#!/bin/bash

# Database connection details
DB_USER="your_username"
DB_PASSWORD="your_password"
DB_SID="your_sid"

# Define directories with respective retention periods in days
declare -A FOLDER_RETENTION=(
    ["/path/to/folder1"]=120
    ["/path/to/folder2"]=30
    ["/path/to/folder3"]=50
    ["/path/to/folder4"]=90
    # Add more directories as needed
)

# Function to log messages to the log_msg table
log_message() {
    local folder="$1"
    local status="$2"
    local message="$3"
    
    sqlplus -s "$DB_USER/$DB_PASSWORD@$DB_SID" <<EOF
    INSERT INTO log_msg (folder_name, status, message, timestamp)
    VALUES ('$folder', '$status', '$message', SYSDATE);
    COMMIT;
EOF
}

# Loop through each directory and delete .log files older than specified retention period
for folder in "${!FOLDER_RETENTION[@]}"; do
    retention_days=${FOLDER_RETENTION[$folder]}
    echo "Cleaning up $folder, deleting .log files older than $retention_days days"

    # Try cleaning up files and check if it was successful
    if find "$folder" -type f -name "*.log" -mtime +"$retention_days" -exec rm -f {} \;; then
        echo "Cleanup completed for $folder"
        log_message "$folder" "SUCCESS" "Cleanup completed successfully for $folder with retention $retention_days days."
    else
        echo "Cleanup failed for $folder"
        log_message "$folder" "FAILURE" "Cleanup failed for $folder with retention $retention_days days."
    fi
done

echo "All specified folders have been cleaned up."

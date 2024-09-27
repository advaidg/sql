#!/bin/bash

# Set Oracle environment variables
export ORACLE_SID=your_oracle_sid
export ORACLE_HOME=/path/to/oracle_home
export PATH=$PATH:$ORACLE_HOME/bin

# Get the current hour (24-hour format)
current_hour=$(date +"%H")

# Check if the current time is between 3 PM (15:00) and 11 PM (23:00)
if [ "$current_hour" -ge 15 ] && [ "$current_hour" -le 23 ]; then
    echo "Current time is between 3 PM and 11 PM. Running the SQL query..."
    
    # Run the Oracle SQL*Plus query and capture the count output
    count=$(sqlplus -s username/password@your_db <<EOF
    set heading off
    set feedback off
    SELECT COUNT(*) FROM your_table WHERE your_condition;
    exit;
EOF
)

    # Trim any leading/trailing whitespaces from the count
    count=$(echo $count | xargs)

    # Check if the count is greater than 0
    if [ "$count" -gt 0 ]; then
        variable=""
        echo "Query returned a non-zero count: $count. Variable updated ."
    else
        echo "Query returned a count of 0. No update needed."
    fi
else
    echo "Current time is outside the 3 PM to 11 PM window. Skipping SQL query."
fi

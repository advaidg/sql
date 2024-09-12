SELECT
    s.sid,
    s.serial#,
    s.username,
    s.status,
    q.sql_text,
    q.sql_id,
    s.event,
    s.wait_time
FROM
    v$session s
JOIN
    v$sql q
ON
    s.sql_id = q.sql_id
WHERE
    s.sid = <session_id>;

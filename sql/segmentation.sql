-- High-risk segment identification

SELECT
    category,
    priority,
    COUNT(*) AS total_cases,
    AVG(resolution_time_hours) AS avg_resolution_time,
    ROUND(
        100.0 * SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS breach_rate_pct
FROM ops.fact_incidents
GROUP BY category, priority
HAVING COUNT(*) > 50
ORDER BY breach_rate_pct DESC;

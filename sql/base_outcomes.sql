-- Base outcome metrics used for driver analysis

SELECT
    region,
    team,
    category,
    priority,
    DATE_PART('hour', created_at) AS hour_of_day,
    COUNT(*) AS total_cases,
    AVG(resolution_time_hours) AS avg_resolution_time,
    SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END) AS breached_cases,
    ROUND(
        100.0 * SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS breach_rate_pct
FROM ops.fact_incidents
GROUP BY
    region, team, category, priority, hour_of_day;

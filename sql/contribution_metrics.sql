-- Contribution of each region to total SLA breaches

WITH overall AS (
    SELECT
        SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END) AS total_breaches
    FROM ops.fact_incidents
)

SELECT
    region,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END) AS breached_cases,
    ROUND(
        100.0 * SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END)
        / (SELECT total_breaches FROM overall),
        2
    ) AS contribution_to_breaches_pct,
    ROUND(
        100.0 * SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS breach_rate_pct
FROM ops.fact_incidents
GROUP BY region
ORDER BY contribution_to_breaches_pct DESC;

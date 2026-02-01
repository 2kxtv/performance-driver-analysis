-- Simulate improvement impact

WITH baseline AS (
    SELECT
        SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END) AS total_breaches
    FROM ops.fact_incidents
),
target_region AS (
    SELECT
        SUM(CASE WHEN sla_breached = 1 THEN 1 ELSE 0 END) AS region_breaches
    FROM ops.fact_incidents
    WHERE region = 'Region B'
)

SELECT
    baseline.total_breaches AS current_breaches,
    ROUND(target_region.region_breaches * 0.10) AS reduced_breaches,
    baseline.total_breaches - ROUND(target_region.region_breaches * 0.10)
        AS new_total_breaches
FROM baseline, target_region;


WITH ordered_distances AS (
    SELECT trip_distance
    FROM taxi_trips
    WHERE strftime('%Y-%m', tpep_pickup_datetime) = '2024-01'
    UNION ALL
    SELECT trip_miles AS trip_distance
    FROM uber_trips
    WHERE strftime('%Y-%m', pickup_datetime) = '2024-01'
),
ranked_distances AS (
    SELECT 
        trip_distance,
        ROW_NUMBER() OVER (ORDER BY trip_distance) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM ordered_distances
)
SELECT 
    trip_distance AS distance_95_percentile
FROM ranked_distances
WHERE row_num = CAST(0.95 * total_rows AS INTEGER);

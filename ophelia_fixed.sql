
WITH all_hired_rides_hourly AS (
    SELECT 
        STRFTIME('%Y-%m-%d %H:00:00', tpep_pickup_datetime) AS hour,
        COUNT(*) AS total_rides
    FROM taxi_trips
    WHERE DATE(tpep_pickup_datetime) BETWEEN '2023-09-25' AND '2023-10-03'
    GROUP BY hour

    UNION ALL

    SELECT 
        STRFTIME('%Y-%m-%d %H:00:00', pickup_datetime) AS hour,
        COUNT(*) AS total_rides
    FROM uber_trips
    WHERE DATE(pickup_datetime) BETWEEN '2023-09-25' AND '2023-10-03'
    GROUP BY hour
),
weather_hourly AS (
    SELECT 
        STRFTIME('%Y-%m-%d %H:00:00', date) AS hour,
        SUM(precipitation_hourly) AS total_precipitation,
        AVG(wind_speed_hourly) AS avg_wind_speed
    FROM hourly_weather
    WHERE DATE(date) BETWEEN '2023-09-25' AND '2023-10-03'
    GROUP BY hour
),
all_hours AS (
    SELECT DISTINCT
        STRFTIME('%Y-%m-%d %H:00:00', date) AS hour
    FROM hourly_weather
    WHERE DATE(date) BETWEEN '2023-09-25' AND '2023-10-03'
    UNION
    SELECT DISTINCT
        STRFTIME('%Y-%m-%d %H:00:00', tpep_pickup_datetime) AS hour
    FROM taxi_trips
    WHERE DATE(tpep_pickup_datetime) BETWEEN '2023-09-25' AND '2023-10-03'
    UNION
    SELECT DISTINCT
        STRFTIME('%Y-%m-%d %H:00:00', pickup_datetime) AS hour
    FROM uber_trips
    WHERE DATE(pickup_datetime) BETWEEN '2023-09-25' AND '2023-10-03'
)
SELECT 
    h.hour,
    COALESCE(r.total_rides, 0) AS total_rides,
    COALESCE(w.total_precipitation, 0.0) AS total_precipitation,
    COALESCE(w.avg_wind_speed, 0.0) AS avg_wind_speed
FROM all_hours h
LEFT JOIN all_hired_rides_hourly r ON h.hour = r.hour
LEFT JOIN weather_hourly w ON h.hour = w.hour
WHERE DATE(h.hour) BETWEEN '2023-09-25' AND '2023-10-03'  -- Restrict to exact range
ORDER BY h.hour ASC;

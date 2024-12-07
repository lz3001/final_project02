WITH all_rides_2023 AS (
    SELECT 
        DATE(tpep_pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_distance) AS avg_distance
    FROM taxi_trips
    WHERE DATE(tpep_pickup_datetime) BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY ride_date

    UNION ALL

    SELECT 
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides,
        AVG(trip_miles) AS avg_distance
    FROM uber_trips
    WHERE DATE(pickup_datetime) BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY ride_date
),
weather_aggregates AS (
    SELECT 
        DATE(date) AS weather_date,
        AVG(precipitation_daily) AS avg_precipitation,
        AVG(wind_speed_daily) AS avg_wind_speed
    FROM daily_weather
    WHERE DATE(date) BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY weather_date
)
SELECT 
    a.ride_date AS date,
    SUM(a.total_rides) AS total_rides,
    AVG(a.avg_distance) AS avg_distance,
    w.avg_precipitation,
    w.avg_wind_speed
FROM all_rides_2023 a
LEFT JOIN weather_aggregates w
    ON a.ride_date = w.weather_date
GROUP BY a.ride_date
ORDER BY total_rides DESC
LIMIT 10;

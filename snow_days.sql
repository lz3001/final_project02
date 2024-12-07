
WITH all_hired_rides AS (
    SELECT 
        DATE(tpep_pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides
    FROM taxi_trips
    WHERE DATE(tpep_pickup_datetime) BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY ride_date

    UNION ALL

    SELECT 
        DATE(pickup_datetime) AS ride_date,
        COUNT(*) AS total_rides
    FROM uber_trips
    WHERE DATE(pickup_datetime) BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY ride_date
),
daily_snowfall AS (
    SELECT 
        DATE(date) AS snow_date,
        SUM(snowfall) AS total_snowfall
    FROM daily_weather
    WHERE snowfall > 0 AND DATE(date) BETWEEN '2020-01-01' AND '2024-08-31'
    GROUP BY snow_date
)
SELECT 
    s.snow_date AS date,
    s.total_snowfall,
    COALESCE(SUM(r.total_rides), 0) AS total_rides
FROM daily_snowfall s
LEFT JOIN all_hired_rides r
    ON s.snow_date = r.ride_date
GROUP BY s.snow_date, s.total_snowfall
ORDER BY s.total_snowfall DESC
LIMIT 10;

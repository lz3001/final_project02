
SELECT 
    strftime('%w', pickup_datetime) AS day_of_week,
    CASE strftime('%w', pickup_datetime)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_name,
    COUNT(*) AS ride_count
FROM 
    uber_trips
GROUP BY 
    day_of_week
ORDER BY 
    ride_count DESC


CREATE TABLE hourly_weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT,
    latitude REAL,
    longitude REAL,
    precipitation_hourly REAL,
    wind_speed_hourly REAL
);

CREATE TABLE daily_weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT,
    latitude REAL,
    longitude REAL,
    precipitation_daily REAL,
    snowfall REAL,
    wind_speed_daily REAL
);

CREATE TABLE taxi_trips (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pickup_datetime TEXT,
    dropoff_datetime TEXT,
    latitude_pickup REAL,
    longitude_pickup REAL,
    latitude_dropoff REAL,
    longitude_dropoff REAL,
    fare_amount REAL,
    trip_distance REAL,
    total_amount REAL,
    tip_amount REAL
);

CREATE TABLE uber_trips (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pickup_datetime TEXT,
    dropoff_datetime TEXT,
    latitude_pickup REAL,
    longitude_pickup REAL,
    latitude_dropoff REAL,
    longitude_dropoff REAL,
    base_passenger_fare REAL,
    trip_miles REAL,
    tolls REAL,
    tips REAL
);

-- ---------------------------------------------------------------
-- Database Initialization Script
-- ---------------------------------------------------------------
-- This script creates the primary table used for storing raw
-- weather data consumed from Kafka.
--
-- Table: weather_raw
-- Purpose:
-- Stores timestamped weather observations including temperature
-- and precipitation probability.
-- ---------------------------------------------------------------

CREATE TABLE weather_raw (

    -- Unique identifier for each record
    id SERIAL PRIMARY KEY,

    -- Timestamp of the weather observation
    timestamp TIMESTAMP,

    -- Temperature measurement in Celsius
    temperature FLOAT,

    -- Probability of precipitation
    precipitation FLOAT,

    -- Record creation timestamp (auto-generated)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

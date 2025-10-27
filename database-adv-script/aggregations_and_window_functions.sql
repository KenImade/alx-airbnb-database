-- ======================================================
-- Airbnb Aggregations and Window Functions
-- Author: Kenneth Imade
-- Date: 2025-10-27
-- Description: This script retrieves the following data
--  points using queries.
--   1. Find the total number of bookings made by each user.
--   2. Rank properties based on the total number of bookings they have received.
-- ======================================================

-- Find the total number of bookings made by each user.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS number_of_bookings
FROM User u
LEFT JOIN Booking b 
ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY number_of_bookings DESC;

-- Rank properties based on the total number of bookings they have received.
SELECT
    property_id,
    host_id,
    name,
    number_of_bookings,
    RANK() OVER (ORDER BY number_of_bookings DESC) AS rank,
    ROW_NUMBER() OVER (ORDER BY number_of_bookings DESC) AS row_number
FROM (
    SELECT
        p.property_id,
        p.host_id,
        p.name,
        COUNT(b.booking_id) AS number_of_bookings
    FROM Property p
    LEFT JOIN Booking b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.host_id, p.name
) AS property_bookings
ORDER BY number_of_bookings DESC;
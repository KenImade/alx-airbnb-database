-- ======================================================
-- Airbnb SubQueries
-- Author: Kenneth Imade
-- Date: 2025-10-27
-- Description: This script retrieves the following data
--  points using queries.
--   1. All properties where the average rating is greater than 4.0.
--   2. Users who have made more than 3 bookings.
-- ======================================================


-- All properties where the average rating is greater than 4.0
SELECT
    r.property_id,
    AVG(r.rating) as average_rating
FROM Review r
WHERE r.property_id IN (SELECT property_id FROM Property)
GROUP BY r.property_id
HAVING AVG(r.rating) > 4
ORDER BY average_rating DESC;

-- Users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number
FROM User u
WHERE (
    SELECT
        COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;
-- ======================================================
-- Airbnb Complex Join Queries
-- Author: Kenneth Imade
-- Date: 2025-10-27
-- Description: This script retrieves the following data
--  points using queries.
--   1. All bookings and the respective users who made those bookings.
--   2. All properties and their reviews, including properties that have no reviews.
--   3. All users and all bookings, even if the user has no booking or a booking is not
--      linked to a user.
-- ======================================================

-- All booking and the respective users who made those bookings.

SELECT
    u.user_id AS user_id,
    u.first_name AS first_name,
    u.last_name AS last_name,
    u.email AS email,
    u.phone_number AS phone_number,
    b.booking_id AS booking_id,
    b.start_date AS start_date,
    b.end_date AS end_date,
    b.total_price AS total_price,
    b.status AS status,
    b.created_at AS booking_creation_date
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id;

-- All properties and their reviewss

SELECT
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    r.rating,
    r.comment,
    r.created_at
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
ORDER BY property_name;


-- All users and all bookings

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM User u
FULL OUTER JOIN Booking b
ON u.user_id = b.user_id;
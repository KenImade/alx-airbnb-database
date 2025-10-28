-- ======================================================
-- Airbnb Indexes
-- Author: Kenneth Imade
-- Date: 2025-10-27
-- Description: Query Optimization
-- ======================================================

-- ===========================================
-- STEP 1: Initial Query
-- Retrieve all bookings with user, property, and payment details
-- ===========================================

SELECT
    b.booking_id,
    b.status,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pmt.payment_id,
    pmt.payment_date,
    pmt.amount,
    pmt.payment_method
FROM Booking b
LEFT JOIN "User" u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pmt ON b.booking_id = pmt.booking_id;

-- ===========================================
-- STEP 2: Analyze Performance
-- Use EXPLAIN ANALYZE to view the execution plan
-- ===========================================
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.status,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pmt.payment_id,
    pmt.payment_date,
    pmt.amount,
    pmt.payment_method
FROM Booking b
LEFT JOIN "User" u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pmt ON b.booking_id = pmt.booking_id;

-- Observation:
-- Initial plan uses Nested Loop Left Joins.
-- This is fine for small tables, but can be slow for larger datasets.

-- ===========================================
-- STEP 3: Refactor for Performance
-- ===========================================

-- Use Hash Joins instead of Nested Loops
-- (Let the planner choose hash joins by using explicit INNER JOINs
-- and applying filters early if possible.)

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.status,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pmt.payment_date,
    pmt.amount
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pmt ON b.booking_id = pmt.booking_id
WHERE b.status = 'confirmed'
WHERE b.status = 'confirmed'
  AND p.location IS NOT NULL;

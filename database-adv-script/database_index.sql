-- ======================================================
-- Airbnb Indexes
-- Author: Kenneth Imade
-- Date: 2025-10-27
-- Description: This script creates indexes to improve query performance.
-- ======================================================

-- Indexes
CREATE INDEX idx_user_role ON "User" (role);
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_end_date ON Booking(end_date);
CREATE INDEX idx_property_location ON Property(location);

-- Test Queries
-- 1. Find all bookings for a specific guest with property details
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    p.name as property_name,
    p.location,
    u.first_name || ' ' || u.last_name as host_name
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN "User" u ON p.host_id = u.user_id
WHERE b.user_id = (SELECT user_id FROM "User" WHERE email = 'alice@example.com')
ORDER BY b.start_date DESC;

-- 2. Calculate total revenue per host
EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.first_name || ' ' || u.last_name as host_name,
    COUNT(DISTINCT p.property_id) as total_properties,
    COUNT(b.booking_id) as total_bookings,
    COALESCE(SUM(pay.amount), 0) as total_revenue
FROM "User" u
JOIN Property p ON u.user_id = p.host_id
LEFT JOIN Booking b ON p.property_id = b.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE u.role = 'host'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_revenue DESC;

-- 3. Find properties with no bookings (available properties)
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    u.first_name || ' ' || u.last_name as host_name
FROM Property p
JOIN "User" u ON p.host_id = u.user_id
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE b.booking_id IS NULL
ORDER BY p.pricepernight;

-- 4. Get properties with their average rating and review count
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    COUNT(r.review_id) as review_count,
    ROUND(AVG(r.rating), 2) as average_rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location, p.pricepernight
HAVING COUNT(r.review_id) > 0
ORDER BY average_rating DESC, review_count DESC;

-- 5. Find upcoming bookings with payment status
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    p.name as property_name,
    u.first_name || ' ' || u.last_name as guest_name,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status as booking_status,
    COALESCE(SUM(pay.amount), 0) as amount_paid,
    b.total_price - COALESCE(SUM(pay.amount), 0) as amount_due
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN "User" u ON b.user_id = u.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date > CURRENT_DATE
GROUP BY b.booking_id, p.name, u.first_name, u.last_name, b.start_date, 
         b.end_date, b.total_price, b.status
ORDER BY b.start_date;

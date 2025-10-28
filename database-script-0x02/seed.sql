-- ======================================================
-- Airbnb Database Seed Script
-- Author: Kenneth Imade
-- Date: 2025-10-23
-- Updated: 2025-10-27
-- Description: Inserts sample test data into the AirBnB database schema.
-- ======================================================

-- Ensure required extensions are enabled (for UUID generation)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ======================================================
-- Clear existing data (to avoid duplication)
-- ======================================================
TRUNCATE TABLE Payment, Review, Booking, Message, Property, "User" RESTART IDENTITY CASCADE;

-- ======================================================
-- Users
-- ======================================================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
SELECT
    gen_random_uuid(),
    md5(random()::text) || '_fname', -- random first name
    md5(random()::text) || '_lname', -- random last name
    md5(random()::text) || '@example.com', -- email
    md5(random()::text), -- password_hash
    '+1' || (floor(random()*9000000000)+1000000000)::TEXT, -- phone_number
    (ARRAY['guest','host','admin'])[floor(random()*3)+1]::role -- role
FROM generate_series(1, 1000) s;

-- ======================================================
-- Properties
-- ======================================================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
SELECT
    gen_random_uuid(),
    (SELECT user_id FROM "User" ORDER BY random() LIMIT 1), -- random host
    'Property ' || s, -- name
    'Description for property ' || s, -- description
    (ARRAY['New York','London','Paris','Tokyo','Berlin'])[floor(random()*5)+1], -- location
    ROUND((random() * 500 + 50)::numeric, 2) -- pricepernight
FROM generate_series(1, 500) s; 

-- ======================================================
-- Bookings
-- ======================================================
INSERT INTO Booking (booking_id, user_id, property_id, status, start_date, end_date, total_price)
SELECT
    gen_random_uuid(),                                        -- booking_id
    (SELECT user_id FROM "User" ORDER BY random() LIMIT 1),  -- user_id
    (SELECT property_id FROM Property ORDER BY random() LIMIT 1), -- property_id (must exist!)
    (ARRAY['confirmed','pending','canceled'])[floor(random()*3)+1]::status,
    date '2024-01-01' + (random()*365)::INT,                -- start_date
    date '2024-01-01' + (random()*365)::INT + 3,            -- end_date
    ROUND((random()*500 + 50)::numeric, 2)                  -- total_price
FROM generate_series(1, 1000) s;                            -- number of bookings


-- ======================================================
-- Payments
-- ======================================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
SELECT
    gen_random_uuid(),
    (SELECT booking_id FROM Booking ORDER BY random() LIMIT 1), -- random booking
    ROUND((random() * 500 + 50)::numeric, 2), -- amount
    (ARRAY['credit_card','paypal','stripe'])[floor(random()*3)+1]::payment_method -- payment_method
FROM generate_series(1, 1000) s;

-- ======================================================
-- Reviews
-- ======================================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
SELECT
    gen_random_uuid(),
    (SELECT property_id FROM Property ORDER BY random() LIMIT 1), -- random property
    (SELECT user_id FROM "User" ORDER BY random() LIMIT 1), -- random user
    floor(random()*5 + 1)::INT, -- rating 1-5
    'Review comment ' || s -- comment
FROM generate_series(1, 1500) s;

-- ======================================================
-- Messages
-- ======================================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
SELECT
    gen_random_uuid(),
    (SELECT user_id FROM "User" ORDER BY random() LIMIT 1), -- random sender
    (SELECT user_id FROM "User" ORDER BY random() LIMIT 1), -- random recipient
    'Message content ' || s -- message_body
FROM generate_series(1, 2000) s;
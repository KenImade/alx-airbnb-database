-- ======================================================
-- Airbnb Database Seed Script
-- Author: Kenneth Imade
-- Date: 2025-10-23
-- Description: Inserts sample test data into the AirBnB database schema.
-- ======================================================

-- Ensure required extensions are enabled (for UUID generation)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ======================================================
-- Clear existing data (to avoid duplication)
-- ======================================================
TRUNCATE TABLE Payment, Review, Booking, Message, Property, "User" RESTART IDENTITY CASCADE;

-- ======================================================
-- Users
-- ======================================================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (uuid_generate_v4(), 'Alice', 'Walker', 'alice@example.com', 'hashed_pw_1', '555-1010', 'guest'),
    (uuid_generate_v4(), 'Bob', 'Smith', 'bob@example.com', 'hashed_pw_2', '555-2020', 'host'),
    (uuid_generate_v4(), 'Charlie', 'Johnson', 'charlie@example.com', 'hashed_pw_3', '555-3030', 'guest'),
    (uuid_generate_v4(), 'Diana', 'Martinez', 'diana@example.com', 'hashed_pw_4', '555-4040', 'host'),
    (uuid_generate_v4(), 'Eve', 'Miller', 'eve@example.com', 'hashed_pw_5', '555-5050', 'admin');

-- Capture host and guest IDs for later reference
-- (Assuming this runs in psql or similar tool)
\set host1 (SELECT user_id FROM "User" WHERE email = 'bob@example.com')
\set host2 (SELECT user_id FROM "User" WHERE email = 'diana@example.com')
\set guest1 (SELECT user_id FROM "User" WHERE email = 'alice@example.com')
\set guest2 (SELECT user_id FROM "User" WHERE email = 'charlie@example.com')

-- ======================================================
-- Properties
-- ======================================================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
        'Cozy Mountain Cabin', 'A beautiful cabin in the mountains with a hot tub.', 'Aspen, CO', 180.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'diana@example.com'),
        'Beachfront Apartment', 'Modern apartment with stunning sea views.', 'Malibu, CA', 250.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
        'City Loft', 'Chic loft in downtown New York City.', 'New York, NY', 320.00);

-- ======================================================
-- Bookings
-- ======================================================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Cozy Mountain Cabin'),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        '2025-11-10', '2025-11-15', 900.00, 'confirmed'),

    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Beachfront Apartment'),
        (SELECT user_id FROM "User" WHERE email = 'charlie@example.com'),
        '2025-12-01', '2025-12-05', 1000.00, 'pending'),

    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'City Loft'),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        '2025-12-20', '2025-12-23', 960.00, 'confirmed');

-- ======================================================
-- Payments
-- ======================================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 900.00),
        900.00, 'credit_card'),

    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 960.00),
        960.00, 'paypal');

-- ======================================================
-- Reviews
-- ======================================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Cozy Mountain Cabin'),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        5, 'Absolutely loved it! The view and hot tub were perfect.'),

    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'City Loft'),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        4, 'Stylish place but a bit noisy at night.');

-- ======================================================
-- Messages
-- ======================================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
        'Hi Bob, I loved staying at your cabin! Thanks again.'),
        
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        'You’re welcome, Alice! Glad you enjoyed your stay.');

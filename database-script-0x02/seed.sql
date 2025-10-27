-- ======================================================
-- Airbnb Database Seed Script
-- Author: Kenneth Imade
-- Date: 2025-10-23
-- Updated: 2025-10-27
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
    (uuid_generate_v4(), 'Eve', 'Miller', 'eve@example.com', 'hashed_pw_5', '555-5050', 'admin'),
    (uuid_generate_v4(), 'Frank', 'Davis', 'frank@example.com', 'hashed_pw_6', '555-6060', 'host'),
    (uuid_generate_v4(), 'Grace', 'Wilson', 'grace@example.com', 'hashed_pw_7', '555-7070', 'guest'),
    (uuid_generate_v4(), 'Henry', 'Brown', 'henry@example.com', 'hashed_pw_8', '555-8080', 'host'),
    (uuid_generate_v4(), 'Iris', 'Taylor', 'iris@example.com', 'hashed_pw_9', '555-9090', 'guest'),
    (uuid_generate_v4(), 'Jack', 'Anderson', 'jack@example.com', 'hashed_pw_10', '555-1111', 'guest'),
    (uuid_generate_v4(), 'Karen', 'Thomas', 'karen@example.com', 'hashed_pw_11', '555-2222', 'host'),
    (uuid_generate_v4(), 'Leo', 'Jackson', 'leo@example.com', 'hashed_pw_12', '555-3333', 'guest'),
    (uuid_generate_v4(), 'Mia', 'White', 'mia@example.com', 'hashed_pw_13', '555-4444', 'host'),
    (uuid_generate_v4(), 'Noah', 'Harris', 'noah@example.com', 'hashed_pw_14', '555-5555', 'guest'),
    (uuid_generate_v4(), 'Olivia', 'Martin', 'olivia@example.com', 'hashed_pw_15', '555-6666', 'admin');

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
        'City Loft', 'Chic loft in downtown New York City.', 'New York, NY', 320.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'frank@example.com'),
        'Lakeside Cottage', 'Peaceful cottage with private dock and fishing access.', 'Lake Tahoe, NV', 195.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'henry@example.com'),
        'Desert Oasis Villa', 'Luxurious villa with pool in the Arizona desert.', 'Scottsdale, AZ', 420.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'karen@example.com'),
        'Historic Townhouse', 'Charming townhouse in historic Boston neighborhood.', 'Boston, MA', 275.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'mia@example.com'),
        'Mountain View Chalet', 'Stunning alpine chalet with ski-in/ski-out access.', 'Park City, UT', 380.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'diana@example.com'),
        'Garden Studio', 'Cozy studio apartment with private garden space.', 'Portland, OR', 145.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'frank@example.com'),
        'Penthouse Suite', 'Luxury penthouse with panoramic city views.', 'Chicago, IL', 500.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
        'Rustic Farmhouse', 'Spacious farmhouse on 5 acres with horses.', 'Austin, TX', 210.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'henry@example.com'),
        'Coastal Bungalow', 'Cute bungalow steps from the beach.', 'Cape Cod, MA', 225.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'karen@example.com'),
        'Wine Country Estate', 'Elegant estate surrounded by vineyards.', 'Napa Valley, CA', 650.00),
    (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email = 'mia@example.com'),
        'Urban Studio', 'Modern studio in trendy neighborhood with rooftop access.', 'Seattle, WA', 165.00);

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
        '2025-12-20', '2025-12-23', 960.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Lakeside Cottage'),
        (SELECT user_id FROM "User" WHERE email = 'grace@example.com'),
        '2025-11-05', '2025-11-08', 585.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Desert Oasis Villa'),
        (SELECT user_id FROM "User" WHERE email = 'iris@example.com'),
        '2025-11-15', '2025-11-18', 1260.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Historic Townhouse'),
        (SELECT user_id FROM "User" WHERE email = 'jack@example.com'),
        '2025-12-10', '2025-12-14', 1100.00, 'pending'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Mountain View Chalet'),
        (SELECT user_id FROM "User" WHERE email = 'leo@example.com'),
        '2026-01-02', '2026-01-09', 2660.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Garden Studio'),
        (SELECT user_id FROM "User" WHERE email = 'noah@example.com'),
        '2025-11-20', '2025-11-25', 725.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Penthouse Suite'),
        (SELECT user_id FROM "User" WHERE email = 'charlie@example.com'),
        '2025-12-15', '2025-12-17', 1000.00, 'canceled'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Rustic Farmhouse'),
        (SELECT user_id FROM "User" WHERE email = 'grace@example.com'),
        '2026-02-01', '2026-02-06', 1050.00, 'pending'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Coastal Bungalow'),
        (SELECT user_id FROM "User" WHERE email = 'iris@example.com'),
        '2025-11-28', '2025-12-02', 900.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Wine Country Estate'),
        (SELECT user_id FROM "User" WHERE email = 'jack@example.com'),
        '2026-03-10', '2026-03-13', 1950.00, 'confirmed'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Urban Studio'),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        '2025-12-05', '2025-12-08', 495.00, 'confirmed');

-- ======================================================
-- Payments
-- ======================================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 900.00 AND start_date = '2025-11-10'),
        900.00, 'credit_card'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 960.00),
        960.00, 'paypal'),
    -- New payments
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 585.00),
        585.00, 'credit_card'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 1260.00),
        1260.00, 'stripe'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 2660.00),
        2660.00, 'credit_card'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 725.00),
        725.00, 'paypal'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 900.00 AND start_date = '2025-11-28'),
        900.00, 'stripe'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 1950.00),
        1950.00, 'credit_card'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 495.00),
        495.00, 'paypal'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 1100.00),
        550.00, 'credit_card'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 1050.00),
        525.00, 'stripe'),
    (uuid_generate_v4(),
        (SELECT booking_id FROM Booking WHERE total_price = 1000.00 AND start_date = '2025-12-15'),
        500.00, 'credit_card');

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
        4, 'Stylish place but a bit noisy at night.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Lakeside Cottage'),
        (SELECT user_id FROM "User" WHERE email = 'grace@example.com'),
        5, 'Perfect getaway! The lake views were breathtaking.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Desert Oasis Villa'),
        (SELECT user_id FROM "User" WHERE email = 'iris@example.com'),
        5, 'Luxurious property with amazing amenities. Highly recommend!'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Mountain View Chalet'),
        (SELECT user_id FROM "User" WHERE email = 'leo@example.com'),
        4, 'Great location for skiing. Property was clean and well-maintained.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Garden Studio'),
        (SELECT user_id FROM "User" WHERE email = 'noah@example.com'),
        5, 'Cozy and charming. The garden was a lovely touch.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Beachfront Apartment'),
        (SELECT user_id FROM "User" WHERE email = 'charlie@example.com'),
        3, 'Nice views but property needs some updating.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Coastal Bungalow'),
        (SELECT user_id FROM "User" WHERE email = 'iris@example.com'),
        5, 'Amazing location right on the beach. Perfect vacation spot!'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Wine Country Estate'),
        (SELECT user_id FROM "User" WHERE email = 'jack@example.com'),
        5, 'Stunning property surrounded by vineyards. A dream come true!'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Urban Studio'),
        (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
        4, 'Great location and rooftop access was a bonus. A bit small though.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Historic Townhouse'),
        (SELECT user_id FROM "User" WHERE email = 'jack@example.com'),
        4, 'Beautiful historic charm with modern conveniences.'),
    (uuid_generate_v4(),
        (SELECT property_id FROM Property WHERE name = 'Rustic Farmhouse'),
        (SELECT user_id FROM "User" WHERE email = 'grace@example.com'),
        5, 'Loved the rural setting and the horses were a delight!');

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
        'You''re welcome, Alice! Glad you enjoyed your stay.'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'grace@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'frank@example.com'),
        'Hi Frank, what time is check-in at the Lakeside Cottage?'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'frank@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'grace@example.com'),
        'Check-in is at 3 PM. Looking forward to hosting you!'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'iris@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'henry@example.com'),
        'Is there parking available at the Desert Oasis Villa?'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'henry@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'iris@example.com'),
        'Yes, there is a private garage with space for two cars.'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'jack@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'karen@example.com'),
        'Are pets allowed at the Historic Townhouse?'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'karen@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'jack@example.com'),
        'Sorry, no pets are allowed at this property.'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'leo@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'mia@example.com'),
        'The chalet was amazing! Thank you for the ski pass recommendation.'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'mia@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'leo@example.com'),
        'So glad you enjoyed it! Hope to host you again soon.'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'charlie@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'diana@example.com'),
        'I need to cancel my booking at the Beachfront Apartment. Can you help?'),
    (uuid_generate_v4(),
        (SELECT user_id FROM "User" WHERE email = 'noah@example.com'),
        (SELECT user_id FROM "User" WHERE email = 'diana@example.com'),
        'Thank you for the lovely stay at the Garden Studio!');
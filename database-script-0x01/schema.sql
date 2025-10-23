/* 
This script creates the tables required for the AirBnB project.
It follows 3NF principles and uses enums for controlled categorical data.
*/


-- Enums

CREATE TYPE role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method AS ENUM ('credit_card', 'paypal', 'stripe');

-- Tables

CREATE TABLE IF NOT EXISTS "User" (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR(50),
    role role NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS Property (
    property_id UUID PRIMARY KEY,
    host_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    recipient_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status status NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS Review (
    review_id UUID PRIMARY KEY,
    property_id UUID REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID REFERENCES Booking(booking_id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT NOW(),
    payment_method payment_method NOT NULL
);

-- Indexes
CREATE INDEX idx_user_email ON "User" (email);
CREATE INDEX idx_booking_property_id ON Booking (property_id);
CREATE INDEX idx_payment_booking_id ON Payment (booking_id);
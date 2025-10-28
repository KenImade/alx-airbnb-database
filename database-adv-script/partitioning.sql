-- ======================================================
-- Airbnb Table Partitions
-- Author: Kenneth Imade
-- Date: 2025-10-27
-- Description: Table Partitions
-- ======================================================

-- Drop Table
DROP TABLE IF EXISTS Booking CASCADE;

-- Create Table with Partitions
CREATE TABLE Booking (
    booking_id UUID NOT NULL,
    property_id UUID REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status status NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (booking_id, start_date)
)
PARTITION BY RANGE (start_date);

-- Create partitions by year
CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE Booking_future PARTITION OF Booking
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

-- Insert Values
INSERT INTO Booking (booking_id, user_id, property_id, status, start_date, end_date, total_price)
SELECT
    gen_random_uuid(),                                        -- booking_id
    (SELECT user_id FROM "User" ORDER BY random() LIMIT 1),  -- user_id
    (SELECT property_id FROM Property ORDER BY random() LIMIT 1), -- property_id (must exist!)
    (ARRAY['confirmed','pending','canceled'])[floor(random()*3)+1]::status,
    date '2024-01-01' + (random()*365)::INT,                -- start_date
    date '2024-01-01' + (random()*365)::INT + 3,            -- end_date
    ROUND((random()*500 + 50)::numeric, 2)                  -- total_price
FROM generate_series(1, 1000) s;


-- Create Indexes
CREATE INDEX idx_booking_property_id ON Booking (property_id);
CREATE INDEX idx_booking_2023_status ON Booking_2023 (status);
CREATE INDEX idx_booking_2024_status ON Booking_2024 (status);
CREATE INDEX idx_booking_2025_status ON Booking_2025 (status);
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_end_date ON Booking(end_date);

-- ======================================================
-- Test Performance Query
-- ======================================================
EXPLAIN ANALYZE
SELECT booking_id, user_id, property_id, start_date, status
FROM Booking
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30'
  AND status = 'confirmed';
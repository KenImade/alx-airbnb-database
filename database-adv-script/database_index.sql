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

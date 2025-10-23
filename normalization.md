# Normalization Process

The database schema was designed to adhere to the **Third Normal Form (3NF)** standard.

### 1. First Normal Form (1NF)

- Each table represents a single entity (e.g., User, Property, Booking, etc.).
- All attributes are atomic i.e. no repeating groups or multi-valued fields.
- Each record is uniquely identified by a primary key.

### 2. Second Normal Form (2NF)

- All non-key attributes depend on the entire primary key.
- No partial dependencies exist since each table has a single-column primary key (e.g., `user_id`, `booking_id`).

### 3. Third Normal Form (3NF)

- No transitive dependencies are present i.e. non-key attributes depend only on the primary key.
- Related but independent data (like roles, payment methods, and statuses) are stored in separate lookup tables.
- Enum-like values are handled through dedicated tables (e.g., `Role`, `Status`, `PaymentMethod`) instead of inline text fields.

### Summary

- Each entity has its own table with unique characteristics.
- Redundancy is minimized by linking tables through foreign keys.
- Data integrity and scalability are improved by eliminating derived and transitive dependencies.

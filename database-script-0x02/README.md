# AirBnB Database Seed Script

This repository contains an SQL seed script (`seed.sql`) designed to populate the AirBnB database with realistic test data. It supports development, testing, and demonstration of the database schema.

---

## Prerequisites

Before running the seed script, ensure that:

1. PostgreSQL is installed and running.
2. The AirBnB schema (`schema.sql`) has already been executed.
3. You have access to a database (e.g., `airbnb_db`).
4. The `uuid-ossp` extension is enabled (the script will enable it automatically if not).

---

## Usage Instructions

### 1. Connect to PostgreSQL

```bash
psql -U your_username -d airbnb_db
```

### 2. Run the Schema Script

```bash
\i path/to/schema.sql
```

### 3. Run the Seed Script

```bash
\i path/to/seed.sql
```

---

##  What the Seed Script Does

The script:

- Clears existing data (TRUNCATE … CASCADE) to prevent duplicates.

- Inserts:

  - 5 users (guests, hosts, admin)

  - 3 properties

  - 3 bookings

  - 2 payments

  - 2 reviews

  - 2 messages

All data uses valid foreign key relationships and realistic timestamps.

---

##  Notes

- UUIDs are auto-generated via uuid_generate_v4().
- Enum values match the schema: role, status, and payment_method.
- The seed data is designed to demonstrate all entity relationships.

## Resetting Data

To clear all test data:

```sql
TRUNCATE TABLE Payment, Review, Booking, Message, Property, "User" RESTART IDENTITY CASCADE;
```

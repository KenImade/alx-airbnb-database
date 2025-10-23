# Airbnb Database Schema

## Overview

This SQL script defines the relational database schema for the Airbnb Clone Project.
It creates all necessary tables, relationships, constraints, and enumerated data types required to manage users, properties, bookings, reviews, messages, and payments.

The schema adheres to Third Normal Form (3NF) to ensure data consistency, eliminate redundancy, and improve query efficiency.

---

##  Design Goals

- Maintain clear separation of entities (User, Property, Booking, etc.)
- Enforce data integrity through primary/foreign key constraints
- Use enums for controlled categorical data (roles, booking status, payment methods)
- Support scalability and data consistency through normalization

---

## Entities and Relationships

| Entity | Description |
|---------|--------------|
| **User** | Stores user information such as name, email, role, and contact details. |
| **Property** | Represents a property listed by a host. Linked to the User table through `host_id`. |
| **Booking** | Contains details about reservations, including dates, price, and status. |
| **Review** | Stores feedback and ratings for a property by users. |
| **Message** | Manages communication between users (e.g., guest ↔ host). |
| **Payment** | Tracks payments made for bookings and their payment method. |

### Relationships

- A **User** can host multiple **Properties**
- A **User** can make multiple **Bookings**
- A **Booking** belongs to one **Property** and one **User**
- A **Booking** can have one or more **Payments**
- A **Property** can receive multiple **Reviews**
- Users can **Message** each other

---

## Normalization

This database schema was designed to comply with **Third Normal Form (3NF)**.

### 1. First Normal Form (1NF)

- Each table represents a single entity.
- All fields are atomic (no repeating groups or multivalued attributes).
- Every table has a unique primary key.

### 2. Second Normal Form (2NF)

- All non-key attributes depend on the full primary key.
- Partial dependencies are eliminated (each table has a single-column PK).

### 3. Third Normal Form (3NF)

- No transitive dependencies exist.
- Enum and lookup data (e.g., roles, statuses, payment methods) are isolated from main entities.

---

## Enum Definitions

To maintain consistent categorical data, the following **PostgreSQL enums** are defined:

| Enum Type | Values |
|------------|---------|
| `role` | `'guest'`, `'host'`, `'admin'` |
| `status` | `'pending'`, `'confirmed'`, `'canceled'` |
| `payment_method` | `'credit_card'`, `'paypal'`, `'stripe'` |

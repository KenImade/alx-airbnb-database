# Airbnb Booking Table Partitioning – Performance Report

**Author:** Kenneth Imade  
**Date:** 2025-10-28  

## Objective

The goal was to improve query performance on the `Booking` table by implementing **range-based partitioning** on the `start_date` column, since the table is expected to grow large over time.

---

## Changes Implemented

1. **Partitioned `Booking` table** by `RANGE(start_date)` with yearly partitions:
   - `Booking_2023`
   - `Booking_2024`
   - `Booking_2025`
   - `Booking_future`
2. Adjusted the **primary key** to include `start_date`:  
   `PRIMARY KEY (booking_id, start_date)`  
3. Inserted **sample data** using UUIDs for `booking_id`, `user_id`, `property_id`, ensuring foreign key integrity.
4. Created **indexes** on `start_date`, `end_date`, `status`, and `property_id` on the parent table and partitions.
5. Tested performance using a **date range query** filtered by status:

```sql
SELECT booking_id, user_id, property_id, start_date, status
FROM Booking
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30'
  AND status = 'confirmed';
```

--

## Observations

| Metric                 | Before Partitioning        | After Partitioning                           |
| ---------------------- | -------------------------- | -------------------------------------------- |
| Scanned rows for query | 1,000 (entire table)       | ~82 rows (only relevant partition)           |
| Execution time         | ~120 ms (simulated)        | 0.468 ms                                     |
| Index usage            | Single index scan on table | Bitmap index scan with **partition pruning** |
| Storage / maintenance  | Single large table         | Smaller, per-year partitions                 |

Key Improvements:

- Partition pruning: Queries scan only the relevant yearly partition, reducing I/O and improving execution time.
- Index efficiency: Indexes on partitions make range queries faster.
- Scalability: Future data can be added to new partitions without affecting query performance.
- Data management: Dropping or archiving old partitions is simpler than working with a monolithic table

# SQL Auction System Database

## Overview
A relational database implementation designed to manage users, items, auctions, and payments. The project focuses on schema design, relational integrity, and cross-table querying.

## Key Features
* **Schema Design:** Structured using superclass/subclass hierarchies (`USER`, `BUYER`, `SELLER`) to separate concerns and enforce role-based constraints.
* **Data Integrity:** Implemented `PRIMARY` and `FOREIGN KEY` constraints to ensure consistency across the auction lifecycle.
* **SQL Implementation:** Includes table definitions, constraints, and sample data population for managing the complete transaction flow.
* **Querying:** Demonstrates advanced `JOIN` operations to aggregate data across users, items, and payments.


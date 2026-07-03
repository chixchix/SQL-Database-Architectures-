# SQL-Database-Architectures-
# SQL Database Architecture: Auction System

## Overview
This project demonstrates the design and implementation of a relational database for a complex, stateful application. The goal was to architect a robust schema that enforces data integrity while supporting multi-role user interactions (Buyers and Sellers).

## Core Architecture
* **Relational Schema Design:** Implemented a superclass/subclass hierarchy for the `USER` entity, with specialized `BUYER` and `SELLER` tables linked via foreign key constraints to ensure referential integrity.
* **Integrity Constraints:** Utilized `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, and `NOT NULL` constraints to maintain strict data validation across transactional tables.
* **Transactional Logic:** Designed schemas for handling complex relational flows, including item listings, bid tracking, and payment processing.
* **Data Verification:** Developed complex `JOIN` statements to aggregate and report on cross-referenced financial and relational data.

## Key SQL Capabilities
* **Normalization:** Organized data into structured tables (`ITEM`, `BID`, `PAYMENT`, `AUCTIONEVENT`) to reduce redundancy and improve query performance.
* **Relational Operations:** Demonstrated proficiency in writing `JOIN` queries to aggregate and normalize data across disparate tables.
* **Automation:** Used `AUTO_INCREMENT` and `TIMESTAMP` defaults to streamline record keeping and state tracking.

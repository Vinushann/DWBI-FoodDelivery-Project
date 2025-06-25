# Data Warehouse and OLAP Reporting Solution

This repository contains two parts of a complete business intelligence solution using SQL Server technologies. The project includes the design and development of a scalable data warehouse and the creation of an OLAP cube for multidimensional analysis and reporting.

## Part 1: Data Warehouse Design and ETL Development

### Overview

The first part focuses on building a scalable data warehouse for a food delivery business scenario. It includes:

- Designing a snowflake schema with fact and dimension tables.
- Extracting data from multiple sources such as SQL tables and CSV files.
- Performing data cleaning, validation, and transformation using SQL Server Integration Services (SSIS).
- Implementing Slowly Changing Dimensions (SCD Type 2) to track historical changes in customer and restaurant data.

### Components

- **Fact Table**: Stores order transactions including quantity, price, discount, and calculated total.
- **Dimension Tables**:
  - Customer
  - Delivery Person
  - Food (linked to Subcategory and Category)
  - Restaurant
  - Payment Method
  - Date (with hierarchy levels: day, month, quarter, year)

### ETL Features

- Use of staging tables to isolate raw data before transformation.
- Lookup and validation tasks to ensure data quality.
- Derived columns for calculations and transformations.
- Accumulating snapshot fact table to track order completion times.

## Part 2: OLAP Cube and Multidimensional Reporting

### OLAP Cube Development

The second part involves creating an OLAP cube using SQL Server Analysis Services (SSAS). It connects to the previously built data warehouse and enables advanced analysis.

- Measures included in the cube:
  - Final Order Amount
  - Order Count
  - Delivery Time in hours
- Role-playing dimensions used to separate order date and delivery date.
- Custom hierarchies created in key dimensions for easier drill-down:
  - Date: Year → Quarter → Month
  - Food: Category → Name
  - Restaurant: City → Name

### OLAP Operations Demonstrated

Using Excel and Power BI, the following OLAP operations were performed:

- **Roll-Up**: Summarizing total sales by year.
- **Drill-Down**: Breaking down yearly sales into months.
- **Slice**: Filtering data by a single dimension such as city.
- **Dice**: Filtering data using multiple dimensions (e.g., city and payment method).
- **Pivot**: Switching rows and columns to view data from different perspectives.

### Power BI Reports

Power BI was used to create four interactive reports:

1. Matrix view comparing cities across months.
2. Slicer-controlled view for filtering by city and payment method.
3. Drill-down chart from year to month using the date hierarchy.
4. Drill-through report for detailed order-level analysis by selected city.

## Summary

This repository demonstrates a complete business intelligence pipeline:

- Designing and implementing a snowflake-based data warehouse.
- Extracting, transforming, and loading data using SSIS.
- Creating an OLAP cube using SSAS.
- Performing interactive multidimensional analysis in Excel and Power BI.

The solution supports reliable, scalable, and insightful reporting for business decision-making.

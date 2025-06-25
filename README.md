# 📊 Data Warehouse and OLAP Reporting Solution

This repository contains two major components:

1. **Scalable Data Warehouse Design and ETL Pipeline**
2. **OLAP Cube Implementation and Multidimensional Analysis**

These components demonstrate how to build and analyze a business intelligence solution using SQL Server technologies.

---

## 🏗️ Part 1: Data Warehouse Design and ETL Development

### ✅ Key Highlights

- Designed a **Snowflake Schema** for a food delivery business scenario.
- Used a mix of **CSV files** and **SQL tables** as source data (customers, delivery staff, food items, payments, and orders).
- Built the data pipeline using **SQL Server Integration Services (SSIS)** with:
  - **Staging Layer**: raw data is loaded and stored temporarily.
  - **Transformation Layer**: includes trimming, null handling, data validation.
  - **Data Warehouse Layer**: fact and dimension tables created with historical tracking.

### 🧱 Dimensions and Fact Table

- **FactOrders**: Stores transactional data (order amount, quantity, discount).
- Dimensions:
  - Customer
  - Delivery Person
  - Food Item → Subcategory → Category
  - Restaurant
  - Payment Method
  - Date

### 🔁 Special Features

- Implemented **Slowly Changing Dimensions (Type 2)** for Customer and Restaurant history tracking.
- Added an **accumulating snapshot fact** to monitor order lifecycle (created vs. completed time).
- Included transformation logic for cleaning and enriching data.

---

## 📦 Part 2: OLAP Cube and Analysis Reports

### 🔧 OLAP Cube Setup

- Developed a cube using **SQL Server Analysis Services (SSAS)**.
- Connected to the previously built data warehouse.
- Defined measures like:
  - Final Order Amount
  - Order Count
  - Delivery Time

- Included dimensions:
  - Food hierarchy (Category → Item)
  - Restaurant location (City → Name)
  - Time (Order Date and Delivery Date as role-playing dimensions)

### 🔎 OLAP Operations Performed

Using **Excel** and **Power BI**, the following operations were demonstrated:

- **Roll-Up**: View total revenue by year
- **Drill-Down**: Break yearly totals into quarters and months
- **Slice**: Filter data by city
- **Dice**: Analyze multiple filters (e.g., city + payment type)
- **Pivot**: Switch rows/columns to view data from different angles

### 📈 Power BI Reporting

Created 4 visual reports using Power BI:

- **Matrix Report**: Monthly totals by city
- **Slicer Report**: Filtered chart by city and payment method
- **Drill-Down Report**: Navigate from year → quarter → month
- **Drill-Through Report**: View detailed order data per city

---

## 🔚 Summary

This project demonstrates a complete Business Intelligence workflow:

- Designing a warehouse schema
- Building ETL pipelines
- Creating historical dimensions
- Developing an OLAP cube
- Visualizing insights with Excel and Power BI

The end-to-end flow enables efficient and insightful decision-making using real-world data modeling techniques.

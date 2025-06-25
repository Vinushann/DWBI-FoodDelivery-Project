-- =====================================================================
-- Create Database FoodDelivery_DW
-- =====================================================================
IF DB_ID('FoodDelivery_DW') IS NULL
    CREATE DATABASE FoodDelivery_DW;
GO

USE FoodDelivery_DW;
GO

-- =====================================================================
-- Create Dimension Tables
-- =====================================================================

-- DimCustomer
CREATE TABLE DimCustomer (
    CustomerSK INT IDENTITY(1,1) PRIMARY KEY,
    AlternateCustomerID INT,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(50),
    Address NVARCHAR(255),
    City NVARCHAR(50),
    Area NVARCHAR(50),
    LoyaltyTier NVARCHAR(20),
    StartDate DATETIME,
    EndDate DATETIME,
    InsertDate DATETIME,
    ModifiedDate DATETIME
);
GO

-- DimDeliveryPerson
CREATE TABLE DimDeliveryPerson (
    DeliveryPersonSK INT IDENTITY(1,1) PRIMARY KEY,
    AlternateDeliveryPersonID INT,
    FullName NVARCHAR(100),
    Phone NVARCHAR(50),
    HireDate DATE,
    Rating FLOAT,
    InsertDate DATETIME,
    ModifiedDate DATETIME
);
GO

-- DimFoodCategory
CREATE TABLE DimFoodCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100)
);
GO

-- DimFoodSubCategory
CREATE TABLE DimFoodSubCategory (
    SubCategoryID INT PRIMARY KEY,
    SubCategoryName NVARCHAR(100),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES DimFoodCategory(CategoryID)
);
GO

ALTER TABLE dbo.DimFoodCategory
ADD 
    InsertDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE();
GO

ALTER TABLE dbo.DimFoodSubCategory
ADD 
    InsertDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE();
GO

-- DimFood
CREATE TABLE DimFood (
    FoodSK INT IDENTITY(1,1) PRIMARY KEY,
    AlternateFoodID INT,
    FoodName NVARCHAR(100),
    SubCategoryID INT,
    Price DECIMAL(10,2),
    InsertDate DATETIME,
    ModifiedDate DATETIME,
    FOREIGN KEY (SubCategoryID) REFERENCES DimFoodSubCategory(SubCategoryID)
);
GO

-- DimRestaurant
CREATE TABLE DimRestaurant (
    RestaurantSK INT IDENTITY(1,1) PRIMARY KEY,
    AlternateRestaurantID INT,
    Name NVARCHAR(100),
    City NVARCHAR(50),
    Area NVARCHAR(50),
    CuisineType NVARCHAR(50),
    Rating FLOAT,
    StartDate DATETIME,
    EndDate DATETIME,
    InsertDate DATETIME,
    ModifiedDate DATETIME
);
GO

-- DimPaymentMethod
CREATE TABLE DimPaymentMethod (
    PaymentMethodSK INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethodName NVARCHAR(50),
    InsertDate DATETIME,
    ModifiedDate DATETIME
);
GO
-- DimDate

-- Drop DimDate table if it already exists
IF OBJECT_ID('dbo.DimDate', 'U') IS NOT NULL
    DROP TABLE dbo.DimDate;
GO

-- Create DimDate Table
CREATE TABLE dbo.DimDate
(
    DateKey INT PRIMARY KEY,
    Date DATE,
    FullDateUK CHAR(10),
    FullDateUSA CHAR(10),
    DayOfMonth VARCHAR(2),
    DaySuffix VARCHAR(4),
    DayName VARCHAR(9),
    DayOfWeekUSA CHAR(1),
    DayOfWeekUK CHAR(1),
    DayOfWeekInMonth VARCHAR(2),
    DayOfWeekInYear VARCHAR(2),
    DayOfQuarter VARCHAR(3),
    DayOfYear VARCHAR(3),
    WeekOfMonth VARCHAR(1),
    WeekOfQuarter VARCHAR(2),
    WeekOfYear VARCHAR(2),
    Month VARCHAR(2),
    MonthName VARCHAR(9),
    MonthOfQuarter VARCHAR(2),
    Quarter CHAR(1),
    QuarterName VARCHAR(9),
    Year CHAR(4),
    YearName CHAR(7),
    MonthYear CHAR(10),
    MMYYYY CHAR(6),
    FirstDayOfMonth DATE,
    LastDayOfMonth DATE,
    FirstDayOfQuarter DATE,
    LastDayOfQuarter DATE,
    FirstDayOfYear DATE,
    LastDayOfYear DATE,
    IsHolidaySL BIT,
    IsWeekday BIT,
    HolidaySL VARCHAR(50),
    IsCurrentDay INT,
    IsDataAvailable INT,
    IsLatestDataAvailable INT
);
GO

-- Set the Start and End Dates
DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2025-12-31';

-- Generate the data
DECLARE @Date DATE = @StartDate;

WHILE @Date <= @EndDate
BEGIN
    INSERT INTO dbo.DimDate
    (
        DateKey,
        Date,
        FullDateUK,
        FullDateUSA,
        DayOfMonth,
        DaySuffix,
        DayName,
        DayOfWeekUSA,
        DayOfWeekUK,
        DayOfWeekInMonth,
        DayOfWeekInYear,
        DayOfQuarter,
        DayOfYear,
        WeekOfMonth,
        WeekOfQuarter,
        WeekOfYear,
        Month,
        MonthName,
        MonthOfQuarter,
        Quarter,
        QuarterName,
        Year,
        YearName,
        MonthYear,
        MMYYYY,
        FirstDayOfMonth,
        LastDayOfMonth,
        FirstDayOfQuarter,
        LastDayOfQuarter,
        FirstDayOfYear,
        LastDayOfYear,
        IsHolidaySL,
        IsWeekday,
        HolidaySL,
        IsCurrentDay,
        IsDataAvailable,
        IsLatestDataAvailable
    )
    SELECT
        CONVERT(INT, FORMAT(@Date, 'yyyyMMdd')),
        @Date,
        FORMAT(@Date, 'dd-MM-yyyy'),
        FORMAT(@Date, 'MM-dd-yyyy'),
        FORMAT(@Date, 'dd'),
        CASE 
            WHEN DATEPART(DAY, @Date) IN (11, 12, 13) THEN FORMAT(@Date, 'dd') + 'th'
            WHEN RIGHT(FORMAT(@Date, 'dd'),1) = '1' THEN FORMAT(@Date, 'dd') + 'st'
            WHEN RIGHT(FORMAT(@Date, 'dd'),1) = '2' THEN FORMAT(@Date, 'dd') + 'nd'
            WHEN RIGHT(FORMAT(@Date, 'dd'),1) = '3' THEN FORMAT(@Date, 'dd') + 'rd'
            ELSE FORMAT(@Date, 'dd') + 'th'
        END,
        DATENAME(WEEKDAY, @Date),
        CAST(DATEPART(WEEKDAY, @Date) AS CHAR(1)),
        CAST(CASE DATEPART(WEEKDAY, @Date) WHEN 1 THEN 7 ELSE DATEPART(WEEKDAY, @Date) - 1 END AS CHAR(1)),
        NULL, -- Optional: can be calculated more complex if needed
        NULL, -- Optional
        NULL, -- Optional
        CAST(DATEPART(DAYOFYEAR, @Date) AS VARCHAR(3)),
        NULL, -- WeekOfMonth
        NULL, -- WeekOfQuarter
        RIGHT('0' + CAST(DATEPART(WEEK, @Date) AS VARCHAR(2)), 2),
        RIGHT('0' + CAST(MONTH(@Date) AS VARCHAR(2)),2),
        DATENAME(MONTH, @Date),
        NULL, -- MonthOfQuarter
        CAST(DATEPART(QUARTER, @Date) AS CHAR(1)),
        CASE DATEPART(QUARTER, @Date)
            WHEN 1 THEN 'First'
            WHEN 2 THEN 'Second'
            WHEN 3 THEN 'Third'
            WHEN 4 THEN 'Fourth'
        END,
        CAST(YEAR(@Date) AS CHAR(4)),
        'CY ' + CAST(YEAR(@Date) AS CHAR(4)),
        LEFT(DATENAME(MONTH, @Date),3) + '-' + CAST(YEAR(@Date) AS CHAR(4)),
        FORMAT(@Date, 'MMyyyy'),
        DATEFROMPARTS(YEAR(@Date), MONTH(@Date), 1),
        EOMONTH(@Date),
        DATEADD(QUARTER, DATEDIFF(QUARTER, 0, @Date), 0),
        DATEADD(QUARTER, DATEDIFF(QUARTER, 0, @Date) + 1, -1),
        DATEFROMPARTS(YEAR(@Date), 1, 1),
        DATEFROMPARTS(YEAR(@Date), 12, 31),
        0, -- IsHolidaySL (you can update later)
        CASE WHEN DATEPART(WEEKDAY, @Date) IN (1,7) THEN 0 ELSE 1 END,
        NULL, -- Holiday Name (optional)
        CASE WHEN @Date = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END,
        1, -- Data available (static)
        CASE WHEN @Date = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END
    ;

    SET @Date = DATEADD(DAY, 1, @Date);
END
GO

-- remove these since those are becomes null values
  alter table [FoodDelivery_DW].[dbo].[DimDate]
  drop column [DayOfWeekInMonth] ,[DayOfWeekInYear],[DayOfQuarter],[WeekOfMonth] ,[WeekOfQuarter], [MonthOfQuarter] ,[HolidaySL]




-- =====================================================================
-- Create Fact Table
-- =====================================================================



-- Create FactOrder table
CREATE TABLE dbo.FactOrders (
    -- Primary Business Key
    OrderID INT PRIMARY KEY,                             -- Order ID from source

    -- Foreign Keys (Surrogate Keys from Dimension Tables)
    CustomerSK INT NOT NULL,                             -- FK to DimCustomer
    RestaurantSK INT NOT NULL,                           -- FK to DimRestaurant
    DeliveryPersonSK INT NOT NULL,                       -- FK to DimDeliveryPerson
    FoodSK INT NOT NULL,                                 -- FK to DimFood
    OrderDateKey INT NOT NULL,                           -- FK to DimDate (Order Date)
    DeliveryDateKey INT NOT NULL,                        -- FK to DimDate (Delivery Date)
    PaymentMethodSK INT NOT NULL,                        -- FK to DimPaymentMethod

    -- Fact Attributes / Measures
    Quantity INT NOT NULL,
    PricePerUnit DECIMAL(10,2) NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    DeliveryCharge DECIMAL(10,2) NOT NULL,
    DiscountAmount DECIMAL(10,2) NOT NULL,
    FinalAmount DECIMAL(10,2) NOT NULL,

    -- Audit Columns
    InsertDate DATETIME DEFAULT GETDATE()
);

-- Add Foreign Key Constraints
ALTER TABLE dbo.FactOrders
ADD CONSTRAINT FK_FactOrder_DimCustomer
FOREIGN KEY (CustomerSK) REFERENCES dbo.DimCustomer(CustomerSK);

ALTER TABLE dbo.FactOrders
ADD CONSTRAINT FK_FactOrder_DimRestaurant
FOREIGN KEY (RestaurantSK) REFERENCES dbo.DimRestaurant(RestaurantSK);

ALTER TABLE dbo.FactOrders
ADD CONSTRAINT FK_FactOrder_DimDeliveryPerson
FOREIGN KEY (DeliveryPersonSK) REFERENCES dbo.DimDeliveryPerson(DeliveryPersonSK);

ALTER TABLE dbo.FactOrders
ADD CONSTRAINT FK_FactOrder_DimFood
FOREIGN KEY (FoodSK) REFERENCES dbo.DimFood(FoodSK);

ALTER TABLE dbo.FactOrders
ADD CONSTRAINT FK_FactOrder_DimOrderDate
FOREIGN KEY (OrderDateKey) REFERENCES dbo.DimDate(DateKey);

ALTER TABLE dbo.FactOrders
ADD CONSTRAINT FK_FactOrder_DimDeliveryDate
FOREIGN KEY (DeliveryDateKey) REFERENCES dbo.DimDate(DateKey);

ALTER TABLE dbo.FactOrders
ADD CONSTRAINT FK_FactOrder_DimPaymentMethod
FOREIGN KEY (PaymentMethodSK) REFERENCES dbo.DimPaymentMethod(PaymentMethodSK);
-- =====================================================================
-- USE THE STAGING DATABASE
-- =====================================================================
CREATE DATABASE FoodDelivery_StagingDB;

USE FoodDelivery_StagingDB;
GO

-- =====================================================================
-- CREATE StgCustomer
-- =====================================================================
IF OBJECT_ID('StgCustomer', 'U') IS NOT NULL
    DROP TABLE StgCustomer;
GO

CREATE TABLE StgCustomer (
    CustomerID INT,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(50),
    Address NVARCHAR(255),
    City NVARCHAR(50),
    Area NVARCHAR(50),sub
    LoyaltyTier NVARCHAR(20)
);
GO

-- =====================================================================
-- CREATE StgDeliveryPerson
-- =====================================================================
IF OBJECT_ID('StgDeliveryPerson', 'U') IS NOT NULL
    DROP TABLE StgDeliveryPerson;
GO

CREATE TABLE StgDeliveryPerson (
    DeliveryPersonID INT,
    FullName NVARCHAR(100),
    Phone NVARCHAR(50),
    HireDate DATE,
    Rating FLOAT
);
GO

-- =====================================================================
-- CREATE StgRestaurant
-- =====================================================================
IF OBJECT_ID('StgRestaurant', 'U') IS NOT NULL
    DROP TABLE StgRestaurant;
GO

CREATE TABLE StgRestaurant (
    RestaurantID INT,
    Name NVARCHAR(100),
    City NVARCHAR(50),
    Area NVARCHAR(50),
    CuisineType NVARCHAR(50),
    Rating FLOAT
);
GO

-- =====================================================================
-- CREATE StgFood
-- =====================================================================
IF OBJECT_ID('StgFood', 'U') IS NOT NULL
    DROP TABLE StgFood;
GO

CREATE TABLE StgFood (
    FoodID INT,
    Name NVARCHAR(100),
    SubCategoryID INT,
    Price DECIMAL(10,2)
);
GO

-- =====================================================================
-- CREATE StgFoodSubCategory
-- =====================================================================
IF OBJECT_ID('StgFoodSubCategory', 'U') IS NOT NULL
    DROP TABLE StgFoodSubCategory;
GO

CREATE TABLE StgFoodSubCategory (
    SubCategoryID INT,
    SubCategoryName NVARCHAR(100),
    CategoryID INT
);
GO

-- =====================================================================
-- CREATE StgFoodCategory
-- =====================================================================
IF OBJECT_ID('StgFoodCategory', 'U') IS NOT NULL
    DROP TABLE StgFoodCategory;
GO

CREATE TABLE StgFoodCategory (
    CategoryID INT,
    CategoryName NVARCHAR(100)
);
GO

-- =====================================================================
-- CREATE StgPaymentMethod
-- =====================================================================
IF OBJECT_ID('StgPaymentMethod', 'U') IS NOT NULL
    DROP TABLE StgPaymentMethod;
GO

CREATE TABLE StgPaymentMethod (
    PaymentMethodID INT,
    PaymentMethodName NVARCHAR(50)
);
GO

-- =====================================================================
-- CREATE StgOrder
-- =====================================================================
IF OBJECT_ID('StgOrder', 'U') IS NOT NULL
    DROP TABLE StgOrder;
GO

CREATE TABLE StgOrder (
    OrderID INT,
    CustomerID INT,
    RestaurantID INT,
    FoodID INT,
    DeliveryPersonID INT,
    OrderDate DATE,
    DeliveryDate DATE,
    Quantity INT,
    PaymentMethodID INT,
    Price DECIMAL(10,2),
    Discount DECIMAL(10,2)
);
GO
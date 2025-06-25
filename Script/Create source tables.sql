-- =====================================================================
-- USE THE CORRECT DATABASE
-- =====================================================================
USE FoodDelivery_SourceDB;
GO

-- =====================================================================
-- CREATE FOODCATEGORY TABLE
-- =====================================================================
IF OBJECT_ID('src.FoodCategory', 'U') IS NOT NULL
    DROP TABLE src.FoodCategory;
GO

CREATE TABLE src.FoodCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
GO

INSERT INTO src.FoodCategory (CategoryID, CategoryName) VALUES
(1, 'Fast Food'),
(2, 'Asian Cuisine'),
(3, 'Western'),
(4, 'Desserts'),
(5, 'Beverages');
GO

SELECT * FROM src.FoodCategory;
GO

-- =====================================================================
-- CREATE FOODSUBCATEGORY TABLE
-- =====================================================================
IF OBJECT_ID('src.FoodSubCategory', 'U') IS NOT NULL
    DROP TABLE src.FoodSubCategory;
GO

CREATE TABLE src.FoodSubCategory (
    SubCategoryID INT PRIMARY KEY,
    SubCategoryName NVARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    CONSTRAINT FK_FoodSubCategory_Category FOREIGN KEY (CategoryID)
        REFERENCES src.FoodCategory(CategoryID)
);
GO

INSERT INTO src.FoodSubCategory (SubCategoryID, SubCategoryName, CategoryID) VALUES
(101, 'Burger', 1),
(102, 'Pizza', 1),
(103, 'Sushi', 2),
(104, 'Rice and Curry', 2),
(105, 'Steak', 3),
(106, 'Pasta', 3),
(107, 'Cake', 4),
(108, 'Ice Cream', 4),
(109, 'Soft Drinks', 5),
(110, 'Coffee', 5);
GO

SELECT * FROM src.FoodSubCategory;
GO

-- =====================================================================
-- CREATE FOOD TABLE
-- =====================================================================
IF OBJECT_ID('src.Food', 'U') IS NOT NULL
    DROP TABLE src.Food;
GO

CREATE TABLE src.Food (
    FoodID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    SubCategoryID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Food_SubCategory FOREIGN KEY (SubCategoryID)
        REFERENCES src.FoodSubCategory(SubCategoryID)
);
GO

INSERT INTO src.Food (FoodID, Name, SubCategoryID, Price) VALUES
(81001, 'Chicken Burger', 101, 9.50),
(81002, 'Veggie Burger', 101, 8.00),
(81003, 'Pepperoni Pizza', 102, 12.00),
(81004, 'Margherita Pizza', 102, 10.00),
(81005, 'Salmon Sushi Roll', 103, 14.00),
(81006, 'Tuna Sushi Roll', 103, 13.00),
(81007, 'Sri Lankan Rice and Curry', 104, 8.00),
(81008, 'Indian Rice and Curry', 104, 8.50),
(81009, 'Beef Steak', 105, 18.00),
(81010, 'Grilled Chicken Steak', 105, 16.00);
GO

SELECT * FROM src.Food;
GO

-- =====================================================================
-- CREATE RESTAURANT TABLE
-- =====================================================================
IF OBJECT_ID('src.Restaurant', 'U') IS NOT NULL
    DROP TABLE src.Restaurant;
GO

CREATE TABLE src.Restaurant (
    RestaurantID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    City NVARCHAR(50),
    Area NVARCHAR(50),
    CuisineType NVARCHAR(50),
    Rating FLOAT
);
GO

INSERT INTO src.Restaurant (RestaurantID, Name, City, Area, CuisineType, Rating) VALUES
(71001, 'KFC Manhattan', 'New York', 'Manhattan', 'Fast Food', 4.2),
(71002, 'Sushi House LA', 'Los Angeles', 'Downtown LA', 'Japanese', 4.6),
(71003, 'Pizza Hut Chicago', 'Chicago', 'Lincoln Park', 'Fast Food', 4.1),
(71004, 'TexMex Grill', 'Houston', 'Midtown', 'Tex-Mex', 4.4),
(71005, 'Burger King SF', 'San Francisco', 'Mission District', 'Fast Food', 4.3);
GO

SELECT * FROM src.Restaurant;
GO

-- =====================================================================
-- CREATE PAYMENTMETHOD TABLE
-- =====================================================================
IF OBJECT_ID('src.PaymentMethod', 'U') IS NOT NULL
    DROP TABLE src.PaymentMethod;
GO

CREATE TABLE src.PaymentMethod (
    PaymentMethodID INT PRIMARY KEY,
    PaymentMethodName NVARCHAR(50) NOT NULL
);
GO

INSERT INTO src.PaymentMethod (PaymentMethodID, PaymentMethodName) VALUES
(1, 'Cash'),
(2, 'Credit Card'),
(3, 'Mobile Wallet'),
(4, 'Bank Transfer');
GO

SELECT * FROM src.PaymentMethod;
GO

-- =====================================================================
-- CREATE ORDERS TABLE
-- =====================================================================
IF OBJECT_ID('src.Orders', 'U') IS NOT NULL
    DROP TABLE src.Orders;
GO

CREATE TABLE src.Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL, -- Will come from CustomerList.csv
    RestaurantID INT NOT NULL,
    FoodID INT NOT NULL,
    DeliveryPersonID INT NOT NULL, -- Will come from DeliveryPersonList.csv
    OrderDate DATE NOT NULL,
    DeliveryDate DATE NOT NULL,
    Quantity INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(10,2) NOT NULL,
    -- Foreign Key Constraints
    CONSTRAINT FK_Orders_Restaurant FOREIGN KEY (RestaurantID) REFERENCES src.Restaurant(RestaurantID),
    CONSTRAINT FK_Orders_Food FOREIGN KEY (FoodID) REFERENCES src.Food(FoodID),
    CONSTRAINT FK_Orders_PaymentMethod FOREIGN KEY (PaymentMethodID) REFERENCES src.PaymentMethod(PaymentMethodID)
);
GO

-- Insert Example Data (Only food/restaurant/payment linked for now)
-- CustomerID and DeliveryPersonID must exist after CSV import!
INSERT INTO src.Orders (OrderID, CustomerID, RestaurantID, FoodID, DeliveryPersonID, OrderDate, DeliveryDate, Quantity, PaymentMethodID, Price, Discount)
VALUES
(91001, 51001, 71001, 81001, 62001, '2021-01-15', '2021-01-15', 2, 1, 19.00, 2.00),
(91002, 51002, 71002, 81003, 62002, '2021-03-10', '2021-03-10', 1, 2, 14.00, 0.00),
(91003, 51003, 71003, 81004, 62003, '2021-05-20', '2021-05-21', 3, 3, 30.00, 2.00),
(91004, 51004, 71004, 81007, 62004, '2022-02-11', '2022-02-12', 2, 2, 16.00, 1.00),
(91005, 51005, 71005, 81009, 62005, '2022-06-25', '2022-06-26', 1, 1, 18.00, 0.00);
GO

SELECT * FROM src.Orders;
GO
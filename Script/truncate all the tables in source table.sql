-- Use correct database
USE FoodDelivery_SourceDB;
GO

-- STEP 1: Disable all Foreign Key Constraints
ALTER TABLE src.Orders NOCHECK CONSTRAINT ALL;
ALTER TABLE src.Food NOCHECK CONSTRAINT ALL;
ALTER TABLE src.FoodSubCategory NOCHECK CONSTRAINT ALL;
ALTER TABLE src.FoodCategory NOCHECK CONSTRAINT ALL;
ALTER TABLE src.Restaurant NOCHECK CONSTRAINT ALL;
ALTER TABLE src.PaymentMethod NOCHECK CONSTRAINT ALL;

-- STEP 2: Delete Data in Dependency Order
DELETE FROM src.Orders;
DELETE FROM src.Food;
DELETE FROM src.FoodSubCategory;
DELETE FROM src.FoodCategory;
DELETE FROM src.Restaurant;
DELETE FROM src.PaymentMethod;

-- STEP 3: (If you had Customer and DeliveryPerson tables here, delete them too)
-- DELETE FROM src.Customer;
-- DELETE FROM src.DeliveryPerson;

-- STEP 4: Re-Enable All Foreign Key Constraints
ALTER TABLE src.Orders CHECK CONSTRAINT ALL;
ALTER TABLE src.Food CHECK CONSTRAINT ALL;
ALTER TABLE src.FoodSubCategory CHECK CONSTRAINT ALL;
ALTER TABLE src.FoodCategory CHECK CONSTRAINT ALL;
ALTER TABLE src.Restaurant CHECK CONSTRAINT ALL;
ALTER TABLE src.PaymentMethod CHECK CONSTRAINT ALL;
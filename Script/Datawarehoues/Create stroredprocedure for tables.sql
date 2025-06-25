-- 1. for dimfoodcategory
CREATE OR ALTER PROCEDURE dbo.UpdateDimFoodCategory
    @CategoryID INT,
    @CategoryName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- If record does NOT exist, INSERT
    IF NOT EXISTS (
        SELECT 1
        FROM dbo.DimFoodCategory
        WHERE CategoryID = @CategoryID
    )
    BEGIN
        INSERT INTO dbo.DimFoodCategory
        (CategoryID, CategoryName, InsertDate, ModifiedDate)
        VALUES
        (@CategoryID, @CategoryName, GETDATE(), GETDATE());
    END
    -- If record exists, UPDATE
    ELSE
    BEGIN
        UPDATE dbo.DimFoodCategory
        SET 
            CategoryName = @CategoryName,
            ModifiedDate = GETDATE()
        WHERE CategoryID = @CategoryID;
    END
END
GO



--2. for dimfoodsubcategory
CREATE OR ALTER PROCEDURE dbo.UpdateDimFoodSubCategory
    @SubCategoryID INT,
    @SubCategoryName NVARCHAR(100),
    @CategoryID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- If record does NOT exist, INSERT
    IF NOT EXISTS (
        SELECT 1
        FROM dbo.DimFoodSubCategory
        WHERE SubCategoryID = @SubCategoryID
    )
    BEGIN
        INSERT INTO dbo.DimFoodSubCategory
        (SubCategoryID, SubCategoryName, CategoryID, InsertDate, ModifiedDate)
        VALUES
        (@SubCategoryID, @SubCategoryName, @CategoryID, GETDATE(), GETDATE());
    END
    -- If record exists, UPDATE
    ELSE
    BEGIN
        UPDATE dbo.DimFoodSubCategory
        SET 
            SubCategoryName = @SubCategoryName,
            CategoryID = @CategoryID,
            ModifiedDate = GETDATE()
        WHERE SubCategoryID = @SubCategoryID;
    END
END
GO




-- 3. food table

CREATE OR ALTER PROCEDURE dbo.UpdateDimFood
    @FoodID INT,
    @FoodName NVARCHAR(100),
    @SubCategoryID INT,
    @Price DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert if not exists
    IF NOT EXISTS (
        SELECT 1 FROM dbo.DimFood WHERE AlternateFoodID = @FoodID
    )
    BEGIN
        INSERT INTO dbo.DimFood
        (AlternateFoodID, FoodName, SubCategoryID, Price, InsertDate, ModifiedDate)
        VALUES
        (@FoodID, @FoodName, @SubCategoryID, @Price, GETDATE(), GETDATE());
    END

    -- Update if exists
    ELSE
    BEGIN
        UPDATE dbo.DimFood
        SET 
            FoodName = @FoodName,
            SubCategoryID = @SubCategoryID,
            Price = @Price,
            ModifiedDate = GETDATE()
        WHERE AlternateFoodID = @FoodID;
    END
END
GO














-- 4. paymentmethod
CREATE OR ALTER PROCEDURE dbo.UpdateDimPaymentMethod
	@PaymentMethodID INT,
	@PaymentMethodName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- If record does not exist, INSERT
    IF NOT EXISTS (
        SELECT 1
        FROM dbo.DimPaymentMethod
        WHERE PaymentMethodName = @PaymentMethodName
    )
    BEGIN
        INSERT INTO dbo.DimPaymentMethod
        (PaymentMethodName, InsertDate, ModifiedDate)
        VALUES
        (@PaymentMethodName, GETDATE(), GETDATE());
    END
    -- If record exists, UPDATE (not necessary for now but good to track ModifiedDate)
    ELSE
    BEGIN
        UPDATE dbo.DimPaymentMethod
        SET 
            ModifiedDate = GETDATE()
        WHERE PaymentMethodName = @PaymentMethodName;
    END
END
GO




use FoodDelivery_DW;
-- 5.deliveryperson 

CREATE OR ALTER PROCEDURE dbo.UpdateDimDeliveryPerson
    @DeliveryPersonID INT,
    @FullName NVARCHAR(100),
    @Phone NVARCHAR(50),
    @HireDate DATE,
    @Rating FLOAT
AS
BEGIN
    SET NOCOUNT ON;

    -- If record does not exist, INSERT
    IF NOT EXISTS (
        SELECT 1
        FROM dbo.DimDeliveryPerson
        WHERE AlternateDeliveryPersonID = @DeliveryPersonID
    )
    BEGIN
        INSERT INTO dbo.DimDeliveryPerson
        (AlternateDeliveryPersonID, FullName, Phone, HireDate, Rating, InsertDate, ModifiedDate)
        VALUES
        (@DeliveryPersonID, @FullName, @Phone, @HireDate, @Rating, GETDATE(), GETDATE());
    END
    -- If record exists, UPDATE (only ModifiedDate and optionally data fields)
    ELSE
    BEGIN
        UPDATE dbo.DimDeliveryPerson
        SET 
            FullName = @FullName,
            Phone = @Phone,
            HireDate = @HireDate,
            Rating = @Rating,
            ModifiedDate = GETDATE()
        WHERE AlternateDeliveryPersonID = @DeliveryPersonID;
    END
END
GO
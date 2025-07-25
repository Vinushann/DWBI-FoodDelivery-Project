SELECT TOP (1000) [SubCategoryID]
      ,[SubCategoryName]
      ,[CategoryID]
  FROM [FoodDelivery_StagingDB].[dbo].[StgFoodSubCategory]
  
INSERT INTO dbo.[StgFoodSubCategory] (SubCategoryID, SubCategoryName, CategoryID) VALUES
(101, 'Burger', 1),
(102, 'Fried Chicken', 1),
(103, 'Nuggets', 1),
(104, 'Sushi', 2),
(105, 'Rice and Curry', 2),
(106, 'Noodles', 2),
(107, 'Steak', 3),
(108, 'Pasta', 3),
(109, 'Pizza', 3),
(110, 'Cake', 4),
(111, 'Ice Cream', 4),
(112, 'Pudding', 4),
(113, 'Soft Drinks', 5),
(114, 'Coffee', 5),
(115, 'Tea', 5),
(116, 'Vegan Burger', 6),
(117, 'Vegan Pizza', 6),
(118, 'Vegan Salads', 6),
(119, 'Grilled Fish', 7),
(120, 'Shrimp Curry', 7),
(121, 'Bread', 8),
(122, 'Croissant', 8),
(123, 'Bagels', 8),
(124, 'Pancakes', 9),
(125, 'Omelette', 9),
(126, 'Toast', 9),
(127, 'Burrito', 10),
(128, 'Taco', 10),
(129, 'Quesadilla', 10);
GO
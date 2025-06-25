SELECT AVG(CAST(Rating AS FLOAT)) AS AvgRating
FROM [dbo].[StgRestaurant]
WHERE Rating IS NOT NULL;
-- File: 01_schema_understanding.sql
-- Purpose: Initial schema understanding and data quality checks
-- Dataset: NYC Airbnb listings

-- 1. Row count
SELECT COUNT(*) AS total_rows
FROM listings_nyc;

-- 2. Sample rows
SELECT *
FROM listings_nyc
LIMIT 10;

-- 3. Null checks
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE price IS NULL) AS null_price,
    COUNT(*) FILTER (WHERE number_of_reviews IS NULL) AS null_reviews,
    COUNT(*) FILTER (WHERE reviews_per_month IS NULL) AS null_reviews_per_month,
    COUNT(*) FILTER (WHERE room_type IS NULL) AS null_room_type
FROM listings_nyc;

-- 4. Price sanity check
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    ROUND(AVG(price), 2) AS avg_price
FROM listings_nyc
WHERE price IS NOT NULL;

-- 5. Engagement overview
SELECT
    MIN(number_of_reviews) AS min_reviews,
    MAX(number_of_reviews) AS max_reviews,
    ROUND(AVG(number_of_reviews), 2) AS avg_reviews
FROM listings_nyc;

-- 6. Room type distribution
SELECT
    room_type,
    COUNT(*) AS listings_count
FROM listings_nyc
GROUP BY room_type
ORDER BY listings_count DESC;

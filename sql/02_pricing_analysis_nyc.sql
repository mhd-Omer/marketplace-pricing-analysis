-- File: 02_pricing_analysis.sql
-- Purpose: Pricing analysis for NYC Airbnb listings
-- Focus: Distribution, central tendency, and price bands

-- 1. Median vs Average
SELECT
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price)::NUMERIC, 2) AS median_price
FROM listings_nyc
WHERE price IS NOT NULL;

-- 2. Price spread
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price)::NUMERIC AS p25_price,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY price)::NUMERIC AS median_price,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price)::NUMERIC AS p75_price
FROM listings_nyc
WHERE price IS NOT NULL;

-- 3. Identifying extreme outliers
SELECT
    COUNT(*) AS extreme_price_listings
FROM listings_nyc
WHERE price > 10000; 

SELECT
    id,
    room_type,
    neighbourhood_cleansed,
    price
FROM listings_nyc
WHERE price > 10000
ORDER BY price DESC
LIMIT 10;

-- 4. Create price bands
WITH price_thresholds AS (
    SELECT
        PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY price) AS low_threshold,
        PERCENTILE_CONT(0.66) WITHIN GROUP (ORDER BY price) AS mid_threshold
    FROM listings_nyc
    WHERE price IS NOT NULL
)
SELECT
    CASE
        WHEN price <= low_threshold THEN 'Budget'
        WHEN price <= mid_threshold THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_band,
    COUNT(*) AS listings_count
FROM listings_nyc, price_thresholds
WHERE price IS NOT NULL
GROUP BY price_band
ORDER BY listings_count DESC;

-- 5. Price bands × room type
WITH price_thresholds AS (
    SELECT
        PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY price) AS low_threshold,
        PERCENTILE_CONT(0.66) WITHIN GROUP (ORDER BY price) AS mid_threshold
    FROM listings_nyc
    WHERE price IS NOT NULL
)
SELECT
    room_type,
    CASE
        WHEN price <= low_threshold THEN 'Budget'
        WHEN price <= mid_threshold THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_band,
    COUNT(*) AS listings_count
FROM listings_nyc, price_thresholds
WHERE price IS NOT NULL
GROUP BY room_type, price_band
ORDER BY price_band, listings_count DESC;

-- 6. Median price by room type
SELECT
    room_type,
    ROUND(
        PERCENTILE_CONT(0.5) 
        WITHIN GROUP (ORDER BY price)::NUMERIC, 
        2
    ) AS median_price
FROM listings_nyc
WHERE price IS NOT NULL
GROUP BY room_type
ORDER BY median_price DESC;
-- File: 06_engagement_analysis_london.sql
-- Purpose: Analyze engagement vs price for London Airbnb listings
-- Focus: Reviews, price bands, and listing maturity

-- 1. Price vs average engagement
SELECT
    CASE
        WHEN price < 100 THEN '< $100'
        WHEN price BETWEEN 100 AND 199 THEN '$100–199'
        WHEN price BETWEEN 200 AND 399 THEN '$200–399'
        WHEN price BETWEEN 400 AND 999 THEN '$400–999'
        ELSE '$1000+'
    END AS price_range,
    COUNT(*) AS listings_count,
    ROUND(AVG(number_of_reviews), 2) AS avg_reviews
FROM listings_london
WHERE price IS NOT NULL
GROUP BY price_range
ORDER BY listings_count DESC;

-- 2. Median engagement
SELECT
    CASE
        WHEN price < 100 THEN '< $100'
        WHEN price BETWEEN 100 AND 199 THEN '$100–199'
        WHEN price BETWEEN 200 AND 399 THEN '$200–399'
        WHEN price BETWEEN 400 AND 999 THEN '$400–999'
        ELSE '$1000+'
    END AS price_range,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY number_of_reviews)::NUMERIC,
        2
    ) AS median_reviews
FROM listings_london
WHERE price IS NOT NULL
GROUP BY price_range
ORDER BY median_reviews DESC;

-- 3. Distribution: new vs established listings
SELECT
    CASE
        WHEN number_of_reviews <= 5 THEN 'New'
        ELSE 'Established'
    END AS listing_type,
    COUNT(*) AS listings_count
FROM listings_london
GROUP BY listing_type;

-- 4. Price comparison: new vs established listings
SELECT
    CASE
        WHEN number_of_reviews <= 5 THEN 'New'
        ELSE 'Established'
    END AS listing_type,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY price)::NUMERIC,
        2
    ) AS median_price
FROM listings_london
WHERE price IS NOT NULL
GROUP BY listing_type;

-- 5. Engagement by price band
WITH price_thresholds AS (
    SELECT
        PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY price) AS low_threshold,
        PERCENTILE_CONT(0.66) WITHIN GROUP (ORDER BY price) AS mid_threshold
    FROM listings_london
    WHERE price IS NOT NULL
)
SELECT
    CASE
        WHEN price <= low_threshold THEN 'Budget'
        WHEN price <= mid_threshold THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_band,
    COUNT(*) AS listings_count,
    ROUND(AVG(number_of_reviews), 2) AS avg_reviews,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY number_of_reviews)::NUMERIC,
        2
    ) AS median_reviews
FROM listings_london, price_thresholds
WHERE price IS NOT NULL
GROUP BY price_band
ORDER BY avg_reviews DESC;

-- 6. Identify risky listings
SELECT
    id,
    room_type,
    neighbourhood_cleansed,
    price,
    number_of_reviews
FROM listings_london
WHERE price > 500
  AND number_of_reviews < 5
ORDER BY price DESC
LIMIT 20;
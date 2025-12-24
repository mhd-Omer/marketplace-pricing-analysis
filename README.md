# Marketplace Pricing & Engagement Analysis (Multi-City Airbnb Case Study)

## Overview
This project analyzes **pricing behavior and user engagement patterns across multiple Airbnb markets** using **SQL (PostgreSQL)** and **Python (for data preparation only)**. The objective is to derive **marketplace-level insights** that generalize across cities and are transferable to large-scale platforms such as real estate portals, rental marketplaces, and e-commerce ecosystems.

The analysis is designed to be **scalable**: each city follows the same analytical framework, enabling meaningful cross-city comparison once multiple markets are added.

The core business questions addressed are:
1. How are listings priced, and how skewed are pricing distributions across cities?
2. Does higher price translate to higher user engagement (reviews)?
3. How do new listings behave compared to established ones within each market?
4. Which price segments generate the highest engagement?

---

## Dataset
- **Source:** Inside Airbnb (official public dataset)
- **Markets analyzed:**
  - New York City (completed)
  - London (planned)
  - Paris (planned)
  - Singapore (planned)

### New York City Snapshot
- **Number of listings:** 36,111

Raw CSV data is lightly cleaned using Python for schema alignment and database compatibility. All analytical logic and insights are derived using PostgreSQL.

---

## Data Preparation & Quality Checks (Common Across Cities)
Before analysis, each city dataset undergoes consistent validation steps:
- Verification of successful data load and row counts
- Confirmation of numeric integrity for pricing fields
- Identification of expected NULL values (e.g., price, reviews_per_month)
- Validation of critical categorical fields such as room_type

Missing values are intentionally retained as NULLs to preserve data integrity and avoid bias.

---

## City-Level Analysis: New York City

### Pricing Distribution
- **Average price:** $680.53
- **Median price:** $154.00

Pricing in NYC is heavily right-skewed due to a small number of extremely high-priced listings. Median price is therefore a more representative measure of typical market pricing.

---

### Core Market Price Range
- 25% of listings priced at or below **$89**
- 50% (median) priced at or below **$154**
- 75% priced at or below **$279**

This indicates that the majority of NYC listings fall within a $90–$280 range, with rapid price escalation beyond the upper quartile.

---

### Extreme Pricing Outliers
- **218 listings** priced above **$10,000**
- Maximum observed price exceeds **$50,000**
- Predominantly hotel rooms and select private listings in central locations

These outliers represent niche or non-typical inventory and are analyzed separately to prevent skewed market conclusions.

---

### Price Band Segmentation (NYC)
Listings were segmented using percentile-based price bands:
- **Budget:** 7,071 listings
- **Mid-range:** 7,082 listings
- **Premium:** 7,175 listings

The near-uniform distribution suggests a highly competitive and balanced marketplace.

---

### Room Type vs Price Band (NYC)
- **Budget:** Dominated by private rooms
- **Mid-range:** Primarily entire homes/apartments
- **Premium:** Dominated by entire homes, with hotel rooms competing almost exclusively in this segment

As prices increase, demand shifts toward listings offering greater privacy and exclusivity.

---

## Engagement Analysis: New York City

### Engagement vs Price
Engagement follows an inverted-U relationship with price:
- Highest engagement in the **$100–199** and **$200–399** ranges
- Reduced engagement at both low-price (crowded) and high-price (niche) extremes

Higher price does **not** directly correlate with higher engagement.

---

### Median Engagement Confirms Demand Concentration
Median review counts decline steadily as prices rise. Listings priced above $1000 typically exhibit zero median engagement, indicating limited demand volume in premium segments.

---

### New vs Established Listings (NYC)
- **New listings:** 20,369
- **Established listings:** 15,742

A large proportion of listings are early-stage, reflecting continuous supply churn and high competition within the NYC market.

---

### Pricing Behavior by Listing Maturity
- Median prices are similar between new and established listings
- New listings exhibit significantly higher price volatility due to extreme outliers

This suggests comparable baseline pricing strategies with divergent risk profiles.

---

### Engagement by Price Band
- **Mid-range listings:** Highest average and median engagement
- **Budget listings:** High competition, diluted engagement
- **Premium listings:** Lower engagement despite higher prices

Mid-range offerings achieve the strongest balance between price and demand.

---

## Cross-City Extension (In Progress)
The NYC analysis serves as the baseline framework. The same SQL logic will be applied to additional cities to:
- Compare pricing distributions and skewness
- Identify city-specific engagement sweet spots
- Assess how market maturity and affordability differ by region

---

## Business-Level Takeaways
- Median-based metrics are essential for skewed marketplace data
- Extreme pricing outliers should be contextualized, not blindly removed
- Higher price does not guarantee higher engagement
- Mid-range price segments consistently drive the strongest demand signals

These insights are broadly applicable to two-sided marketplaces such as real estate platforms, rental services, and e-commerce portals.

---

## Tools Used
- **PostgreSQL:** Core querying and analytical logic
- **Python (Pandas):** One-time data preparation
- **Git & GitHub:** Version control and documentation

# Marketplace Pricing & Engagement Analysis (Multi-City Airbnb Case Study)

## Overview
This project analyzes **pricing behavior and user engagement patterns across multiple Airbnb markets** using **SQL (PostgreSQL)** and **Python (for data preparation only)**. The objective is to derive **marketplace-level insights** that generalize across cities and are transferable to large-scale platforms such as real estate portals, rental marketplaces, and e-commerce ecosystems.

The analysis is intentionally designed to be **scalable and repeatable**. Each city follows the same analytical framework, enabling consistent city-level insights as well as meaningful cross-city comparisons.

The core business questions addressed are:
1. How are listings priced, and how skewed are pricing distributions across cities?
2. Does higher price translate to higher user engagement (reviews)?
3. How do new listings behave compared to established ones within each market?
4. Which price segments generate the strongest engagement signals?

---

## Dataset
- **Source:** Inside Airbnb (official public dataset)
- **Markets analyzed:**
  - New York City (completed)
  - London (completed)
  - Paris (planned)
  - Singapore (planned)

All prices are analyzed in **local currency**. Cross-city comparisons rely on **relative measures** (medians, percentiles, price bands) rather than absolute currency values.

---

## Data Preparation & Quality Checks (Common Across Cities)
Before analysis, each city dataset undergoes consistent validation and preparation steps:
- Verification of successful data load and row counts
- Confirmation of numeric integrity for pricing fields
- Identification of expected NULL values (e.g., price, reviews_per_month)
- Validation of critical categorical fields such as room_type

Missing values are intentionally retained as NULLs to preserve data integrity and avoid analytical bias.

---

## City-Level Analysis: New York City

### Market Snapshot
- **Total listings:** 36,111
- Market structure includes a mix of entire homes, private rooms, and hotel inventory

---

### Pricing Distribution
- **Average price:** $680.53  
- **Median price:** $154.00  

NYC pricing is **heavily right-skewed**, driven by a small number of extremely high-priced listings. Median price is therefore a far more reliable representation of a typical listing.

---

### Core Market Price Range
- 25% of listings priced at or below **$89**
- 50% (median) priced at or below **$154**
- 75% priced at or below **$279**

The majority of demand is concentrated between $90 and $280, with rapid price escalation beyond the upper quartile.

---

### Extreme Pricing Outliers
- **218 listings** priced above **$10,000**
- Maximum observed price exceeds **$50,000**
- Predominantly hotel rooms and select private listings in central locations

These listings represent niche or non-typical inventory and materially distort mean-based metrics.

---

### Price Band Segmentation (NYC)
Listings were segmented using percentile-based price bands:
- **Budget:** 7,071 listings
- **Mid-range:** 7,082 listings
- **Premium:** 7,175 listings

The near-uniform distribution suggests a highly competitive and well-supplied marketplace.

---

### Room Type vs Price Band (NYC)
- **Budget:** Dominated by private rooms
- **Mid-range:** Primarily entire homes/apartments
- **Premium:** Dominated by entire homes, with hotel rooms competing almost exclusively in this tier

As prices increase, demand shifts toward listings offering greater privacy and exclusivity.

---

## Engagement Analysis: New York City

### Engagement vs Price
Engagement in NYC follows an **inverted-U relationship** with price:
- Highest engagement occurs in the **mid-range price segment**
- Engagement declines at both low-price (high competition) and high-price (niche demand) extremes

Higher prices do **not** directly translate into higher engagement.

---

### Listing Maturity
- **New listings:** 20,369
- **Established listings:** 15,742

NYC shows higher listing churn, with many listings still in early stages of establishing demand.

---

### Engagement by Price Band
- **Mid-range listings:** Highest average and median engagement
- **Budget listings:** Competitive but engagement is diluted
- **Premium listings:** Lowest engagement despite higher prices

Mid-range listings achieve the strongest balance between price and demand.

---

## City-Level Analysis: London

### Market Snapshot
- **Total listings:** 96,871
- Market dominated by **entire home/apartment listings**, indicating a more professionalized hosting ecosystem

---

### Pricing Distribution
- **Average price:** £229.92  
- **Median price:** £135.00  

London pricing is moderately right-skewed but far more stable than NYC. Median price remains the most reliable indicator of typical listing cost.

---

### Core Market Price Range
- 25% of listings priced at or below **£77**
- 50% (median) priced at or below **£135**
- 75% priced at or below **£221**

Most London listings cluster tightly within this range, indicating strong price discipline.

---

### Extreme Pricing Outliers
- **32 listings** priced above **£10,000**
- Maximum observed price exceeds **£1,000,000**
- These listings show negligible engagement and likely represent placeholder or non-transactional inventory

---

### Price Band Segmentation (London)
- **Budget:** 20,453 listings
- **Mid-range:** 20,442 listings
- **Premium:** 21,068 listings

Supply is evenly distributed across segments, reflecting a balanced marketplace.

---

### Room Type vs Price Band (London)
- **Budget:** Predominantly private rooms
- **Mid-range:** Largely entire homes/apartments
- **Premium:** Almost exclusively entire homes, with minimal hotel presence

As prices rise, London listings overwhelmingly shift toward full-unit accommodations.

---

## Engagement Analysis: London

### Engagement vs Price
Unlike NYC, engagement in London **decreases monotonically as prices increase**:
- **Budget listings** receive the highest engagement
- Engagement steadily declines across mid-range and premium tiers

This indicates strong **price sensitivity** and affordability-driven demand.

---

### Listing Maturity
- **New listings:** 50,794
- **Established listings:** 46,077

London exhibits a near-even split between new and established listings, suggesting a mature and stable marketplace.

---

### Engagement by Price Band
- **Budget listings:** Highest engagement
- **Mid-range listings:** Moderate engagement
- **Premium listings:** Lowest engagement

Lower-priced listings consistently generate the strongest demand signals.

---

## Cross-City Comparison: New York City vs London

- **NYC** exhibits higher price volatility and a mid-range engagement peak
- **London** shows tighter price clustering and stronger price sensitivity
- Extreme outliers are far more prevalent and impactful in NYC
- London’s market structure is more professionalized and stable

**Summary insight:** NYC behaves as a value-segmented, experience-driven marketplace, while London behaves as a price-sensitive, affordability-driven marketplace.

---

## Business-Level Takeaways
- Median-based metrics are essential for skewed marketplace data
- Higher price does not guarantee higher engagement
- Pricing strategies must adapt to local market dynamics
- Relative measures enable meaningful cross-city comparisons

---

## Tools Used
- **PostgreSQL:** Core querying and analytical logic
- **Python (Pandas):** One-time data preparation
- **Git & GitHub:** Version control and documentation

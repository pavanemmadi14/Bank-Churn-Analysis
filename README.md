# Bank Churn Analysis Dashboard

A two-page interactive Power BI dashboard for analysing customer churn patterns and risk factors in a retail banking context.

---

## Project Overview

This dashboard helps banking analysts and business stakeholders understand **who their customers are** and **where they are losing them**. It is split into two focused views:

| Page | Title | Purpose |
|------|-------|---------|
| 1 | Customer Portfolio Overview | Understand the customer base — demographics, geography, products, and tenure |
| 2 | Churn Drivers & Risk Analysis | Identify churn rates, high-risk segments, and key attrition factors |

---

## Dataset Summary

| Field | Details |
|-------|---------|
| Total customers | 10,000 |
| Average age | 39 years |
| Average balance | $76,490 |
| Average credit score | 651 |
| Active member rate | 51.5% |
| Overall churn rate | 20.4% (2,037 customers churned) |

---

## Dashboard Pages

### Page 1 — Customer Portfolio Overview

Provides a high-level demographic and behavioural snapshot of the full customer base.

**KPI Cards**
- Total Customers: 10,000
- Average Age: 39
- Average Balance: 76.49K
- Average Credit Score: 651
- Active Member %: 51.5%

**Visuals**
- **Customers by Geography** — Donut chart showing France (50.1%), Germany (25.1%), Spain (24.8%)
- **Customers by Gender** — Donut chart: Female (54.58%), Male (45.42%)
- **Customers by Number of Products** — Bar chart: One (5.1K), Two (4.6K), Three (0.3K), Four (0.1K)
- **Customers by Age Group** — Treemap: Adult (5,806), Middle Aged (2,780), Senior (800), Young Adult (611)
- **Customers by Tenure Group** — Horizontal bar: New (2.5K), Mid (3.0K), Loyal (3.0K), Very Loyal (1.5K)

**Filters available**
- Churn Status
- Balance Group
- Customer Status

---

### Page 2 — Churn Drivers & Risk Analysis

Identifies which customer segments churn the most and the top contributing risk factors.

**KPI Cards**
- Overall Churn Rate: 20.4% (2,037 churned)
- Retained: 79.6% (7,963 retained)
- Highest Churn Geography: Germany (32.5% churn rate)
- Inactive Churn Rate: 26.9% vs 14.3% for active members
- High Risk Age Group: Middle Aged (38.0% churn rate)

**Visuals**
- **Churned vs Retained %** — Donut chart (20.4% / 79.6%)
- **Churn Rate by Number of Products** — Bar chart: One (27.7%), Two (7.6%), Three (82.7%), Four (100%)
- **Churn Rate by Balance Group** — Horizontal bar: Zero (13.8%), 1–50K (34.7%), 50–100K (19.9%), 100–150K (25.8%), 150K+ (23.1%)
- **Churn Rate by Age Group** — Treemap: Middle Aged (38%), Senior (36.8%), Adult (11%), Young Adult (7.5%)
- **Key Churn Risk Factors** — Ranked horizontal bar chart

**Filters available**
- Gender
- Geography
- Tenure Group
- Customer Status

---

## Key Insights

1. **4-product customers churn at 100%** — customers holding 4 products have a 100% churn rate; this warrants urgent investigation
2. **3-product customers are also very high risk** at 82.7% churn
3. **Germany has the highest churn rate** (32.5%) compared to France and Spain
4. **Inactive customers churn at nearly twice the rate** of active members (26.9% vs 14.3%)
5. **Middle Aged customers (51–60)** are the highest churn risk age group at 38%
6. **Balance band 1–50K** has the highest churn rate across balance groups (34.7%)
7. **Female customers** show a slightly elevated churn rate (25.1%) compared to males

---

## Recommended Actions

| Risk Factor | Suggested Action |
|-------------|-----------------|
| 3–4 product holders churning | Review product bundling strategy; conduct exit interviews |
| Germany high churn | Geo-specific retention campaign; investigate service quality |
| Inactive members | Re-engagement programme; targeted outreach before they lapse |
| Age 51–60 segment | Tailored product offers suited to mid-life financial needs |
| Balance 1–50K band | Low-balance customers may feel underserved; review fee structures |

---

## File Structure

```
bank-churn-dashboard/
├── README.md
├── Bank_Analysis_Dashboard.pbix        # Main Power BI file
├── Bank_churn_analysis.sql
└── bank_churn_messy.csv        # Source dataset
```

---

## Tools Used

- **Power BI Desktop** — dashboard design and visualisation
- **DAX** — calculated measures (churn rate, retention rate, segment breakdowns)
- **Power Query** — data transformation and age/balance grouping
- **Sql** — data extraction, filtering, and exploratory querying of the raw customer dataset
---

## How to Use

1. Open `BankChurnDashboard.pbix` in Power BI Desktop
2. Use the **Menu** panel on the left to switch between Overview and Churn Analysis pages
3. Use the **dropdown filters** (Gender, Geography, Tenure Group, Customer Status) to slice the data
4. Hover over any chart element for detailed tooltips

---

## Potential Improvements

- Replace gradient background with a flat dark or white theme for a more modern look
- Swap the Age Group treemap for a horizontal bar chart for clearer label readability
- Add a drill-through page for individual customer-level detail
- Include a trend line showing churn rate over time (if date data is available)
- Add a dedicated Germany deep-dive page given its outsized churn rate

---

## Author
Pavan Emmadi

# Global Electronics Retailer Analytics

An end-to-end **Business Analyst & Data Analytics project** analyzing sales, customers, products, stores, and business performance using **PostgreSQL, SQL, and Power BI**.

The project focuses on identifying revenue drivers, customer behavior, market performance, sales trends, and the key factors behind the significant decline in sales during 2020.

---

## 📌 Project Overview

The **Global Electronics Retailer** dataset contains transactional sales data covering customers, products, stores, exchange rates, and sales transactions.

The objective of this project was to transform raw business data into actionable insights that could support management decision-making.

The analysis covers:

* Sales performance
* Order volume
* Customer activity
* Product and category performance
* Country and store performance
* Sales trends
* Revenue concentration
* Customer purchasing behavior
* 2020 sales decline
* Root cause analysis
* Management recommendations

---

## 🎯 Business Problem

Management needs to understand:

1. What are the company's major revenue drivers?
2. Which products and categories generate the most sales?
3. Which markets contribute the most revenue?
4. How are customers behaving?
5. How has sales performance changed over time?
6. What caused the major decline in sales during 2020?
7. Which markets and categories were most affected?
8. What actions should management prioritize?

---

## 🗂️ Dataset

The project uses six datasets:

| Dataset         | Description                                      |
| --------------- | ------------------------------------------------ |
| Customers       | Customer information                             |
| Products        | Product, brand, category and pricing information |
| Sales           | Transaction-level sales data                     |
| Stores          | Store and geographical information               |
| Exchange_Rates  | Currency exchange rate information               |
| Data_Dictionary | Dataset field definitions                        |

### Dataset Size

| Table           |   Rows |
| --------------- | -----: |
| Customers       | 15,266 |
| Products        | 25,180 |
| Sales           | 62,884 |
| Stores          |     67 |
| Exchange Rates  | 11,215 |
| Data Dictionary |     37 |

---

## 🛠️ Tools & Technologies

* **PostgreSQL 18.6**
* **pgAdmin 4**
* **SQL**
* **Microsoft Power BI**
* **DAX**
* **GitHub**
* **Microsoft Excel / CSV**

---

## 🗄️ Data Model

The Power BI model uses a simple relational structure:

```text
Customers ────────┐
                  │
Products ─────────┼──── Sales
                  │
Stores ───────────┘

Exchange Rates
      │
      └── Supporting currency analysis
```

### Relationships

* Customers → Sales
* Products → Sales
* Stores → Sales
* Exchange Rates → Sales by date and currency
* Data Dictionary → Documentation/reference table

---

## 💰 Revenue Calculation

The Sales table does not contain a direct revenue column.

Revenue was calculated using:

```text
Revenue = Quantity × Unit Price USD
```

In SQL:

```sql
SELECT
    SUM(s.quantity * p.unitpriceusd) AS total_sales
FROM sales s
JOIN products p
    ON s.productkey = p.productkey;
```

This produced total sales of approximately:

**$55.76 million**

---

# 📊 Key Business KPIs

| KPI                                |    Result |
| ---------------------------------- | --------: |
| Total Sales                        |   $55.76M |
| Total Orders                       |    26,326 |
| Total Quantity                     |   197,757 |
| Total Customers                    |    15,266 |
| Active Customers                   |    11,887 |
| Average Order Value                | $2,117.80 |
| Average Quantity per Order         |      7.51 |
| Sales per Active Customer          | $4,690.46 |
| Customer Purchase Rate             |    77.88% |
| Repeat Customers                   |     7,272 |
| Repeat Customer Rate               |    61.17% |
| Average Orders per Active Customer |      2.21 |

---

# 📈 Power BI Dashboard

The Power BI report contains three analytical pages.

## Page 1 — Business Performance

The first dashboard provides an overall view of business performance.

### Key Analysis

* Total Sales
* Total Orders
* Total Quantity
* Customer KPIs
* Sales by Product Category
* Sales by Country
* Sales Trend Over Time
* Sales by Brand
* Sales by Store
* Sales by Product Subcategory
* Quantity by Product Category
* Sales by State

---

## Page 2 — Product & Customer Analysis

The second dashboard focuses on product and customer performance.

### Key Analysis

* Top 10 Products by Sales
* Top 10 Customers by Sales
* Orders by Product Category
* Average Order Value by Country
* Customer Purchase Rate by Country
* Active Customers by Country
* Sales by Product Color
* Total Quantity by Country
* Average Quantity per Order by Country
* Sales by Product Subcategory
* Orders by Country

---

## Page 3 — Business Insights & Actions

The final page converts the analysis into management-level insights and recommendations.

### Main Findings

* Order volume was the primary issue behind the sales decline.
* Several markets experienced significant deterioration.
* Home Appliances and Audio were among the most affected categories.
* Average Order Value remained stable.
* Customer activity declined much less than order volume.
* Online, UK and Canada demonstrated greater resilience.
* Computers and the U.S. market remained major revenue drivers.

---

# 🔍 Key Business Findings

## 1. Top Product Performance

The top five products generated approximately:

**$2.32M**

or around **4.16% of total sales**.

The leading products were predominantly desktop PC variants.

### Recommendation

Maintain strong inventory availability for high-performing desktop products while continuing to diversify the product portfolio.

---

## 2. Category Revenue Concentration

The largest category was:

**Computers — $19.30M / 34.62%**

followed by:

* Home Appliances — 19.36%
* Cameras and camcorders — 11.69%
* Cell phones — 11.09%
* TV and Video — 10.63%

### Recommendation

Protect the Computers category as a major revenue driver while reducing dependency through continued development of other categories.

---

## 3. Country Revenue Concentration

The United States generated approximately:

**$23.76M / 42.62%**

Online sales represented approximately:

**$11.40M / 20.45%**

Together, the U.S. and Online channel represented approximately:

**63.07% of total sales.**

### Recommendation

Protect these major revenue sources while developing underperforming markets to improve geographic diversification.

---

## 4. Revenue Decline in 2020

Annual sales changed significantly:

| Year |   Sales |
| ---- | ------: |
| 2016 |  $6.95M |
| 2017 |  $7.42M |
| 2018 | $12.79M |
| 2019 | $18.26M |
| 2020 |  $9.29M |
| 2021 | $1.04M* |

*2021 contains data through February.

Sales declined by approximately **49% from 2019 to 2020**.

---

## 5. Order Volume Collapse

The most significant change occurred between February and April 2020.

Orders decreased from:

**1,124 → 80**

representing approximately:

**−92.9%**

Sales decreased from:

**$2.23M → $217.6K**

representing approximately:

**−90.2%**

### Key Insight

The sales decline was primarily driven by a dramatic reduction in **transaction volume**.

---

## 6. Market Impact

The most affected markets during March–April 2020 included:

| Market      | Approx. Change |
| ----------- | -------------: |
| Germany     |           −72% |
| Australia   |           −77% |
| Netherlands |           −78% |

Meanwhile, several markets showed resilience:

| Market | Approx. Change |
| ------ | -------------: |
| Online |           +20% |
| UK     |           +31% |
| Canada |           +45% |

### Recommendation

Investigate operational, supply, demand and market-specific factors in Germany, Australia and the Netherlands while studying the practices that supported resilience in Online, UK and Canada.

---

## 7. Category Impact

The most significant category declines included:

| Category        | Approx. Change |
| --------------- | -------------: |
| Home Appliances |           −45% |
| Audio           |           −35% |

Meanwhile:

* Cameras and camcorders increased approximately 34%.
* Cell phones increased approximately 7%.

### Recommendation

Review inventory availability, supply constraints, pricing and customer demand in affected categories.

---

## 8. Customer Behavior

Active customers during March–April declined by approximately:

**−10.8%**

However, orders per active customer remained essentially unchanged.

Average Order Value also remained stable:

**2019:** ~$2,160
**2020:** ~$2,167

Change:

**+0.3%**

### Key Insight

Customers were not simply spending substantially less per order.

The major issue was the sharp decline in overall transaction volume.

---

# 🧠 Root Cause Analysis

The analysis indicates that the 2020 revenue decline was primarily caused by a **collapse in order volume**.

The evidence shows:

```text
Revenue Decline
       │
       ▼
Order Volume Collapse
       │
       ├── Major impact in selected markets
       │
       └── Major impact in selected categories

Meanwhile:
       │
       ├── AOV remained stable
       ├── Purchase frequency remained stable
       └── Customer decline was comparatively smaller
```

Therefore, reducing customer spending per order was **not the primary explanation** for the decline.

---

# 💡 Management Recommendations

### 1. Recover

Prioritize investigation and recovery plans for:

* Germany
* Australia
* Netherlands

### 2. Investigate

Review:

* Home Appliances
* Audio
* Inventory availability
* Supply conditions
* Pricing
* Demand changes

### 3. Protect

Protect the company's strongest revenue drivers:

* Computers
* United States
* Online channel

### 4. Learn

Study resilient markets and channels:

* Online
* UK
* Canada

Identify successful practices that could be replicated elsewhere.

### 5. Monitor

Management should continuously monitor:

* Orders
* Sales
* Active customers
* Average Order Value
* Category performance
* Country performance

---

# 📁 Repository Structure

```text
Global-Electronics-Retailer-Analytics/
│
├── Documentation/
│   └── Business_Analysis_Report.md
│
├── PowerBI/
│   └── Global_Electronics_Retailer_Analytics.pbix
│
├── SQL/
│   └── Global_Electronics_Retailer_Analysis.sql
│
├── Screenshots/
│   ├── Page1_Business_Performance.png
│   ├── Page2_Product_Customer_Analysis.png
│   └── Page3_Business_Insights_Actions.png
│
└── README.md
```

---

# 📂 Project Files

### Documentation

The `Documentation` folder contains the complete business analysis report, including:

* Business problem
* Dataset overview
* Data model
* KPI analysis
* Business findings
* Root cause analysis
* Recommendations

### SQL

The `SQL` folder contains the complete PostgreSQL analysis covering:

* Data validation
* KPI calculations
* Product analysis
* Customer analysis
* Country analysis
* Sales trends
* Business decline analysis
* Revenue concentration

### Power BI

The `PowerBI` folder contains the completed interactive Power BI dashboard.

### Screenshots

The `Screenshots` folder contains images of all three Power BI dashboard pages.

---

# 🏆 Project Outcome

This project demonstrates an end-to-end Business Analyst workflow:

```text
Raw Data
   ↓
Data Validation
   ↓
PostgreSQL Database
   ↓
SQL Analysis
   ↓
Business KPIs
   ↓
Power BI Dashboard
   ↓
Trend & Root Cause Analysis
   ↓
Business Insights
   ↓
Management Recommendations
```

The final analysis goes beyond simply reporting numbers by identifying **what changed, where it changed, why it likely changed, and what management should do next.**

---

## 👨‍💻 Skills Demonstrated

* SQL
* PostgreSQL
* Data Analysis
* Business Analysis
* KPI Development
* DAX
* Power BI
* Data Modeling
* Customer Analysis
* Product Analysis
* Sales Analysis
* Trend Analysis
* Root Cause Analysis
* Business Recommendations
* Data Visualization
* GitHub Portfolio Development

---

## 📌 Final Recommendation

The most important management priority is to **restore transaction volume**.

Management should investigate the severe order decline during 2020, with particular attention to the most affected markets and categories. At the same time, the company should protect its strongest revenue drivers, including Computers, the U.S. market and Online sales, while replicating successful practices from resilient markets.

## 👤 Author

**Haris Ali Paracha**

**Focus:** Business Analysis | Data Analytics | SQL | Power BI | DAX

---

## 📌 Project Type

**Portfolio Project — Business Analysis & Data Analytics**

**Status:** Completed ✅


**The analysis suggests that restoring order volume should be prioritized before attempting to increase Average Order Value.**

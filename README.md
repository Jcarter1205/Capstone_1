EmporiUm Capstone Project – Massachusetts Sales Analysis
Project Overview
This project analyzes sales data for EmporiUm, a fictional retail company, using SQL and Excel. My assigned sales territory was Massachusetts (MA).

The purpose of this project was to examine Massachusetts sales performance, identify revenue trends, compare the territory with the Northeast region, evaluate product category performance, and rank store revenue. The analysis was used to identify business opportunities and develop recommendations for the next quarter.
Tools & Technologies
- MySQL Workbench: Database exploration, SQL queries, and sales analysis.
- SQL: Filtering, joining, grouping, and summarizing sales data.
- Microsoft Excel: PivotTable and PivotChart creation and data visualization.
- GitHub: Project file storage and version control.
Data Source
The analysis used the sample_sales database, which included information from the following tables:
- online_sales
- store_sales
- store_locations
- products
- inventory_categories
- inventory_subcategories
- management
- shipper_list
I explored the database structure and used matching columns to connect related tables. Examples include:
- store_sales.Store_ID = store_locations.StoreId
- store_sales.Prod_Num = products.ProdNum
- products.Categoryid = inventory_categories.Categoryid
I used DESCRIBE statements to review table structures and identify the columns needed for my SQL joins. These are the logical relationships used in the analysis; formal foreign key constraints were not independently verified.
Business Questions & Key Findings
Q1: Total Massachusetts Revenue and Date Range
Business question: How much revenue did Massachusetts generate, and what was the date range of the sales?

I combined online and in-store sales using UNION ALL because Massachusetts had both sales channels. I used SUM() to calculate total revenue and MIN() and MAX() to identify the earliest and latest sales dates.

Findings:
- Total Massachusetts revenue: $9,832,788.26
- Date range: January 1, 2022 – December 31, 2025
Q2: Revenue by Year and Month
Business question: How did Massachusetts revenue change over time?

I combined online and in-store sales and grouped revenue by year and month. I exported the query results to CSV and used Excel to create a PivotTable and PivotChart.

Findings:
- Highest month: October 2025 – $629,751.75
- Lowest month: January 2022 – $73,618.50
- 2022 revenue: approximately $1.44 million
- 2025 revenue: approximately $4.54 million
The results show substantial revenue growth over the four-year period, along with differences in monthly sales performance.
Q3: Massachusetts vs. Northeast Revenue
Business question: How much does Massachusetts contribute to the Northeast region's total revenue?

I used the management table to identify Massachusetts as part of the Northeast region. I then compared Massachusetts revenue with total regional revenue.

Findings:
- Massachusetts revenue: $9,832,788.26
- Northeast revenue: $32,846,960.65
- Massachusetts share of Northeast revenue: 29.94%
Massachusetts contributes nearly 30% of the Northeast region's revenue, making it an important part of regional performance.
Q4: Monthly Transactions and Average Sales by Product Category
Business question: Which product categories had the most transactions and the highest average sale amounts?

I analyzed Massachusetts in-store sales by connecting store_sales, store_locations, products, and inventory_categories. I used INNER JOIN, COUNT(), and AVG() to examine monthly category performance.

Findings:
- Technology & Accessories: approximately 95–116 transactions per month
- Technology & Accessories average sale: approximately $405–$505
- Stationery & Supplies: approximately $9–$11 per sale
- Books (General): approximately 36–46 transactions per month
Technology & Accessories was the strongest category based on transaction count and average sale amount.

Scope: These findings represent Massachusetts in-store category performance, not combined online and in-store sales.
Q5: Massachusetts Store Revenue Ranking
Business question: Which Massachusetts stores generated the highest and lowest revenue?

I analyzed in-store sales by connecting store_sales with store_locations. I used SUM(), GROUP BY, and the RANK() window function to rank stores by total revenue.

Findings:
- Highest-performing store: Worcester – $602,183.44
- Lowest-performing store: Lowell – $266,982.83
The difference in store revenue provides an opportunity for management to investigate successful practices at Worcester and potential improvements at Lowell.

Scope: This ranking compares stores within Massachusetts only, not stores across the country.
Q6: Recommendation for the Next Quarter
Based on the analysis, I recommend that EmporiUm:
1. Learn from Worcester: Review its sales strategies and identify practices that could help improve performance at Lowell.
2. Promote Technology & Accessories: Consider targeted promotions for a category with strong in-store transaction counts and average sale amounts.
3. Monitor monthly sales trends: Use revenue patterns to plan promotions and inventory more effectively.
These recommendations focus on building on Massachusetts's contribution to regional revenue while identifying opportunities to improve store and product category performance.
Overall Business Takeaways
The analysis revealed three important findings:
- Massachusetts contributes 29.94% of Northeast revenue, making it a significant part of the region.
- Technology & Accessories is a strong-performing category in Massachusetts in-store sales.
- Worcester and Lowell have a noticeable difference in revenue, creating an opportunity to investigate store performance and identify ways to improve results.
Project Deliverables
The project includes:
- README.md – Project overview, analysis, findings, and recommendations.
- sample_sales_ERD.mwb – Entity Relationship Diagram created in MySQL Workbench.
- database_exploration.sql – SQL statements used to explore the database.
- Carter_sales_analysis.sql – SQL queries used to answer the six business questions.
- Carter_territory_chart.xlsx – Excel workbook containing the territory sales visualization.
Conclusion
This project demonstrated how SQL and Excel can be used to turn raw sales data into meaningful business insights. By exploring the database, connecting related tables, calculating revenue, identifying trends, and visualizing results, I was able to evaluate Massachusetts sales performance and develop recommendations to support future business decisions.

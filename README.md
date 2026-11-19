# Manufacturing Production MIS Dashboard (Power BI + MySQL)

An end-to-end Management Information System (MIS) project that analyses manufacturing production data for 2026. Raw data is explored with **MySQL**, and the findings are presented in a four-page, interactive **Power BI** dashboard covering production, quality, downtime, cost and energy.

---

## 1. Project Objectives

- Track production performance against plan (planned vs actual).
- Identify defect hotspots by product, line and shift.
- Understand what causes downtime and how much production time it costs.
- Measure material cost and energy efficiency per good unit.
- Compare supervisors and production lines to support management decisions.

---

## 2. Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL | Data storage, exploration and KPI queries (`SQL.sql`) |
| Power BI | Interactive dashboard (4 report pages), connected directly to the SQL database |
| DAX | KPI measures (achievement %, defect rate, cost per good unit, etc.) |

---

## 3. Dataset

- **Schema / Table:** `manufacturing_mis.manufacturing_production_mis_500_rows`
- **Size:** 500 production records, January–December 2026
- **Key columns:**
  - `Production_Date`, `Shift`, `Production_Line`, `Supervisor`
  - `Product_Name`
  - `Planned_Quantity`, `Actual_Quantity`, `Good_Quantity`, `Defect_Quantity`
  - `Downtime_Reason`, `Downtime_Minutes`
  - `Material_Cost_INR`, `Energy_Consumed_KWH`
  - `Raw_Material_Supplier`

**Dimensions covered**
- Products (8): Automotive Gear, Circuit Enclosure, Conveyor Pulley, Packaging Roller, Plastic Housing, Pump Impeller, Steel Bracket, Valve Body
- Production lines (4): Line A, B, C, D
- Shifts (3): Morning, Evening, Night
- Supervisors (5): P. Kulkarni, M. Shaikh, A. Patil, R. Sharma, S. Jadhav

---

## 4. Repository Contents

```
├── SQL.sql                         # 15 analysis queries (MySQL)
├── Production__overview_.jpg       # Dashboard page 1
├── Quality___Downtime_Analysis.jpg # Dashboard page 2
├── Cost___Energy_Analysis_.jpg     # Dashboard page 3
├── Management_Insights.jpg         # Dashboard page 4
└── README.md
```

---

## 5. SQL Analysis (SQL.sql)

The script first checks the table structure and server details, then answers 15 business questions:

| # | Question |
|---|----------|
| Q1 | Total production |
| Q2 | Total defects |
| Q3 | Production by product (plus planned / good / defect comparison) |
| Q4 | Production by line |
| Q5 | Shift-wise production |
| Q6 | Production achievement % |
| Q7 | Product-wise defect rate |
| Q8 | Downtime by reason |
| Q9 | Monthly production |
| Q10 | Supervisor ranking (`RANK()` window function) |
| Q11 | Top 3 products |
| Q12 | Cost per good unit by product |
| Q13 | Energy consumption by line |
| Q14 | Records where production was below target |
| Q15 | Supplier-wise material cost |

SQL concepts used: aggregation (`SUM`), `GROUP BY`, `ORDER BY`, `LIMIT`, `ROUND`, `MONTH()`, window function `RANK() OVER()`, filtering with `WHERE`.

---

## 6. Dashboard Pages

All pages include slicers for **Date, Production Line, Shift and Product Name**.

### Page 1 – Manufacturing Production Overview
- KPIs: Total Planned (312K), Total Actual (292K), Achievement (93.63%), Defect Rate (3.30%), Total Material Cost (₹29.43M)
- Visuals: line-wise production, product-wise production, planned vs actual by line, shift distribution, monthly planned vs actual trend

### Page 2 – Quality & Downtime Analysis
- KPIs: Total Planned, Total Defects (9,621), Defect Rate (3.30%), Good Production (96.70%), Downtime (16K minutes)
- Visuals: downtime distribution by reason, defects by product, defects by line, daily defect trend, downtime minutes by line

### Page 3 – Cost & Energy Efficiency Analysis
- KPIs: Total Material Cost (₹29.43M), Total Material Used (276.85K), Total Energy (95.01K kWh), Energy per Good Unit (0.34), Material Cost per Good Unit (₹104.26)
- Visuals: material cost by product, energy consumption by line, daily material consumption trend, product-wise cost & resource table

### Page 4 – Management Insights
- KPIs: Production Achievement (93.63%), Total Material Used, Defect Rate, Total Downtime Hours (274.12), Cost per Good Unit (₹104.26)
- Visuals: production line performance, downtime reasons, supervisor-wise performance, product-wise defect rate
- Key problem callouts: low production achievement, high defect rate, high machine downtime

---

## 7. Key KPIs

| KPI | Value |
|-----|-------|
| Total Planned Quantity | ~311,761 |
| Total Actual Quantity | 291,897 |
| Production Achievement | 93.63% |
| Total Defects | 9,621 |
| Defect Rate | 3.30% |
| Good Production | 96.70% |
| Total Downtime | ~16K minutes (274.12 hours) |
| Total Material Cost | ₹29.43M |
| Material Cost per Good Unit | ₹104.26 |
| Total Energy Consumed | 95.01K kWh |
| Energy per Good Unit | 0.34 kWh |

---

## 8. Key Insights

**Production**
- Actual output is about 6.4% below plan; every line misses its target.
- Line B has the best achievement (94.06%); Line D the lowest (93.17%).
- Morning shift contributes the most output (36.77%), followed by Night (33.6%) and Evening (29.62%).
- Valve Body and Automotive Gear are the highest-volume products; Conveyor Pulley is the lowest.

**Quality**
- Automotive Gear has the highest defect count (1,562), while Conveyor Pulley has the highest defect rate (4.0%).
- Pump Impeller (2.6%) and Steel Bracket (2.8%) have the lowest defect rates.
- Defects are spread fairly evenly across lines, so the issue is process-wide rather than tied to one line.

**Downtime**
- Downtime is spread across reasons: Machine Breakdown (~21%), Material Shortage (~20%), Quality Check (~20%), Tool Change (~20%) and Power Interruption (~18%).
- Machine Breakdown is the largest single cause; Line D and Line B record the most downtime minutes.

**Cost & Energy**
- Packaging Roller has the highest material cost (₹4.5M) and cost per good unit (₹115.66); Pump Impeller is the most cost-efficient (₹89.73).
- Line D uses the most energy (26.21%) and Line C the least (23.12%).

**Supervisors**
- R. Sharma has the highest output (70,828) but also the most downtime hours (66.12).
- M. Shaikh has the best production achievement (96%).

---

## 9. Recommendations

1. **Reduce machine downtime** with preventive maintenance and a spare-parts plan, starting with Lines D and B.
2. **Fix material shortages** by reviewing supplier lead times and safety stock (use Q15 supplier cost data).
3. **Target high-defect products** (Conveyor Pulley, Automotive Gear, Packaging Roller) with process and tooling reviews.
4. **Shorten tool-change and quality-check time** using standard changeover procedures.
5. **Review Packaging Roller costing** and apply Pump Impeller best practices where possible.
6. **Share best practices** from top-achieving supervisors and lines.

---

## 10. Data Connection (SQL → Power BI)

Power BI is connected directly to the SQL database, so the dashboard reads from the same table that the SQL queries analyse. This keeps the SQL results and the dashboard KPIs consistent.

- **Source:** `manufacturing_mis.manufacturing_production_mis_500_rows`
- **Connection steps in Power BI Desktop:**
  1. Home → Get Data → select your database connector (MySQL database).
  2. Enter the server name (and port) and the database name `manufacturing_mis`.
  3. Choose the credentials (Database) and sign in.
  4. Select the `manufacturing_production_mis_500_rows` table and click Load (Import mode) or Transform Data to clean it first.
- **Refresh:** Use Home → Refresh to pull new data from the database. For scheduled refresh in Power BI Service, install an on-premises data gateway.

---

## 11. How to Reproduce

1. Load the dataset into the database as `manufacturing_mis.manufacturing_production_mis_500_rows`.
2. Run `SQL.sql` in MySQL Workbench to verify KPIs.
3. Connect Power BI Desktop to the database (see Section 10).
4. Create the DAX measures (Achievement %, Defect Rate %, Good Production %, Cost per Good Unit, Energy per Good Unit, Downtime Hours) and build the four report pages.

---

## 12. Notes

- Dashboard figures were read from the report screenshots; SQL results should match when run on the same data.
- The "Downtime Reasons" chart on the Management Insights page is labelled in hours, but its values look like record counts per reason. Verify the measure if you reuse it.
- Currency is Indian Rupees (INR).

---

## 13. Author

*Your Name* – Data Analyst | *your-email@example.com* | *LinkedIn / GitHub link*

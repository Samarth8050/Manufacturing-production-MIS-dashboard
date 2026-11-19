SELECT * FROM manufacturing_mis.manufacturing_production_mis_500_rows;

DESCRIBE manufacturing_mis.manufacturing_production_mis_500_rows;

SELECT
    VERSION() AS MySQL_Version,
    @@hostname AS Server_Hostname,
    @@port AS Server_Port,
    USER() AS Connected_User;
    
-- Q1. Total production     
select sum(Actual_Quantity) as Total_Production from manufacturing_mis.manufacturing_production_mis_500_rows;

-- Q2. Total defects
select sum(Defect_Quantity) as Total_Defects from manufacturing_mis.manufacturing_production_mis_500_rows;

-- Q3. Production by product
select Product_Name,sum(Actual_Quantity) as Production from manufacturing_mis.manufacturing_production_mis_500_rows group by Product_Name;

select Product_Name,
sum(Planned_Quantity) as Planned,
sum(Actual_Quantity) as Production,
sum(Good_Quantity) as good_Quality,
sum(Defect_Quantity) as defect 
from manufacturing_mis.manufacturing_production_mis_500_rows group by Product_Name;

-- Q4. Production by line
select Production_Line,sum(Actual_Quantity) as Production from manufacturing_mis.manufacturing_production_mis_500_rows group by Production_Line;

-- Q5. Shift-wise production
select Shift,sum(Actual_Quantity) as Production from manufacturing_mis.manufacturing_production_mis_500_rows group by Shift;

-- Q6. Production achievement
SELECT ROUND(SUM(Actual_Quantity)*100/SUM(Planned_Quantity),2)
AS Achievement_Percentage
FROM manufacturing_mis.manufacturing_production_mis_500_rows;

-- Q7. Product-wise defect rate
SELECT Product_Name,
ROUND(SUM(Defect_Quantity)*100/SUM(Actual_Quantity),2) AS Defect_Rate
FROM manufacturing_mis.manufacturing_production_mis_500_rows
GROUP BY Product_Name
ORDER BY Defect_Rate DESC;

-- Q8. Downtime by reason
select Downtime_Reason,sum(Downtime_Minutes) as downtime from manufacturing_mis.manufacturing_production_mis_500_rows group by Downtime_Reason order by Downtime desc;

-- Q9. Monthly production
select month(Production_Date) as monthh, sum(Actual_Quantity) as Production from manufacturing_mis.manufacturing_production_mis_500_rows group by monthh;

-- Q10. Supervisor ranking
SELECT Supervisor, SUM(Actual_Quantity) AS Production,
RANK() OVER(ORDER BY SUM(Actual_Quantity) DESC) AS Ranking
FROM manufacturing_mis.manufacturing_production_mis_500_rows
GROUP BY Supervisor;

-- Q11. Top 3 products
select Product_Name, sum(Actual_Quantity) as Production
from manufacturing_mis.manufacturing_production_mis_500_rows 
group by Product_Name
order by Production desc
limit 3;

-- Q12. Cost per good unit
SELECT Product_Name,
ROUND(SUM(Material_Cost_INR)/SUM(Good_Quantity),2) AS Cost_Per_Unit
FROM manufacturing_mis.manufacturing_production_mis_500_rows
GROUP BY Product_Name;

-- Q13. Energy consumption by line
SELECT Production_Line, SUM(Energy_Consumed_KWH) AS Energy
FROM manufacturing_mis.manufacturing_production_mis_500_rows
GROUP BY Production_Line;

-- Q14. Production below target
SELECT *
FROM manufacturing_mis.manufacturing_production_mis_500_rows
WHERE Actual_Quantity < Planned_Quantity;

-- Q15. Supplier-wise material cost
SELECT Raw_Material_Supplier, SUM(Material_Cost_INR) AS Total_Cost
FROM manufacturing_mis.manufacturing_production_mis_500_rows
GROUP BY Raw_Material_Supplier
ORDER BY Total_Cost DESC;
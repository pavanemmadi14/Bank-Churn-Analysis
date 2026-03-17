Create database Bank_Project;
Use Bank_Project;
create table bank_churn(
CustomerId BIGINT PRIMARY KEY,
Surname varchar(50),
CreditScore INT,
Geography Varchar(50),
Gender Varchar(10),
Age INT,
Tenure INT,
Balance Decimal(15,2),
NumOfProducts INT,
HasCrCard TINYINT,
IsActiveMember TINYINT,
EstimatedSalary Decimal(15,2),
Exited TINYINT
)
;
desc bank_churn;

-- Loading data 
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bank_Churn.csv"
INTO TABLE bank_churn
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM bank_churn;

SELECT COUNT(*) FROM bank_churn;

-- Checking NULL Values : There are no null values found
SELECT * FROM bank_churn
WHERE CustomerId IS NULL;

-- Checking duplicates : there no duplicates found 
SELECT CustomerId, count(*) FROM Bank_churn
Group by CustomerId 
Having count(*)>1;

-- Ensure each column has correct data type 
desc bank_churn;

-- Checking Outliers or Summary Statistics
Select max(Age), min(Age), avg(Age) From bank_churn;
Select max(Tenure), min(Tenure), avg(Tenure) From bank_churn;
Select max(Balance), min(Balance), avg(Balance) From bank_churn;
Select max(EstimatedSalary), min(EstimatedSalary), avg(EstimatedSalary) From bank_churn;


-- Standardizing catgorical coulumns
SELECT DISTINCT Gender From bank_churn;
SELECT DISTINCT Geography FROM bank_churn;

-- 1.Customers distribustion based on exit and non exit 
SELECT Exited,Count(*) 
FROM bank_churn
GROUP BY Exited; 

-- 2.How many total customers are in the dataset?
SELECT COUNT(*) as "Total Customers" from bank_churn;

-- 3.How many customers have churned vs not churned?
Select Count(Case When Exited = 0 Then 1 End) as "Not Churned Customers",
	   Count(Case When Exited = 1 Then 1 End) as "Churned Customers",
       Count(*) as "Total Customers"
From bank_churn;

-- 4. what is the churn rate of customers
SELECT ROUND(AVG(Exited)*100,2) AS churn_rate
FROM bank_churn;

-- 5. what is the average account balance of all customers
SELECT AVG(Balance) AS "Average Account Balance"
FROM bank_churn;

-- 6. What is the average credit score of customers
SELECT Round(AVG(CreditScore)) AS "Average Credit Score"
FROM bank_churn;

-- 7.What is the average age of customers 
SELECT Round(avg(Age)) as "Average Age"
FROM bank_churn;

-- 8. What is the average tenure of customers with the bank
SELECT round(avg(Tenure)) as "Average Tenure"
FROM bank_churn;

-- 9. What is average credit score of churned vs non churned customers
SELECT Exited, Round(AVG(CreditScore)) 
FROM bank_churn
group by Exited;

-- 10. what is the average balance of churned vs non churned
SELECT 
   Round(avg(case when Exited =1 then Balance end)) as "Churned Customer Avg balance",
   Round(avg(case when Exited =0 then Balance end)) as "Non churned Customer Avg balance"
from bank_churn;

-- 11. what average age of churned vs non churned customers
SELECT 
   Round(avg(case when Exited =1 then Age end)) As "Avg age of churned customers",
   Round(avg(case when Exited =0 then Age end)) as "Avg age of Non churned Customer"
FROM bank_churn;

-- 12. what is the average tenure of churned vs non churned customers
SELECT 
   Round(avg(case when Exited =1 then Tenure end)) As "Avg Tenure of churned customers",
   Round(avg(case when Exited =0 then Tenure end)) as "Avg Tenure of Non churned Customer"
FROM bank_churn;

-- 13. which group has more products churned vs non churned
SELECT 
  sum(case when Exited = 1 then NumOfProducts end) as "No of products of churndes customers",
  sum(case when Exited= 0 then NumOfProducts end) as "No of products of non churned customers"
FROM bank_churn;

-- 14. Do customers with high balances churn more frequently?
SELECT
  CASE when balance < 50000 Then "Low balance"
	   when balance between 50000 AND 100000 THEN "Medium balance"
       else "High balance" End AS BalanceCategory,
  count(*) as "Total customers",
  sum(Exited) as "Churned customers",
  Round(avg(Exited)*100,2) as "Churn rate"
  From bank_churn
  group by BalanceCategory;
  
-- 15. Do older customers churn more than younger customers? yes
SELECT 
  CASE WHEN Age<30 then "Young"
	   When Age Between 30 and 50 then "Middle Age"
	   When Age >50 then "Older" end as AgeCategory,
  count(*) as "Total Customers",
  sum(Exited) as "Churned Customers",
  Round(avg(Exited)*100.0,2) as "Churn Rate"
  From bank_churn
  Group by AgeCategory;
  
-- 16.Which country has the highest number of customers?
Select Geography, count(*) as TotalNoOfCustomers
From bank_churn
Group by Geography
order by TotalNoOfCustomers desc;

-- 17. Which country has the highest churn rate?
Select Geography, Round(avg(Exited)*100,2) as ChurnRate
From bank_churn
Group by Geography
order by ChurnRate desc
limit 1;

-- 18 churn rate for each country
Select Geography, Round(avg(Exited)*100,2) as ChurnRate
From bank_churn
Group by Geography
order by ChurnRate desc;

-- 19. Which country has the highest average balance?
select Geography, avg(balance) as AvgBalance
from bank_churn
Group by Geography
order by AvgBalance desc
limit 1;

-- 20. avg balance across all countries
select Geography, avg(balance) as AvgBalance
from bank_churn
Group by Geography
order by AvgBalance desc;

-- 21. Which country has the highest average credit score?
Select Geography, Round(avg(CreditScore)) as AvgCreditScore
from bank_churn
Group by Geography
order by AvgCreditScore desc; 

-- 22. What is the average age of customers by geography?
select Geography, Round(avg(Age)) as AvgAge
from bank_churn
group by Geography;

-- 23. Which geography has customers with the longest tenure?
select Geography, Max(Tenure) as LogestTenure
from bank_churn
group by Geography
order by LogestTenure;

-- 24. What is the gender distribution of customers?
select Gender, count(*) as Count
from bank_churn
group by Gender;

-- 25. What is the churn rate by gender?
select Gender, Round(avg(Exited)*100.0,2) as ChurnRate
from bank_churn
Group by Gender;

-- 26. What is the average balance for male vs female customers?
select Gender, Round(avg(Balance),2) as AvgBalance
from bank_churn
Group by Gender;

-- 27. Which age group has the highest average balance?
With AgeBalance as (
select case when Age<30  then "Young"
	   when Age Between 30 and 50 then "Middle Aged"
       else "Older" end as AgeCategory,
  Round(Avg(Balance),2) as AvgBalance
  From bank_churn
  Group by AgeCategory
)
select * from AgeBalance
  order by AvgBalance desc;
  
-- 28. Which age group stays longest with the bank?
With AgeTenure as (
select case when Age<30  then "Young"
	   when Age Between 30 and 50 then "Middle Aged"
       else "Older" end as AgeCategory,
  Round(Avg(Tenure)) as Avgtenure 
  From bank_churn
  Group by AgeCategory
)
select * from AgeTenure
order by Avgtenure Desc;

-- 29 Do customers with more products churn less?
select NumOfProducts, Count(*) as Total_Customers,
Sum(case when Exited = 1 then 1 else 0 end) as Churned_Customers,
Round(avg(Exited)*100,2) as Churn_Rate
from bank_churn
group by NumOfProducts
order by NumOfProducts desc;

-- 30. Do customers with credit cards churn less?
with cust_credit as(
select count(*) as Total_customers,HasCrCard,
Sum(case when Exited = 1 then 1 else 0 end) as Churned_Customers,
Round(Avg(Exited)*100,2) as Churn_Rate
from bank_churn
group by HasCrCard)
select 
case when HasCrCard = 1 then "Has Credit Card" 
	 else "No Credit Card" end as CriditCard_Status,
	Total_Customers,
    Churned_Customers,
    Churn_Rate
from  cust_credit;


-- 31. Do active members churn less than inactive members?

with cust_act as(
select count(*) as Total_customers, IsActiveMember,
Sum(case when Exited =1 then 1 else 0 end) as Churned_Customers,
Round(Avg(Exited)*100,2) as Churn_Rate
from bank_churn
group by IsActiveMember)
select
Case when IsActiveMember = 1 then "Active Member"
 Else "In Active Member" end as Isactivemember_status,
Total_Customers,
Churned_Customers,
Churn_Rate
from cust_act;

-- 32. What percentage of churners are inactive members?
with cust_act as(
select count(*) as Total_customers, IsActiveMember,
Sum(case when Exited =1 then 1 else 0 end) as Churned_Customers,
Round(Avg(Exited)*100,2) as Churn_Rate
from bank_churn
group by IsActiveMember)
select
Case when IsActiveMember = 1 then "Active Member"
 Else "InActive Member" end as Isactivemember_status,
Total_Customers,
Churned_Customers,
Churn_Rate
from cust_act
where IsActiveMember = 0;

-- 33. What is the average balance of churners by geography?
with churgeo as (
select avg(Balance) as Avg_Balance, Geography,
Count(*) as Churned_Customers
from bank_churn
where Exited = 1
group by Geography
),
totalgeo as ( 
select Geography, count(*) as Total_Customers
from bank_churn
group by Geography
)
select Avg_Balance, churgeo.Geography, Total_Customers, Churned_Customers
from churgeo
Join totalgeo
on totalgeo.Geography = churgeo.Geography;

-- 34. Do customers with zero balance churn more?
with zerochur as (
select Balance, 
Count(*) as Total_Customers,
Sum(case when Exited =1 then 1 else 0 end) as Churned_Customers,
Round(Avg(Exited)*100,2) as Churn_Rate
from bank_churn
where Balance = 0
)
select * from zerochur;

-- 35. What is the average estimated salary of churned customers?
with avgsal as (
select avg(EstimatedSalary) as Avg_Estimated_Salary
from bank_churn
where Exited = 1
)
select * from avgsal;

-- 36. Is there a relationship between salary and churn?
select Exited, Round(Avg(EstimatedSalary),0) as Avg_Estimated_Salary-- 
from bank_churn
group by Exited;
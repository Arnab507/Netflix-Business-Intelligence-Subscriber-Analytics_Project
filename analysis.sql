use netflix_db;
select *from netflix_titles;

select * from churn ;

select * from userbase;

# Q1 total revernue 
select sum(Monthly_Revenue) from userbase;

#Q2 revenue by contry
select country,sum(Monthly_Revenue) as Total_Revenue from userbase group by country order by Total_Revenue desc;

#Q3 revenue by subscription
select Subscription_Type , sum(Monthly_Revenue) as Total_Revenue from userbase group by Subscription_Type order by Total_Revenue desc;

#Q4 subscribe by device
select Device,count(*) as Total_count from userbase group by device;

#Q5 subscribe by gender
select Gender,count(*) as Total_count from userbase group by Gender;

#Q6 subscribe by age group
select Age_Group, count(*) as Total_count from userbase group by Age_Group;

#Q7 total movies and total tv show
select Type, count(*) as Total_count from netflix_titles group by Type;

#Q8 content watch by country
select Country,count(*) as Total_count from netflix_titles group by Country order by Total_count desc;

#Q9 average revenue per user
select avg(Monthly_Revenue) as avg_revenue from userbase;

#Q10 top 5 country by users 
select Country,count(*) as Total_users from userbase group by Country order by Total_users desc limit 5;

#Q11 top country producing content
select Country, count(*) as Total_shows from netflix_titles where Country is not null group by Country order by Total_shows desc limit 10;

#Q12 TV Shows with more than 5 seasons
select * from netflix_titles where Type='TV Show' and Duration like '%Season%';

#Q13 Overall Churn Rate
select round(sum(case when Churn_Status='Yes' then 1 else 0 end)*100.0/count(*),2) as Churn_rate from churn;

#Q14 churn by subsciption type
select Subscription_Plan, count(*) as Total_customers, 
sum(case when Churn_Status='Yes' then 1 else 0 end) as Churned 
from churn group by Subscription_Plan;

#Q15 top region with highest churn 
select Region , count(*) as Churned_Customer from churn where Churn_Status='Yes' 
group by Region order by Churned_Customer desc;

#Q16 rank countries by revenue
select Country, sum(Monthly_Revenue) as Total_Revenue , 
rank() over(order by sum(Monthly_Revenue) desc)
as Revenue_Rank from userbase group by Country;

#Q17 top revenue user in each country
with RankedUsers as (select Country,User_ID, Monthly_Revenue, 
row_number() over(partition by Country order by Monthly_Revenue desc) as Ranking from userbase) 
select * from RankedUsers where Ranking=1;

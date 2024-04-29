select * from credit;

-- rename the column

alter table credit 
rename column GENDER to Gender;

alter table credit
rename column CHILDREN to Children;

alter table credit
rename column EDUCATION to Education;

alter table credit 
rename column Type_Income to Income_type;

select * from credit;

-- deleting the columns which are not necessary for analysis

alter table credit
drop column Birthday_count;

alter table credit 
drop column Employed_days;

-- updation the value in education

update credit
set Education = (
case when Education = 'Secondary / secondary special' then 'Secondary education'
else Education end);


-- 1. Group the customers based on their income type and find the average of their annual income.

select Income_type,avg(annual_income) as Avg_income from credit
group by Income_type
order by 2 desc;
-- commerical associate were highest in terms of avg income and the lowest was the pensioner who are not working as they are retired. 

-- 2. Find the female owners of cars and property.

select * from credit;
select 
    SUM(CASE WHEN Gender = 'F' AND car_owner = 'Y' AND property_owner = 'N'THEN 1 ELSE 0 END) AS female_car_owners,
    SUM(CASE WHEN Gender = 'F' AND property_owner = 'Y' AND car_owner = 'N' THEN 1 ELSE 0 END) AS female_property_owners,
    SUM(CASE WHEN Gender = 'F' AND property_owner = 'Y' AND car_owner = 'Y' THEN 1 ELSE 0 END) AS female_car_property_owners
from credit;

-- we can see that more number of females are owning properties,
-- and over 172 members owns both car and property then only 62 members owns only car.

-- 3. Find the male customers who are staying with their families.

select count(Ind_ID) as male_customers from credit
where Gender = 'M' and Family_members > 0;

-- we can see over 549 customers stay with there families.

-- 4. Please list the top five people having the highest income.

select Ind_ID, Annual_income from credit
group by Ind_ID
order by Annual_income desc
limit 5;

-- customer with highest Annual income of about 15,75,000 

-- 5. How many married people are having bad credit?

select Education,count(*) as customers from credit c
inner join test_data t on t.Ind_ID = c.Ind_ID
where Marital_status = 'Married' and Approval = 0
group by Education 
order by 2 desc;
-- Total of 908 married customers having bad credit and most of them are from seconary education follwed by higher education.

-- 6. Between married males and females, who is having more bad credit? 

select Education,
    SUM(CASE WHEN Gender = 'M' AND Marital_status = 'Married' AND Approval = 0 THEN 1 ELSE 0 END) AS Male_customers,
    SUM(CASE WHEN Gender = 'F' AND Marital_status = 'Married' AND Approval = 0 THEN 1 ELSE 0 END) AS Female_customers
from credit c 
inner join test_data t
on t.Ind_ID = c.Ind_ID
group by Education;
-- Most of females have bad credit comapre to males and most of the females and males from secondary education and O from graduation.

-- 7. What is the highest education level and what is the total count?

select Education ,count(*) as customers from credit
group by Education
order by 2 desc;

-- Most customers applying loan are from secondary education who are completed 10 th class,
-- then followed by higher education of 10+2 class students are about of 414 applicants.
-- There are only 2 customers from academic degree which means that the students of below 10 th class to upto intermediate are applying for loans.

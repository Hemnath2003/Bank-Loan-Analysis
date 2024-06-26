use bank;
select * from bank_csv;

select count(id) as Total_loan_application from bank_csv;

select count(id) as MTD_total_loan_application from bank_csv
where month(issue_date)=12 and year(issue_date)=2021 ;

-- Previous month
select count(id) as PMTD_total_loan_application from bank_csv
where month(issue_date)=11 and year(issue_date)=2021 ;

select sum(loan_amount) as Total_funded_amount from bank_csv;

select sum(loan_amount) as MTD_Total_funded_amount from bank_csv
where month(issue_date)=12 and year(issue_date)=2021;

select sum(loan_amount) as PMTD_Total_funded_amount from bank_csv
where month(issue_date)=11 and year(issue_date)=2021;

select sum(total_payment) as Total_amount_recived from bank_csv;

select sum(total_payment) as MTD_Total_amount_recived from bank_csv
where month(issue_date)=12 and year(issue_date)=2021;

select sum(total_payment) as PMTD_Total_amount_recived from bank_csv
where month(issue_date)=11 and year(issue_date)=2021;

select round(avg(int_rate),4)*100 as average_interest_rate from bank_csv;

select round(avg(int_rate),4)*100 as MTD_average_interest_rate from bank_csv
where month(issue_date)=12 and year(issue_date)=2021;

select round(avg(int_rate),4)*100 as PMTD_average_interest_rate from bank_csv
where month(issue_date)=11 and year(issue_date)=2021;

select round(avg(dti),4)*100 as Average_dti from bank_csv;

select round(avg(dti),4)*100 as MTD_Average_dti from bank_csv
where month(issue_date)=12 and year(issue_date)=2021;

select round(avg(dti),4)*100 as PMTD_Average_dti from bank_csv
where month(issue_date)=11 and year(issue_date)=2021;

-- Good loan vs Bad loan KPI's
select loan_status from bank_csv;

select
	(count(case when loan_status='Fully Paid' or loan_status='Current' then id end)*100)
    /
    count(id) as Good_loan_percentage
from bank_csv;

select count(id) as Good_loan_applications from bank_csv 
where loan_status='Fully paid' or loan_status='Current'; -- (or) in('Fully paid' ,'Current');

select sum(loan_amount) as Good_loan_funded_amount from bank_csv 
where loan_status='Fully paid' or loan_status='Current'; 

select sum(total_payment) as Good_loan_total_payment from bank_csv 
where loan_status='Fully paid' or loan_status='Current'; 

select (count( case when loan_status ='Charged off' then id end)*100)
/
count(id) as Bad_loan_percentage from bank_csv;

select count(id) as Bad_loan_application from bank_csv 
where loan_status='Charged off';

select sum(loan_amount) as Bad_loan_funded_amount from bank_csv 
where loan_status='Charged off';

select sum(total_payment) as Bad_loan_amount_recieved from bank_csv 
where loan_status='Charged off';

select 
       loan_status,
       count(id) as Total_loan_applications,
       sum(total_payment) as Total_amount_recieved,
       sum(loan_amount)as Total_funded_amount,
       avg(int_rate*100) as Interest_rate,
       avg(dti*100) as DTI
	from
	   bank_csv
	group by
       loan_status;
       
select 
       loan_status,
       sum(total_payment) as MTD_Total_amount_recieved,
       sum(loan_amount)as MTD_Total_funded_amount
	from bank_csv
    where month(issue_date)=12
    group by
       loan_status;
       
select
	month(issue_date) as Month_number,
    date_format(issue_date,'%M') as Month_name,
    count(id) as Total_loan_application,
    sum(loan_amount) as Total_funded_amount,
    sum(total_payment) as Total_recieved_amnount
from bank_csv
group by Month_number,Month_name
order by Month_name;

select
	address_state,
    count(id) as Total_loan_application,
    sum(loan_amount) as Total_funded_amount,
    sum(total_payment) as Total_recieved_amnount
from bank_csv
group by address_state
order by address_state;

select
	term,
    count(id) as Total_loan_application,
    sum(loan_amount) as Total_funded_amount,
    sum(total_payment) as Total_recieved_amnount
from bank_csv
group by term
order by term;

select
	emp_length,
    count(id) as Total_loan_application,
    sum(loan_amount) as Total_funded_amount,
    sum(total_payment) as Total_recieved_amnount
from bank_csv
group by emp_length
order by emp_length;

select
	purpose,
    count(id) as Total_loan_application,
    sum(loan_amount) as Total_funded_amount,
    sum(total_payment) as Total_recieved_amnount
from bank_csv
group by purpose
order by count(id);

select
	home_ownership,
    count(id) as Total_loan_application,
    sum(loan_amount) as Total_funded_amount,
    sum(total_payment) as Total_recieved_amnount
from bank_csv
group by home_ownership
order by count(id);
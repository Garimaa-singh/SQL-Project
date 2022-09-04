SELECT * FROM bank_data.loan;

/* how many loan for duration 24 in each year  */
select year,purpose,duration,count(*) from bank_data.loan 
where duration=24
group by year;


/* how many loan for car in each year */
select loan_id,purpose,amount,year,count(*) from bank_data.loan
where purpose='car'
group by 4;


/* want to know account_id in 5th month who has taken car loan */
select * from bank_data.loan
where month=5 and purpose='home'
group by account_id;

/* top 10 account_id-1st method */
select max(amount),year,purpose,account_id,loan_id
from bank_data.loan
group by account_id
order by max(amount) desc
limit 10;

/* 2nd method */
select * from
(select amount,year,purpose,account_id,loan_id,
Rank()over(order by amount desc)as max_amount
from bank_data.loan)as a
where a.max_amount <=10;

/* all loans in 2018 */
select amount,year,purpose,account_id,loan_id,month
from bank_data.loan
where year=2018
order by month;

/* maximum loan type in both years*/
select max(purpose),year,count(*),loan_id,duration
from bank_data.loan
group by year;

 /*maximum duration loan */
select max(duration),purpose
from bank_data.loan
group by purpose;

/* total loan duration by each month and year */
select purpose,duration,year,month from bank_data.loan where 
(select sum(duration) from bank_data.loan
order by year desc);

/* home loan with A status and payment more than 1000 */
select * from bank_data.loan
where status='a' and payments >1000 and purpose='home';

/* unique loanid with status c for each year */
select distinct (loan_id),day,purpose,status,year
from bank_data.loan
where day=28 and status='c';

/* maximum amount for which loan and what is the duration of that loan and in which year*/
/* 1st method */

select max(amount),purpose,duration,year
group by 3
order by 1 desc;

/* 2nd method */
select amount,purpose,duration,year,
rank()over( partition by year order by amount desc)as max_loan
from bank_data.loan;

/* loan is maximum in which month of year */

select purpose,year,month,duration,count(*) as max_loan
from bank_data.loan
group by 1,2
order by 5 desc;

/* top 5 transaction for home loan */

select l.purpose,l.amount,t.bank,l.year from bank_data.loan as l
 join bank_data.trans as t
on l.account_id=t.account_id
where purpose='home'
order by 2 desc
limit 5;

/* how many type of loan transaction */

select type, trans_id,bank,count(*),purpose
from bank_data.trans
join bank_data.loan
group by purpose;

/* how many amount is credi by cash for car loan in each year */

select payment,operation,type,bank,year,amount
from bank_data.trans
where operation="credit in cash" and payment="car loan";

/* how many amount is withdraw from jpmorgan chase in both year and for what purpose */

select bank,sum(amount),operation,year,payment
from bank_data.trans
where bank="jpmorgan chase" and operation="cash withdrawal"
group by payment;
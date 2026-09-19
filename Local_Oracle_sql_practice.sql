

create table customer(
customer_id number not null primary key,
customer_name varchar2(20) not null,
phone number(12),
city varchar2(30));


create table branch(
branch_id number not null primary key,
branch_name varchar2(20) not null,
city varchar2(20));


create table account(
account_id number not null primary key,
customer_id number not null,
branch_id number not null,
account_type varchar(20) check (account_type in ('Savings','Current')),
balance number(10,2) default 0 check(balance >=0),
opening_date date default SYSDATE,
constraint fk_branch foreign key (branch_id) references branch(branch_id),
constraint fk_cust_id foreign key (customer_id) references customer(customer_id));


create table employee(
employee_id number not null primary key,
employee_name varchar2(20) not null,
branch_id number not null,
designation varchar2(10),
salary number(8,2) default 0 check(salary > 0),
constraint fk_branch_empl foreign key (branch_id) references branch(branch_id));


create table bank_transaction(
transaction_id number primary key,
account_id number not null,
transaction_type varchar(20) check(transaction_type in ('Deposit','Withdrawl')),
amount number(10,2) check(amount > 0),
transaction_date date default sysdate,
constraint fk_trans_acc foreign key (account_id) references account(account_id)
);


select * from customer;
alter table customer add email varchar2(30);

insert into customer values(1,'test_user',000000,'chennai','test@gmail.com');

update customer
set phone = 1111111
where customer_id = 1;

delete from customer where customer_id = 1;

insert into customer values(1,'test_user_again',0067880,'chennai','test@gmail.com');

savepoint test_user;

insert into customer values(2,'who knows',00986756,'god knows','useles@gmail.com');

select * from customer;
rollback to test_user;




-- ==========================================
-- 1. INSERT DATA INTO BRANCH (3 Branches)
-- ==========================================
INSERT INTO branch (branch_id, branch_name, city) VALUES
(1, 'Downtown Main', 'New York'),
(2, 'Westside Hub', 'Los Angeles'),
(3, 'Metro Center', 'Chicago');

-- ==========================================
-- 2. INSERT DATA INTO CUSTOMER (10 Customers)
-- ==========================================
INSERT INTO customer (customer_id, customer_name, phone, email, city) VALUES
(101, 'Alice Smith', 5550101, 'alice@email.com', 'New York'),
(102, 'Bob Jones', 5550102, 'bob@email.com', 'New York'),
(103, 'Charlie Brown', 5550103, 'charlie@email.com', 'Los Angeles'),
(104, 'Diana Prince', 5550104, 'diana@email.com', 'Los Angeles'),
(105, 'Evan Wright', 5550105, 'evan@email.com', 'Chicago'),
(106, 'Fiona Gallagher', 5550106, 'fiona@email.com', 'Chicago'),
(107, 'George Clark', 5550107, 'george@email.com', 'New York'),
(108, 'Hannah Abbott', 5550108, 'hannah@email.com', 'Boston'),
(109, 'Ian Malcolm', 5550109, 'ian@email.com', 'Austin'),
(110, 'Julia Roberts', 5550110, 'julia@email.com', 'San Francisco');

-- ==========================================
-- 3. INSERT DATA INTO ACCOUNT (10 Accounts)
-- Matches your check constraints: 'Savings' or 'Current'
-- ==========================================
INSERT INTO account (account_id, customer_id, branch_id, account_type, balance, opening_date) VALUES
(5001, 101, 1, 'Savings', 5000.00, TO_DATE('2025-01-15', 'YYYY-MM-DD')),
(5002, 102, 1, 'Current', 1500.50, TO_DATE('2025-01-20', 'YYYY-MM-DD')),
(5003, 103, 2, 'Savings', 12000.00, TO_DATE('2025-02-10', 'YYYY-MM-DD')),
(5004, 104, 2, 'Current', 350.00, TO_DATE('2025-02-15', 'YYYY-MM-DD')),
(5005, 105, 3, 'Savings', 8500.75, TO_DATE('2025-03-01', 'YYYY-MM-DD')),
(5006, 106, 3, 'Current', 2750.00, TO_DATE('2025-03-12', 'YYYY-MM-DD')),
(5007, 107, 1, 'Savings', 95.00, TO_DATE('2025-04-05', 'YYYY-MM-DD')),
(5008, 108, 2, 'Savings', 6200.00, TO_DATE('2025-04-18', 'YYYY-MM-DD')),
(5009, 109, 3, 'Current', 10500.00, TO_DATE('2025-05-22', 'YYYY-MM-DD')),
(5010, 110, 1, 'Savings', 430.00, TO_DATE('2025-06-01', 'YYYY-MM-DD'));

-- ==========================================
-- 4. INSERT DATA INTO EMPLOYEE (8 Employees)
-- Matches your column order: salary before designation
-- ==========================================
INSERT INTO employee (employee_id, employee_name, branch_id, salary, designation) VALUES
(201, 'John Doe', 1, 85000.00, 'Manager'),
(202, 'Jane Doe', 1, 45000.00, 'Teller'),
(203, 'Michael Scott', 2, 82000.00, 'Manager'),
(204, 'Pam Beesly', 2, 43000.00, 'Teller'),
(205, 'Jim Halpert', 2, 60000.00, 'Officer'),
(206, 'Robert California', 3, 95000.00, 'Manager'),
(207, 'Oscar Martinez', 3, 65000.00, 'Accountant'),
(208, 'Kevin Malone', 3, 40000.00, 'Teller');

-- ==========================================
-- 5. INSERT DATA INTO BANK_TRANSACTION (25 Transactions)
-- Matches your exact check constraint spelling: 'Withdrawl'
-- ==========================================
INSERT INTO bank_transaction (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES
(9001, 5001, 'Deposit', 1000.00, TO_DATE('2026-01-02', 'YYYY-MM-DD')),
(9002, 5001, 'Withdrawl', 200.00, TO_DATE('2026-01-05', 'YYYY-MM-DD')),
(9003, 5002, 'Deposit', 500.00, TO_DATE('2026-01-06', 'YYYY-MM-DD')),
(9004, 5003, 'Deposit', 2500.00, TO_DATE('2026-01-10', 'YYYY-MM-DD')),
(9005, 5004, 'Withdrawl', 50.00, TO_DATE('2026-01-12', 'YYYY-MM-DD')),
(9006, 5005, 'Deposit', 1200.00, TO_DATE('2026-01-15', 'YYYY-MM-DD')),
(9007, 5006, 'Withdrawl', 300.00, TO_DATE('2026-01-18', 'YYYY-MM-DD')),
(9008, 5002, 'Withdrawl', 100.00, TO_DATE('2026-01-20', 'YYYY-MM-DD')),
(9009, 5007, 'Deposit', 50.00, TO_DATE('2026-01-22', 'YYYY-MM-DD')),
(9010, 5008, 'Deposit', 800.00, TO_DATE('2026-01-25', 'YYYY-MM-DD')),
(9011, 5009, 'Withdrawl', 1500.00, TO_DATE('2026-02-01', 'YYYY-MM-DD')),
(9012, 5010, 'Deposit', 200.00, TO_DATE('2026-02-03', 'YYYY-MM-DD')),
(9013, 5003, 'Withdrawl', 1000.00, TO_DATE('2026-02-05', 'YYYY-MM-DD')),
(9014, 5005, 'Withdrawl', 450.00, TO_DATE('2026-02-08', 'YYYY-MM-DD')),
(9015, 5001, 'Deposit', 350.00, TO_DATE('2026-02-10', 'YYYY-MM-DD')),
(9016, 5006, 'Deposit', 1400.00, TO_DATE('2026-02-14', 'YYYY-MM-DD')),
(9017, 5008, 'Withdrawl', 250.00, TO_DATE('2026-02-17', 'YYYY-MM-DD')),
(9018, 5009, 'Deposit', 3000.00, TO_DATE('2026-02-20', 'YYYY-MM-DD')),
(9019, 5004, 'Deposit', 150.00, TO_DATE('2026-02-22', 'YYYY-MM-DD')),
(9020, 5002, 'Deposit', 600.00, TO_DATE('2026-02-25', 'YYYY-MM-DD')),
(9021, 5007, 'Withdrawl', 20.00, TO_DATE('2026-02-28', 'YYYY-MM-DD')),
(9022, 5010, 'Withdrawl', 100.00, TO_DATE('2026-03-02', 'YYYY-MM-DD')),
(9023, 5003, 'Deposit', 500.00, TO_DATE('2026-03-05', 'YYYY-MM-DD')),
(9024, 5005, 'Deposit', 900.00, TO_DATE('2026-03-08', 'YYYY-MM-DD')),
(9025, 5006, 'Withdrawl', 600.00, TO_DATE('2026-03-10', 'YYYY-MM-DD'));


commit;

select * from customer;

select customer_id,customer_name,city from customer;

select * from customer
where city = 'New York';

select * from account;

select * from account
where balance > 2000;

select * from account
where balance between 5000 and 10000;

select * from account 
where account_type = 'Savings';

select * from bank_transaction;

select * from bank_transaction 
where transaction_type = 'Deposit';

select * from bank_transaction 
where transaction_type = 'Withdrawl';

select * from bank_transaction
where amount > 500 and transaction_type = 'Deposit';

select * from bank_transaction
where amount <= 1000 or transaction_type = 'Withdrawl'; 

select * from bank_transaction
where transaction_type != 'Deposit';

select * from account;
select * from account where balance = 5000;
select * from account where balance <> 350;
select * from account where balance > 100;
select * from account where balance < 350;
select * from account where balance >= 95;
select * from account where balance <= 430;

select * from customer;

select * from customer
where city in ('New York','Boston');

select * from account
where balance between 5000 and 10000;

select customer_name from customer where customer_name like 'A%';

select * from account;
select * from account order by balance desc;
select * from account order by balance asc;

select customer_name, upper(customer_name) as upper_name
from customer;

select customer_name, lower(customer_name) as lower_name
from customer;

select customer_name, length(customer_name) as name_length
from customer;

select customer_name, substr(customer_name, 1, 5) as short_name
from customer;

select account_id, balance, round(balance) as rounded_value
from account;

select balance, mod(balance,3) as modded
from account;

select opening_date, opening_date + 30 as after_30_days
from account;

select sysdate as current_date
from dual;

select opening_date,to_char(opening_date) as formatted_date
from account;

select customer_name, nvl(email, 'no email found') from customer;

select balance,
       CASE 
           when balance >= 5000 THEN 'rich kid' 
           when balance >= 1000 THEN 'middle class' 
           else 'broke' 
       end as financial_status
from account;

select 
  (select count(*) from customer) as total_cust,
  (select count(*) from account) as total_accounts;

select max(balance),avg(balance),min(balance),sum(balance) from account;

select city,count(customer_name)
from customer
group by city;

select account_type, count(account_type) 
from account
group by account_type;

select * from employee;

select avg(salary), branch_id
from employee
group by branch_id;

select sum(salary) from employee group by branch_id having sum(salary) > 130000;

select c.customer_name, a.account_id, a.balance
from customer c
join account a on c.customer_id = a.customer_id;

select c.customer_name, a.account_type, b.branch_name
from customer c
join account a on c.customer_id = a.customer_id 
join branch b on a.branch_id = b.branch_id;

select e.employee_name, e.designation, b.branch_name
from employee e
join branch b on e.branch_id = b.branch_id;

select * from bank_transaction;

select a.account_id, t.transaction_id, t.transaction_type, t.transaction_date
from account a
join bank_transaction t on a.account_id = t.account_id;


select c.customer_name, c.customer_id, a.account_id, a.balance
from customer c 
left outer join account a on c.customer_id = a.customer_id;

select * from branch;
select * from employee;

select e.employee_name, e.salary, b.branch_name
from employee e
left outer join branch b on e.branch_id = b.branch_id;


select balance,
rank() over(order by balance desc) as desc_order
from account;

select account_id,account_type,balance,
row_number() over(order by balance) as ordered_by
from account;

select * from branch;
select * from employee;

select employee_name, salary, branch_id ,rank() over(partition by branch_id order by salary desc) from employee;

select transaction_id,transaction_date,amount,sum(amount) over(order by transaction_date, transaction_id) as running_total from bank_transaction;


SELECT 
    account_id, 
    transaction_id, 
    transaction_date, 
    amount AS current_transaction_amount,
    LAG(amount, 1) OVER (PARTITION BY account_id ORDER BY transaction_date) AS previous_transaction_amount
FROM bank_transaction;



SELECT 
    account_id, 
    transaction_id, 
    transaction_date, 
    amount AS current_transaction_amount,
    lead(amount, 1) OVER (PARTITION BY account_id ORDER BY transaction_date) AS previous_transaction_amount
FROM bank_transaction;


with account_summary as (
    select account_type, sum(balance) as total_balance
    from account
    group by account_type
)
select *
from account_summary;

select * from bank_transaction;

with transaction_summary as(
select account_id,sum(amount)
from bank_transaction
group by account_id
)
select * from transaction_summary;


select * from employee;

with avg_sal_by_branch as (
select branch_id, avg(salary)
from employee
group by branch_id
)
select * from avg_sal_by_branch;


with transaction_summary as (
    select
        account_id,
        count(*) as transaction_count,
        sum(amount) as total_transaction_amount
    from BANK_TRANSACTION
    group by account_id
)
select
    c.customer_name,
    a.account_id,
    a.account_type,
    a.balance,
    NVL(t.transaction_count, 0) AS transaction_count,
    NVL(t.total_transaction_amount, 0) AS total_transaction_amount
from CUSTOMER c
join account a
    on c.customer_id = a.customer_id
left join transaction_summary t
    on a.account_id = t.account_id
order by c.customer_name;

commit;
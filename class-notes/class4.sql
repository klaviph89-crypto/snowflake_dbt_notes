



select * from employees;

select first_name,
        last_name,
        hire_date,
        salary from employees;

        select employee_id from employees;

        select employee_id,
        first_name,
        last_name,
        hire_date,
        salary from employees;

        select * from employees;

        select distinct job_id from employees
        order by 1;

        select job_id, count(*),manager_id, count(*) from employees
        group by job_id,manager_id;
        
        select first_name,count(*) from employees
        group by first_name
        having count(*)>1;

        select manager_id,count(*) from employees
        group by manager_id
        having count(*)>3;

        select salary,count(*) from employees
        group by salary
        having count(*)>1

       select * from employees where manager_id in(select manager_id  
       from employees
        group by manager_id
        having count(*)>3
        );

        select * from employees where first_name in(select first_name 
        from employees
        group by first_name
        having count(*)>1
      );
select min(salary) from employees;
where salary not in(select min(salary) from employees);

select * from employees where salary in (select min(salary) 
from employees
where salary not in(select min(salary) from employees)
);

select * from employees;

select * from dependents;

select employee_id from dependents;

select * from employees where employee_id not in (select employee_id from dependents
);

select dependent_id from dependents;

select * from dependents where employee_id not in(select dependent_id from dependents
);

select * from employees where manager_id  is not null;

select * from employees;

select phone_number,
manager_id ,
coalesce(phone_number, 'na')
from employees ;


select phone_number,
manager_id ,
coalesce(manager_id, '13')AS MANAGER_ID
from employees ;
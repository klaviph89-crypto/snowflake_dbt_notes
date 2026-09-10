

---CONDTITIONAL STATEMENTS TASK----

create database employee;

create table employee(e_id int,age int);
insert into employee(e_id,age)values
(1,21),
(2,19),
(3,26),
(4,16),
(5,18),
(6,25),
(7,30);

select * from employee;

select e_id,
       age,
       iff(age>=20, 'major' , 'minor') as status
       from employee
       order by age asc;

   select day,
         case
            when day=1 then 'monday'
            when day=2 then 'tuesday'
            when day=3 then 'wednesday'
            when day=4 then 'thursday'
            when day=5 then 'friday'
            when day=6 then 'saturday'
            when day=7 then 'invalid day'
            when day=8 then 'invalid day'
            when day=9 then 'invalid day'
            
         end as status
         from employee;

     select *from employee ;

     insert into employee(day) values
     (1),
     (2),
     (3),
     (4),
     (5),
     (6),
     (7),
     (8),
     (9);
     select day from employee;

     delete  from employee where day in(1,2,3,4,5,6,7,8,9);
     

     alter table employee add column day string;

     select day,
         case
            when day=1 then 'monday'
            when day=2 then 'tuesday'
            when day=3 then 'wednesday'
            when day=4 then 'thursday'
            when day=5 then 'friday'
            when day=6 then 'saturday'
            when day=7 then 'sunday'
            when day=8 then 'invalid day'
            when day=9 then 'invalid day'
            
         end as status
         from employee;

      

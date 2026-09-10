




create table tab_x (ID int);

create table tab_y (ID int);

insert into tab_x (ID) values
(1),
(1),
(1),
(2),
(3),
(3),
(5),
(5),
(6),
(8),
(null);

insert into tab_y (ID) values
(1),
(1),
(3),
(3),
(4),
(4),
(6),
(7),
(8),
(8),
(null);

select *  from tab_x;

select * from tab_y;

select x.*, y.* from tab_x X inner join
                    tab_y  Y
                    on x.ID=y.ID;


select x.*, y.* from tab_x X left join
                    tab_y  Y
                    on x.ID=y.ID;

 select x.*, y.* from tab_x X right join
                    tab_y  Y
                    on x.ID=y.ID;                   

select x.*, y.* from tab_x X full join
                    tab_y  Y
                    on x.ID=y.ID;                   


  inner joins count=13
  left joins count=17
  right joins count=17
  full joins count=21
                                        
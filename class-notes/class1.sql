

 

create or replace database college;
use college;
create or replace schema mits;
create or replace schema vit;
create or replace schema SGMS;

create or replace table college.mits.student(sid int,
                                       name string,
                                    address string,
                                    marks int,
                                    phone int
                                    );

                                    
create or replace table college.vit.student(sid int,
                                       name string,
                                    address string,
                                    marks int,
                                    phone int
                                    );

 create or replace table college.sgms.student(sid int,
                                       name string,
                                    address string,
                                    marks int,
                                    phone int
                                    
                                   

 insert into college.mits.student(sid,name,address,marks,phone)values
 (20,'lavanya','bgl',800,8945122312),
 (21,'varalakshmi','hyd',850,8974512587),
 (22,'harathi','tpt',860,9984512567),
 (23,'rihal','bgl',870,9997454578),
 (24,'varma','hyd',880,7954522585),
 (25,'giri','bgl',810,8818457561),
 (26,'manju','plmr',820,8877514588),
 (27,'vamsi','hyd',830,8974514518),
 (28,'mokshi','bgl',890,9976547812),
 (29,'chitti','hyd',880,8897845725);

 select * from college.mits.student;
 
insert into college.vit.student(sid,name,address,marks,phone)values
 (20,'lavanya','bgl',800,8945122312),
 (21,'varalakshmi','hyd',850,8974512587),
 (22,'harathi','tpt',860,9984512567),
 (23,'rihal','bgl',870,9997454578),
 (24,'varma','hyd',880,7954522585),
 (25,'giri','bgl',810,8818457561),
 (26,'manju','plmr',820,8877514588),
 (27,'vamsi','hyd',830,8974514518),
 (28,'mokshi','bgl',890,9976547812),
 (29,'chitti','hyd',880,8897845725);

 select * from college.vit.student;
 
insert into college.sgms.student(sid,name,address,marks,phone)values
 (20,'lavanya','bgl',800,8945122312),
 (21,'varalakshmi','hyd',850,8974512587),
 (22,'harathi','tpt',860,9984512567),
 (23,'rihal','bgl',870,9997454578),
 (24,'varma','hyd',880,7954522585),
 (25,'giri','bgl',810,8818457561),
 (26,'manju','plmr',820,8877514588),
 (27,'vamsi','hyd',830,8974514518),
 (28,'mokshi','bgl',890,9976547812),
 (29,'chitti','hyd',880,8897845725);

 select * from college.sgms.student;
 

select *from college.mits.student
union all
select *from college.vit.student
union all
select *from college.sgms.student;














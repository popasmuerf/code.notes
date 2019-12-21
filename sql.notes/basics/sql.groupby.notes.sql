create table data_points
(
    data_points_id int(11) auto_increment primary key,
    data_point int
) ;


insert into data_points (data_point) value(1) ;
insert into data_points (data_point) value(2) ;
insert into data_points (data_point) value(3) ;
insert into data_points (data_point) value(4) ;
insert into data_points (data_point) value(5) ;
insert into data_points (data_point) value(6) ;
insert into data_points (data_point) value(7) ;
insert into data_points (data_point) value(8) ;
insert into data_points (data_point) value(9) ;
insert into data_points (data_point) value(10) ;


select max(data_point) from data_points ;
select min(data_point) from data_points ;
select sum(data_point) from data_points ;


alter table  data_points add column varchar_data_point varchar(20) ;

insert into data_points (data_point,varchar_data_point) value(1,'Trevor');
insert into data_points (data_point,varchar_data_point) value(2,'Bob');
insert into data_points (data_point,varchar_data_point) value(3,'Zoo');
insert into data_points (data_point,varchar_data_point) value(4,'Eric');
insert into data_points (data_point,varchar_data_point) value(5,'Chris');
insert into data_points (data_point,varchar_data_point) values(6,'Miko Lee');
insert into data_points (data_point,varchar_data_point) values(7,'Obsession');
insert into data_points (data_point,varchar_data_point) values(8,'Brazilia');
insert into data_points (data_point,varchar_data_point) values(9,'Kenya');
insert into data_points (data_point,varchar_data_point) values(10,'Kiwi');

 select max(varchar_data_point) from data_points ;


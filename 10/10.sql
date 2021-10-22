use BVA_UNIVER
go
----------------1------------------------------------------------------------------------------------------------



exec SP_HELPINDEX 'AUDITORIUM'
exec SP_HELPINDEX 'AUDITORIUM_TYPE'
exec SP_HELPINDEX 'FACULTY'
exec SP_HELPINDEX 'GROUPS'
exec SP_HELPINDEX 'PROFESSION'
exec SP_HELPINDEX 'PROGRESS'
exec SP_HELPINDEX 'PULPIT'
exec SP_HELPINDEX 'STUDENT'
exec SP_HELPINDEX 'SUBJECT'
exec SP_HELPINDEX 'TEACHER'


create table  #EXPLRE
(	a int, 
	b int,
	TFIELD varchar(100) 
);
SET nocount on; -- не выводить сообщение о добавлении строк
DECLARE @i int=0
while @i<2000
begin 
	insert #EXPLRE(a, b, TFIELD)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('строка', 10));
	set @i=@i+1;
end;

SELECT * FROM #EXPLRE where a between 1 and 1500
checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш
CREATE clustered index #EXPLRE_CL on #EXPLRE(b asc)

SELECT * FROM #EXPLRE where b between 1 and 150 and a>b order by b;

drop table #EXPLRE;
drop index #EXPLRE_CL on #EXPLRE

----------------2------------------------------------------------------------------------------------------------

create table  #EXP
(	aa int, 
	bb int,
	TFIELD2 varchar(100) 
);
SET nocount on;
DECLARE @ii int=0
while @ii<10000
begin 
	insert #EXP(aa, bb, TFIELD2)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('строка', 10));
	set @ii=@ii+1;
end;

create index #EXP_NONCLU on #EXP(aa, bb)

select * from  #EXP where  aa>1500 and  bb < 100; -- не применим
select * from  #EXP order by  aa, bb -- не применим
select * from  #EXP where  aa = 556 and  bb > 3

drop table #EXP
drop index #EXP_NONCLU on #EXP

----------------3------------------------------------------------------------------------------------------------

create table  #EXP2
(	aaa int, 
	bbb int,
	TFIELD2 varchar(100) 
);
SET nocount on;
DECLARE @iii int=0
while @iii<10000
begin 
	insert #EXP2(aaa, bbb, TFIELD2)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('строка', 10));
	set @iii=@iii+1;
end;

select bbb from #EXP2 where aaa>1500

create index #EXP_NONCLU on #EXP2(aaa) include (bbb)

drop table #EXP2
drop index #EXP_NONCLU on #EXP2

----------------4------------------------------------------------------------------------------------------------

create table #TABL
(	m int, 
	k int,
	F varchar(100) 
);
SET nocount on;
DECLARE @j int=0
while @j<10000
begin 
	insert #TABL(m, k, F)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('строка', 10));
	set @j=@j+1;
end;

select m from  #TABL where m between 500 and 1999; 
select m from  #TABL where m>1500 and  m < 2000 
select m from  #TABL where m=1700

create  index #TABL_WHERE on #TABL(m) where (m>=1500 and m < 2000); 

drop table #TABL
drop index #TABL_WHERE on #TABL

----------------5------------------------------------------------------------------------------------------------

create table #TABL2
(	m2 int, 
	k2 int,
	F2 varchar(100) 
);
SET nocount on;
DECLARE @j2 int=0
while @j2<10000
begin 
	insert #TABL2(m2, k2, F2)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('строка', 10));
	set @j2=@j2+1;
end;

create index #TABL2_m2 on #TABL2(m2)

select name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#TABL2_m2'), NULL, NULL, NULL) s,
sys.indexes z
where s.object_id = z.object_id and s.index_id = z.index_id
and name is not null;

DECLARE @jj2 int=0
while @jj2<100000
begin 
	insert #TABL2(m2, k2, F2)
	values (floor(20000*RAND()), floor(8000*RAND()), REPLICATE('строка', 10));
	set @jj2=@jj2+1;
end;

alter index #TABL2_m2 on #TABL2 reorganize; --только на нижних уровнях

alter index #TABL2_m2 on #TABL2 rebuild with (online = off); --затрагивает все узлы

drop table #TABL2
drop index #TABL2_m2 on #TABL2

----------------6------------------------------------------------------------------------------------------------

create table #TABL3
(	m3 int, 
	k3 int,
	F3 varchar(100) 
);
SET nocount on;
DECLARE @j3 int=0
while @j3<10000
begin 
	insert #TABL3(m3, k3, F3)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('строка', 10));
	set @j3=@j3+1;
end;

create index #TABL3_m3 on #TABL3(m3)

select name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#TABL3_m3'), NULL, NULL, NULL) s,
sys.indexes z
where s.object_id = z.object_id and s.index_id = z.index_id
and name is not null;

drop table #TABL3
drop index #TABL3_m3 on #TABL3;
create index #TABL3_m3 on #TABL3(m3) with (fillfactor = 65);

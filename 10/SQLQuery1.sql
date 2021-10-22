use [Фирма по продаже автозапчастей]
go

exec SP_HELPINDEX 'Детали'
exec SP_HELPINDEX 'Поставки'
exec SP_HELPINDEX 'Поставщики'

select * from Детали where [Код детали] between 2 and 7 order by [Код детали]
checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш
CREATE index Детали_Код on Детали([Код детали] asc)

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
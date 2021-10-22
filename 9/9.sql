use BVA_UNIVER
go

declare @c char(2)='ab',
@v varchar(6)='helloa',
@d datetime, 
@ti time,
@i int,
@s smallint,
@tin tinyint,
@n numeric(12,6)

select @c c, @i i;
set @i=1222; set @v='hellob';
Select @i i, @v v;
Select
@d=getdate(),
@ti='01:49:35',
@s=34,
@tin=1,
@v='helloc';
Select @d date, @ti tim, @s s, @tin tin, @i i;
Print 'Print : ' + @v;


--2
declare @sumVm int = (SELECT CAST(SUM(AUDITORIUM_CAPACITY) AS NUMERIC(5)) FROM AUDITORIUM),
@count int,
@avgvmest float,
@countsmall int,
@percent float;
if @sumVm>200
begin
select @count = (select count(*) from AUDITORIUM)
set @avgvmest=(select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)
Set @countsmall = (select count(*) from AUDITORIUM Where AUDITORIUM_CAPACITY<@avgvmest)
Set @percent = @countsmall/@count*100
Select @count 'Количество аудиторий',
@avgvmest 'Средняя вместительность',
@countsmall 'Сумма аудиторий, вместимость < средней', 
@percent 'Процент'
end
else 
Select @sumVm 'Общая вместимость'

--3
select @@ROWCOUNT as string,
@@VERSION as Version,
@@SPID as Process_Id,
@@ERROR as Last_Error,
@@SERVERNAME as Server_Name,
@@TRANCOUNT as LevelInTran,
@@FETCH_STATUS as ReadString,
@@NESTLEVEL as Level_in_curr_proc

--4
Declare @t int = 1, @x float = 2.1, @z float;
if(@t>@x) set @z=power(sin(@t),2)
else if(@t<@x) set @z= 4*(@t+@x)
else set @z=1-exp(@x-2);
print 'z=' + cast(@z as varchar(15));


declare @FIO varchar(50), @F varchar(10), @Im varchar(5), @O varchar(5)
set @FIO='Шихов Максим Владиславович'
declare @Socr int
set @Socr=CHARINDEX(' ',@FIO,1)
set @F= substring(@FIO,1,@Socr)
set @Im= substring(@FIO,@Socr+1,1)
set @Socr= charindex(' ',@FIO,@Socr+1)
set @O= substring(@FIO, @Socr+1,1)
select @F+' '+@Im+'.'+@O+'.'


DECLARE @DOfBirth int
SET @DOfBirth = MONTH(GETDATE());
SELECT NAME, BDAY,(SELECT YEAR(GETDATE())-YEAR(BDAY) - 1)[AGE] 
FROM STUDENT WHERE MONTH(BDAY) = @DOfBirth+1




DECLARE @Day NVARCHAR(15), @Date DATE;
SET @Date =
(SELECT TOP(1) PROGRESS.PDATE
FROM PROGRESS
WHERE PROGRESS.SUBJECT = 'СУБД');
SET @Day= CONVERT(NVARCHAR(15), DATEPART(DW,@Date));
SET @Day= CASE @Day
WHEN '1' THEN 'Воскресенье'
WHEN '2' THEN 'Понедельник'
WHEN '3' THEN 'Вторник'
WHEN '4' THEN 'Средy'
WHEN '5' THEN 'Четверг'
WHEN '6' THEN 'Пятницy'
WHEN '7' THEN 'Субботy'
END
PRINT 'Экзамен по СУБД был в '+ @Day;










--5

Declare @sum int = (SELECT CAST(SUM(AUDITORIUM_CAPACITY) AS NUMERIC(5)) FROM AUDITORIUM)
if(@sum<10)
print 'Меньше 10'
else
print 'Больше 10';





--6
select case
when NOTE between 1 and 4 then 'Плохо'
	when NOTE between 5 and 7 then 'Нeплохо'
	when NOTE between 8 and 10 then 'Отлично'
	else 'Пересдача!'
	end Оценка,count(*)[Количество]
	from PROGRESS p inner join SUBJECT s
	 on p.SUBJECT=s.SUBJECT 
 inner join PULPIT p2 on s.PULPIT=p2.PULPIT 
 inner join FACULTY f on p2.FACULTY=f.FACULTY
 Where f.FACULTY = 'ИТ'
 group by 
 case
  when NOTE between 1 and 4 then 'Плохо'
	when NOTE between 5 and 7 then 'Нeплохо'
	when NOTE between 8 and 10 then 'Отлично'
	else 'Пересдача!'
	end














--7
create table #EXCPLRE
(
one int,
two varchar(100),
three varchar(1000));
set nocount on;
declare @int int=0;
while @int<10
begin 
insert #EXCPLRE(one,two,three)
values (floor(30*rand()),REPLICATE('hi', @int+1),REPLICATE('hello', @int+1));
if(@int%10=0)
print @int;
set @int += 1;
end;
select * from #EXCPLRE;
drop table #EXCPLRE
;







--8 
declare @xx int=3;
print @xx+10;
print @xx*10;
return
print @xx+1;

--9
use [Фирма по продаже автозапчастей]
begin try
update Поставки set [Код поставщика]='вы'
end try 
begin catch
print ERROR_NUMBER()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE() 
end catch
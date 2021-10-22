use [Фирма по продаже автозапчастей]
go
create function countOfSales1(@name nvarchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count([Код детали]) from Детали where [Название детали]=@name)
return @rc;
end; 

go
declare @n int = dbo.countOfSales1('Правый поворотник');
print 'Количество деталей: ' + cast(@n as varchar(4));


use [Фирма по продаже автозапчастей]
go
alter function countOfSales1(@name varchar(20) = null, @prim varchar(20) = '1-40 01 02') returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count([Код детали]) from Детали where [Название детали] = @name and Примечание = @prim)
return @rc;
end; 

go
declare @n int = dbo.countOfSales1('Правый поворотник', 'Субару');
print 'Количество деталей: ' + cast(@n as varchar(4));


use [Фирма по продаже автозапчастей]
go
create FUNCTION zakdet(@nz char(20)) returns char(300) 
     as
     begin  
     declare @tv char(20);  
     declare @t varchar(300)
     declare ZkTovar CURSOR LOCAL 
     for select Наименование_товара from Заказы where Заказчик = @nz ;
     open ZkTovar;	  
     fetch  ZkTovar into @tv;   	 
     while @@fetch_status = 0                                     
     begin 
         set @t = @t + ', ' + rtrim(@tv);         
         FETCH  ZkTovar into @tv; 
     end;    
     return @t;
     end;  

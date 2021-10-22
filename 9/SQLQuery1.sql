use [Фирма по продаже автозапчастей]
go

declare @x int=(select count(*) from Поставки);
if (select count(*) from Поставки)>3
begin
print'Количество поставок больше 3';
print'Количество ='+ cast(@x as varchar(10));
end;
if (select count(*) from Поставки)<3
begin
print'Количество поставок меньше 3';
print'Количество ='+ cast(@x as varchar(10));
end;

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

declare @kolvo int=(select count(*) from Детали)
print 'Количество деталей:'+ cast(@kolvo as varchar(10));
declare @kolvo1 int=(select count(*) from Поставки)
print 'Количество поставок:'+ cast(@kolvo as varchar(10));
declare @time time=sysdatetime();
print 'Системное время:'+ cast(@time as varchar(10));
declare @date date=getdate();
print 'Системная дата:'+ cast(@date as varchar(10));
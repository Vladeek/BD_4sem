use [����� �� ������� �������������]
go
create function countOfSales1(@name nvarchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count([��� ������]) from ������ where [�������� ������]=@name)
return @rc;
end; 

go
declare @n int = dbo.countOfSales1('������ ����������');
print '���������� �������: ' + cast(@n as varchar(4));


use [����� �� ������� �������������]
go
alter function countOfSales1(@name varchar(20) = null, @prim varchar(20) = '1-40 01 02') returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count([��� ������]) from ������ where [�������� ������] = @name and ���������� = @prim)
return @rc;
end; 

go
declare @n int = dbo.countOfSales1('������ ����������', '������');
print '���������� �������: ' + cast(@n as varchar(4));


use [����� �� ������� �������������]
go
create FUNCTION zakdet(@nz char(20)) returns char(300) 
     as
     begin  
     declare @tv char(20);  
     declare @t varchar(300)
     declare ZkTovar CURSOR LOCAL 
     for select ������������_������ from ������ where �������� = @nz ;
     open ZkTovar;	  
     fetch  ZkTovar into @tv;   	 
     while @@fetch_status = 0                                     
     begin 
         set @t = @t + ', ' + rtrim(@tv);         
         FETCH  ZkTovar into @tv; 
     end;    
     return @t;
     end;  

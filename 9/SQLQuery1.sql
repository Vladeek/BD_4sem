use [����� �� ������� �������������]
go

declare @x int=(select count(*) from ��������);
if (select count(*) from ��������)>3
begin
print'���������� �������� ������ 3';
print'���������� ='+ cast(@x as varchar(10));
end;
if (select count(*) from ��������)<3
begin
print'���������� �������� ������ 3';
print'���������� ='+ cast(@x as varchar(10));
end;

begin try
update �������� set [��� ����������]='��'
end try 
begin catch
print ERROR_NUMBER()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE() 
end catch

declare @kolvo int=(select count(*) from ������)
print '���������� �������:'+ cast(@kolvo as varchar(10));
declare @kolvo1 int=(select count(*) from ��������)
print '���������� ��������:'+ cast(@kolvo as varchar(10));
declare @time time=sysdatetime();
print '��������� �����:'+ cast(@time as varchar(10));
declare @date date=getdate();
print '��������� ����:'+ cast(@date as varchar(10));
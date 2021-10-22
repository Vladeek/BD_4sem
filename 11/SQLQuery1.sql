use [����� �� ������� �������������]
go

go
declare @tid char(20), @tnm char(200);  
declare Tov cursor                              
for select [�������� ������]
from ������;
open Tov;	  
fetch  Tov into @tid;--�������� FETCH ��������� ���� ������ �� ��������������� ������ � ���������� ��������� �� ��������� ������   
print  '������:';   
set @tnm=cast(@tid as varchar(10))
while @@fetch_status = 0
begin
set @tnm = rtrim(@tid)+', '+@tnm;  
fetch  Tov into @tid; 
end;   
print @tnm;        
close  Tov;

go
declare @tid char(20), @tnm char(5), @tgn char(5);
declare tov cursor global                    
for select [�������� ������], [��� ������], [���-�� ������� �� ������]   
from ������ where [��� ������] between 2 and 6;
open tov;                                             
fetch tov into @tid, @tnm, @tgn;
while @@fetch_status = 0                                     
begin 
print @tid + ' '+ @tnm + ' '+ @tgn;      
fetch  tov into @tid, @tnm, @tgn;                  
end;
close  tov;                                           
deallocate tov;

open tov;  

go 
declare @tid char(10), @tnm char(40), @tgn char(1);   
declare tov cursor local--��������� ����� ����������� � ������ ������ ������ � �������, 
						--���������� ��� ��� ���-�������, ������������� ����� ����� ���������� ������ ������.
for select t.[�������� ������], t.[��� ������], t.[���-�� ������� �� ������] 
from ������ t where t.[��� ������] between 2 and 5;
open tov;  

fetch  tov into @tid, @tnm, @tgn;   
print '1. '+ @tid + ' '+ @tnm + ' '+ @tgn;                      
go 
declare @tid char(10), @tnm char(40), @tgn char(1); 
fetch  tov into @tid, @tnm, @tgn;  
print '2. '+@tid + ' '+ @tnm + ' '+ @tgn;

go 
declare tov cursor global--���������� ����� ���� ��������, ������ � ����������� � ������ �������.
--���������� ��� ������� ������������� ����� ��������� DEALLOCATE ��� ��� ���������� ������
for select t.[�������� ������], t.[��� ������], t.[���-�� ������� �� ������]
from ������ t where t.[��� ������] between 2 and 5;
open tov;
go                       
declare @tid char(20), @tnm char(5), @tgn char(3);  
fetch  tov into @tid, @tnm, @tgn;  
print '1. '+ @tid + ' '+ @tnm + ' '+ @tgn;   
go 
declare @tid char(20), @tnm char(5), @tgn char(3);  
fetch  tov into @tid, @tnm, @tgn;  
print '2. '+@tid + ' '+ @tnm + ' '+ @tgn;  
close  tov;
go 
declare @tid char(20), @tnm char(5), @tgn char(3);  
open tov; 
fetch  tov into @tid, @tnm, @tgn;  
print '3. '+@tid + ' '+ @tnm + ' '+ @tgn;
close  tov;  

deallocate tov;--DEALLOCATE ������������ �������� ����������� �������
go 
open tov; 
go

go
declare @tid char(20), @tnm char(5), @tgn char(3);  
declare tov cursor local static--	����������� ������(�������� � �������� ��������������� ������ � TEMPDB)
for select [�������� ������], [��� ������], [���-�� ������� �� ������] 
from ������ where [��� ������] between 1 and 9;  
						   
open tov;
print   '���������� ����� : '+cast(@@CURSOR_ROWS as varchar(5)); 

update ������ set [�������� ������] = '������� ������� ����' where [�������� ������] = '������ ����';
delete ������ where [�������� ������] = '������ �����������';

fetch  tov into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                     
begin 
print @tid + ' '+ @tnm + ' '+ @tgn;      
fetch  tov into @tid, @tnm, @tgn; 
end;          
close  tov;

declare @tc char(50), @rn char(50);
declare orcs cursor local dynamic scroll --������������ ������ � SCROLL, ����������� ��������� �������� FETCH � ��������������� ������� ����������������.
for select row_number() over (order by [�������� ������]) N,
[�������� ������] from ������
open orcs;
fetch orcs into @tc, @rn;
print '���������� ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch prior from  orcs into @tc, @rn;
print '��������� ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch next from orcs into @tc, @rn;
print '��������� ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch absolute 3 from orcs into @tc, @rn;
print '3 ������ � ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch absolute -3 from orcs into @tc, @rn;
print '3 ������ � �����				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch relative 5 from orcs into @tc, @rn;
print '5 ������ � ������� �������		:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch relative -5 from orcs into @tc, @rn;
print '5 ������ ����� � ������� �������:' + cast(@tc as varchar(3))+rtrim(@rn);
close dunam

go
declare @tid char(10), @tnm char(40), @tgn char(20);   
declare tov cursor local dynamic                            
for select [�������� ������],[��� ������],[���-�� ������� �� ������] 
from ������ for update; 
open tov;  
fetch  tov into @tid, @tnm, @tgn; --��������
fetch  tov into @tid, @tnm, @tgn;
update ������ set [�������� ������] = 'XXXX' where current of tov;--������ ��� ������� ������� �������
close tov;

select * from ������
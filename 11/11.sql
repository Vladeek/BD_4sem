use BVA_UNIVER

--1
go
declare @tid char(10), @tnm char(200);  
declare Isit_d cursor                              
for select SUBJECT
from dbo.SUBJECT where PULPIT = '����';
open Isit_d;	  
fetch  Isit_d into @tid;--�������� FETCH ��������� ���� ������ �� ��������������� ������ � ���������� ��������� �� ��������� ������   
print  '������� ����';   
set @tnm=cast(@tid as varchar(10))
while @@fetch_status = 0
begin
set @tnm = rtrim(@tid)+', '+@tnm;  
fetch  Isit_d into @tid; 
end;   
print @tnm;        
close  Isit_d;


--2
print '-------------------------------2----------------------------'
go
declare @tid char(10), @tnm char(40), @tgn char(1);
declare c_teacher cursor global                    
for select TEACHER, TEACHER_NAME, GENDER   
from TEACHER where PULPIT = '����';
open c_teacher;                                             
fetch  c_teacher into @tid, @tnm, @tgn;
while @@fetch_status = 0                                     
begin 
print @tid +' '+ @tnm +' '+ @tgn;      
fetch c_teacher into @tid, @tnm, @tgn;                  
end;
close  c_teacher;                                           
deallocate c_teacher;
print '-------------------------------2----------------------------'

        
		
		                                 
open c_teacher;  


go 
declare @tid char(10), @tnm char(40), @tgn char(1);   
declare c_teacher cursor local--��������� ����� ����������� � ������ ������ ������ � �������, 
							  --���������� ��� ��� ���-�������, ������������� ����� ����� ���������� ������ ������.
for select t.TEACHER, t.TEACHER_NAME, t.GENDER 
from TEACHER t where t.PULPIT = '����';
open c_teacher;  

fetch  c_teacher into @tid, @tnm, @tgn;   
print '1. '+ @tid + ' '+ @tnm + ' '+ @tgn;                      
go 
declare @tid char(10), @tnm char(40), @tgn char(1); 
fetch  c_teacher into @tid, @tnm, @tgn;  
print '2. '+@tid + ' '+ @tnm + ' '+ @tgn;      


go 
declare c_teacher cursor global--���������� ����� ���� ��������, ������ � ����������� � ������ �������.
--���������� ��� ������� ������������� ����� ��������� DEALLOCATE ��� ��� ���������� ������
for select t.TEACHER, t.TEACHER_NAME, t.GENDER 
from TEACHER t where t.PULPIT = '����';
open c_teacher;
go                       
declare @tid char(10), @tnm char(40), @tgn char(1);  
fetch  c_teacher into @tid, @tnm, @tgn;  
print '1. '+ @tid + ' '+ @tnm + ' '+ @tgn;   
go 
declare @tid char(10), @tnm char(40), @tgn char(1);  
fetch  c_teacher into @tid, @tnm, @tgn;  
print '2. '+@tid + ' '+ @tnm + ' '+ @tgn;  
close  c_teacher;
go 
declare @tid char(10), @tnm char(40), @tgn char(1);  
open c_teacher; 
fetch  c_teacher into @tid, @tnm, @tgn;  
print '3. '+@tid + ' '+ @tnm + ' '+ @tgn;
close  c_teacher;  

deallocate c_teacher;--DEALLOCATE ������������ �������� ����������� �������
go 
open c_teacher; 
go    



--3						   

go
declare @tid char(10), @tnm char(40), @tgn char(1);  
declare c_teacher cursor local static--	����������� ������(�������� � �������� ��������������� ������ � TEMPDB)
 for select TEACHER, TEACHER_NAME, GENDER 
from TEACHER where PULPIT = '����';  
						   
open c_teacher;
print   '���������� ����� : '+cast(@@CURSOR_ROWS as varchar(5)); 

update TEACHER set TEACHER_NAME = 'XXX' where TEACHER = '���';
delete TEACHER where TEACHER = '���';
insert TEACHER(TEACHER, PULPIT) values ('���', '����'); 

fetch  c_teacher into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                     
begin 
print @tid + ' '+ @tnm + ' '+ @tgn;      
fetch  c_teacher into @tid, @tnm, @tgn; 
end;          
close  c_teacher;

--4



declare @tc char(50), @rn char(50);
declare dunam cursor local dynamic scroll --������������ ������ � SCROLL, ����������� ��������� �������� FETCH � ��������������� ������� ����������������.
for select row_number() over (order by FACULTY) N,
FACULTY_NAME from FACULTY
open dunam;
fetch dunam into @tc, @rn;
print '���������� ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch prior from  dunam into @tc, @rn;
print '��������� ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch next from dunam into @tc, @rn;
print '��������� ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch absolute 3 from dunam into @tc, @rn;
print '3 ������ � ������				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch absolute -3 from dunam into @tc, @rn;
print '3 ������ � �����				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch relative 5 from dunam into @tc, @rn;
print '5 ������ � ������� �������		:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch relative -5 from dunam into @tc, @rn;
print '5 ������ ����� � ������� �������:' + cast(@tc as varchar(3))+rtrim(@rn);
close dunam;


--5

go
declare @tid char(10), @tnm char(40), @tgn char(20);   
declare c_teacher cursor local dynamic                            
for select TEACHER,TEACHER_NAME,GENDER 
from TEACHER where PULPIT = '����' for update; 
open c_teacher;  
fetch  c_teacher into @tid, @tnm, @tgn; --delete TEACHER where current of c_teacher;
fetch  c_teacher into @tid, @tnm, @tgn;
update TEACHER set TEACHER_NAME = 'XXXX' where current of c_teacher;--������ ��� ������� ������� �������
close c_teacher;

select * from TEACHER where PULPIT = '����';	




--6

declare @tn char(50), @tl char(50), @tk char(50);   
declare c_pr cursor local dynamic  
for select IDSTUDENT, SUBJECT, NOTE
from PROGRESS FOR UPDATE; 
open c_pr;  
fetch  c_pr into @tn, @tl, @tk;  
print @tn  + @tl + @tk;
delete PROGRESS where CURRENT OF c_pr;--����������� ��� �������
fetch  c_pr into @tn, @tl, @tk; 
update PROGRESS set NOTE = NOTE+1 where CURRENT OF c_pr;
close c_pr;
    
deallocate c_pr; 
     

--7
go 
declare report cursor local for  select f.FACULTY, p.PULPIT, isnull(s.SUBJECT, '���') SUBJECT
from FACULTY f join PULPIT p on f.FACULTY = p.FACULTY left outer join SUBJECT s on p.PULPIT = s.PULPIT order by  f.FACULTY, p.PULPIT, SUBJECT;
declare @f varchar(50), @p varchar(50), @s varchar(100);                                     
declare @fx varchar(50) = '###',@px varchar(50) = '###', @kx int = 0, @sx varchar(200)= '';  

open report 
fetch report into @f, @p, @s;
while @@FETCH_STATUS = 0
begin 
if(@fx != '###' and  (@fx != @f or @px != @p))
begin
set @sx =  SUBSTRING(@sx,1, LEN(@sx)-1)+ '.';--���������� �������� ���������� ���������� ��������� �������� �������� �������
print '     ����������: ' + @sx;--��������� ������� �� ��������� ��� ����� �������� �����
set @sx = '';
end;
if(@fx != @f) 
begin
select @fx = @f;
print '���������: '+ @fx  
end;
if(@px != @p) 
begin 
set @px = @p;  
print '   �������:'+ @px; 
set @kx = (select count(*) from TEACHER where PULPIT =@px);
print '     ���������� ��������������: ' + cast(@kx as varchar(10)); 
end;
set @sx = @sx+ rtrim(@s)+ ', ';--���������� ��������� ��������, ������ ��� ����������� �������
fetch report into @f, @p, @s;
end;
close report;    
go
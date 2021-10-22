use [����� �� ������� �������������]
go

create table TR_Tov
(
ID int identity,
ST varchar(20)
check (ST in ('INS', 'DEL', 'UPD')),
TRN varchar(50),
C varchar(300)
)
go
select * from TR_Tov

--create table TR_AUDIT
--(
--ID int identity,
--STMT varchar(20)
--check (STMT in ('INS', 'DEL', 'UPD')),
--TRNAME varchar(50),
--CC varchar(300)
--)
--go

create trigger TRIG_Det  on ������ after INSERT, DELETE, UPDATE  
as declare @a1 varchar(20), @a2 nvarchar(50), @a3 int, @in varchar(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print '�������: INSERT';
     set @a1 = (select [��� ������] from INSERTED);  
     set @a2 = (select [�������� ������] from INSERTED);
     set @a3 = (select [���-�� ������� �� ������] from INSERTED);
     set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30));
     insert into TR_Tov(ST, TRN, C)  values('INS', 'TRIG_Det', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
    print '�������: DELETE';
    set @a1 = (select [��� ������] from deleted);
    set @a2 = (select [�������� ������] from deleted);
    set @a3 = (select [���-�� ������� �� ������] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30));
    insert into TR_Tov(ST, TRN, C)  values('DEL', 'TRIG_Det', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print '�������: UPDATE'; 
    set @a1 = (select [��� ������] from inserted);
    set @a2 = (select [�������� ������] from inserted);
    set @a3 = (select [���-�� ������� �� ������] from inserted);
    set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30));
    set @a1 = (select [��� ������] from deleted);
    set @a2 = (select [�������� ������] from deleted);
    set @a3 = (select [���-�� ������� �� ������] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30))+' '+@in;
    insert into TR_Tov(ST, TRN, C)  values('UPD', 'TRIG_Det', @in); 
end;  
return;  
--drop trigger TRIG_Det

insert into ������([��� ������],[�������� ������],[���-�� ������� �� ������])
values(10,'������������� �����', 999)
select * from TR_Tov

insert into ������([��� ������],[�������� ������],[���-�� ������� �� ������])
values(11,'Ujh �����', 500)
select * from TR_Tov

alter table ������  add constraint [���-�� ������� �� ������] check([���-�� ������� �� ������] >= 2)
go 	
update ������ set [���-�� ������� �� ������] = 1 where [�������� ������] = 'XXXX';
go

create trigger TRIG_Inst
on ������ instead of DELETE
as raiserror(N'----�������� ���������----',10,1) return;
--drop trigger TRIG_Inst
delete from ������ where [�������� ������]='XXXX'
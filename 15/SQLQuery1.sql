use [Фирма по продаже автозапчастей]
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

create trigger TRIG_Det  on Детали after INSERT, DELETE, UPDATE  
as declare @a1 varchar(20), @a2 nvarchar(50), @a3 int, @in varchar(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print 'Событие: INSERT';
     set @a1 = (select [Код детали] from INSERTED);  
     set @a2 = (select [Название детали] from INSERTED);
     set @a3 = (select [Кол-во деталей на складе] from INSERTED);
     set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30));
     insert into TR_Tov(ST, TRN, C)  values('INS', 'TRIG_Det', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
    print 'Событие: DELETE';
    set @a1 = (select [Код детали] from deleted);
    set @a2 = (select [Название детали] from deleted);
    set @a3 = (select [Кол-во деталей на складе] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30));
    insert into TR_Tov(ST, TRN, C)  values('DEL', 'TRIG_Det', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print 'Событие: UPDATE'; 
    set @a1 = (select [Код детали] from inserted);
    set @a2 = (select [Название детали] from inserted);
    set @a3 = (select [Кол-во деталей на складе] from inserted);
    set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30));
    set @a1 = (select [Код детали] from deleted);
    set @a2 = (select [Название детали] from deleted);
    set @a3 = (select [Кол-во деталей на складе] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(30))+' '+cast(@a3 as varchar(30))+' '+@in;
    insert into TR_Tov(ST, TRN, C)  values('UPD', 'TRIG_Det', @in); 
end;  
return;  
--drop trigger TRIG_Det

insert into Детали([Код детали],[Название детали],[Кол-во деталей на складе])
values(10,'Анигиляторная пушка', 999)
select * from TR_Tov

insert into Детали([Код детали],[Название детали],[Кол-во деталей на складе])
values(11,'Ujh пушка', 500)
select * from TR_Tov

alter table Детали  add constraint [Кол-во деталей на складе] check([Кол-во деталей на складе] >= 2)
go 	
update Детали set [Кол-во деталей на складе] = 1 where [Название детали] = 'XXXX';
go

create trigger TRIG_Inst
on Детали instead of DELETE
as raiserror(N'----Удаление запрещено----',10,1) return;
--drop trigger TRIG_Inst
delete from Детали where [Название детали]='XXXX'
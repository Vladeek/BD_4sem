use TMPS_UNIVER;

--1. ����.����. ��� ����� ����� ����������
--STMT - �������, TRNAME - �����. ���
go
create trigger TR on AUDITORIUM_TYPE instead of INSERT
as
begin
	DECLARE curs CURSOR local for SELECT AUDITORIUM_TYPENAME from AUDITORIUM_TYPE;
	declare @numb nvarchar(30), @aud nvarchar(30), @count int, @type nvarchar(5);
	set @count = 0;
	OPEN curs;
	fetch  curs into @aud;  
		while @@fetch_status = 0
		begin 		
			set @numb = (select AUDITORIUM_TYPENAME from INSERTED);
			set @type = (select AUDITORIUM_TYPE from INSERTED);
			if(@numb = @aud)
			set @count = @count + 1;
			if(@count > 1)
			begin
				raiserror('������ �������� ������������� ��������',10,1);
				rollback;
				--delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE=@type;
			end; 
			fetch curs into @aud;  
		end; 
	CLOSE curs;
end;
return;
--������� ���������,����� � ������
insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME) values('��_17','����������2');



--����������� AFTER-������� ��� ������� TEACHER, ������ �� ������� INSERT
--�����. ������ �������� ������ � ������� TR_AUDIT
--� ������� �� ���������� �������� �������� �������� ������. 

drop table TR_AUDIT


go 
create table TR_AUDIT
(
ID int identity,
STMT varchar(20)
check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50),
CC varchar(300)
)

	drop trigger TR_TEACHER_INS


	go
    create  trigger TR_TEACHER_INS 
      on TEACHER after INSERT  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print '�������';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER_INS', @in);	         
      return;  
      go

	  insert into  TEACHER values('����', '������', '�', '����');
	  select * from TR_AUDIT
	  --delete from TEACHER where TEACHER='����';



--2
--������� AFTER-������� � ������ TR_TEACHER_DEL ��� ������� TEACHER, ����������� 
--�� ������� DELETE. ������� TR_TEACHER_DEL ������ ���������� ����-�� ������ � ������� TR_AUDIT 
--��� ������ ��������� ������. � ������� �� ���������� �������� ������� TEACHER ��������� ����-��. 

go
    create  trigger TR_TEACHER_DEL 
      on TEACHER after DELETE  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print '��������';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER_DEL', @in);	         
      return;  
      go 
	   delete TEACHER where TEACHER='����'
	  select * from TR_AUDIT

	

--3
--������� AFTER-������� � ������ TR_TEACHER_UPD ��� ������� TEACHER, ����������� �� ������� UPDATE. 
--������� TR_TEACHER_UPD ������ ���������� ����-�� ������ � ������� TR_AUDIT ��� ������ ���������� ������. 
--� ������� �� ���������� �������� ���� �������� ���������� ������ �� � ����� ���������.

go
    alter  trigger TR_TEACHER_DEL 
      on TEACHER after UPDATE  
      as
      declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	  declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 

      print '����������';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      set @a1 = (select TEACHER from deleted);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in =@in + '' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER_UPD', @in);	         
      return;  
      go

	  update TEACHER set GENDER = '�' where TEACHER='����'
	  select * from TR_AUDIT

	  delete from TR_AUDIT where STMT = 'UPD'

--4 
--������� AFTER-������� � ������ TR_TEACHER ��� ������� TEACHER, ���-�������� �� ������� 
--INSERT, DELETE, UPDATE. ������� TR_TEACHER ������ ��-�������� ������ ������ � ������� TR_AUDIT 
--��� ������ ���������� ������. � ���� ������-�� ���������� �������, ���������������� ������� � 
--��������� � ������� �� �����������-���� ������� ����������. ����������� ���-�����, ��������������� 
--����������������� ��������. 

go
create trigger TR_TEACHER   on TEACHER after INSERT, DELETE, UPDATE  
 as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	  declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
   if  @ins > 0 and  @del = 0
   begin
   print '�������: INSERT';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER_INS', @in);	
	 end;
	else		  	 
    if @ins = 0 and  @del > 0
	begin
	print '�������: DELETE';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER_DEL', @in);
	  end;
	else	  
    if @ins > 0 and  @del > 0
	begin
	print '�������: UPDATE'; 
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      set @a1 = (select TEACHER from deleted);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in =@in + '' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER_UPD', @in); 
	  end;
	  return;  

	  delete TEACHER where TEACHER='����'
	  insert into  TEACHER values('����', '������', '�', '����');
	  	  update TEACHER set GENDER = '�' where TEACHER='����'
	  select * from TR_AUDIT

--5
--����������� ��������, ������� ������������� �� ������� ���� ������ X_BSTU, ��� ������-��
-- ����������� ����������� ����������� �� ������������ AFTER-��������.


update TEACHER set GENDER = '�' where TEACHER='����'
 select * from TR_AUDIT

--6
--������� ��� ������� TEACHER ��� AFTER-�������� � �������: TR_TEACHER_ DEL1, TR_TEACHER_DEL2 � TR_TEACHER_ DEL3. 
--�������� ������ ����������� �� ����-��� DELETE � ����������� ��������������� ������ � ������� TR_AUDIT.

go   
create trigger AUD_AFTER_DEL1 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL1';
 return;  
go 
create trigger AUD_AFTER_DEL2 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL2';
 return;  
go  
create trigger AUD_AFTER_DEL3 on FACULTY after DELETE  
as print 'AUD_AFTER_DEL3';
 return;  
go    


select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL3', 
	                        @order='First', @stmttype = 'DELETE';
exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL2', 
	                        @order='Last', @stmttype = 'DELETE';


select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='FACULTY' and e.type_desc = 'DELETE';
 
--7

--����������� ��������, ��������������� �� ������� ���� ������ X_BSTU �����������: 
--AFTER-������� �������� ������ ����������, � ������ �������� ����������� ��������, ����-������������ �������.


use TMPS_UNIVER;
go 
	create trigger PTran 
	on PULPIT after INSERT, DELETE, UPDATE  
	as declare @c int = (select count (*) from PULPIT); 	 
	 if (@c >26) 
	 begin
       raiserror('����� ���������� ������ �� ����� ���� >26', 10, 1);
	 rollback; 
	 end; 
	 return;          

	insert into PULPIT(PULPIT) values ('����')

--8

--������� ��� ������� FACULTY INSTEAD OF-�������, ����������� �������� ����� � �������. 
--����������� ��������, ������� ���������-���� �� ������� ���� ������ X_BSTU, 
--��� �������� ����������� ����������� ���������, ���� ���� INSTEADOF-�������.

--� ������� ��������� DROP ������� ��� DML-��������, ��������� � ���� ������������ ������.



use TMPS_UNIVER;
	go 
	create trigger F_INSTEAD_OF 
	on FACULTY instead of DELETE 
	as 
raiserror(N'�������� ���������', 10, 1);
	return;

	 delete FACULTY where FACULTY = '����'

	 drop trigger F_INSTEAD_OF
	 drop trigger PTran
	 drop trigger TR_TEACHER
	 drop trigger TR_TEACHER_DEL

go



  use TMPS_UNIVER
  go	

  create  trigger DDL_PRODAJI on database 
                          for DDL_DATABASE_LEVEL_EVENTS  as   
  declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
  declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
  declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
  if @t1 = 'TMPS_UNIVER' 
  begin
       print '��� �������: '+@t;
       print '��� �������: '+@t1;
       print '��� �������: '+@t2;
       raiserror( N'�������� � �������� ������ ���������', 16, 1);  
       rollback;    
   end;

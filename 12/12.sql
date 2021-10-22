

--------------------------------1

use BVA_UNIVER
go

set nocount on --��������� ����������� ���������, ���������� ���-�� ������������ �������
if exists(select * from sys.objects -- sys.objects �������� �� ����� ������ ��� ������� 
--������������� ������������� ������� ������� �����, ������� ��������� � ���� ������,
--������� ���������������� � ����������� ���� ��������� ������������ ������������� �������.
					where OBJECT_ID=object_id(N'DBO.MyTable'))  --N'' ��������� ���������� ������ � �������
drop table MyTable;

declare @MyCount int, @flag char ='r';
set implicit_transactions on
create table MyTable(K int);
	insert MyTable values(1),(2),(3);
	set @MyCount = (select count(*) from MyTable);
	print '���-�� ������� � MyTable:'+cast(@MyCount as varchar(2));
	if @flag='c' commit;
	else rollback;
set implicit_transactions off

if exists (select * from sys.objects
					where OBJECT_ID=object_id(N'DBO.MyTable'))
print '������� ����������';
else print '������� �� ����������'


--------------------------------2

use BVA_UNIVER
begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM='206-1';
		insert AUDITORIUM values ('999-9','���-��', 15, '999-9');
		insert AUDITORIUM values ('888-8','��-�', 15, '888-8');
		commit tran;
	end try
	begin catch
		print '������: '+case
		when error_number() = 2627 and patindex('%PK_AUDITORIUM%',error_message())>0
		then '������������'
		else '����������� ������'+cast(error_number() as varchar(5))+error_message()
		end;
	if @@trancount > 0 rollback tran;
end catch;


--------------------------------3

use BVA_UNIVER
declare @point varchar(32);
begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM='206-1';
		insert AUDITORIUM values ('888-8','��-�', 15, '888-8');
		set @point = 'p1';
		save tran @point;
		insert AUDITORIUM values ('999-9','���-��', 15, '999-9');
		set @point = 'p2';
		save tran @point;
	end try
	begin catch
		print '����������� �����: '+@point+'������: '+case
		when error_number() = 2627 and patindex('%PK_AUDITORIUM%',error_message())>0
		then '������������'
		else '����������� ������'+cast(error_number() as varchar(5))+error_message()
		end;
		if @@trancount > 0
			rollback tran @point;
	end catch;
commit tran

--------------------------------4

use BVA_UNIVER

set transaction isolation level read uncommitted
begin transaction 
select count(*) from AUDITORIUM

begin tran
delete from AUDITORIUM where AUDITORIUM='301-1'

select count(*) from AUDITORIUM 

rollback tran

select count(*) from AUDITORIUM

--------------------------------5

use BVA_UNIVER

set transaction isolation level read committed
begin tran
select count(*) from AUDITORIUM

begin tran
delete from AUDITORIUM where AUDITORIUM='888-8'

select count(*) from AUDITORIUM

rollback tran

select count(*) from AUDITORIUM



set transaction isolation level read committed
begin tran
select count(*) from AUDITORIUM

begin tran
/*insert AUDITORIUM values ('400-4','��', 1, '400-4');*/
delete from AUDITORIUM where AUDITORIUM='400-4'
commit tran

select count(*) from AUDITORIUM

commit tran


--------------------------------6

/*set transaction isolation level repeatable read
begin transaction
select  SUBJECT, IDSTUDENT, NOTE from PROGRESS where NOTE=5
												and PROGRESS.SUBJECT='��';

select  case
when SUBJECT = '��' then 'aaa'  else ' ' 
end '���������', SUBJECT, IDSTUDENT from PROGRESS  where NOTE = 5 and SUBJECT='��';
commit; 

begin transaction
insert PROGRESS values('��',1003,'2013-10-01', 5);
commit;*/
/*???????????*/
insert AUDITORIUM values ('222-7','��', 1, '222-7');

set transaction isolation level repeatable read
begin tran
select count(*) from AUDITORIUM

begin tran
delete from AUDITORIUM where AUDITORIUM='222-7'

commit tran
select count(*) from AUDITORIUM

commit tran

---------

insert AUDITORIUM values ('160-0','��', 100, '160-4');

set transaction isolation level repeatable read
begin tran
select count(*) from AUDITORIUM

begin tran
insert AUDITORIUM values ('170-9','��', 100, '172-9');
commit tran

select count(*) from AUDITORIUM

--------------------------------7

set transaction isolation level serializable
begin transaction
delete STUDENT where IDSTUDENT=1111;
insert STUDENT values(9,'SOMETHING','30/12/1999',null,null,null);
update STUDENT set IDGROUP=12 where NAME='SOMETHING';
select * from STUDENT where IDGROUP=12;

commit;

set transaction isolation level read committed
begin transaction
delete STUDENT where NAME='SOMETHING';
insert STUDENT values(17,'WRONG','25/12/1997',null,null,null);
update STUDENT set IDGROUP=12 where NAME='WRONG';
select * from STUDENT where IDGROUP=12;
commit

select * from STUDENT where IDGROUP=12;

------------

/*set transaction isolation level serializable
begin tran
select count(*) from AUDITORIUM

begin tran
insert AUDITORIUM values ('171-2','��', 100, '171-2');


commit tran*/
--------------------------------8

/*begin tran
	select * from STUDENT where IDGROUP=11;
	begin tran
	select * from STUDENT where IDGROUP=11 or IDGROUP=12;
	commit;
	if @@trancount > 0 rollback;
select 
	(select count(*) from STUDENT where IDGROUP=14) '14 group count',
	(select count(*) from STUDENT where IDGROUP=17) '17 group count';	*/ 



-- �������� ���������� 1
BEGIN TRANSACTION

-- ��������� ������ ������ � ������� �������
INSERT INTO AUDITORIUM
VALUES ('0-0', '��', 120, '0-0')

-- �������� ���������� 2
BEGIN TRANSACTION

-- �������� ������ � ��������� ������
UPDATE AUDITORIUM
SET AUDITORIUM_CAPACITY = 90
WHERE [AUDITORIUM_NAME] LIKE '0-0'

SELECT * FROM AUDITORIUM
ROLLBACK TRANSACTION

-- ���������� ���������
--COMMIT TRANSACTION
--
-- ������� ��� ������ �� �������
SELECT * FROM AUDITORIUM
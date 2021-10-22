--1 ��������� ������� �������� ���������� ��������� �� ��������� ����������
--(��.����.)
use BVA_UNIVER
go
create function COUNT_STUDENTS(@faculty nvarchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count(IDSTUDENT) from STUDENT join GROUPS
    on STUDENT.IDGROUP = GROUPS.IDGROUP
	join FACULTY
	    on GROUPS.FACULTY = FACULTY.FACULTY
		    where FACULTY.FACULTY = @faculty);
return @rc;
end; go
declare @n int = dbo.COUNT_STUDENTS('����');
print '���������� ���������: ' + cast(@n as varchar(4));



-- + @prof
go
alter function COUNT_STUDENTS(@faculty varchar(20) = null, @prof varchar(20) = '1-40 01 02') returns int
as begin
declare @rc int = 0;
set @rc = (
SELECT count(IDSTUDENT) from FACULTY inner join GROUPS
	on FACULTY.FACULTY = GROUPS.FACULTY
	inner join STUDENT
		on GROUPS.IDGROUP = STUDENT.IDGROUP
			where FACULTY.FACULTY = @faculty and GROUPS.PROFESSION = @prof);
return @rc;
end; go
declare @n int = dbo.COUNT_STUDENTS('����', '1-40 01 02');
print '���������� ���������: ' + cast(@n as varchar(4));





--2. ��������� ������� FSUBJECTS, �����. @p (��� ������� = SUBJECT.PULPIT)
-- �����. ������ � �������� ���������
go
create function FSUBJECTS(@p varchar(20)) returns varchar(300)
as begin
declare @sb varchar(10), @s varchar(100) = '';
declare sbj cursor local static
    for select distinct SUBJECT from SUBJECT 
	    where PULPIT like @p;
open sbj;
fetch sbj into @sb;
while @@FETCH_STATUS = 0
begin
	set @s = @s + RTRIM(@sb) + ', ';
	fetch sbj into @sb;
end;
return @s
end;


go 
select distinct PULPIT, dbo.FSUBJECTS(PULPIT)[����������] from SUBJECT;




--3. ��������� �., �����: ��� ��� + ��� �������
-- ���� ��� ����� NULL, �����. ������ ���� ������ �� ���
-- ���� ������ NULL, �����. ��� ������� ���. ���
-- ���� ������ NULL, �����. ������, �����-��� ���. �������
-- ���� ��� �� NULL, �����. ������, �����-��� ���. ������� �� ���. ���
-- ���� ������ �������. ������, �����. ������ ���.�����
go
create function FFACPUL(@f varchar(20), @p varchar(20)) returns table
as return
select FACULTY.FACULTY, PULPIT.PULPIT from FACULTY left outer join PULPIT
  on FACULTY.FACULTY = PULPIT.FACULTY
   where FACULTY.FACULTY = ISNULL(@f, FACULTY.FACULTY) and --������ ��������, �� ������ null
    PULPIT.PULPIT = ISNULL(@p, PULPIT.PULPIT);

go
select * from dbo.FFACPUL(null, null);
select * from dbo.FFACPUL('����', null);
select * from dbo.FFACPUL(null, '����');
select * from dbo.FFACPUL('����', '����');





--4. ��������� �., ���� ����� (��� �������)
-- �����. ���-�� �������� �� ���.�������
-- ���� (NULL), �����. ����� ���-�� ����������
go
create function FCTEACHER(@p varchar(20)) returns int
as begin
declare @rc int = (select count(TEACHER) from TEACHER where PULPIT = ISNULL(@p, PULPIT));
return @rc;
end;

go 
select PULPIT, dbo.FCTEACHER(PULPIT)[���������� ��������������] from TEACHER;
select dbo.FCTEACHER(null)[����� ���������� ��������������];

--������� ���������� ��������� �� ����������
go
create function COUNT_stud(@f varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(NAME)
from STUDENT z join GROUPS zk
on z.IDGROUP=zk.IDGROUP
where FACULTY = @f) ;
return @rc;
end;
select dbo.COUNT_stud('����')
end
--������� ���������� ������ �� ����������

go

create function COUNT_pulpit(@f varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(PULPIT) from PULPIT where FACULTY = @f) ;
return @rc;
end;
select dbo.COUNT_pulpit('����')

--������� ���������� ����� �� ����������

go
create function COUNT_group(@f varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(IDGROUP) from GROUPS where FACULTY = @f) ;
return @rc;
end;
select dbo.COUNT_group('����')

--������� ���������� �������������� �� ����������
go
create function COUNT_prof(@f varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(PROFESSION) from PROFESSION where FACULTY = @f) ;
return @rc;
end;
select dbo.COUNT_prof('����')

--
go
create function FACULTY_REPORT(@c varchar(20))
returns @fr table
( [���������] varchar(50), [���������� ������] int, [���������� �����] int,
[���������� ���������] int, [���������� ��������������] int )

begin
insert @fr values( @c,
(select dbo.COUNT_pulpit(@c)),
(select dbo.COUNT_group(@c)),
(select dbo.COUNT_stud(@c)),
(select dbo.COUNT_prof(@c))
);

return; end;

drop function FACULTY_REPORT

select * from dbo.FACULTY_REPORT('����')
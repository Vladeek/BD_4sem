use BVA_UNIVER
go
CREATE VIEW [�������������]
	as select TEACHER [���],
			  TEACHER_NAME [��� �������������],
			  GENDER [���],
			  PULPIT [��� �������] from TEACHER;
go
CREATE VIEW [���������� ������]
		as select FACULTY.FACULTY_NAME [���������],
		count(PULPIT.PULPIT)[���������� ������]
		from FACULTY  join PULPIT 
		on FACULTY.FACULTY=PULPIT.FACULTY
		GROUP BY FACULTY.FACULTY_NAME
		go
Drop view [���������� ������]
go

CREATE VIEW ���������(���, [������������ ���������])
	as select 
	AUDITORIUM,
	AUDITORIUM_NAME
	from AUDITORIUM
	where AUDITORIUM.AUDITORIUM_TYPE='��'
	go 
	select * from ���������

	insert ��������� values ('401-4', '401-4')
Drop view [���������]
go
CREATE VIEW ����������_���������(���, [������������ ���������], [��� ���������])
	as select 
	AUDITORIUM,
	AUDITORIUM_NAME,
	AUDITORIUM_TYPE
	from AUDITORIUM
	where  AUDITORIUM.AUDITORIUM_TYPE Like'��%' with check option
	go
	insert ����������_��������� values ('1200-4','1200-4','��-�');

Drop view ����������_���������
go
CREATE VIEW ����������(���,[������������ ����������], [��� �������])
	as select top 100
	SUBJECT,
	SUBJECT_NAME,
	PULPIT
	from SUBJECT
	order by SUBJECT
	go
	select * from ����������
go
ALTER VIEW [���������� ������] WITH SCHEMABINDING
		as select FACULTY.FACULTY_NAME [���������],
		count(PULPIT.PULPIT)[���������� ������]
		from dbo.FACULTY  join dbo.PULPIT 
		on FACULTY.FACULTY=PULPIT.FACULTY
		GROUP BY FACULTY.FACULTY_NAME
		go
		select * from [���������� ������]
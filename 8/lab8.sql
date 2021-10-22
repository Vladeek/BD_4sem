use BVA_UNIVER
go
CREATE VIEW [Преподователь]
	as select TEACHER [код],
			  TEACHER_NAME [имя преподователя],
			  GENDER [Пол],
			  PULPIT [Код кафедры] from TEACHER;
go
CREATE VIEW [Количество кафедр]
		as select FACULTY.FACULTY_NAME [факультет],
		count(PULPIT.PULPIT)[Количество кафедр]
		from FACULTY  join PULPIT 
		on FACULTY.FACULTY=PULPIT.FACULTY
		GROUP BY FACULTY.FACULTY_NAME
		go
Drop view [Количество кафедр]
go

CREATE VIEW Аудитории(Код, [наименование аудитории])
	as select 
	AUDITORIUM,
	AUDITORIUM_NAME
	from AUDITORIUM
	where AUDITORIUM.AUDITORIUM_TYPE='ЛК'
	go 
	select * from Аудитории

	insert Аудитории values ('401-4', '401-4')
Drop view [Аудитории]
go
CREATE VIEW Лекционные_аудитории(Код, [наименование аудитории], [тип аудитории])
	as select 
	AUDITORIUM,
	AUDITORIUM_NAME,
	AUDITORIUM_TYPE
	from AUDITORIUM
	where  AUDITORIUM.AUDITORIUM_TYPE Like'ЛК%' with check option
	go
	insert Лекционные_аудитории values ('1200-4','1200-4','ЛК-К');

Drop view Лекционные_аудитории
go
CREATE VIEW Дисциплины(код,[наименование дисциплины], [код кафедры])
	as select top 100
	SUBJECT,
	SUBJECT_NAME,
	PULPIT
	from SUBJECT
	order by SUBJECT
	go
	select * from Дисциплины
go
ALTER VIEW [Количество кафедр] WITH SCHEMABINDING
		as select FACULTY.FACULTY_NAME [факультет],
		count(PULPIT.PULPIT)[Количество кафедр]
		from dbo.FACULTY  join dbo.PULPIT 
		on FACULTY.FACULTY=PULPIT.FACULTY
		GROUP BY FACULTY.FACULTY_NAME
		go
		select * from [Количество кафедр]
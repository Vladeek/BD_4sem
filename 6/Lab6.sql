use BVA_UNIVER
--список наим кафедр, на специальности которых содержитс€ слово технолог
select PULPIT.PULPIT_NAME,FACULTY.FACULTY,PROFESSION_NAME
from faculty,pulpit,profession
where pulpit.FACULTY=FACULTY.FACULTY and PROFESSION.FACULTY=FACULTY.FACULTY
and PROFESSION.PROFESSION_NAME in(select PROFESSION.PROFESSION_NAME from PROFESSION where (PROFESSION.PROFESSION_NAME like '%технолог%'));

select PULPIT.PULPIT_NAME,FACULTY.FACULTY,PROFESSION.PROFESSION_NAME
from PROFESSION join FACULTY
on faculty.FACULTY=PROFESSION.FACULTY
join pulpit on pulpit.FACULTY=FACULTY.FACULTY
where PROFESSION.PROFESSION_NAME in(select PROFESSION.PROFESSION_NAME from PROFESSION where (PROFESSION.PROFESSION_NAME like '%технолог%'));

select PULPIT.PULPIT_NAME,FACULTY.FACULTY,PROFESSION.PROFESSION_NAME
from PROFESSION join FACULTY
on faculty.FACULTY=PROFESSION.FACULTY
join pulpit on pulpit.FACULTY=FACULTY.FACULTY
where PROFESSION.PROFESSION_NAME like '%технолог%';
--список аудиторий самых больших вместимостей
select AUDITORIUM_CAPACITY , AUDITORIUM_TYPE, AUDITORIUM_NAME
from AUDITORIUM a
where AUDITORIUM_CAPACITY=(select top(1) AUDITORIUM_CAPACITY from AUDITORIUM aa
 where a.AUDITORIUM_TYPE=aa.AUDITORIUM_TYPE
 order by AUDITORIUM_CAPACITY desc  );
 --список наим фак-тов, на которых нет ни одной кафедры
select FACULTY_NAME
from FACULTY
where not exists (select * from PULPIT where PULPIT.FACULTY=FACULTY.FACULTY)

--сформировать строку, содержащую ср знач оценок по 3 дисциплинам
select top(1) (select avg(Note) from PROGRESS where PROGRESS.SUBJECT='ќјиѕ') [ќјиѕ],
(select avg(Note) from PROGRESS where PROGRESS.SUBJECT='Ѕƒ') [Ѕƒ],
(select avg(Note) from PROGRESS where PROGRESS.SUBJECT='—”Ѕƒ') [—”Ѕƒ]
from PROGRESS;
--запрос  с применением оператора all
select progress.subject,progress.note, STUDENT.NAME from PROGRESS
join STUDENT
on PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT
where note >=all(select note from PROGRESS where SUBJECT like 'ќјиѕ');

select progress.subject,progress.note, STUDENT.NAME from PROGRESS
join STUDENT
on PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT
where note >any(select note from PROGRESS where SUBJECT like 'ќјиѕ');





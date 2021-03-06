use BVA_UNIVER
SELECT min(AUDITORIUM_CAPACITY)[??????????? ???????????],
	   max(AUDITORIUM_CAPACITY)[???????????? ???????????],
	   count (*)[?????????? ?????????],
	   avg(AUDITORIUM_CAPACITY)[??????? ???????????],
	   sum(AUDITORIUM_CAPACITY)[????????? ???????????]
from AUDITORIUM







SELECT AUDITORIUM_TYPENAME,
		min(AUDITORIUM_CAPACITY)[??????????? ???????????],
	   max(AUDITORIUM_CAPACITY)[???????????? ???????????],
	   count (*)[?????????? ?????????],
	   avg(AUDITORIUM_CAPACITY)[??????? ???????????],
	   sum(AUDITORIUM_CAPACITY)[????????? ???????????]
FROM AUDITORIUM, AUDITORIUM_TYPE
	where AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
	group by AUDITORIUM_TYPENAME





SELECT *
FROM (select Case when NOTE between 5 and 10 then '?????? ?? 5 ?? 10'
	else '?????? ?????? 5'
	end [????????????? ??????], Count(*)[??????????]
FROM PROGRESS Group by case
	when NOTE between 5 and 10 then '?????? ?? 5 ?? 10'
	else '?????? ?????? 5'
	end) as T
		ORDER BY Case [????????????? ??????]
		when '?????? ?? 5 ?? 10' then 2
		when '?????? ?????? 5' then 1
		else 0
		end





SELECT f.FACULTY,
	   g.PROFESSION,
	   round(avg(cast(p.NOTE as float(5))),2)[??????? ??????]
FROM FACULTY f inner join GROUPS g
	on f.FACULTY=g.FACULTY
	inner join STUDENT s
	on g.IDGROUP=s.IDGROUP
	inner join PROGRESS p
	on s.IDSTUDENT=p.IDSTUDENT
GROUP BY f.FACULTY,
		 g.PROFESSION,
		 p.NOTE,
		 s.IDSTUDENT
		 order by [??????? ??????] desc




		 select FACULTY.FACULTY_NAME, GROUPS.PROFESSION,
round(avg(cast(PROGRESS.NOTE as float(4))),2) [??????? ??????]
from FACULTY inner join GROUPS
on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT
on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
group by FACULTY.FACULTY_NAME,
GROUPS.PROFESSION

order by [??????? ??????] desc




SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT,avg(PROGRESS.NOTE) [??????? ??????]
FROM FACULTY inner join GROUPS
on FACULTY.FACULTY=GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP=STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
WHERE FACULTY.FACULTY='???'
GROUP BY rollup (FACULTY.FACULTY, PROFESSION, SUBJECT) 




SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT,avg(PROGRESS.NOTE) [??????? ??????]
FROM FACULTY inner join GROUPS
on FACULTY.FACULTY=GROUPS.FACULTY
inner join STUDENT
on GROUPS.IDGROUP=STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
WHERE FACULTY.FACULTY='???'
GROUP BY cube (FACULTY.FACULTY, PROFESSION, SUBJECT)




SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, avg(PROGRESS.NOTE) [??????? ??????]
From GROUPS
inner join STUDENT
on GROUPS.IDGROUP=STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
where GROUPS.FACULTY='???'
GROUP BY PROFESSION, SUBJECT
	UNION
SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, avg(PROGRESS.NOTE) [??????? ??????]
From GROUPS
inner join STUDENT
on GROUPS.IDGROUP=STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
where GROUPS.FACULTY='????'
GROUP BY PROFESSION, SUBJECT
	




	SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, avg(PROGRESS.NOTE) [??????? ??????]
From GROUPS
inner join STUDENT
on GROUPS.IDGROUP=STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
where GROUPS.FACULTY='???'
GROUP BY PROFESSION, SUBJECT
	except
SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, avg(PROGRESS.NOTE) [??????? ??????]
From GROUPS
inner join STUDENT
on GROUPS.IDGROUP=STUDENT.IDGROUP
inner join PROGRESS
on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
where GROUPS.FACULTY='????'
GROUP BY PROFESSION, SUBJECT




SELECT S1.SUBJECT, S1.NOTE,
	(select count(*) from PROGRESS S2
	where S1.SUBJECT= S2.SUBJECT
	and S1.NOTE= S2.NOTE) [??????????]
FROM PROGRESS S1
	GROUP BY S1.SUBJECT, S1.NOTE
	HAVING NOTE=9 or NOTE=8
	ORDER BY [??????????] desc








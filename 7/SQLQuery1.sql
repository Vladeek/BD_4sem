USE [????? ?? ??????? ?????????????]
SELECT min(????)[??????????? ????],
	   max(????)[???????????? ????],
	   count (*)[?????????? ???????],
	   avg(????)[??????? ????],
	   sum(????)[????????? ????]
FROM ??????

SELECT [???????? ??????],
       min(????)[??????????? ????],
	   max(????)[???????????? ????],
	   count (*)[?????????? ???????],
	   avg(????)[??????? ????],
	   sum(????)[????????? ????]
FROM ??????
	group by [???????? ??????]

SELECT *
FROM (select Case when ???? between 2 and 100 then '???? ?? 2 ?? 100'
	else '???? ?????? 2'
	end [????], Count(*)[??????????]
FROM ?????? Group by case
	when ???? between 2 and 100 then '???? ?? 2 ?? 100'
	else '???? ?????? 2'
	end) as T
		ORDER BY Case [????]
		when '???? ?? 5 ?? 10' then 2
		when '???? ?????? 5' then 1
		else 0
		end


SELECT f.[??? ??????????],
       f.[???? ????????],
	   g.[???????? ??????],
	   round(avg(cast(g.???? as float(5))),2)[??????? ????]
FROM ???????? f inner join ?????? g
	on f.[??? ??????]=g.[??? ??????]
	where g.[???-?? ??????? ?? ??????]>=f.???????????
GROUP BY f.[???? ????????],
		 f.[??? ??????????],
		 g.[???????? ??????],
		 g.????,
		 g.[???-?? ??????? ?? ??????]
		 order by [??????? ????] desc


select [???????? ??????],????,SUM([???-?? ??????? ?? ??????])as [???-??] 
from ??????
where [???????? ??????] in ('?????? ???','????? ??????????')
group by rollup ([???????? ??????],????)

select [???????? ??????],????,SUM([???-?? ??????? ?? ??????])as [???-??] 
from ??????
where [???????? ??????] in ('?????? ???','????? ??????????')
group by cube ([???????? ??????],????)


select ????????,??????????.[??? ????????]
from ????????, ??????????
where ???????? in ('???????')
group by ????????,??????????.[??? ????????]
union
select ????????,??????????.[??? ????????]
from ????????,??????, ??????????
where ???????? in ('????????')
group by ????????,??????????.[??? ????????]


select ????????,??????????.[??? ??????????]
from ????????, ??????????
where ???????? in ('???????')
group by ????????,??????????.[??? ??????????]
union all
select ????????,??????????.[??? ??????????]
from ????????,??????, ??????????
where ???????? in ('????????')
group by ????????,??????????.[??? ??????????]


select [??? ??????]
from ??????
intersect
select [??? ??????]
from ????????


select [??? ??????]
from ??????
except
select [??? ??????]
from ????????
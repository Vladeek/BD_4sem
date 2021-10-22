use [����� �� ������� �������������]
go

exec SP_HELPINDEX '������'
exec SP_HELPINDEX '��������'
exec SP_HELPINDEX '����������'

select * from ������ where [��� ������] between 2 and 7 order by [��� ������]
checkpoint;  --�������� ��
DBCC DROPCLEANBUFFERS;  --�������� �������� ���
CREATE index ������_��� on ������([��� ������] asc)

create table  #EXP
(	aa int, 
	bb int,
	TFIELD2 varchar(100) 
);
SET nocount on;
DECLARE @ii int=0
while @ii<10000
begin 
	insert #EXP(aa, bb, TFIELD2)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('������', 10));
	set @ii=@ii+1;
end;

create index #EXP_NONCLU on #EXP(aa, bb)

select * from  #EXP where  aa>1500 and  bb < 100; -- �� ��������
select * from  #EXP order by  aa, bb -- �� ��������
select * from  #EXP where  aa = 556 and  bb > 3

drop table #EXP
drop index #EXP_NONCLU on #EXP

create table  #EXP2
(	aaa int, 
	bbb int,
	TFIELD2 varchar(100) 
);
SET nocount on;
DECLARE @iii int=0
while @iii<10000
begin 
	insert #EXP2(aaa, bbb, TFIELD2)
	values (floor(2000*RAND()), floor(200*RAND()), REPLICATE('������', 10));
	set @iii=@iii+1;
end;

select bbb from #EXP2 where aaa>1500

create index #EXP_NONCLU on #EXP2(aaa) include (bbb)

drop table #EXP2
drop index #EXP_NONCLU on #EXP2
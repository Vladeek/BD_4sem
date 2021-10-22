use [Фирма по продаже автозапчастей]
go

CREATE procedure countOfsales
as begin
	DECLARE @n int = (SELECT count(*) from Детали);
	SELECT [Название детали], [Код детали], [Кол-во деталей на складе] from Детали;
	return @n;
end;
--DROP procedure countOfsales
DECLARE @k int;
EXEC @k = countOfsales; -- вызов процедуры 
print 'Количество поставок: ' + cast(@k as varchar(3));
go


use [Фирма по продаже автозапчастей]
go
ALTER procedure countOfsales @p varchar(20), @c nvarchar(2) output
as begin
	SELECT * from Детали where [Название детали] = @p;
	set @c = cast(@@rowcount as nvarchar(2));
end;

DECLARE @k1 int, @k2 nvarchar(2);
EXEC @k1 = countOfsales @p = 'Правый поворотник', @c = @k2 output; -- выходной
print 'Количество деталей: ' + @k2;
go

use [Фирма по продаже автозапчастей]
go

ALTER procedure countOfsales @p varchar(20)
as begin
	SELECT * from Детали where [Название детали] = @p;
end;


CREATE table #Zakaziki
(
	[Код детали] [int] NOT NULL,
	[Название детали] [nvarchar](50) NULL,
	[Кол-во деталей на складе] [int] NULL,
	[Артикул] [nvarchar](50) NULL,
	[Примечание] [nvarchar](50) NULL,
);
INSERT #Zakaziki EXEC countOfsales @p = 'Ремень ГРМ';
INSERT #Zakaziki EXEC countOfsales @p = 'Правый поворотник';
SELECT * from #Zakaziki;
go
use [����� �� ������� �������������]
go

CREATE procedure countOfsales
as begin
	DECLARE @n int = (SELECT count(*) from ������);
	SELECT [�������� ������], [��� ������], [���-�� ������� �� ������] from ������;
	return @n;
end;
--DROP procedure countOfsales
DECLARE @k int;
EXEC @k = countOfsales; -- ����� ��������� 
print '���������� ��������: ' + cast(@k as varchar(3));
go


use [����� �� ������� �������������]
go
ALTER procedure countOfsales @p varchar(20), @c nvarchar(2) output
as begin
	SELECT * from ������ where [�������� ������] = @p;
	set @c = cast(@@rowcount as nvarchar(2));
end;

DECLARE @k1 int, @k2 nvarchar(2);
EXEC @k1 = countOfsales @p = '������ ����������', @c = @k2 output; -- ��������
print '���������� �������: ' + @k2;
go

use [����� �� ������� �������������]
go

ALTER procedure countOfsales @p varchar(20)
as begin
	SELECT * from ������ where [�������� ������] = @p;
end;


CREATE table #Zakaziki
(
	[��� ������] [int] NOT NULL,
	[�������� ������] [nvarchar](50) NULL,
	[���-�� ������� �� ������] [int] NULL,
	[�������] [nvarchar](50) NULL,
	[����������] [nvarchar](50) NULL,
);
INSERT #Zakaziki EXEC countOfsales @p = '������ ���';
INSERT #Zakaziki EXEC countOfsales @p = '������ ����������';
SELECT * from #Zakaziki;
go
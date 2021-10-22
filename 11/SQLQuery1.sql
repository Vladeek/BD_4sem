use [Фирма по продаже автозапчастей]
go

go
declare @tid char(20), @tnm char(200);  
declare Tov cursor                              
for select [Название детали]
from Детали;
open Tov;	  
fetch  Tov into @tid;--Оператор FETCH считывает одну строку из результирующего набора и продвигает указатель на следующую строку   
print  'Товары:';   
set @tnm=cast(@tid as varchar(10))
while @@fetch_status = 0
begin
set @tnm = rtrim(@tid)+', '+@tnm;  
fetch  Tov into @tid; 
end;   
print @tnm;        
close  Tov;

go
declare @tid char(20), @tnm char(5), @tgn char(5);
declare tov cursor global                    
for select [Название детали], [Код детали], [Кол-во деталей на складе]   
from Детали where [Код детали] between 2 and 6;
open tov;                                             
fetch tov into @tid, @tnm, @tgn;
while @@fetch_status = 0                                     
begin 
print @tid + ' '+ @tnm + ' '+ @tgn;      
fetch  tov into @tid, @tnm, @tgn;                  
end;
close  tov;                                           
deallocate tov;

open tov;  

go 
declare @tid char(10), @tnm char(40), @tgn char(1);   
declare tov cursor local--локальный может применяться в рамках одного пакета и ресурсы, 
						--выделенные ему при объ-явлении, освобождаются сразу после завершения работы пакета.
for select t.[Название детали], t.[Код детали], t.[Кол-во деталей на складе] 
from Детали t where t.[Код детали] between 2 and 5;
open tov;  

fetch  tov into @tid, @tnm, @tgn;   
print '1. '+ @tid + ' '+ @tnm + ' '+ @tgn;                      
go 
declare @tid char(10), @tnm char(40), @tgn char(1); 
fetch  tov into @tid, @tnm, @tgn;  
print '2. '+@tid + ' '+ @tnm + ' '+ @tgn;

go 
declare tov cursor global--глобальный может быть объявлен, открыт и использован в разных пакетах.
--Выделенные ему ресурсы освобождаются после оператора DEALLOCATE или при завершении сеанса
for select t.[Название детали], t.[Код детали], t.[Кол-во деталей на складе]
from Детали t where t.[Код детали] between 2 and 5;
open tov;
go                       
declare @tid char(20), @tnm char(5), @tgn char(3);  
fetch  tov into @tid, @tnm, @tgn;  
print '1. '+ @tid + ' '+ @tnm + ' '+ @tgn;   
go 
declare @tid char(20), @tnm char(5), @tgn char(3);  
fetch  tov into @tid, @tnm, @tgn;  
print '2. '+@tid + ' '+ @tnm + ' '+ @tgn;  
close  tov;
go 
declare @tid char(20), @tnm char(5), @tgn char(3);  
open tov; 
fetch  tov into @tid, @tnm, @tgn;  
print '3. '+@tid + ' '+ @tnm + ' '+ @tgn;
close  tov;  

deallocate tov;--DEALLOCATE освобождение ресурсов глобального курсора
go 
open tov; 
go

go
declare @tid char(20), @tnm char(5), @tgn char(3);  
declare tov cursor local static--	статический курсор(приводит к выгрузке результирующего набора в TEMPDB)
for select [Название детали], [Код детали], [Кол-во деталей на складе] 
from Детали where [Код детали] between 1 and 9;  
						   
open tov;
print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 

update Детали set [Название детали] = 'Зеркало заднего вида' where [Название детали] = 'Ремень ГРММ';
delete Детали where [Название детали] = 'Правый поворотникк';

fetch  tov into @tid, @tnm, @tgn;     
while @@fetch_status = 0                                     
begin 
print @tid + ' '+ @tnm + ' '+ @tgn;      
fetch  tov into @tid, @tnm, @tgn; 
end;          
close  tov;

declare @tc char(50), @rn char(50);
declare orcs cursor local dynamic scroll --динамический курсор и SCROLL, позволяющий применять оператор FETCH с дополнительными опциями позиционирования.
for select row_number() over (order by [Название детали]) N,
[Название детали] from Детали
open orcs;
fetch orcs into @tc, @rn;
print 'предыдущая строка				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch prior from  orcs into @tc, @rn;
print 'последняя строка				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch next from orcs into @tc, @rn;
print 'следующая строка				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch absolute 3 from orcs into @tc, @rn;
print '3 строка с начала				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch absolute -3 from orcs into @tc, @rn;
print '3 строка с конца				:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch relative 5 from orcs into @tc, @rn;
print '5 строка с текущей позиции		:' + cast(@tc as varchar(3))+rtrim(@rn);
fetch relative -5 from orcs into @tc, @rn;
print '5 строка назад с текущей позиции:' + cast(@tc as varchar(3))+rtrim(@rn);
close dunam

go
declare @tid char(10), @tnm char(40), @tgn char(20);   
declare tov cursor local dynamic                            
for select [Название детали],[Код детали],[Кол-во деталей на складе] 
from Детали for update; 
open tov;  
fetch  tov into @tid, @tnm, @tgn; --удаление
fetch  tov into @tid, @tnm, @tgn;
update Детали set [Название детали] = 'XXXX' where current of tov;--только где текущая позиция курсора
close tov;

select * from Детали
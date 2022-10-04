Задача: Cоздать витрину данных для RFM-классификации пользователей приложения.

## 1.1. Выясните требования к целевой витрине.
структуру витрины (наименование, поля):
     наименование витрины: dm_rfm_segments
     поля в витрине:    
        user_id int
         recency int(число от 1 до 5)
         frequency int (число от 1 до 5)
         monetary_value int (число от 1 до 5)
назначение витрины: RFM-классификация пользователей приложения
расположение витрины: в той же базе, где находятся данные для витрины, но в схеме analysis
процедуры получения доступов: в задании не обсуждается вопрос доступов
данные, на основе которых построена витрина: production.orders, production.orderstatuslog
процесс сборки:
     
## 1.2. Изучите структуру исходных данных.

данные, на основе которых построена витрина: production.orders, production.orderstatuslog
поля для расчета из таблицы production.orders: user_id, order_ts, cost, status

## 1.3. Проанализируйте качество данных
Проведена проверка пользователей на уникальность и отсутствие дубликатов в production.orders по user_id (сравнение проведено с таблицей production.users)
       Проведена проверка заказов на отсутствие дубликатов в production.orders по полю order_id 
       Проведена проверка в таблицах production.orders, production.users, production.orderstatuses на отсутствие значений Null 
По данным в таблицах production.orders замечания:
Нет проверки что стаутс должен быть в диапазоне от 1..5
Нет внешнего ключа (fkey) для поля user_id

в целом по данным замечаний нет - дубликаты и значения Null отсутствуют


### 1.4.1. Сделайте VIEW для таблиц из базы production.**

```SQL
create or replace view analysis.orders --view с данными по заказам, пользователям, включая статус заказа
	as select * from production.orders;

create or replace view analysis.products --view с меню включая стоимость
	as select * from production.products;

create or replace view analysis.orderitmes --view с данными по каждому заказу разделенное по блюдам из меню
	as select * from production.orderitems;
	
create or replace view analysis.orderstatuses --view с описанием статуса заказа Open/Cooking/Delivering/Closed/Cancelled = 1/2/3/4/5 
	as select *	from production.orderstatuses;
	
create or replace view analysis.orderstatuslog --view с логами заказов и их прохождению по разным статусам 1/2/3/4/5
	as select * from production.orderstatuslog; 
	
```

### 1.4.2. Напишите DDL-запрос для создания витрины.**

Далее вам необходимо создать витрину. Напишите CREATE TABLE запрос и выполните его на предоставленной базе данных в схеме analysis.

```SQL
CREATE TABLE analysis.dm_rfm_segments (
	 user_id INT NOT NULL PRIMARY KEY,
	 recency INT NOT NULL CHECK(recency >= 1 AND recency <= 5),
	 frequency INT NOT NULL CHECK(frequency >= 1 AND frequency <= 5),
	  monetary_value INT NOT NULL CHECK(monetary_value >= 1 AND monetary_value <= 5)
	);
```

### 1.4.3. Напишите SQL запрос для заполнения витрины

Наконец, реализуйте расчет витрины на языке SQL и заполните таблицу, созданную в предыдущем пункте.

Для решения предоставьте код запроса.

```SQL
insert into analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
	select r.user_id, r.recency, f.frequency, m.monetary_value  
	from analysis.tmp_rfm_recency r
		join analysis.tmp_rfm_frequency f on r.user_id = f.user_id 
		join analysis.tmp_rfm_monetary_value m on r.user_id = m.user_id 

```

```SQL --запрос без 3-х таблиц tmp
insert into analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
--собираем заказы за 2022 год со статусом Closed
with orders as ( 
		select ord.user_id, ord.order_ts
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--собираем 3 параметра для каждого id клиента
users as (  
		select ord.user_id, 
		sum(coalesce(ord.payment,0)) as order_cost,
		max(coalesce(ord.order_ts,'2022-01-01'::timestamp)) as order_last_date,
		count(ord.*) as counted
		from analysis.orders ord
		group by 1),
--делим на 5 групп при помощи ntile на основе суммы заказа каждого клиента
monetary as( 
		select order_cost, ntile (5) over (order by orders2.order_cost) as monetary_value
			from (
				select order_cost from users group by 1) 
			as orders2),
--делим на 5 групп при помощи ntile на основе количества сделанных заказов
frequency as ( 
		select counted, ntile(5) OVER( order by fr.counted ) as frequency
			from (select counted from users group by 1) as fr ),
--делим на 5 групп при помощи ntile на основе последней даты заказа
recency as ( 
		select order_last_date, ntile(5) OVER(order by u.order_last_date) as recency
			from (select order_last_date from users group by 1) as u )
--заполняем поля в rfm_segments
select u.user_id as user_id, r.recency, f.frequency, m.monetary_value  
	from users u
	join recency r on r.order_last_date = u.order_last_date
	join frequency f on f.counted = u.counted
	join monetary m on m.order_cost = u.order_cost
```
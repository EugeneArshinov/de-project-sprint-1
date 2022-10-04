insert into analysis.tmp_rfm_recency 
--собираем заказы за 2022 год со статусом Closed
with orders as ( 
		select ord.user_id, ord.order_ts  
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--собираем последние даты заказа для каждого id клиента
users as ( 
  		select ord.user_id , max(coalesce(ord.order_ts,'2022-01-01'::timestamp)) as order_last_date
  			from analysis.orders ord
  			group by 1),
--делим на 5 групп при помощи ntile на основе последней даты заказа
recency as ( 
		select order_last_date, ntile(5) OVER(order by u.order_last_date) as recency
			from (select order_last_date from users group by 1) as u )
--заполняем поля в tmp_rfm_recency 
select u.user_id as user_id, r.recency
	from users u
	join recency r on r.order_last_date = u.order_last_date

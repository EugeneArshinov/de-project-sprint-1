insert into analysis.tmp_rfm_monetary_value 
--собираем заказы за 2022 год со статусом Closed
with orders as ( 
		select ord.user_id, ord.order_ts
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--собираем суммы по заказам для каждого id клиента
users as (  
		select ord.user_id, sum(coalesce(ord.payment,0)) as order_cost
		from analysis.orders ord
		group by 1),
--делим на 5 групп при помощи ntile на основе суммы заказа каждого клиента
monetary as( 
		select order_cost, ntile (5) over (order by orders2.order_cost) as monetary_value
			from (
				select order_cost from users group by 1) 
			as orders2)
--заполняем поля в tmp_rfm_monetary_value
select u.user_id as user_id, m.monetary_value  
	from users u
	join monetary m on m.order_cost = u.order_cost

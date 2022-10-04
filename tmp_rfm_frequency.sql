insert into analysis.tmp_rfm_frequency
--собираем заказы за 2022 год со статусом Closed
with orders as ( 
		select ord.user_id, ord.order_ts  
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--собираем количество заказов для каждого id клиента
users as ( 
  		select ord.user_id , count(ord.*) as counted
  			from analysis.orders ord
  			group by 1),
--делим на 5 групп при помощи ntile на основе количества сделанных заказов
frequency as ( 
		select counted, ntile(5) OVER( order by fr.counted ) as frequency
			from (select counted from users group by 1) as fr )
--заполняем поля в tmp_rfm_frequency
select u.user_id as user_id, f.frequency 
	from users u
	join frequency f on f.counted = u.counted

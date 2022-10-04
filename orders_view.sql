create or replace view analysis.orders as 
select ord.order_id, 
	ord_log.dttm as order_ts, 
	ord.user_id, ord.bonus_payment, ord.payment, ord.cost, ord.bonus_grant,
	ord_log.status_id as status
		from production.orders ord 
		join production.orderstatuslog ord_log on ord.order_id = ord_log.order_id 
		where ord_log.dttm = ( --выбираем максимальную дату обновления в логах
							  select max(ord_date.dttm) 
							  from production.orderstatuslog ord_date 
							  where ord_date.order_id = ord.order_id) 

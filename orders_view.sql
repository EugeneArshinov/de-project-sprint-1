create or replace view analysis.orders as 
select ord.order_id, 
	ord_log.dttm as order_ts, 
	ord.user_id, ord.bonus_payment, ord.payment, ord.cost, ord.bonus_grant,
	ord_log.status_id as status
		from production.orders ord 
		join production.orderstatuslog ord_log on ord.order_id = ord_log.order_id 
		where ord_log.dttm = ( --§Ó§í§Ò§Ú§â§Ñ§Ö§Þ §Þ§Ñ§Ü§ã§Ú§Þ§Ñ§Ý§î§ß§å§ð §Õ§Ñ§ä§å §à§Ò§ß§à§Ó§Ý§Ö§ß§Ú§ñ §Ó §Ý§à§Ô§Ñ§ç
							  select max(ord_date.dttm) 
							  from production.orderstatuslog ord_date 
							  where ord_date.order_id = ord.order_id) 

insert into analysis.tmp_rfm_monetary_value 
--§ã§à§Ò§Ú§â§Ñ§Ö§Þ §Ù§Ñ§Ü§Ñ§Ù§í §Ù§Ñ 2022 §Ô§à§Õ §ã§à §ã§ä§Ñ§ä§å§ã§à§Þ Closed
with orders as ( 
		select ord.user_id, ord.order_ts
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--§ã§à§Ò§Ú§â§Ñ§Ö§Þ §ã§å§Þ§Þ§í §á§à §Ù§Ñ§Ü§Ñ§Ù§Ñ§Þ §Õ§Ý§ñ §Ü§Ñ§Ø§Õ§à§Ô§à id §Ü§Ý§Ú§Ö§ß§ä§Ñ
users as (  
		select ord.user_id, sum(coalesce(ord.payment,0)) as order_cost
		from analysis.orders ord
		group by 1),
--§Õ§Ö§Ý§Ú§Þ §ß§Ñ 5 §Ô§â§å§á§á §á§â§Ú §á§à§Þ§à§ë§Ú ntile §ß§Ñ §à§ã§ß§à§Ó§Ö §ã§å§Þ§Þ§í §Ù§Ñ§Ü§Ñ§Ù§Ñ §Ü§Ñ§Ø§Õ§à§Ô§à §Ü§Ý§Ú§Ö§ß§ä§Ñ
monetary as( 
		select order_cost, ntile (5) over (order by orders2.order_cost) as monetary_value
			from (
				select order_cost from users group by 1) 
			as orders2)
--§Ù§Ñ§á§à§Ý§ß§ñ§Ö§Þ §á§à§Ý§ñ §Ó tmp_rfm_monetary_value
select u.user_id as user_id, m.monetary_value  
	from users u
	join monetary m on m.order_cost = u.order_cost

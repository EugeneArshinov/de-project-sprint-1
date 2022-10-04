insert into analysis.tmp_rfm_recency 
--§ã§à§Ò§Ú§â§Ñ§Ö§Þ §Ù§Ñ§Ü§Ñ§Ù§í §Ù§Ñ 2022 §Ô§à§Õ §ã§à §ã§ä§Ñ§ä§å§ã§à§Þ Closed
with orders as ( 
		select ord.user_id, ord.order_ts  
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--§ã§à§Ò§Ú§â§Ñ§Ö§Þ §á§à§ã§Ý§Ö§Õ§ß§Ú§Ö §Õ§Ñ§ä§í §Ù§Ñ§Ü§Ñ§Ù§Ñ §Õ§Ý§ñ §Ü§Ñ§Ø§Õ§à§Ô§à id §Ü§Ý§Ú§Ö§ß§ä§Ñ
users as ( 
  		select ord.user_id , max(coalesce(ord.order_ts,'2022-01-01'::timestamp)) as order_last_date
  			from analysis.orders ord
  			group by 1),
--§Õ§Ö§Ý§Ú§Þ §ß§Ñ 5 §Ô§â§å§á§á §á§â§Ú §á§à§Þ§à§ë§Ú ntile §ß§Ñ §à§ã§ß§à§Ó§Ö §á§à§ã§Ý§Ö§Õ§ß§Ö§Û §Õ§Ñ§ä§í §Ù§Ñ§Ü§Ñ§Ù§Ñ
recency as ( 
		select order_last_date, ntile(5) OVER(order by u.order_last_date) as recency
			from (select order_last_date from users group by 1) as u )
--§Ù§Ñ§á§à§Ý§ß§ñ§Ö§Þ §á§à§Ý§ñ §Ó tmp_rfm_recency 
select u.user_id as user_id, r.recency
	from users u
	join recency r on r.order_last_date = u.order_last_date

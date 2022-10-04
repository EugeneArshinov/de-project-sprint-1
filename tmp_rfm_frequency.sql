insert into analysis.tmp_rfm_frequency
--§ã§à§Ò§Ú§â§Ñ§Ö§Þ §Ù§Ñ§Ü§Ñ§Ù§í §Ù§Ñ 2022 §Ô§à§Õ §ã§à §ã§ä§Ñ§ä§å§ã§à§Þ Closed
with orders as ( 
		select ord.user_id, ord.order_ts  
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--§ã§à§Ò§Ú§â§Ñ§Ö§Þ §Ü§à§Ý§Ú§é§Ö§ã§ä§Ó§à §Ù§Ñ§Ü§Ñ§Ù§à§Ó §Õ§Ý§ñ §Ü§Ñ§Ø§Õ§à§Ô§à id §Ü§Ý§Ú§Ö§ß§ä§Ñ
users as ( 
  		select ord.user_id , count(ord.*) as counted
  			from analysis.orders ord
  			group by 1),
--§Õ§Ö§Ý§Ú§Þ §ß§Ñ 5 §Ô§â§å§á§á §á§â§Ú §á§à§Þ§à§ë§Ú ntile §ß§Ñ §à§ã§ß§à§Ó§Ö §Ü§à§Ý§Ú§é§Ö§ã§ä§Ó§Ñ §ã§Õ§Ö§Ý§Ñ§ß§ß§í§ç §Ù§Ñ§Ü§Ñ§Ù§à§Ó
frequency as ( 
		select counted, ntile(5) OVER( order by fr.counted ) as frequency
			from (select counted from users group by 1) as fr )
--§Ù§Ñ§á§à§Ý§ß§ñ§Ö§Þ §á§à§Ý§ñ §Ó tmp_rfm_frequency
select u.user_id as user_id, f.frequency 
	from users u
	join frequency f on f.counted = u.counted

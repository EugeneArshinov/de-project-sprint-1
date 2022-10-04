--§Ù§Ñ§á§à§Ý§ß§ñ§Ö§Þ §ä§Ñ§Ò§Ý§Ú§è§å dm_rfm_segments §ß§Ñ §à§ã§ß§à§Ó§Ö 3§ç §ä§Ñ§Ò§Ý§Ú§è tmp_rfm_recency, tmp_rfm_frequency, tmp_rfm_monetary_value
insert into analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
	select r.user_id, r.recency, f.frequency, m.monetary_value  
	from analysis.tmp_rfm_recency r
		join analysis.tmp_rfm_frequency f on r.user_id = f.user_id 
		join analysis.tmp_rfm_monetary_value m on r.user_id = m.user_id 
	
--§Ó§í§Ô§â§å§Ù§Ü§Ñ §á§Ö§â§Ó§í§ç 10 §Ù§Ñ§á§Ú§ã§Ö§Û §à§ä§ã§à§â§ä§Ú§â§à§Ó§Ñ§ß§ß§í§ç §á§à §Ó§à§Ù§â§Ñ§ã§ä§Ñ§ß§Ú§ð user_id
user_id | recency | frequency | monetary_value
	0	 	 3		   3				5
	1		 4		   3	  			3
	2		 3	  	   2				3
	3		 3		   2				2
	4		 3		   3				2
	5		 4		   3				4
	6		 1		   2				2
	7		 5		   2		 		2
	8		 4		   1		  		2
	9		 4		   2				2
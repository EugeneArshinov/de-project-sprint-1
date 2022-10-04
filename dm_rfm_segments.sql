--�٧ѧ��ݧߧ�֧� ��ѧҧݧڧ�� dm_rfm_segments �ߧ� ���ߧ�ӧ� 3�� ��ѧҧݧڧ� tmp_rfm_recency, tmp_rfm_frequency, tmp_rfm_monetary_value
insert into analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
	select r.user_id, r.recency, f.frequency, m.monetary_value  
	from analysis.tmp_rfm_recency r
		join analysis.tmp_rfm_frequency f on r.user_id = f.user_id 
		join analysis.tmp_rfm_monetary_value m on r.user_id = m.user_id 
	
--�ӧ�ԧ��٧ܧ� ��֧�ӧ�� 10 �٧ѧ�ڧ�֧� �������ڧ��ӧѧߧߧ�� ��� �ӧ�٧�ѧ��ѧߧڧ� user_id
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
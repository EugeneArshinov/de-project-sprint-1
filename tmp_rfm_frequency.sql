insert into analysis.tmp_rfm_frequency
--���ҧڧ�ѧ֧� �٧ѧܧѧ٧� �٧� 2022 �ԧ�� ��� ���ѧ����� Closed
with orders as ( 
		select ord.user_id, ord.order_ts  
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--���ҧڧ�ѧ֧� �ܧ�ݧڧ�֧��ӧ� �٧ѧܧѧ٧�� �էݧ� �ܧѧاէ�ԧ� id �ܧݧڧ֧ߧ��
users as ( 
  		select ord.user_id , count(ord.*) as counted
  			from analysis.orders ord
  			group by 1),
--�է֧ݧڧ� �ߧ� 5 �ԧ���� ���� ���ާ��� ntile �ߧ� ���ߧ�ӧ� �ܧ�ݧڧ�֧��ӧ� ��է֧ݧѧߧߧ�� �٧ѧܧѧ٧��
frequency as ( 
		select counted, ntile(5) OVER( order by fr.counted ) as frequency
			from (select counted from users group by 1) as fr )
--�٧ѧ��ݧߧ�֧� ���ݧ� �� tmp_rfm_frequency
select u.user_id as user_id, f.frequency 
	from users u
	join frequency f on f.counted = u.counted

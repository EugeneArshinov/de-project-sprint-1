insert into analysis.tmp_rfm_recency 
--���ҧڧ�ѧ֧� �٧ѧܧѧ٧� �٧� 2022 �ԧ�� ��� ���ѧ����� Closed
with orders as ( 
		select ord.user_id, ord.order_ts  
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--���ҧڧ�ѧ֧� ����ݧ֧էߧڧ� �էѧ�� �٧ѧܧѧ٧� �էݧ� �ܧѧاէ�ԧ� id �ܧݧڧ֧ߧ��
users as ( 
  		select ord.user_id , max(coalesce(ord.order_ts,'2022-01-01'::timestamp)) as order_last_date
  			from analysis.orders ord
  			group by 1),
--�է֧ݧڧ� �ߧ� 5 �ԧ���� ���� ���ާ��� ntile �ߧ� ���ߧ�ӧ� ����ݧ֧էߧ֧� �էѧ�� �٧ѧܧѧ٧�
recency as ( 
		select order_last_date, ntile(5) OVER(order by u.order_last_date) as recency
			from (select order_last_date from users group by 1) as u )
--�٧ѧ��ݧߧ�֧� ���ݧ� �� tmp_rfm_recency 
select u.user_id as user_id, r.recency
	from users u
	join recency r on r.order_last_date = u.order_last_date

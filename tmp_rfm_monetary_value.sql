insert into analysis.tmp_rfm_monetary_value 
--���ҧڧ�ѧ֧� �٧ѧܧѧ٧� �٧� 2022 �ԧ�� ��� ���ѧ����� Closed
with orders as ( 
		select ord.user_id, ord.order_ts
			from analysis.orders ord 
			join analysis.orderstatuses stat on ord.status = stat.id
				where stat.key = 'Closed'
				and ord.order_ts >= '2022-01-01'::timestamp),
--���ҧڧ�ѧ֧� ���ާާ� ��� �٧ѧܧѧ٧ѧ� �էݧ� �ܧѧاէ�ԧ� id �ܧݧڧ֧ߧ��
users as (  
		select ord.user_id, sum(coalesce(ord.payment,0)) as order_cost
		from analysis.orders ord
		group by 1),
--�է֧ݧڧ� �ߧ� 5 �ԧ���� ���� ���ާ��� ntile �ߧ� ���ߧ�ӧ� ���ާާ� �٧ѧܧѧ٧� �ܧѧاէ�ԧ� �ܧݧڧ֧ߧ��
monetary as( 
		select order_cost, ntile (5) over (order by orders2.order_cost) as monetary_value
			from (
				select order_cost from users group by 1) 
			as orders2)
--�٧ѧ��ݧߧ�֧� ���ݧ� �� tmp_rfm_monetary_value
select u.user_id as user_id, m.monetary_value  
	from users u
	join monetary m on m.order_cost = u.order_cost

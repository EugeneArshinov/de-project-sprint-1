create or replace view analysis.orders --view �� �էѧߧߧ�ާ� ��� �٧ѧܧѧ٧ѧ�, ���ݧ�٧�ӧѧ�֧ݧ��, �ӧܧݧ��ѧ� ���ѧ��� �٧ѧܧѧ٧�
	as select * from production.orders;

create or replace view analysis.products --view �� �ާ֧ߧ� �ӧܧݧ��ѧ� ����ڧާ����
	as select * from production.products;

create or replace view analysis.orderitmes --view �� �էѧߧߧ�ާ� ��� �ܧѧاէ�ާ� �٧ѧܧѧ٧� ��ѧ٧է֧ݧ֧ߧߧ�� ��� �ҧݧ�էѧ� �ڧ� �ާ֧ߧ�
	as select * from production.orderitems;
	
create or replace view analysis.orderstatuses --view �� ���ڧ�ѧߧڧ֧� ���ѧ���� �٧ѧܧѧ٧� Open/Cooking/Delivering/Closed/Cancelled = 1/2/3/4/5 
	as select *	from production.orderstatuses;
	
create or replace view analysis.orderstatuslog --view �� �ݧ�ԧѧާ� �٧ѧܧѧ٧�� �� �ڧ� ������اէ֧ߧڧ� ��� ��ѧ٧ߧ�� ���ѧ���ѧ� 1/2/3/4/5
	as select * from production.orderstatuslog; 
	
	
	

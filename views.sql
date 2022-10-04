create or replace view analysis.orders --view с данными по заказам, пользователям, включая статус заказа
	as select * from production.orders;

create or replace view analysis.products --view с меню включая стоимость
	as select * from production.products;

create or replace view analysis.orderitmes --view с данными по каждому заказу разделенное по блюдам из меню
	as select * from production.orderitems;
	
create or replace view analysis.orderstatuses --view с описанием статуса заказа Open/Cooking/Delivering/Closed/Cancelled = 1/2/3/4/5 
	as select *	from production.orderstatuses;
	
create or replace view analysis.orderstatuslog ---view с логами заказов и их прохождению по разным статусам 1/2/3/4/5
	as select * from production.orderstatuslog; 
	
	
	

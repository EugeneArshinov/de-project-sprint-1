create or replace view analysis.orders --view §ã §Õ§Ñ§ß§ß§í§Þ§Ú §á§à §Ù§Ñ§Ü§Ñ§Ù§Ñ§Þ, §á§à§Ý§î§Ù§à§Ó§Ñ§ä§Ö§Ý§ñ§Þ, §Ó§Ü§Ý§ð§é§Ñ§ñ §ã§ä§Ñ§ä§å§ã §Ù§Ñ§Ü§Ñ§Ù§Ñ
	as select * from production.orders;

create or replace view analysis.products --view §ã §Þ§Ö§ß§ð §Ó§Ü§Ý§ð§é§Ñ§ñ §ã§ä§à§Ú§Þ§à§ã§ä§î
	as select * from production.products;

create or replace view analysis.orderitmes --view §ã §Õ§Ñ§ß§ß§í§Þ§Ú §á§à §Ü§Ñ§Ø§Õ§à§Þ§å §Ù§Ñ§Ü§Ñ§Ù§å §â§Ñ§Ù§Õ§Ö§Ý§Ö§ß§ß§à§Ö §á§à §Ò§Ý§ð§Õ§Ñ§Þ §Ú§Ù §Þ§Ö§ß§ð
	as select * from production.orderitems;
	
create or replace view analysis.orderstatuses --view §ã §à§á§Ú§ã§Ñ§ß§Ú§Ö§Þ §ã§ä§Ñ§ä§å§ã§Ñ §Ù§Ñ§Ü§Ñ§Ù§Ñ Open/Cooking/Delivering/Closed/Cancelled = 1/2/3/4/5 
	as select *	from production.orderstatuses;
	
create or replace view analysis.orderstatuslog --view §ã §Ý§à§Ô§Ñ§Þ§Ú §Ù§Ñ§Ü§Ñ§Ù§à§Ó §Ú §Ú§ç §á§â§à§ç§à§Ø§Õ§Ö§ß§Ú§ð §á§à §â§Ñ§Ù§ß§í§Þ §ã§ä§Ñ§ä§å§ã§Ñ§Þ 1/2/3/4/5
	as select * from production.orderstatuslog; 
	
	
	

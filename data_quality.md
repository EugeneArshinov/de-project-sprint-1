# 1.3. Качество данных

## Оцените, насколько качественные данные хранятся в источнике:
       Проведена проверка пользователей на уникальность и отсутствие дубликатов в production.orders по user_id (сравнение проведено с таблицей production.users)
       Проведена проверка заказов на отсутствие дубликатов в production.orders по полю order_id 
       Проведена проверка в таблицах production.orders, production.users, production.orderstatuses на отсутствие значений Null 


По данным в таблицах production.orders замечания:
Нет проверки что стаутс должен быть в диапазоне от 1..5
Нет внешнего ключа (fkey) для поля user_id



## Укажите, какие инструменты обеспечивают качество данных в источнике.
Ответ запишите в формате таблицы:


| Таблицы             | Объект                      | Инструмент            | Для чего используется |
| ------------------- | --------------------------- | --------------------- | --------------------- |
| production.orders   | order_id int4               | Primary key Not null  | Уникальность и отсутствие пустых значений |
| production.orders   | order_ts timestamp          | Not null              |  отсутствие пустых значений |
| production.orders   | user_id int4                | Not null              |  отсутствие пустых значений |
| production.orders   | bonus_payment numeric(19, 5)| NOT NULL DEFAULT 0    | отсутствие пустых значений, замена на 0 если пусто |
| production.orders   | payment numeric(19, 5)      | NOT NULL DEFAULT 0    | отсутствие пустых значений, замена на 0 если пусто |
| production.orders   | cost numeric(19, 5)         | NOT NULL DEFAULT 0    | отсутствие пустых значений, замена на 0 если пусто |
| production.orders   | cost numeric(19, 5)         | CHECK ((cost = (payment + bonus_payment)) | проверка что стоимость равняется цена блюда плюс бонус |
| production.orders   | bonus_grant numeric(19, 5)  | NOT NULL DEFAULT 0    | отсутствие пустых значений, замена на 0 если пусто |
| production.orders   | status int4                 |  Not null             |  отсутствие пустых значений |

# Курсовая работа по теме "Разработка базы данных для бронирования номеров в отеле"
![ERD-диаграмма](https://github.com/vanilnic/Course_work/blob/main/erd.png)

## Типовые Запросы
**1. Вывести дату последнего выезда из номера 5**
```sql
SELECT departure FROM rooms
JOIN booking_has_rooms ON rooms.id = booking_has_rooms.rooms_id
JOIN booking ON booking_has_rooms.booking_id = booking.id
WHERE rooms_id = 5
ORDER BY departure DESC
LIMIT 1;
```
## Хранимые процедуры
## Роли

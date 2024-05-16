# Курсовая работа по теме "Разработка базы данных для бронирования номеров в отеле"
![ERD-диаграмма](https://github.com/vanilnic/Course_work/blob/main/erd.png)

## Типовые Запросы
### **1. Вывести дату последнего выезда из номера 5**
```sql
SELECT departure FROM rooms
JOIN booking_has_rooms ON rooms.id = booking_has_rooms.rooms_id
JOIN booking ON booking_has_rooms.booking_id = booking.id
WHERE rooms_id = 5
ORDER BY departure DESC
LIMIT 1;
```

### **2. Получить список бронирований на ближайшие 2 недели**
```sql
SELECT booking.arrival, booking.departure, booking.total_price, clients.name AS client_name, rooms.number, room_type.title
FROM booking
JOIN clients ON booking.client_id = clients.id
JOIN booking_has_rooms ON booking.id = booking_has_rooms.booking_id
JOIN rooms ON booking_has_rooms.rooms_id = rooms.id
JOIN room_type ON rooms.type_room_id = room_type.id
WHERE booking.arrival BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 2 WEEK)
ORDER BY booking.arrival;
```

### **3. Получить список доступных номеров в период с 2024-05-08 по 2024-05-10**
```sql
SELECT number, room_type.title, price_per_night_adult, price_per_night_child
FROM rooms
JOIN room_type ON room_type.id = rooms.type_room_id
WHERE rooms.id NOT IN (
    SELECT rooms_id
    FROM booking_has_rooms 
    INNER JOIN booking ON booking_has_rooms.booking_id = booking.id
    WHERE arrival >= '2024-05-08' AND departure <= '2024-05-10'
);
```

### **4. Получить информацию по всем бронированиям человека с паспортом 1219111111**
```sql
SELECT room_type.title, quantity_adults, quantity_children, arrival, booking.departure, booking.total_price, rooms.number
FROM clients
JOIN booking ON booking.client_id = clients.id
JOIN booking_has_rooms ON booking.id = booking_has_rooms.booking_id
JOIN rooms ON booking_has_rooms.rooms_id = rooms.id
JOIN room_type ON rooms.type_room_id = room_type.id
WHERE clients.passport = 1219111111
ORDER BY arrival ASC;
```

### **5. Получить номера и типы комнат у которых есть Кондиционер**
```sql
SELECT rooms.number, room_type.title  FROM rooms
JOIN room_type ON room_type.id = rooms.type_room_id
JOIN room_type_has_options ON room_type_has_options.room_type_id = room_type.id
JOIN options ON options_id = options.id
WHERE options.title = 'Кондиционер';
```

## Хранимые процедуры
## Роли

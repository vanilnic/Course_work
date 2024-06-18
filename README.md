# Курсовая работа по теме "Разработка базы данных для бронирования номеров в отеле"
![ERD-диаграмма](https://github.com/vanilnic/Course_work/blob/main/erd.png)

## Типовые Запросы
**1. Вывести имя, фамилию, паспорт и дату последнего выезда из номера 2**
```sql
SELECT rooms.number, clients.name, clients.surname, clients.passport,  departure FROM rooms
JOIN booking_has_rooms ON rooms.id = booking_has_rooms.rooms_id
JOIN booking ON booking_has_rooms.booking_id = booking.id
JOIN clients ON booking.client_id = clients.id
WHERE rooms_id = 2
ORDER BY departure DESC
LIMIT 1;
```

**2. Получить список бронирований на ближайшие 2 недели**
```sql
SELECT booking.arrival, booking.departure, booking.price_per_room, booking.price_per_servises,  clients.name AS client_name, rooms.number, room_type.title
FROM booking
JOIN clients ON booking.client_id = clients.id
JOIN booking_has_rooms ON booking.id = booking_has_rooms.booking_id
JOIN rooms ON booking_has_rooms.rooms_id = rooms.id
JOIN room_type ON rooms.type_room_id = room_type.id
WHERE booking.arrival BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 2 WEEK)
ORDER BY booking.arrival;
```

**3. Получить список доступных номеров в период с 2024-06-12 по 2024-06-14**
```sql
SELECT number, room_type.title, price_per_night_adult, price_per_night_child
FROM rooms
JOIN room_type ON room_type.id = rooms.type_room_id
WHERE rooms.id NOT IN (
    SELECT DISTINCT rooms.id
    FROM rooms
    INNER JOIN booking_has_rooms ON rooms.id = booking_has_rooms.rooms_id
    INNER JOIN booking ON booking_has_rooms.booking_id = booking.id
    WHERE NOT (booking.arrival > '2024-06-15 12:00:00' OR booking.departure < '2024-06-12 14:00:00')
);
```

**4. Получить информацию по всем бронированиям человека с паспортом 1219111111**
```sql
SELECT room_type.title, quantity_adults, quantity_children, arrival, booking.departure, booking.price_per_room, booking.price_per_servises, rooms.number
FROM clients
JOIN booking ON booking.client_id = clients.id
JOIN booking_has_rooms ON booking.id = booking_has_rooms.booking_id
JOIN rooms ON booking_has_rooms.rooms_id = rooms.id
JOIN room_type ON rooms.type_room_id = room_type.id
WHERE clients.passport = 1219111111
ORDER BY arrival ASC;
```

**5. Получить номера и типы комнат у которых есть Кондиционер**
```sql
SELECT rooms.number, room_type.title  FROM rooms
JOIN room_type ON room_type.id = rooms.type_room_id
JOIN room_type_has_options ON room_type_has_options.room_type_id = room_type.id
JOIN options ON options_id = options.id
WHERE options.title = 'Кондиционер';
```

## Роли
1. Роль: Простой пользователь (SimpleUser)
``` sql
-- создание роли
CREATE ROLE IF NOT EXISTS SimpleUser; 
GRANT SELECT ON course_paper_services.options TO SimpleUser;
GRANT SELECT ON course_paper_services.room_type TO SimpleUser;
GRANT SELECT ON course_paper_services.room_type_has_options TO SimpleUser;
GRANT SELECT ON course_paper_services.rooms TO SimpleUser;
GRANT SELECT ON course_paper_services.services TO SimpleUser;
```
> Пользователи с этой ролью могут только читать таблицы, содержащие информацию о номерах.

2. Роль: Менеджер бронирования (BookingManager)
``` sql
-- создание роли
CREATE ROLE IF NOT EXISTS BookingManager;

GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.booking TO BookingManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.clients TO BookingManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.booking_has_rooms TO BookingManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.booking_has_services TO BookingManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.payments TO BookingManager;
GRANT SELECT ON course_paper_services.rooms TO BookingManager;
GRANT SELECT ON course_paper_services.room_type TO BookingManager;
GRANT SELECT ON course_paper_services.services TO BookingManager;
GRANT SELECT ON course_paper_services.room_type_has_options TO BookingManager;
GRANT SELECT ON course_paper_services.options TO BookingManager;

GRANT EXECUTE ON PROCEDURE course_paper_services.AddBooking TO BookingManager;
GRANT EXECUTE ON PROCEDURE course_paper_services.AddService TO BookingManager;
GRANT EXECUTE ON PROCEDURE course_paper_services.MakePayment TO BookingManager;
GRANT EXECUTE ON PROCEDURE course_paper_services.AddClient TO BookingManager;

GRANT EXECUTE ON FUNCTION course_paper_services.calculate_total_payment TO BookingManager;
```
> Пользователи с этой ролью могут управлять бронированиями, клиентскими данными, оплатой, а также просматривать доступные номера и информацию о них.

3. Роль: Менеджер отеля (HotelManager)
``` sql
-- создание роли
CREATE ROLE IF NOT EXISTS HotelManager;

GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.rooms TO HotelManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.room_type TO HotelManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.services TO HotelManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.options TO HotelManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON course_paper_services.room_type_has_options TO HotelManager;
```
> Пользователи с этой ролью имеют доступ к управлентю номерами

## Хранимые процедуры
1. Процедура добавления клиента
``` sql
call course_paper_services.AddClient('Иван', 'Иванов', 'vanivan@gmail.com', '89001116789', '1921191817', 'male');
```
> Процедура добавит в таблицу clients имя `Иван`, фамилию `Иванов`, почту `vanivan@gmail.com`, номер телефона `89001116789`, паспорт `1921191817` и пол `male`
---
2. Процедура создания новой брони с выбором дополнительных сервисов
``` sql
   call course_paper_services.AddBooking(1, 1, 0, '2024-06-16', '2024-06-20', 1219111111, 'yes', 'no');
```
> Процедура принимает входные параметры: тип комнаты `1`, колличество взрослых `1` и детей `0`, период заселения `2024-06-16` —  `2024-06-20`, паспорт клиента `1219111111`, и добавление дополнительных сервисов 'Wi-Fi' `yes` и 'Поздний выезд' `no`. На выходе мы получаем нове записи в таблицы `booking`, `booking_has_room`, `booking_has_services`
---
3. Процедура добавления дополнительного сервиса для уже существующей брони
``` sql
call course_paper_services.AddService(148, 2);
```
> Процедура добавит новую запись в таблицу `booking_has_services`, где `148` —  id бронирования, а `2` — id дополнительного сервиса 'Поздний выезд'. Так же она внесёт изменение стоимости в таблицы `payments` и `booking`
---
4. Процедура оформления оплаты за номер
``` sql
call course_paper_services.MakeAPayment(148, 'non-cash');
```
> Процедура подтвердит оплату в таблице `payments` с указанием на id бронирования `148` и методом оплаты `non-cash`

## Триггер
**`create_payment_on_booking`** осуществляет свою деятельность после добавления новой записи в таблицу `booking`, а именно, создание новой записи в таблицу `payments` с указанием итоговой суммы и id нового бронирования

## Функция
**`calculate_total_payment`** вызывается триггером, выполняя подсчёт итоговой суммы бронирования. Входные параметры получает непосредственно в тригере

## Представление
``` sql
SELECT * FROM course_paper_services.monthlyrevenue;
```
> Это представление показывает доход от бронирований по месяцам
---
```sql
SELECT * FROM course_paper_services.current_bookings_view;
```
> Представление вернет все текущие бронирования, которые активны на текущую дату, включая информацию о клиенте, номере и типе комнаты

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: course_paper_services
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity_adults` smallint unsigned NOT NULL,
  `quantity_children` smallint unsigned NOT NULL,
  `arrival` datetime NOT NULL,
  `departure` datetime NOT NULL,
  `nights_count` smallint unsigned DEFAULT NULL,
  `price_per_room` decimal(10,2) unsigned NOT NULL,
  `price_per_servises` decimal(10,2) unsigned DEFAULT '0.00',
  `date` datetime NOT NULL,
  `client_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_booking_client1_idx` (`client_id`),
  CONSTRAINT `fk_booking_client1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (137,1,0,'2024-05-24 14:00:00','2024-05-25 12:00:00',1,1000.00,0.00,'2024-05-23 12:51:30',1),(138,1,0,'2024-05-24 14:00:00','2024-05-25 12:00:00',1,1000.00,0.00,'2024-05-23 12:51:47',2),(139,3,0,'2024-05-28 14:00:00','2024-05-30 12:00:00',2,15600.00,1000.00,'2024-05-23 12:52:26',2),(140,1,0,'2024-05-26 14:00:00','2024-05-30 12:00:00',4,12000.00,1000.00,'2024-05-23 12:53:01',7),(141,1,0,'2024-06-01 14:00:00','2024-06-03 18:00:00',2,2000.00,2500.00,'2024-05-23 12:54:25',13),(142,1,0,'2024-06-02 14:00:00','2024-06-03 18:00:00',1,1000.00,2500.00,'2024-05-23 12:55:04',8),(143,1,0,'2024-06-02 14:00:00','2024-06-03 18:00:00',1,1400.00,2500.00,'2024-05-23 12:55:37',14),(144,1,0,'2024-06-02 14:00:00','2024-06-03 18:00:00',1,1400.00,2500.00,'2024-05-23 12:55:39',14);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `create_payment_on_booking` AFTER INSERT ON `booking` FOR EACH ROW BEGIN
    DECLARE total_price DECIMAL(10,2);
    
    -- Получаем общую стоимость бронирования
    SET total_price = calculate_total_payment(NEW.id);
    
    -- Вставляем новую запись в таблицу payments
    INSERT INTO payments (amount, booking_id)
    VALUES (total_price, NEW.id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `booking_has_rooms`
--

DROP TABLE IF EXISTS `booking_has_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_has_rooms` (
  `booking_id` int NOT NULL,
  `rooms_id` int NOT NULL,
  PRIMARY KEY (`booking_id`,`rooms_id`),
  KEY `fk_booking_has_rooms_rooms1_idx` (`rooms_id`),
  KEY `fk_booking_has_rooms_booking1_idx` (`booking_id`),
  CONSTRAINT `fk_booking_has_rooms_booking1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `fk_booking_has_rooms_rooms1` FOREIGN KEY (`rooms_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_has_rooms`
--

LOCK TABLES `booking_has_rooms` WRITE;
/*!40000 ALTER TABLE `booking_has_rooms` DISABLE KEYS */;
INSERT INTO `booking_has_rooms` VALUES (137,1),(141,1),(138,2),(142,2),(143,3),(144,4),(139,9),(140,11);
/*!40000 ALTER TABLE `booking_has_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_has_services`
--

DROP TABLE IF EXISTS `booking_has_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_has_services` (
  `services_id` int NOT NULL,
  `booking_id` int NOT NULL,
  PRIMARY KEY (`services_id`,`booking_id`),
  KEY `fk_services_has_booking_booking1_idx` (`booking_id`),
  KEY `fk_services_has_booking_services1_idx` (`services_id`),
  CONSTRAINT `fk_services_has_booking_booking1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `fk_services_has_booking_services1` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_has_services`
--

LOCK TABLES `booking_has_services` WRITE;
/*!40000 ALTER TABLE `booking_has_services` DISABLE KEYS */;
INSERT INTO `booking_has_services` VALUES (1,139),(1,140),(1,141),(2,141),(1,142),(2,142),(1,143),(2,143),(1,144),(2,144);
/*!40000 ALTER TABLE `booking_has_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `passport` varchar(20) NOT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `passport_UNIQUE` (`passport`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Иван','Иванов','ivan@example.com','89123456789','1219111111','male'),(2,'Елена','Петрова','elena@example.com','89234567890','1219222222','female'),(3,'Алексей','Сидоров','alex@example.com','89345678901','1418111111','male'),(4,'Мария','Смирнова','maria@example.com','89456789012','1418222222','female'),(5,'Петр','Кузнецов','petr@example.com','89567890123','1010111111','male'),(6,'Анна','Павлова','anna@example.com','89678901234','1010222222','female'),(7,'Игорь','Федоров','igor@example.com','89789012345','1921111111','male'),(8,'Ольга','Михайлова','olga@example.com','89890123456','1921222222','female'),(9,'Дмитрий','Васильев','dmitry@example.com','89901234567','2120111111','male'),(10,'Светлана','Александрова','svetlana@example.com','89012345678','2120222222','female'),(11,'Виктория','Богданова','bika@gmail.com','89001117788','1212111111','female'),(13,'Виктор','Богданов','bikaa@gmail.com','89112345678','1212222222','male'),(14,'Пётр','Петров','petr@gmail.com','89002345678','1313444444','male'),(15,'Пётр','Петров','petrr@gmail.com','89102345678','2222444555','male'),(16,'Алексей','Иванов','ioan@gmail.com','89102345634','1212236781','male'),(17,'Максим','Орлов','qweqwe@gmail.com','89001116143','1212345678','male'),(18,'Максим','Орлов','max@gmail.com','89051116143','1219111112','male'),(19,'Ваня','Иванов','123@gmail','89067778965','1122345678','male');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `current_bookings_view`
--

DROP TABLE IF EXISTS `current_bookings_view`;
/*!50001 DROP VIEW IF EXISTS `current_bookings_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `current_bookings_view` AS SELECT 
 1 AS `booking_id`,
 1 AS `client_name`,
 1 AS `number`,
 1 AS `room_type`,
 1 AS `arrival`,
 1 AS `departure`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `monthlyrevenue`
--

DROP TABLE IF EXISTS `monthlyrevenue`;
/*!50001 DROP VIEW IF EXISTS `monthlyrevenue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `monthlyrevenue` AS SELECT 
 1 AS `Month`,
 1 AS `TotalRevenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (2,'Кондиционер'),(3,'Телевизор'),(4,'Фен'),(5,'Холодильник'),(6,'Сейф');
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) unsigned NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_method` enum('cash','non-cash') DEFAULT NULL,
  `booking_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payments_booking1_idx` (`booking_id`),
  CONSTRAINT `fk_payments_booking1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (14,1000.00,NULL,NULL,137),(15,1000.00,NULL,NULL,138),(16,16600.00,NULL,NULL,139),(17,13000.00,NULL,NULL,140),(18,4500.00,NULL,NULL,141),(19,3500.00,NULL,NULL,142),(20,3900.00,NULL,NULL,143),(21,3900.00,NULL,NULL,144);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `beds_amount` tinyint unsigned NOT NULL,
  `bath_amount` tinyint unsigned NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type`
--

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;
INSERT INTO `room_type` VALUES (1,'Эконом-номер',1,0,'Бюджетный номер с одной кроватью и без отдельной ванной комнаты.'),(2,'Стандартный одноместный',1,1,'Уютный одноместный номер с одной кроватью и одной ванной комнатой. Идеально подходит для путешественников-одиночек.'),(3,'Стандартный двухместный',2,1,'Номер с двумя односпальными кроватями и одной ванной комнатой. Идеально подходит для друзей или коллег.'),(4,'Стандартный двухместный улучшеный',2,1,'Удобный двухместный номер с одной большой кроватью и одной ванной комнатой. Подходит для пар.'),(5,'Семейный номер',4,2,'Просторный номер с одной большой кроватью, двумя односпальными кроватями и двумя ванными комнатами. Отлично подходит для семей.'),(6,'Люкс',2,1,'Роскошный номер с отдельной гостиной, спальней с одной большой кроватью и одной ванной комнатой. Идеально для особых случаев.');
/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type_has_options`
--

DROP TABLE IF EXISTS `room_type_has_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_type_has_options` (
  `room_type_id` int NOT NULL,
  `options_id` int NOT NULL,
  PRIMARY KEY (`room_type_id`,`options_id`),
  KEY `fk_room_type_has_options_options1_idx` (`options_id`),
  KEY `fk_room_type_has_options_room_type1_idx` (`room_type_id`),
  CONSTRAINT `fk_room_type_has_options_options1` FOREIGN KEY (`options_id`) REFERENCES `options` (`id`),
  CONSTRAINT `fk_room_type_has_options_room_type1` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type_has_options`
--

LOCK TABLES `room_type_has_options` WRITE;
/*!40000 ALTER TABLE `room_type_has_options` DISABLE KEYS */;
INSERT INTO `room_type_has_options` VALUES (4,2),(5,2),(6,2),(2,3),(3,3),(4,3),(5,3),(6,3),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(5,5),(6,5),(6,6);
/*!40000 ALTER TABLE `room_type_has_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` smallint unsigned NOT NULL,
  `price_per_night_adult` decimal(10,2) unsigned NOT NULL,
  `price_per_night_child` decimal(10,2) unsigned NOT NULL,
  `type_room_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rooms_type_room_idx` (`type_room_id`),
  CONSTRAINT `fk_rooms_type_room` FOREIGN KEY (`type_room_id`) REFERENCES `room_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,101,1000.00,800.00,1),(2,102,1000.00,800.00,1),(3,103,1400.00,1000.00,2),(4,104,1400.00,1000.00,2),(5,105,1800.00,1600.00,3),(6,106,1800.00,1600.00,3),(7,107,2200.00,2000.00,4),(8,108,2200.00,2000.00,4),(9,109,2600.00,2400.00,5),(10,110,2600.00,2400.00,5),(11,111,3000.00,2800.00,6),(12,112,3000.00,2800.00,6);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Wi-Fi',1000.00,'Быстрый доступ в интернет по всей территории отеля'),(2,'Поздний выезд',1500.00,'Возможность позднего выезда из номера, бронирование номера закрепляется за вами до 18:00 по местному времени');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'course_paper_services'
--

--
-- Dumping routines for database 'course_paper_services'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_total_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_total_payment`(booking_id INT) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
	DECLARE total_price DECIMAL(10,2);
    
    SET total_price = (SELECT (price_per_servises + price_per_room) FROM booking WHERE id = booking_id);
    
    RETURN total_price;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(
    IN id_type_room INT,
    IN quantity_adults SMALLINT UNSIGNED,
    IN quantity_children SMALLINT UNSIGNED,
    IN arrival_date DATE,
    IN departure_date DATE,
    IN client_passport INT,
    IN service_wifi ENUM('yes','no'),
    IN service_Late_check_out ENUM('yes','no')
)
BEGIN
	DECLARE arrival DATETIME;
    DECLARE departure DATETIME;
	
	DECLARE AdultPrice_per_room DECIMAL(10,2);
    DECLARE ChildPrice_per_room DECIMAL(10,2);
    DECLARE AllPrice_per_room DECIMAL(10,2);
    
    DECLARE Service_price DECIMAL(10,2);
    
    DECLARE current_datetime DATETIME;
    DECLARE nights_count INT;
    
    DECLARE client_id INT;
    
    DECLARE id_room INT;
    DECLARE room_available BOOLEAN DEFAULT FALSE;
    
    DECLARE last_booking_id INT;
    
-- время для заезда и выезда
	IF service_Late_check_out = 'yes' THEN
      SET arrival = (SELECT DATE_ADD(arrival_date, INTERVAL 14 HOUR));
      SET departure = (SELECT DATE_ADD(departure_date, INTERVAL 18 HOUR));
    ELSE
	  SET arrival = (SELECT DATE_ADD(arrival_date, INTERVAL 14 HOUR));
      SET departure = (SELECT DATE_ADD(departure_date, INTERVAL 12 HOUR));
    END IF;
-- получение текущей даты
    SET current_datetime = NOW();
    
-- проверка выбранной даты бронирования
    IF arrival <= current_datetime THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Дата заезда не может быть в прошлом';
    ELSEIF departure <= arrival THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Дата выезда не может быть меньше даты заезда';
    END IF;
    
-- получение количества ночей
    SET nights_count = DATEDIFF(departure, arrival);

-- проверка на кол-во спальных мест с кол-вом людей
    IF quantity_adults + quantity_children > (
            SELECT beds_amount
            FROM room_type
            WHERE id = id_type_room
        ) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Количество гостей превышает количество кроватей в номере';
    END IF;

-- получение id клиента
	SET client_id = (SELECT id FROM clients WHERE passport = client_passport);

-- подсчёт цены взрослого и ребёнка
    SET AdultPrice_per_room = ( quantity_adults *
    (SELECT DISTINCT price_per_night_adult FROM rooms
    JOIN room_type ON room_type.id = type_room_id
    WHERE room_type.id = id_type_room)
    ); 
    SET ChildPrice_per_room = ( quantity_children *
    (SELECT DISTINCT price_per_night_child FROM rooms
    JOIN room_type ON room_type.id = type_room_id
    WHERE room_type.id = id_type_room)
    ); 
	-- итоговая цена за комнату
    SET AllPrice_per_room = (AdultPrice_per_room + ChildPrice_per_room) * nights_count;
    
-- подсчёт цены за сервисы
	SET Service_price = 0.00;
		
	IF service_wifi = 'yes' THEN
	  SET Service_price = Service_price + (SELECT price FROM services WHERE id = 1);
	END IF;
	IF service_Late_check_out = 'yes' THEN
      SET Service_price = Service_price + (SELECT price FROM services WHERE id = 2);
	END IF;
    
    
-- получение id свободной комнаты
	SET id_room = (
	  SELECT id FROM rooms WHERE type_room_id = id_type_room AND id NOT IN (
			SELECT rooms_id FROM booking_has_rooms
			WHERE booking_id IN (
                    SELECT id FROM booking
                    WHERE arrival BETWEEN booking.arrival AND booking.departure OR departure BETWEEN booking.arrival AND booking.departure
			)
		) LIMIT 1
	);
      
    START TRANSACTION;
    
-- проверка на наличие комнаты и добавление записей
 	IF id_room IS NOT NULL THEN
	  -- вставляем новое бронирование в таблицу booking
      INSERT INTO booking (quantity_adults, quantity_children, arrival, departure, nights_count, price_per_room, price_per_servises, date, client_id)
      VALUES (quantity_adults, quantity_children, arrival, departure, nights_count, AllPrice_per_room, Service_price, current_datetime, client_id);
	ELSE 
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка при поиске свободной комнаты';
    END IF;
    
    SET last_booking_id = LAST_INSERT_ID();
    
	  -- запись в таблицу booking_has_rooms
    INSERT INTO booking_has_rooms (booking_id, rooms_id)
    VALUES (last_booking_id, id_room);
    
	IF ROW_COUNT() > 0 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
    
	
   -- запись в таблицу booking_has_services
	IF service_wifi = 'yes' THEN
	-- добавление в теблицу booking_has_services
	  INSERT INTO booking_has_services(services_id, booking_id)
	  VALUES(1, last_booking_id);
	END IF;
	IF service_Late_check_out = 'yes' THEN
	-- добавление в теблицу booking_has_services
	  INSERT INTO booking_has_services(services_id, booking_id)
	  VALUES(2, last_booking_id);
	END IF; 
    
-- вывод данных
	SELECT AllPrice_per_room as 'Стоимость за номер', nights_count as 'Ночи', Service_price as 'Стоимость за доп. сервисы', id_room as 'Комната';  
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddService`(
	IN booking_id INT,
	IN id_service INT
)
BEGIN
	DECLARE time_departure DATETIME;
    DECLARE current_datetime DATETIME;
    
    DECLARE availability_of_the_service INT;
    DECLARE services_in_booking INT;
    
    DECLARE service_price DECIMAL(10.2);
    
-- получение текущей даты
  SET current_datetime = NOW();
-- получить время выезда из номера по id брони
  SET time_departure = (SELECT departure FROM booking
						  WHERE id = booking_id);
-- проверка, является ли бронь актуальной
  IF current_datetime > time_departure THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Добавление услуги недоступно для истёкшой брони';
  END IF;
  
		
-- добавление данных в таблицу booking_has_services
  SET availability_of_the_service = (SELECT id FROM services WHERE id = id_service);
  
  IF availability_of_the_service IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Сервиса с таким id не существует';
  ELSE
	INSERT INTO booking_has_services(services_id, booking_id)
	VALUES(id_service, booking_id);

  
-- изменение стоимости за сервисы
  SET service_price = (SELECT price FROM services WHERE id = id_service);
  UPDATE booking 
  SET price_per_servises = price_per_servises + service_price
  WHERE id = booking_id;
  
  UPDATE payments
  SET amount = amount + service_price
  WHERE booking_id = payments.booking_id;
  
  END IF;

-- вывод данных
  SELECT time_departure;    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MakeAPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MakeAPayment`(
	IN booking_id INT,
    IN method ENUM('cash', 'non-cash')
)
BEGIN
    DECLARE payment_exists INT;

-- проверка существования записи с указанным id
    SELECT COUNT(*) INTO payment_exists
    FROM payments
    WHERE payments.booking_id = booking_id;

    IF payment_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Запись с указанным ID не найдена в таблице payments';
    ELSE
		IF (SELECT payment_date FROM payments WHERE payments.booking_id = booking_id) IS NULL THEN
        -- Обновление записи
        UPDATE payments 
        SET payment_date = NOW(), payment_method = method
        WHERE payments.booking_id = booking_id;
        
		ELSE
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Данная бронь уже оплачена';
		END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `current_bookings_view`
--

/*!50001 DROP VIEW IF EXISTS `current_bookings_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_bookings_view` AS select `booking`.`id` AS `booking_id`,`clients`.`name` AS `client_name`,`rooms`.`number` AS `number`,`room_type`.`title` AS `room_type`,`booking`.`arrival` AS `arrival`,`booking`.`departure` AS `departure` from ((((`booking` join `clients` on((`booking`.`client_id` = `clients`.`id`))) join `booking_has_rooms` on((`booking`.`id` = `booking_has_rooms`.`booking_id`))) join `rooms` on((`booking_has_rooms`.`rooms_id` = `rooms`.`id`))) join `room_type` on((`rooms`.`type_room_id` = `room_type`.`id`))) where ((`booking`.`departure` >= curdate()) and (`booking`.`arrival` <= curdate())) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `monthlyrevenue`
--

/*!50001 DROP VIEW IF EXISTS `monthlyrevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `monthlyrevenue` AS select date_format(`booking`.`date`,'%Y-%m') AS `Month`,sum(`payments`.`amount`) AS `TotalRevenue` from (`booking` join `payments` on((`payments`.`booking_id` = `booking`.`id`))) group by date_format(`booking`.`date`,'%Y-%m') order by `Month` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-23 13:01:12

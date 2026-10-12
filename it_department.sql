-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: it_department
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `ced_students_view`
--

DROP TABLE IF EXISTS `ced_students_view`;
/*!50001 DROP VIEW IF EXISTS `ced_students_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ced_students_view` AS SELECT 
 1 AS `student_number`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `age`,
 1 AS `address`,
 1 AS `program_code`,
 1 AS `program_name`,
 1 AS `year_level`,
 1 AS `student_type`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `it_student_records`
--

DROP TABLE IF EXISTS `it_student_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `it_student_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `age` tinyint NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `college_code` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `program_code` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `program_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `year_level` tinyint NOT NULL,
  `student_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_number` (`student_number`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `it_student_records`
--

LOCK TABLES `it_student_records` WRITE;
/*!40000 ALTER TABLE `it_student_records` DISABLE KEYS */;
INSERT INTO `it_student_records` VALUES (1,'SIM-0001','Jirah','Ege',19,'Dumaguete City','CED','CpE','BS Computer Engineering',1,'new'),(2,'SIM-0002','JiRAHH','Yehey',20,'Valencia','CED','CpE','BS Computer Engineering',2,'old'),(3,'SIM-0003','Pedro','Reyes',21,'Bacong','CED','CE','BS Civil Engineering',3,'old'),(4,'SIM-0004','Ana','Garcia',22,'Sibulan','CED','EE','BS Electrical Engineering',4,'old'),(5,'SIM-0005','Luis','Torres',19,'Dauin','CBA','BSBA','BS Business Administration',1,'new'),(6,'SIM-0006','Rosa','Mendoza',20,'Zamboanguita','CON','BSN','BS Nursing',2,'old'),(7,'SIM-0007','Samuel','Real',19,'Dumaguete City','CED','CpE','BS Computer Engineering',2,'new'),(9,'SIM-0008','Tomn','Jerry',22,'Dumaguete City','CON','BSN','BS Nursing',3,'new'),(10,'SIM-0009','JiRUH','Ege',19,'Dumaguete City','CED','CpE','BS Computer Engineering',1,'new'),(12,'SIM-0010','JiBRUH','Egestudyante',19,'Dumaguete City','CED','CpE','BS Computer Engineering',2,'new'),(13,'SIM-0011','Kent','Tan',23,'Dumaguete City','CED','CE','BS Civil Engineering',4,'old'),(14,'SIM-0012','Overlord','Baring',32,'Dumaguete City','CED','ME','BS Mechanical Engineering',3,'old');
/*!40000 ALTER TABLE `it_student_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `ced_students_view`
--

/*!50001 DROP VIEW IF EXISTS `ced_students_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ced_students_view` AS select `it_student_records`.`student_number` AS `student_number`,`it_student_records`.`first_name` AS `first_name`,`it_student_records`.`last_name` AS `last_name`,`it_student_records`.`age` AS `age`,`it_student_records`.`address` AS `address`,`it_student_records`.`program_code` AS `program_code`,`it_student_records`.`program_name` AS `program_name`,`it_student_records`.`year_level` AS `year_level`,`it_student_records`.`student_type` AS `student_type` from `it_student_records` where (`it_student_records`.`college_code` = 'CED') */;
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

-- Dump completed on 2026-10-13  1:35:05

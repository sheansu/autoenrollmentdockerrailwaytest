-- MySQL dump 10.13  Distrib 8.4.11, for Linux (x86_64)
--
-- Host: localhost    Database: ced_preenrollment
-- ------------------------------------------------------
-- Server version	8.4.11

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
-- Table structure for table `advising_requests`
--

DROP TABLE IF EXISTS `advising_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advising_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `teacher_id` int DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `school_year` varchar(10) NOT NULL,
  `semester` tinyint NOT NULL,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `advising_requests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `advising_requests_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advising_requests`
--

LOCK TABLES `advising_requests` WRITE;
/*!40000 ALTER TABLE `advising_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `advising_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum`
--

DROP TABLE IF EXISTS `curriculum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curriculum` (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `year_level` tinyint NOT NULL,
  `semester` tinyint NOT NULL,
  `subject_id` int NOT NULL,
  `standard_units` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `curriculum_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `curriculum_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum`
--

LOCK TABLES `curriculum` WRITE;
/*!40000 ALTER TABLE `curriculum` DISABLE KEYS */;
INSERT INTO `curriculum` VALUES (1,1,1,1,42,1),(2,1,1,1,43,2),(3,1,1,1,1,3),(4,1,1,1,2,4),(5,1,1,1,17,3),(6,1,1,1,18,3),(7,1,1,1,23,3),(8,1,1,1,25,3),(9,1,1,1,38,3),(10,1,1,1,34,2),(11,1,1,1,32,0),(16,1,1,2,9,4),(17,1,1,2,44,2),(18,1,1,2,40,1),(19,1,1,2,3,3),(20,1,1,2,4,4),(21,1,1,2,20,3),(22,1,1,2,39,3),(23,1,1,2,35,2),(24,1,1,2,33,0),(25,1,1,2,8,4),(31,1,2,1,29,3),(32,1,2,1,45,2),(33,1,2,1,41,1),(34,1,2,1,47,5),(35,1,2,1,5,3),(36,1,2,1,10,3),(37,1,2,1,11,3),(38,1,2,1,12,3),(39,1,2,1,26,3),(40,1,2,1,36,2),(46,1,2,2,46,4),(47,1,2,2,48,5),(48,1,2,2,6,3),(49,1,2,2,7,3),(50,1,2,2,49,3),(51,1,2,2,19,3),(52,1,2,2,21,3),(53,1,2,2,37,2),(61,1,3,1,50,4),(62,1,3,1,51,3),(63,1,3,1,52,3),(64,1,3,1,53,1),(65,1,3,1,54,3),(66,1,3,1,55,1),(67,1,3,1,56,3),(68,1,3,1,15,3),(69,1,3,1,27,3),(76,1,3,2,57,2),(77,1,3,2,58,4),(78,1,3,2,59,4),(79,1,3,2,60,2),(80,1,3,2,61,3),(81,1,3,2,16,3),(82,1,3,2,22,3),(83,1,3,2,24,3),(91,1,3,3,71,3),(92,1,4,1,30,3),(93,1,4,1,62,4),(94,1,4,1,63,4),(95,1,4,1,64,3),(96,1,4,1,65,1),(97,1,4,1,66,4),(98,1,4,1,28,3),(99,1,4,2,31,3),(100,1,4,2,67,1),(101,1,4,2,68,2),(102,1,4,2,69,3),(103,1,4,2,70,3),(104,1,4,2,13,3),(105,1,4,2,14,2);
/*!40000 ALTER TABLE `curriculum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'CpE','Computer Engineering'),(2,'CE','Civil Engineering'),(3,'EE','Electrical Engineering'),(4,'ME','Mechanical Engineering'),(5,'ARCH','Architecture');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment_settings`
--

DROP TABLE IF EXISTS `enrollment_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_open` tinyint(1) NOT NULL DEFAULT '0',
  `school_year` varchar(10) NOT NULL,
  `semester` tinyint NOT NULL,
  `opened_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `previous_school_year` varchar(10) DEFAULT NULL,
  `previous_semester` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_settings`
--

LOCK TABLES `enrollment_settings` WRITE;
/*!40000 ALTER TABLE `enrollment_settings` DISABLE KEYS */;
INSERT INTO `enrollment_settings` VALUES (1,0,'2026-2027',1,'2026-10-12 15:44:31',NULL,NULL);
/*!40000 ALTER TABLE `enrollment_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `school_year` varchar(10) NOT NULL,
  `semester` tinyint NOT NULL,
  `status` enum('auto_enrolled','manually_added','dropped','conflict_removed','pre_enlisted','submitted_for_advising','officially_enrolled') NOT NULL DEFAULT 'auto_enrolled',
  `enrolled_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `section_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_enrollment` (`student_id`,`subject_id`,`school_year`,`semester`),
  KEY `subject_id` (`subject_id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  CONSTRAINT `enrollments_ibfk_3` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_contacts`
--

DROP TABLE IF EXISTS `faculty_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `department_id` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `faculty_contacts_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_contacts`
--

LOCK TABLES `faculty_contacts` WRITE;
/*!40000 ALTER TABLE `faculty_contacts` DISABLE KEYS */;
INSERT INTO `faculty_contacts` VALUES (4,'Asst. Prof. Klint Ian V. Austero','Dean, College of Engineering & Design',NULL,'klintvaustero@su.edu.ph',NULL),(5,'Anie D. Escarilla','Secretary, College of Engineering & Design',NULL,'eng_g@su.edu.ph',NULL),(6,'Dr. Marife K. Villareal','Faculty, Computer Engineering',1,'marifekvillareal@su.edu.ph',NULL),(7,'Engr. Johnson B. Diputado','Faculty, Computer Engineering',1,'johnsonbdiputado@su.edu.ph',NULL);
/*!40000 ALTER TABLE `faculty_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `grade` decimal(4,2) DEFAULT NULL,
  `passed` tinyint(1) NOT NULL DEFAULT '0',
  `school_year` varchar(10) NOT NULL,
  `semester` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_grade` (`student_id`,`subject_id`,`school_year`,`semester`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `type` enum('unit_overload','unit_underload','f2f_required','conflict','prereq_not_met') NOT NULL,
  `message` text NOT NULL,
  `resolved` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `notices_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notices`
--

LOCK TABLES `notices` WRITE;
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prerequisites`
--

DROP TABLE IF EXISTS `prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prerequisites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `prerequisite_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_id` (`subject_id`),
  KEY `prerequisite_id` (`prerequisite_id`),
  CONSTRAINT `prerequisites_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  CONSTRAINT `prerequisites_ibfk_2` FOREIGN KEY (`prerequisite_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prerequisites`
--

LOCK TABLES `prerequisites` WRITE;
/*!40000 ALTER TABLE `prerequisites` DISABLE KEYS */;
INSERT INTO `prerequisites` VALUES (1,44,43),(2,3,1),(3,4,1),(4,4,2),(5,8,1),(6,35,34),(7,39,38),(8,45,44),(9,41,40),(10,47,8),(11,5,4),(12,10,4),(13,11,4),(14,11,8),(15,12,9),(16,36,34),(17,46,45),(18,48,47),(19,6,5),(20,7,5),(21,49,4),(22,49,5),(23,37,34),(24,50,48),(25,51,45),(26,52,48),(27,53,43),(28,53,48),(29,54,48),(30,55,48),(31,15,7),(32,15,47),(33,57,56),(34,58,52),(35,59,50),(36,60,6),(37,60,50),(38,60,21),(39,61,46),(40,16,51),(41,62,59),(42,63,59),(43,64,61),(44,65,59),(45,65,60),(46,66,15),(47,30,29),(48,67,60),(49,68,65),(50,69,62),(51,70,64),(52,13,5),(53,14,10),(54,31,30);
/*!40000 ALTER TABLE `prerequisites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `teacher_id` int DEFAULT NULL,
  `section_code` varchar(10) NOT NULL,
  `capacity` tinyint NOT NULL DEFAULT '40',
  `day` enum('Mon/Thu','Tue/Fri','Wed/Sat','Mon','Tue','Wed','Thu','Fri','Sat') DEFAULT NULL,
  `time_start` time DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  `room` varchar(50) DEFAULT NULL,
  `school_year` varchar(10) NOT NULL,
  `semester` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_id` (`subject_id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  CONSTRAINT `sections_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_number` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `age` tinyint NOT NULL,
  `address` varchar(255) NOT NULL,
  `department_id` int NOT NULL,
  `course` varchar(100) NOT NULL,
  `year_level` tinyint NOT NULL,
  `type` enum('new','old','shiftee') NOT NULL DEFAULT 'new',
  `status` enum('regular','irregular','on_probation') DEFAULT NULL,
  `ok_to_enroll` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `current_semester` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_number` (`student_number`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_change_requests`
--

DROP TABLE IF EXISTS `subject_change_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_change_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `request_type` enum('add','drop','shift') NOT NULL,
  `reason` text,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `subject_change_requests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `subject_change_requests_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_change_requests`
--

LOCK TABLES `subject_change_requests` WRITE;
/*!40000 ALTER TABLE `subject_change_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_change_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_schedules`
--

DROP TABLE IF EXISTS `subject_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `day` enum('Mon/Thu','Tue/Fri','Wed/Sat','Mon','Tue','Wed','Thu','Fri','Sat') NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  `room` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `subject_schedules_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_schedules`
--

LOCK TABLES `subject_schedules` WRITE;
/*!40000 ALTER TABLE `subject_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `units` tinyint NOT NULL,
  `type` enum('engineering','GE','PE','NSTP','drawing') NOT NULL DEFAULT 'engineering',
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,'EM 11','Calculus 1 (Differential Calculus)',3,'engineering',NULL),(2,'EM 13','Algebra and Trigonometry for Engineering',4,'engineering',NULL),(3,'EM 16','Discrete Mathematics',3,'engineering',NULL),(4,'EM 18','Calculus 2 (Integral Calculus)',4,'engineering',NULL),(5,'EM 21','Differential Equations',3,'engineering',NULL),(6,'EM 24','Engineering Data Analysis',3,'engineering',NULL),(7,'EM 31','Numerical Methods',3,'engineering',NULL),(8,'Phys 1','Physics for Engineers',4,'engineering',NULL),(9,'Chem 14','Chemistry for Engineers',4,'engineering',NULL),(10,'ES 21','Engineering Economics',3,'engineering',NULL),(11,'ES 23R','Statics of Rigid Bodies',3,'engineering',NULL),(12,'ES 25R','Environmental Science and Engineering',3,'engineering',NULL),(13,'ES 28','Technopreneurship',3,'engineering',NULL),(14,'ES 40R','Engineering Management',2,'engineering',NULL),(15,'EES 31','Feedback and Control Systems',3,'engineering',NULL),(16,'EES 34','Basic Occupational Health and Safety',3,'engineering',NULL),(17,'GE 1','Understanding the Self',3,'GE',NULL),(18,'GE 2','Readings in Philippine History',3,'GE',NULL),(19,'GE 3','The Contemporary World',3,'GE',NULL),(20,'GE 4','Mathematics for the Modern World',3,'GE',NULL),(21,'GE 5','Purposive Communication',3,'GE',NULL),(22,'GE 6','Art Appreciation',3,'GE',NULL),(23,'GE 7','Science, Technology and Society',3,'GE',NULL),(24,'GE 8','Ethics',3,'GE',NULL),(25,'GE 9','The Life and Works of Jose Rizal',3,'GE',NULL),(26,'GE 10A','Whole Person Education',3,'GE',NULL),(27,'GE 11','Climate Change: Effects on People and Ecosystems',3,'GE',NULL),(28,'GE 12','Ethics of the Christian Faith',3,'GE',NULL),(29,'CHS 1','Reading and Interpreting the Hebrew Scriptures',3,'GE',NULL),(30,'CHS 2','Reading and Interpreting the Christian Scriptures',3,'GE',NULL),(31,'CHS 3','Ethics of the Christian Faith',3,'GE',NULL),(32,'PEP 1','Personality Enhancement Program 1',0,'GE',NULL),(33,'PEP 2','Personality Enhancement Program 2',0,'GE',NULL),(34,'PE 1','Physical Fitness and Swimming',2,'PE',NULL),(35,'PE 2','Physical Education 2',2,'PE',NULL),(36,'PE 3','Physical Education 3',2,'PE',NULL),(37,'PE 4','Physical Education 4',2,'PE',NULL),(38,'NSTP 1','National Service Training Program 1',3,'NSTP',NULL),(39,'NSTP 2','National Service Training Program 2',3,'NSTP',NULL),(40,'Draw 11R','Engineering Drawing and Plans',1,'drawing',NULL),(41,'Draw 12R','Computer-Aided Drafting (CAD)',1,'drawing',NULL),(42,'CpE 1','Computer Engineering as a Discipline',1,'engineering',1),(43,'CpE 11','Programming Logic and Design',2,'engineering',1),(44,'CpE 12','Object Oriented Programming',2,'engineering',1),(45,'CpE 21','Data Structures and Algorithm',2,'engineering',1),(46,'CpE 22','Software Design',4,'engineering',1),(47,'EE 21CpE','Fundamentals of Electrical Circuits',5,'engineering',1),(48,'EE 24CpE','Fundamentals of Electronic Circuits',5,'engineering',1),(49,'EMCp 26','Engineering Mathematics for CpE',3,'engineering',1),(50,'CpE 31','Logic Circuits and Design',4,'engineering',1),(51,'CpE 33','Operating Systems',3,'engineering',1),(52,'CpE 35','Data and Digital Communications',3,'engineering',1),(53,'CpE 37','Introduction to HDL',1,'engineering',1),(54,'CpE 39','Fundamentals of Mixed Signals and Sensors',3,'engineering',1),(55,'CpE 41','Computer Engineering Drafting and Design',1,'engineering',1),(56,'CpE 43','Engineering Ethics',3,'engineering',1),(57,'CpE 30','CpE Laws and Professional Practice',2,'engineering',1),(58,'CpE 32','Computer Networks and Security',4,'engineering',1),(59,'CpE 34','Microprocessors',4,'engineering',1),(60,'CpE 36','Methods of Research',2,'engineering',1),(61,'CpE 38','Software Development 1 (Elective 1)',3,'engineering',1),(62,'CpE 45','Embedded Systems',4,'engineering',1),(63,'CpE 47','Computer Architecture and Organization',4,'engineering',1),(64,'CpE 49','Software Development 2 (Elective 2)',3,'engineering',1),(65,'CpE 51','CpE Practice and Design 1',1,'engineering',1),(66,'CpE 53','Digital Signal Processing',4,'engineering',1),(67,'CpE 40','Seminars and Fieldtrips',1,'engineering',1),(68,'CpE 42','CpE Practice and Design 2',2,'engineering',1),(69,'CpE 44','Emerging Technologies in CpE',3,'engineering',1),(70,'CpE 46','System and Network Administration 1 (Elective 3)',3,'engineering',1),(71,'CpE 300','On the Job Training (OJT)',3,'engineering',1);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_subjects`
--

DROP TABLE IF EXISTS `teacher_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `teacher_subjects_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`),
  CONSTRAINT `teacher_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_subjects`
--

LOCK TABLES `teacher_subjects` WRITE;
/*!40000 ALTER TABLE `teacher_subjects` DISABLE KEYS */;
INSERT INTO `teacher_subjects` VALUES (1,1,42),(2,1,43),(3,1,1),(4,1,2),(5,1,17),(6,1,18),(7,1,23),(8,1,25),(9,1,38),(10,1,34),(11,1,32);
/*!40000 ALTER TABLE `teacher_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `teachers_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,3,'Kar','Baring','karizzaabaring@su.edu.ph',1,'2026-10-12 15:44:32');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','admin','business_office','teacher') NOT NULL,
  `student_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','admin',NULL,'2026-10-12 15:44:32'),(2,'busoff','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','business_office',NULL,'2026-10-12 15:44:32'),(3,'teacher1','$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','teacher',NULL,'2026-10-12 15:44:32');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-12 16:36:59

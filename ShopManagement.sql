-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `confirmorder`
--

DROP TABLE IF EXISTS `confirmorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confirmorder` (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `customerid` int NOT NULL,
  `productid` int NOT NULL,
  `quantity` int NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'pending',
  `date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`orderid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confirmorder`
--

LOCK TABLES `confirmorder` WRITE;
/*!40000 ALTER TABLE `confirmorder` DISABLE KEYS */;
INSERT INTO `confirmorder` VALUES (1,2,16,1,'confirm','2024-05-24 08:26:33.946'),(2,2,17,1,'confirm','2024-05-24 08:26:33.956'),(3,2,18,1,'confirm','2024-05-24 08:26:33.968'),(4,2,19,1,'confirm','2024-05-24 08:26:33.979');
/*!40000 ALTER TABLE `confirmorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `cname` varchar(45) NOT NULL,
  `cemail` varchar(45) NOT NULL,
  `cphone` bigint NOT NULL,
  `address` varchar(100) NOT NULL DEFAULT 'agortola',
  `cpassword` varchar(20) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`),
  UNIQUE KEY `cemail_UNIQUE` (`cemail`),
  UNIQUE KEY `cphone_UNIQUE` (`cphone`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'shaon','shaon@gmail.com',1751227593,'agortola','shaon'),(2,'hridoy','hridoy@gmail.com',3864587634,'agortola','hridoy'),(3,'ghgfh','fghfgh@vng',56757567,'agortola','ty'),(4,'cghfgh','fghrtfgh@hgfh',6567546,'agortola','hello'),(5,'dfhfhfg','hfghfghf@dfgfd',46456546,'agortola','fgh'),(6,'nvngfh','bvbcdfg@dfgdf',5465464,'agortola','keda'),(7,'fghfgh','fghdfghf@ghfdh',546546456,'agortola','as'),(8,'dfgfdhf','ghfghfg@gdhfgh',56756756,'agortola','qw'),(9,'keda','kdshfdfb@hjsdvghvsd',345345,'agortola','rew'),(10,'bangl','bangla@g',34567,'agortola','bangla'),(28,'dfhgfg','hfhdfgh@fghfgh',56456,'fghdfhg','bal'),(32,'mia','mia123@gmail.com',17512275934,'khilgati,ghatail','mia');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `customerid` int NOT NULL,
  `productid` int NOT NULL,
  `quantity` int NOT NULL,
  `orderdate` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`orderid`),
  UNIQUE KEY `orderid_UNIQUE` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productcategory`
--

DROP TABLE IF EXISTS `productcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productcategory` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) NOT NULL,
  `cdes` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cname_UNIQUE` (`cname`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productcategory`
--

LOCK TABLES `productcategory` WRITE;
/*!40000 ALTER TABLE `productcategory` DISABLE KEYS */;
INSERT INTO `productcategory` VALUES (1,'JUICE','I LOVE JUICE '),(2,'Chips','i love Chips'),(5,'Drinks','i love to drinks'),(7,'Icecream','i love icecream');
/*!40000 ALTER TABLE `productcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `pname` varchar(100) NOT NULL,
  `pimg` varchar(255) DEFAULT 'default.jpg',
  `unitprice` int NOT NULL,
  `totalp` int NOT NULL,
  `pcompany` varchar(100) NOT NULL,
  `pdes` varchar(250) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cid` int DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `cid_idx` (`cid`),
  CONSTRAINT `fk_cid` FOREIGN KEY (`cid`) REFERENCES `productcategory` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (16,'Disgo khur','Disgo khur_amra.jpg',1,1,'ty','valo chele nah','2024-04-27 10:41:59',2),(17,'jiuce','jiuce_juice.jfif',34,4,'bcb','cvncn','2024-04-28 07:38:08',5),(18,'fghv','fghv_515Dk7zatmL._AC_UF1000,1000_QL80_.jpg',456,6456,'gjgj','ghj','2024-04-28 07:38:23',5),(19,'Mango','Mango_Mango.jpg',3,5345,'natural','cfgfghfg','2024-05-07 09:30:07',1),(24,'Orange','Orange_orange-1558624428.jpg',4,345,'fdfgh','fnvcbn','2024-05-07 09:30:56',1),(25,'Chips','Chips_download.jfif',34,456,'gdfg','cvbcvb','2024-05-07 09:31:47',2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selldetails`
--

DROP TABLE IF EXISTS `selldetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selldetails` (
  `sellid` int NOT NULL AUTO_INCREMENT,
  `productid` int NOT NULL,
  `customerid` int NOT NULL,
  `quantity` int NOT NULL,
  `date` timestamp(3) NOT NULL,
  PRIMARY KEY (`sellid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selldetails`
--

LOCK TABLES `selldetails` WRITE;
/*!40000 ALTER TABLE `selldetails` DISABLE KEYS */;
INSERT INTO `selldetails` VALUES (1,16,2,2,'2024-05-23 10:17:08.000'),(2,17,2,2,'2024-05-23 10:17:08.000'),(3,18,2,1,'2024-05-23 10:17:08.000'),(4,19,2,4,'2024-05-23 10:17:08.000'),(5,16,2,1,'2024-05-24 08:17:04.000'),(6,17,2,1,'2024-05-24 08:17:04.000'),(7,18,2,1,'2024-05-24 08:17:04.000'),(8,19,2,1,'2024-05-24 08:17:04.000'),(9,16,2,1,'2024-05-24 08:20:34.000'),(10,17,2,1,'2024-05-24 08:20:34.000'),(11,19,2,1,'2024-05-24 08:20:34.000'),(12,24,2,1,'2024-05-24 08:20:34.000'),(13,25,2,1,'2024-05-24 08:20:34.000'),(14,16,2,1,'2024-05-24 08:26:33.000'),(15,17,2,1,'2024-05-24 08:26:33.000'),(16,18,2,1,'2024-05-24 08:26:33.000'),(17,19,2,1,'2024-05-24 08:26:33.000');
/*!40000 ALTER TABLE `selldetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `useremail` varchar(100) NOT NULL,
  `userpassword` varchar(20) NOT NULL,
  `userimg` varchar(100) DEFAULT 'default.jpg',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `useremail_UNIQUE` (`useremail`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'bel','bel@gamd','bel','default.jpg'),(2,'bela','bela@gmail.com','kela','default.jpg'),(3,'hridoy','hridoy@gmail.com','hridoy','default.jpg'),(4,'bangla','bangla@gmail.com','bangla','default.jpg'),(6,'mia','mia@gmail.com','mia','default.jpg'),(7,'hellobi','hellob@gmail','hello','default.jpg'),(8,'kedagotumra','sdgkfbjsbvhfjs@jgbfhjs','bela','default.jpg'),(16,'shaon','haon@gmail.com','haon','default.jpg'),(17,'Md Shaon','shaon42hridoy@gmail.com','shaon','default.jpg'),(18,'dfghf','ghfgh@dhfg','zx','default.jpg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-24 15:39:18

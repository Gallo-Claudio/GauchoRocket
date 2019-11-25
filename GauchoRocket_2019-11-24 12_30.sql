CREATE DATABASE  IF NOT EXISTS `gauchorocket` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `gauchorocket`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gauchorocket
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cabina`
--

DROP TABLE IF EXISTS `cabina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cabina` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cabinaNombre` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabina`
--

LOCK TABLES `cabina` WRITE;
/*!40000 ALTER TABLE `cabina` DISABLE KEYS */;
INSERT INTO `cabina` VALUES (1,'General'),(2,'Familiar'),(3,'Suite');
/*!40000 ALTER TABLE `cabina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capacidad`
--

DROP TABLE IF EXISTS `capacidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `capacidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelo` int(11) DEFAULT NULL,
  `tipo_cabina` int(11) DEFAULT NULL,
  `filas` int(11) DEFAULT NULL,
  `columnas` int(11) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modelo` (`modelo`),
  KEY `tipo_cabina` (`tipo_cabina`),
  CONSTRAINT `capacidad_ibfk_1` FOREIGN KEY (`modelo`) REFERENCES `modelos_naves` (`id`),
  CONSTRAINT `capacidad_ibfk_2` FOREIGN KEY (`tipo_cabina`) REFERENCES `cabina` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacidad`
--

LOCK TABLES `capacidad` WRITE;
/*!40000 ALTER TABLE `capacidad` DISABLE KEYS */;
INSERT INTO `capacidad` VALUES (1,1,1,20,10,1000),(2,1,2,15,5,1500),(3,1,3,5,5,2500),(4,2,1,20,5,800),(5,2,2,9,2,1300),(6,2,3,1,2,2300),(7,3,1,10,5,1300),(8,3,2,10,5,3500),(9,4,1,11,10,1200),(10,5,2,10,5,2600),(11,5,3,5,2,3700),(12,6,2,14,5,2600),(13,6,3,5,2,3700),(14,7,1,20,10,1600),(15,7,2,15,5,3000),(16,7,3,5,5,4100),(17,8,1,30,10,1600),(18,8,2,5,2,3000),(19,8,3,8,5,4100),(20,9,1,15,10,1600),(21,9,2,5,5,3000),(22,9,3,5,5,4100),(23,10,3,10,10,10000),(24,10,2,10,10,10);
/*!40000 ALTER TABLE `capacidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centros_medicos`
--

DROP TABLE IF EXISTS `centros_medicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `centros_medicos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `turnos_diarios` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centros_medicos`
--

LOCK TABLES `centros_medicos` WRITE;
/*!40000 ALTER TABLE `centros_medicos` DISABLE KEYS */;
INSERT INTO `centros_medicos` VALUES (1,'Buenos Aires',300),(2,'Shanghai',210),(3,'Ankara',200);
/*!40000 ALTER TABLE `centros_medicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circuitos`
--

DROP TABLE IF EXISTS `circuitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `circuitos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `sentido` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circuitos`
--

LOCK TABLES `circuitos` WRITE;
/*!40000 ALTER TABLE `circuitos` DISABLE KEYS */;
INSERT INTO `circuitos` VALUES (1,'Circuito 1 - Ida','ida'),(2,'Circuito 2 - Ida','ida'),(3,'Bs As',NULL),(4,'Ankara',NULL),(5,'Circuito 1 - Vuelta','vuelta'),(6,'Circuito 2 - Vuelta','vuelta');
/*!40000 ALTER TABLE `circuitos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circuitos_estaciones`
--

DROP TABLE IF EXISTS `circuitos_estaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `circuitos_estaciones` (
  `circuito_id` int(11) NOT NULL,
  `estacion_id` int(11) NOT NULL,
  PRIMARY KEY (`circuito_id`,`estacion_id`),
  KEY `estacion_id` (`estacion_id`),
  CONSTRAINT `circuitos_estaciones_ibfk_1` FOREIGN KEY (`circuito_id`) REFERENCES `circuitos` (`id`),
  CONSTRAINT `circuitos_estaciones_ibfk_2` FOREIGN KEY (`estacion_id`) REFERENCES `estaciones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circuitos_estaciones`
--

LOCK TABLES `circuitos_estaciones` WRITE;
/*!40000 ALTER TABLE `circuitos_estaciones` DISABLE KEYS */;
INSERT INTO `circuitos_estaciones` VALUES (1,1),(2,1),(3,1),(5,1),(6,1),(1,2),(2,2),(4,2),(5,2),(6,2),(1,3),(2,3),(5,3),(6,3),(1,4),(5,4),(1,5),(2,5),(5,5),(6,5),(1,6),(5,6),(2,7),(6,7),(2,8),(6,8),(2,9),(6,9),(2,10),(6,10),(2,11),(6,11);
/*!40000 ALTER TABLE `circuitos_estaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credenciales`
--

DROP TABLE IF EXISTS `credenciales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `credenciales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `rol` int(11) DEFAULT NULL,
  `clave` varchar(50) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rol` (`rol`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `credenciales_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credenciales`
--

LOCK TABLES `credenciales` WRITE;
/*!40000 ALTER TABLE `credenciales` DISABLE KEYS */;
INSERT INTO `credenciales` VALUES (1,'Tomas',1,'81dc9bdb52d04dc20036dbd8313ed055',1),(2,'Sebastian',2,'81dc9bdb52d04dc20036dbd8313ed055',2),(9,'gallo',2,'81dc9bdb52d04dc20036dbd8313ed055',23);
/*!40000 ALTER TABLE `credenciales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estaciones`
--

DROP TABLE IF EXISTS `estaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `estaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estaciones`
--

LOCK TABLES `estaciones` WRITE;
/*!40000 ALTER TABLE `estaciones` DISABLE KEYS */;
INSERT INTO `estaciones` VALUES (1,'Buenos Aires'),(2,'Ankara'),(3,'EEI'),(4,'Orbital Hotel'),(5,'Luna'),(6,'Marte'),(7,'Ganimedes'),(8,'Europa'),(9,'Io'),(10,'Encedalo'),(11,'Titan');
/*!40000 ALTER TABLE `estaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturacion`
--

DROP TABLE IF EXISTS `facturacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `facturacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_pago` date DEFAULT NULL,
  `monto_pago` int(11) DEFAULT NULL,
  `id_reserva` int(11) DEFAULT NULL,
  `numero_tarjeta` int(11) DEFAULT NULL,
  `tipo_de_tarjeta` int(11) DEFAULT NULL,
  `titular` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_reserva` (`id_reserva`),
  KEY `tipo_de_tarjeta` (`tipo_de_tarjeta`),
  CONSTRAINT `facturacion_ibfk_1` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id`),
  CONSTRAINT `facturacion_ibfk_2` FOREIGN KEY (`tipo_de_tarjeta`) REFERENCES `tarjetas_credito` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturacion`
--

LOCK TABLES `facturacion` WRITE;
/*!40000 ALTER TABLE `facturacion` DISABLE KEYS */;
INSERT INTO `facturacion` VALUES (1,'2019-11-21',6400,149,6359,3,'Palo Gandolfo'),(2,'2019-11-21',6400,149,6312,2,'Pink Floyd'),(3,'2019-11-21',6400,149,8967,2,'rtrttt'),(4,'2019-11-21',6400,149,3987,2,'kjjkjkk olop');
/*!40000 ALTER TABLE `facturacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrantes_viaje`
--

DROP TABLE IF EXISTS `integrantes_viaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `integrantes_viaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuarios` int(11) DEFAULT NULL,
  `id_reserva` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuarios` (`id_usuarios`),
  KEY `id_reserva` (`id_reserva`),
  CONSTRAINT `integrantes_viaje_ibfk_1` FOREIGN KEY (`id_usuarios`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `integrantes_viaje_ibfk_2` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrantes_viaje`
--

LOCK TABLES `integrantes_viaje` WRITE;
/*!40000 ALTER TABLE `integrantes_viaje` DISABLE KEYS */;
INSERT INTO `integrantes_viaje` VALUES (1,1,149),(4,1,1),(5,23,1),(6,1,90),(7,26,90),(8,1,113),(9,1,94),(10,1,140),(11,1,147),(12,1,148),(13,1,150);
/*!40000 ALTER TABLE `integrantes_viaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_menu` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Standard'),(2,'Gourmet'),(3,'Spa');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meses`
--

DROP TABLE IF EXISTS `meses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `meses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meses` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meses`
--

LOCK TABLES `meses` WRITE;
/*!40000 ALTER TABLE `meses` DISABLE KEYS */;
INSERT INTO `meses` VALUES (1,'Enero'),(2,'Febrero'),(3,'Marzo'),(4,'Abril'),(5,'Mayo'),(6,'Junio'),(7,'Julio'),(8,'Agosto'),(9,'Septiembre'),(10,'Octubre'),(11,'Noviembre'),(12,'Diciembre');
/*!40000 ALTER TABLE `meses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelos_naves`
--

DROP TABLE IF EXISTS `modelos_naves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `modelos_naves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naveNombre` varchar(20) DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelos_naves`
--

LOCK TABLES `modelos_naves` WRITE;
/*!40000 ALTER TABLE `modelos_naves` DISABLE KEYS */;
INSERT INTO `modelos_naves` VALUES (1,'Calandria',300),(2,'Colibrí',120),(3,'Zorzal',100),(4,'Carancho',110),(5,'Aguilucho',60),(6,'Canario',80),(7,'Águila',300),(8,'Condor',350),(9,'Halcón',200),(10,'Guanaco',100);
/*!40000 ALTER TABLE `modelos_naves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `naves`
--

DROP TABLE IF EXISTS `naves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `naves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matricula` varchar(8) DEFAULT NULL,
  `modelo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modelo` (`modelo`),
  CONSTRAINT `naves_ibfk_1` FOREIGN KEY (`modelo`) REFERENCES `modelos_naves` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `naves`
--

LOCK TABLES `naves` WRITE;
/*!40000 ALTER TABLE `naves` DISABLE KEYS */;
INSERT INTO `naves` VALUES (1,'O1',1),(2,'O2',1),(3,'O3',2),(4,'O4',2),(5,'O5',2),(6,'O6',1),(7,'O7',1),(8,'O8',2),(9,'O9',2),(10,'BA1',3),(11,'BA2',3),(12,'BA3',3),(13,'BA4',4),(14,'BA5',4),(15,'BA6',4),(16,'BA7',4),(17,'BA8',5),(18,'BA9',5),(19,'BA10',5),(20,'BA11',5),(21,'BA12',5),(22,'BA13',6),(23,'BA14',6),(24,'BA15',6),(25,'BA16',6),(26,'BA17',6),(27,'AA1',7),(28,'AA2',8),(29,'AA3',9),(30,'AA4',10),(31,'AA5',7),(32,'AA6',8),(33,'AA7',9),(34,'AA8',10),(35,'AA9',7),(36,'AA10',8),(37,'AA11',9),(38,'AA12',10),(39,'AA13',7),(40,'AA14',8),(41,'AA15',9),(42,'AA16',10),(43,'AA17',7),(44,'AA18',8),(45,'AA19',9);
/*!40000 ALTER TABLE `naves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reservas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_viajes` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `cod_reserva` varchar(8) DEFAULT NULL,
  `estacion_origen` int(11) DEFAULT NULL,
  `estacion_destino` int(11) DEFAULT NULL,
  `idCapacidadCabina` int(11) DEFAULT NULL,
  `pago` tinyint(1) DEFAULT NULL,
  `lista_espera` tinyint(1) DEFAULT NULL,
  `menu_elegido` int(11) DEFAULT NULL,
  `check_in` tinyint(1) DEFAULT NULL,
  `codigo_qr` varchar(70) DEFAULT NULL,
  `codigo_embarque` varchar(6) DEFAULT NULL,
  `codigo_vuelo` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cod_vuelo` (`id_viajes`),
  KEY `id_usuario` (`id_usuario`),
  KEY `estacion_origen` (`estacion_origen`),
  KEY `estacion_destino` (`estacion_destino`),
  KEY `menu_elegido` (`menu_elegido`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_viajes`) REFERENCES `viajes` (`id`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `credenciales` (`id`),
  CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`estacion_origen`) REFERENCES `estaciones` (`id`),
  CONSTRAINT `reservas_ibfk_4` FOREIGN KEY (`estacion_destino`) REFERENCES `estaciones` (`id`),
  CONSTRAINT `reservas_ibfk_5` FOREIGN KEY (`menu_elegido`) REFERENCES `menu` (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` VALUES (1,1,2,1,'s',1,1,NULL,0,0,NULL,0,NULL,NULL,NULL),(17,1,2,2,NULL,1,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(42,11,3,NULL,'CR99',3,5,2,1,NULL,NULL,NULL,NULL,NULL,NULL),(90,20,2,1,'h',8,9,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(94,8,1,1,'a',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(113,5,1,1,'i',1,1,6,1,NULL,NULL,NULL,NULL,NULL,NULL),(140,4,1,1,'n',2,2,1,1,0,NULL,NULL,NULL,NULL,NULL),(147,2,1,1,'p',2,2,2,1,NULL,NULL,1,NULL,NULL,NULL),(148,10,1,1,'gg',1,4,12,1,0,NULL,NULL,NULL,NULL,NULL),(149,83,2,1,'CR515',5,10,14,1,NULL,2,NULL,'codigo-CR515.png','KZ0C',NULL),(150,89,1,1,'q',1,1,23,NULL,1,NULL,NULL,NULL,NULL,NULL),(183,5,1,1,NULL,1,1,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(184,9,2,1,NULL,1,1,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(185,6,4,1,NULL,1,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(186,3,1,1,'dDax85gb',NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,NULL),(187,9,1,1,'1SqJ4zRW',1,1,4,NULL,0,NULL,NULL,NULL,NULL,NULL),(192,3,1,1,'ouKl19WN',1,1,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(193,3,1,1,'b3EIuFcI',1,1,3,0,NULL,NULL,NULL,NULL,NULL,NULL),(194,3,1,1,'UkmoUxZZ',1,1,3,0,0,NULL,NULL,NULL,NULL,NULL),(196,3,1,1,'DEZblEzV',1,1,1,0,0,NULL,0,NULL,NULL,NULL),(197,3,25,1,'E2VFri8h',1,1,3,0,1,NULL,0,NULL,NULL,NULL),(198,27,25,1,'knDfQ4wj',9,3,22,0,0,NULL,0,NULL,NULL,NULL),(199,27,25,1,'zSXNs8IF',9,3,22,0,0,NULL,0,NULL,NULL,NULL),(200,27,100,1,'EulzkK1Q',9,3,22,0,0,NULL,0,NULL,NULL,NULL),(201,27,1,1,'g1rby1ff',9,3,22,0,0,NULL,0,NULL,NULL,NULL),(202,90,2,1,'vDQ7u2ZO',1,6,11,0,0,NULL,0,NULL,NULL,'gg'),(203,93,8,1,'V2NLpyTT',4,5,11,0,0,NULL,0,NULL,NULL,'gg'),(244,95,2,1,'69m8EaPN',6,1,11,0,0,NULL,0,NULL,NULL,'ggv'),(251,97,8,1,'9MCSVJOd',4,3,11,0,0,NULL,0,NULL,NULL,'ggv'),(317,90,1,1,'4Q6fUTsY',1,5,11,0,1,NULL,0,NULL,NULL,'gg'),(318,95,1,1,'mSOvF2Y6',6,3,11,0,1,NULL,0,NULL,NULL,'ggv');
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador'),(2,'Usuario');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarjetas_credito`
--

DROP TABLE IF EXISTS `tarjetas_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tarjetas_credito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_tarjeta` varchar(30) DEFAULT NULL,
  `validacion_tarjeta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarjetas_credito`
--

LOCK TABLES `tarjetas_credito` WRITE;
/*!40000 ALTER TABLE `tarjetas_credito` DISABLE KEYS */;
INSERT INTO `tarjetas_credito` VALUES (1,'American Express','/^([34|37]{2})([0-9]{13})$/'),(2,'Visa','/^([4]{1})([0-9]{12,15})$/'),(3,'MasterCard','/^([51|52|53|54|55]{2})([0-9]{14})$/');
/*!40000 ALTER TABLE `tarjetas_credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_viajes`
--

DROP TABLE IF EXISTS `tipo_viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipo_viajes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_viaje` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_viajes`
--

LOCK TABLES `tipo_viajes` WRITE;
/*!40000 ALTER TABLE `tipo_viajes` DISABLE KEYS */;
INSERT INTO `tipo_viajes` VALUES (1,'Tour'),(2,'Suborbitales'),(3,'Entre destinos');
/*!40000 ALTER TABLE `tipo_viajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnos`
--

DROP TABLE IF EXISTS `turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `turnos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `centro_medico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `centro_medico` (`centro_medico`),
  CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `turnos_ibfk_2` FOREIGN KEY (`centro_medico`) REFERENCES `centros_medicos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnos`
--

LOCK TABLES `turnos` WRITE;
/*!40000 ALTER TABLE `turnos` DISABLE KEYS */;
INSERT INTO `turnos` VALUES (13,'2019-11-21',23,2);
/*!40000 ALTER TABLE `turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ubicacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_vuelo` varchar(7) DEFAULT NULL,
  `codigo_reserva` varchar(7) DEFAULT NULL,
  `asiento` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=376 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicacion`
--

LOCK TABLES `ubicacion` WRITE;
/*!40000 ALTER TABLE `ubicacion` DISABLE KEYS */;
INSERT INTO `ubicacion` VALUES (113,'ED512-I','O51U2Z9','c2f1'),(114,'ED512-I','O51U2Z9','c5f1'),(115,'ED512-I','O51U2Z9','c6f1'),(116,'ED512-I','O51U2Z9','c3f1'),(119,'ED512-I','O51U2Z9','c6f3'),(120,'ED512-I','O51U2Z9','c3f4'),(121,'ED512-I','O51U2Z9','c5f5'),(122,'ED512-I','O51U2Z9','c2f21'),(123,'ED512-I','O51U2Z9','c3f21'),(147,'ED512-I','O51U2Z9','c10f1'),(148,'ED512-I','O51U2Z9','c11f1'),(149,'ED512-I','O51U2Z9','c12f1'),(150,'ED512-I','O51U2Z9','c13f1'),(151,NULL,'79MN5','c3f1'),(170,NULL,'SSS','c2f13'),(171,NULL,'SSS','c3f13'),(172,NULL,'SSS','c4f13'),(173,NULL,'SSS','c5f13'),(174,NULL,'SSS','c2f14'),(175,NULL,'SSS','c3f14'),(176,NULL,'SSS','c4f14'),(177,NULL,'SSS','c5f14'),(178,NULL,'CR15','c4f13'),(179,NULL,'CR15','c3f14'),(180,NULL,'CR15','c4f14'),(181,NULL,'CR15','c2f11'),(182,NULL,'CR15','c3f11'),(183,NULL,'CR15','c2f12'),(184,NULL,'CR15','c4f2'),(185,NULL,'CR15','c3f3'),(186,NULL,'CR15','c5f3'),(187,NULL,'CR15','c4f2'),(188,NULL,'CR15','c3f3'),(189,NULL,'CR15','c5f3'),(190,NULL,'CR15','c3f1'),(191,NULL,'CR15','c4f1'),(192,NULL,'CR15','c5f1'),(193,NULL,'CR15','c1f1'),(194,NULL,'CR15','c1f2'),(195,NULL,'CR15','c1f3'),(196,NULL,'CR15','c3f4'),(197,NULL,'CR15','c2f5'),(198,NULL,'CR15','c4f5'),(199,NULL,'CR15','c5f8'),(200,NULL,'CR15','c4f9'),(201,NULL,'CR15','c5f9'),(282,NULL,'CR515','c1f1'),(283,NULL,'CR515','c2f1'),(284,NULL,'CR515','c3f1'),(285,NULL,'CR515','c4f1'),(286,NULL,'CR515','c5f1'),(287,NULL,'CR515','c6f1'),(288,NULL,'CR515','c7f1'),(289,NULL,'CR515','c8f1'),(290,NULL,'CR515','c9f1'),(291,NULL,'CR515','c10f1'),(292,NULL,'CR515','c1f2'),(293,NULL,'CR515','c2f2'),(294,NULL,'CR515','c5f2'),(295,NULL,'CR515','c6f2'),(296,NULL,'CR515','c5f3'),(297,NULL,'CR515','c6f3'),(298,NULL,'CR515','c7f2'),(299,NULL,'CR515','c8f2'),(300,NULL,'CR515','c7f3'),(301,NULL,'CR515','c8f3'),(302,NULL,'CR515','c3f2'),(303,NULL,'CR515','c10f2'),(304,NULL,'CR515','c4f3'),(305,NULL,'CR515','c9f3'),(306,NULL,'CR515','c4f4'),(307,NULL,'CR515','c5f4'),(308,NULL,'CR515','c6f4'),(309,NULL,'CR515','c7f4'),(310,NULL,'CR515','c8f4'),(311,NULL,'CR515','c9f4'),(312,NULL,'CR515','c10f4'),(313,NULL,'CR515','c8f5'),(314,NULL,'CR515','c6f9'),(315,NULL,'CR515','c4f10'),(316,NULL,'CR515','c5f10'),(317,NULL,'CR515','c6f10'),(318,NULL,'CR515','c7f7'),(319,NULL,'CR515','c8f7'),(320,NULL,'CR515','c9f7'),(321,NULL,'CR515','c10f7'),(322,NULL,'CR515','c1f8'),(323,NULL,'CR515','c4f5'),(324,NULL,'CR515','c2f4'),(325,NULL,'CR515','c8f9'),(326,NULL,'CR515','c10f10'),(327,NULL,'CR515','c6f11'),(328,NULL,'CR515','c7f16'),(329,NULL,'CR515','c9f6'),(330,NULL,'CR515','c3f20'),(331,NULL,'CR515','c8f20'),(332,NULL,'CR515','c4f17'),(333,NULL,'CR515','c6f16'),(334,NULL,'CR515','c6f18'),(335,NULL,'CR515','c6f19'),(336,NULL,'CR515','c4f6'),(337,NULL,'CR515','c10f15'),(338,NULL,'CR515','c3f14'),(339,NULL,'CR515','c7f14'),(340,NULL,'CR515','c7f14'),(341,NULL,'CR515','c8f17'),(342,NULL,'CR515','c3f7'),(343,NULL,'CR515','c7f18'),(344,NULL,'CR515','c2f18'),(345,NULL,'CR515','c3f17'),(346,NULL,'CR515','c3f15'),(347,NULL,'CR515','c3f15'),(348,NULL,'CR515','c10f18'),(349,NULL,'CR515','c10f19'),(350,NULL,'CR515','c3f11'),(351,NULL,'CR515','c4f12'),(352,NULL,'CR515','c5f14'),(353,NULL,'CR515','c5f15'),(354,NULL,'CR515','c8f16'),(355,NULL,'CR515','c9f17'),(356,NULL,'CR515','c5f8'),(357,NULL,'CR515','c4f9'),(358,NULL,'CR515','c5f20'),(359,NULL,'CR515','c6f20'),(360,NULL,'CR515','c9f19'),(361,NULL,'CR515','c10f20'),(362,NULL,'CR515','c10f13'),(363,NULL,'CR515','c10f14'),(364,NULL,'CR515','c8f11'),(365,NULL,'CR515','c9f11'),(366,NULL,'CR515','c6f14'),(367,NULL,'CR515','c6f15'),(368,NULL,'CR515','c5f13'),(369,NULL,'CR515','c6f13'),(370,NULL,'CR515','c4f19'),(371,NULL,'CR515','c4f20'),(372,NULL,'CR515','c1f14'),(373,NULL,'CR515','c2f14'),(374,NULL,'CR515','c8f18'),(375,NULL,'CR515','c7f19');
/*!40000 ALTER TABLE `ubicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(15) DEFAULT NULL,
  `apellido` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `nivel_vuelo` int(11) DEFAULT NULL,
  `se_chequeo` tinyint(4) DEFAULT NULL,
  `confirmacion_mail` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Tomas','Seijas','tomas.seijas10@gmail.com',3,1,1),(2,'Sebastian','Dominikow','sebidomi@hotmail.com',NULL,0,1),(23,'Claudio','Vazquez','galloclaudio69@gmail.com',0,1,NULL),(24,'fafafa','zar','wewewe@dffd.com',3,1,NULL),(25,'popopo','son','xpoqwmc@wewe.dff',3,1,NULL),(26,'frfrfr','bg','rtrtg@rtrt.fgfg',1,1,NULL),(27,'pedro','marin','pmarin@gmail.com',NULL,NULL,0),(28,'Juan','Lopez','jlopez@gmail.com',NULL,NULL,0),(29,'carlos','puentes','cpuentes@gmail.com',NULL,NULL,0),(30,'andres','Gutierrez','agutierrez@gmail.com',NULL,NULL,0),(31,'aaa','aaaaaa','peroti24@salo.com',NULL,NULL,0),(32,'aaa','aaaaaa','peroti23@salo.com',NULL,NULL,0),(33,'aaa','aaaaaa','peroti22@salo.com',NULL,NULL,0),(34,'aaa','aaaaaa','peroti19@salo.com',NULL,NULL,0),(35,'aaa','aaaaaa','peroti20@salo.com',NULL,NULL,0),(36,'aaa','aaaaaa','peroti21@salo.com',NULL,NULL,0),(37,'aaa','aaaaaa','peroti18@salo.com',NULL,NULL,0),(38,'aaa','aaaaaa','peroti17@salo.com',NULL,NULL,0),(39,'aaa','aaaaaa','peroti16@salo.com',NULL,NULL,0),(40,'aaa','aaaaaa','peroti13@salo.com',NULL,NULL,0),(41,'aaa','aaaaaa','peroti14@salo.com',NULL,NULL,0),(42,'aaa','aaaaaa','peroti15@salo.com',NULL,NULL,0),(43,'aaa','aaaaaa','peroti12@salo.com',NULL,NULL,0),(44,'aaa','aaaaaa','peroti11@salo.com',NULL,NULL,0),(45,'mmmmm','aaaaaa','peroti10@salo.com',NULL,NULL,0),(46,'aaa','aaaaaa','peroti7@salo.com',NULL,NULL,0),(47,'aaa','aaaaaa','peroti8@salo.com',NULL,NULL,0),(48,'aaa','aaaaaa','peroti9@salo.com',NULL,NULL,0),(49,'aaa','aaaaaa','peroti1@salo.com',NULL,NULL,0),(50,'aaa','aaaaaa','peroti2@salo.com',NULL,NULL,0),(51,'aaa','aaaaaa','peroti3@salo.com',NULL,NULL,0),(52,'aaa','aaaaaa','peroti6@salo.com',NULL,NULL,0),(53,'aaa','yyyt','peroti5@salo.com',NULL,NULL,0),(54,'aaa','yyyt','peroti4@salo.com',NULL,NULL,0),(55,'','','',NULL,NULL,0);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viajes`
--

DROP TABLE IF EXISTS `viajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `viajes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_hora` datetime DEFAULT NULL,
  `tipo_viaje` int(11) DEFAULT NULL,
  `duracion` varchar(15) DEFAULT NULL,
  `nave` int(11) DEFAULT NULL,
  `circuito_id` int(11) DEFAULT NULL,
  `codigo_vuelo` varchar(7) DEFAULT NULL,
  `origen` int(11) DEFAULT NULL,
  `destino` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_viaje` (`tipo_viaje`),
  KEY `circuitos` (`circuito_id`),
  KEY `origen` (`origen`),
  KEY `destino` (`destino`),
  CONSTRAINT `viajes_ibfk_1` FOREIGN KEY (`tipo_viaje`) REFERENCES `tipo_viajes` (`id`),
  CONSTRAINT `viajes_ibfk_2` FOREIGN KEY (`circuito_id`) REFERENCES `circuitos` (`id`),
  CONSTRAINT `viajes_ibfk_3` FOREIGN KEY (`origen`) REFERENCES `estaciones` (`id`),
  CONSTRAINT `viajes_ibfk_4` FOREIGN KEY (`destino`) REFERENCES `estaciones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viajes`
--

LOCK TABLES `viajes` WRITE;
/*!40000 ALTER TABLE `viajes` DISABLE KEYS */;
INSERT INTO `viajes` VALUES (1,'2019-12-24 23:00:00',1,'35 dias',30,3,'TR236',1,1),(2,'2019-11-24 01:00:00',2,'8 horas',1,4,'OR155',2,2),(3,'2019-12-07 09:00:00',2,'8 horas',6,3,'OR172',1,1),(4,'2019-11-24 01:00:00',2,'8 horas',2,4,'OR784',2,2),(5,'2019-12-07 13:00:00',2,'8 horas',3,3,'OR634',1,1),(6,'2019-12-07 16:00:00',2,'8 horas',7,3,'OR811',1,1),(7,'2019-12-07 13:00:00',2,'8 horas',4,4,'OR235',2,2),(8,'2019-12-07 07:00:00',2,'8 horas',5,3,'OR641',1,1),(9,'2019-12-07 11:00:00',2,'8 horas',8,3,'OR369',1,1),(10,'2019-11-22 03:29:00',3,'4 horas',22,1,'ED612-I',1,3),(11,'2019-11-20 20:00:00',3,'1 horas',22,1,'ED612-I',3,4),(12,'2019-11-20 21:00:00',3,'16 horas',22,1,'ED612-I',4,5),(13,'2019-11-21 13:00:00',3,'26 horas',22,1,'ED612-I',5,6),(14,'2019-11-21 00:53:00',3,'26 horas',12,5,'ED389-V',6,5),(15,'2019-11-20 12:00:00',3,'16 horas',12,5,'ED389-V',5,4),(16,'2019-11-21 04:00:00',3,'1 horas',12,5,'ED389-V',4,3),(17,'2019-11-21 05:00:00',3,'4 horas',12,5,'ED389-V',3,1),(18,'2019-11-19 16:00:00',3,'4 horas',32,2,'ED951-I',1,3),(19,'2019-11-19 20:00:00',3,'14 horas',32,2,'ED951-I',3,5),(20,'2019-12-20 10:00:00',3,'48 horas',32,2,'ED951-I',5,7),(21,'2019-11-22 10:00:00',3,'50 horas',32,2,'ED951-I',7,8),(22,'2019-11-24 12:00:00',3,'51 horas',32,2,'ED951-I',8,9),(23,'2019-11-26 15:00:00',3,'70 horas',32,2,'ED951-I',9,10),(24,'2019-11-29 13:00:00',3,'77 horas',32,2,'ED951-I',10,11),(25,'2019-11-19 10:00:00',3,'77 horas',33,6,'ED803-V',11,10),(26,'2019-11-22 15:00:00',3,'70 horas',33,6,'ED803-V',10,9),(27,'2019-11-25 13:00:00',3,'51 horas',33,6,'ED803-V',9,8),(28,'2019-11-27 16:00:00',3,'50 horas',33,6,'ED803-V',8,7),(29,'2019-11-29 18:00:00',3,'48 horas',33,6,'ED803-V',7,5),(30,'2019-12-01 18:00:00',3,'14 horas',33,6,'ED803-V',5,3),(31,'2019-12-02 08:00:00',3,'4 horas',33,6,'ED803-V',3,1),(32,NULL,NULL,NULL,NULL,NULL,'523',NULL,NULL),(76,'2019-11-21 22:00:00',NULL,NULL,NULL,NULL,'CERATTI',NULL,NULL),(77,'2019-11-22 03:00:00',NULL,NULL,NULL,NULL,'CERATTI',NULL,NULL),(78,'2019-11-22 08:00:00',NULL,NULL,NULL,NULL,'CERATTI',NULL,NULL),(79,'2019-11-20 10:00:00',3,'medio dia',10,5,'J8',5,3),(80,'2019-11-20 10:00:00',3,'medio dia',11,6,'J9',5,3),(81,'2019-12-04 16:00:00',3,'4 horas',39,2,'ED504-I',1,3),(82,'2019-12-04 20:00:00',3,'14 horas',39,2,'ED504-I',3,5),(83,'2019-11-22 01:20:00',3,'48 horas',39,2,'ED504-I',5,7),(84,'2019-12-07 10:00:00',3,'50 horas',39,2,'ED504-I',7,8),(85,'2019-12-09 12:00:00',3,'51 horas',39,2,'ED504-I',8,9),(86,'2019-12-11 15:00:00',3,'70 horas',39,2,'ED504-I',9,10),(87,'2019-12-14 13:00:00',3,'77 horas',39,2,'ED504-I',10,11),(88,'2019-12-01 10:30:00',1,'35 dias',30,3,'TR486',1,1),(89,'2019-12-01 16:00:00',1,'35 dias',30,3,'TR281',1,1),(90,'2019-11-30 10:00:00',3,NULL,20,1,'gg',1,3),(92,'2019-11-30 14:00:00',3,NULL,20,1,'gg',3,4),(93,'2019-11-30 15:00:00',3,NULL,20,1,'gg',4,5),(94,'2019-12-01 07:00:00',3,NULL,20,1,'gg',5,6),(95,'2019-11-30 10:00:00',3,NULL,21,5,'ggv',6,5),(96,'2019-12-01 02:00:00',3,NULL,21,5,'ggv',5,4),(97,'2019-12-01 03:00:00',3,NULL,21,5,'ggv',4,3),(98,'2019-12-01 07:00:00',3,NULL,21,5,'ggv',3,1);
/*!40000 ALTER TABLE `viajes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-24 12:33:50

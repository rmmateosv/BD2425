drop database  if exists cooperativa;
create database cooperativa;
use cooperativa;

--
-- Table structure for table `materiales`
--
DROP TABLE IF EXISTS `materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materiales` (
  `id` varchar(10) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiales`
--

LOCK TABLES `materiales` WRITE;
/*!40000 ALTER TABLE `materiales` DISABLE KEYS */;
INSERT INTO `materiales` VALUES ('M1','Fertilizante',5.1),('M2','Abono',3.9),('M3','Semilla',2),('M4','Planta Naranjo',10),('M5','Planta Fresa',0.2),('M6','Planta Melocotón',8);
/*!40000 ALTER TABLE `materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--


--
-- Table structure for table `productos`
--
DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `id` varchar(10) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `fechai` date NOT NULL,
  `fechaf` date NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES ('F1','Fresas Oro','2015-01-01','2015-06-30',1),('F2','Fresas Primera','2015-01-01','2015-06-30',0.9),('F3','Fresas Segunda','2015-01-01','2015-06-30',0.4),('N1','Naranjas Primera','2014-10-01','2015-07-15',0.6),('N2','Naranjas Segunda','2014-10-01','2015-07-15',0.3),('N3','Naranjas Destrío','2014-10-01','2015-07-15',0.05);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socios` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `saldo` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
INSERT INTO `socios` VALUES (1,'Silva, Hugo',915.9),(2,'Casas, Mario',2575.9),(3,'Suárez, Blanca',-10.2),(4,'Cruz, Penélope',1500),(5,'Machi, Carmen',0);
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--
DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `socio` int(11) NOT NULL,
  `material` varchar(10) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk3` (`socio`),
  KEY `fk4` (`material`),
  KEY `ifecha` (`fecha`),
  CONSTRAINT `fk3` FOREIGN KEY (`socio`) REFERENCES `socios` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk4` FOREIGN KEY (`material`) REFERENCES `materiales` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (3,'2015-06-15',1,'M1',2,10.2),(4,'2015-06-15',1,'M2',1,3.9),(5,'2015-06-15',2,'M2',1,3.9),(6,'2015-06-15',3,'M1',2,10.2),(7,'2015-06-15',2,'M1',2,10.2);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entregas`
--

DROP TABLE IF EXISTS `entregas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entregas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `socio` int(11) NOT NULL,
  `producto` varchar(10) NOT NULL,
  `kilos` int(11) NOT NULL,
  `bultos` int(11) NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1` (`socio`),
  KEY `fk2` (`producto`),
  CONSTRAINT `fk1` FOREIGN KEY (`socio`) REFERENCES `socios` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2` FOREIGN KEY (`producto`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entregas`
--

LOCK TABLES `entregas` WRITE;
/*!40000 ALTER TABLE `entregas` DISABLE KEYS */;
INSERT INTO `entregas` VALUES (5,'2015-06-15',1,'F2',100,10,90),(6,'2015-06-15',1,'F2',200,20,180),(7,'2015-06-11',2,'F2',100,10,90),(8,'2015-06-10',1,'N1',1000,10,600),(9,'2015-06-12',2,'F1',2500,15,2500),(10,'2015-06-14',1,'N1',100,1,60),(11,'2015-06-14',4,'N2',2500,20,750),(12,'2015-06-09',4,'N2',2500,20,750);
/*!40000 ALTER TABLE `entregas` ENABLE KEYS */;
UNLOCK TABLES;




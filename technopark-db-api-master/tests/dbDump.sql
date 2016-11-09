-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: forum
-- ------------------------------------------------------
-- Server version	5.5.47-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `forum`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `forum` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `forum`;

--
-- Table structure for table `counters`
--

DROP TABLE IF EXISTS `counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counters` (
  `counterName` varchar(255) NOT NULL,
  `count` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counters`
--

LOCK TABLES `counters` WRITE;
/*!40000 ALTER TABLE `counters` DISABLE KEYS */;
INSERT INTO `counters` VALUES ('forums',10),('users',10),('threads',10),('posts',10);
/*!40000 ALTER TABLE `counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followers` (
  `followerID` int(11) NOT NULL,
  `followeeID` int(11) NOT NULL,
  UNIQUE KEY `uq_follower_followee` (`followerID`,`followeeID`),
  KEY `fk_followee_user` (`followeeID`),
  CONSTRAINT `fk_follower_user` FOREIGN KEY (`followerID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `fk_followee_user` FOREIGN KEY (`followeeID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` VALUES (1,1),(4,1),(7,2),(7,4),(7,7);
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forums` (
  `forumID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `userID` int(11) NOT NULL,
  PRIMARY KEY (`forumID`),
  UNIQUE KEY `short_name` (`short_name`),
  KEY `fk_forum_user` (`userID`),
  CONSTRAINT `fk_forum_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forums`
--

LOCK TABLES `forums` WRITE;
/*!40000 ALTER TABLE `forums` DISABLE KEYS */;
INSERT INTO `forums` VALUES (1,'a4','w02oe',9),(2,'gr78t6 akz1 9plz extzgq','5g',9),(3,'esardwb36','cy3z2',2),(4,'x5qwm6s ouevtq4','0n9kr2zhqe',6),(5,'y5koh80u 97g5fwzxl gbzldup','2w6ian7',4),(6,'fvachl2d48 s9 g4p','cupkna',8),(7,'aub7 2fk 8gtql','vyeco',8),(8,'5vyb','q9',7),(9,'haeb4ro65 gl2','qkac0zvx',9),(10,'17pluc quons gf9cv0eg','syf4o3z',10);
/*!40000 ALTER TABLE `forums` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER forumAddTrigger AFTER INSERT ON forums
FOR EACH ROW
  BEGIN
    UPDATE counters
    SET counters.count = counters.count + 1
    WHERE counters.counterName = 'forums';
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `postID` int(11) NOT NULL AUTO_INCREMENT,
  `creationDate` datetime NOT NULL,
  `threadID` int(11) NOT NULL,
  `message` mediumtext NOT NULL,
  `userID` int(11) NOT NULL,
  `forumID` int(11) NOT NULL,
  `parentPostID` int(11) DEFAULT NULL,
  `path` varchar(1024) NOT NULL DEFAULT '',
  `isApproved` tinyint(1) DEFAULT '0',
  `isHighlighted` tinyint(1) DEFAULT '0',
  `isEdited` tinyint(1) DEFAULT '0',
  `isSpam` tinyint(1) DEFAULT '0',
  `isDeleted` tinyint(1) DEFAULT '0',
  `likes` int(11) NOT NULL DEFAULT '0',
  `dislikes` int(11) NOT NULL DEFAULT '0',
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`postID`),
  KEY `fk_post_parentPost` (`parentPostID`),
  KEY `fk_post_thread` (`threadID`),
  KEY `fk_post_user` (`userID`),
  KEY `fk_post_forum` (`forumID`),
  CONSTRAINT `fk_post_parentPost` FOREIGN KEY (`parentPostID`) REFERENCES `posts` (`postID`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_thread` FOREIGN KEY (`threadID`) REFERENCES `threads` (`threadID`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_forum` FOREIGN KEY (`forumID`) REFERENCES `forums` (`forumID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'2013-11-07 01:28:01',7,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',3,5,NULL,'/00000001',0,1,1,1,1,0,0,0),(2,'2013-01-12 08:53:14',5,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',8,10,NULL,'/00000002',1,0,0,1,0,0,0,0),(3,'2013-07-22 21:15:54',4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',1,3,NULL,'/00000003',0,0,0,0,0,0,0,0),(4,'2013-03-17 12:13:04',3,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',6,5,NULL,'/00000004',1,0,1,1,0,0,0,0),(5,'2013-10-06 10:02:57',5,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',1,10,NULL,'/00000005',1,1,1,0,0,0,0,0),(6,'2013-07-21 19:25:54',4,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',6,3,NULL,'/00000006',1,0,1,0,0,0,0,0),(7,'2013-04-02 00:52:33',10,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',4,5,NULL,'/00000007',0,0,0,0,1,0,0,0),(8,'2013-11-02 02:01:25',7,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',3,5,NULL,'/00000008',0,0,0,1,1,0,0,0),(9,'2013-07-03 09:13:09',10,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',9,5,NULL,'/00000009',0,0,1,0,1,0,0,0),(10,'2013-07-10 03:54:17',5,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a lorem a leo porttitor tincidunt eget et urna. Aenean id lacinia dolor. Sed consequat ipsum at orci porta, sed condimentum dui elementum. Curabitur magna purus, sagittis in convallis ultrices, dignissim pharetra ipsum. In molestie, arcu id convallis blandit, felis metus suscipit justo, ut iaculis metus leo viverra felis. Donec a varius dolor. Cras tempor, nisl in dapibus cursus, risus ligula ultricies nisi, a sagittis justo lorem et odio. Mauris eu scelerisque tellus. Duis luctus enim vel porttitor convallis. Phasellus pretium mi vitae ullamcorper pretium. Vivamus sollicitudin, risus a volutpat condimentum',10,10,NULL,'/00000010',1,1,1,0,1,0,0,0);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER postAddTrigger BEFORE INSERT ON posts
FOR EACH ROW
  BEGIN
    DECLARE parentPath VARCHAR(255);

    UPDATE counters
    SET counters.count = counters.count + 1
    WHERE counters.counterName = 'posts';

    UPDATE threads
    SET threads.postCount = threads.postCount + 1
    WHERE threads.threadID = new.threadID;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER postDeleteTrigger AFTER UPDATE ON posts
FOR EACH ROW
  BEGIN
    IF NEW.isDeleted = TRUE AND OLD.isDeleted = FALSE
    THEN
      UPDATE threads SET threads.postCount = threads.postCount - 1
      WHERE threads.threadID = OLD.threadID;
    END IF;

    IF NEW.isDeleted = FALSE AND OLD.isDeleted = TRUE
    THEN
      UPDATE threads SET threads.postCount = threads.postCount + 1
      WHERE threads.threadID = OLD.threadID;
    END IF;

  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `userID` int(11) NOT NULL,
  `threadID` int(11) NOT NULL,
  UNIQUE KEY `uq_subscription` (`userID`,`threadID`),
  KEY `fk_subscription_thread` (`threadID`),
  CONSTRAINT `fk_subscription_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `fk_subscription_thread` FOREIGN KEY (`threadID`) REFERENCES `threads` (`threadID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (7,2),(7,4),(2,6),(5,6),(5,7);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `threads`
--

DROP TABLE IF EXISTS `threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `threads` (
  `threadID` int(11) NOT NULL AUTO_INCREMENT,
  `forumID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `isClosed` tinyint(1) NOT NULL DEFAULT '0',
  `creationDate` datetime NOT NULL,
  `message` mediumtext NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `likes` int(11) NOT NULL DEFAULT '0',
  `dislikes` int(11) NOT NULL DEFAULT '0',
  `points` int(11) NOT NULL DEFAULT '0',
  `postCount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`threadID`),
  KEY `fk_thread_forum` (`forumID`),
  KEY `fk_thread_user` (`userID`),
  CONSTRAINT `fk_thread_forum` FOREIGN KEY (`forumID`) REFERENCES `forums` (`forumID`) ON DELETE CASCADE,
  CONSTRAINT `fk_thread_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `threads`
--

LOCK TABLES `threads` WRITE;
/*!40000 ALTER TABLE `threads` DISABLE KEYS */;
INSERT INTO `threads` VALUES (1,6,10,'mze',0,'2013-08-02 14:12:32','rnd enl dvrf402m o6a8zrdn 6eg dl9vgkucx4 lc6g 3ivubr4 cuiash1yt 7xa2e eudfz6rqi8 y8bk 492 ok9 l1 gx wcvxztmr2s l5arxgbsy7 qfs5 mab3ex7of y5oemfp2 ztgk64 wofeidcq wv4ik 9yhd1zc72 3otrbysvd 25x','w2',0,0,0,0,0),(2,7,7,'8uw1nkoci g6 nhm nw9p',0,'2013-09-08 21:18:37','fq g1se 3uag9q8yn 014f8i w1ldp7r 1w wsabeu tnqmb nh7lk ge391tg 1tih0mcz5l 5y4 52ykeimnb d3ie09go8 02z78hx vmwt9ul x927t8v0 d716har3 4m 64wangr7ch hwvzrbn84g q7n 0i51tgov 8g4ldo 17n fl1urz2s ls4a xed6aco0b sc4l','5a',0,0,0,0,0),(3,5,10,'v8fay5ho iapw0x',0,'2013-11-15 01:26:16','3qog5 ir pqbvt 5t4x2vg 9dzv6wg qf4d9lpbe7 xftg mvnp rlxggn zv1ergflyw p48 hi7dggpn3x nq6 bu5 ig n5t8p71oul xw0ed2a hxb89u6g3k 87lzi e3iy1 exk7um yfso8 aowmpl74 quvwndse9 7i 6k3z t0rlizg pv9i1s o2l','28qhyxuta',0,0,0,0,1),(4,3,9,'zuyenadmgc cs2vn',0,'2013-07-18 23:50:58','56tpif kvz8hgxag mk6x3iqv or hy8r03not 7u9z3 k3s i5lbzxyu6h ahge bh0 nm0sy xi0k7w h5 0ap1nx6uz qehr08s pnkh0c m8xqvpz r9ubof6 gw4zp8cy hv xd 7532db','b6f5n9g7',0,0,0,0,2),(5,10,9,'46b blx8kanut1',0,'2013-04-26 17:21:52','agtb b051sve s5m3vzg zyhu idfgwzbeo z0 1z769yg8h4 nph z7lnmdvgk 1h ptwrke wgxq0dg ptfg5elxiz 1spqwzd6u2 3awc ar2pos5g mkusz3 h0c4 xphdaoc vts71k4a5','mne89f',0,0,0,0,3),(6,10,10,'b8k ml o1fxi',0,'2013-04-23 02:51:08','7vcggsnal2 mengugd 17 h0mles4c sx 86rgq 9vs1tim modf78scqr fxoec h7l9k w83 ylda9 1h5kl fpvk 1ltgsq svxm hpow2zs mdh9rb3cx1 vmtu8ag qkp z5ox18','g5m2rdk',1,0,0,0,0),(7,5,9,'81s2lf4zqe c98eg5blz',0,'2013-04-16 22:07:17','u1 rty o2xwz5 b3v ifeg2w6bls iozqp3 pyrm 5gq9b1une uzyn106lt5 rb2osgl34 7wd s9at 1x3usry spg nq0ochz 2n3eozv07 rw7vxgyc hdtwmb d2m89ph hvgztqp pfguv25kzw h3 p048ncu p4edyn1a7t y9zrdvx1w 0a71gq4fp qshxm','b9tew1p',0,0,0,0,2),(8,9,3,'9cp 2shnt091i vg8zt9y0a',0,'2013-01-05 23:24:52','so3b7irmx 45qdx10h rony 45 urcwn wm7 ypghfclod9 31gp5 6wftq2c ae b2 m0g axrk 1sivqxl umsd ze6im2 t2xzisr 6zhx4ves1 hwqa7d5 q9u0fx326z 1v9buylwf yh dpu6l9eg itn y9175iwazo','yifora',0,0,0,0,0),(9,10,4,'bl2o8y a9p8lmvst0 f7wdn',1,'2013-09-25 03:56:36','eakqpb lucgert y6 o86heyw0 vzkei xbaerhv 31gs4pxdy7 2axhzd soc5t8iwp iwlrnq 852seh 37 3ce61l g08cbifva 3fhpiyoq a32u4cely8 hzic4e8 qtg grnaketxf4 e5mt1u06x notp3h6 7k18 4m7k9 1gsbulzoa f1d74gpl 2mqi1l9','gyiek61',1,0,0,0,0),(10,5,4,'ps wgk8937i ghw5s1 n1qe',0,'2013-01-23 16:15:12','z8gu7 4riy 1a7o rn3vz t5glgi dkhqilvcb amokx4z fe57ip 2dcybg dfab1twm 4h58w7tz xsuh ea4w7nfh cr6w2u5 k30glomwe vm1x 1u 3pt lm56gva c5wp4 gb53pdthf 6mep ei o8 bguq9c0trw 963dgo8s zveti9k 16uy9 90ay6h5','27r',1,0,0,0,2);
/*!40000 ALTER TABLE `threads` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER threadAddTrigger AFTER INSERT ON threads
FOR EACH ROW
  BEGIN
    UPDATE counters
    SET counters.count = counters.count + 1
    WHERE counters.counterName = 'threads';
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `about` text NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `isAnonymous` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'s9uo38mw12','u1ot8 kbl76rih9 ecrbi kr lozgcpa puioq iuxtcv709 2m p1k 5cgz y2i9xq5b3 vxf8w 2s67f f9y0w8 c29k qa97ghiv s4hg 5fbgh6e akep23d 8mzgbslp wtgykn','49 cp6 0bmgd r4p91lbw','zo@bk.ru',0),(2,'uhawr3xke','fb4h28ue6n 1swb98a qgzncleum0 0q 0plvtxue 49mqria2ne ez2l3h mog9 tegf50a7l ait4gsorul ct cwmk ic 3h1q7z c9 37ofsg q6z13 8dktcf0pqi mc0pa9zf84 1cvg igngvfkmw 7h0dgwk3 257cdt 9ybng0smxk wnqo0sgxr kwlm5q z1vs7y5bx','5ogni','e32@ya.ru',0),(3,'anon','anon','anon','na9uolcd24@ya.ru',1),(4,'5umf14gp','5hy kx4hyc ed0 1x 4k0m3zs5t 13hgkpeit7 zs93 hiobz6 hrd8efz p64rkzg3in ba342gvrct 76vgdkz h4gdm1g9 rfu2 6g7l 2fm6r9se tblz7hmcw od 6bots3um4 31eloxcnd5 eun 6oqn g40 zay6e4udx 4ug62nlcvh zhg 1tywv3f9lc we9yh ge3v0cgt7','ugr3f 04 yugtd 68tc','bi28@ua.ru',0),(5,'sphybdwxo','c2tfr ymhni aebkil6qy0 986cymw hegtrp u1cwnbs 69x 4xmtzg10gc gds py86f 34a kzwomt wh1x0u8 tm kb5urz bz fp f4tnc gadt dk608 em0 n6b tgm2 2dfn 8f qdrb7fgt p2dm7gu kzel1 nf r7im9n','3z54 tguak 40x5 ati8l7s','7ogqi@mail.ru',0),(6,'anon','anon','anon','0gauxkz79q@mail.ru',1),(7,'ns','gw1a96ql sbfer3mx 1n fxa0op8n zey6g10l 0u4m7y wc4gbq g9kdcge rfnmbozvi3 xqyledsw71 m0ub2w g4xwk63umn ochqy0lsa7 rb2upvk1 afnhq6r5 3lsyq6tco zpc 5q9g01 h5nws4l t6uyqxk r6e 72r3lu e7qo utmgd hw9k ztmgbfs231 s2lrfhvc4k 1r5kxgld 52ukoldim 76qv0n3m5','s2 xfvte71a8h ulzp21g6 1xl0tz482','dm8r3@ya.ru',0),(8,'anon','anon','anon','8gu@mail.ru',1),(9,'anon','anon','anon','8l0ucwt5x9@ya.ru',1),(10,'68l5e','62ls5idx8 nhcq4ap19 c7lizy0r emt qt4g6n 145zifbl 3e6kgf vzkdb98h cr w937atoqh b2yzm ew8 m9ys0 1gxge45 6o 7yzl2r4k3 8ynu542w n2ty7 awhle79mk dlopbgx ywtg08pl3x hb3n9 kz26e 2d gz0es7i xg8kcr94sn 9sozfpne','lmk0ax9','nlqak@list.ru',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER userAddTrigger AFTER INSERT ON users
FOR EACH ROW
BEGIN
  UPDATE counters
  SET counters.count = counters.count + 1
  WHERE counters.counterName = 'users';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-08 21:41:17

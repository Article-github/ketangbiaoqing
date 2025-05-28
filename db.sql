/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.26 : Database - class_zj
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`class_zj` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `class_zj`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add pic',7,'add_pic'),(26,'Can change pic',7,'change_pic'),(27,'Can delete pic',7,'delete_pic'),(28,'Can view pic',7,'view_pic'),(29,'Can add black_list',8,'add_black_list'),(30,'Can change black_list',8,'change_black_list'),(31,'Can delete black_list',8,'delete_black_list'),(32,'Can view black_list',8,'view_black_list'),(33,'Can add user',9,'add_user'),(34,'Can change user',9,'change_user'),(35,'Can delete user',9,'delete_user'),(36,'Can view user',9,'view_user');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (1,'pbkdf2_sha256$260000$mVz33GPILdQaKxGQohd4VI$9brAIg/PfCJa9wgKAPsBeCWH4BQmDTgxEROD/wPrg0k=','2025-04-10 22:23:36.000000',1,'admin','','','admin@qq.com',1,1,'2025-04-10 22:23:36.000000');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(7,'common','pic'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(8,'user','black_list'),(9,'user','user');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2025-04-10 22:23:36.000000'),(2,'auth','0001_initial','2025-04-10 22:23:36.000000'),(3,'admin','0001_initial','2025-04-10 22:23:36.000000'),(4,'admin','0002_logentry_remove_auto_add','2025-04-10 22:23:36.000000'),(5,'admin','0003_logentry_add_action_flag_choices','2025-04-10 22:23:36.000000'),(6,'contenttypes','0002_remove_content_type_name','2025-04-10 22:23:36.000000'),(7,'auth','0002_alter_permission_name_max_length','2025-04-10 22:23:36.000000'),(8,'auth','0003_alter_user_email_max_length','2025-04-10 22:23:36.000000'),(9,'auth','0004_alter_user_username_opts','2025-04-10 22:23:36.000000'),(10,'auth','0005_alter_user_last_login_null','2025-04-10 22:23:36.000000'),(11,'auth','0006_require_contenttypes_0002','2025-04-10 22:23:36.000000'),(12,'auth','0007_alter_validators_add_error_messages','2025-04-10 22:23:36.000000'),(13,'auth','0008_alter_user_username_max_length','2025-04-10 22:23:36.000000'),(14,'auth','0009_alter_user_last_name_max_length','2025-04-10 22:23:36.000000'),(15,'auth','0010_alter_group_name_max_length','2025-04-10 22:23:36.000000'),(16,'auth','0011_update_proxy_permissions','2025-04-10 22:23:36.000000'),(17,'auth','0012_alter_user_first_name_max_length','2025-04-10 22:23:36.000000'),(18,'common','0001_initial','2025-04-10 22:23:36.000000'),(19,'sessions','0001_initial','2025-04-10 22:23:36.000000'),(20,'user','0001_initial','2025-04-10 22:23:36.000000');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('1j8off352gly457q4yedpbmzh26llfhb','eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6MSwidXNlcl9pZCI6MX0:1rtIc1:vZMXgaiLot70Kda7tKM0FN_8GBhXIq5exc2z-IAGKyM','2025-04-10 22:23:36.000000'),('90o6du5q04ktmns457cebbswvmpyi479','eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6MSwidXNlcl9pZCI6MX0:1rxQ68:u7CQr_gQ27__E6q2zKZKJmFB2sFQcv660LtnnlYk9nU','2025-04-10 22:23:36.000000'),('bhddm6gsbpvxtfnkcudjtihp3s88tjcc','eyJyb2xlIjoxLCJ1c2VyX2lkIjoxfQ:1u2so9:hfWIX9Hrz2DdJDtJ0V08fHLb7MMRydLatndYwKh1L7Q','2025-04-10 22:23:36.000000'),('kisscspmxted9wrnvtdr92rvc2z0okfb','eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6MSwidXNlcl9pZCI6MX0:1tSSAl:QCvITNfqIB6NVNyJM3qnuxVppdHVHR30cr3rwoxB1y0','2025-04-10 22:23:36.000000'),('ooc5ka5xs03qm2fi85bqfl1oqarni8jc','eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6MSwidXNlcl9pZCI6MX0:1rxPUt:8AuLNCNhq5ck6SWAGbEQF2-ZdzEh9QOSYomZAYIBZY0','2025-04-10 22:23:36.000000'),('xmbgpbs37ks74kxu0ns1pwqxpyam4p3o','eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6MSwidXNlcl9pZCI6MX0:1rl89n:p3NiPFesNcNUlv7s17TnSvWcraPvF2ki2sY2wt7GXjM','2025-04-10 22:23:36.000000'),('ye5zhh5oby61mdvt9vgpru7t15vgrbwb','eyJyb2xlIjoxLCJ1c2VyX2lkIjoxfQ:1u2sqU:qPfdIrHwO2zaMWa5WzRocxsrDl4MtdtdV1T2eKLHVW8','2025-04-24 22:25:34.754384');

/*Table structure for table `pic` */

DROP TABLE IF EXISTS `pic`;

CREATE TABLE `pic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `face_status` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `pic` */

insert  into `pic`(`id`,`name`,`face_status`,`status`,`create_time`) values (1,'1.jpg','自然',0,'2025-04-10 22:23:36.000000'),(2,'1.jpg','开心',0,'2025-04-10 22:23:36.000000'),(3,'1.jpg','自然',0,'2025-04-10 22:23:36.000000'),(4,'1.jpg','开心',0,'2025-04-10 22:23:36.000000'),(5,'1.jpg','自然',0,'2025-04-10 22:23:36.000000'),(6,'1.jpg','开心',0,'2025-04-10 22:23:36.000000'),(7,'1.jpg','伤心',0,'2025-04-10 22:23:36.000000'),(8,'1.jpg','开心',0,'2025-04-10 22:23:36.000000'),(9,'1.jpg','自然',0,'2025-04-10 22:23:36.000000'),(10,'1.jpg','开心',0,'2025-04-10 22:23:36.000000'),(11,'1.jpg','愤怒',1,'2025-04-10 22:23:36.000000'),(12,'1.jpg','愤怒',1,'2025-04-10 22:23:36.000000'),(13,'1.jpg','开心',1,'2025-04-10 22:23:36.000000'),(14,'1.jpg','开心',1,'2025-04-10 22:24:43.148794');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `modify_time` datetime(6) NOT NULL,
  `role` int NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`password`,`image`,`phone`,`create_time`,`modify_time`,`role`,`description`) values (1,'admin','admin','static','123','2025-04-10 22:23:36.000000','2025-04-10 22:23:36.000000',1,'1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

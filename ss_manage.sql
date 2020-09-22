# Host: localhost  (Version: 5.5.53)
# Date: 2019-04-19 19:42:24
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "ts_admin"
#

DROP TABLE IF EXISTS `ts_admin`;
CREATE TABLE `ts_admin` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `admin_username` varchar(20) NOT NULL COMMENT '管理员用户名',
  `admin_password` varchar(32) NOT NULL COMMENT '管理员密码',
  `manage` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_username_2` (`admin_username`),
  KEY `admin_username` (`admin_username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

#
# Data for table "ts_admin"
#

INSERT INTO `ts_admin` VALUES (13,'admin','635092b43f6daab6e117b2429f5e6236',1)

#
# Structure for table "ts_build"
#

DROP TABLE IF EXISTS `ts_build`;
CREATE TABLE `ts_build` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `build_name` varchar(4) NOT NULL COMMENT '楼号',
  `build_describe` varchar(100) NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `build_name` (`build_name`),
  KEY `build_name_2` (`build_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Data for table "ts_build"
#

#
# Structure for table "ts_department"
#

DROP TABLE IF EXISTS `ts_department`;
CREATE TABLE `ts_department` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `department_name` varchar(10) NOT NULL COMMENT '系名',
  `department_describe` varchar(100) NOT NULL COMMENT '系描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Data for table "ts_department"
#


#
# Structure for table "ts_dorm"
#

DROP TABLE IF EXISTS `ts_dorm`;
CREATE TABLE `ts_dorm` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `dorm_name` smallint(6) NOT NULL COMMENT '宿舍名称',
  `lc_name` tinyint(4) NOT NULL COMMENT '楼层',
  `build_id` tinyint(4) NOT NULL COMMENT '宿舍id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dorm_name` (`dorm_name`),
  KEY `build_id` (`build_id`),
  KEY `dorm_name_2` (`dorm_name`),
  KEY `lc_name` (`lc_name`),
  CONSTRAINT `ts_dorm_ibfk_1` FOREIGN KEY (`build_id`) REFERENCES `ts_build` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1879 DEFAULT CHARSET=utf8;

#
# Data for table "ts_dorm"
#


#
# Structure for table "ts_fd"
#

DROP TABLE IF EXISTS `ts_fd`;
CREATE TABLE `ts_fd` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `fd_name` varchar(15) NOT NULL COMMENT '辅导员名',
  `fd_phone` varchar(20) NOT NULL COMMENT '辅导员联系方式',
  `department_id` tinyint(4) NOT NULL COMMENT '系id',
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  KEY `fd_name` (`fd_name`),
  CONSTRAINT `ts_fd_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `ts_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

#
# Data for table "ts_fd"
#



#
# Structure for table "ts_grade"
#

DROP TABLE IF EXISTS `ts_grade`;
CREATE TABLE `ts_grade` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `class_name` varchar(10) NOT NULL COMMENT '班级名',
  `department_id` tinyint(4) NOT NULL COMMENT '系id',
  `fd_id` smallint(6) NOT NULL COMMENT '导员',
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  KEY `fa_id` (`fd_id`),
  KEY `class_name` (`class_name`),
  CONSTRAINT `ts_grade_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `ts_department` (`id`),
  CONSTRAINT `ts_grade_ibfk_2` FOREIGN KEY (`fd_id`) REFERENCES `ts_fd` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8;

#
# Data for table "ts_grade"
#


#
# Structure for table "ts_student"
#

DROP TABLE IF EXISTS `ts_student`;
CREATE TABLE `ts_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` varchar(10) NOT NULL,
  `student_cardid` varchar(20) NOT NULL,
  `student_sex` char(2) NOT NULL,
  `student_name` varchar(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`),
  KEY `student_id_2` (`student_id`),
  KEY `student_cardid` (`student_cardid`)
) ENGINE=InnoDB AUTO_INCREMENT=14081 DEFAULT CHARSET=utf8;

#
# Data for table "ts_student"
#



#
# Structure for table "ts_bed"
#

DROP TABLE IF EXISTS `ts_bed`;
CREATE TABLE `ts_bed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bed_name` tinyint(4) NOT NULL,
  `student_id` int(11) NOT NULL,
  `build_id` tinyint(4) NOT NULL,
  `dorm_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `build_id` (`build_id`),
  KEY `dorm_id` (`dorm_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `ts_bed_ibfk_1` FOREIGN KEY (`build_id`) REFERENCES `ts_build` (`id`),
  CONSTRAINT `ts_bed_ibfk_2` FOREIGN KEY (`dorm_id`) REFERENCES `ts_dorm` (`id`),
  CONSTRAINT `ts_bed_ibfk_3` FOREIGN KEY (`student_id`) REFERENCES `ts_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4089 DEFAULT CHARSET=utf8;

#
# Data for table "ts_bed"
#


#
# Structure for table "ts_studentx"
#

DROP TABLE IF EXISTS `ts_studentx`;
CREATE TABLE `ts_studentx` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `xxstudent_birthday` date DEFAULT NULL COMMENT '学生生日',
  `xxstudent_phone` varchar(20) DEFAULT NULL COMMENT '学生联系方式',
  `xxstudent_place` varchar(10) DEFAULT NULL COMMENT '学生籍贯',
  `xxstudent_addres` varchar(30) DEFAULT NULL COMMENT '学生地址',
  `xxstudent_major` varchar(15) DEFAULT NULL COMMENT '学生专业',
  `xxstudent_job` varchar(10) DEFAULT NULL COMMENT '学生职务',
  `xxstudent_mphone` varchar(20) DEFAULT NULL COMMENT '妈妈联系',
  `xxstudent_fphone` varchar(20) DEFAULT NULL COMMENT '爸爸联系',
  `xxdepartment_id` tinyint(4) NOT NULL COMMENT '所属系id',
  `student_id` int(11) NOT NULL COMMENT '学生id',
  `fd_id` smallint(6) NOT NULL COMMENT '所属导员_id',
  `class_id` smallint(6) NOT NULL COMMENT '所属班级_id',
  `xxstudent_qq` varchar(11) NOT NULL,
  `statu` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `fd_id` (`fd_id`),
  KEY `class_id` (`class_id`),
  KEY `xxdepartment_id` (`xxdepartment_id`),
  KEY `xxstudent_qq` (`xxstudent_qq`),
  CONSTRAINT `ts_studentx_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `ts_student` (`id`),
  CONSTRAINT `ts_studentx_ibfk_2` FOREIGN KEY (`fd_id`) REFERENCES `ts_fd` (`id`),
  CONSTRAINT `ts_studentx_ibfk_3` FOREIGN KEY (`class_id`) REFERENCES `ts_grade` (`id`),
  CONSTRAINT `ts_studentx_ibfk_4` FOREIGN KEY (`xxdepartment_id`) REFERENCES `ts_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4744 DEFAULT CHARSET=utf8;

#
# Data for table "ts_studentx"
#



#
# Structure for table "ts_token"
#

DROP TABLE IF EXISTS `ts_token`;
CREATE TABLE `ts_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(20) NOT NULL,
  `token` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `ts_token_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `ts_admin` (`admin_username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

#
# Data for table "ts_token"
#
;

-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: pall_wdpts
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Temporary view structure for view `menubuttonview`
--

DROP TABLE IF EXISTS `menubuttonview`;
/*!50001 DROP VIEW IF EXISTS `menubuttonview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `menubuttonview` AS SELECT 
 1 AS `menuid`,
 1 AS `menuname`,
 1 AS `menutype`,
 1 AS `pmenuid`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `t_trackinglist_cistern`
--

DROP TABLE IF EXISTS `t_trackinglist_cistern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_cistern` (
  `cistern_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `assemble_time` date DEFAULT NULL COMMENT '装配日期',
  `production_time` datetime DEFAULT NULL COMMENT '生产时间',
  `c_orderid` varchar(50) DEFAULT '' COMMENT '客户订单信息',
  `cistern_pn` varchar(50) DEFAULT NULL COMMENT '料号/PN',
  `serial_no` varchar(50) DEFAULT NULL COMMENT '序列号/Serial NO',
  `workorder_no` varchar(50) NOT NULL COMMENT '工单号/WO',
  `cistern_model` varchar(100) DEFAULT NULL COMMENT '水箱型号/Model',
  `cistern_option` varchar(100) DEFAULT NULL COMMENT '水箱选配件/Options',
  `cistern_option2` varchar(100) DEFAULT NULL COMMENT '水箱选配件/Options',
  `exception_record` varchar(200) DEFAULT NULL COMMENT '异常记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `assemble_Operator` varchar(20) DEFAULT NULL COMMENT '装配人员',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cistern_id`,`input_time`),
  KEY `idx_cistern_pn` (`cistern_pn`),
  KEY `idx_serial_no` (`serial_no`),
  KEY `idx_assemble_time` (`assemble_time`),
  KEY `idx_workorder_no` (`workorder_no`),
  KEY `idx_cistern_model` (`cistern_model`),
  KEY `idx_c_orderid` (`c_orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='水箱装配流程跟踪单表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION p201802 VALUES LESS THAN (737091) ENGINE = InnoDB,
 PARTITION p201803 VALUES LESS THAN (737119) ENGINE = InnoDB,
 PARTITION p201804 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION p201805 VALUES LESS THAN (737180) ENGINE = InnoDB,
 PARTITION p201806 VALUES LESS THAN (737211) ENGINE = InnoDB,
 PARTITION p201807 VALUES LESS THAN (737241) ENGINE = InnoDB,
 PARTITION p201808 VALUES LESS THAN (737272) ENGINE = InnoDB,
 PARTITION p201809 VALUES LESS THAN (737303) ENGINE = InnoDB,
 PARTITION p201810 VALUES LESS THAN (737333) ENGINE = InnoDB,
 PARTITION p201811 VALUES LESS THAN (737364) ENGINE = InnoDB,
 PARTITION p201812 VALUES LESS THAN (737394) ENGINE = InnoDB,
 PARTITION p201901 VALUES LESS THAN (737425) ENGINE = InnoDB,
 PARTITION p201902 VALUES LESS THAN (737456) ENGINE = InnoDB,
 PARTITION p201903 VALUES LESS THAN (737484) ENGINE = InnoDB,
 PARTITION p201904 VALUES LESS THAN (737515) ENGINE = InnoDB,
 PARTITION p201905 VALUES LESS THAN (737545) ENGINE = InnoDB,
 PARTITION p201906 VALUES LESS THAN (737576) ENGINE = InnoDB,
 PARTITION p201907 VALUES LESS THAN (737606) ENGINE = InnoDB,
 PARTITION p201908 VALUES LESS THAN (737637) ENGINE = InnoDB,
 PARTITION p201909 VALUES LESS THAN (737668) ENGINE = InnoDB,
 PARTITION p201910 VALUES LESS THAN (737698) ENGINE = InnoDB,
 PARTITION p201911 VALUES LESS THAN (737729) ENGINE = InnoDB,
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB,
 PARTITION p202001 VALUES LESS THAN (737790) ENGINE = InnoDB,
 PARTITION p202002 VALUES LESS THAN (737821) ENGINE = InnoDB,
 PARTITION p202003 VALUES LESS THAN (737850) ENGINE = InnoDB,
 PARTITION p202004 VALUES LESS THAN (737881) ENGINE = InnoDB,
 PARTITION p202005 VALUES LESS THAN (737911) ENGINE = InnoDB,
 PARTITION p202006 VALUES LESS THAN (737942) ENGINE = InnoDB,
 PARTITION p202007 VALUES LESS THAN (737972) ENGINE = InnoDB,
 PARTITION p202008 VALUES LESS THAN (738003) ENGINE = InnoDB,
 PARTITION p202009 VALUES LESS THAN (738034) ENGINE = InnoDB,
 PARTITION p202010 VALUES LESS THAN (738064) ENGINE = InnoDB,
 PARTITION p202011 VALUES LESS THAN (738095) ENGINE = InnoDB,
 PARTITION p202012 VALUES LESS THAN (738125) ENGINE = InnoDB,
 PARTITION p202101 VALUES LESS THAN (738156) ENGINE = InnoDB,
 PARTITION p202102 VALUES LESS THAN (738187) ENGINE = InnoDB,
 PARTITION p202103 VALUES LESS THAN (738215) ENGINE = InnoDB,
 PARTITION p202104 VALUES LESS THAN (738246) ENGINE = InnoDB,
 PARTITION p202105 VALUES LESS THAN (738276) ENGINE = InnoDB,
 PARTITION p202106 VALUES LESS THAN (738307) ENGINE = InnoDB,
 PARTITION p202107 VALUES LESS THAN (738337) ENGINE = InnoDB,
 PARTITION p202108 VALUES LESS THAN (738368) ENGINE = InnoDB,
 PARTITION p202109 VALUES LESS THAN (738399) ENGINE = InnoDB,
 PARTITION p202110 VALUES LESS THAN (738429) ENGINE = InnoDB,
 PARTITION p202111 VALUES LESS THAN (738460) ENGINE = InnoDB,
 PARTITION p202112 VALUES LESS THAN (738490) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_cistern`
--

LOCK TABLES `t_trackinglist_cistern` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_cistern` DISABLE KEYS */;
INSERT INTO `t_trackinglist_cistern` VALUES (3,'2018-09-28','2018-09-04 16:14:52','','LWFS32401S','对方答复','按时发生','Cascada II.I',NULL,NULL,'','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','阿凡达',9,'2018-09-28 16:15:09','2018-09-28 16:15:09'),(4,'2018-09-28','2018-09-04 16:14:52','','LWFS32401S','对方答复','按时发生','Cascada II.I',NULL,NULL,'','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','阿凡达',9,'2018-09-28 16:22:18','2018-09-28 18:10:05'),(5,'2018-09-28','2018-09-04 16:14:52','sdfsdf33','LWFS32401S','对方答复','按时发生','Cascada II.I',NULL,NULL,'','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','阿凡达',9,'2018-10-09 11:32:50','2018-10-09 11:33:04'),(7,'2018-10-09','2018-10-09 14:27:28','水电费','LWFS32401S','胜多负少的','撒发生','Cascada II.I','水电费3','水电费','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','胜多负少',9,'2018-10-09 14:27:30','2018-11-27 11:27:29');
/*!40000 ALTER TABLE `t_trackinglist_cistern` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_cistern_assemble`
--

DROP TABLE IF EXISTS `t_trackinglist_cistern_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_cistern_assemble` (
  `cistern_id` int(11) NOT NULL COMMENT '水箱装配流程跟踪单唯一标示',
  `component_name` varchar(100) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(100) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(50) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_cistern_id` (`cistern_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='水箱装配流程跟踪单装配记录表'
/*!50100 PARTITION BY HASH (cistern_id)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_cistern_assemble`
--

LOCK TABLES `t_trackinglist_cistern_assemble` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_cistern_assemble` DISABLE KEYS */;
INSERT INTO `t_trackinglist_cistern_assemble` VALUES (4,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','0_正确Yes|不正确No','消防水带'),(4,'底部密封方式|Bottem Sealing Element','堵头/Stopper Probe','1_正确Yes|不正确No','胜多负少'),(4,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','1_正确Yes|不正确No','胜多负少的吧'),(4,'整流器控制盒 Waterproof ballast box','---','0_有 Yes|无 No','吃的舒服'),(4,'液位杆|Tank Level Sensor','35L航空插液位杆/Level Sensor 35L','0_正确Yes|不正确No',''),(5,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','0_正确Yes|不正确No','消防水带'),(5,'底部密封方式|Bottem Sealing Element','堵头/Stopper Probe','1_正确Yes|不正确No','胜多负少'),(5,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','1_正确Yes|不正确No','胜多负少的吧'),(5,'整流器控制盒 Waterproof ballast box','---','0_有 Yes|无 No','吃的舒服'),(5,'液位杆|Tank Level Sensor','35L航空插液位杆/Level Sensor 35L','0_正确Yes|不正确No',''),(7,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','0_正确Yes|不正确No',''),(7,'底部密封方式|Bottem Sealing Element','堵头/Stopper Probe','0_正确Yes|不正确No',''),(7,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','1_正确Yes|不正确No','水电费'),(7,'整流器控制盒 Waterproof ballast box','---','0_有 Yes|无 No',''),(7,'液位杆|Tank Level Sensor','35L航空插液位杆/Level Sensor 35L','0_正确Yes|不正确No','');
/*!40000 ALTER TABLE `t_trackinglist_cistern_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_dsp`
--

DROP TABLE IF EXISTS `t_trackinglist_dsp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_dsp` (
  `dsp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `assemble_time` date DEFAULT NULL COMMENT '装配日期',
  `production_time` datetime DEFAULT NULL COMMENT '生产时间',
  `c_orderid` varchar(50) DEFAULT NULL COMMENT '客户订单信息',
  `dsp_pn` varchar(50) DEFAULT NULL COMMENT '型号/PN',
  `serial_no` varchar(50) DEFAULT NULL COMMENT '序列号/Serial NO',
  `workorder_no` varchar(50) NOT NULL COMMENT '工单号/WO',
  `dsp_model` varchar(100) DEFAULT NULL COMMENT 'DSP型号/Model',
  `exception_record` varchar(200) DEFAULT NULL COMMENT '异常记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `assemble_Operator` varchar(20) DEFAULT NULL COMMENT '装配人员',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dsp_id`,`input_time`),
  KEY `idx_assemble_time` (`assemble_time`),
  KEY `idx_c_orderid` (`c_orderid`),
  KEY `idx_dsp_pn` (`dsp_pn`),
  KEY `idx_serial_no` (`serial_no`),
  KEY `idx_workorder_no` (`workorder_no`),
  KEY `idx_dsp_model` (`dsp_model`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='DSP装配流程跟踪单表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION p201802 VALUES LESS THAN (737091) ENGINE = InnoDB,
 PARTITION p201803 VALUES LESS THAN (737119) ENGINE = InnoDB,
 PARTITION p201804 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION p201805 VALUES LESS THAN (737180) ENGINE = InnoDB,
 PARTITION p201806 VALUES LESS THAN (737211) ENGINE = InnoDB,
 PARTITION p201807 VALUES LESS THAN (737241) ENGINE = InnoDB,
 PARTITION p201808 VALUES LESS THAN (737272) ENGINE = InnoDB,
 PARTITION p201809 VALUES LESS THAN (737303) ENGINE = InnoDB,
 PARTITION p201810 VALUES LESS THAN (737333) ENGINE = InnoDB,
 PARTITION p201811 VALUES LESS THAN (737364) ENGINE = InnoDB,
 PARTITION p201812 VALUES LESS THAN (737394) ENGINE = InnoDB,
 PARTITION p201901 VALUES LESS THAN (737425) ENGINE = InnoDB,
 PARTITION p201902 VALUES LESS THAN (737456) ENGINE = InnoDB,
 PARTITION p201903 VALUES LESS THAN (737484) ENGINE = InnoDB,
 PARTITION p201904 VALUES LESS THAN (737515) ENGINE = InnoDB,
 PARTITION p201905 VALUES LESS THAN (737545) ENGINE = InnoDB,
 PARTITION p201906 VALUES LESS THAN (737576) ENGINE = InnoDB,
 PARTITION p201907 VALUES LESS THAN (737606) ENGINE = InnoDB,
 PARTITION p201908 VALUES LESS THAN (737637) ENGINE = InnoDB,
 PARTITION p201909 VALUES LESS THAN (737668) ENGINE = InnoDB,
 PARTITION p201910 VALUES LESS THAN (737698) ENGINE = InnoDB,
 PARTITION p201911 VALUES LESS THAN (737729) ENGINE = InnoDB,
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB,
 PARTITION p202001 VALUES LESS THAN (737790) ENGINE = InnoDB,
 PARTITION p202002 VALUES LESS THAN (737821) ENGINE = InnoDB,
 PARTITION p202003 VALUES LESS THAN (737850) ENGINE = InnoDB,
 PARTITION p202004 VALUES LESS THAN (737881) ENGINE = InnoDB,
 PARTITION p202005 VALUES LESS THAN (737911) ENGINE = InnoDB,
 PARTITION p202006 VALUES LESS THAN (737942) ENGINE = InnoDB,
 PARTITION p202007 VALUES LESS THAN (737972) ENGINE = InnoDB,
 PARTITION p202008 VALUES LESS THAN (738003) ENGINE = InnoDB,
 PARTITION p202009 VALUES LESS THAN (738034) ENGINE = InnoDB,
 PARTITION p202010 VALUES LESS THAN (738064) ENGINE = InnoDB,
 PARTITION p202011 VALUES LESS THAN (738095) ENGINE = InnoDB,
 PARTITION p202012 VALUES LESS THAN (738125) ENGINE = InnoDB,
 PARTITION p202101 VALUES LESS THAN (738156) ENGINE = InnoDB,
 PARTITION p202102 VALUES LESS THAN (738187) ENGINE = InnoDB,
 PARTITION p202103 VALUES LESS THAN (738215) ENGINE = InnoDB,
 PARTITION p202104 VALUES LESS THAN (738246) ENGINE = InnoDB,
 PARTITION p202105 VALUES LESS THAN (738276) ENGINE = InnoDB,
 PARTITION p202106 VALUES LESS THAN (738307) ENGINE = InnoDB,
 PARTITION p202107 VALUES LESS THAN (738337) ENGINE = InnoDB,
 PARTITION p202108 VALUES LESS THAN (738368) ENGINE = InnoDB,
 PARTITION p202109 VALUES LESS THAN (738399) ENGINE = InnoDB,
 PARTITION p202110 VALUES LESS THAN (738429) ENGINE = InnoDB,
 PARTITION p202111 VALUES LESS THAN (738460) ENGINE = InnoDB,
 PARTITION p202112 VALUES LESS THAN (738490) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_dsp`
--

LOCK TABLES `t_trackinglist_dsp` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_dsp` DISABLE KEYS */;
INSERT INTO `t_trackinglist_dsp` VALUES (7,'2018-09-28','2018-09-28 15:35:04','zfsfsdfd','LWFS32603','55555555555556666','2222222222山东省','灵活取水手柄 III 级水     Flexible DSP Type III','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','王文',9,'2018-10-09 11:31:19','2018-11-27 11:27:02');
/*!40000 ALTER TABLE `t_trackinglist_dsp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_dsp_assemble`
--

DROP TABLE IF EXISTS `t_trackinglist_dsp_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_dsp_assemble` (
  `dsp_id` int(11) NOT NULL COMMENT '主机装配流程跟踪单唯一标示',
  `component_name` varchar(100) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(100) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(50) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机装配流程跟踪单装配记录表'
/*!50100 PARTITION BY HASH (dsp_id)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_dsp_assemble`
--

LOCK TABLES `t_trackinglist_dsp_assemble` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_dsp_assemble` DISABLE KEYS */;
INSERT INTO `t_trackinglist_dsp_assemble` VALUES (7,'滚轮与IO板配合|Dispenser roller and IO board Assembly','滚动阻尼及微动开关|Roll damping and micro switch','0_合格 Pass|不合格 Fail','sada'),(7,'IO板接线线序|IO Board Wring ','线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring','1_合格 Pass|不合格 Fail','asdas'),(7,'FFC排线|FFC cable','FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable','0_合格 Pass|不合格 Fail','asda'),(7,'DSP手柄圆形挂件|Dispenser holder','是否漏装及方向是否正确|direction','1_合格 Pass|不合格 Fail','asda'),(7,'远程取水站配件|Remote DSP With Station accessories','底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection','0_合格 Pass|不合格 Fail','asda'),(7,'远程取水站配件|Remote DSP With Station accessories','底座水路上下盖（Cable位置，外观）|Dispenser base inspection','0_合格 Pass|不合格 Fail','asda'),(7,'远程取水站配件|Remote DSP With Station accessories','铝杆支架及螺钉|Dispenser base inspection','0_有 Yes|无 No','sdfsd');
/*!40000 ALTER TABLE `t_trackinglist_dsp_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_mainframe`
--

DROP TABLE IF EXISTS `t_trackinglist_mainframe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_mainframe` (
  `mainframe_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `assemble_time` date DEFAULT NULL COMMENT '装配日期',
  `production_time` datetime DEFAULT NULL COMMENT '生产时间',
  `c_orderid` varchar(50) DEFAULT '' COMMENT '客户订单信息',
  `mainframe_pn` varchar(50) DEFAULT NULL COMMENT '型号/PN',
  `serial_no` varchar(50) DEFAULT NULL COMMENT '序列号/Serial NO',
  `workorder_no` varchar(50) NOT NULL COMMENT '工单号/WO',
  `mainframe_model` varchar(100) DEFAULT NULL COMMENT '主机型号/Model',
  `mainframe_option` varchar(100) DEFAULT NULL COMMENT '主机选配件/Option',
  `mainframe_option2` varchar(100) DEFAULT NULL,
  `exception_record` varchar(200) DEFAULT NULL COMMENT '异常记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `assemble_Operator` varchar(20) DEFAULT NULL COMMENT '装配人员',
  `inspect_operator` varchar(20) DEFAULT NULL COMMENT '送检人员',
  `inspect_time` date DEFAULT NULL COMMENT '送检日期',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`mainframe_id`,`input_time`),
  KEY `idx_assemble_time` (`assemble_time`),
  KEY `idx_c_orderid` (`c_orderid`),
  KEY `idx_mainframe_pn` (`mainframe_pn`),
  KEY `idx_workorder_no` (`workorder_no`),
  KEY `idx_serial_no` (`serial_no`),
  KEY `idx_mainframe_model` (`mainframe_model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='主机装配流程跟踪单表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION p201802 VALUES LESS THAN (737091) ENGINE = InnoDB,
 PARTITION p201803 VALUES LESS THAN (737119) ENGINE = InnoDB,
 PARTITION p201804 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION p201805 VALUES LESS THAN (737180) ENGINE = InnoDB,
 PARTITION p201806 VALUES LESS THAN (737211) ENGINE = InnoDB,
 PARTITION p201807 VALUES LESS THAN (737241) ENGINE = InnoDB,
 PARTITION p201808 VALUES LESS THAN (737272) ENGINE = InnoDB,
 PARTITION p201809 VALUES LESS THAN (737303) ENGINE = InnoDB,
 PARTITION p201810 VALUES LESS THAN (737333) ENGINE = InnoDB,
 PARTITION p201811 VALUES LESS THAN (737364) ENGINE = InnoDB,
 PARTITION p201812 VALUES LESS THAN (737394) ENGINE = InnoDB,
 PARTITION p201901 VALUES LESS THAN (737425) ENGINE = InnoDB,
 PARTITION p201902 VALUES LESS THAN (737456) ENGINE = InnoDB,
 PARTITION p201903 VALUES LESS THAN (737484) ENGINE = InnoDB,
 PARTITION p201904 VALUES LESS THAN (737515) ENGINE = InnoDB,
 PARTITION p201905 VALUES LESS THAN (737545) ENGINE = InnoDB,
 PARTITION p201906 VALUES LESS THAN (737576) ENGINE = InnoDB,
 PARTITION p201907 VALUES LESS THAN (737606) ENGINE = InnoDB,
 PARTITION p201908 VALUES LESS THAN (737637) ENGINE = InnoDB,
 PARTITION p201909 VALUES LESS THAN (737668) ENGINE = InnoDB,
 PARTITION p201910 VALUES LESS THAN (737698) ENGINE = InnoDB,
 PARTITION p201911 VALUES LESS THAN (737729) ENGINE = InnoDB,
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB,
 PARTITION p202001 VALUES LESS THAN (737790) ENGINE = InnoDB,
 PARTITION p202002 VALUES LESS THAN (737821) ENGINE = InnoDB,
 PARTITION p202003 VALUES LESS THAN (737850) ENGINE = InnoDB,
 PARTITION p202004 VALUES LESS THAN (737881) ENGINE = InnoDB,
 PARTITION p202005 VALUES LESS THAN (737911) ENGINE = InnoDB,
 PARTITION p202006 VALUES LESS THAN (737942) ENGINE = InnoDB,
 PARTITION p202007 VALUES LESS THAN (737972) ENGINE = InnoDB,
 PARTITION p202008 VALUES LESS THAN (738003) ENGINE = InnoDB,
 PARTITION p202009 VALUES LESS THAN (738034) ENGINE = InnoDB,
 PARTITION p202010 VALUES LESS THAN (738064) ENGINE = InnoDB,
 PARTITION p202011 VALUES LESS THAN (738095) ENGINE = InnoDB,
 PARTITION p202012 VALUES LESS THAN (738125) ENGINE = InnoDB,
 PARTITION p202101 VALUES LESS THAN (738156) ENGINE = InnoDB,
 PARTITION p202102 VALUES LESS THAN (738187) ENGINE = InnoDB,
 PARTITION p202103 VALUES LESS THAN (738215) ENGINE = InnoDB,
 PARTITION p202104 VALUES LESS THAN (738246) ENGINE = InnoDB,
 PARTITION p202105 VALUES LESS THAN (738276) ENGINE = InnoDB,
 PARTITION p202106 VALUES LESS THAN (738307) ENGINE = InnoDB,
 PARTITION p202107 VALUES LESS THAN (738337) ENGINE = InnoDB,
 PARTITION p202108 VALUES LESS THAN (738368) ENGINE = InnoDB,
 PARTITION p202109 VALUES LESS THAN (738399) ENGINE = InnoDB,
 PARTITION p202110 VALUES LESS THAN (738429) ENGINE = InnoDB,
 PARTITION p202111 VALUES LESS THAN (738460) ENGINE = InnoDB,
 PARTITION p202112 VALUES LESS THAN (738490) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_mainframe`
--

LOCK TABLES `t_trackinglist_mainframe` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_mainframe` DISABLE KEYS */;
INSERT INTO `t_trackinglist_mainframe` VALUES (4,'2018-09-28','2018-09-28 18:08:01','','LWFS31101C','撒发生','撒发生','Cascada I','水电费','水电费是','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','阿萨德','',NULL,9,'2018-09-28 18:08:26','2018-09-28 18:09:44'),(5,'2018-09-28','2018-09-28 18:08:01','','LWFS31101C','撒发生','撒发生','Cascada I','水电费','水电费是','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','阿萨德','',NULL,9,'2018-09-28 18:09:51','2018-09-28 18:09:51'),(6,'2018-09-28','2018-09-28 18:08:01','asfda33','LWFS31101C','撒发生','撒发生','Cascada I','水电费','水电费是','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','阿萨德','',NULL,9,'2018-10-09 11:35:43','2018-10-10 18:25:57'),(7,'2018-10-24',NULL,'XXXX','LWFS31230T','N81X000CA','TEST000001','Cascada II.I','TOC','RESRVOR','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','test01','',NULL,9,'2018-10-24 13:58:32','2018-10-24 13:58:32'),(8,NULL,NULL,'','LWFS31101C','11','11','Cascada I','','','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','11','',NULL,9,'2018-11-02 10:35:04','2018-11-02 10:35:04'),(11,'2018-11-22',NULL,'','LWFS31101C','XX01','123','Cascada I','C','','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','a','',NULL,9,'2018-11-22 15:18:57','2018-11-22 15:18:57'),(12,'2018-11-22',NULL,'','LWFS31101C','XX01','123','Cascada I','C','','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','a','',NULL,9,'2018-11-22 15:19:17','2018-11-22 15:19:17'),(13,'2018-11-22',NULL,'','LWFS31101C','FCHGF','GHJGH','Cascada I','C','','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','FGDF','',NULL,9,'2018-11-22 15:23:59','2018-11-22 15:23:59'),(14,'2018-11-26',NULL,'','LWFS31101','0001','DSFG','Cascada I','N/A','','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','111','',NULL,9,'2018-11-26 14:36:26','2018-11-26 14:36:26'),(15,'2018-11-26',NULL,'','LWFS31101','0001','FDGS','Cascada I','N/A','','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','REWT','',NULL,9,'2018-11-26 14:36:59','2018-11-26 14:36:59');
/*!40000 ALTER TABLE `t_trackinglist_mainframe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_mainframe_assemble`
--

DROP TABLE IF EXISTS `t_trackinglist_mainframe_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_mainframe_assemble` (
  `mainframe_id` int(11) NOT NULL COMMENT '主机装配流程跟踪单唯一标示',
  `component_name` varchar(100) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(100) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(50) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_mainframe_id` (`mainframe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机装配流程跟踪单装配记录表'
/*!50100 PARTITION BY HASH (mainframe_id)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_mainframe_assemble`
--

LOCK TABLES `t_trackinglist_mainframe_assemble` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_mainframe_assemble` DISABLE KEYS */;
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES (4,'开关电源（主机）|Power module (MU)','SP-200-24','阿达',''),(4,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-阿萨德',''),(4,'循环压力变送器|Loop PT3','MPM4150','阿萨德',''),(4,'水质变送器|Water quality transducer','CM2 RO产水电导仪 RO quality sensor','',''),(4,'水质变送器|Water quality transducer','2# 电导变送器     2# transducer','','阿达'),(4,'水质变送器|Water quality transducer','CM4中间电导 Intermediate sensor','',''),(4,'水质变送器|Water quality transducer','6# 电导变送器     2# transducer','阿萨德','阿萨德'),(4,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','阿萨德','阿萨德'),(4,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(4,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(5,'开关电源（主机）|Power module (MU)','SP-200-24','阿达',''),(5,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-阿萨德',''),(5,'循环压力变送器|Loop PT3','MPM4150','阿萨德',''),(5,'水质变送器|Water quality transducer','CM2 RO产水电导仪 RO quality sensor','',''),(5,'水质变送器|Water quality transducer','2# 电导变送器     2# transducer','','阿达'),(5,'水质变送器|Water quality transducer','CM4中间电导 Intermediate sensor','',''),(5,'水质变送器|Water quality transducer','6# 电导变送器     2# transducer','阿萨德','阿萨德'),(5,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','阿萨德','阿萨德'),(5,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(5,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(6,'开关电源（主机）|Power module (MU)','SP-200-24','阿达1',''),(6,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-阿萨德',''),(6,'循环压力变送器|Loop PT3','MPM4150','阿萨德',''),(6,'水质变送器|Water quality transducer','CM2 RO产水电导仪 RO quality sensor','',''),(6,'水质变送器|Water quality transducer','2# 电导变送器     2# transducer','','阿达'),(6,'水质变送器|Water quality transducer','CM4中间电导 Intermediate sensor','',''),(6,'水质变送器|Water quality transducer','6# 电导变送器     2# transducer','阿萨德','阿萨德'),(6,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','阿萨德','阿萨德'),(6,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(6,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(7,'开关电源（主机）|Power module (MU)','','1',''),(7,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-2',''),(7,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-3',''),(7,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-4',''),(7,'一级RO压力变送器|1st RO PT 1','MPM4150','5',''),(7,'二级RO压力变送器|2st RO PT 2','MPM4150','6',''),(7,'循环压力变送器| Loop PT 3','MPM4150','7',''),(7,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','8',''),(7,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','9',''),(7,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','10',''),(7,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','11',''),(7,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','12',''),(7,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','13',''),(7,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','14',''),(7,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','15',''),(7,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','16',''),(7,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','17',''),(7,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','18',''),(7,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','19',''),(7,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','20',''),(7,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','21',''),(7,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','22',''),(7,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','23',''),(8,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(8,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(8,'循环压力变送器|Loop PT3','MPM4150','',''),(8,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(8,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','',''),(8,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(8,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(8,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(8,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(8,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(8,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(11,'开关电源（主机）|Power module (MU)','SP-200-24','1',''),(11,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(11,'循环压力变送器|Loop PT3','MPM4150','1',''),(11,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','1',''),(11,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','1',''),(11,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','1',''),(11,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','1',''),(11,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','1',''),(11,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','1',''),(11,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','1',''),(11,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','1',''),(12,'开关电源（主机）|Power module (MU)','SP-200-24','1',''),(12,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(12,'循环压力变送器|Loop PT3','MPM4150','1',''),(12,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','1',''),(12,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','1',''),(12,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','1',''),(12,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','1',''),(12,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','1',''),(12,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','1',''),(12,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','1',''),(12,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','1',''),(13,'开关电源（主机）|Power module (MU)','SP-200-24','FCHGF',''),(13,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(13,'循环压力变送器|Loop PT3','MPM4150','GHJG',''),(13,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','GHJG',''),(13,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','GHJG',''),(13,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','GJHG',''),(13,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','GHJHG',''),(13,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','GJHYG',''),(13,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','GJG',''),(13,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','GHJG',''),(13,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','GHJG',''),(14,'开关电源（主机）|Power module (MU)','SP-200-24','1',''),(14,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(14,'循环压力变送器|LoopPT3','MPM4150','1',''),(14,'水质变送器|Water quality transducer','CM4 中间电导 Intermediate sensor','1',''),(14,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','1',''),(14,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','1',''),(14,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','1',''),(14,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','1',''),(14,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','1',''),(15,'开关电源（主机）|Power module (MU)','SP-200-24','1',''),(15,'循环泵|Recirculation pump','EC-203-300ARS','1',''),(15,'循环压力变送器|LoopPT3','MPM4150','1',''),(15,'水质变送器|Water quality transducer','CM4 中间电导 Intermediate sensor','1',''),(15,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','1',''),(15,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','1',''),(15,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','1',''),(15,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','1',''),(15,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','1','');
/*!40000 ALTER TABLE `t_trackinglist_mainframe_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_mainframe_inspect`
--

DROP TABLE IF EXISTS `t_trackinglist_mainframe_inspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_mainframe_inspect` (
  `mainframe_id` int(11) NOT NULL COMMENT '主机装配流程跟踪单唯一标示',
  `selfcheck_name` varchar(100) DEFAULT NULL COMMENT '自检名称',
  `selfcheck_content` varchar(100) DEFAULT NULL COMMENT '自检内容',
  `selfcheck_result` varchar(50) DEFAULT NULL COMMENT '自检结果',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_mainframe_id` (`mainframe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机装配流程跟踪单送检记录表'
/*!50100 PARTITION BY HASH (mainframe_id)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_mainframe_inspect`
--

LOCK TABLES `t_trackinglist_mainframe_inspect` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_mainframe_inspect` DISABLE KEYS */;
INSERT INTO `t_trackinglist_mainframe_inspect` VALUES (13,'CASCADA I','10101010','',''),(14,'BOMA','11110000','CASCADA I',''),(15,'BOMA','11110000','CASCADA I','');
/*!40000 ALTER TABLE `t_trackinglist_mainframe_inspect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_preprocessing`
--

DROP TABLE IF EXISTS `t_trackinglist_preprocessing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_preprocessing` (
  `preprocessing_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `assemble_time` date DEFAULT NULL COMMENT '装配日期',
  `production_time` datetime DEFAULT NULL COMMENT '生产时间',
  `c_orderid` varchar(50) DEFAULT '' COMMENT '客户订单信息',
  `preprocessing_pn` varchar(50) DEFAULT NULL COMMENT '型号/PN',
  `serial_no` varchar(50) DEFAULT NULL COMMENT '序列号/Serial NO',
  `workorder_no` varchar(50) NOT NULL COMMENT '工单号/WO',
  `preprocessing_model` varchar(100) DEFAULT NULL COMMENT '名称/Model',
  `pt_option2` varchar(50) DEFAULT NULL COMMENT 'PT选配件/Option',
  `pt_option` varchar(50) DEFAULT NULL COMMENT 'PT选配件/Option',
  `exception_record` varchar(200) DEFAULT NULL COMMENT '异常记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  `assemble_Operator` varchar(20) DEFAULT NULL COMMENT '装配人员',
  `inspect_operator` varchar(20) DEFAULT NULL COMMENT '送检人员',
  `inspect_time` date DEFAULT NULL COMMENT '送检日期',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`preprocessing_id`,`input_time`),
  KEY `idx_assemble_time` (`assemble_time`),
  KEY `idx_c_orderid` (`c_orderid`),
  KEY `idx_preprocessing_pn` (`preprocessing_pn`),
  KEY `idx_serial_no` (`serial_no`),
  KEY `idx_workorder_no` (`workorder_no`),
  KEY `idx_preprocessing_model` (`preprocessing_model`)
) ENGINE=InnoDB AUTO_INCREMENT=1288 DEFAULT CHARSET=utf8 COMMENT='预处理装配流程跟踪单表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION p201802 VALUES LESS THAN (737091) ENGINE = InnoDB,
 PARTITION p201803 VALUES LESS THAN (737119) ENGINE = InnoDB,
 PARTITION p201804 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION p201805 VALUES LESS THAN (737180) ENGINE = InnoDB,
 PARTITION p201806 VALUES LESS THAN (737211) ENGINE = InnoDB,
 PARTITION p201807 VALUES LESS THAN (737241) ENGINE = InnoDB,
 PARTITION p201808 VALUES LESS THAN (737272) ENGINE = InnoDB,
 PARTITION p201809 VALUES LESS THAN (737303) ENGINE = InnoDB,
 PARTITION p201810 VALUES LESS THAN (737333) ENGINE = InnoDB,
 PARTITION p201811 VALUES LESS THAN (737364) ENGINE = InnoDB,
 PARTITION p201812 VALUES LESS THAN (737394) ENGINE = InnoDB,
 PARTITION p201901 VALUES LESS THAN (737425) ENGINE = InnoDB,
 PARTITION p201902 VALUES LESS THAN (737456) ENGINE = InnoDB,
 PARTITION p201903 VALUES LESS THAN (737484) ENGINE = InnoDB,
 PARTITION p201904 VALUES LESS THAN (737515) ENGINE = InnoDB,
 PARTITION p201905 VALUES LESS THAN (737545) ENGINE = InnoDB,
 PARTITION p201906 VALUES LESS THAN (737576) ENGINE = InnoDB,
 PARTITION p201907 VALUES LESS THAN (737606) ENGINE = InnoDB,
 PARTITION p201908 VALUES LESS THAN (737637) ENGINE = InnoDB,
 PARTITION p201909 VALUES LESS THAN (737668) ENGINE = InnoDB,
 PARTITION p201910 VALUES LESS THAN (737698) ENGINE = InnoDB,
 PARTITION p201911 VALUES LESS THAN (737729) ENGINE = InnoDB,
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB,
 PARTITION p202001 VALUES LESS THAN (737790) ENGINE = InnoDB,
 PARTITION p202002 VALUES LESS THAN (737821) ENGINE = InnoDB,
 PARTITION p202003 VALUES LESS THAN (737850) ENGINE = InnoDB,
 PARTITION p202004 VALUES LESS THAN (737881) ENGINE = InnoDB,
 PARTITION p202005 VALUES LESS THAN (737911) ENGINE = InnoDB,
 PARTITION p202006 VALUES LESS THAN (737942) ENGINE = InnoDB,
 PARTITION p202007 VALUES LESS THAN (737972) ENGINE = InnoDB,
 PARTITION p202008 VALUES LESS THAN (738003) ENGINE = InnoDB,
 PARTITION p202009 VALUES LESS THAN (738034) ENGINE = InnoDB,
 PARTITION p202010 VALUES LESS THAN (738064) ENGINE = InnoDB,
 PARTITION p202011 VALUES LESS THAN (738095) ENGINE = InnoDB,
 PARTITION p202012 VALUES LESS THAN (738125) ENGINE = InnoDB,
 PARTITION p202101 VALUES LESS THAN (738156) ENGINE = InnoDB,
 PARTITION p202102 VALUES LESS THAN (738187) ENGINE = InnoDB,
 PARTITION p202103 VALUES LESS THAN (738215) ENGINE = InnoDB,
 PARTITION p202104 VALUES LESS THAN (738246) ENGINE = InnoDB,
 PARTITION p202105 VALUES LESS THAN (738276) ENGINE = InnoDB,
 PARTITION p202106 VALUES LESS THAN (738307) ENGINE = InnoDB,
 PARTITION p202107 VALUES LESS THAN (738337) ENGINE = InnoDB,
 PARTITION p202108 VALUES LESS THAN (738368) ENGINE = InnoDB,
 PARTITION p202109 VALUES LESS THAN (738399) ENGINE = InnoDB,
 PARTITION p202110 VALUES LESS THAN (738429) ENGINE = InnoDB,
 PARTITION p202111 VALUES LESS THAN (738460) ENGINE = InnoDB,
 PARTITION p202112 VALUES LESS THAN (738490) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_preprocessing`
--

LOCK TABLES `t_trackinglist_preprocessing` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_preprocessing` DISABLE KEYS */;
INSERT INTO `t_trackinglist_preprocessing` VALUES (1280,'2018-09-23','2018-09-06 03:29:33','','LWFS32701PC','4444444','5677886','2342432','2. -C CM1','1. -P Raw Pump','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','sdas','asdas','2018-09-17',9,'2018-09-06 03:30:37','2018-09-06 03:30:37'),(1281,'2018-09-23','2018-09-06 03:29:33','','LWFS32701PC','4444444','5677886','2342432','2. -C CM1','1. -P Raw Pump','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','sdas','asdas','2018-09-17',9,'2018-09-06 03:30:42','2018-09-06 03:30:42'),(1287,'2018-09-28','2018-09-28 16:45:11','','LWFS32701C','撒发生','山东省','Pretreatment','是房地产商','水电费','','若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。','是非得失','',NULL,9,'2018-09-28 16:49:32','2018-11-27 11:28:51');
/*!40000 ALTER TABLE `t_trackinglist_preprocessing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_preprocessing_assemble`
--

DROP TABLE IF EXISTS `t_trackinglist_preprocessing_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_preprocessing_assemble` (
  `preprocessing_id` int(11) NOT NULL COMMENT '预处理装配流程跟踪单唯一标示',
  `component_name` varchar(100) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(100) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(50) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_preprocessing_id` (`preprocessing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预处理装配流程跟踪单装配记录表'
/*!50100 PARTITION BY HASH (preprocessing_id)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_preprocessing_assemble`
--

LOCK TABLES `t_trackinglist_preprocessing_assemble` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_preprocessing_assemble` DISABLE KEYS */;
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES (1280,'开关电源（预处理）|Power module (PT)','SP-75-24',NULL,'ddfd'),(1280,'源水增压泵|Raw water boost pump','EC-203-300ARS',NULL,''),(1280,'水质变送器|Water quality transducer','CM1源水电导仪|CM1 Raw water sensor',NULL,'dfdsf'),(1280,'水质变送器|Water quality transducer','1#电导变送器|1# Conductivity transducer',NULL,''),(1280,'预处理IO主板|PT module IO PCB','PT-IO PCB board',NULL,''),(1280,'预处理显示板|PT module display PCB','PT LCD PCB with LCD',NULL,'sdfs'),(1280,'PT减压阀|Pressure Regulator (feed water)','PRV-3-SH',NULL,'sdfs'),(1280,'常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）','-',NULL,'sdfs'),(1280,'低压开关|Pressure switch (feed water)','-',NULL,''),(1281,'开关电源（预处理）|Power module (PT)','SP-75-24',NULL,'ddfd'),(1281,'源水增压泵|Raw water boost pump','EC-203-300ARS',NULL,''),(1281,'水质变送器|Water quality transducer','CM1源水电导仪|CM1 Raw water sensor',NULL,'dfdsf'),(1281,'水质变送器|Water quality transducer','1#电导变送器|1# Conductivity transducer',NULL,''),(1281,'预处理IO主板|PT module IO PCB','PT-IO PCB board',NULL,''),(1281,'预处理显示板|PT module display PCB','PT LCD PCB with LCD',NULL,'sdfs'),(1281,'PT减压阀|Pressure Regulator (feed water)','PRV-3-SH',NULL,'sdfs'),(1281,'常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）','-',NULL,'sdfs'),(1281,'低压开关|Pressure switch (feed water)','-',NULL,''),(1287,'开关电源（预处理）|Power module (PT)','SP-75-24','胜多负少','是否'),(1287,'水质变送器|Water quality transducer','CM1源水电导仪|CM1 Raw water sensor','水电费','水电费'),(1287,'水质变送器|Water quality transducer','1#电导变送器 |1# Conductivity transducer','ereer',''),(1287,'预处理IO主板|PT module IO PCB','PT-IO PCB board','水电费',''),(1287,'预处理显示板|PT module display PCB','PT LCD PCB with LCD','ere',''),(1287,'PT减压阀|Pressure Regulator','PRV-3-SH','1_正确Yes|不正确No',''),(1287,'常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）','-','0_正确Yes|不正确No',''),(1287,'低压开关|Pressure switch (feed water)','-','0_正确Yes|不正确No','');
/*!40000 ALTER TABLE `t_trackinglist_preprocessing_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trackinglist_preprocessing_inspect`
--

DROP TABLE IF EXISTS `t_trackinglist_preprocessing_inspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trackinglist_preprocessing_inspect` (
  `preprocessing_id` int(11) NOT NULL COMMENT '预处理装配流程跟踪单唯一标示',
  `selfcheck_name` varchar(100) DEFAULT NULL COMMENT '自检名称',
  `selfcheck_content` varchar(100) DEFAULT NULL COMMENT '自检内容',
  `selfcheck_result` varchar(50) DEFAULT NULL COMMENT '自检结果',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_preprocessing_id` (`preprocessing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预处理装配流程跟踪单送检记录表'
/*!50100 PARTITION BY HASH (preprocessing_id)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trackinglist_preprocessing_inspect`
--

LOCK TABLES `t_trackinglist_preprocessing_inspect` WRITE;
/*!40000 ALTER TABLE `t_trackinglist_preprocessing_inspect` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_trackinglist_preprocessing_inspect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_accountloginlog`
--

DROP TABLE IF EXISTS `t_ums_accountloginlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_accountloginlog` (
  `ACCLOGINID` bigint(22) NOT NULL COMMENT 'id',
  `OPERATETIME` date NOT NULL COMMENT '操作时间',
  `ACCOUNT` varchar(30) NOT NULL COMMENT '登录名',
  `OPERATERESULT` int(2) NOT NULL COMMENT '操作结果',
  `FAILREASON` int(2) DEFAULT NULL COMMENT '结果原因',
  `LOGINIP` varchar(100) NOT NULL COMMENT '登陆ip',
  `RESULTDES` text COMMENT '描述',
  `OPERATORID` bigint(22) NOT NULL COMMENT '操作员id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_accountloginlog`
--

LOCK TABLES `t_ums_accountloginlog` WRITE;
/*!40000 ALTER TABLE `t_ums_accountloginlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ums_accountloginlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_acctivesessions`
--

DROP TABLE IF EXISTS `t_ums_acctivesessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_acctivesessions` (
  `activesessionid` bigint(22) NOT NULL AUTO_INCREMENT COMMENT '主键ＩＤ',
  `operatorid` int(11) NOT NULL COMMENT '操作员ＩＤ',
  `loginname` varchar(100) NOT NULL DEFAULT '' COMMENT '帐号',
  `logintime` datetime NOT NULL COMMENT '登陆时间',
  `loginip` varchar(20) DEFAULT NULL COMMENT '登陆ＩＰ',
  PRIMARY KEY (`activesessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会话表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_acctivesessions`
--

LOCK TABLES `t_ums_acctivesessions` WRITE;
/*!40000 ALTER TABLE `t_ums_acctivesessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ums_acctivesessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_admininfo`
--

DROP TABLE IF EXISTS `t_ums_admininfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_admininfo` (
  `OPERATORID` bigint(22) NOT NULL AUTO_INCREMENT COMMENT '操作员编号',
  `NAME` varchar(50) NOT NULL DEFAULT '' COMMENT '操作员名称',
  `ACCOUNT` varchar(30) NOT NULL DEFAULT '' COMMENT '登录名',
  `PASSWORD` varchar(100) DEFAULT '' COMMENT '登录密码 MD5加密后摘要',
  `SEX` varchar(6) DEFAULT NULL COMMENT '性别0为男，1为女',
  `POSITION` varchar(30) DEFAULT '' COMMENT '职务',
  `DEPTID` int(10) DEFAULT NULL COMMENT '部门',
  `MOBILE` varchar(20) DEFAULT '' COMMENT '手机',
  `EMAIL` varchar(100) DEFAULT NULL COMMENT '电子信箱',
  `GROUPLIST` varchar(200) DEFAULT '' COMMENT '角色组列表，以角色组ID以|并起',
  `PROVINCEID` varchar(50) DEFAULT '' COMMENT '省份代码',
  `OPERATORTYPE` int(3) NOT NULL COMMENT '2：CP；3：系统管理员4：客服管理员；5：CP操作员',
  `STATUS` int(3) NOT NULL DEFAULT '2' COMMENT '用户状态：1、暂停；2、正常；3、锁定；4、失效；5、删除',
  `UPDATEPWDFLAG` int(3) NOT NULL DEFAULT '1' COMMENT '管理员初次登陆需更改密码标记 0、不需要 1、需要更改',
  `CREATETIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATETIME` datetime DEFAULT NULL COMMENT '状态变更时间',
  PRIMARY KEY (`OPERATORID`),
  KEY `idx_uaa_account` (`ACCOUNT`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_admininfo`
--

LOCK TABLES `t_ums_admininfo` WRITE;
/*!40000 ALTER TABLE `t_ums_admininfo` DISABLE KEYS */;
INSERT INTO `t_ums_admininfo` VALUES (9,'超级管理员','admin','admin','1','',NULL,'13816763234','13434@1632',NULL,NULL,1,2,1,'2017-07-08 00:55:55','2018-09-28 10:42:35'),(20,'admin','test','admin','0','',NULL,'13816763233','13816763233@163.com','','',1,2,1,'2018-09-06 20:38:01','2018-09-06 20:43:49'),(21,'admin','zhuji','admin','0','',NULL,'13816763233','1213@163.com','','',1,2,1,'2018-09-20 01:02:22','2018-09-20 01:02:22'),(22,'admin','yuchuli','admin','0','',NULL,'13816763233','1213@163.com','','',1,2,1,'2018-09-20 01:02:46','2018-09-20 01:02:46'),(23,'admin','shuixiang','admin','0','',NULL,'13816763233','1213@163.com','','',1,2,1,'2018-09-20 01:03:06','2018-09-28 11:35:37'),(24,'admin','dspl','admin','0','',NULL,'13816763233','1213@163.com','','',1,2,1,'2018-09-20 01:03:36','2018-09-28 13:59:54'),(25,'admin','peizhi','admin','0','',NULL,'13816763233','1213@163.com','','',1,2,1,'2018-09-20 01:03:57','2018-09-20 01:03:57'),(26,'admin','genzhong','admin','0','',NULL,'13816763233','1213@163.com','','',1,2,1,'2018-09-20 01:04:07','2018-09-28 10:44:25'),(27,'admin','chaoji','admin','0','',NULL,'13816763233','1213@163.com','','',1,2,1,'2018-09-20 01:04:16','2018-09-28 10:43:18');
/*!40000 ALTER TABLE `t_ums_admininfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_config`
--

DROP TABLE IF EXISTS `t_ums_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_config` (
  `CONFIGID` int(11) NOT NULL COMMENT '配置项编号',
  `CONFIGNAME` varchar(100) NOT NULL COMMENT '配置项名称',
  `CONFIGTYPE` int(2) NOT NULL COMMENT '配置项子系统类型：1-PUBLIC;2-polish;3-clean;',
  `CONFIGVALUE` text COMMENT '配置项取值',
  `CONFIGEXPRESSION` varchar(250) DEFAULT NULL COMMENT '配置项正则表达式',
  `ALLOWMODIFY` int(2) NOT NULL COMMENT '否可以修改：1-可以更改；2-不可以更改',
  `DESCRIPTION` text COMMENT '配置项描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_config`
--

LOCK TABLES `t_ums_config` WRITE;
/*!40000 ALTER TABLE `t_ums_config` DISABLE KEYS */;
INSERT INTO `t_ums_config` VALUES (83,'paging/pagesize',1,'10',NULL,2,'系统默认分页大小'),(3,'excel/export/records/limits',1,'100000',NULL,2,'excel结果集导出最大限制数'),(32,'default/root/menuid',1,'-1',NULL,2,'默认根节点菜单id'),(33,'default/root/roleid',1,'-1',NULL,2,'分页默认角色根节点id'),(35,'dataconfig/type/list',1,'1',NULL,2,'数据配置表代表基础数据配置列表类型'),(100,'tracklinglist/dsp/menuid',1,'401',NULL,2,'DSP装配流程跟踪单流程菜单id'),(101,'tracklinglist/cistern/menuid',1,'402',NULL,2,' 水箱装配流程跟踪单流程菜单id'),(102,'tracklinglist/preprocessing/menuid',1,'403',NULL,2,'预处理装配流程跟踪单流程菜单id'),(103,'tracklinglist/mainFrame/menuid',1,'404',NULL,2,'主机装配流程跟踪单流程菜单id'),(104,'tracklinglist/dsp/tablename',1,'dspTable401',NULL,2,'DSP装配流程跟踪单流程配置表名'),(105,'tracklinglist/cistern/tablename',1,'cisternTable402',NULL,2,'水箱装配流程跟踪单流程配置表名'),(106,'tracklinglist/preprocessing/tablename',1,'preprocessingTable403',NULL,2,'预处理装配流程跟踪单流程配置表名'),(107,'tracklinglist/mainFrame/tablename',1,'mainframeTable404',NULL,2,'主机装配流程跟踪单流程配置表名'),(108,'trackinglist/preprocessing/download/subdirectory',1,'preprocessing',NULL,2,'预处理装配流程跟踪单流程下载子目录名称'),(109,'tracklinglist/preprocessing/templatename',1,'preprocessingTemplate403',NULL,2,' 预处理装配流程跟踪单流程导出模板'),(109,'tracklinglist/mainFrame/templatename',1,'mainframeTemplate404',NULL,2,'主机装配流程跟踪单流程导出模板'),(110,'trackinglist/mainFrame/download/subdirectory',1,'mainFrame',NULL,2,'主机装配流程跟踪单流程下载子目录名称'),(111,'tracklinglist/dsp/templatename',1,'dspTemplate401',NULL,2,'DSP装配流程跟踪单流程导出模板'),(112,'trackinglist/dsp/download/subdirectory',1,'dsp',NULL,2,NULL),(113,'tracklinglist/cistern/templatename',1,'cisternTemplate402',NULL,2,'水箱装配流程跟踪单流程导出模板'),(114,'trackinglist/cistern/download/subdirectory',1,'cistern',NULL,2,'水箱装配流程跟踪单流程下载子目录名称'),(82,'right/button/righttype',1,'2',NULL,2,'权限表中button对应的righttype'),(4,'right/menu/righttype',1,'1',NULL,2,'权限表中menu对应的righttype'),(115,'setting/dsp/dataconfig/type/dspModel',1,'48',NULL,2,'DSP配置_DSP型号/Model'),(116,'setting/cistern/dataconfig/type/cisternModel',1,'49',NULL,2,'水箱配置_水箱型号/Model'),(117,'setting/preprocessing/dataconfig/type/preprocessingModel',1,'50',NULL,2,'预处理配置_名称/Model'),(118,'setting/mainframe/dataconfig/type/mainframeModel',1,'51',NULL,2,'主机_主机型号/Model');
/*!40000 ALTER TABLE `t_ums_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_data_button`
--

DROP TABLE IF EXISTS `t_ums_data_button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_data_button` (
  `btnID` int(4) NOT NULL COMMENT '按钮编号',
  `Menuid` int(4) NOT NULL COMMENT '菜单编号',
  `BTNNAME` varchar(100) DEFAULT NULL COMMENT '按钮名称',
  `BTNCNAME` varchar(100) DEFAULT NULL COMMENT '中文名称',
  `BTNCLASS` varchar(50) DEFAULT NULL COMMENT '按钮样式',
  `iconclass` varchar(50) DEFAULT NULL,
  `BTNTYPE` int(1) NOT NULL COMMENT '按钮类型 1 普通 2 table  3 table row',
  `SORT` int(4) NOT NULL COMMENT '同级菜单顺序',
  `DESCRIPTION` text COMMENT '描述信息',
  PRIMARY KEY (`btnID`,`Menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按钮权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_data_button`
--

LOCK TABLES `t_ums_data_button` WRITE;
/*!40000 ALTER TABLE `t_ums_data_button` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ums_data_button` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_data_config`
--

DROP TABLE IF EXISTS `t_ums_data_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_data_config` (
  `DATAID` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据id',
  `DATATYPE` int(3) NOT NULL COMMENT '数据类型',
  `configname` varchar(50) DEFAULT NULL COMMENT '标题',
  `DESCRIPTION` varchar(255) DEFAULT '' COMMENT '描述信息',
  `operatorid` int(11) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`DATAID`),
  KEY `idx_udc_config_datatype_configname` (`DATATYPE`,`configname`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='数据字典配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_data_config`
--

LOCK TABLES `t_ums_data_config` WRITE;
/*!40000 ALTER TABLE `t_ums_data_config` DISABLE KEYS */;
INSERT INTO `t_ums_data_config` VALUES (48,1,'DSP配置_DSP型号/Model','',9,NULL,NULL),(49,1,'水箱配置_水箱型号/Model','',9,NULL,NULL),(50,1,'预处理配置_名称/Model','',9,NULL,NULL),(51,1,'主机_主机型号/Model','',9,NULL,NULL),(64,48,'远程取水站 I 级水      DSP With Station Type I','',9,'2018-09-26 16:32:20','2018-09-26 16:32:20'),(65,48,'远程取水站 II 级水      DSP With Station Type II','',9,'2018-09-26 16:33:04','2018-09-26 16:33:04'),(66,48,'远程取水站 III级水      DSP With Station Type III','',9,'2018-09-26 16:33:58','2018-09-26 16:33:58'),(67,48,'灵活取水手柄 I 级水     Flexible DSP Type I','',9,'2018-09-26 16:35:02','2018-09-26 16:35:02'),(68,48,'灵活取水手柄 II 级水     Flexible DSP Type II','',9,'2018-09-26 16:35:55','2018-09-26 16:35:55'),(69,48,'灵活取水手柄 III 级水     Flexible DSP Type III','',9,'2018-09-26 16:36:59','2018-09-26 16:36:59'),(70,50,'Pretreatment','',9,'2018-09-26 16:38:45','2018-09-26 16:38:45'),(71,49,'PE Reservoir 35 L','',9,'2018-09-26 16:46:37','2018-09-26 16:46:37'),(72,49,'Cascada II.I','',9,'2018-09-26 16:47:30','2018-09-26 16:47:30'),(73,51,'Cascada III','',9,'2018-09-26 16:51:57','2018-09-26 16:51:57'),(74,51,'Cascada I','',9,'2018-09-26 16:52:19','2018-09-26 16:52:19'),(75,51,'Cascada II.I','',9,'2018-09-26 16:52:32','2018-09-26 16:52:32'),(78,51,'Cascada III.I','',9,'2018-10-22 15:08:23','2018-10-22 15:08:55');
/*!40000 ALTER TABLE `t_ums_data_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_deptinfo`
--

DROP TABLE IF EXISTS `t_ums_deptinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_deptinfo` (
  `DEPTID` int(11) NOT NULL COMMENT '部门编号',
  `DEPTNAME` varchar(30) DEFAULT NULL COMMENT '部门名称',
  `DEPTLEVEL` varchar(20) DEFAULT NULL COMMENT '部门级别（填写一级、二级之类的文字信息）',
  `EMPNUMBER` varchar(20) DEFAULT NULL COMMENT '员工数量',
  `CONTACT` varchar(32) DEFAULT NULL COMMENT '联系人',
  `PHONE` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `EMAIL` varchar(100) DEFAULT NULL COMMENT '电子信箱',
  `DESCRIPTION` text COMMENT '描述信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_deptinfo`
--

LOCK TABLES `t_ums_deptinfo` WRITE;
/*!40000 ALTER TABLE `t_ums_deptinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ums_deptinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_loginlimitinfo`
--

DROP TABLE IF EXISTS `t_ums_loginlimitinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_loginlimitinfo` (
  `LIMITID` bigint(22) NOT NULL COMMENT 'id',
  `ACCOUNT` varchar(30) DEFAULT NULL COMMENT '帐号名',
  `LIMITSTARTTIME` datetime DEFAULT NULL COMMENT '限制登录开始时间',
  `LIMITENDTIME` datetime DEFAULT NULL COMMENT '限制登录结束时间',
  `LIMITIP` text COMMENT '受限ip串',
  `OPERATORID` bigint(22) NOT NULL COMMENT '操作员编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帐号受限信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_loginlimitinfo`
--

LOCK TABLES `t_ums_loginlimitinfo` WRITE;
/*!40000 ALTER TABLE `t_ums_loginlimitinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ums_loginlimitinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_menu_button`
--

DROP TABLE IF EXISTS `t_ums_menu_button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_menu_button` (
  `btnid` int(4) NOT NULL AUTO_INCREMENT COMMENT '按钮编号',
  `menuid` int(4) NOT NULL COMMENT '菜单编号',
  `btnename` varchar(100) DEFAULT '' COMMENT '按钮名称',
  `btncname` varchar(100) DEFAULT '' COMMENT '中文名称',
  `btnclass` varchar(50) DEFAULT '' COMMENT '按钮样式',
  `btniconclass` varchar(50) DEFAULT '',
  `DESCRIPTION` text COMMENT '描述信息',
  PRIMARY KEY (`btnid`,`menuid`),
  KEY `idx_umb_button_menuid_btnename` (`menuid`,`btnename`)
) ENGINE=InnoDB AUTO_INCREMENT=2032 DEFAULT CHARSET=utf8 COMMENT='按钮权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_menu_button`
--

LOCK TABLES `t_ums_menu_button` WRITE;
/*!40000 ALTER TABLE `t_ums_menu_button` DISABLE KEYS */;
INSERT INTO `t_ums_menu_button` VALUES (2000,401,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(2001,401,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(2002,401,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(2003,401,'exportRow','导出','btn btn-primary btn-sm','fa fa-download',NULL),(2004,401,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(2005,401,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(2006,401,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(2007,401,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(2008,402,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(2009,402,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(2010,402,'exportRow','导出','btn btn-primary btn-sm','fa fa-download',NULL),(2011,402,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(2012,402,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(2013,402,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(2014,402,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(2015,402,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(2016,403,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(2017,403,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(2018,403,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(2019,403,'exportRow','导出','btn btn-primary btn-sm','fa fa-download',NULL),(2020,403,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(2021,403,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(2022,403,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(2023,403,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(2024,404,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(2025,404,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(2026,404,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(2027,404,'exportRow','导出','btn btn-primary btn-sm','fa fa-download',NULL),(2028,404,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(2029,404,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(2030,404,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(2031,404,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL);
/*!40000 ALTER TABLE `t_ums_menu_button` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_menuinfo`
--

DROP TABLE IF EXISTS `t_ums_menuinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_menuinfo` (
  `MENUID` int(4) NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `MENUNAME` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `MENUICON` varchar(100) DEFAULT NULL COMMENT '菜单图标',
  `MENUURL` varchar(100) DEFAULT NULL COMMENT '菜单路径',
  `LEAF` int(1) NOT NULL COMMENT '叶子节点与否 1叶子节点 0目录',
  `DISABLED` int(1) NOT NULL COMMENT '节点是否可用 0可用 1不可用',
  `PMENUID` int(4) NOT NULL COMMENT '父菜单编号',
  `SORT` int(4) NOT NULL COMMENT '同级菜单顺序',
  `DESCRIPTION` varchar(300) DEFAULT '' COMMENT '描述信息',
  PRIMARY KEY (`MENUID`)
) ENGINE=InnoDB AUTO_INCREMENT=505 DEFAULT CHARSET=utf8 COMMENT='菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_menuinfo`
--

LOCK TABLES `t_ums_menuinfo` WRITE;
/*!40000 ALTER TABLE `t_ums_menuinfo` DISABLE KEYS */;
INSERT INTO `t_ums_menuinfo` VALUES (1,'基础管理','menu-icon glyphicon glyphicon-cog',NULL,0,0,-1,1,NULL),(4,'水机跟踪管理','menu-icon glyphicon glyphicon-tint',NULL,0,0,-1,5,''),(5,'水机配置管理','menu-icon glyphicons\r\nglyphicon glyphicon-asterisk',NULL,0,0,-1,4,''),(101,'权限管理','胜多负少',NULL,1,1,1,1,''),(102,'用户管理','\r\nmenu-icon glyphicon glyphicon-user','/user/userManage',1,0,1,2,NULL),(103,'角色管理','menu-icon glyphicon glyphicon-asterisk','/role/roleManage',1,1,1,3,NULL),(104,'权限配置管理','menu-icon glyphicons \r\nglyphicons-user','/right/rightManage',1,1,1,4,NULL),(105,'菜单管理','menu-icon glyphicon glyphicon-eye-open','/menu/menuManage',1,1,1,5,NULL),(107,'数据配置管理','menu-icon glyphicon glyphicons-settings','/dataconfig/dataConfigManage',1,0,1,7,NULL),(108,'按钮管理','menu-icon glyphicon glyphicon-eye-open','/button/buttonManage',1,1,1,8,''),(401,'DSP装配流程跟踪单','menu-icon glyphicons\r\nglyphicons-hand-right','/trackinglist/dspManage',1,0,4,1,''),(402,'水箱装配流程跟踪单','menu-icon glyphicons\r\nglyphicons-hand-right','/trackinglist/cisternManage',1,0,4,2,''),(403,'预处理装配流程跟踪单','menu-icon glyphicons\r\nglyphicons-hand-right','/trackinglist/preprocessingManage',1,0,4,3,''),(404,'主机装配流程跟踪单','menu-icon glyphicons\r\nglyphicons-hand-right','/trackinglist/mainframeManage',1,0,4,4,''),(501,'DSP配置','menu-icon glyphicons\r\nglyphicons-hand-right','/setting/dspSetting',1,0,5,1,''),(502,'水箱配置','menu-icon glyphicons\r\nglyphicons-hand-right','/setting/cisternSetting',1,0,5,2,''),(503,'预处理配置','menu-icon glyphicons\r\nglyphicons-hand-right','/setting/preprocessingSetting',1,0,5,3,''),(504,'主机配置','menu-icon glyphicons\r\nglyphicons-hand-right','/setting/mainframeSetting',1,0,5,4,'');
/*!40000 ALTER TABLE `t_ums_menuinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_provinceinfo`
--

DROP TABLE IF EXISTS `t_ums_provinceinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_provinceinfo` (
  `PROVINCEID` varchar(50) NOT NULL COMMENT '省份编码',
  `PROVINCENAME` varchar(50) NOT NULL COMMENT '省名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省份信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_provinceinfo`
--

LOCK TABLES `t_ums_provinceinfo` WRITE;
/*!40000 ALTER TABLE `t_ums_provinceinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ums_provinceinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_right`
--

DROP TABLE IF EXISTS `t_ums_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_right` (
  `RIGHTID` int(10) NOT NULL AUTO_INCREMENT COMMENT '权限编码',
  `RIGHTTYPE` int(2) NOT NULL COMMENT '权限类型  1 菜单权限',
  `DATAID` int(4) NOT NULL COMMENT '数据权限id,如权限类型为菜单，则dataid则为菜单id，依次类推',
  `DESCRIPTION` text COMMENT '浏览按钮权限描述',
  PRIMARY KEY (`RIGHTID`),
  KEY `idx_ur_right_righttype_dataid` (`RIGHTTYPE`,`DATAID`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COMMENT='权限信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_right`
--

LOCK TABLES `t_ums_right` WRITE;
/*!40000 ALTER TABLE `t_ums_right` DISABLE KEYS */;
INSERT INTO `t_ums_right` VALUES (1,1,1,NULL),(2,1,2,NULL),(3,1,101,NULL),(4,1,102,NULL),(5,1,103,NULL),(6,1,104,NULL),(7,1,105,NULL),(9,1,107,NULL),(10,1,108,NULL),(100,1,4,NULL),(101,1,401,NULL),(102,1,402,NULL),(103,1,403,NULL),(104,1,404,NULL),(110,1,5,NULL),(111,1,501,NULL),(112,1,502,NULL),(113,1,503,NULL),(114,1,504,NULL),(124,2,2000,NULL),(125,2,2001,NULL),(126,2,2002,NULL),(127,2,2003,NULL),(128,2,2004,NULL),(129,2,2005,NULL),(130,2,2006,NULL),(131,2,2007,NULL),(132,2,2008,NULL),(133,2,2009,NULL),(134,2,2010,NULL),(135,2,2011,NULL),(136,2,2012,NULL),(137,2,2013,NULL),(138,2,2014,NULL),(139,2,2015,NULL),(140,2,2016,NULL),(141,2,2017,NULL),(142,2,2018,NULL),(143,2,2019,NULL),(144,2,2020,NULL),(145,2,2021,NULL),(146,2,2022,NULL),(147,2,2023,NULL),(148,2,2024,NULL),(149,2,2025,NULL),(150,2,2026,NULL),(151,2,2027,NULL),(152,2,2028,NULL),(153,2,2029,NULL),(154,2,2030,NULL),(155,2,2031,NULL);
/*!40000 ALTER TABLE `t_ums_right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_role`
--

DROP TABLE IF EXISTS `t_ums_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_role` (
  `ROLEID` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `ROLENAME` varchar(60) DEFAULT '' COMMENT '角色名',
  `PROLEID` int(10) DEFAULT NULL,
  `DESCRIPTION` varchar(400) DEFAULT '' COMMENT '角色描述语言值',
  PRIMARY KEY (`ROLEID`),
  KEY `idx_ur_role_rolename` (`ROLENAME`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8 COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_role`
--

LOCK TABLES `t_ums_role` WRITE;
/*!40000 ALTER TABLE `t_ums_role` DISABLE KEYS */;
INSERT INTO `t_ums_role` VALUES (1,'超级角色',-1,''),(4,'饮水机跟踪管理',-1,''),(5,'饮水机配置管理',-1,''),(117,'DSP装配流程_查询',NULL,''),(118,'DSP装配流程_添加',NULL,''),(119,'DSP装配流程_批量删除',NULL,''),(120,'DSP装配流程_导出',NULL,''),(121,'DSP装配流程_刷新',NULL,''),(122,'DSP装配流程_复制',NULL,''),(123,'DSP装配流程_修改',NULL,''),(124,'DSP装配流程_删除',NULL,''),(125,'水箱装配流程_查询',NULL,''),(126,'水箱装配流程_添加',NULL,''),(127,'水箱装配流程_批量删除',NULL,''),(128,'水箱装配流程_导出',NULL,''),(129,'水箱装配流程_刷新',NULL,''),(130,'水箱装配流程_复制',NULL,''),(131,'水箱装配流程_修改',NULL,''),(132,'水箱装配流程_删除',NULL,''),(133,'预处理装配流程_查询',NULL,''),(134,'预处理装配流程_添加',NULL,''),(135,'预处理装配流程_批量删除',NULL,''),(136,'预处理装配流程_导出',NULL,''),(137,'预处理装配流程_刷新',NULL,''),(138,'预处理装配流程_复制',NULL,''),(139,'预处理装配流程_修改',NULL,''),(140,'预处理装配流程_删除',NULL,''),(141,'主机装配流程_查询',NULL,''),(142,'主机装配流程_添加',NULL,''),(143,'主机装配流程_批量删除',NULL,''),(144,'主机装配流程_导出',NULL,''),(145,'主机装配流程_刷新',NULL,''),(146,'主机装配流程_复制',NULL,''),(147,'主机装配流程_修改',NULL,''),(148,'主机装配流程_删除',NULL,'');
/*!40000 ALTER TABLE `t_ums_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_rolepermission`
--

DROP TABLE IF EXISTS `t_ums_rolepermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_rolepermission` (
  `RIGHTID` int(10) NOT NULL COMMENT '权限编码',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码',
  KEY `idx_ur_rolepermission_rightid` (`RIGHTID`),
  KEY `idx_ur_rolepermission_roleid` (`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与权限对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_rolepermission`
--

LOCK TABLES `t_ums_rolepermission` WRITE;
/*!40000 ALTER TABLE `t_ums_rolepermission` DISABLE KEYS */;
INSERT INTO `t_ums_rolepermission` VALUES (2,1),(3,1),(4,1),(5,1),(8,1),(9,1),(17,1),(12,1),(15,1),(10,1),(11,1),(13,1),(14,1),(16,1),(7,1),(18,1),(19,1),(20,1),(38,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,1),(60,1),(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(76,1),(77,1),(78,1),(79,1),(80,1),(81,1),(82,1),(83,1),(84,1),(85,1),(86,1),(87,1),(88,1),(89,1),(90,1),(91,1),(92,1),(93,1),(21,1),(100,1),(101,1),(102,1),(103,1),(104,1),(110,1),(111,1),(112,1),(113,1),(114,1),(100,4),(101,4),(102,4),(103,4),(104,4),(110,5),(111,5),(112,5),(113,5),(114,5),(1,1),(138,1),(139,1),(140,1),(141,1),(142,1),(143,1),(144,1),(145,1),(146,1),(147,1),(148,1),(149,1),(150,1),(151,1),(152,1),(153,1),(124,1),(125,1),(126,1),(127,1),(128,1),(129,1),(130,1),(131,1),(132,1),(133,1),(134,1),(135,1),(136,1),(137,1),(154,1),(155,1),(124,4),(125,4),(126,4),(127,4),(128,4),(129,4),(130,4),(131,4),(132,4),(133,4),(134,4),(135,4),(136,4),(137,4),(138,4),(139,4),(140,4),(141,4),(142,4),(143,4),(144,4),(145,4),(146,4),(147,4),(148,4),(149,4),(150,4),(151,4),(152,4),(153,4),(154,4),(155,4),(124,117),(125,118),(126,119),(127,120),(129,121),(128,122),(130,123),(131,124),(132,125),(133,126),(136,127),(134,128),(137,129),(135,130),(138,131),(139,132),(140,133),(141,134),(142,135),(143,136),(144,137),(145,138),(146,139),(147,140),(148,141),(149,142),(150,143),(151,144),(152,145),(153,146),(154,147),(155,148),(100,117),(100,118),(100,119),(100,120),(100,121),(100,122),(100,123),(100,124),(100,125),(100,126),(100,127),(100,128),(100,129),(100,130),(100,131),(100,132),(100,133),(100,134),(100,135),(100,136),(100,137),(100,138),(100,139),(100,140),(100,141),(100,142),(100,143),(100,144),(100,145),(100,146),(100,147),(100,148),(101,123),(101,124),(101,121),(101,122),(101,120),(101,119),(101,117),(101,118),(104,147),(104,148),(104,145),(104,146),(104,144),(104,143),(104,141),(104,142),(102,131),(102,132),(102,129),(102,130),(102,128),(102,127),(102,125),(102,126),(103,139),(103,140),(103,137),(103,138),(103,136),(103,135),(103,133),(103,134);
/*!40000 ALTER TABLE `t_ums_rolepermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_cistern`
--

DROP TABLE IF EXISTS `t_ums_setting_cistern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_cistern` (
  `csid` int(11) NOT NULL AUTO_INCREMENT COMMENT '水箱配置表唯一标示',
  `cistern_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `cistern_model` varchar(100) DEFAULT NULL,
  `cistern_option` varchar(100) DEFAULT NULL,
  `cistern_option2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`csid`),
  KEY `idx_cistern_pn` (`cistern_pn`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='水箱配置记录表'
/*!50100 PARTITION BY HASH (csid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_cistern`
--

LOCK TABLES `t_ums_setting_cistern` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_cistern` DISABLE KEYS */;
INSERT INTO `t_ums_setting_cistern` VALUES (18,'LWFS32401',9,'2018-09-26 17:14:11','2018-09-26 17:14:11',NULL,NULL,NULL),(19,'LWFS32401R',9,'2018-09-26 17:16:27','2018-09-26 17:16:27',NULL,NULL,NULL),(20,'LWFS32401S',9,'2018-09-26 17:19:42','2018-09-26 17:19:42',NULL,NULL,NULL),(21,'LWFS32402',9,'2018-10-23 14:35:44','2018-10-23 14:41:22',NULL,NULL,NULL),(22,'LWFS32402R',9,'2018-10-23 14:41:36','2018-10-23 14:46:01',NULL,NULL,NULL),(23,'LWFS32402S',9,'2018-10-23 14:46:41','2018-10-23 14:49:50',NULL,NULL,NULL),(24,'LWFS32402SR',9,'2018-10-23 14:50:37','2018-10-23 14:56:53',NULL,NULL,NULL),(25,'LWFS32401SR',9,'2018-10-23 14:58:46','2018-10-23 15:01:01',NULL,NULL,NULL),(26,'LWFS32403',9,'2018-10-23 15:01:21','2018-10-23 15:02:33',NULL,NULL,NULL),(27,'LWFS32403R',9,'2018-10-23 15:02:51','2018-10-23 15:03:32',NULL,NULL,NULL),(28,'LWFS32403S',9,'2018-10-23 15:03:59','2018-10-23 15:05:51',NULL,NULL,NULL),(29,'LWFS32403SR',9,'2018-10-23 15:06:02','2018-10-23 15:07:38',NULL,NULL,NULL),(30,'asrfsrwe',9,'2018-11-22 14:53:47','2018-11-22 14:53:47','Cascada II.I','werwe','werwe'),(31,'asrfsrwewerw',9,'2018-11-22 14:53:54','2018-11-22 14:53:58','Cascada II.I','werwe','werwe');
/*!40000 ALTER TABLE `t_ums_setting_cistern` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_cistern_assemble`
--

DROP TABLE IF EXISTS `t_ums_setting_cistern_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_cistern_assemble` (
  `csid` int(11) NOT NULL COMMENT '水箱配置表唯一标示',
  `component_name` varchar(200) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(200) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(100) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_cid` (`csid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='水箱配置装配表'
/*!50100 PARTITION BY HASH (csid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_cistern_assemble`
--

LOCK TABLES `t_ums_setting_cistern_assemble` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_cistern_assemble` DISABLE KEYS */;
INSERT INTO `t_ums_setting_cistern_assemble` VALUES (18,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(18,'底部密封方式|Bottem Sealing Element','堵头/Stopper ','正确Yes|不正确No',''),(18,'水箱盖密封类型|Tank Cap','硅胶塞/Silicone cover','正确Yes|不正确No',''),(18,'液位杆|Tank Level Sensor','35L航空插液位杆/Level Sensor 35L','正确Yes|不正确No',''),(19,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(19,'底部密封方式|Bottem Sealing Element','0.1 电极/0.1 Conductivity Probe','',''),(19,'水箱盖密封类型|Tank Cap','硅胶塞/Silicone cover','正确Yes|不正确No',''),(19,'液位杆|Tank Level Sensor','35L航空插液位杆/Level Sensor 35L','',''),(20,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(20,'底部密封方式|Bottem Sealing Element','堵头/Stopper Probe','正确Yes|不正确No',''),(20,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','正确Yes|不正确No',''),(20,'整流器控制盒 Waterproof ballast box','---','有 Yes|无 No',''),(20,'液位杆|Tank Level Sensor','35L航空插液位杆/Level Sensor 35L','正确Yes|不正确No',''),(21,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(21,'底部密封方式|Bottem Sealing Element','堵头/Stopper ','正确Yes|不正确No',''),(21,'水箱盖密封类型|Tank Cap','硅胶塞/Silicone cover','正确Yes|不正确No',''),(21,'液位杆|Tank Level Sensor','70L航空插液位杆/Level Sensor 70L','正确Yes|不正确No',''),(22,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(22,'底部密封方式|Bottem Sealing Element','0.1电极/0.1 Conductivity Probe','Serial NO:',''),(22,'水箱盖密封类型|Tank Cap','硅胶塞/Silicone cover','正确Yes|不正确No',''),(22,'液位杆|Tank Level Sensor','70L航空插液位杆/Level Sensor 70L','',''),(23,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(23,'底部密封方式|Bottem Sealing Element','堵头/Stopper ','正确Yes|不正确No',''),(23,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','正确Yes|不正确No',''),(23,'整流器控制盒 Waterproof ballast box','---','有 Yes|无 No',''),(23,'液位杆|Tank Level Sensor','70L航空插液位杆/Level Sensor 70L','正确Yes|不正确No',''),(24,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(24,'底部密封方式|Bottem Sealing Element','0.1电极/0.1 Conductivity Probe','Serial NO:',''),(24,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','正确Yes|不正确No',''),(24,'整流器控制盒 Waterproof ballast box','---','有 Yes|无 No',''),(24,'紫外灯（4W-L) UV lamp (4w-l)','紫外灯包装好装入纸筒 UV Lamp Packaging','合格Pass|不合格Fail',''),(24,'液位杆|Tank Level Sensor','70L航空插液位杆/Level Sensor 70L','正确Yes|不正确No',''),(25,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(25,'底部密封方式|Bottem Sealing Element','0.1电极/0.1 Conductivity Probe','Serial NO:',''),(25,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','正确Yes|不正确No',''),(25,'整流器控制盒 Waterproof ballast box','---','有 Yes|无 No',''),(25,'紫外灯（4W-L) UV lamp (4w-l)','紫外灯包装好装入纸筒 UV Lamp Packaging','合格Pass|不合格Fail',''),(25,'液位杆|Tank Level Sensor','35L航空插液位杆/Level Sensor 35L','',''),(26,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(26,'底部密封方式|Bottem Sealing Element','堵头/Stopper ','正确Yes|不正确No',''),(26,'水箱盖密封类型|Tank Cap','硅胶塞/Silicone cover','正确Yes|不正确No',''),(26,'液位杆|Tank Level Sensor','105L航空插液位杆/Level Sensor 105L','正确Yes|不正确No',''),(27,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(27,'底部密封方式|Bottem Sealing Element','0.1电极/0.1 Conductivity Probe','Serial NO:',''),(27,'水箱盖密封类型|Tank Cap','硅胶塞/Silicone cover','正确Yes|不正确No',''),(27,'液位杆|Tank Level Sensor','105L航空插液位杆/Level Sensor 105L','',''),(28,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(28,'底部密封方式|Bottem Sealing Element','堵头/Stopper ','正确Yes|不正确No',''),(28,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','正确Yes|不正确No',''),(28,'整流器控制盒 Waterproof ballast box','---','有 Yes|无 No',''),(28,'液位杆|Tank Level Sensor','105L航空插液位杆/Level Sensor 105L','正确Yes|不正确No',''),(29,'PE手动球阀|PE manual valve（3/8\"）','球阀开关方向是否一致|Direction of PE manual valve','正确Yes|不正确No',''),(29,'底部密封方式|Bottem Sealing Element','0.1电极/0.1 Conductivity Probe','Serial NO:',''),(29,'水箱盖密封类型|Tank Cap','石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止','正确Yes|不正确No',''),(29,'整流器控制盒 Waterproof ballast box','---','有 Yes|无 No',''),(29,'紫外灯（4W-L) UV lamp (4w-l)','紫外灯包装好装入纸筒 UV Lamp Packaging','合格Pass|不合格Fail',''),(29,'液位杆|Tank Level Sensor','105L航空插液位杆/Level Sensor 105L','正确Yes|不正确No',''),(30,'werwe','werwe','rwew','werwe'),(31,'werwe','werwewerw','rwew','werwe');
/*!40000 ALTER TABLE `t_ums_setting_cistern_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_dsp`
--

DROP TABLE IF EXISTS `t_ums_setting_dsp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_dsp` (
  `dsid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'DSP配置表唯一标示',
  `dsp_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `dsp_model` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`dsid`),
  KEY `idx_dsp_pn` (`dsp_pn`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='DSP配置记录表'
/*!50100 PARTITION BY HASH (dsid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_dsp`
--

LOCK TABLES `t_ums_setting_dsp` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_dsp` DISABLE KEYS */;
INSERT INTO `t_ums_setting_dsp` VALUES (2,'LWFS32601',9,'2018-09-26 16:58:18','2018-09-26 17:08:54',NULL),(3,'LWFS32602',9,'2018-09-26 16:59:52','2018-09-26 17:09:03',NULL),(4,'LWFS32603',9,'2018-09-26 17:00:39','2018-09-26 17:09:11',NULL),(5,'LWFS32604',9,'2018-09-26 17:03:00','2018-09-26 17:03:00',NULL),(6,'LWFS32605',9,'2018-09-26 17:07:55','2018-09-26 17:07:55',NULL),(7,'LWFS32606',9,'2018-09-26 17:07:59','2018-09-26 17:07:59',NULL);
/*!40000 ALTER TABLE `t_ums_setting_dsp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_dsp_assemble`
--

DROP TABLE IF EXISTS `t_ums_setting_dsp_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_dsp_assemble` (
  `dsid` int(11) NOT NULL COMMENT 'DSP配置表唯一标示',
  `component_name` varchar(200) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(200) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(100) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_dsid` (`dsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DSP配置装配表'
/*!50100 PARTITION BY HASH (dsid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_dsp_assemble`
--

LOCK TABLES `t_ums_setting_dsp_assemble` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_dsp_assemble` DISABLE KEYS */;
INSERT INTO `t_ums_setting_dsp_assemble` VALUES (2,'滚轮与IO板配合|Dispenser roller and IO board Assembly','滚动阻尼及微动开关|Roll damping and micro switch','合格 Pass|不合格 Fail',''),(2,'IO板接线线序|IO Board Wring ','线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring','合格 Pass|不合格 Fail',''),(2,'FFC排线|FFC cable','FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable','合格 Pass|不合格 Fail',''),(2,'DSP手柄圆形挂件|Dispenser holder','是否漏装及方向是否正确|direction','合格 Pass|不合格 Fail',''),(2,'远程取水站配件|Remote DSP With Station accessories','底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection','合格 Pass|不合格 Fail',''),(2,'远程取水站配件|Remote DSP With Station accessories','底座水路上下盖（Cable位置，外观）|Dispenser base inspection','合格 Pass|不合格 Fail',''),(2,'远程取水站配件|Remote DSP With Station accessories','铝杆支架及螺钉|Dispenser base inspection','有 Yes|无 No',''),(3,'滚轮与IO板配合|Dispenser roller and IO board Assembly','滚动阻尼及微动开关|Roll damping and micro switch','合格 Pass|不合格 Fail',''),(3,'IO板接线线序|IO Board Wring ','线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring','合格 Pass|不合格 Fail',''),(3,'FFC排线|FFC cable','FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable','合格 Pass|不合格 Fail',''),(3,'DSP手柄圆形挂件|Dispenser holder','是否漏装及方向是否正确|direction','合格 Pass|不合格 Fail',''),(3,'远程取水站配件|Remote DSP With Station accessories','底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection','合格 Pass|不合格 Fail',''),(3,'远程取水站配件|Remote DSP With Station accessories','底座水路上下盖（Cable位置，外观）|Dispenser base inspection','合格 Pass|不合格 Fail',''),(3,'远程取水站配件|Remote DSP With Station accessories','铝杆支架及螺钉|Dispenser base inspection','有 Yes|无 No',''),(4,'滚轮与IO板配合|Dispenser roller and IO board Assembly','滚动阻尼及微动开关|Roll damping and micro switch','合格 Pass|不合格 Fail',''),(4,'IO板接线线序|IO Board Wring ','线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring','合格 Pass|不合格 Fail',''),(4,'FFC排线|FFC cable','FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable','合格 Pass|不合格 Fail',''),(4,'DSP手柄圆形挂件|Dispenser holder','是否漏装及方向是否正确|direction','合格 Pass|不合格 Fail',''),(4,'远程取水站配件|Remote DSP With Station accessories','底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection','合格 Pass|不合格 Fail',''),(4,'远程取水站配件|Remote DSP With Station accessories','底座水路上下盖（Cable位置，外观）|Dispenser base inspection','合格 Pass|不合格 Fail',''),(4,'远程取水站配件|Remote DSP With Station accessories','铝杆支架及螺钉|Dispenser base inspection','有 Yes|无 No',''),(5,'滚轮与IO板配合|Dispenser roller and IO board Assembly','滚动阻尼及微动开关|Roll damping and micro switch','合格 Pass|不合格 Fail',''),(5,'IO板接线线序|IO Board Wring ','线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring','合格 Pass|不合格 Fail',''),(5,'FFC排线|FFC cable','FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable','合格 Pass|不合格 Fail',''),(5,'DSP手柄圆形挂件|Dispenser holder','是否漏装及方向是否正确|direction','合格 Pass|不合格 Fail',''),(5,'灵活取水手柄配件|Flexible DSP accessories','硬插直接1/4\"*3/8\"|Stem reducer(1/4\"tube*3/8\"stem)','有 Yes|无 No',''),(5,'灵活取水手柄配件|Flexible DSP accessories','宝塔直接3/8\"*3/8\" Tube barb connector 3/8\"|stem','有 Yes|无 No',''),(5,'灵活取水手柄配件|Flexible DSP accessories','主机侧面取水手柄挂件&螺钉|Flexible dispenser rack','有 Yes|无 No',''),(6,'滚轮与IO板配合|Dispenser roller and IO board Assembly','滚动阻尼及微动开关|Roll damping and micro switch','合格 Pass|不合格 Fail',''),(6,'IO板接线线序|IO Board Wring ','线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring','合格 Pass|不合格 Fail',''),(6,'FFC排线|FFC cable','FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable','合格 Pass|不合格 Fail',''),(6,'DSP手柄圆形挂件|Dispenser holder','是否漏装及方向是否正确|direction','合格 Pass|不合格 Fail',''),(6,'灵活取水手柄配件|Flexible DSP accessories','硬插直接1/4\"*3/8\"|Stem reducer(1/4\"tube*3/8\"stem)','有 Yes|无 No',''),(6,'灵活取水手柄配件|Flexible DSP accessories','宝塔直接3/8\"*3/8\" Tube barb connector 3/8\"|stem','有 Yes|无 No',''),(6,'灵活取水手柄配件|Flexible DSP accessories','主机侧面取水手柄挂件&螺钉|Flexible dispenser rack','有 Yes|无 No',''),(7,'滚轮与IO板配合|Dispenser roller and IO board Assembly','滚动阻尼及微动开关|Roll damping and micro switch','合格 Pass|不合格 Fail',''),(7,'IO板接线线序|IO Board Wring ','线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring','合格 Pass|不合格 Fail',''),(7,'FFC排线|FFC cable','FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable','合格 Pass|不合格 Fail',''),(7,'DSP手柄圆形挂件|Dispenser holder','是否漏装及方向是否正确|direction','合格 Pass|不合格 Fail',''),(7,'灵活取水手柄配件|Flexible DSP accessories','硬插直接1/4\"*3/8\"|Stem reducer(1/4\"tube*3/8\"stem)','有 Yes|无 No',''),(7,'灵活取水手柄配件|Flexible DSP accessories','宝塔直接3/8\"*3/8\" Tube barb connector 3/8\"|stem','有 Yes|无 No',''),(7,'灵活取水手柄配件|Flexible DSP accessories','主机侧面取水手柄挂件&螺钉|Flexible dispenser rack','有 Yes|无 No','');
/*!40000 ALTER TABLE `t_ums_setting_dsp_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_mainframe`
--

DROP TABLE IF EXISTS `t_ums_setting_mainframe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_mainframe` (
  `msid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主机配置表唯一标示',
  `mainframe_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `mainframe_model` varchar(100) DEFAULT NULL,
  `mainframe_option` varchar(100) DEFAULT NULL,
  `mainframe_option2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`msid`),
  KEY `idx_mainframe_pn` (`mainframe_pn`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='主机配置记录表'
/*!50100 PARTITION BY HASH (msid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_mainframe`
--

LOCK TABLES `t_ums_setting_mainframe` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_mainframe` DISABLE KEYS */;
INSERT INTO `t_ums_setting_mainframe` VALUES (64,'werew',9,'2018-11-22 14:54:39','2018-11-22 14:54:39','Cascada I','werw','werw'),(65,'werewwerwe',9,'2018-11-22 14:54:51','2018-11-22 14:54:51','Cascada I','werw','werw'),(66,'LWFS31101',9,'2018-11-26 14:31:24','2018-11-26 14:31:24','Cascada I','N/A',''),(19,'LWFS31101C',9,'2018-09-26 17:30:31','2018-11-27 17:01:44','Cascada I','C',''),(20,'LWFS31101T',9,'2018-10-22 15:13:42','2018-10-22 15:59:21',NULL,NULL,NULL),(21,'LWFS31101TC',9,'2018-10-22 15:46:09','2018-10-22 16:01:37',NULL,NULL,NULL),(22,'LWFS31205',9,'2018-10-22 16:01:56','2018-10-23 08:59:41',NULL,NULL,NULL),(23,'LWFS31205T',9,'2018-10-22 16:17:14','2018-10-23 09:00:06',NULL,NULL,NULL),(24,'LWFS31205R',9,'2018-10-22 16:33:00','2018-10-23 09:00:24',NULL,NULL,NULL),(25,'LWFS31205TR',9,'2018-10-22 16:43:13','2018-10-23 09:00:47',NULL,NULL,NULL),(26,'LWFS31210',9,'2018-10-23 08:41:18','2018-10-23 08:52:37',NULL,NULL,NULL),(27,'LWFS31210T',9,'2018-10-23 08:53:44','2018-10-23 08:58:45',NULL,NULL,NULL),(28,'LWFS31210R',9,'2018-10-23 09:01:33','2018-10-23 09:07:20',NULL,NULL,NULL),(29,'LWFS31210TR',9,'2018-10-23 09:07:50','2018-10-23 09:14:42',NULL,NULL,NULL),(30,'LWFS31220',9,'2018-10-23 09:18:53','2018-10-23 09:32:39',NULL,NULL,NULL),(31,'LWFS31220R',9,'2018-10-23 09:33:02','2018-10-23 09:39:49',NULL,NULL,NULL),(32,'LWFS31220T',9,'2018-10-23 09:40:18','2018-10-23 09:46:49',NULL,NULL,NULL),(33,'LWFS31220TR',9,'2018-10-23 09:47:14','2018-10-23 09:55:16',NULL,NULL,NULL),(34,'LWFS31230',9,'2018-10-23 09:56:41','2018-10-23 10:00:50',NULL,NULL,NULL),(35,'LWFS31230R',9,'2018-10-23 10:01:19','2018-10-23 10:04:22',NULL,NULL,NULL),(36,'LWFS31230T',9,'2018-10-23 10:04:41','2018-10-23 10:07:55',NULL,NULL,NULL),(37,'LWFS31230TR',9,'2018-10-23 10:08:48','2018-10-23 10:11:37',NULL,NULL,NULL),(38,'LWFS31305',9,'2018-10-23 10:29:53','2018-10-23 10:32:37',NULL,NULL,NULL),(39,'LWFS31305R',9,'2018-10-23 10:40:20','2018-10-23 10:43:13',NULL,NULL,NULL),(40,'LWFS31305T',9,'2018-10-23 10:43:33','2018-10-23 10:48:24',NULL,NULL,NULL),(41,'LWFS31305TR',9,'2018-10-23 10:48:44','2018-10-23 10:51:54',NULL,NULL,NULL),(42,'LWFS31310',9,'2018-10-23 11:54:33','2018-10-23 11:58:47',NULL,NULL,NULL),(44,'LWFS31310R',9,'2018-10-23 11:59:25','2018-10-23 12:06:22',NULL,NULL,NULL),(45,'LWFS31310T',9,'2018-10-23 12:03:08','2018-10-23 12:05:56',NULL,NULL,NULL),(46,'LWFS31310TR',9,'2018-10-23 12:06:46','2018-10-23 12:09:36',NULL,NULL,NULL),(47,'LWFS31320',9,'2018-10-23 12:10:39','2018-10-23 12:16:52',NULL,NULL,NULL),(48,'LWFS31320R',9,'2018-10-23 12:18:01','2018-10-23 12:20:57',NULL,NULL,NULL),(49,'LWFS31320T',9,'2018-10-23 12:21:17','2018-10-23 12:24:23',NULL,NULL,NULL),(50,'LWFS31320TR',9,'2018-10-23 12:24:51','2018-10-23 12:28:23',NULL,NULL,NULL),(51,'LWFS31330',9,'2018-10-23 12:29:11','2018-10-23 12:32:08',NULL,NULL,NULL),(52,'LWFS31330R',9,'2018-10-23 12:32:37','2018-10-23 12:35:30',NULL,NULL,NULL),(53,'LWFS31330T',9,'2018-10-23 12:36:11','2018-10-23 12:39:29',NULL,NULL,NULL),(54,'LWFS31330TR',9,'2018-10-23 12:39:51','2018-10-23 12:42:26',NULL,NULL,NULL),(55,'LWFS31405',9,'2018-10-23 12:48:45','2018-10-23 12:54:09',NULL,NULL,NULL),(56,'LWFS31405L',9,'2018-10-23 12:55:05','2018-10-23 12:59:05',NULL,NULL,NULL),(57,'LWFS31405R',9,'2018-10-23 13:02:05','2018-10-23 13:22:19',NULL,NULL,NULL),(58,'LWFS31410',9,'2018-10-23 13:23:40','2018-10-23 13:27:36',NULL,NULL,NULL),(59,'LWFS31410L',9,'2018-10-23 13:27:50','2018-10-23 14:11:36',NULL,NULL,NULL),(60,'LWFS31410R',9,'2018-10-23 13:57:33','2018-10-23 14:01:18',NULL,NULL,NULL),(61,'LWFS31420L',9,'2018-10-23 14:02:00','2018-10-23 14:10:25',NULL,NULL,NULL),(62,'LWFS31430',9,'2018-10-23 14:12:13','2018-10-23 14:15:21',NULL,NULL,NULL),(63,'LWFS31430L',9,'2018-10-23 14:15:43','2018-11-26 13:36:17','Cascada I','L','');
/*!40000 ALTER TABLE `t_ums_setting_mainframe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_mainframe_assemble`
--

DROP TABLE IF EXISTS `t_ums_setting_mainframe_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_mainframe_assemble` (
  `msid` int(11) NOT NULL COMMENT '主机配置表唯一标示',
  `component_name` varchar(200) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(200) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(100) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_msid` (`msid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机配置装配表'
/*!50100 PARTITION BY HASH (msid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_mainframe_assemble`
--

LOCK TABLES `t_ums_setting_mainframe_assemble` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_mainframe_assemble` DISABLE KEYS */;
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES (64,'werw','werw','werw','werew'),(65,'werw','werw','werw','werew'),(66,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(66,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(66,'循环压力变送器|LoopPT3','MPM4150','',''),(66,'水质变送器|Water quality transducer','CM4 中间电导 Intermediate sensor','',''),(66,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(66,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(66,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(66,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(66,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(19,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(19,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(19,'循环压力变送器|Loop PT3','MPM4150','',''),(19,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(19,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','',''),(19,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(19,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(19,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(19,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(19,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(19,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(20,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(20,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(20,'循环压力变送器|LoopPT3','MPM4150','',''),(20,'水质变送器|Water quality transducer','CM4 中间电导 Intermediate sensor','',''),(20,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(20,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(20,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(20,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(20,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(20,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(20,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(21,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(21,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(21,'循环压力变送器|LoopPT3','MPM4150','',''),(21,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(21,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','',''),(21,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(21,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(21,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(21,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(21,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(21,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(21,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(21,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(22,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(22,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(22,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(22,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(22,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(22,'循环压力变送器| Loop PT 3','MPM4150','',''),(22,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(22,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(22,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(22,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','',''),(22,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(22,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(22,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(22,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(22,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(22,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(23,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(23,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(23,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(23,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(23,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(23,'循环压力变送器| Loop PT 3','MPM4150','',''),(23,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(23,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(23,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(23,'水质变送器|Water quality transducer','2# 电导变送器|2# transducer','',''),(23,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(23,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(23,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(23,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(23,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(23,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(23,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(23,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(24,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(24,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(24,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(24,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(24,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(24,'循环压力变送器| Loop PT 3','MPM4150','',''),(24,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(24,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(24,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(24,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(24,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(24,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(24,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(24,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(24,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(24,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(24,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(25,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(25,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(25,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(25,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(25,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(25,'循环压力变送器| Loop PT 3','MPM4150','',''),(25,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(25,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(25,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(25,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(25,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(25,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(25,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(25,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(25,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(25,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(25,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(25,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(25,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(26,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(26,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(26,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(26,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(26,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(26,'循环压力变送器| Loop PT 3','MPM4150','',''),(26,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(26,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(26,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(26,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(26,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(26,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(26,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(26,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(26,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(26,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(26,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(27,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(27,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(27,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(27,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(27,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(27,'循环RO压力变送器| Loop PT 3','MPM4150','',''),(27,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(27,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(27,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(27,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(27,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(27,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(27,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(27,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(27,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(27,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(27,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(27,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(27,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(28,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(28,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(28,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(28,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(28,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(28,'循环压力变送器| Loop PT 3','MPM4150','',''),(28,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(28,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(28,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(28,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(28,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(28,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(28,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(28,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(28,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(28,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(28,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(28,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(29,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(29,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(29,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(29,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(29,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(29,'循环压力变送器| Loop PT 3','MPM4150','',''),(29,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(29,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(29,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(29,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(29,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(29,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(29,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(29,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(29,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(29,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(29,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(29,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(29,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(29,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(30,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(30,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(30,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(30,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(30,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(30,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(30,'循环压力变送器| Loop PT 3','MPM4150','',''),(30,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(30,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(30,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(30,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(30,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(30,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(30,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(30,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(30,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(30,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(30,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(30,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(30,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(31,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(31,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(31,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(31,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(31,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(31,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(31,'循环压力变送器| Loop PT 3','MPM4150','',''),(31,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(31,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(31,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(31,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(31,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(31,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(31,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(31,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(31,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(31,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(31,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(31,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(31,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(31,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(32,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(32,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(32,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(32,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(32,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(32,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(32,'循环压力变送器| Loop PT 3','MPM4150','',''),(32,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(32,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(32,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(32,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(32,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(32,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(32,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(32,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(32,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(32,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(32,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(32,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(32,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(32,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(32,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(33,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(33,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(33,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(33,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(33,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(33,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(33,'循环压力变送器| Loop PT 3','MPM4150','',''),(33,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(33,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(33,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(33,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(33,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(33,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(33,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(33,'水质变送器|Water quality transducer','C3#电导变送器  2# transducer','',''),(33,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(33,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(33,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(33,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(33,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(33,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(33,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(33,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(34,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(34,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(34,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(34,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(34,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(34,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(34,'循环压力变送器| Loop PT 3','MPM4150','',''),(34,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(34,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(34,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(34,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(34,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(34,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(34,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(34,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(34,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(34,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(34,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(34,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(34,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(35,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(35,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(35,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(35,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(35,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(35,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(35,'循环压力变送器| Loop PT 3','MPM4150','',''),(35,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(35,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(35,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(35,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(35,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(35,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(35,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(35,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(35,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(35,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(35,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(35,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(35,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(35,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(36,'开关电源（主机）|Power module (MU)','','',''),(36,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(36,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(36,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(36,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(36,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(36,'循环压力变送器| Loop PT 3','MPM4150','',''),(36,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(36,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(36,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(36,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(36,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(36,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(36,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(36,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(36,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(36,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(36,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(36,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(36,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(36,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(36,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(36,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(37,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(37,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(37,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(37,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(37,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(37,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(37,'循环压力变送器| Loop PT 3','MPM4150','',''),(37,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(37,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(37,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(37,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(37,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(37,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(37,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(37,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(37,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(37,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(37,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(37,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(37,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(37,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(37,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(37,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(38,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(38,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(38,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(38,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(38,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(38,'循环压力变送器| Loop PT 3','MPM4150','',''),(38,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(38,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(38,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(38,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(38,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(38,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(38,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(38,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(38,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(38,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(39,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(39,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(39,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(39,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(39,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(39,'循环压力变送器| Loop PT 3','MPM4150','',''),(39,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(39,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(39,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(39,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(39,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(39,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(39,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(39,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(39,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(39,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(39,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(40,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(40,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(40,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(40,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(40,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(40,'循环压力变送器| Loop PT 3','MPM4150','',''),(40,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(40,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(40,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(40,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(40,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(40,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(40,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(40,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(40,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(40,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(40,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(40,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(41,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(41,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(41,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(41,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(41,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(41,'循环压力变送器| Loop PT 3','MPM4150','',''),(41,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(41,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(41,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(41,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(41,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(41,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(41,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(41,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(41,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(41,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(41,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(41,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(41,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(42,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(42,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(42,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(42,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(42,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(42,'循环压力变送器| Loop PT 3','MPM4150','',''),(42,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(42,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(42,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(42,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(42,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(42,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(42,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(42,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(42,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(42,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(42,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(44,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(44,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(44,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(44,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(44,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(44,'循环压力变送器| Loop PT 3','MPM4150','',''),(44,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(44,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(44,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(44,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(44,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(44,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(44,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(44,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(44,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(44,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(44,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(44,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(45,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(45,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(45,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(45,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(45,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(45,'循环压力变送器| Loop PT 3','MPM4150','',''),(45,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(45,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(45,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(45,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(45,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(45,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(45,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(45,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(45,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(45,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(45,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(45,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(45,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(46,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(46,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(46,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(46,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(46,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(46,'循环压力变送器| Loop PT 3','MPM4150','',''),(46,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(46,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(46,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(46,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(46,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(46,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(46,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(46,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(46,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(46,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(46,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(46,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(46,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(46,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(47,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(47,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(47,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(47,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(47,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(47,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(47,'循环压力变送器| Loop PT 3','MPM4150','',''),(47,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(47,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(47,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(47,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(47,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(47,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(47,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(47,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(47,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(47,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(47,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(47,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(47,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(48,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(48,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(48,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(48,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(48,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(48,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(48,'循环压力变送器| Loop PT 3','MPM4150','',''),(48,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(48,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(48,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(48,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(48,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(48,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(48,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(48,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(48,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(48,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(48,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(48,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(48,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(48,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(49,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(49,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(49,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(49,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(49,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(49,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(49,'循环压力变送器| Loop PT 3','MPM4150','',''),(49,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(49,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(49,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(49,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(49,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(49,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(49,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(49,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(49,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(49,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(49,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(49,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(49,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(49,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(49,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(50,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(50,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(50,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(50,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(50,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(50,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(50,'循环压力变送器| Loop PT 3','MPM4150','',''),(50,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(50,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(50,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(50,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(50,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(50,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(50,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(50,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(50,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(50,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(50,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(50,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(50,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(50,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(50,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(50,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(51,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(51,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(51,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(51,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(51,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(51,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(51,'循环压力变送器| Loop PT 3','MPM4150','',''),(51,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(51,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(51,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(51,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(51,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(51,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(51,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(51,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(51,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(51,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(51,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(51,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(51,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(52,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(52,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(52,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(52,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(52,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(52,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(52,'循环压力变送器| Loop PT 3','MPM4150','',''),(52,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(52,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(52,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(52,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(52,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(52,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(52,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(52,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(52,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(52,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(52,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(52,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(52,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(52,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(53,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(53,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(53,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(53,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(53,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(53,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(53,'循环压力变送器| Loop PT 3','MPM4150','',''),(53,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(53,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(53,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(53,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(53,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(53,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(53,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(53,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(53,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(53,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(53,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(53,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(53,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(53,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(53,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(54,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(54,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(54,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(54,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(54,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(54,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(54,'循环压力变送器| Loop PT 3','MPM4150','',''),(54,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(54,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(54,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(54,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(54,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(54,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(54,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(54,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(54,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','',''),(54,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','',''),(54,'水质变送器|Water quality transducer','CM5 TOC电导仪 TOC sensor','',''),(54,'水质变送器|Water quality transducer','5# 电导变送器 2#transducer','',''),(54,'水质变送器|Water quality transducer','CM6 UP产水电导仪 UP quality sensor','',''),(54,'水质变送器|Water quality transducer','6#电导变送器  2#transducer','',''),(54,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(54,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(55,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(55,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(55,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(55,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(55,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(55,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(55,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(55,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(55,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2levels)','',''),(55,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(56,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(56,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(56,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(56,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(56,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(56,'循环压力变送器| Loop PT 3','MPM4150','',''),(56,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(56,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(56,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(56,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(56,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','','0.1 电导'),(56,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','','C型：1 0 0'),(56,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(56,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(57,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(57,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(57,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(57,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(57,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(57,'一级RO膜| 1st RO membrane','RT-2012-120(1A)','',''),(57,'二级RO膜| 2nd RO  membrane','RT-2012-75(1B)','',''),(57,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(57,'水质变送器|Water quality transducer',' 2# 电导变送器 2# transducer','',''),(57,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(57,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(57,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(58,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(58,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(58,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(58,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(58,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(58,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(58,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(58,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(58,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(58,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(58,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(59,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(59,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(59,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(59,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(59,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(59,'循环压力变送器| Loop PT 3','MPM4150','',''),(59,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(59,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(59,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(59,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(59,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(59,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','','0.1 电导'),(59,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','','C型：1 0 0'),(59,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(59,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(60,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(60,'一级RO泵|1st RO pump ','EC-304-100BRS (5L,10L)','SJZ-EC-',''),(60,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(60,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(60,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(60,'循环压力变送器| Loop PT 3','MPM4150','',''),(60,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(60,'一级RO膜| 1st RO membrane','RT-2012-100(2A)','',''),(60,'二级RO膜| 2nd RO  membrane','RT-2012-120(2B)','',''),(60,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(60,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(60,'水质变送器|Water quality transducer','3#电导变送器  2# transducer','',''),(60,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(60,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(61,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(61,'一级RO泵|1st RO pump ','EC-203-200ARS (20L)','SJZ-EC-',''),(61,'二级RO泵|2st RO pump','EC-103-75RS (20L)','SJZ-EC-',''),(61,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(61,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(61,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(61,'循环压力变送器| Loop PT 3','MPM4150','',''),(61,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(61,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(61,'一级RO膜| 1st RO membrane','RT-2012-100(3A)','',''),(61,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(61,'二级RO膜| 2nd RO  membrane','RT-2012-100(3B)','',''),(61,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(61,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(61,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','','0.1电导'),(61,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','','C型：1 0 0'),(61,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(61,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(62,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(62,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(62,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(62,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(62,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(62,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(62,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(62,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(62,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(62,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(62,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(62,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(62,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(62,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(62,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','',''),(63,'开关电源（主机）|Power module (MU)','SP-200-24','',''),(63,'一级RO泵|1st RO pump ','EC-203-300ARS (30L)','SJZ-EC-',''),(63,'二级RO泵|2st RO pump','EC-304-50BRS (30L)','SJZ-EC-',''),(63,'循环泵|Recirculation pump','EC-203-300ARS','SJZ-EC-',''),(63,'一级RO压力变送器|1st RO PT 1','MPM4150','',''),(63,'二级RO压力变送器|2st RO PT 2','MPM4150','',''),(63,'循环压力变送器| Loop PT 3','MPM4150','',''),(63,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(63,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(63,'一级RO膜| 1st RO membrane','RT-2012-120(4A)','',''),(63,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(63,'二级RO膜| 2nd RO  membrane','RT-2012-120(4B)','',''),(63,'水质变送器|Water quality transducer','CM2 RO产水电导仪|RO quality sensor','',''),(63,'水质变送器|Water quality transducer','2# 电导变送器 2# transducer','',''),(63,'水质变送器|Water quality transducer','CM4中间电导|Intermediate sensor','','0.1电导'),(63,'水质变送器|Water quality transducer','4#电导变送器 2#transducer','','C型：1 0 0'),(63,'主机主板|Main unit PCB','Cascada MU-MAIN PCB(2 levels)','',''),(63,'主机显示屏|Main unit LCD','MU LCD PCB with touch screen LCD','','');
/*!40000 ALTER TABLE `t_ums_setting_mainframe_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_mainframe_inspect`
--

DROP TABLE IF EXISTS `t_ums_setting_mainframe_inspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_mainframe_inspect` (
  `msid` int(11) NOT NULL COMMENT '主机配置表唯一标示',
  `selfcheck_name` varchar(200) DEFAULT NULL COMMENT '自检名称',
  `selfcheck_content` varchar(200) DEFAULT NULL COMMENT '自检内容',
  `selfcheck_result` varchar(100) DEFAULT NULL COMMENT '自检结果',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_msid` (`msid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机配置送检记录表'
/*!50100 PARTITION BY HASH (msid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_mainframe_inspect`
--

LOCK TABLES `t_ums_setting_mainframe_inspect` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_mainframe_inspect` DISABLE KEYS */;
INSERT INTO `t_ums_setting_mainframe_inspect` VALUES (64,'werew','10101000','werw','werwe'),(65,'werew','10101000','werw','werwe'),(66,'BOMA','11110000','CASCADA I',''),(19,'拨码记录','10101010','',''),(63,'BOMA','01010000','OK','');
/*!40000 ALTER TABLE `t_ums_setting_mainframe_inspect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_preprocessing`
--

DROP TABLE IF EXISTS `t_ums_setting_preprocessing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_preprocessing` (
  `psid` int(11) NOT NULL AUTO_INCREMENT COMMENT '预处理配置表唯一标示',
  `preprocessing_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `preprocessing_model` varchar(100) DEFAULT NULL,
  `pt_option` varchar(100) DEFAULT NULL,
  `pt_option2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`psid`),
  KEY `idx_preprocessing_pn` (`preprocessing_pn`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='预处理装配流程跟踪单装配记录表'
/*!50100 PARTITION BY HASH (psid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_preprocessing`
--

LOCK TABLES `t_ums_setting_preprocessing` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_preprocessing` DISABLE KEYS */;
INSERT INTO `t_ums_setting_preprocessing` VALUES (13,'LWFS32701C',9,'2018-09-05 23:22:26','2018-09-06 00:10:04',NULL,NULL,NULL),(14,'LWFS32701',9,'2018-09-05 23:35:59','2018-09-05 23:59:20',NULL,NULL,NULL),(15,'LWFS32701P',9,'2018-09-05 23:39:34','2018-09-06 00:09:20',NULL,NULL,NULL),(16,'LWFS32701PC',9,'2018-09-05 23:43:38','2018-09-06 00:06:41',NULL,NULL,NULL),(17,'werwe',9,'2018-11-22 14:54:10','2018-11-22 14:54:10','Pretreatment','werew','werwe'),(18,'werwewerw',9,'2018-11-22 14:54:15','2018-11-22 14:54:19','Pretreatment','werew','werwe');
/*!40000 ALTER TABLE `t_ums_setting_preprocessing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_preprocessing_assemble`
--

DROP TABLE IF EXISTS `t_ums_setting_preprocessing_assemble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_preprocessing_assemble` (
  `psid` int(11) NOT NULL COMMENT '预处理配置表唯一标示',
  `component_name` varchar(200) DEFAULT NULL COMMENT '组件名称',
  `component_no` varchar(200) DEFAULT NULL COMMENT '组件型号',
  `serial_no_record` varchar(100) DEFAULT NULL COMMENT '序列号记录',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_psid` (`psid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预处理装配配置表'
/*!50100 PARTITION BY HASH (psid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_preprocessing_assemble`
--

LOCK TABLES `t_ums_setting_preprocessing_assemble` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_preprocessing_assemble` DISABLE KEYS */;
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES (13,'开关电源（预处理）|Power module (PT)','SP-75-24','',''),(13,'水质变送器|Water quality transducer','CM1源水电导仪|CM1 Raw water sensor','',''),(13,'水质变送器|Water quality transducer','1#电导变送器 |1# Conductivity transducer','',''),(13,'预处理IO主板|PT module IO PCB','PT-IO PCB board','',''),(13,'预处理显示板|PT module display PCB','PT LCD PCB with LCD','',''),(13,'PT减压阀|Pressure Regulator','PRV-3-SH','正确Yes|不正确No',''),(13,'常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）','-','正确Yes|不正确No',''),(13,'低压开关|Pressure switch (feed water)','-','正确Yes|不正确No',''),(14,'开关电源（预处理）|Power module (PT)','SP-75-24','',''),(14,'预处理IO主板|PT module IO PCB','PT-IO PCB board','',''),(14,'预处理显示板|PT module display PCB','PT LCD PCB with LCD','',''),(14,'PT减压阀|Pressure Regulator','PRV-3-SH','正确Yes|不正确No',''),(14,'常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）','-','正确Yes|不正确No',''),(14,'低压开关|Pressure switch (feed water)','-','正确Yes|不正确No',''),(15,'开关电源（预处理）|Power module (PT)','SP-75-24','',''),(15,'源水增压泵|Raw water boost pump','EC-203-300ARS','',''),(15,'预处理IO主板|PT module IO PCB','PT-IO PCB board','',''),(15,'预处理显示板|PT module display PCB','PT LCD PCB with LCD','',''),(15,'PT减压阀|Pressure Regulator','PRV-3-SH','正确Yes|不正确No',''),(15,'常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）','-','正确Yes|不正确No',''),(15,'低压开关|Pressure switch (feed water)','-','正确Yes|不正确No',''),(16,'开关电源（预处理）|Power module (PT)','SP-75-24','',''),(16,'源水增压泵|Raw water boost pump','EC-203-300ARS','',''),(16,'水质变送器|Water quality transducer','CM1源水电导仪|CM1 Raw water sensor','',''),(16,'水质变送器|Water quality transducer','1#电导变送器|1# Conductivity transducer','',''),(16,'预处理IO主板|PT module IO PCB','PT-IO PCB board','',''),(16,'预处理显示板|PT module display PCB','PT LCD PCB with LCD','',''),(16,'PT减压阀|Pressure Regulator (feed water)','PRV-3-SH','正确Yes|不正确No',''),(16,'常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）','-','正确Yes|不正确No',''),(16,'低压开关|Pressure switch (feed water)','-','正确Yes|不正确No',''),(17,'werew','werw','werwe','werwe'),(18,'werew','werwwerw','werwe','werwe');
/*!40000 ALTER TABLE `t_ums_setting_preprocessing_assemble` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_setting_preprocessing_inspect`
--

DROP TABLE IF EXISTS `t_ums_setting_preprocessing_inspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_setting_preprocessing_inspect` (
  `psid` int(11) NOT NULL COMMENT '预处理配置表唯一标示',
  `selfcheck_name` varchar(200) DEFAULT NULL COMMENT '自检名称',
  `selfcheck_content` varchar(200) DEFAULT NULL COMMENT '自检内容',
  `selfcheck_result` varchar(100) DEFAULT NULL COMMENT '自检结果',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  KEY `idx_psid` (`psid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预处理送检记录配置表'
/*!50100 PARTITION BY HASH (psid)
(PARTITION p1 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p50 ENGINE = InnoDB,
 PARTITION p51 ENGINE = InnoDB,
 PARTITION p52 ENGINE = InnoDB,
 PARTITION p53 ENGINE = InnoDB,
 PARTITION p54 ENGINE = InnoDB,
 PARTITION p55 ENGINE = InnoDB,
 PARTITION p56 ENGINE = InnoDB,
 PARTITION p57 ENGINE = InnoDB,
 PARTITION p58 ENGINE = InnoDB,
 PARTITION p59 ENGINE = InnoDB,
 PARTITION p60 ENGINE = InnoDB,
 PARTITION p61 ENGINE = InnoDB,
 PARTITION p62 ENGINE = InnoDB,
 PARTITION p63 ENGINE = InnoDB,
 PARTITION p64 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_setting_preprocessing_inspect`
--

LOCK TABLES `t_ums_setting_preprocessing_inspect` WRITE;
/*!40000 ALTER TABLE `t_ums_setting_preprocessing_inspect` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ums_setting_preprocessing_inspect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_th_config`
--

DROP TABLE IF EXISTS `t_ums_th_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_th_config` (
  `MENUID` int(11) NOT NULL COMMENT '菜单编号',
  `TABLENAME` varchar(30) DEFAULT NULL COMMENT '表格名称',
  `LINENUM` int(4) DEFAULT NULL COMMENT '行号',
  `COLNUM` int(4) DEFAULT NULL COMMENT '列号',
  `SORT` int(2) DEFAULT NULL,
  `ROWS` int(3) DEFAULT NULL COMMENT '占据行',
  `COLS` int(3) DEFAULT NULL COMMENT '占据列',
  `DATATYPE` int(11) DEFAULT NULL COMMENT '数据字典id',
  `fieldname` varchar(50) DEFAULT NULL,
  `invisible` int(1) DEFAULT '0' COMMENT '是否可见',
  `HEADLINE` varchar(100) DEFAULT NULL COMMENT '中文标题',
  `DESCRIPTION` text COMMENT '描述信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统表格标题配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_th_config`
--

LOCK TABLES `t_ums_th_config` WRITE;
/*!40000 ALTER TABLE `t_ums_th_config` DISABLE KEYS */;
INSERT INTO `t_ums_th_config` VALUES (401,'dspTable',1,1,NULL,1,1,NULL,'',2,'',NULL),(401,'dspTable',1,2,NULL,1,1,NULL,'dspID',1,'id',NULL),(401,'dspTable',1,3,NULL,1,1,NULL,'cOrderID',0,'客户订单信息',NULL),(401,'dspTable',1,4,NULL,1,1,NULL,'assembleTime',0,'装配日期',NULL),(401,'dspTable',1,5,NULL,1,1,NULL,'productionTime',1,'生产时间',NULL),(401,'dspTable',1,6,NULL,1,1,NULL,'dspPn',0,'型号/PN',NULL),(401,'dspTable',1,7,NULL,1,1,NULL,'serialNo',0,'序列号/Serial NO',NULL),(401,'dspTable',1,8,NULL,1,1,NULL,'workorderNo',0,'工单号/WO',NULL),(401,'dspTable',1,9,NULL,1,1,NULL,'dspModel',0,'DSP型号/Model',NULL),(401,'dspTable',1,10,NULL,1,1,NULL,'assembleRecords',0,'装配记录',NULL),(401,'dspTable',1,11,NULL,1,1,NULL,'exceptionRecord',0,'异常记录',NULL),(401,'dspTable',1,12,NULL,1,1,NULL,'remarks',0,'备注',NULL),(401,'dspTable',1,13,NULL,1,1,NULL,'assembleOperator',0,'装配人员',NULL),(401,'dspTable',1,14,NULL,1,1,NULL,'operatorName',0,'操作员',NULL),(401,'dspTable',1,15,NULL,1,1,NULL,'',2,'操作',NULL),(402,'cisternTable',1,1,NULL,1,1,NULL,'',2,'',NULL),(402,'cisternTable',1,2,NULL,1,1,NULL,'cisternID',1,'id',NULL),(402,'cisternTable',1,3,NULL,1,1,NULL,'cOrderID',0,'客户订单信息',NULL),(402,'cisternTable',1,4,NULL,1,1,NULL,'assembleTime',0,'装配日期',NULL),(402,'cisternTable',1,5,NULL,1,1,NULL,'productionTime',1,'生产时间',NULL),(402,'cisternTable',1,6,NULL,1,1,NULL,'cisternPn',0,'料号/PN',NULL),(402,'cisternTable',1,7,NULL,1,1,NULL,'serialNo',0,'序列号/Serial NO',NULL),(402,'cisternTable',1,8,NULL,1,1,NULL,'workorderNo',0,'工单号/WO',NULL),(402,'cisternTable',1,9,NULL,1,1,NULL,'cisternModel',0,'水箱型号/Model',NULL),(402,'cisternTable',1,10,NULL,1,1,NULL,'cisternOptions',0,'水箱选配件/Options',NULL),(402,'cisternTable',1,11,NULL,1,1,NULL,'assembleRecords',0,'装配记录',NULL),(402,'cisternTable',1,12,NULL,1,1,NULL,'exceptionRecord',0,'异常记录',NULL),(402,'cisternTable',1,13,NULL,1,1,NULL,'remarks',0,'备注',NULL),(402,'cisternTable',1,14,NULL,1,1,NULL,'assembleOperator',0,'装配人员',NULL),(402,'cisternTable',1,15,NULL,1,1,NULL,'operatorName',0,'操作员',NULL),(402,'cisternTable',1,16,NULL,1,1,NULL,'',2,'操作',NULL),(403,'preprocessingTable',1,1,NULL,1,1,NULL,'',2,'',NULL),(403,'preprocessingTable',1,2,NULL,1,1,NULL,'preprocessingID',1,'id',NULL),(403,'preprocessingTable',1,3,NULL,1,1,NULL,'cOrderID',0,'客户订单信息',NULL),(403,'preprocessingTable',1,4,NULL,1,1,NULL,'assembleTime',0,'装配日期',NULL),(403,'preprocessingTable',1,5,NULL,1,1,NULL,'productionTime',1,'生产时间',NULL),(403,'preprocessingTable',1,6,NULL,1,1,NULL,'preprocessingPn',0,'料号/PN',NULL),(403,'preprocessingTable',1,7,NULL,1,1,NULL,'serialNo',0,'序列号/Serial NO',NULL),(403,'preprocessingTable',1,8,NULL,1,1,NULL,'workorderNo',0,'工单号/WO',NULL),(403,'preprocessingTable',1,9,NULL,1,1,NULL,'preprocessingModel',0,'名称/Model',NULL),(403,'preprocessingTable',1,10,NULL,1,1,NULL,'ptOptions',0,'PT选配件/Option',NULL),(403,'preprocessingTable',1,11,NULL,1,1,NULL,'assembleRecords',0,'装配记录',NULL),(403,'preprocessingTable',1,12,NULL,1,1,NULL,'inspectRecords',1,'送检人员记录',NULL),(403,'preprocessingTable',1,13,NULL,1,1,NULL,'exceptionRecord',0,'异常记录',NULL),(403,'preprocessingTable',1,14,NULL,1,1,NULL,'remarks',0,'备注',NULL),(403,'preprocessingTable',1,15,NULL,1,1,NULL,'assembleOperator',0,'装配人员',NULL),(403,'preprocessingTable',1,16,NULL,1,1,NULL,'inspectOperator',1,'送检人员',NULL),(403,'preprocessingTable',1,17,NULL,1,1,NULL,'inspectTime',1,'送检日期',NULL),(403,'preprocessingTable',1,18,NULL,1,1,NULL,'operatorName',0,'操作员',NULL),(403,'preprocessingTable',1,19,NULL,1,1,NULL,'',2,'操作',NULL),(404,'mainframeTable',1,1,NULL,1,1,NULL,'',2,'',NULL),(404,'mainframeTable',1,2,NULL,1,1,NULL,'mainframeID',1,'id',NULL),(404,'mainframeTable',1,3,NULL,1,1,NULL,'cOrderID',0,'客户订单信息',NULL),(404,'mainframeTable',1,4,NULL,1,1,NULL,'assembleTime',0,'装配日期',NULL),(404,'mainframeTable',1,5,NULL,1,1,NULL,'productionTime',1,'生产时间',NULL),(404,'mainframeTable',1,6,NULL,1,1,NULL,'mainframePn',0,'料号/PN',NULL),(404,'mainframeTable',1,7,NULL,1,1,NULL,'serialNo',0,'序列号/Serial NO',NULL),(404,'mainframeTable',1,8,NULL,1,1,NULL,'workorderNo',0,'工单号/WO',NULL),(404,'mainframeTable',1,9,NULL,1,1,NULL,'mainframeModel',0,'主机型号/Model',NULL),(404,'mainframeTable',1,10,NULL,1,1,NULL,'mainframeOptions',0,'主机选配件/Option',NULL),(404,'mainframeTable',1,11,NULL,1,1,NULL,'assembleRecords',0,'装配记录',NULL),(404,'mainframeTable',1,12,NULL,1,1,NULL,'inspectRecords',0,'送检人员记录',NULL),(404,'mainframeTable',1,13,NULL,1,1,NULL,'exceptionRecord',0,'异常记录',NULL),(404,'mainframeTable',1,14,NULL,1,1,NULL,'remarks',0,'备注',NULL),(404,'mainframeTable',1,15,NULL,1,1,NULL,'assembleOperator',0,'装配人员',NULL),(404,'mainframeTable',1,16,NULL,1,1,NULL,'inspectOperator',1,'送检人员',NULL),(404,'mainframeTable',1,17,NULL,1,1,NULL,'inspectTime',1,'送检日期',NULL),(404,'mainframeTable',1,18,NULL,1,1,NULL,'operatorName',0,'操作员',NULL),(404,'mainframeTable',1,19,NULL,1,1,NULL,'',2,'操作',NULL),(403,'preprocessingTemplate_inspect',1,1,NULL,1,9,NULL,'',0,'预处理装配流程跟踪单/PT Assembly Record',NULL),(403,'preprocessingTemplate_inspect',2,1,NULL,1,2,NULL,'',0,'料号/PN:',NULL),(403,'preprocessingTemplate_inspect',2,3,NULL,1,2,NULL,'preprocessingPn',0,'',NULL),(403,'preprocessingTemplate_inspect',2,5,NULL,1,1,NULL,'',0,'',NULL),(403,'preprocessingTemplate_inspect',2,6,NULL,1,2,NULL,'',0,'序列号/Serial No:',NULL),(403,'preprocessingTemplate_inspect',2,8,NULL,1,2,NULL,'serialNo',0,'',NULL),(403,'preprocessingTemplate_inspect',3,1,NULL,1,2,NULL,'',0,'工单号/WO：',NULL),(403,'preprocessingTemplate_inspect',3,3,NULL,1,2,NULL,'workorderNo',0,'',NULL),(403,'preprocessingTemplate_inspect',3,5,NULL,1,1,NULL,'',0,'',NULL),(403,'preprocessingTemplate_inspect',4,6,NULL,1,2,NULL,'',0,'PT选配件/Options：',NULL),(403,'preprocessingTemplate_inspect',4,7,NULL,1,1,NULL,'ptOption',0,'',NULL),(403,'preprocessingTemplate_inspect',4,8,NULL,1,1,NULL,'ptOption2',0,'',NULL),(403,'preprocessingTemplate_inspect',4,1,NULL,1,2,NULL,'',0,'名称/Modle：',NULL),(403,'preprocessingTemplate_inspect',4,3,NULL,1,2,NULL,'preprocessingModel',0,'',NULL),(403,'preprocessingTemplate_inspect',4,5,NULL,1,1,NULL,'',0,'',NULL),(403,'preprocessingTemplate_inspect',3,6,NULL,1,2,NULL,'',0,'客户订单信息：',NULL),(403,'preprocessingTemplate_inspect',3,8,NULL,1,2,NULL,'cOrderID',0,'',NULL),(403,'preprocessingTemplate_inspect',5,1,NULL,1,9,NULL,'',0,'装配记录/Manufacture Record',NULL),(403,'preprocessingTemplate_inspect',6,1,NULL,1,1,NULL,'assembleRecords:preprocessingID',0,'序号\r\nNO',NULL),(403,'preprocessingTemplate_inspect',6,2,NULL,1,2,NULL,'assembleRecords:componentName',0,'组件名称\r\nComponent Name',NULL),(403,'preprocessingTemplate_inspect',6,4,NULL,1,2,NULL,'assembleRecords:componentNo',0,'组件型号\r\nComponent Module',NULL),(403,'preprocessingTemplate_inspect',6,6,NULL,1,2,NULL,'assembleRecords:serialNoRecord',4,'序列号记录\r\nSerial No',NULL),(403,'preprocessingTemplate_inspect',6,8,NULL,1,2,NULL,'assembleRecords:remarks',0,'备注\r\nRemarks',NULL),(403,'preprocessingTemplate_inspect',7,1,NULL,1,9,NULL,'',0,'送检人员记录/Self Inspection Records',NULL),(403,'preprocessingTemplate_inspect',8,1,NULL,1,1,NULL,'inspectRecords:preprocessingID',0,'序号\r\nNO',NULL),(403,'preprocessingTemplate_inspect',8,2,NULL,1,2,NULL,'inspectRecords:selfcheckName',0,'自检名称\r\nInspection Item',NULL),(403,'preprocessingTemplate_inspect',8,4,NULL,1,2,NULL,'inspectRecords:selfcheckContent',0,'自检内容\r\nSelf Inspection Content',NULL),(403,'preprocessingTemplate_inspect',8,6,NULL,1,2,NULL,'inspectRecords:selfcheckResult',4,'自检结果\r\nSelf Inspection Result',NULL),(403,'preprocessingTemplate_inspect',8,8,NULL,1,2,NULL,'inspectRecords:remarks',0,'备注\r\nRemarks',NULL),(403,'preprocessingTemplate_inspect',9,1,NULL,1,1,NULL,'',0,'异常记录：',NULL),(403,'preprocessingTemplate_inspect',9,2,NULL,1,8,NULL,'exceptionRecord',0,'',NULL),(403,'preprocessingTemplate_inspect',10,1,NULL,1,1,NULL,'',0,'备注：',NULL),(403,'preprocessingTemplate_inspect',10,2,NULL,1,8,NULL,'remarks',0,'',NULL),(403,'preprocessingTemplate_inspect',11,1,NULL,1,1,NULL,'',0,'装配人员：',NULL),(403,'preprocessingTemplate_inspect',11,2,NULL,1,1,NULL,'assembleOperator',0,'',NULL),(403,'preprocessingTemplate_inspect',11,3,NULL,1,1,NULL,'',0,'装配日期：',NULL),(403,'preprocessingTemplate_inspect',11,4,NULL,1,1,NULL,'assembleTime',0,'',NULL),(403,'preprocessingTemplate_inspect',11,5,NULL,1,1,NULL,'',0,'',NULL),(403,'preprocessingTemplate_inspect',11,6,NULL,1,1,NULL,'',0,'送检人员：',NULL),(403,'preprocessingTemplate_inspect',11,7,NULL,1,1,NULL,'inspectOperator',0,'',NULL),(403,'preprocessingTemplate_inspect',11,8,NULL,1,1,NULL,'',0,'送检日期：',NULL),(403,'preprocessingTemplate_inspect',11,9,NULL,1,1,NULL,'inspectTime',0,'',NULL),(403,'preprocessingTemplate_inspect',3,9,NULL,1,1,NULL,'ptOption2',0,'',NULL),(404,'mainframeTemplate_inspect',1,1,NULL,1,9,NULL,'',0,'主机装配流程跟踪单/PT Assembly Record',NULL),(404,'mainframeTemplate_inspect',2,1,NULL,1,2,NULL,'',0,'料号/PN:',NULL),(404,'mainframeTemplate_inspect',2,3,NULL,1,2,NULL,'mainframePn',0,'',NULL),(404,'mainframeTemplate_inspect',2,5,NULL,1,1,NULL,'',0,'',NULL),(404,'mainframeTemplate_inspect',2,6,NULL,1,2,NULL,'',0,'序列号/Serial No:',NULL),(404,'mainframeTemplate_inspect',2,8,NULL,1,2,NULL,'serialNo',0,'',NULL),(404,'mainframeTemplate_inspect',3,1,NULL,1,2,NULL,'',0,'工单号/WO：',NULL),(404,'mainframeTemplate_inspect',3,3,NULL,1,2,NULL,'workorderNo',0,'',NULL),(404,'mainframeTemplate_inspect',3,5,NULL,1,1,NULL,'',0,'',NULL),(404,'mainframeTemplate_inspect',4,6,NULL,1,2,NULL,'',0,'主机选配件/Options：',NULL),(404,'mainframeTemplate_inspect',4,8,NULL,1,1,NULL,'mainframeOption',0,'',NULL),(404,'mainframeTemplate_inspect',4,9,NULL,1,1,NULL,'mainframeOption2',0,'',NULL),(404,'mainframeTemplate_inspect',4,1,NULL,1,2,NULL,'',0,'主机型号/Modle：',NULL),(404,'mainframeTemplate_inspect',4,3,NULL,1,3,NULL,'mainframeModel',0,'',NULL),(404,'mainframeTemplate_inspect',3,6,NULL,1,2,NULL,'',0,'客户订单信息：',NULL),(404,'mainframeTemplate_inspect',3,8,NULL,1,2,NULL,'cOrderID',0,'',NULL),(404,'mainframeTemplate_inspect',5,1,NULL,1,9,NULL,'',0,'装配记录/Manufacture Record',NULL),(404,'mainframeTemplate_inspect',6,1,NULL,1,1,NULL,'assembleRecords:mainframeID',0,'序号\r\nNO',NULL),(404,'mainframeTemplate_inspect',6,2,NULL,1,2,NULL,'assembleRecords:componentName',0,'组件名称\r\nComponent Name',NULL),(404,'mainframeTemplate_inspect',6,4,NULL,1,2,NULL,'assembleRecords:componentNo',0,'组件型号\r\nComponent Module',NULL),(404,'mainframeTemplate_inspect',6,6,NULL,1,2,NULL,'assembleRecords:serialNoRecord',4,'序列号记录\r\nSerial No',NULL),(404,'mainframeTemplate_inspect',6,8,NULL,1,2,NULL,'assembleRecords:remarks',0,'备注\r\nRemarks',NULL),(404,'mainframeTemplate_inspect',7,1,NULL,1,9,NULL,'',0,'送检人员记录/Self Inspection Records',NULL),(404,'mainframeTemplate_inspect',8,1,NULL,1,1,NULL,'inspectRecords:mainframeID',0,'序号\r\nNO',NULL),(404,'mainframeTemplate_inspect',8,2,NULL,1,2,NULL,'inspectRecords:selfcheckName',0,'自检名称\r\nInspection Item',NULL),(404,'mainframeTemplate_inspect',8,4,NULL,1,2,NULL,'inspectRecords:selfcheckContent',0,'自检内容\r\nSelf Inspection Content',NULL),(404,'mainframeTemplate_inspect',8,6,NULL,1,2,NULL,'inspectRecords:selfcheckResult',4,'自检结果\r\nSelf Inspection Result',NULL),(404,'mainframeTemplate_inspect',8,8,NULL,1,2,NULL,'inspectRecords:remarks',0,'备注\r\nRemarks',NULL),(404,'mainframeTemplate_inspect',9,1,NULL,1,1,NULL,'',0,'异常记录：',NULL),(404,'mainframeTemplate_inspect',9,2,NULL,1,8,NULL,'exceptionRecord',0,'',NULL),(404,'mainframeTemplate_inspect',10,1,NULL,1,1,NULL,'',0,'备注：',NULL),(404,'mainframeTemplate_inspect',10,2,NULL,1,8,NULL,'remarks',0,'',NULL),(404,'mainframeTemplate_inspect',11,1,NULL,1,1,NULL,'',0,'装配人员：',NULL),(404,'mainframeTemplate_inspect',11,2,NULL,1,1,NULL,'assembleOperator',0,'',NULL),(404,'mainframeTemplate_inspect',11,3,NULL,1,1,NULL,'',0,'装配日期：',NULL),(404,'mainframeTemplate_inspect',11,4,NULL,1,1,NULL,'assembleTime',0,'',NULL),(404,'mainframeTemplate_inspect',11,5,NULL,1,1,NULL,'',0,'',NULL),(404,'mainframeTemplate_inspect',11,6,NULL,1,1,NULL,'',0,'送检人员：',NULL),(404,'mainframeTemplate_inspect',11,7,NULL,1,1,NULL,'inspectOperator',0,'',NULL),(404,'mainframeTemplate_inspect',11,8,NULL,1,1,NULL,'',0,'送检日期：',NULL),(404,'mainframeTemplate_inspect',11,9,NULL,1,1,NULL,'inspectTime',0,'',NULL),(401,'dspTemplate',1,1,NULL,1,9,NULL,'',0,'DSP装配流程跟踪单/PT Assembly Record',NULL),(401,'dspTemplate',2,1,NULL,1,2,NULL,'',0,'料号/PN:',NULL),(401,'dspTemplate',2,3,NULL,1,2,NULL,'dspPn',0,'',NULL),(401,'dspTemplate',2,5,NULL,1,1,NULL,'',0,'',NULL),(401,'dspTemplate',2,6,NULL,1,2,NULL,'',0,'序列号/Serial No:',NULL),(401,'dspTemplate',2,8,NULL,1,2,NULL,'serialNo',0,'',NULL),(401,'dspTemplate',3,1,NULL,1,2,NULL,'',0,'工单号/WO：',NULL),(401,'dspTemplate',3,3,NULL,1,2,NULL,'workorderNo',0,'',NULL),(401,'dspTemplate',3,5,NULL,1,1,NULL,'',0,'',NULL),(401,'dspTemplate',3,6,NULL,1,2,NULL,'',0,'客户订单信息：',NULL),(401,'dspTemplate',3,8,NULL,1,2,NULL,'cOrderID',0,'',NULL),(401,'dspTemplate',4,1,NULL,1,2,NULL,'',0,'DSP型号/Model：',NULL),(401,'dspTemplate',4,3,NULL,1,7,NULL,'dspModel',0,'',NULL),(401,'dspTemplate',5,1,NULL,1,9,NULL,'',0,'装配记录/Manufacture Record',NULL),(401,'dspTemplate',6,1,NULL,1,1,NULL,'assembleRecords:dspID',0,'序号\r\nNO',NULL),(401,'dspTemplate',6,2,NULL,1,2,NULL,'assembleRecords:componentName',0,'组件名称\r\nComponent Name',NULL),(401,'dspTemplate',6,4,NULL,1,2,NULL,'assembleRecords:componentNo',0,'装配记录\r\nAssembly Record',NULL),(401,'dspTemplate',6,6,NULL,1,2,NULL,'assembleRecords:serialNoRecord',4,'结论\r\nResult Record',NULL),(401,'dspTemplate',6,8,NULL,1,2,NULL,'assembleRecords:remarks',0,'备注\r\nRemarks',NULL),(401,'dspTemplate',7,1,NULL,1,1,NULL,'',0,'异常记录：',NULL),(401,'dspTemplate',7,2,NULL,1,8,NULL,'exceptionRecord',0,'',NULL),(401,'dspTemplate',8,1,NULL,1,1,NULL,'',0,'备注：',NULL),(401,'dspTemplate',8,2,NULL,1,8,NULL,'remarks',0,'',NULL),(401,'dspTemplate',9,1,NULL,1,5,NULL,'',0,'',NULL),(401,'dspTemplate',9,6,NULL,1,1,NULL,'',0,'装配人员：',NULL),(401,'dspTemplate',9,7,NULL,1,1,NULL,'assembleOperator',0,'',NULL),(401,'dspTemplate',9,8,NULL,1,1,NULL,'',0,'装配日期：',NULL),(401,'dspTemplate',9,9,NULL,1,1,NULL,'assembleTime',0,'',NULL),(402,'cisternTemplate',1,1,NULL,1,9,NULL,'',0,'水箱装配流程跟踪单/PT Assembly Record',NULL),(402,'cisternTemplate',2,1,NULL,1,2,NULL,'',0,'料号/PN:',NULL),(402,'cisternTemplate',2,3,NULL,1,2,NULL,'cisternPn',0,'',NULL),(402,'cisternTemplate',2,5,NULL,1,1,NULL,'',0,'',NULL),(402,'cisternTemplate',2,6,NULL,1,2,NULL,'',0,'序列号/Serial No:',NULL),(402,'cisternTemplate',2,8,NULL,1,2,NULL,'serialNo',0,'',NULL),(402,'cisternTemplate',3,1,NULL,1,2,NULL,'',0,'工单号/WO：',NULL),(402,'cisternTemplate',3,3,NULL,1,2,NULL,'workorderNo',0,'',NULL),(402,'cisternTemplate',3,5,NULL,1,1,NULL,'',0,'',NULL),(402,'cisternTemplate',3,6,NULL,1,2,NULL,'',0,'客户订单信息：',NULL),(402,'cisternTemplate',3,8,NULL,1,2,NULL,'cOrderID',0,'',NULL),(402,'cisternTemplate',4,1,NULL,1,2,NULL,'',0,'水箱型号/Model：',NULL),(402,'cisternTemplate',4,3,NULL,1,3,NULL,'cisternModel',0,'',NULL),(402,'cisternTemplate',4,6,NULL,1,2,NULL,'',0,'水箱选配件/Options：',NULL),(402,'cisternTemplate',4,8,NULL,1,1,NULL,'cisternOption',0,'',NULL),(402,'cisternTemplate',4,9,NULL,1,1,NULL,'cisternOption2',0,'',NULL),(402,'cisternTemplate',5,1,NULL,1,9,NULL,'',0,'装配记录/Manufacture Record',NULL),(402,'cisternTemplate',6,1,NULL,1,1,NULL,'assembleRecords:cisternID',0,'序号\r\nNO',NULL),(402,'cisternTemplate',6,2,NULL,1,2,NULL,'assembleRecords:componentName',0,'组件名称\r\nComponent Name',NULL),(402,'cisternTemplate',6,4,NULL,1,2,NULL,'assembleRecords:componentNo',0,'装配记录\r\nAssembly Record',NULL),(402,'cisternTemplate',6,6,NULL,1,2,NULL,'assembleRecords:serialNoRecord',4,'结论\r\nResult Record',NULL),(402,'cisternTemplate',6,8,NULL,1,2,NULL,'assembleRecords:remarks',0,'备注\r\nRemarks',NULL),(402,'cisternTemplate',7,1,NULL,1,1,NULL,'',0,'异常记录：',NULL),(402,'cisternTemplate',7,2,NULL,1,8,NULL,'exceptionRecord',0,'',NULL),(402,'cisternTemplate',8,1,NULL,1,1,NULL,'',0,'备注：',NULL),(402,'cisternTemplate',8,2,NULL,1,8,NULL,'remarks',0,'',NULL),(402,'cisternTemplate',9,1,NULL,1,5,NULL,'',0,'',NULL),(402,'cisternTemplate',9,6,NULL,1,1,NULL,'',0,'装配人员：',NULL),(402,'cisternTemplate',9,7,NULL,1,1,NULL,'assembleOperator',0,'',NULL),(402,'cisternTemplate',9,8,NULL,1,1,NULL,'',0,'装配日期：',NULL),(402,'cisternTemplate',9,9,NULL,1,1,NULL,'assembleTime',0,'',NULL),(403,'preprocessingTemplate',1,1,NULL,1,9,NULL,'',0,'预处理装配流程跟踪单/PT Assembly Record',NULL),(403,'preprocessingTemplate',2,1,NULL,1,2,NULL,'',0,'料号/PN:',NULL),(403,'preprocessingTemplate',2,3,NULL,1,2,NULL,'preprocessingPn',0,'',NULL),(403,'preprocessingTemplate',2,5,NULL,1,1,NULL,'',0,'',NULL),(403,'preprocessingTemplate',2,6,NULL,1,2,NULL,'',0,'序列号/Serial No:',NULL),(403,'preprocessingTemplate',2,8,NULL,1,2,NULL,'serialNo',0,'',NULL),(403,'preprocessingTemplate',3,1,NULL,1,2,NULL,'',0,'工单号/WO：',NULL),(403,'preprocessingTemplate',3,3,NULL,1,2,NULL,'workorderNo',0,'',NULL),(403,'preprocessingTemplate',3,5,NULL,1,1,NULL,'',0,'',NULL),(403,'preprocessingTemplate',3,6,NULL,1,2,NULL,'',0,'客户订单信息：',NULL),(403,'preprocessingTemplate',3,8,NULL,1,2,NULL,'cOrderID',0,'',NULL),(403,'preprocessingTemplate',4,1,NULL,1,2,NULL,'',0,'名称/Modle：',NULL),(403,'preprocessingTemplate',4,3,NULL,1,2,NULL,'preprocessingModel',0,'',NULL),(403,'preprocessingTemplate',4,5,NULL,1,1,NULL,'',0,'',NULL),(403,'preprocessingTemplate',4,6,NULL,1,2,NULL,'',0,'PT选配件/Options：',NULL),(403,'preprocessingTemplate',4,8,NULL,1,1,NULL,'ptOption',0,'',NULL),(403,'preprocessingTemplate',4,9,NULL,1,1,NULL,'ptOption2',0,'',NULL),(403,'preprocessingTemplate',5,1,NULL,1,9,NULL,'',0,'装配记录/Manufacture Record',NULL),(403,'preprocessingTemplate',6,1,NULL,1,1,NULL,'assembleRecords:preprocessingID',0,'序号\r\nNO',NULL),(403,'preprocessingTemplate',6,2,NULL,1,2,NULL,'assembleRecords:componentName',0,'组件名称\r\nComponent Name',NULL),(403,'preprocessingTemplate',6,4,NULL,1,2,NULL,'assembleRecords:componentNo',0,'组件型号\r\nComponent Module',NULL),(403,'preprocessingTemplate',6,6,NULL,1,2,NULL,'assembleRecords:serialNoRecord',4,'序列号记录\r\nSerial No',NULL),(403,'preprocessingTemplate',6,8,NULL,1,2,NULL,'assembleRecords:remarks',0,'备注\r\nRemarks',NULL),(403,'preprocessingTemplate',7,1,NULL,1,1,NULL,'',0,'异常记录：',NULL),(403,'preprocessingTemplate',7,2,NULL,1,8,NULL,'exceptionRecord',0,'',NULL),(403,'preprocessingTemplate',8,1,NULL,1,1,NULL,'',0,'备注：',NULL),(403,'preprocessingTemplate',8,2,NULL,1,8,NULL,'remarks',0,'',NULL),(403,'preprocessingTemplate',9,1,NULL,1,5,NULL,'',0,'',NULL),(403,'preprocessingTemplate',9,6,NULL,1,1,NULL,'',0,'装配人员：',NULL),(403,'preprocessingTemplate',9,7,NULL,1,1,NULL,'assembleOperator',0,'',NULL),(403,'preprocessingTemplate',9,8,NULL,1,1,NULL,'',0,'装配日期：',NULL),(403,'preprocessingTemplate',9,9,NULL,1,1,NULL,'assembleTime',0,'',NULL),(404,'mainframeTemplate',1,1,NULL,1,9,NULL,'',0,'主机装配流程跟踪单/PT Assembly Record',NULL),(404,'mainframeTemplate',2,1,NULL,1,2,NULL,'',0,'料号/PN:',NULL),(404,'mainframeTemplate',2,3,NULL,1,2,NULL,'mainframePn',0,'',NULL),(404,'mainframeTemplate',2,5,NULL,1,1,NULL,'',0,'',NULL),(404,'mainframeTemplate',2,6,NULL,1,2,NULL,'',0,'序列号/Serial No:',NULL),(404,'mainframeTemplate',2,8,NULL,1,2,NULL,'serialNo',0,'',NULL),(404,'mainframeTemplate',3,1,NULL,1,2,NULL,'',0,'工单号/WO：',NULL),(404,'mainframeTemplate',3,3,NULL,1,2,NULL,'workorderNo',0,'',NULL),(404,'mainframeTemplate',3,5,NULL,1,1,NULL,'',0,'',NULL),(404,'mainframeTemplate',4,6,NULL,1,2,NULL,'',0,'主机选配件/Options：',NULL),(404,'mainframeTemplate',4,8,NULL,1,1,NULL,'mainframeOption',0,'',NULL),(404,'mainframeTemplate',4,9,NULL,1,1,NULL,'mainframeOption2',0,'',NULL),(404,'mainframeTemplate',4,1,NULL,1,2,NULL,'',0,'主机型号/Modle：',NULL),(404,'mainframeTemplate',4,3,NULL,1,3,NULL,'mainframeModel',0,'',NULL),(404,'mainframeTemplate',3,6,NULL,1,2,NULL,'',0,'客户订单信息：',NULL),(404,'mainframeTemplate',3,8,NULL,1,2,NULL,'cOrderID',0,'',NULL),(404,'mainframeTemplate',5,1,NULL,1,9,NULL,'',0,'装配记录/Manufacture Record',NULL),(404,'mainframeTemplate',6,1,NULL,1,1,NULL,'assembleRecords:mainframeID',0,'序号\r\nNO',NULL),(404,'mainframeTemplate',6,2,NULL,1,2,NULL,'assembleRecords:componentName',0,'组件名称\r\nComponent Name',NULL),(404,'mainframeTemplate',6,4,NULL,1,2,NULL,'assembleRecords:componentNo',0,'组件型号\r\nComponent Module',NULL),(404,'mainframeTemplate',6,6,NULL,1,2,NULL,'assembleRecords:serialNoRecord',4,'序列号记录\r\nSerial No',NULL),(404,'mainframeTemplate',6,8,NULL,1,2,NULL,'assembleRecords:remarks',0,'备注\r\nRemarks',NULL),(404,'mainframeTemplate',7,1,NULL,1,9,NULL,'',0,'送检人员记录/Self Inspection Records',NULL),(404,'mainframeTemplate',8,1,NULL,1,1,NULL,'inspectRecords:mainframeID',0,'序号\r\nNO',NULL),(404,'mainframeTemplate',8,2,NULL,1,2,NULL,'inspectRecords:selfcheckName',0,'自检名称\r\nInspection Item',NULL),(404,'mainframeTemplate',8,4,NULL,1,2,NULL,'inspectRecords:selfcheckContent',0,'自检内容\r\nSelf Inspection Content\r\n(1:ON 0:OFF)',NULL),(404,'mainframeTemplate',8,6,NULL,1,2,NULL,'inspectRecords:selfcheckResult',4,'自检结果\r\nSelf Inspection Result',NULL),(404,'mainframeTemplate',8,8,NULL,1,2,NULL,'inspectRecords:remarks',0,'备注\r\nRemarks',NULL),(404,'mainframeTemplate',9,1,NULL,1,1,NULL,'',0,'异常记录：',NULL),(404,'mainframeTemplate',9,2,NULL,1,8,NULL,'exceptionRecord',0,'',NULL),(404,'mainframeTemplate',10,1,NULL,1,1,NULL,'',0,'备注：',NULL),(404,'mainframeTemplate',10,2,NULL,1,8,NULL,'remarks',0,'',NULL),(404,'mainframeTemplate',11,1,NULL,1,5,NULL,'',0,'',NULL),(404,'mainframeTemplate',11,6,NULL,1,1,NULL,'',0,'装配人员：',NULL),(404,'mainframeTemplate',11,7,NULL,1,1,NULL,'assembleOperator',0,'',NULL),(404,'mainframeTemplate',11,8,NULL,1,1,NULL,'',0,'装配日期：',NULL),(404,'mainframeTemplate',11,9,NULL,1,1,NULL,'assembleTime',0,'',NULL);
/*!40000 ALTER TABLE `t_ums_th_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ums_userpermission`
--

DROP TABLE IF EXISTS `t_ums_userpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ums_userpermission` (
  `OPERATORID` int(8) NOT NULL COMMENT '操作员编号',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码',
  KEY `idx_uu_userpermission_operatorid` (`OPERATORID`),
  KEY `idx_uu_userpermission_roleid` (`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ums_userpermission`
--

LOCK TABLES `t_ums_userpermission` WRITE;
/*!40000 ALTER TABLE `t_ums_userpermission` DISABLE KEYS */;
INSERT INTO `t_ums_userpermission` VALUES (20,5),(20,4),(21,148),(21,147),(21,146),(21,145),(21,144),(21,143),(21,142),(21,141),(22,140),(22,139),(22,138),(22,137),(22,136),(22,135),(22,134),(22,133),(25,5),(9,1),(27,1),(26,4),(23,132),(23,131),(23,130),(23,129),(23,128),(23,127),(23,126),(23,125),(24,123),(24,122),(24,121),(24,120),(24,119),(24,118),(24,117);
/*!40000 ALTER TABLE `t_ums_userpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `menubuttonview`
--

/*!50001 DROP VIEW IF EXISTS `menubuttonview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `menubuttonview` AS select `t_ums_menuinfo`.`MENUID` AS `menuid`,`t_ums_menuinfo`.`MENUNAME` AS `menuname`,1 AS `menutype`,`t_ums_menuinfo`.`PMENUID` AS `pmenuid` from `t_ums_menuinfo` union all select `f`.`btnid` AS `btnid`,`f`.`btncname` AS `btncname`,2 AS `menutype`,`f`.`menuid` AS `menuid` from `t_ums_menu_button` `f` where exists(select 1 from `t_ums_menuinfo` `d` where (`d`.`MENUID` = `f`.`menuid`)) */;
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

-- Dump completed on 2018-11-28 14:23:08

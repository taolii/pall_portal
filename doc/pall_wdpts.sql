/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : 127.0.0.1:3306
Source Database       : pall_wdpts

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-10-16 16:20:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_trackinglist_cistern
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_cistern`;
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

-- ----------------------------
-- Records of t_trackinglist_cistern
-- ----------------------------
INSERT INTO `t_trackinglist_cistern` VALUES ('3', '2018-09-28', '2018-09-04 16:14:52', '', 'LWFS32401S', '对方答复', '按时发生', 'Cascada II.I', null, null, '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '阿凡达', '9', '2018-09-28 16:15:09', '2018-09-28 16:15:09');
INSERT INTO `t_trackinglist_cistern` VALUES ('4', '2018-09-28', '2018-09-04 16:14:52', '', 'LWFS32401S', '对方答复', '按时发生', 'Cascada II.I', null, null, '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '阿凡达', '9', '2018-09-28 16:22:18', '2018-09-28 18:10:05');
INSERT INTO `t_trackinglist_cistern` VALUES ('5', '2018-09-28', '2018-09-04 16:14:52', 'sdfsdf33', 'LWFS32401S', '对方答复', '按时发生', 'Cascada II.I', null, null, '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '阿凡达', '9', '2018-10-09 11:32:50', '2018-10-09 11:33:04');
INSERT INTO `t_trackinglist_cistern` VALUES ('6', '2018-10-09', null, '水电费', 'LWFS32401S', '胜多负少的', '撒发生', 'Cascada II.I', '水电费', '水电费', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '胜多负少', '9', '2018-10-09 14:27:16', '2018-10-09 14:27:16');
INSERT INTO `t_trackinglist_cistern` VALUES ('7', '2018-10-09', '2018-10-09 14:27:28', '水电费', 'LWFS32401S', '胜多负少的', '撒发生', 'Cascada II.I', '水电费3', '水电费', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '胜多负少', '9', '2018-10-09 14:27:30', '2018-10-09 14:27:43');

-- ----------------------------
-- Table structure for t_trackinglist_cistern_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_cistern_assemble`;
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

-- ----------------------------
-- Records of t_trackinglist_cistern_assemble
-- ----------------------------
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('4', 'PE手动球阀|PE manual valve（3/8\"）', '球阀开关方向是否一致|Direction of PE manual valve', '0_正确Yes|不正确No', '消防水带');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('4', '底部密封方式|Bottem Sealing Element', '堵头/Stopper Probe', '1_正确Yes|不正确No', '胜多负少');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('4', '水箱盖密封类型|Tank Cap', '石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止', '1_正确Yes|不正确No', '胜多负少的吧');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('4', '整流器控制盒 Waterproof ballast box', '---', '0_有 Yes|无 No', '吃的舒服');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('4', '液位杆|Tank Level Sensor', '35L航空插液位杆/Level Sensor 35L', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('5', 'PE手动球阀|PE manual valve（3/8\"）', '球阀开关方向是否一致|Direction of PE manual valve', '0_正确Yes|不正确No', '消防水带');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('5', '底部密封方式|Bottem Sealing Element', '堵头/Stopper Probe', '1_正确Yes|不正确No', '胜多负少');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('5', '水箱盖密封类型|Tank Cap', '石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止', '1_正确Yes|不正确No', '胜多负少的吧');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('5', '整流器控制盒 Waterproof ballast box', '---', '0_有 Yes|无 No', '吃的舒服');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('5', '液位杆|Tank Level Sensor', '35L航空插液位杆/Level Sensor 35L', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('6', 'PE手动球阀|PE manual valve（3/8\"）', '球阀开关方向是否一致|Direction of PE manual valve', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('6', '底部密封方式|Bottem Sealing Element', '堵头/Stopper Probe', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('6', '水箱盖密封类型|Tank Cap', '石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止', '1_正确Yes|不正确No', '水电费');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('6', '整流器控制盒 Waterproof ballast box', '---', '0_有 Yes|无 No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('6', '液位杆|Tank Level Sensor', '35L航空插液位杆/Level Sensor 35L', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('7', 'PE手动球阀|PE manual valve（3/8\"）', '球阀开关方向是否一致|Direction of PE manual valve', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('7', '底部密封方式|Bottem Sealing Element', '堵头/Stopper Probe', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('7', '水箱盖密封类型|Tank Cap', '石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止', '1_正确Yes|不正确No', '水电费');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('7', '整流器控制盒 Waterproof ballast box', '---', '0_有 Yes|无 No', '');
INSERT INTO `t_trackinglist_cistern_assemble` VALUES ('7', '液位杆|Tank Level Sensor', '35L航空插液位杆/Level Sensor 35L', '0_正确Yes|不正确No', '');

-- ----------------------------
-- Table structure for t_trackinglist_dsp
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_dsp`;
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

-- ----------------------------
-- Records of t_trackinglist_dsp
-- ----------------------------
INSERT INTO `t_trackinglist_dsp` VALUES ('5', '2018-09-28', '2018-09-28 15:35:04', null, 'LWFS32603', '55555555555556666', '2222222222', '灵活取水手柄 III 级水     Flexible DSP Type III', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '王文', '9', '2018-09-28 16:06:59', '2018-09-28 16:06:59');
INSERT INTO `t_trackinglist_dsp` VALUES ('6', '2018-09-28', '2018-09-28 15:35:04', null, 'LWFS32603', '55555555555556666', '2222222222山东省', '灵活取水手柄 III 级水     Flexible DSP Type III', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '王文', '9', '2018-09-28 16:07:35', '2018-09-28 16:07:35');
INSERT INTO `t_trackinglist_dsp` VALUES ('7', '2018-09-28', '2018-09-28 15:35:04', 'zfsfsdfd', 'LWFS32603', '55555555555556666', '2222222222山东省', '灵活取水手柄 III 级水     Flexible DSP Type III', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '王文', '9', '2018-10-09 11:31:19', '2018-10-09 11:33:33');

-- ----------------------------
-- Table structure for t_trackinglist_dsp_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_dsp_assemble`;
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

-- ----------------------------
-- Records of t_trackinglist_dsp_assemble
-- ----------------------------
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('5', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '0_合格 Pass|不合格 Fail', 'sada');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('5', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '1_合格 Pass|不合格 Fail', 'asdas');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('5', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('5', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '1_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('5', '远程取水站配件|Remote DSP With Station accessories', '底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('5', '远程取水站配件|Remote DSP With Station accessories', '底座水路上下盖（Cable位置，外观）|Dispenser base inspection', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('5', '远程取水站配件|Remote DSP With Station accessories', '铝杆支架及螺钉|Dispenser base inspection', '0_有 Yes|无 No', 'sdfsd');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('6', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '0_合格 Pass|不合格 Fail', 'sada');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('6', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '1_合格 Pass|不合格 Fail', 'asdas');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('6', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('6', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '1_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('6', '远程取水站配件|Remote DSP With Station accessories', '底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('6', '远程取水站配件|Remote DSP With Station accessories', '底座水路上下盖（Cable位置，外观）|Dispenser base inspection', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('6', '远程取水站配件|Remote DSP With Station accessories', '铝杆支架及螺钉|Dispenser base inspection', '0_有 Yes|无 No', 'sdfsd');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('7', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '0_合格 Pass|不合格 Fail', 'sada');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('7', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '1_合格 Pass|不合格 Fail', 'asdas');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('7', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('7', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '1_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('7', '远程取水站配件|Remote DSP With Station accessories', '底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('7', '远程取水站配件|Remote DSP With Station accessories', '底座水路上下盖（Cable位置，外观）|Dispenser base inspection', '0_合格 Pass|不合格 Fail', 'asda');
INSERT INTO `t_trackinglist_dsp_assemble` VALUES ('7', '远程取水站配件|Remote DSP With Station accessories', '铝杆支架及螺钉|Dispenser base inspection', '0_有 Yes|无 No', 'sdfsd');

-- ----------------------------
-- Table structure for t_trackinglist_mainframe
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_mainframe`;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='主机装配流程跟踪单表'
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

-- ----------------------------
-- Records of t_trackinglist_mainframe
-- ----------------------------
INSERT INTO `t_trackinglist_mainframe` VALUES ('4', '2018-09-28', '2018-09-28 18:08:01', '', 'LWFS31101C', '撒发生', '撒发生', 'Cascada I', '水电费', '水电费是', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '阿萨德', '', null, '9', '2018-09-28 18:08:26', '2018-09-28 18:09:44');
INSERT INTO `t_trackinglist_mainframe` VALUES ('5', '2018-09-28', '2018-09-28 18:08:01', '', 'LWFS31101C', '撒发生', '撒发生', 'Cascada I', '水电费', '水电费是', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '阿萨德', '', null, '9', '2018-09-28 18:09:51', '2018-09-28 18:09:51');
INSERT INTO `t_trackinglist_mainframe` VALUES ('6', '2018-09-28', '2018-09-28 18:08:01', 'asfda33', 'LWFS31101C', '撒发生', '撒发生', 'Cascada I', '水电费', '水电费是', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '阿萨德', '', null, '9', '2018-10-09 11:35:43', '2018-10-10 18:25:57');

-- ----------------------------
-- Table structure for t_trackinglist_mainframe_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_mainframe_assemble`;
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

-- ----------------------------
-- Records of t_trackinglist_mainframe_assemble
-- ----------------------------
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '开关电源（主机）|Power module (MU)', 'SP-200-24', '阿达', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '循环泵|Recirculation pump', 'EC-203-300ARS', 'SJZ-EC-阿萨德', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '循环压力变送器|Loop PT3', 'MPM4150', '阿萨德', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '水质变送器|Water quality transducer', 'CM2 RO产水电导仪 RO quality sensor', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '水质变送器|Water quality transducer', '2# 电导变送器     2# transducer', '', '阿达');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '水质变送器|Water quality transducer', 'CM4中间电导 Intermediate sensor', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '水质变送器|Water quality transducer', '6# 电导变送器     2# transducer', '阿萨德', '阿萨德');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '水质变送器|Water quality transducer', 'CM6 UP产水电导仪 UP quality sensor', '阿萨德', '阿萨德');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '主机主板|Main unit PCB', 'Cascada MU-MAIN PCB(2 levels)', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('4', '主机显示屏|Main unit LCD', 'MU LCD PCB with touch screen LCD', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '开关电源（主机）|Power module (MU)', 'SP-200-24', '阿达', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '循环泵|Recirculation pump', 'EC-203-300ARS', 'SJZ-EC-阿萨德', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '循环压力变送器|Loop PT3', 'MPM4150', '阿萨德', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '水质变送器|Water quality transducer', 'CM2 RO产水电导仪 RO quality sensor', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '水质变送器|Water quality transducer', '2# 电导变送器     2# transducer', '', '阿达');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '水质变送器|Water quality transducer', 'CM4中间电导 Intermediate sensor', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '水质变送器|Water quality transducer', '6# 电导变送器     2# transducer', '阿萨德', '阿萨德');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '水质变送器|Water quality transducer', 'CM6 UP产水电导仪 UP quality sensor', '阿萨德', '阿萨德');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '主机主板|Main unit PCB', 'Cascada MU-MAIN PCB(2 levels)', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('5', '主机显示屏|Main unit LCD', 'MU LCD PCB with touch screen LCD', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '开关电源（主机）|Power module (MU)', 'SP-200-24', '阿达1', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '循环泵|Recirculation pump', 'EC-203-300ARS', 'SJZ-EC-阿萨德', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '循环压力变送器|Loop PT3', 'MPM4150', '阿萨德', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '水质变送器|Water quality transducer', 'CM2 RO产水电导仪 RO quality sensor', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '水质变送器|Water quality transducer', '2# 电导变送器     2# transducer', '', '阿达');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '水质变送器|Water quality transducer', 'CM4中间电导 Intermediate sensor', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '水质变送器|Water quality transducer', '6# 电导变送器     2# transducer', '阿萨德', '阿萨德');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '水质变送器|Water quality transducer', 'CM6 UP产水电导仪 UP quality sensor', '阿萨德', '阿萨德');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '主机主板|Main unit PCB', 'Cascada MU-MAIN PCB(2 levels)', '', '');
INSERT INTO `t_trackinglist_mainframe_assemble` VALUES ('6', '主机显示屏|Main unit LCD', 'MU LCD PCB with touch screen LCD', '', '');

-- ----------------------------
-- Table structure for t_trackinglist_mainframe_inspect
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_mainframe_inspect`;
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

-- ----------------------------
-- Records of t_trackinglist_mainframe_inspect
-- ----------------------------
INSERT INTO `t_trackinglist_mainframe_inspect` VALUES ('4', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '0_合格/Pass|不合格/Fail', '');
INSERT INTO `t_trackinglist_mainframe_inspect` VALUES ('4', '拨码记录|Dial switch ', '1|2|3|4|5|6|7|8', '型号/Type：', '');
INSERT INTO `t_trackinglist_mainframe_inspect` VALUES ('5', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '0_合格/Pass|不合格/Fail', '');
INSERT INTO `t_trackinglist_mainframe_inspect` VALUES ('5', '拨码记录|Dial switch ', '1|2|3|4|5|6|7|8', '型号/Type：', '');
INSERT INTO `t_trackinglist_mainframe_inspect` VALUES ('6', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '0_合格/Pass|不合格/Fail', '');
INSERT INTO `t_trackinglist_mainframe_inspect` VALUES ('6', '拨码记录|Dial switch ', '1|2|3|4|5|6|7|8', '型号/Type：', '');

-- ----------------------------
-- Table structure for t_trackinglist_preprocessing
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_preprocessing`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1289 DEFAULT CHARSET=utf8 COMMENT='预处理装配流程跟踪单表'
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

-- ----------------------------
-- Records of t_trackinglist_preprocessing
-- ----------------------------
INSERT INTO `t_trackinglist_preprocessing` VALUES ('1280', '2018-09-23', '2018-09-06 03:29:33', '', 'LWFS32701PC', '4444444', '5677886', '2342432', '2. -C CM1', '1. -P Raw Pump', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', 'sdas', 'asdas', '2018-09-17', '9', '2018-09-06 03:30:37', '2018-09-06 03:30:37');
INSERT INTO `t_trackinglist_preprocessing` VALUES ('1281', '2018-09-23', '2018-09-06 03:29:33', '', 'LWFS32701PC', '4444444', '5677886', '2342432', '2. -C CM1', '1. -P Raw Pump', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', 'sdas', 'asdas', '2018-09-17', '9', '2018-09-06 03:30:42', '2018-09-06 03:30:42');
INSERT INTO `t_trackinglist_preprocessing` VALUES ('1287', '2018-09-28', '2018-09-28 16:45:11', '', 'LWFS32701C', '撒发生', '山东省', 'Pretreatment', '是房地产商', '水电费', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '是非得失', '', null, '9', '2018-09-28 16:49:32', '2018-09-28 17:50:56');
INSERT INTO `t_trackinglist_preprocessing` VALUES ('1288', '2018-09-28', '2018-09-28 16:45:11', 'sdfsdd', 'LWFS32701C', '撒发生', '山东省', 'Pretreatment', '是房地产商', '水电费', '', '若无特别说明，装配跟踪单记录人员即为装配人员，若非记录者装配设备请于备注处注明。', '是非得失', '', null, '9', '2018-10-09 11:33:49', '2018-10-09 11:33:58');

-- ----------------------------
-- Table structure for t_trackinglist_preprocessing_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_preprocessing_assemble`;
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

-- ----------------------------
-- Records of t_trackinglist_preprocessing_assemble
-- ----------------------------
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '开关电源（预处理）|Power module (PT)', 'SP-75-24', null, 'ddfd');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '源水增压泵|Raw water boost pump', 'EC-203-300ARS', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '水质变送器|Water quality transducer', 'CM1源水电导仪|CM1 Raw water sensor', null, 'dfdsf');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '水质变送器|Water quality transducer', '1#电导变送器|1# Conductivity transducer', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', null, 'sdfs');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', 'PT减压阀|Pressure Regulator (feed water)', 'PRV-3-SH', null, 'sdfs');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', null, 'sdfs');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1280', '低压开关|Pressure switch (feed water)', '-', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '开关电源（预处理）|Power module (PT)', 'SP-75-24', null, 'ddfd');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '源水增压泵|Raw water boost pump', 'EC-203-300ARS', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '水质变送器|Water quality transducer', 'CM1源水电导仪|CM1 Raw water sensor', null, 'dfdsf');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '水质变送器|Water quality transducer', '1#电导变送器|1# Conductivity transducer', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', null, 'sdfs');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', 'PT减压阀|Pressure Regulator (feed water)', 'PRV-3-SH', null, 'sdfs');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', null, 'sdfs');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1281', '低压开关|Pressure switch (feed water)', '-', null, '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', '开关电源（预处理）|Power module (PT)', 'SP-75-24', '胜多负少', '是否');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', '水质变送器|Water quality transducer', 'CM1源水电导仪|CM1 Raw water sensor', '水电费', '水电费');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', '水质变送器|Water quality transducer', '1#电导变送器 |1# Conductivity transducer', '', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', '水电费', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', '', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', 'PT减压阀|Pressure Regulator', 'PRV-3-SH', '1_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1287', '低压开关|Pressure switch (feed water)', '-', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', '开关电源（预处理）|Power module (PT)', 'SP-75-24', '胜多负少', '是否');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', '水质变送器|Water quality transducer', 'CM1源水电导仪|CM1 Raw water sensor', '水电费', '水电费');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', '水质变送器|Water quality transducer', '1#电导变送器 |1# Conductivity transducer', '', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', '水电费', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', '', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', 'PT减压阀|Pressure Regulator', 'PRV-3-SH', '1_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', '0_正确Yes|不正确No', '');
INSERT INTO `t_trackinglist_preprocessing_assemble` VALUES ('1288', '低压开关|Pressure switch (feed water)', '-', '0_正确Yes|不正确No', '');

-- ----------------------------
-- Table structure for t_trackinglist_preprocessing_inspect
-- ----------------------------
DROP TABLE IF EXISTS `t_trackinglist_preprocessing_inspect`;
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

-- ----------------------------
-- Records of t_trackinglist_preprocessing_inspect
-- ----------------------------
INSERT INTO `t_trackinglist_preprocessing_inspect` VALUES ('1280', '流路及组件检查/Inspection', null, null, 'ddfd');
INSERT INTO `t_trackinglist_preprocessing_inspect` VALUES ('1281', '流路及组件检查/Inspection', null, null, 'ddfd');
INSERT INTO `t_trackinglist_preprocessing_inspect` VALUES ('1287', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '0_合格/Pass|不合格/Fail', '是否');
INSERT INTO `t_trackinglist_preprocessing_inspect` VALUES ('1288', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '0_合格/Pass|不合格/Fail', '是否');

-- ----------------------------
-- Table structure for t_ums_accountloginlog
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_accountloginlog`;
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

-- ----------------------------
-- Records of t_ums_accountloginlog
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_acctivesessions
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_acctivesessions`;
CREATE TABLE `t_ums_acctivesessions` (
  `activesessionid` bigint(22) NOT NULL AUTO_INCREMENT COMMENT '主键ＩＤ',
  `operatorid` int(11) NOT NULL COMMENT '操作员ＩＤ',
  `loginname` varchar(100) NOT NULL DEFAULT '' COMMENT '帐号',
  `logintime` datetime NOT NULL COMMENT '登陆时间',
  `loginip` varchar(20) DEFAULT NULL COMMENT '登陆ＩＰ',
  PRIMARY KEY (`activesessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会话表';

-- ----------------------------
-- Records of t_ums_acctivesessions
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_admininfo
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_admininfo`;
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

-- ----------------------------
-- Records of t_ums_admininfo
-- ----------------------------
INSERT INTO `t_ums_admininfo` VALUES ('9', '超级管理员', 'admin', 'admin', '1', '', null, '13816763234', '13434@1632', null, null, '1', '2', '1', '2017-07-08 00:55:55', '2018-09-28 10:42:35');
INSERT INTO `t_ums_admininfo` VALUES ('20', 'admin', 'test', 'admin', '0', '', null, '13816763233', '13816763233@163.com', '', '', '1', '2', '1', '2018-09-06 20:38:01', '2018-09-06 20:43:49');
INSERT INTO `t_ums_admininfo` VALUES ('21', 'admin', 'zhuji', 'admin', '0', '', null, '13816763233', '1213@163.com', '', '', '1', '2', '1', '2018-09-20 01:02:22', '2018-09-20 01:02:22');
INSERT INTO `t_ums_admininfo` VALUES ('22', 'admin', 'yuchuli', 'admin', '0', '', null, '13816763233', '1213@163.com', '', '', '1', '2', '1', '2018-09-20 01:02:46', '2018-09-20 01:02:46');
INSERT INTO `t_ums_admininfo` VALUES ('23', 'admin', 'shuixiang', 'admin', '0', '', null, '13816763233', '1213@163.com', '', '', '1', '2', '1', '2018-09-20 01:03:06', '2018-09-28 11:35:37');
INSERT INTO `t_ums_admininfo` VALUES ('24', 'admin', 'dspl', 'admin', '0', '', null, '13816763233', '1213@163.com', '', '', '1', '2', '1', '2018-09-20 01:03:36', '2018-09-28 13:59:54');
INSERT INTO `t_ums_admininfo` VALUES ('25', 'admin', 'peizhi', 'admin', '0', '', null, '13816763233', '1213@163.com', '', '', '1', '2', '1', '2018-09-20 01:03:57', '2018-09-20 01:03:57');
INSERT INTO `t_ums_admininfo` VALUES ('26', 'admin', 'genzhong', 'admin', '0', '', null, '13816763233', '1213@163.com', '', '', '1', '2', '1', '2018-09-20 01:04:07', '2018-09-28 10:44:25');
INSERT INTO `t_ums_admininfo` VALUES ('27', 'admin', 'chaoji', 'admin', '0', '', null, '13816763233', '1213@163.com', '', '', '1', '2', '1', '2018-09-20 01:04:16', '2018-09-28 10:43:18');

-- ----------------------------
-- Table structure for t_ums_config
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_config`;
CREATE TABLE `t_ums_config` (
  `CONFIGID` int(11) NOT NULL COMMENT '配置项编号',
  `CONFIGNAME` varchar(100) NOT NULL COMMENT '配置项名称',
  `CONFIGTYPE` int(2) NOT NULL COMMENT '配置项子系统类型：1-PUBLIC;2-polish;3-clean;',
  `CONFIGVALUE` text COMMENT '配置项取值',
  `CONFIGEXPRESSION` varchar(250) DEFAULT NULL COMMENT '配置项正则表达式',
  `ALLOWMODIFY` int(2) NOT NULL COMMENT '否可以修改：1-可以更改；2-不可以更改',
  `DESCRIPTION` text COMMENT '配置项描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';

-- ----------------------------
-- Records of t_ums_config
-- ----------------------------
INSERT INTO `t_ums_config` VALUES ('83', 'paging/pagesize', '1', '10', null, '2', '系统默认分页大小');
INSERT INTO `t_ums_config` VALUES ('3', 'excel/export/records/limits', '1', '100000', null, '2', 'excel结果集导出最大限制数');
INSERT INTO `t_ums_config` VALUES ('32', 'default/root/menuid', '1', '-1', null, '2', '默认根节点菜单id');
INSERT INTO `t_ums_config` VALUES ('33', 'default/root/roleid', '1', '-1', null, '2', '分页默认角色根节点id');
INSERT INTO `t_ums_config` VALUES ('35', 'dataconfig/type/list', '1', '1', null, '2', '数据配置表代表基础数据配置列表类型');
INSERT INTO `t_ums_config` VALUES ('100', 'tracklinglist/dsp/menuid', '1', '401', null, '2', 'DSP装配流程跟踪单流程菜单id');
INSERT INTO `t_ums_config` VALUES ('101', 'tracklinglist/cistern/menuid', '1', '402', null, '2', ' 水箱装配流程跟踪单流程菜单id');
INSERT INTO `t_ums_config` VALUES ('102', 'tracklinglist/preprocessing/menuid', '1', '403', null, '2', '预处理装配流程跟踪单流程菜单id');
INSERT INTO `t_ums_config` VALUES ('103', 'tracklinglist/mainFrame/menuid', '1', '404', null, '2', '主机装配流程跟踪单流程菜单id');
INSERT INTO `t_ums_config` VALUES ('104', 'tracklinglist/dsp/tablename', '1', 'dspTable401', null, '2', 'DSP装配流程跟踪单流程配置表名');
INSERT INTO `t_ums_config` VALUES ('105', 'tracklinglist/cistern/tablename', '1', 'cisternTable402', null, '2', '水箱装配流程跟踪单流程配置表名');
INSERT INTO `t_ums_config` VALUES ('106', 'tracklinglist/preprocessing/tablename', '1', 'preprocessingTable403', null, '2', '预处理装配流程跟踪单流程配置表名');
INSERT INTO `t_ums_config` VALUES ('107', 'tracklinglist/mainFrame/tablename', '1', 'mainframeTable404', null, '2', '主机装配流程跟踪单流程配置表名');
INSERT INTO `t_ums_config` VALUES ('108', 'trackinglist/preprocessing/download/subdirectory', '1', 'preprocessing', null, '2', '预处理装配流程跟踪单流程下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('109', 'tracklinglist/preprocessing/templatename', '1', 'preprocessingTemplate403', null, '2', ' 预处理装配流程跟踪单流程导出模板');
INSERT INTO `t_ums_config` VALUES ('109', 'tracklinglist/mainFrame/templatename', '1', 'mainframeTemplate404', null, '2', '主机装配流程跟踪单流程导出模板');
INSERT INTO `t_ums_config` VALUES ('110', 'trackinglist/mainFrame/download/subdirectory', '1', 'mainFrame', null, '2', '主机装配流程跟踪单流程下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('111', 'tracklinglist/dsp/templatename', '1', 'dspTemplate401', null, '2', 'DSP装配流程跟踪单流程导出模板');
INSERT INTO `t_ums_config` VALUES ('112', 'trackinglist/dsp/download/subdirectory', '1', 'dsp', null, '2', null);
INSERT INTO `t_ums_config` VALUES ('113', 'tracklinglist/cistern/templatename', '1', 'cisternTemplate402', null, '2', '水箱装配流程跟踪单流程导出模板');
INSERT INTO `t_ums_config` VALUES ('114', 'trackinglist/cistern/download/subdirectory', '1', 'cistern', null, '2', '水箱装配流程跟踪单流程下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('82', 'right/button/righttype', '1', '2', null, '2', '权限表中button对应的righttype');
INSERT INTO `t_ums_config` VALUES ('4', 'right/menu/righttype', '1', '1', null, '2', '权限表中menu对应的righttype');
INSERT INTO `t_ums_config` VALUES ('115', 'trackinglist/dsp/dataconfig/type/dspModel', '1', '48', null, '2', 'DSP配置_DSP型号/Model');
INSERT INTO `t_ums_config` VALUES ('116', 'trackinglist/cistern/dataconfig/type/cisternModel', '1', '49', null, '2', '水箱配置_水箱型号/Model');
INSERT INTO `t_ums_config` VALUES ('117', 'trackinglist/preprocessing/dataconfig/type/preprocessingModel', '1', '50', null, '2', '预处理配置_名称/Model');
INSERT INTO `t_ums_config` VALUES ('118', 'trackinglist/mainframe/dataconfig/type/mainframeModel', '1', '51', null, '2', '主机_主机型号/Model');

-- ----------------------------
-- Table structure for t_ums_data_button
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_data_button`;
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

-- ----------------------------
-- Records of t_ums_data_button
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_data_config
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_data_config`;
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
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='数据字典配置表';

-- ----------------------------
-- Records of t_ums_data_config
-- ----------------------------
INSERT INTO `t_ums_data_config` VALUES ('48', '1', 'DSP配置_DSP型号/Model', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('49', '1', '水箱配置_水箱型号/Model', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('50', '1', '预处理配置_名称/Model', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('51', '1', '主机_主机型号/Model', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('64', '48', '远程取水站 I 级水      DSP With Station Type I', '', '9', '2018-09-26 16:32:20', '2018-09-26 16:32:20');
INSERT INTO `t_ums_data_config` VALUES ('65', '48', '远程取水站 II 级水      DSP With Station Type II', '', '9', '2018-09-26 16:33:04', '2018-09-26 16:33:04');
INSERT INTO `t_ums_data_config` VALUES ('66', '48', '远程取水站 III级水      DSP With Station Type III', '', '9', '2018-09-26 16:33:58', '2018-09-26 16:33:58');
INSERT INTO `t_ums_data_config` VALUES ('67', '48', '灵活取水手柄 I 级水     Flexible DSP Type I', '', '9', '2018-09-26 16:35:02', '2018-09-26 16:35:02');
INSERT INTO `t_ums_data_config` VALUES ('68', '48', '灵活取水手柄 II 级水     Flexible DSP Type II', '', '9', '2018-09-26 16:35:55', '2018-09-26 16:35:55');
INSERT INTO `t_ums_data_config` VALUES ('69', '48', '灵活取水手柄 III 级水     Flexible DSP Type III', '', '9', '2018-09-26 16:36:59', '2018-09-26 16:36:59');
INSERT INTO `t_ums_data_config` VALUES ('70', '50', 'Pretreatment', '', '9', '2018-09-26 16:38:45', '2018-09-26 16:38:45');
INSERT INTO `t_ums_data_config` VALUES ('71', '49', 'PE Reservoir 35 L', '', '9', '2018-09-26 16:46:37', '2018-09-26 16:46:37');
INSERT INTO `t_ums_data_config` VALUES ('72', '49', 'Cascada II.I', '', '9', '2018-09-26 16:47:30', '2018-09-26 16:47:30');
INSERT INTO `t_ums_data_config` VALUES ('73', '51', 'Cascada III', '', '9', '2018-09-26 16:51:57', '2018-09-26 16:51:57');
INSERT INTO `t_ums_data_config` VALUES ('74', '51', 'Cascada I', '', '9', '2018-09-26 16:52:19', '2018-09-26 16:52:19');
INSERT INTO `t_ums_data_config` VALUES ('75', '51', 'Cascada II.I', '', '9', '2018-09-26 16:52:32', '2018-09-26 16:52:32');
INSERT INTO `t_ums_data_config` VALUES ('76', '51', 'Cascada III.I', '', '9', '2018-09-26 16:52:44', '2018-09-26 16:52:44');

-- ----------------------------
-- Table structure for t_ums_deptinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_deptinfo`;
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

-- ----------------------------
-- Records of t_ums_deptinfo
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_loginlimitinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_loginlimitinfo`;
CREATE TABLE `t_ums_loginlimitinfo` (
  `LIMITID` bigint(22) NOT NULL COMMENT 'id',
  `ACCOUNT` varchar(30) DEFAULT NULL COMMENT '帐号名',
  `LIMITSTARTTIME` datetime DEFAULT NULL COMMENT '限制登录开始时间',
  `LIMITENDTIME` datetime DEFAULT NULL COMMENT '限制登录结束时间',
  `LIMITIP` text COMMENT '受限ip串',
  `OPERATORID` bigint(22) NOT NULL COMMENT '操作员编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帐号受限信息表';

-- ----------------------------
-- Records of t_ums_loginlimitinfo
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_menuinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_menuinfo`;
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

-- ----------------------------
-- Records of t_ums_menuinfo
-- ----------------------------
INSERT INTO `t_ums_menuinfo` VALUES ('1', '基础管理', 'menu-icon glyphicon glyphicon-cog', null, '0', '0', '-1', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('4', '水机跟踪管理', 'menu-icon glyphicon glyphicon-tint', null, '0', '0', '-1', '5', '');
INSERT INTO `t_ums_menuinfo` VALUES ('5', '水机配置管理', 'menu-icon glyphicons\r\nglyphicon glyphicon-asterisk', null, '0', '0', '-1', '4', '');
INSERT INTO `t_ums_menuinfo` VALUES ('101', '权限管理', '胜多负少', null, '1', '1', '1', '1', '');
INSERT INTO `t_ums_menuinfo` VALUES ('102', '用户管理', '\r\nmenu-icon glyphicon glyphicon-user', '/user/userManage', '1', '0', '1', '2', null);
INSERT INTO `t_ums_menuinfo` VALUES ('103', '角色管理', 'menu-icon glyphicon glyphicon-asterisk', '/role/roleManage', '1', '1', '1', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('104', '权限配置管理', 'menu-icon glyphicons \r\nglyphicons-user', '/right/rightManage', '1', '1', '1', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('105', '菜单管理', 'menu-icon glyphicon glyphicon-eye-open', '/menu/menuManage', '1', '1', '1', '5', null);
INSERT INTO `t_ums_menuinfo` VALUES ('107', '数据配置管理', 'menu-icon glyphicon glyphicons-settings', '/dataconfig/dataConfigManage', '1', '0', '1', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('108', '按钮管理', 'menu-icon glyphicon glyphicon-eye-open', '/button/buttonManage', '1', '1', '1', '8', '');
INSERT INTO `t_ums_menuinfo` VALUES ('401', 'DSP装配流程跟踪单', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/trackinglist/dspManage', '1', '0', '4', '1', '');
INSERT INTO `t_ums_menuinfo` VALUES ('402', '水箱装配流程跟踪单', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/trackinglist/cisternManage', '1', '0', '4', '2', '');
INSERT INTO `t_ums_menuinfo` VALUES ('403', '预处理装配流程跟踪单', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/trackinglist/preprocessingManage', '1', '0', '4', '3', '');
INSERT INTO `t_ums_menuinfo` VALUES ('404', '主机装配流程跟踪单', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/trackinglist/mainframeManage', '1', '0', '4', '4', '');
INSERT INTO `t_ums_menuinfo` VALUES ('501', 'DSP配置', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/setting/dspSetting', '1', '0', '5', '1', '');
INSERT INTO `t_ums_menuinfo` VALUES ('502', '水箱配置', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/setting/cisternSetting', '1', '0', '5', '2', '');
INSERT INTO `t_ums_menuinfo` VALUES ('503', '预处理配置', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/setting/preprocessingSetting', '1', '0', '5', '3', '');
INSERT INTO `t_ums_menuinfo` VALUES ('504', '主机配置', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/setting/mainframeSetting', '1', '0', '5', '4', '');

-- ----------------------------
-- Table structure for t_ums_menu_button
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_menu_button`;
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

-- ----------------------------
-- Records of t_ums_menu_button
-- ----------------------------
INSERT INTO `t_ums_menu_button` VALUES ('2000', '401', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('2001', '401', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('2002', '401', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('2003', '401', 'exportRow', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('2004', '401', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('2005', '401', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('2006', '401', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('2007', '401', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('2008', '402', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('2009', '402', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('2010', '402', 'exportRow', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('2011', '402', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('2012', '402', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('2013', '402', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('2014', '402', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('2015', '402', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('2016', '403', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('2017', '403', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('2018', '403', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('2019', '403', 'exportRow', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('2020', '403', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('2021', '403', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('2022', '403', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('2023', '403', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('2024', '404', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('2025', '404', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('2026', '404', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('2027', '404', 'exportRow', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('2028', '404', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('2029', '404', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('2030', '404', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('2031', '404', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);

-- ----------------------------
-- Table structure for t_ums_provinceinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_provinceinfo`;
CREATE TABLE `t_ums_provinceinfo` (
  `PROVINCEID` varchar(50) NOT NULL COMMENT '省份编码',
  `PROVINCENAME` varchar(50) NOT NULL COMMENT '省名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省份信息表';

-- ----------------------------
-- Records of t_ums_provinceinfo
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_right
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_right`;
CREATE TABLE `t_ums_right` (
  `RIGHTID` int(10) NOT NULL AUTO_INCREMENT COMMENT '权限编码',
  `RIGHTTYPE` int(2) NOT NULL COMMENT '权限类型  1 菜单权限',
  `DATAID` int(4) NOT NULL COMMENT '数据权限id,如权限类型为菜单，则dataid则为菜单id，依次类推',
  `DESCRIPTION` text COMMENT '浏览按钮权限描述',
  PRIMARY KEY (`RIGHTID`),
  KEY `idx_ur_right_righttype_dataid` (`RIGHTTYPE`,`DATAID`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COMMENT='权限信息表';

-- ----------------------------
-- Records of t_ums_right
-- ----------------------------
INSERT INTO `t_ums_right` VALUES ('1', '1', '1', null);
INSERT INTO `t_ums_right` VALUES ('2', '1', '2', null);
INSERT INTO `t_ums_right` VALUES ('3', '1', '101', null);
INSERT INTO `t_ums_right` VALUES ('4', '1', '102', null);
INSERT INTO `t_ums_right` VALUES ('5', '1', '103', null);
INSERT INTO `t_ums_right` VALUES ('6', '1', '104', null);
INSERT INTO `t_ums_right` VALUES ('7', '1', '105', null);
INSERT INTO `t_ums_right` VALUES ('9', '1', '107', null);
INSERT INTO `t_ums_right` VALUES ('10', '1', '108', null);
INSERT INTO `t_ums_right` VALUES ('100', '1', '4', null);
INSERT INTO `t_ums_right` VALUES ('101', '1', '401', null);
INSERT INTO `t_ums_right` VALUES ('102', '1', '402', null);
INSERT INTO `t_ums_right` VALUES ('103', '1', '403', null);
INSERT INTO `t_ums_right` VALUES ('104', '1', '404', null);
INSERT INTO `t_ums_right` VALUES ('110', '1', '5', null);
INSERT INTO `t_ums_right` VALUES ('111', '1', '501', null);
INSERT INTO `t_ums_right` VALUES ('112', '1', '502', null);
INSERT INTO `t_ums_right` VALUES ('113', '1', '503', null);
INSERT INTO `t_ums_right` VALUES ('114', '1', '504', null);
INSERT INTO `t_ums_right` VALUES ('124', '2', '2000', null);
INSERT INTO `t_ums_right` VALUES ('125', '2', '2001', null);
INSERT INTO `t_ums_right` VALUES ('126', '2', '2002', null);
INSERT INTO `t_ums_right` VALUES ('127', '2', '2003', null);
INSERT INTO `t_ums_right` VALUES ('128', '2', '2004', null);
INSERT INTO `t_ums_right` VALUES ('129', '2', '2005', null);
INSERT INTO `t_ums_right` VALUES ('130', '2', '2006', null);
INSERT INTO `t_ums_right` VALUES ('131', '2', '2007', null);
INSERT INTO `t_ums_right` VALUES ('132', '2', '2008', null);
INSERT INTO `t_ums_right` VALUES ('133', '2', '2009', null);
INSERT INTO `t_ums_right` VALUES ('134', '2', '2010', null);
INSERT INTO `t_ums_right` VALUES ('135', '2', '2011', null);
INSERT INTO `t_ums_right` VALUES ('136', '2', '2012', null);
INSERT INTO `t_ums_right` VALUES ('137', '2', '2013', null);
INSERT INTO `t_ums_right` VALUES ('138', '2', '2014', null);
INSERT INTO `t_ums_right` VALUES ('139', '2', '2015', null);
INSERT INTO `t_ums_right` VALUES ('140', '2', '2016', null);
INSERT INTO `t_ums_right` VALUES ('141', '2', '2017', null);
INSERT INTO `t_ums_right` VALUES ('142', '2', '2018', null);
INSERT INTO `t_ums_right` VALUES ('143', '2', '2019', null);
INSERT INTO `t_ums_right` VALUES ('144', '2', '2020', null);
INSERT INTO `t_ums_right` VALUES ('145', '2', '2021', null);
INSERT INTO `t_ums_right` VALUES ('146', '2', '2022', null);
INSERT INTO `t_ums_right` VALUES ('147', '2', '2023', null);
INSERT INTO `t_ums_right` VALUES ('148', '2', '2024', null);
INSERT INTO `t_ums_right` VALUES ('149', '2', '2025', null);
INSERT INTO `t_ums_right` VALUES ('150', '2', '2026', null);
INSERT INTO `t_ums_right` VALUES ('151', '2', '2027', null);
INSERT INTO `t_ums_right` VALUES ('152', '2', '2028', null);
INSERT INTO `t_ums_right` VALUES ('153', '2', '2029', null);
INSERT INTO `t_ums_right` VALUES ('154', '2', '2030', null);
INSERT INTO `t_ums_right` VALUES ('155', '2', '2031', null);

-- ----------------------------
-- Table structure for t_ums_role
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_role`;
CREATE TABLE `t_ums_role` (
  `ROLEID` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `ROLENAME` varchar(60) DEFAULT '' COMMENT '角色名',
  `PROLEID` int(10) DEFAULT NULL,
  `DESCRIPTION` varchar(400) DEFAULT '' COMMENT '角色描述语言值',
  PRIMARY KEY (`ROLEID`),
  KEY `idx_ur_role_rolename` (`ROLENAME`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of t_ums_role
-- ----------------------------
INSERT INTO `t_ums_role` VALUES ('1', '超级角色', '-1', '');
INSERT INTO `t_ums_role` VALUES ('4', '饮水机跟踪管理', '-1', '');
INSERT INTO `t_ums_role` VALUES ('5', '饮水机配置管理', '-1', '');
INSERT INTO `t_ums_role` VALUES ('117', 'DSP装配流程_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('118', 'DSP装配流程_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('119', 'DSP装配流程_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('120', 'DSP装配流程_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('121', 'DSP装配流程_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('122', 'DSP装配流程_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('123', 'DSP装配流程_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('124', 'DSP装配流程_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('125', '水箱装配流程_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('126', '水箱装配流程_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('127', '水箱装配流程_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('128', '水箱装配流程_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('129', '水箱装配流程_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('130', '水箱装配流程_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('131', '水箱装配流程_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('132', '水箱装配流程_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('133', '预处理装配流程_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('134', '预处理装配流程_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('135', '预处理装配流程_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('136', '预处理装配流程_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('137', '预处理装配流程_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('138', '预处理装配流程_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('139', '预处理装配流程_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('140', '预处理装配流程_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('141', '主机装配流程_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('142', '主机装配流程_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('143', '主机装配流程_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('144', '主机装配流程_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('145', '主机装配流程_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('146', '主机装配流程_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('147', '主机装配流程_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('148', '主机装配流程_删除', null, '');

-- ----------------------------
-- Table structure for t_ums_rolepermission
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_rolepermission`;
CREATE TABLE `t_ums_rolepermission` (
  `RIGHTID` int(10) NOT NULL COMMENT '权限编码',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码',
  KEY `idx_ur_rolepermission_rightid` (`RIGHTID`),
  KEY `idx_ur_rolepermission_roleid` (`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与权限对应表';

-- ----------------------------
-- Records of t_ums_rolepermission
-- ----------------------------
INSERT INTO `t_ums_rolepermission` VALUES ('2', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('3', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('4', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('5', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('8', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('9', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('10', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('7', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('18', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('19', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('20', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('38', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('39', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('40', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('41', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('42', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('43', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('44', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('45', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('46', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('47', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('48', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('49', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('50', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('51', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('52', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('53', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('54', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('55', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('56', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('57', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('58', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('59', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('60', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('61', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('62', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('63', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('64', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('65', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('66', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('67', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('68', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('69', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('70', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('71', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('72', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('73', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('74', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('75', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('76', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('77', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('78', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('79', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('80', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('81', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('82', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('83', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('84', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('85', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('86', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('87', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('88', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('89', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('90', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('91', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('92', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('93', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('21', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('110', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('111', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('112', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('113', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('114', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('110', '5');
INSERT INTO `t_ums_rolepermission` VALUES ('111', '5');
INSERT INTO `t_ums_rolepermission` VALUES ('112', '5');
INSERT INTO `t_ums_rolepermission` VALUES ('113', '5');
INSERT INTO `t_ums_rolepermission` VALUES ('114', '5');
INSERT INTO `t_ums_rolepermission` VALUES ('1', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('138', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('139', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('140', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('141', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('142', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('143', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('144', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('145', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('146', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('147', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('148', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('149', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('150', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('151', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('152', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('153', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('124', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('125', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('126', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('127', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('128', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('129', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('130', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('131', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('132', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('133', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('134', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('135', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('136', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('137', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('154', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('155', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('124', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('125', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('126', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('127', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('128', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('129', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('130', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('131', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('132', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('133', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('134', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('135', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('136', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('137', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('138', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('139', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('140', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('141', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('142', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('143', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('144', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('145', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('146', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('147', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('148', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('149', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('150', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('151', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('152', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('153', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('154', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('155', '4');
INSERT INTO `t_ums_rolepermission` VALUES ('124', '117');
INSERT INTO `t_ums_rolepermission` VALUES ('125', '118');
INSERT INTO `t_ums_rolepermission` VALUES ('126', '119');
INSERT INTO `t_ums_rolepermission` VALUES ('127', '120');
INSERT INTO `t_ums_rolepermission` VALUES ('129', '121');
INSERT INTO `t_ums_rolepermission` VALUES ('128', '122');
INSERT INTO `t_ums_rolepermission` VALUES ('130', '123');
INSERT INTO `t_ums_rolepermission` VALUES ('131', '124');
INSERT INTO `t_ums_rolepermission` VALUES ('132', '125');
INSERT INTO `t_ums_rolepermission` VALUES ('133', '126');
INSERT INTO `t_ums_rolepermission` VALUES ('136', '127');
INSERT INTO `t_ums_rolepermission` VALUES ('134', '128');
INSERT INTO `t_ums_rolepermission` VALUES ('137', '129');
INSERT INTO `t_ums_rolepermission` VALUES ('135', '130');
INSERT INTO `t_ums_rolepermission` VALUES ('138', '131');
INSERT INTO `t_ums_rolepermission` VALUES ('139', '132');
INSERT INTO `t_ums_rolepermission` VALUES ('140', '133');
INSERT INTO `t_ums_rolepermission` VALUES ('141', '134');
INSERT INTO `t_ums_rolepermission` VALUES ('142', '135');
INSERT INTO `t_ums_rolepermission` VALUES ('143', '136');
INSERT INTO `t_ums_rolepermission` VALUES ('144', '137');
INSERT INTO `t_ums_rolepermission` VALUES ('145', '138');
INSERT INTO `t_ums_rolepermission` VALUES ('146', '139');
INSERT INTO `t_ums_rolepermission` VALUES ('147', '140');
INSERT INTO `t_ums_rolepermission` VALUES ('148', '141');
INSERT INTO `t_ums_rolepermission` VALUES ('149', '142');
INSERT INTO `t_ums_rolepermission` VALUES ('150', '143');
INSERT INTO `t_ums_rolepermission` VALUES ('151', '144');
INSERT INTO `t_ums_rolepermission` VALUES ('152', '145');
INSERT INTO `t_ums_rolepermission` VALUES ('153', '146');
INSERT INTO `t_ums_rolepermission` VALUES ('154', '147');
INSERT INTO `t_ums_rolepermission` VALUES ('155', '148');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '117');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '118');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '119');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '120');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '121');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '122');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '123');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '124');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '125');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '126');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '127');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '128');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '129');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '130');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '131');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '132');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '133');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '134');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '135');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '136');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '137');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '138');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '139');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '140');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '141');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '142');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '143');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '144');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '145');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '146');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '147');
INSERT INTO `t_ums_rolepermission` VALUES ('100', '148');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '123');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '124');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '121');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '122');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '120');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '119');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '117');
INSERT INTO `t_ums_rolepermission` VALUES ('101', '118');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '147');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '148');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '145');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '146');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '144');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '143');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '141');
INSERT INTO `t_ums_rolepermission` VALUES ('104', '142');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '131');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '132');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '129');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '130');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '128');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '127');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '125');
INSERT INTO `t_ums_rolepermission` VALUES ('102', '126');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '139');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '140');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '137');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '138');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '136');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '135');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '133');
INSERT INTO `t_ums_rolepermission` VALUES ('103', '134');

-- ----------------------------
-- Table structure for t_ums_setting_cistern
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_cistern`;
CREATE TABLE `t_ums_setting_cistern` (
  `csid` int(11) NOT NULL AUTO_INCREMENT COMMENT '水箱配置表唯一标示',
  `cistern_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`csid`),
  KEY `idx_cistern_pn` (`cistern_pn`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='水箱配置记录表'
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

-- ----------------------------
-- Records of t_ums_setting_cistern
-- ----------------------------
INSERT INTO `t_ums_setting_cistern` VALUES ('18', 'LWFS32401', '9', '2018-09-26 17:14:11', '2018-09-26 17:14:11');
INSERT INTO `t_ums_setting_cistern` VALUES ('19', 'LWFS32401R', '9', '2018-09-26 17:16:27', '2018-09-26 17:16:27');
INSERT INTO `t_ums_setting_cistern` VALUES ('20', 'LWFS32401S', '9', '2018-09-26 17:19:42', '2018-09-26 17:19:42');

-- ----------------------------
-- Table structure for t_ums_setting_cistern_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_cistern_assemble`;
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

-- ----------------------------
-- Records of t_ums_setting_cistern_assemble
-- ----------------------------
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('18', 'PE手动球阀|PE manual valve（3/8\"）', '球阀开关方向是否一致|Direction of PE manual valve', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('18', '底部密封方式|Bottem Sealing Element', '堵头/Stopper ', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('18', '水箱盖密封类型|Tank Cap', '硅胶塞/Silicone cover', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('18', '液位杆|Tank Level Sensor', '35L航空插液位杆/Level Sensor 35L', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('19', 'PE手动球阀|PE manual valve（3/8\"）', '球阀开关方向是否一致|Direction of PE manual valve', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('19', '底部密封方式|Bottem Sealing Element', '0.1 电极/0.1 Conductivity Probe', '', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('19', '水箱盖密封类型|Tank Cap', '硅胶塞/Silicone cover', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('19', '液位杆|Tank Level Sensor', '35L航空插液位杆/Level Sensor 35L', '', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('20', 'PE手动球阀|PE manual valve（3/8\"）', '球阀开关方向是否一致|Direction of PE manual valve', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('20', '底部密封方式|Bottem Sealing Element', '堵头/Stopper Probe', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('20', '水箱盖密封类型|Tank Cap', '石英套管&UV线/Quartz tube&UV Cable|+螺钉锁止', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('20', '整流器控制盒 Waterproof ballast box', '---', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_cistern_assemble` VALUES ('20', '液位杆|Tank Level Sensor', '35L航空插液位杆/Level Sensor 35L', '正确Yes|不正确No', '');

-- ----------------------------
-- Table structure for t_ums_setting_dsp
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_dsp`;
CREATE TABLE `t_ums_setting_dsp` (
  `dsid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'DSP配置表唯一标示',
  `dsp_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
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

-- ----------------------------
-- Records of t_ums_setting_dsp
-- ----------------------------
INSERT INTO `t_ums_setting_dsp` VALUES ('2', 'LWFS32601', '9', '2018-09-26 16:58:18', '2018-09-26 17:08:54');
INSERT INTO `t_ums_setting_dsp` VALUES ('3', 'LWFS32602', '9', '2018-09-26 16:59:52', '2018-09-26 17:09:03');
INSERT INTO `t_ums_setting_dsp` VALUES ('4', 'LWFS32603', '9', '2018-09-26 17:00:39', '2018-09-26 17:09:11');
INSERT INTO `t_ums_setting_dsp` VALUES ('5', 'LWFS32604', '9', '2018-09-26 17:03:00', '2018-09-26 17:03:00');
INSERT INTO `t_ums_setting_dsp` VALUES ('6', 'LWFS32605', '9', '2018-09-26 17:07:55', '2018-09-26 17:07:55');
INSERT INTO `t_ums_setting_dsp` VALUES ('7', 'LWFS32606', '9', '2018-09-26 17:07:59', '2018-09-26 17:07:59');

-- ----------------------------
-- Table structure for t_ums_setting_dsp_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_dsp_assemble`;
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

-- ----------------------------
-- Records of t_ums_setting_dsp_assemble
-- ----------------------------
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('2', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('2', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('2', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('2', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('2', '远程取水站配件|Remote DSP With Station accessories', '底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('2', '远程取水站配件|Remote DSP With Station accessories', '底座水路上下盖（Cable位置，外观）|Dispenser base inspection', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('2', '远程取水站配件|Remote DSP With Station accessories', '铝杆支架及螺钉|Dispenser base inspection', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('3', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('3', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('3', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('3', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('3', '远程取水站配件|Remote DSP With Station accessories', '底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('3', '远程取水站配件|Remote DSP With Station accessories', '底座水路上下盖（Cable位置，外观）|Dispenser base inspection', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('3', '远程取水站配件|Remote DSP With Station accessories', '铝杆支架及螺钉|Dispenser base inspection', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('4', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('4', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('4', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('4', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('4', '远程取水站配件|Remote DSP With Station accessories', '底座自检（流路，标签，硅胶垫，外观）|Dispenser base inspection', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('4', '远程取水站配件|Remote DSP With Station accessories', '底座水路上下盖（Cable位置，外观）|Dispenser base inspection', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('4', '远程取水站配件|Remote DSP With Station accessories', '铝杆支架及螺钉|Dispenser base inspection', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('5', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('5', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('5', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('5', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('5', '灵活取水手柄配件|Flexible DSP accessories', '硬插直接1/4\"*3/8\"|Stem reducer(1/4\"tube*3/8\"stem)', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('5', '灵活取水手柄配件|Flexible DSP accessories', '宝塔直接3/8\"*3/8\" Tube barb connector 3/8\"|stem', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('5', '灵活取水手柄配件|Flexible DSP accessories', '主机侧面取水手柄挂件&螺钉|Flexible dispenser rack', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('6', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('6', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('6', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('6', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('6', '灵活取水手柄配件|Flexible DSP accessories', '硬插直接1/4\"*3/8\"|Stem reducer(1/4\"tube*3/8\"stem)', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('6', '灵活取水手柄配件|Flexible DSP accessories', '宝塔直接3/8\"*3/8\" Tube barb connector 3/8\"|stem', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('6', '灵活取水手柄配件|Flexible DSP accessories', '主机侧面取水手柄挂件&螺钉|Flexible dispenser rack', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('7', '滚轮与IO板配合|Dispenser roller and IO board Assembly', '滚动阻尼及微动开关|Roll damping and micro switch', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('7', 'IO板接线线序|IO Board Wring ', '线序复核：红-黑-蓝-棕-绿-白-黑-黑|Self inspection wring', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('7', 'FFC排线|FFC cable', 'FFC 排线弯曲于手柄挂钩方向，金手指金属面朝|Self Inspection-FFC Cable', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('7', 'DSP手柄圆形挂件|Dispenser holder', '是否漏装及方向是否正确|direction', '合格 Pass|不合格 Fail', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('7', '灵活取水手柄配件|Flexible DSP accessories', '硬插直接1/4\"*3/8\"|Stem reducer(1/4\"tube*3/8\"stem)', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('7', '灵活取水手柄配件|Flexible DSP accessories', '宝塔直接3/8\"*3/8\" Tube barb connector 3/8\"|stem', '有 Yes|无 No', '');
INSERT INTO `t_ums_setting_dsp_assemble` VALUES ('7', '灵活取水手柄配件|Flexible DSP accessories', '主机侧面取水手柄挂件&螺钉|Flexible dispenser rack', '有 Yes|无 No', '');

-- ----------------------------
-- Table structure for t_ums_setting_mainframe
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_mainframe`;
CREATE TABLE `t_ums_setting_mainframe` (
  `msid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主机配置表唯一标示',
  `mainframe_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`msid`),
  KEY `idx_mainframe_pn` (`mainframe_pn`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='主机配置记录表'
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

-- ----------------------------
-- Records of t_ums_setting_mainframe
-- ----------------------------
INSERT INTO `t_ums_setting_mainframe` VALUES ('18', ' LWFS31101', '9', '2018-09-26 17:26:18', '2018-09-26 17:26:18');
INSERT INTO `t_ums_setting_mainframe` VALUES ('19', 'LWFS31101C', '9', '2018-09-26 17:30:31', '2018-10-09 13:52:17');

-- ----------------------------
-- Table structure for t_ums_setting_mainframe_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_mainframe_assemble`;
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

-- ----------------------------
-- Records of t_ums_setting_mainframe_assemble
-- ----------------------------
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '开关电源（主机）|Power module (MU)', 'SP-200-24', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '循环泵|Recirculation pump', 'EC-203-300ARS', 'SJZ-EC-', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '循环压力变送器|Loop PT3', 'MPM4150', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '水质变送器|Water quality transducer', 'CM4中间电导 Intermediate sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '水质变送器|Water quality transducer', '4# 电导变送器     2# transducer', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '水质变送器|Water quality transducer', 'CM6 UP产水电导仪 UP quality sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '水质变送器|Water quality transducer', '6# 电导变送器     2# transducer', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '主机主板|Main unit PCB', 'Cascada MU-MAIN PCB(2 levels)', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('18', '主机显示屏|Main unit LCD', 'MU LCD PCB with touch screen LCD', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '开关电源（主机）|Power module (MU)', 'SP-200-24', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '循环泵|Recirculation pump', 'EC-203-300ARS', 'SJZ-EC-', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '循环压力变送器|Loop PT3', 'MPM4150', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', 'CM2 RO产水电导仪|RO quality sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', '2# 电导变送器|2# transducer', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', 'CM4中间电导|Intermediate sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', '6# 电导变送器|2# transducer', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', 'CM6 UP产水电导仪|UP quality sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '主机主板|Main unit PCB', 'Cascada MU-MAIN PCB(2 levels)', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '主机显示屏|Main unit LCD', 'MU LCD PCB with touch screen LCD', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '开关电源（主机）|Power module (MU)', 'SP-200-24', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '循环泵|Recirculation pump', 'EC-203-300ARS', 'SJZ-EC-', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '循环压力变送器|Loop PT3', 'MPM4150', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', 'CM2 RO产水电导仪|RO quality sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', '2# 电导变送器|2# transducer', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', 'CM4中间电导|Intermediate sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', '6# 电导变送器|2# transducer', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '水质变送器|Water quality transducer', 'CM6 UP产水电导仪|UP quality sensor', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '主机主板|Main unit PCB', 'Cascada MU-MAIN PCB(2 levels)', '', '');
INSERT INTO `t_ums_setting_mainframe_assemble` VALUES ('19', '主机显示屏|Main unit LCD', 'MU LCD PCB with touch screen LCD', '', '');

-- ----------------------------
-- Table structure for t_ums_setting_mainframe_inspect
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_mainframe_inspect`;
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

-- ----------------------------
-- Records of t_ums_setting_mainframe_inspect
-- ----------------------------
INSERT INTO `t_ums_setting_mainframe_inspect` VALUES ('18', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '合格/Pass|不合格/Fail', '');
INSERT INTO `t_ums_setting_mainframe_inspect` VALUES ('18', '拨码记录|Dial switch ', '1|2|3|4|5|6|7|8', '型号/Type：', '');
INSERT INTO `t_ums_setting_mainframe_inspect` VALUES ('19', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '合格/Pass|不合格/Fail', '');
INSERT INTO `t_ums_setting_mainframe_inspect` VALUES ('19', '拨码记录|Dial switch ', '1|2|3|4|5|6|7|8', '型号/Type：', '');
INSERT INTO `t_ums_setting_mainframe_inspect` VALUES ('19', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '合格/Pass|不合格/Fail', '');
INSERT INTO `t_ums_setting_mainframe_inspect` VALUES ('19', '拨码记录|Dial switch ', '1|2|3|4|5|6|7|8', '型号/Type：', '');

-- ----------------------------
-- Table structure for t_ums_setting_preprocessing
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_preprocessing`;
CREATE TABLE `t_ums_setting_preprocessing` (
  `psid` int(11) NOT NULL AUTO_INCREMENT COMMENT '预处理配置表唯一标示',
  `preprocessing_pn` varchar(20) DEFAULT NULL COMMENT '料号/PN',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`psid`),
  KEY `idx_preprocessing_pn` (`preprocessing_pn`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='预处理装配流程跟踪单装配记录表'
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

-- ----------------------------
-- Records of t_ums_setting_preprocessing
-- ----------------------------
INSERT INTO `t_ums_setting_preprocessing` VALUES ('13', 'LWFS32701C', '9', '2018-09-05 23:22:26', '2018-09-06 00:10:04');
INSERT INTO `t_ums_setting_preprocessing` VALUES ('14', 'LWFS32701', '9', '2018-09-05 23:35:59', '2018-09-05 23:59:20');
INSERT INTO `t_ums_setting_preprocessing` VALUES ('15', 'LWFS32701P', '9', '2018-09-05 23:39:34', '2018-09-06 00:09:20');
INSERT INTO `t_ums_setting_preprocessing` VALUES ('16', 'LWFS32701PC', '9', '2018-09-05 23:43:38', '2018-09-06 00:06:41');

-- ----------------------------
-- Table structure for t_ums_setting_preprocessing_assemble
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_preprocessing_assemble`;
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

-- ----------------------------
-- Records of t_ums_setting_preprocessing_assemble
-- ----------------------------
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', '开关电源（预处理）|Power module (PT)', 'SP-75-24', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', '水质变送器|Water quality transducer', 'CM1源水电导仪|CM1 Raw water sensor', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', '水质变送器|Water quality transducer', '1#电导变送器 |1# Conductivity transducer', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', 'PT减压阀|Pressure Regulator', 'PRV-3-SH', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('13', '低压开关|Pressure switch (feed water)', '-', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('14', '开关电源（预处理）|Power module (PT)', 'SP-75-24', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('14', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('14', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('14', 'PT减压阀|Pressure Regulator', 'PRV-3-SH', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('14', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('14', '低压开关|Pressure switch (feed water)', '-', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('15', '开关电源（预处理）|Power module (PT)', 'SP-75-24', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('15', '源水增压泵|Raw water boost pump', 'EC-203-300ARS', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('15', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('15', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('15', 'PT减压阀|Pressure Regulator', 'PRV-3-SH', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('15', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('15', '低压开关|Pressure switch (feed water)', '-', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '开关电源（预处理）|Power module (PT)', 'SP-75-24', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '源水增压泵|Raw water boost pump', 'EC-203-300ARS', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '水质变送器|Water quality transducer', 'CM1源水电导仪|CM1 Raw water sensor', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '水质变送器|Water quality transducer', '1#电导变送器|1# Conductivity transducer', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '预处理IO主板|PT module IO PCB', 'PT-IO PCB board', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '预处理显示板|PT module display PCB', 'PT LCD PCB with LCD', '', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', 'PT减压阀|Pressure Regulator (feed water)', 'PRV-3-SH', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '常闭电磁阀_水平流|Solenoid Valve（horizontal,NC）', '-', '正确Yes|不正确No', '');
INSERT INTO `t_ums_setting_preprocessing_assemble` VALUES ('16', '低压开关|Pressure switch (feed water)', '-', '正确Yes|不正确No', '');

-- ----------------------------
-- Table structure for t_ums_setting_preprocessing_inspect
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_setting_preprocessing_inspect`;
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

-- ----------------------------
-- Records of t_ums_setting_preprocessing_inspect
-- ----------------------------
INSERT INTO `t_ums_setting_preprocessing_inspect` VALUES ('13', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '合格/Pass|不合格/Fail', '');
INSERT INTO `t_ums_setting_preprocessing_inspect` VALUES ('14', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '合格/Pass|不合格/Fail', '');
INSERT INTO `t_ums_setting_preprocessing_inspect` VALUES ('15', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '合格/Pass|不合格/Fail', '');
INSERT INTO `t_ums_setting_preprocessing_inspect` VALUES ('16', '流路及组件检查/Inspection', '参照流路图检查组件是否有误及流路是否正确/Assembly inspection', '合格/Pass|不合格/Fail', '');

-- ----------------------------
-- Table structure for t_ums_th_config
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_th_config`;
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

-- ----------------------------
-- Records of t_ums_th_config
-- ----------------------------
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '1', null, '1', '1', null, '', '2', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '2', null, '1', '1', null, 'dspID', '1', 'id', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '3', null, '1', '1', null, 'cOrderID', '0', '客户订单信息', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '4', null, '1', '1', null, 'assembleTime', '0', '装配日期', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '5', null, '1', '1', null, 'productionTime', '0', '生产时间', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '6', null, '1', '1', null, 'dspPn', '0', '型号/PN', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '7', null, '1', '1', null, 'serialNo', '0', '序列号/Serial NO', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '8', null, '1', '1', null, 'workorderNo', '0', '工单号/WO', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '9', null, '1', '1', null, 'dspModel', '0', 'DSP型号/Model', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '10', null, '1', '1', null, 'assembleRecords', '0', '装配记录', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '11', null, '1', '1', null, 'exceptionRecord', '0', '异常记录', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '12', null, '1', '1', null, 'remarks', '0', '备注', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '13', null, '1', '1', null, 'assembleOperator', '0', '装配人员', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '14', null, '1', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTable', '1', '15', null, '1', '1', null, '', '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '1', null, '1', '1', null, '', '2', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '2', null, '1', '1', null, 'cisternID', '1', 'id', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '3', null, '1', '1', null, 'cOrderID', '0', '客户订单信息', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '4', null, '1', '1', null, 'assembleTime', '0', '装配日期', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '5', null, '1', '1', null, 'productionTime', '0', '生产时间', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '6', null, '1', '1', null, 'cisternPn', '0', '料号/PN', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '7', null, '1', '1', null, 'serialNo', '0', '序列号/Serial NO', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '8', null, '1', '1', null, 'workorderNo', '0', '工单号/WO', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '9', null, '1', '1', null, 'cisternModel', '0', '水箱型号/Model', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '10', null, '1', '1', null, 'cisternOptions', '0', '水箱选配件/Options', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '11', null, '1', '1', null, 'assembleRecords', '0', '装配记录', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '12', null, '1', '1', null, 'exceptionRecord', '0', '异常记录', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '13', null, '1', '1', null, 'remarks', '0', '备注', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '14', null, '1', '1', null, 'assembleOperator', '0', '装配人员', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '15', null, '1', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTable', '1', '16', null, '1', '1', null, '', '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '1', null, '1', '1', null, '', '2', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '2', null, '1', '1', null, 'preprocessingID', '1', 'id', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '3', null, '1', '1', null, 'cOrderID', '0', '客户订单信息', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '4', null, '1', '1', null, 'assembleTime', '0', '装配日期', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '5', null, '1', '1', null, 'productionTime', '0', '生产时间', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '6', null, '1', '1', null, 'preprocessingPn', '0', '料号/PN', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '7', null, '1', '1', null, 'serialNo', '0', '序列号/Serial NO', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '8', null, '1', '1', null, 'workorderNo', '0', '工单号/WO', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '9', null, '1', '1', null, 'preprocessingModel', '0', '名称/Model', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '10', null, '1', '1', null, 'ptOptions', '0', 'PT选配件/Option', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '11', null, '1', '1', null, 'assembleRecords', '0', '装配记录', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '12', null, '1', '1', null, 'inspectRecords', '1', '送检人员记录', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '13', null, '1', '1', null, 'exceptionRecord', '0', '异常记录', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '14', null, '1', '1', null, 'remarks', '0', '备注', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '15', null, '1', '1', null, 'assembleOperator', '0', '装配人员', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '16', null, '1', '1', null, 'inspectOperator', '1', '送检人员', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '17', null, '1', '1', null, 'inspectTime', '1', '送检日期', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '18', null, '1', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTable', '1', '19', null, '1', '1', null, '', '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '1', null, '1', '1', null, '', '2', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '2', null, '1', '1', null, 'mainframeID', '1', 'id', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '3', null, '1', '1', null, 'cOrderID', '0', '客户订单信息', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '4', null, '1', '1', null, 'assembleTime', '0', '装配日期', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '5', null, '1', '1', null, 'productionTime', '0', '生产时间', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '6', null, '1', '1', null, 'mainframePn', '0', '料号/PN', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '7', null, '1', '1', null, 'serialNo', '0', '序列号/Serial NO', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '8', null, '1', '1', null, 'workorderNo', '0', '工单号/WO', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '9', null, '1', '1', null, 'mainframeModel', '0', '主机型号/Model', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '10', null, '1', '1', null, 'mainframeOptions', '0', '主机选配件/Option', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '11', null, '1', '1', null, 'assembleRecords', '0', '装配记录', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '12', null, '1', '1', null, 'inspectRecords', '1', '送检人员记录', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '13', null, '1', '1', null, 'exceptionRecord', '0', '异常记录', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '14', null, '1', '1', null, 'remarks', '0', '备注', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '15', null, '1', '1', null, 'assembleOperator', '0', '装配人员', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '16', null, '1', '1', null, 'inspectOperator', '1', '送检人员', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '17', null, '1', '1', null, 'inspectTime', '1', '送检日期', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '18', null, '1', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTable', '1', '19', null, '1', '1', null, '', '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '1', '1', null, '1', '9', null, '', '0', '预处理装配流程跟踪单/PT Assembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '2', '1', null, '1', '2', null, '', '0', '料号/PN:', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '2', '3', null, '1', '2', null, 'preprocessingPn', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '2', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '2', '6', null, '1', '2', null, '', '0', '序列号/Serial No:', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '2', '8', null, '1', '2', null, 'serialNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '3', '1', null, '1', '2', null, '', '0', '工单号/WO：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '3', '3', null, '1', '2', null, 'workorderNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '3', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '4', '6', null, '1', '2', null, '', '0', 'PT选配件/Options：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '4', '7', null, '1', '1', null, 'ptOption', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '4', '8', null, '1', '1', null, 'ptOption2', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '4', '1', null, '1', '2', null, '', '0', '名称/Modle：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '4', '3', null, '1', '2', null, 'preprocessingModel', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '4', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '3', '6', null, '1', '2', null, '', '0', '生产时间：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '3', '8', null, '1', '2', null, 'productionTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '5', '1', null, '1', '9', null, '', '0', '装配记录/Manufacture Record', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '6', '1', null, '1', '1', null, 'assembleRecords:preprocessingID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '6', '2', null, '1', '2', null, 'assembleRecords:componentName', '0', '组件名称\r\nComponent Name', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '6', '4', null, '1', '2', null, 'assembleRecords:componentNo', '0', '组件型号\r\nComponent Module', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '6', '6', null, '1', '2', null, 'assembleRecords:serialNoRecord', '4', '序列号记录\r\nSerial No', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '6', '8', null, '1', '2', null, 'assembleRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '7', '1', null, '1', '9', null, '', '0', '送检人员记录/Self Inspection Records', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '8', '1', null, '1', '1', null, 'inspectRecords:preprocessingID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '8', '2', null, '1', '2', null, 'inspectRecords:selfcheckName', '0', '自检名称\r\nInspection Item', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '8', '4', null, '1', '2', null, 'inspectRecords:selfcheckContent', '0', '自检内容\r\nSelf Inspection Content', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '8', '6', null, '1', '2', null, 'inspectRecords:selfcheckResult', '4', '自检结果\r\nSelf Inspection Result', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '8', '8', null, '1', '2', null, 'inspectRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '9', '1', null, '1', '1', null, '', '0', '异常记录：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '9', '2', null, '1', '8', null, 'exceptionRecord', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '10', '1', null, '1', '1', null, '', '0', '备注：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '10', '2', null, '1', '8', null, 'remarks', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '1', null, '1', '1', null, '', '0', '装配人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '2', null, '1', '1', null, 'assembleOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '3', null, '1', '1', null, '', '0', '装配日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '4', null, '1', '1', null, 'assembleTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '6', null, '1', '1', null, '', '0', '送检人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '7', null, '1', '1', null, 'inspectOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '8', null, '1', '1', null, '', '0', '送检日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '11', '9', null, '1', '1', null, 'inspectTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate_inspect', '3', '9', null, '1', '1', null, 'ptOption2', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '1', '1', null, '1', '9', null, '', '0', '主机装配流程跟踪单/PT Assembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '2', '1', null, '1', '2', null, '', '0', '料号/PN:', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '2', '3', null, '1', '2', null, 'mainframePn', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '2', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '2', '6', null, '1', '2', null, '', '0', '序列号/Serial No:', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '2', '8', null, '1', '2', null, 'serialNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '3', '1', null, '1', '2', null, '', '0', '工单号/WO：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '3', '3', null, '1', '2', null, 'workorderNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '3', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '4', '6', null, '1', '2', null, '', '0', '主机选配件/Options：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '4', '8', null, '1', '1', null, 'mainframeOption', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '4', '9', null, '1', '1', null, 'mainframeOption2', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '4', '1', null, '1', '2', null, '', '0', '主机型号/Modle：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '4', '3', null, '1', '3', null, 'mainframeModel', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '3', '6', null, '1', '2', null, '', '0', '生产时间：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '3', '8', null, '1', '2', null, 'productionTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '5', '1', null, '1', '9', null, '', '0', '装配记录/Manufacture Record', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '6', '1', null, '1', '1', null, 'assembleRecords:mainframeID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '6', '2', null, '1', '2', null, 'assembleRecords:componentName', '0', '组件名称\r\nComponent Name', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '6', '4', null, '1', '2', null, 'assembleRecords:componentNo', '0', '组件型号\r\nComponent Module', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '6', '6', null, '1', '2', null, 'assembleRecords:serialNoRecord', '4', '序列号记录\r\nSerial No', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '6', '8', null, '1', '2', null, 'assembleRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '7', '1', null, '1', '9', null, '', '0', '送检人员记录/Self Inspection Records', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '8', '1', null, '1', '1', null, 'inspectRecords:mainframeID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '8', '2', null, '1', '2', null, 'inspectRecords:selfcheckName', '0', '自检名称\r\nInspection Item', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '8', '4', null, '1', '2', null, 'inspectRecords:selfcheckContent', '0', '自检内容\r\nSelf Inspection Content', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '8', '6', null, '1', '2', null, 'inspectRecords:selfcheckResult', '4', '自检结果\r\nSelf Inspection Result', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '8', '8', null, '1', '2', null, 'inspectRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '9', '1', null, '1', '1', null, '', '0', '异常记录：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '9', '2', null, '1', '8', null, 'exceptionRecord', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '10', '1', null, '1', '1', null, '', '0', '备注：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '10', '2', null, '1', '8', null, 'remarks', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '1', null, '1', '1', null, '', '0', '装配人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '2', null, '1', '1', null, 'assembleOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '3', null, '1', '1', null, '', '0', '装配日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '4', null, '1', '1', null, 'assembleTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '6', null, '1', '1', null, '', '0', '送检人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '7', null, '1', '1', null, 'inspectOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '8', null, '1', '1', null, '', '0', '送检日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate_inspect', '11', '9', null, '1', '1', null, 'inspectTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '1', '1', null, '1', '9', null, '', '0', 'DSP装配流程跟踪单/PT Assembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '2', '1', null, '1', '2', null, '', '0', '料号/PN:', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '2', '3', null, '1', '2', null, 'dspPn', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '2', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '2', '6', null, '1', '2', null, '', '0', '序列号/Serial No:', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '2', '8', null, '1', '2', null, 'serialNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '3', '1', null, '1', '2', null, '', '0', '工单号/WO：', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '3', '3', null, '1', '2', null, 'workorderNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '3', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '3', '6', null, '1', '2', null, '', '0', '生产时间：', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '3', '8', null, '1', '2', null, 'productionTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '4', '1', null, '1', '2', null, '', '0', 'DSP型号/Model：', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '4', '3', null, '1', '7', null, 'dspModel', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '5', '1', null, '1', '9', null, '', '0', '装配记录/Manufacture Record', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '6', '1', null, '1', '1', null, 'assembleRecords:dspID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '6', '2', null, '1', '2', null, 'assembleRecords:componentName', '0', '组件名称\r\nComponent Name', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '6', '4', null, '1', '2', null, 'assembleRecords:componentNo', '0', '装配记录\r\nAssembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '6', '6', null, '1', '2', null, 'assembleRecords:serialNoRecord', '4', '结论\r\nResult Record', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '6', '8', null, '1', '2', null, 'assembleRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '7', '1', null, '1', '1', null, '', '0', '异常记录：', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '7', '2', null, '1', '8', null, 'exceptionRecord', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '8', '1', null, '1', '1', null, '', '0', '备注：', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '8', '2', null, '1', '8', null, 'remarks', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '9', '1', null, '1', '5', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '9', '6', null, '1', '1', null, '', '0', '装配人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '9', '7', null, '1', '1', null, 'assembleOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '9', '8', null, '1', '1', null, '', '0', '装配日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('401', 'dspTemplate', '9', '9', null, '1', '1', null, 'assembleTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '1', '1', null, '1', '9', null, '', '0', '水箱装配流程跟踪单/PT Assembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '2', '1', null, '1', '2', null, '', '0', '料号/PN:', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '2', '3', null, '1', '2', null, 'cisternPn', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '2', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '2', '6', null, '1', '2', null, '', '0', '序列号/Serial No:', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '2', '8', null, '1', '2', null, 'serialNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '3', '1', null, '1', '2', null, '', '0', '工单号/WO：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '3', '3', null, '1', '2', null, 'workorderNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '3', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '3', '6', null, '1', '2', null, '', '0', '生产时间：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '3', '8', null, '1', '2', null, 'productionTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '4', '1', null, '1', '2', null, '', '0', '水箱型号/Model：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '4', '3', null, '1', '3', null, 'cisternModel', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '4', '6', null, '1', '2', null, '', '0', '水箱选配件/Options：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '4', '8', null, '1', '1', null, 'cisternOption', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '4', '9', null, '1', '1', null, 'cisternOption2', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '5', '1', null, '1', '9', null, '', '0', '装配记录/Manufacture Record', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '6', '1', null, '1', '1', null, 'assembleRecords:cisternID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '6', '2', null, '1', '2', null, 'assembleRecords:componentName', '0', '组件名称\r\nComponent Name', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '6', '4', null, '1', '2', null, 'assembleRecords:componentNo', '0', '装配记录\r\nAssembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '6', '6', null, '1', '2', null, 'assembleRecords:serialNoRecord', '4', '结论\r\nResult Record', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '6', '8', null, '1', '2', null, 'assembleRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '7', '1', null, '1', '1', null, '', '0', '异常记录：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '7', '2', null, '1', '8', null, 'exceptionRecord', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '8', '1', null, '1', '1', null, '', '0', '备注：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '8', '2', null, '1', '8', null, 'remarks', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '9', '1', null, '1', '5', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '9', '6', null, '1', '1', null, '', '0', '装配人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '9', '7', null, '1', '1', null, 'assembleOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '9', '8', null, '1', '1', null, '', '0', '装配日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('402', 'cisternTemplate', '9', '9', null, '1', '1', null, 'assembleTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '1', '1', null, '1', '9', null, '', '0', '主机装配流程跟踪单/PT Assembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '2', '1', null, '1', '2', null, '', '0', '料号/PN:', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '2', '3', null, '1', '2', null, 'mainframePn', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '2', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '2', '6', null, '1', '2', null, '', '0', '序列号/Serial No:', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '2', '8', null, '1', '2', null, 'serialNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '3', '1', null, '1', '2', null, '', '0', '工单号/WO：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '3', '3', null, '1', '2', null, 'workorderNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '3', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '4', '6', null, '1', '2', null, '', '0', '主机选配件/Options：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '4', '8', null, '1', '1', null, 'mainframeOption', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '4', '9', null, '1', '1', null, 'mainframeOption2', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '4', '1', null, '1', '2', null, '', '0', '主机型号/Modle：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '4', '3', null, '1', '3', null, 'mainframeModel', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '3', '6', null, '1', '2', null, '', '0', '生产时间：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '3', '8', null, '1', '2', null, 'productionTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '5', '1', null, '1', '9', null, '', '0', '装配记录/Manufacture Record', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '6', '1', null, '1', '1', null, 'assembleRecords:mainframeID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '6', '2', null, '1', '2', null, 'assembleRecords:componentName', '0', '组件名称\r\nComponent Name', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '6', '4', null, '1', '2', null, 'assembleRecords:componentNo', '0', '组件型号\r\nComponent Module', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '6', '6', null, '1', '2', null, 'assembleRecords:serialNoRecord', '4', '序列号记录\r\nSerial No', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '6', '8', null, '1', '2', null, 'assembleRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '7', '1', null, '1', '1', null, '', '0', '异常记录：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '7', '2', null, '1', '8', null, 'exceptionRecord', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '8', '1', null, '1', '1', null, '', '0', '备注：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '8', '2', null, '1', '8', null, 'remarks', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '9', '1', null, '1', '5', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '9', '6', null, '1', '1', null, '', '0', '装配人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '9', '7', null, '1', '1', null, 'assembleOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '9', '8', null, '1', '1', null, '', '0', '装配日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('404', 'mainframeTemplate', '9', '9', null, '1', '1', null, 'assembleTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '1', '1', null, '1', '9', null, '', '0', '预处理装配流程跟踪单/PT Assembly Record', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '2', '1', null, '1', '2', null, '', '0', '料号/PN:', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '2', '3', null, '1', '2', null, 'preprocessingPn', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '2', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '2', '6', null, '1', '2', null, '', '0', '序列号/Serial No:', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '2', '8', null, '1', '2', null, 'serialNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '3', '1', null, '1', '2', null, '', '0', '工单号/WO：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '3', '3', null, '1', '2', null, 'workorderNo', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '3', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '3', '6', null, '1', '2', null, '', '0', '生产时间：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '3', '8', null, '1', '2', null, 'productionTime', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '4', '1', null, '1', '2', null, '', '0', '名称/Modle：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '4', '3', null, '1', '2', null, 'preprocessingModel', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '4', '5', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '4', '6', null, '1', '2', null, '', '0', 'PT选配件/Options：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '4', '8', null, '1', '1', null, 'ptOption', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '4', '9', null, '1', '1', null, 'ptOption2', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '5', '1', null, '1', '9', null, '', '0', '装配记录/Manufacture Record', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '6', '1', null, '1', '1', null, 'assembleRecords:preprocessingID', '0', '序号\r\nNO', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '6', '2', null, '1', '2', null, 'assembleRecords:componentName', '0', '组件名称\r\nComponent Name', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '6', '4', null, '1', '2', null, 'assembleRecords:componentNo', '0', '组件型号\r\nComponent Module', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '6', '6', null, '1', '2', null, 'assembleRecords:serialNoRecord', '4', '序列号记录\r\nSerial No', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '6', '8', null, '1', '2', null, 'assembleRecords:remarks', '0', '备注\r\nRemarks', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '7', '1', null, '1', '1', null, '', '0', '异常记录：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '7', '2', null, '1', '8', null, 'exceptionRecord', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '8', '1', null, '1', '1', null, '', '0', '备注：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '8', '2', null, '1', '8', null, 'remarks', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '9', '1', null, '1', '5', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '9', '6', null, '1', '1', null, '', '0', '装配人员：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '9', '7', null, '1', '1', null, 'assembleOperator', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '9', '8', null, '1', '1', null, '', '0', '装配日期：', null);
INSERT INTO `t_ums_th_config` VALUES ('403', 'preprocessingTemplate', '9', '9', null, '1', '1', null, 'assembleTime', '0', '', null);

-- ----------------------------
-- Table structure for t_ums_userpermission
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_userpermission`;
CREATE TABLE `t_ums_userpermission` (
  `OPERATORID` int(8) NOT NULL COMMENT '操作员编号',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码',
  KEY `idx_uu_userpermission_operatorid` (`OPERATORID`),
  KEY `idx_uu_userpermission_roleid` (`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色对应表';

-- ----------------------------
-- Records of t_ums_userpermission
-- ----------------------------
INSERT INTO `t_ums_userpermission` VALUES ('20', '5');
INSERT INTO `t_ums_userpermission` VALUES ('20', '4');
INSERT INTO `t_ums_userpermission` VALUES ('21', '148');
INSERT INTO `t_ums_userpermission` VALUES ('21', '147');
INSERT INTO `t_ums_userpermission` VALUES ('21', '146');
INSERT INTO `t_ums_userpermission` VALUES ('21', '145');
INSERT INTO `t_ums_userpermission` VALUES ('21', '144');
INSERT INTO `t_ums_userpermission` VALUES ('21', '143');
INSERT INTO `t_ums_userpermission` VALUES ('21', '142');
INSERT INTO `t_ums_userpermission` VALUES ('21', '141');
INSERT INTO `t_ums_userpermission` VALUES ('22', '140');
INSERT INTO `t_ums_userpermission` VALUES ('22', '139');
INSERT INTO `t_ums_userpermission` VALUES ('22', '138');
INSERT INTO `t_ums_userpermission` VALUES ('22', '137');
INSERT INTO `t_ums_userpermission` VALUES ('22', '136');
INSERT INTO `t_ums_userpermission` VALUES ('22', '135');
INSERT INTO `t_ums_userpermission` VALUES ('22', '134');
INSERT INTO `t_ums_userpermission` VALUES ('22', '133');
INSERT INTO `t_ums_userpermission` VALUES ('25', '5');
INSERT INTO `t_ums_userpermission` VALUES ('9', '1');
INSERT INTO `t_ums_userpermission` VALUES ('27', '1');
INSERT INTO `t_ums_userpermission` VALUES ('26', '4');
INSERT INTO `t_ums_userpermission` VALUES ('23', '132');
INSERT INTO `t_ums_userpermission` VALUES ('23', '131');
INSERT INTO `t_ums_userpermission` VALUES ('23', '130');
INSERT INTO `t_ums_userpermission` VALUES ('23', '129');
INSERT INTO `t_ums_userpermission` VALUES ('23', '128');
INSERT INTO `t_ums_userpermission` VALUES ('23', '127');
INSERT INTO `t_ums_userpermission` VALUES ('23', '126');
INSERT INTO `t_ums_userpermission` VALUES ('23', '125');
INSERT INTO `t_ums_userpermission` VALUES ('24', '123');
INSERT INTO `t_ums_userpermission` VALUES ('24', '122');
INSERT INTO `t_ums_userpermission` VALUES ('24', '121');
INSERT INTO `t_ums_userpermission` VALUES ('24', '120');
INSERT INTO `t_ums_userpermission` VALUES ('24', '119');
INSERT INTO `t_ums_userpermission` VALUES ('24', '118');
INSERT INTO `t_ums_userpermission` VALUES ('24', '117');

-- ----------------------------
-- View structure for menubuttonview
-- ----------------------------
DROP VIEW IF EXISTS `menubuttonview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menubuttonview` AS select `t_ums_menuinfo`.`MENUID` AS `menuid`,`t_ums_menuinfo`.`MENUNAME` AS `menuname`,1 AS `menutype`,`t_ums_menuinfo`.`PMENUID` AS `pmenuid` from `t_ums_menuinfo` union all select `f`.`btnid` AS `btnid`,`f`.`btncname` AS `btncname`,2 AS `menutype`,`f`.`menuid` AS `menuid` from `t_ums_menu_button` `f` where exists(select 1 from `t_ums_menuinfo` `d` where (`d`.`MENUID` = `f`.`menuid`)) ;

-- ----------------------------
-- View structure for v_table_opticalfilming_clean_polish
-- ----------------------------
DROP VIEW IF EXISTS `v_table_opticalfilming_clean_polish`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_table_opticalfilming_clean_polish` AS select `c`.`output_lot_num` AS `ocLotNum`,`c`.`oc_bom` AS `ocBom`,`d`.`clean_lot_num` AS `cleanLotNum`,`d`.`clean_bom` AS `cleanBom`,`e`.`polish_lot_num` AS `polishLotNum`,`e`.`polish_bom` AS `polishBom` from ((`t_ums_workflow_opticalfilming` `c` left join `t_ums_workflow_clean` `d` on((`d`.`clean_lot_num` = `c`.`input_lot_num`))) left join `t_ums_workflow_polish` `e` on((`e`.`polish_lot_num` = `d`.`input_lot_num`))) ;

-- ----------------------------
-- View structure for v_workflow
-- ----------------------------
DROP VIEW IF EXISTS `v_workflow`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_workflow` AS select `a`.`cr_id` AS `cr_id`,`a`.`tray_lot_num` AS `tray_lot_num`,`a`.`t_lot_num` AS `t_lot_num`,`f`.`fixture_num` AS `fixture_num`,`f`.`output_lot_num` AS `assembly_lot_num`,`f`.`assembly_bom` AS `assembly_bom`,`b`.`output_lot_num` AS `aps_lot_num`,`b`.`sf_bom` AS `aps_Bom`,`c`.`output_lot_num` AS `oc_lot_num`,`c`.`oc_bom` AS `oc_bom`,`d`.`clean_lot_num` AS `clean_lot_num`,`d`.`clean_bom` AS `clean_bom`,`e`.`polish_lot_num` AS `polish_lot_num`,`e`.`polish_bom` AS `polish_bom` from (((((`t_ums_workflow_biocoating_relation` `a` left join `t_ums_workflow_assembly` `f` on((`f`.`tray_lot_num` = `a`.`tray_lot_num`))) left join `t_ums_workflow_platedfilm` `b` on(((`f`.`input_lot_num` = `b`.`output_lot_num`) and (`f`.`fixture_num` = `b`.`fixture_num`)))) left join `t_ums_workflow_opticalfilming` `c` on(((`c`.`output_lot_num` = `b`.`input_lot_num`) and (`c`.`fixture_num` = `b`.`fixture_num`)))) left join `t_ums_workflow_clean` `d` on(((`d`.`clean_lot_num` = `c`.`input_lot_num`) and (`d`.`fixture_number` = `c`.`fixture_num`)))) left join `t_ums_workflow_polish` `e` on(((`e`.`polish_lot_num` = `d`.`input_lot_num`) and (`e`.`fixture_number` = `d`.`fixture_number`)))) ;

-- ----------------------------
-- Procedure structure for pro_sys_logByMonth
-- ----------------------------
DROP PROCEDURE IF EXISTS `pro_sys_logByMonth`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pro_sys_logByMonth`(IN tableName VARCHAR(20),IN timeColName VARCHAR(20) )
    COMMENT '每月按时添加表分区的存储过程，由定时任务调用'
BEGIN
    DECLARE p_id int;
    DECLARE p_des date;
    DECLARE lasttime VARCHAR(20);
    DECLARE nexttime varchar(20);
    #获取表中的现有的分区数量数量
    SELECT COUNT(partition_name) into p_id FROM INFORMATION_SCHEMA.partitions WHERE TABLE_SCHEMA = SCHEMA() AND TABLE_NAME=tableName;
    if p_id=0 then
        #获取下个月第一天的时间值，根据此值设置时间分区
        SELECT DATE_FORMAT(DATE_ADD(CURDATE()-DAY(CURDATE())+1,INTERVAL 1 MONTH),'%Y-%m-%d') INTO p_des from DUAL;
        #创建第一个表分区的动态sql
        set @v_add=CONCAT('ALTER table ',tableName,' PARTITION by range COLUMNS(',timeColName,')
         (partition ',CONCAT('par',p_id),' values less than (\'',p_des,'\'))');
    ELSE
        #获取表中现有的最大的分区日期
        SELECT max(partition_description) des into lasttime from INFORMATION_SCHEMA.partitions 
        WHERE TABLE_SCHEMA = SCHEMA() AND TABLE_NAME=tableName;
        #lasttime的值是'2015-12-01' 因是含引号格式的字符串，直接用str_to_date函数和 date_format函数处理不成功。必须通过动态sql把它转换成没有引号的时间字符串into @nexttime from dual ');
        PREPARE stm from @v_add_a;
        EXECUTE stm;
        DEALLOCATE PREPARE stm;
        #将编译执行的stm结果存储到nexttime中
        set nexttime=@nexttime; 
        #添加表分区的sql
        set @v_add=CONCAT('alter table ',tableName,' add partition (partition ',CONCAT('par',p_id),' values less than (\'',nexttime,'\'))');
    END IF;
    PREPARE stmt from @v_add;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for queryChildMenuButtonList
-- ----------------------------
DROP FUNCTION IF EXISTS `queryChildMenuButtonList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `queryChildMenuButtonList`(v_pmenuid INT) RETURNS text CHARSET utf8
BEGIN
	 declare v_p_collections TEXT(4000);
	 declare v_sub_collections TEXT(4000);
	 SET v_p_collections = '$';
	 set v_sub_collections= cast(v_pmenuid as char);
	 while v_sub_collections is not null do
	    set v_p_collections=CONCAT(v_p_collections,',',v_sub_collections);
	 	SELECT group_concat(f.menuid) into v_sub_collections  FROM menuButtonview f WHERE FIND_IN_SET(f.pmenuid,v_sub_collections)>0;
	 end while;
 	return v_p_collections;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for queryChildMenuList
-- ----------------------------
DROP FUNCTION IF EXISTS `queryChildMenuList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `queryChildMenuList`(v_pmenuid INT) RETURNS text CHARSET utf8
BEGIN
	 declare v_p_collections TEXT(4000);
	 declare v_sub_collections TEXT(4000);
	 SET v_p_collections = '$';
	 set v_sub_collections= cast(v_pmenuid as char);
	 while v_sub_collections is not null do
	    set v_p_collections=CONCAT(v_p_collections,',',v_sub_collections);
	 	SELECT group_concat(f.menuid) into v_sub_collections  FROM T_UMS_MENUINFO f WHERE DISABLED=0 and FIND_IN_SET(f.pmenuid,v_sub_collections)>0;
	 end while;
 	return v_p_collections;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for queryChildRoleList
-- ----------------------------
DROP FUNCTION IF EXISTS `queryChildRoleList`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `queryChildRoleList`(v_proleid INT) RETURNS text CHARSET utf8
BEGIN
	 declare v_p_collections TEXT(4000);
	 declare v_sub_collections TEXT(4000);
	 SET v_p_collections = '$';
	 set v_sub_collections= cast(v_proleid as char);
	 while v_sub_collections is not null do
	    set v_p_collections=CONCAT(v_p_collections,',',v_sub_collections);
	 	SELECT group_concat(f.roleid) into v_sub_collections  FROM t_ums_role f WHERE  FIND_IN_SET(f.proleid,v_sub_collections)>0;
	 end while;
 	return v_p_collections;
END
;;
DELIMITER ;

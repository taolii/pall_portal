# Host: localhost  (Version 5.7.17)
# Date: 2018-04-11 19:18:46
# Generator: MySQL-Front 5.4  (Build 4.153) - http://www.mysqlfront.de/

/*!40101 SET NAMES utf8 */;

#
# Structure for table "t_ums_accountloginlog"
#

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

#
# Data for table "t_ums_accountloginlog"
#


#
# Structure for table "t_ums_acctivesessions"
#

DROP TABLE IF EXISTS `t_ums_acctivesessions`;
CREATE TABLE `t_ums_acctivesessions` (
  `activesessionid` bigint(22) NOT NULL AUTO_INCREMENT COMMENT '主键ＩＤ',
  `operatorid` int(11) NOT NULL COMMENT '操作员ＩＤ',
  `loginname` varchar(100) NOT NULL DEFAULT '' COMMENT '帐号',
  `logintime` datetime NOT NULL COMMENT '登陆时间',
  `loginip` varchar(20) DEFAULT NULL COMMENT '登陆ＩＰ',
  PRIMARY KEY (`activesessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会话表';

#
# Data for table "t_ums_acctivesessions"
#


#
# Structure for table "t_ums_admininfo"
#

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
  PRIMARY KEY (`OPERATORID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

#
# Data for table "t_ums_admininfo"
#

INSERT INTO `t_ums_admininfo` VALUES (9,'超级管理员','admin','admin','1','',NULL,'13816763234','13434@1632',NULL,NULL,1,2,1,'2017-07-08 00:55:55','2018-04-03 16:10:27'),(13,'test','test','','女','',NULL,'13816763233','13816763233@163.com','','',2,2,1,'2017-11-21 23:14:53','2017-12-13 21:43:32'),(15,'admin111','admin3','admin','0','',NULL,'13816763233','13@163.com','','',2,2,1,'2018-03-29 17:48:08','2018-04-03 16:17:43'),(16,'adminsds','adminsdssds','admin','1','',NULL,'13816763233','13@163.com','','',1,2,1,'2018-04-03 16:00:27','2018-04-04 03:59:47'),(17,'sdfs','admin334','sdsff','0','',NULL,'13816763233','sfs@163.com','','',1,2,1,'2018-04-04 04:01:18','2018-04-04 04:17:26');

#
# Structure for table "t_ums_config"
#

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

#
# Data for table "t_ums_config"
#

INSERT INTO `t_ums_config` VALUES (1,'workflow/polish/tablename',1,'polishtable201',NULL,2,'configvalue为t_ums_th_config中的tablename与menuid'),(2,'paging/pagesize',1,'10',NULL,2,'系统默认分页大小'),(3,'excel/export/records/limits',1,'100000',NULL,2,'excel结果集导出最大限制数'),(4,'dataconfig/type/throwMillstonePosition',1,'11',NULL,2,'抛光盘位置在数据配置表中的类型'),(5,'dataconfig/type/partNum',1,'12',NULL,2,'零件号在数据配置表中的类型'),(6,'dataconfig/type/polishdefect',1,'17',NULL,2,'抛光表中的缺损信息在数据配置表中的类型'),(7,'dataconfig/type/cleandefect',1,'2',NULL,2,'清洗表中的缺损信息在数据配置表中的类型'),(8,'workflow/clean/tablename',1,'cleantable202',NULL,2,'configvalue为t_ums_th_config中的tablename与menuid'),(9,'polish/download/subdirectory',1,'polish',NULL,2,'抛光管理页面excel下载子目录名称'),(10,'clean/download/subdirectory',1,'clean',NULL,2,'清洗管理页面excel下载子目录名称'),(11,'dataconfig/type/cleandefect/workingface',1,'181',NULL,2,'清洗表工作面的缺损信息在数据配置表中的类型'),(12,'dataconfig/type/cleandefect/noworkingface',1,'182',NULL,2,'清洗表非工作面的缺损信息在数据配置表中的类型'),(13,'dataconfig/type/opticalFilmingDefect/workingface',1,'31',NULL,2,'光学镀膜表工作面的缺损信息在数据配置表中的类型'),(14,'dataconfig/type/opticalFilmingDefect/noworkingface',1,'32',NULL,2,'光学镀膜表非工作面的缺损信息在数据配置表中的类型'),(15,'workflow/opticalFilming/tablename',1,'opticalfilmingtable203',NULL,2,'光学镀膜流程配置表名'),(16,'opticalFilming/download/subdirectory',1,'opticalFilming',NULL,2,'光学镀膜管理页面excel下载子目录名称'),(17,'dataconfig/type/opticalFilmingDefect',1,'3',NULL,2,'数据配置表代表光学镀膜 defect的配置类型'),(18,'workflow/PlatedFilm/tablename',1,'platedfilmtable204',NULL,2,'化学镀膜流程配置表名'),(19,'platedFilm/download/subdirectory',1,'platedFilm',NULL,2,'化学镀膜管理页面excel下载子目录名称'),(20,'dataconfig/type/polishdefect/workingface',1,'171',NULL,2,'抛光表工作面的缺损信息在数据配置表中的类型'),(21,'dataconfig/type/polishdefect/noworkingface',1,'172',NULL,2,'抛光表非工作面的缺损信息在数据配置表中的类型'),(22,'dataconfig/type/scrapinfo',1,'92',NULL,2,'数据配置表代表scrap info的配置类型'),(23,'dataconfig/type/assemblyDefect',1,'5',NULL,2,'数据配置表代表组装 defect的配置类型'),(24,'workflow/assembly/tablename',1,'assemblytable206',NULL,2,'组装流程配置表名'),(25,'dataconfig/type/assemblyDefect/workingface',1,'51',NULL,2,'组装表工作面的缺损信息在数据配置表中的类型'),(26,'dataconfig/type/assemblyDefect/noworkingface',1,'52',NULL,2,' 组装表非工作面的缺损信息在数据配置表中的类型'),(27,'assembly/download/subdirectory',1,'assembly',NULL,2,'组装管理页面excel下载子目录名称'),(28,'dataconfig/type/remark',1,'93',NULL,2,'数据配置表代表remark的配置类型'),(29,'dataconfig/type/chemicalReagent',1,'94',NULL,2,'数据配置表代表化学试剂配置类型'),(30,'workflow/chemicalReagent/tablename',1,'chemicalreagenttable207',NULL,2,'化学试剂流程配置表名'),(31,'chemicalReagent/download/subdirectory',1,'chemicalReagent',NULL,2,'化学试剂管理页面excel下载子目录名称'),(32,'default/root/menuid',1,'-1',NULL,2,'默认根节点菜单id'),(33,'default/root/roleid',1,'-1',NULL,2,'分页默认角色根节点id'),(34,'dataconfig/type/polishBom',1,'14',NULL,2,'数据配置表代表抛光模块polish Bom'),(35,'dataconfig/type/list',1,'1',NULL,2,'数据配置表代表基础数据配置列表类型'),(37,'dataconfig/type/workflow',1,'2',NULL,2,'数据配置表代表工作流数据配置列表类型'),(36,'dataconfig/type/cleanBom',1,'21',NULL,2,'数据配置表代表抛光模块Clean Bom'),(38,'workflow/polishSel/tablename',1,'selpolishtable201',NULL,2,NULL);

#
# Structure for table "t_ums_customers_consuming"
#

DROP TABLE IF EXISTS `t_ums_customers_consuming`;
CREATE TABLE `t_ums_customers_consuming` (
  `cid` bigint(22) NOT NULL COMMENT '客户消费记录唯一标识',
  `customer_name` varchar(100) NOT NULL DEFAULT '' COMMENT '客户姓名',
  `sex` varchar(20) NOT NULL DEFAULT '' COMMENT '性别',
  `mobile` varchar(18) NOT NULL DEFAULT '' COMMENT '联系电话',
  `address` text COMMENT '地址',
  `account_name` varchar(20) NOT NULL DEFAULT '' COMMENT '账号名称,用户表中的账户名',
  `expense_bonus` double(8,0) DEFAULT NULL COMMENT '消费金额',
  `expensetime` datetime NOT NULL COMMENT '消费时间',
  `expense_detail` text COMMENT '消费记录',
  `keyboarder` bigint(22) NOT NULL COMMENT '录入员id',
  `sale_account` varchar(20) DEFAULT '' COMMENT '销售员账号',
  `CREATETIME` datetime NOT NULL COMMENT '创建时间',
  `UPDATETIME` datetime DEFAULT NULL COMMENT '状态变更时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户消费记录表'
/*!50100 PARTITION BY RANGE (to_days(CREATETIME))
(PARTITION p201711 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
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
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB) */;

#
# Data for table "t_ums_customers_consuming"
#


#
# Structure for table "t_ums_data_config"
#

DROP TABLE IF EXISTS `t_ums_data_config`;
CREATE TABLE `t_ums_data_config` (
  `DATAID` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据id',
  `DATATYPE` int(3) NOT NULL COMMENT '数据类型',
  `configname` varchar(50) DEFAULT NULL COMMENT '标题',
  `DESCRIPTION` varchar(255) DEFAULT '' COMMENT '描述信息',
  `operatorid` int(11) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`DATAID`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8 COMMENT='数据字典配置表';

#
# Data for table "t_ums_data_config"
#

INSERT INTO `t_ums_data_config` VALUES (2,1,'破损信息','',9,NULL,NULL),(11,1,'throw millstone Position','',9,NULL,NULL),(12,1,'Part Num','',9,NULL,NULL),(13,1,'Remark','',9,NULL,NULL),(14,1,'Polish Bom','',9,NULL,NULL),(16,1,'化学试剂','',9,NULL,NULL),(17,2,'Polishing','',9,NULL,NULL),(18,2,'Cleaning','',9,NULL,NULL),(19,2,'光学镀膜','',9,NULL,NULL),(20,2,'组装','',9,NULL,NULL),(21,1,'Clean Bom','',9,NULL,NULL),(163,12,'13-0003','',9,NULL,NULL),(164,12,'15-9008','',9,NULL,NULL),(165,12,'14-0014','',9,NULL,NULL),(166,11,'A','',9,NULL,NULL),(167,11,'B','',9,NULL,NULL),(168,11,'C','',9,NULL,NULL),(169,16,'05-0001|04-0001','',9,NULL,NULL),(170,16,'05-0003|03-0001','',9,NULL,NULL),(171,16,'05-0002|04-0002','',9,NULL,NULL),(172,16,'05-0002|05-0067','',9,NULL,NULL),(173,16,'334','',9,NULL,NULL),(174,16,'05-0004|03-0002','',9,NULL,NULL),(175,13,'T08','',9,NULL,NULL),(176,13,'T07','',9,NULL,NULL),(177,13,'T11','',9,NULL,NULL),(178,13,'T13','',9,NULL,NULL),(179,13,'T12','',9,NULL,NULL),(180,13,'T10','',9,NULL,NULL),(181,13,'T09','',9,NULL,NULL),(182,13,'T17','',9,NULL,NULL),(183,13,'T16','',9,NULL,NULL),(184,13,'T15','',9,NULL,NULL),(185,13,'T14','',9,NULL,NULL),(186,13,'T01','',9,NULL,NULL),(187,13,'T03','',9,NULL,NULL),(188,13,'T02','',9,NULL,NULL),(189,13,'T06','',9,NULL,NULL),(190,13,'T05','',9,NULL,NULL),(191,13,'T04','',9,NULL,NULL),(192,201,'膜层脱落','',9,NULL,NULL),(193,201,'绿膜','',9,NULL,NULL),(194,201,'彩虹到芯','',9,NULL,NULL),(195,201,'印迹','',9,NULL,NULL),(196,201,'胶','',9,NULL,NULL),(197,201,'异物','',9,NULL,NULL),(198,201,'缝隙','',9,NULL,NULL),(199,201,'膜下异物','',9,NULL,NULL),(200,201,'其它','',9,NULL,NULL),(201,201,'崩边','',9,NULL,NULL),(202,201,'划痕','',9,NULL,NULL),(203,201,'异物','',9,NULL,NULL),(204,202,'崩边','',9,NULL,NULL),(205,202,'划痕','',9,NULL,NULL),(206,202,'异物','',9,NULL,NULL),(207,202,'胶','',9,NULL,NULL),(208,202,'印迹','',9,NULL,NULL),(209,202,'高低','',9,NULL,NULL),(210,202,'装反','',9,NULL,NULL),(211,202,'破点','',9,NULL,NULL),(212,202,'其它','',9,NULL,NULL),(213,171,'麻点','Polishing',9,NULL,NULL),(214,171,'崩边','Polishing',9,NULL,NULL),(215,171,'划痕','Polishing',9,NULL,NULL),(216,171,'异物','Polishing',9,NULL,NULL),(217,171,'印迹','Polishing',9,NULL,NULL),(218,171,'其它','Polishing',9,NULL,NULL),(219,171,'12-0003','',9,NULL,NULL),(220,171,'水印','Polishing',9,NULL,NULL),(221,171,'缝隙','Polishing',9,NULL,NULL),(222,171,'胶','polishing',9,NULL,NULL),(223,172,'崩边','',9,NULL,NULL),(224,172,'划痕','',9,NULL,NULL),(225,172,'异物','',9,NULL,NULL),(226,172,'印迹','',9,NULL,NULL),(227,172,'其它','',9,NULL,NULL),(228,172,'麻点','',9,NULL,NULL),(229,172,'水印','',9,NULL,NULL),(230,172,'缝隙','',9,NULL,NULL),(231,172,'胶','',9,NULL,NULL),(232,181,'麻点','',9,NULL,NULL),(233,181,'水印','',9,NULL,NULL),(234,181,'胶','',9,NULL,NULL),(235,181,'缝隙','',9,NULL,NULL),(236,181,'麻点','',9,NULL,NULL),(237,181,'水印','',9,NULL,NULL),(238,181,'印迹','',9,NULL,NULL),(239,181,'胶','',9,NULL,NULL),(240,181,'缝隙','',9,NULL,NULL),(241,181,'其它','',9,NULL,NULL),(242,182,'崩边','',9,NULL,NULL),(243,182,'划痕','',9,NULL,NULL),(244,182,'异物','',9,NULL,NULL),(245,182,'棉纱','',9,NULL,NULL),(246,182,'麻点','',9,NULL,NULL),(247,182,'水印','',9,NULL,NULL),(248,182,'印痕','',9,NULL,NULL),(249,182,'胶','',9,NULL,NULL),(250,182,'缝隙','',9,NULL,NULL),(251,182,'其它','',9,NULL,NULL),(252,191,'崩边','',9,NULL,NULL),(253,191,'划痕','',9,NULL,NULL),(254,191,'异物','',9,NULL,NULL),(255,191,'胶','',9,NULL,NULL),(256,191,'印迹','',9,NULL,NULL),(257,191,'绿膜','',9,NULL,NULL),(258,191,'彩虹到芯','',9,NULL,NULL),(259,191,'膜层脱落','',9,NULL,NULL),(260,191,'膜下异物','',9,NULL,NULL),(261,191,'缝隙','',9,NULL,NULL),(262,191,'其它','',9,NULL,NULL),(263,192,'崩边','',9,NULL,NULL),(264,192,'划痕','',9,NULL,NULL),(265,192,'异物','',9,NULL,NULL),(266,192,'胶','',9,NULL,NULL),(267,192,'印迹','',9,NULL,NULL),(268,192,'其它','',9,NULL,NULL),(269,14,'ddd','',9,'2018-04-07 01:44:20','2018-04-07 01:44:20'),(270,14,'ddddsss','',9,'2018-04-07 01:44:28','2018-04-07 01:44:28'),(271,14,'fggff','',9,'2018-04-07 01:44:35','2018-04-07 01:44:35'),(272,21,'C1','',9,'2018-04-10 09:45:27','2018-04-10 09:45:27'),(273,21,'C2','',9,'2018-04-10 09:45:34','2018-04-10 09:45:34'),(274,21,'C3','',9,'2018-04-10 09:45:41','2018-04-10 09:45:41');

#
# Structure for table "t_ums_deptinfo"
#

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

#
# Data for table "t_ums_deptinfo"
#


#
# Structure for table "t_ums_loginlimitinfo"
#

DROP TABLE IF EXISTS `t_ums_loginlimitinfo`;
CREATE TABLE `t_ums_loginlimitinfo` (
  `LIMITID` bigint(22) NOT NULL COMMENT 'id',
  `ACCOUNT` varchar(30) DEFAULT NULL COMMENT '帐号名',
  `LIMITSTARTTIME` datetime DEFAULT NULL COMMENT '限制登录开始时间',
  `LIMITENDTIME` datetime DEFAULT NULL COMMENT '限制登录结束时间',
  `LIMITIP` text COMMENT '受限ip串',
  `OPERATORID` bigint(22) NOT NULL COMMENT '操作员编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帐号受限信息表';

#
# Data for table "t_ums_loginlimitinfo"
#


#
# Structure for table "t_ums_menu_button"
#

DROP TABLE IF EXISTS `t_ums_menu_button`;
CREATE TABLE `t_ums_menu_button` (
  `btnid` int(4) NOT NULL AUTO_INCREMENT COMMENT '按钮编号',
  `menuid` int(4) NOT NULL COMMENT '菜单编号',
  `btnename` varchar(100) DEFAULT '' COMMENT '按钮名称',
  `btncname` varchar(100) DEFAULT '' COMMENT '中文名称',
  `btnclass` varchar(50) DEFAULT '' COMMENT '按钮样式',
  `btniconclass` varchar(50) DEFAULT '',
  `DESCRIPTION` text COMMENT '描述信息',
  PRIMARY KEY (`btnid`,`menuid`)
) ENGINE=InnoDB AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8 COMMENT='按钮权限表';

#
# Data for table "t_ums_menu_button"
#

INSERT INTO `t_ums_menu_button` VALUES (1001,105,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1002,105,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1004,105,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1005,105,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1006,105,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1007,105,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1008,106,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1009,106,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1010,106,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1011,106,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1012,106,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1013,106,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1014,201,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1015,201,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1016,201,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1017,201,'btn-export','导出','btn btn-primary btn-sm','fa fa-download',NULL),(1018,201,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1019,201,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(1020,201,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1021,201,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1022,202,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1023,202,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1024,202,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1025,202,'btn-export','导出','btn btn-primary btn-sm','fa fa-download',NULL),(1026,202,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1027,202,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(1028,202,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1029,202,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1030,203,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1031,203,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1032,203,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1033,203,'btn-export','导出','btn btn-primary btn-sm','fa fa-download',NULL),(1034,203,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1035,203,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(1036,203,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1037,203,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1038,204,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1039,204,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1040,204,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1041,204,'btn-export','导出','btn btn-primary btn-sm','fa fa-download',NULL),(1042,204,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1043,204,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(1044,204,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1045,204,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1046,205,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1047,205,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1048,205,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1049,205,'btn-export','导出','btn btn-primary btn-sm','fa fa-download',NULL),(1050,205,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1051,205,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(1052,205,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1053,205,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1054,206,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1055,206,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1056,206,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1057,206,'btn-export','导出','btn btn-primary btn-sm','fa fa-download',NULL),(1058,206,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1059,206,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(1060,206,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1061,206,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL),(1062,207,'btn-query','查询','btn btn-primary','fa fa-search',NULL),(1063,207,'btn-add','添加','btn btn-primary btn-sm','fa fa-plus',NULL),(1064,207,'btn-delAll','批量删除','btn btn-primary btn-sm','fa fa-remove',NULL),(1065,207,'btn-export','导出','btn btn-primary btn-sm','fa fa-download',NULL),(1066,207,'btn_refresh','刷新','btn btn-primary btn-sm','fa fa-refresh',NULL),(1067,207,'copyRow','复制','btn btn-primary btn-xs','fa fa-copy',NULL),(1068,207,'editRow','修改','btn btn-primary btn-xs','fa fa-edit',NULL),(1069,207,'delRow','删除','btn btn-primary btn-xs','fa fa-trash-o',NULL);

#
# Structure for table "t_ums_menuinfo"
#

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
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COMMENT='菜单表';

#
# Data for table "t_ums_menuinfo"
#

INSERT INTO `t_ums_menuinfo` VALUES (1,'基础管理','menu-icon glyphicon glyphicon-cog',NULL,0,0,-1,1,NULL),(2,'工作流管理','menu-icon glyphicon glyphicon-globe','',0,0,-1,3,''),(101,'权限管理','胜多负少',NULL,1,1,1,1,''),(102,'用户管理','\r\nmenu-icon glyphicon glyphicon-user','/user/userManage',1,0,1,2,NULL),(103,'角色管理','menu-icon glyphicon glyphicon-asterisk','/role/roleManage',1,0,1,3,NULL),(104,'权限配置管理','menu-icon glyphicons \r\nglyphicons-user','/right/rightManage',1,1,1,4,NULL),(105,'菜单管理','menu-icon glyphicon glyphicon-eye-open','/menu/menuManage',1,1,1,5,NULL),(106,'缺损管理','menu-icon glyphicon glyphicon-book','/defect/defectManage',1,0,1,6,NULL),(107,'数据配置管理','menu-icon glyphicon glyphicons-settings','/dataconfig/dataConfigManage',1,0,1,7,NULL),(108,'按钮管理','menu-icon glyphicon glyphicon-eye-open','/button/buttonManage',1,0,1,8,''),(201,'抛磨','menu-icon glyphicons\r\nglyphicons-hand-right','/workflow/polishManage',1,0,2,1,NULL),(202,'清洗','menu-icon glyphicons\r\nglyphicons-hand-right','/workflow/cleanManage',1,0,2,2,NULL),(203,'光学镀膜','menu-icon glyphicons\r\nglyphicons-hand-right','/workflow/opticalFilmingManage',1,0,2,3,NULL),(204,'化学镀膜APS','menu-icon glyphicons\r\nglyphicons-hand-right','/workflow/platedFilmManage',1,0,2,4,NULL),(205,'组装','menu-icon glyphicons\r\nglyphicons-hand-right','/workflow/assemblyManage',1,0,2,6,NULL),(206,'生化镀膜','menu-icon glyphicons\r\nglyphicons-hand-right','/workflow/chemicalReagentManage',1,0,2,7,NULL),(207,'二次生化镀膜','glyphicons-hand-right','/workflow/chemicalReagentManage',1,0,2,8,'');

#
# Structure for table "t_ums_provinceinfo"
#

DROP TABLE IF EXISTS `t_ums_provinceinfo`;
CREATE TABLE `t_ums_provinceinfo` (
  `PROVINCEID` varchar(50) NOT NULL COMMENT '省份编码',
  `PROVINCENAME` varchar(50) NOT NULL COMMENT '省名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省份信息表';

#
# Data for table "t_ums_provinceinfo"
#


#
# Structure for table "t_ums_right"
#

DROP TABLE IF EXISTS `t_ums_right`;
CREATE TABLE `t_ums_right` (
  `RIGHTID` int(10) NOT NULL AUTO_INCREMENT COMMENT '权限编码',
  `RIGHTTYPE` int(2) NOT NULL COMMENT '权限类型  1 菜单权限',
  `DATAID` int(4) NOT NULL COMMENT '数据权限id,如权限类型为菜单，则dataid则为菜单id，依次类推',
  `DESCRIPTION` text COMMENT '浏览按钮权限描述',
  PRIMARY KEY (`RIGHTID`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COMMENT='权限信息表';

#
# Data for table "t_ums_right"
#

INSERT INTO `t_ums_right` VALUES (1,1,1,NULL),(2,1,2,NULL),(3,1,101,NULL),(4,1,102,NULL),(5,1,103,NULL),(6,1,104,NULL),(7,1,105,NULL),(8,1,106,NULL),(9,1,107,NULL),(10,1,108,NULL),(11,1,201,NULL),(12,1,202,NULL),(13,1,203,NULL),(14,1,204,NULL),(15,1,205,NULL),(16,1,206,NULL),(17,1,207,NULL),(25,2,1001,NULL),(26,2,1002,NULL),(27,2,1003,NULL),(28,2,1004,NULL),(29,2,1005,NULL),(30,2,1006,NULL),(31,2,1007,NULL),(32,2,1008,NULL),(33,2,1009,NULL),(34,2,1010,NULL),(35,2,1011,NULL),(36,2,1012,NULL),(37,2,1013,NULL),(38,2,1014,NULL),(39,2,1015,NULL),(40,2,1016,NULL),(41,2,1017,NULL),(42,2,1018,NULL),(43,2,1019,NULL),(44,2,1020,NULL),(45,2,1021,NULL),(46,2,1022,NULL),(47,2,1023,NULL),(48,2,1024,NULL),(49,2,1025,NULL),(50,2,1026,NULL),(51,2,1027,NULL),(52,2,1028,NULL),(53,2,1029,NULL),(54,2,1030,NULL),(55,2,1031,NULL),(56,2,1032,NULL),(57,2,1033,NULL),(58,2,1034,NULL),(59,2,1035,NULL),(60,2,1036,NULL),(61,2,1037,NULL),(62,2,1038,NULL),(63,2,1039,NULL),(64,2,1040,NULL),(65,2,1041,NULL),(66,2,1042,NULL),(67,2,1043,NULL),(68,2,1044,NULL),(69,2,1045,NULL),(70,2,1046,NULL),(71,2,1047,NULL),(72,2,1048,NULL),(73,2,1049,NULL),(74,2,1050,NULL),(75,2,1051,NULL),(76,2,1052,NULL),(77,2,1053,NULL),(78,2,1054,NULL),(79,2,1055,NULL),(80,2,1056,NULL),(81,2,1057,NULL),(82,2,1058,NULL),(83,2,1059,NULL),(84,2,1060,NULL),(85,2,1061,NULL),(86,2,1062,NULL),(87,2,1063,NULL),(88,2,1064,NULL),(89,2,1065,NULL),(90,2,1066,NULL),(91,2,1067,NULL),(92,2,1068,NULL),(93,2,1069,NULL);

#
# Structure for table "t_ums_role"
#

DROP TABLE IF EXISTS `t_ums_role`;
CREATE TABLE `t_ums_role` (
  `ROLEID` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `ROLENAME` varchar(60) DEFAULT '' COMMENT '角色名',
  `PROLEID` int(10) DEFAULT NULL,
  `DESCRIPTION` varchar(400) DEFAULT '' COMMENT '角色描述语言值',
  PRIMARY KEY (`ROLEID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

#
# Data for table "t_ums_role"
#

INSERT INTO `t_ums_role` VALUES (1,'超级角色',-1,''),(2,'流程管理',-1,''),(17,'抛磨_查看',NULL,''),(18,'抛磨_新增',NULL,''),(19,'抛磨_删除',NULL,''),(20,'抛磨_修改',NULL,''),(21,'抛磨_批量删除',NULL,''),(22,'抛磨_导出',NULL,''),(23,'清洗_查看',NULL,''),(24,'清洗_新增',NULL,''),(25,'清洗_删除',NULL,''),(26,'清洗_修改',NULL,''),(27,'清洗_批量删除',NULL,''),(28,'清洗_导出',NULL,''),(29,'光学镀膜_查看',NULL,''),(30,'光学镀膜_新增',NULL,''),(31,'光学镀膜_删除',NULL,''),(32,'光学镀膜_修改',NULL,''),(33,'光学镀膜_导出',NULL,''),(34,'光学镀膜_批量删除',NULL,''),(35,'化学镀膜_查看',NULL,''),(36,'化学镀膜_修改',NULL,''),(37,'化学镀膜_删除',NULL,''),(38,'化学镀膜_新增',NULL,''),(39,'化学镀膜_批量删除',NULL,''),(40,'化学镀膜_导出',NULL,''),(41,'组装_查看',NULL,''),(42,'组装_修改',NULL,''),(43,'组装_删除',NULL,''),(44,'组装_新增',NULL,''),(45,'组装_批量删除',NULL,''),(46,'组装_导出',NULL,''),(47,'生化镀膜_查看',NULL,''),(48,'生化镀膜_修改',NULL,''),(49,'生化镀膜_删除',NULL,''),(50,'生化镀膜_新增',NULL,''),(51,'生化镀膜_批量删除',NULL,''),(52,'生化镀膜_导出',NULL,''),(53,'二次生化镀膜_查看',NULL,''),(54,'二次生化镀膜_修改',NULL,''),(55,'二次生化镀膜_删除',NULL,''),(56,'二次生化镀膜_新增',NULL,''),(57,'二次生化镀膜_批量删除',NULL,''),(58,'二次生化镀膜_导出',NULL,'');

#
# Structure for table "t_ums_rolepermission"
#

DROP TABLE IF EXISTS `t_ums_rolepermission`;
CREATE TABLE `t_ums_rolepermission` (
  `RIGHTID` int(10) NOT NULL COMMENT '权限编码',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与权限对应表';

#
# Data for table "t_ums_rolepermission"
#

INSERT INTO `t_ums_rolepermission` VALUES (1,2),(2,1),(3,1),(4,1),(5,1),(8,1),(9,1),(17,1),(11,2),(12,1),(13,2),(14,2),(15,1),(10,1),(11,1),(13,1),(14,1),(16,1),(1,1),(7,1);

#
# Structure for table "t_ums_th_config"
#

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

#
# Data for table "t_ums_th_config"
#

INSERT INTO `t_ums_th_config` VALUES (202,'cleantable',1,1,NULL,3,1,NULL,'',2,'',NULL),(202,'cleantable',1,2,NULL,3,1,NULL,'cleanID',1,'cleanid',NULL),(202,'cleantable',1,3,NULL,3,1,NULL,'cleanTime',0,'Clean Date',NULL),(202,'cleantable',1,7,NULL,3,1,NULL,'cleanLotNum',0,'Clean LOT#',NULL),(202,'cleantable',1,8,NULL,3,1,NULL,'scrapQty',0,'Scrap Qty',NULL),(202,'cleantable',1,9,NULL,3,1,NULL,'outputQty',0,'Output Qty',NULL),(202,'cleantable',1,10,NULL,1,3,NULL,'',0,'估计值统计',NULL),(202,'cleantable',2,10,NULL,1,1,NULL,'',0,'工作面',NULL),(202,'cleantable',2,11,NULL,1,1,NULL,'',0,'非工作面',NULL),(202,'cleantable',2,12,NULL,1,1,NULL,'',0,'',NULL),(202,'cleantable',3,10,NULL,1,1,181,'',0,'',NULL),(202,'cleantable',3,11,NULL,1,1,182,'',0,'',NULL),(202,'cleantable',3,12,NULL,1,1,NULL,'yield',0,'合格率',NULL),(202,'cleantable',1,13,NULL,3,1,NULL,'toOtherQty',0,'To Other Qty',NULL),(202,'cleantable',1,14,NULL,3,1,NULL,'partNum',0,'Part Num',NULL),(202,'cleantable',1,15,NULL,3,1,NULL,'workOrderNum',0,'Work order number',NULL),(202,'cleantable',1,16,NULL,3,1,NULL,'operatorName',0,'操作员',NULL),(202,'cleantable',1,17,NULL,3,1,NULL,'',2,'操作',NULL),(203,'opticalfilmingtable',1,1,NULL,2,1,NULL,NULL,2,NULL,NULL),(203,'opticalfilmingtable',1,2,NULL,2,1,NULL,'opfID',1,'opfID',NULL),(203,'opticalfilmingtable',1,3,NULL,2,1,NULL,'optTime',0,'Date',NULL),(203,'opticalfilmingtable',1,4,NULL,2,1,NULL,'inputLotNum',0,'Input LOT#',NULL),(203,'opticalfilmingtable',1,5,NULL,2,1,NULL,'inputQty',0,'Input Qty(pcs)',NULL),(203,'opticalfilmingtable',1,6,NULL,2,1,NULL,'fixtureNum',0,'Fixture#',NULL),(203,'opticalfilmingtable',1,7,NULL,2,1,NULL,'outputLotNum',0,'Output LOT#',NULL),(203,'opticalfilmingtable',1,8,NULL,2,1,NULL,'outputQty',0,'output Qty(pcs)',NULL),(203,'opticalfilmingtable',1,9,NULL,2,1,NULL,'scrapQty',0,'Scrap Qty(pcs)',NULL),(203,'opticalfilmingtable',1,10,NULL,1,1,NULL,NULL,0,'工作面',NULL),(203,'opticalfilmingtable',2,10,1,1,1,191,NULL,0,NULL,NULL),(203,'opticalfilmingtable',1,11,NULL,1,1,NULL,NULL,0,'非工作面',NULL),(203,'opticalfilmingtable',2,11,NULL,1,1,192,NULL,0,NULL,NULL),(203,'opticalfilmingtable',1,12,NULL,2,1,NULL,'qcUseQty',0,'QC Use Qty(pcs)',NULL),(203,'opticalfilmingtable',1,13,NULL,2,1,NULL,'toAPSQty',0,'To APS coating Qty(pcs)',NULL),(203,'opticalfilmingtable',1,14,NULL,2,1,NULL,'partNum',0,'Part Num',NULL),(203,'opticalfilmingtable',1,15,NULL,2,1,NULL,'workOrderNum',0,'work order number',NULL),(203,'opticalfilmingtable',1,16,NULL,2,1,NULL,'operatorName',0,'操作员',NULL),(203,'opticalfilmingtable',1,17,NULL,2,1,NULL,NULL,2,'操作',NULL),(204,'platedfilmtable',1,1,NULL,1,1,NULL,'',2,'',''),(204,'platedfilmtable',1,2,NULL,1,1,NULL,'pfID',1,'pfID',''),(204,'platedfilmtable',1,3,NULL,1,1,NULL,'coatingTime',0,'Coating Date',''),(204,'platedfilmtable',1,4,NULL,1,1,NULL,'pfTime',0,'Date',''),(204,'platedfilmtable',1,5,NULL,1,1,NULL,'inputLotNum',0,'Input LOT#',''),(204,'platedfilmtable',1,6,NULL,1,1,NULL,'inputQty',0,'Input Qty(pcs)',''),(204,'platedfilmtable',1,7,NULL,1,1,NULL,'fixtureNum',0,'Fixture#',''),(204,'platedfilmtable',1,8,NULL,1,1,NULL,'apsBottle',0,'APS Bottle',''),(204,'platedfilmtable',1,9,NULL,1,1,NULL,'outputLotNum',0,'Output LOT#',''),(204,'platedfilmtable',1,10,NULL,1,1,NULL,'outputQty',0,'Output Qty(pcs)',''),(204,'platedfilmtable',1,11,NULL,1,1,NULL,'scrapQty',0,'Scrap Qty(pcs)',''),(204,'platedfilmtable',1,12,NULL,1,1,NULL,'underIQCQty',0,'Under IQC Qty(pcs)',''),(204,'platedfilmtable',1,13,NULL,1,1,NULL,'qNum',0,'Q-NUM',''),(204,'platedfilmtable',1,14,NULL,1,1,NULL,'kNum',0,'K-NUM',''),(204,'platedfilmtable',1,15,NULL,1,1,NULL,'qcUseQty',0,'QC Use Qty(pcs)',''),(204,'platedfilmtable',1,16,NULL,1,1,NULL,'functionalTestQty',0,'Functional Test Qty(pcs)',''),(204,'platedfilmtable',1,17,NULL,1,1,NULL,'toHUBQty',0,'To HUB Qty(pcs)',''),(204,'platedfilmtable',1,18,NULL,1,1,NULL,'remainQty',0,'REMAIN QTY',''),(204,'platedfilmtable',1,19,NULL,1,1,NULL,'apsCondition',0,'APS condition',''),(204,'platedfilmtable',1,20,NULL,1,1,NULL,'partNum',0,'Part Num',''),(204,'platedfilmtable',1,21,NULL,1,1,NULL,'workOrderNum',0,'work order number',''),(204,'platedfilmtable',1,22,NULL,1,1,NULL,'operatorName',0,'操作员',''),(204,'platedfilmtable',1,23,NULL,1,1,NULL,'',2,'操作',''),(201,'polishtable',1,1,NULL,4,1,NULL,NULL,2,NULL,NULL),(201,'polishtable',1,2,NULL,4,1,NULL,'polishID',1,'polishid',NULL),(201,'polishtable',1,3,NULL,4,1,NULL,'pickingTime',0,'领料日期',NULL),(201,'polishtable',1,4,NULL,4,1,NULL,'polishTime',0,'Polish Date',NULL),(201,'polishtable',1,5,NULL,4,1,NULL,'inputLotNum',0,'Input LOT#',NULL),(201,'polishtable',1,6,NULL,4,1,NULL,'inputQty',0,'Input Qty.(pcs)',NULL),(201,'polishtable',1,7,NULL,4,1,NULL,'fixtureNumber',0,'Fixture#',NULL),(201,'polishtable',1,8,NULL,4,1,NULL,'throwMillstoneNum',0,'millstone#',NULL),(201,'polishtable',1,9,NULL,4,1,NULL,'throwMillstonePosition',0,'Loading Fixture Position',NULL),(201,'polishtable',1,10,NULL,1,4,NULL,NULL,0,'估计值统计',NULL),(201,'polishtable',2,10,NULL,1,4,NULL,NULL,0,'抛磨后检验',NULL),(201,'polishtable',3,10,NULL,1,1,NULL,NULL,0,'工作面',NULL),(201,'polishtable',3,11,NULL,1,1,NULL,NULL,0,'非工作面',NULL),(201,'polishtable',4,10,NULL,1,1,172,NULL,0,NULL,NULL),(201,'polishtable',4,11,NULL,1,1,171,NULL,0,NULL,NULL),(201,'polishtable',3,12,NULL,2,1,NULL,'casualInspectionNum',0,'抽检总数',NULL),(201,'polishtable',3,13,NULL,2,1,NULL,'yield',0,'合格率',NULL),(201,'polishtable',1,14,NULL,4,1,NULL,'polishLotNum',0,'Polish LOT#',NULL),(201,'polishtable',1,17,NULL,4,1,NULL,'partNum',0,'Part NO',NULL),(201,'polishtable',1,18,NULL,4,1,NULL,'workOrderNum',0,'work order number',NULL),(201,'polishtable',1,19,NULL,4,1,NULL,'operatorName',3,'操作员',NULL),(201,'polishtable',1,20,NULL,4,1,NULL,NULL,2,'操作',NULL),(201,'polishtable',1,16,NULL,4,1,NULL,'measuredValues',0,'测量值',NULL),(206,'assemblytable',1,1,NULL,2,1,NULL,NULL,2,NULL,NULL),(206,'assemblytable',1,2,NULL,2,1,NULL,'assemblyID',1,'assemblyID',NULL),(206,'assemblytable',1,3,NULL,2,1,NULL,'deliveryTime',0,'delivery Date',NULL),(206,'assemblytable',1,4,NULL,2,1,NULL,'trayLotNum',0,'TRAY#',NULL),(206,'assemblytable',1,5,NULL,2,1,NULL,'inputLotNum',0,'Input LOT#',NULL),(206,'assemblytable',1,6,NULL,2,1,NULL,'inputQty',0,'Input Qty(pcs)',NULL),(206,'assemblytable',1,7,NULL,2,1,NULL,'fixtureNum',0,'Fixture#',NULL),(206,'assemblytable',1,8,NULL,2,1,NULL,'hubLotNum',0,'HUB Lot#',NULL),(206,'assemblytable',1,9,NULL,2,1,NULL,'outputLotNum',0,'Output LOT#',NULL),(206,'assemblytable',1,10,NULL,2,1,NULL,'outputQty',0,'output Qty(pcs)',NULL),(206,'assemblytable',1,11,NULL,2,1,NULL,'scrapQty',0,'Scrap Qty(pcs)',NULL),(206,'assemblytable',1,12,NULL,1,1,NULL,NULL,3,'工作面',NULL),(206,'assemblytable',1,13,NULL,1,1,NULL,NULL,3,'非工作面',NULL),(206,'assemblytable',1,14,NULL,2,1,NULL,'partNum',0,'Part Num',NULL),(206,'assemblytable',1,15,NULL,2,1,NULL,'workOrderNum',0,'work order number',NULL),(206,'assemblytable',1,16,NULL,2,1,NULL,'remark',0,'Remark',NULL),(206,'assemblytable',1,17,NULL,2,1,NULL,'operatorName',3,'操作员',NULL),(206,'assemblytable',1,18,NULL,2,1,NULL,NULL,2,'操作',NULL),(206,'assemblytable',2,12,1,1,1,201,NULL,3,NULL,NULL),(206,'assemblytable',2,13,NULL,1,1,202,NULL,3,NULL,NULL),(207,'chemicalreagenttable',1,1,NULL,2,1,NULL,NULL,2,NULL,NULL),(207,'chemicalreagenttable',1,2,NULL,2,1,NULL,'crID',1,'crID',NULL),(207,'chemicalreagenttable',1,3,NULL,2,1,NULL,'lot',0,'Lot',NULL),(207,'chemicalreagenttable',1,4,NULL,1,1,NULL,NULL,0,'混合试剂',NULL),(207,'chemicalreagenttable',1,5,NULL,2,1,NULL,'assemblyOutputLotNums',0,'14-####Lot',NULL),(207,'chemicalreagenttable',1,6,NULL,2,1,NULL,'pfOutputLotNums',0,'APS Lot',NULL),(207,'chemicalreagenttable',1,7,NULL,2,1,NULL,'ocOutputLotNums',0,'OP.Lot',NULL),(207,'chemicalreagenttable',1,8,NULL,1,2,NULL,NULL,0,'Fiber',NULL),(207,'chemicalreagenttable',1,10,NULL,2,1,NULL,'coatingStation',0,'Coating Station',NULL),(207,'chemicalreagenttable',1,11,NULL,2,1,NULL,'docRev',0,'Doc.Rev',NULL),(207,'chemicalreagenttable',1,12,NULL,2,1,NULL,'goodsQty',0,'Goods',NULL),(207,'chemicalreagenttable',1,13,NULL,2,1,NULL,'inputQty',0,'Input',NULL),(207,'chemicalreagenttable',1,14,NULL,2,1,NULL,'theoryYield',0,'theoretical Yield',NULL),(207,'chemicalreagenttable',1,15,NULL,2,1,NULL,'actualYield',0,'actual Yield',NULL),(207,'chemicalreagenttable',1,16,NULL,2,1,NULL,'theoryActualYield',0,'theoretical VS actual',NULL),(207,'chemicalreagenttable',1,17,NULL,2,1,NULL,'operatorName',0,'操作员',NULL),(207,'chemicalreagenttable',1,18,NULL,2,1,NULL,NULL,2,'操作',NULL),(207,'chemicalreagenttable',2,8,NULL,1,1,NULL,'rawMaterial',0,'Raw Material',NULL),(207,'chemicalreagenttable',2,9,NULL,1,1,NULL,'inPutDate',0,'In Put Date',NULL),(207,'chemicalreagenttable',2,4,NULL,1,1,94,NULL,0,NULL,NULL),(201,'polishtable',1,18,NULL,4,1,NULL,'polishBom',0,'Polish Bom',NULL),(202,'cleantable',1,4,NULL,3,1,NULL,'fixtureNumber',0,'Fixture#',NULL),(202,'cleantable',1,5,NULL,3,1,NULL,'inputLotNum',0,'Input LOT#',NULL),(202,'cleantable',1,6,NULL,3,1,NULL,'cleanBom',0,'Clean BOM',NULL),(201,'polishtable',1,15,NULL,4,1,NULL,'outputQty',1,'outputQty',NULL),(201,'selpolishtable',1,1,NULL,1,1,NULL,NULL,0,NULL,NULL),(201,'selpolishtable',1,2,NULL,1,1,NULL,'polishID',1,'polishid',NULL),(201,'selpolishtable',1,3,NULL,1,1,NULL,'pickingTime',0,'领料日期',NULL),(201,'selpolishtable',1,4,NULL,1,1,NULL,'polishTime',0,'Polish Date',NULL),(201,'selpolishtable',1,5,NULL,1,1,NULL,'fixtureNumber',0,'Fixture#',NULL),(201,'selpolishtable',1,6,NULL,1,1,NULL,'throwMillstonePosition',1,'Loading Fixture Position',NULL),(201,'selpolishtable',1,7,NULL,1,1,NULL,'throwMillstoneNum',1,'millstone#',NULL),(201,'selpolishtable',1,8,NULL,1,1,NULL,'inputQty',0,'Input Qty.(pcs)',NULL),(201,'selpolishtable',1,9,NULL,1,1,NULL,'inputLotNum',0,'Input LOT#',NULL),(201,'selpolishtable',1,10,NULL,1,1,NULL,'polishLotNum',0,'Polish LOT#',NULL),(201,'selpolishtable',1,11,NULL,1,1,NULL,'outputQty',1,'outputQty',NULL),(201,'selpolishtable',1,12,NULL,1,1,NULL,'polishBom',0,'Polish Bom',NULL),(201,'selpolishtable',1,13,NULL,1,1,NULL,'measuredValues',1,'测量值',NULL),(201,'selpolishtable',1,14,NULL,1,1,NULL,'partNum',0,'Part NO',NULL),(201,'selpolishtable',1,15,NULL,1,1,NULL,'workOrderNum',0,'work order number',NULL);

#
# Structure for table "t_ums_userpermission"
#

DROP TABLE IF EXISTS `t_ums_userpermission`;
CREATE TABLE `t_ums_userpermission` (
  `OPERATORID` int(8) NOT NULL COMMENT '操作员编号',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色对应表';

#
# Data for table "t_ums_userpermission"
#

INSERT INTO `t_ums_userpermission` VALUES (3,2),(4,2),(13,2),(9,1),(15,13),(15,12),(15,9),(15,8),(15,6),(15,5),(15,4),(15,2),(15,1),(16,58),(16,57),(16,54),(16,53),(16,50),(16,49),(16,46),(16,45),(16,41),(16,37),(17,58),(17,56),(17,54),(17,52),(17,50),(17,49),(17,48),(17,46),(17,45),(17,44),(17,40),(17,38);

#
# Structure for table "t_ums_workflow_assembly"
#

DROP TABLE IF EXISTS `t_ums_workflow_assembly`;
CREATE TABLE `t_ums_workflow_assembly` (
  `assembly_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `delivery_time` date DEFAULT NULL COMMENT '交付日期',
  `tray_lot_num` varchar(20) DEFAULT NULL COMMENT 'TRAY#',
  `input_lot_num` varchar(20) DEFAULT NULL COMMENT 'input LOT#',
  `input_qty` int(10) DEFAULT NULL COMMENT 'input Qty(pcs)',
  `fixture_num` varchar(50) NOT NULL COMMENT '光纤的料号及批次号',
  `hub_lot_num` varchar(20) DEFAULT NULL COMMENT 'HUB#',
  `output_lot_num` varchar(20) DEFAULT NULL COMMENT 'Output LOT#',
  `output_qty` int(10) DEFAULT NULL COMMENT 'output Qty(pcs)',
  `scrap_qty` int(10) DEFAULT NULL COMMENT 'Scrap Qty(pcs)',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `remark` varchar(20) DEFAULT NULL COMMENT 'drop down T01….T17  是TRAY#',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`assembly_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='组装表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201711 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
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
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB) */;

#
# Data for table "t_ums_workflow_assembly"
#

INSERT INTO `t_ums_workflow_assembly` VALUES (25,'2017-11-12','k94605','A1702031',96,'Q723','JS170120B','K170302XX',3,3,'15-9008','sdfs','T05',9,'2017-11-12 16:24:48','2017-11-22 00:12:26'),(27,'2017-11-25','dfd','sdfs',3,'sdcs','sds','sds',3,3,'14-0014','we','T17',9,'2017-11-25 19:07:23','2017-11-25 19:07:23');

#
# Structure for table "t_ums_workflow_chemical_reagent"
#

DROP TABLE IF EXISTS `t_ums_workflow_chemical_reagent`;
CREATE TABLE `t_ums_workflow_chemical_reagent` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `lot` varchar(20) DEFAULT NULL COMMENT '试剂混合物的批次，Lot',
  `raw_material` varchar(20) DEFAULT NULL COMMENT 'FIBER RAW MATERIAL',
  `in_put_date` date DEFAULT NULL COMMENT 'INPUT DATE',
  `coating_station` varchar(20) DEFAULT NULL COMMENT 'BIO 镀膜设备名称/每一个tray需要记录其对应在镀膜设备镀膜时放置的位置',
  `doc_rev` varchar(50) DEFAULT NULL COMMENT 'DOC.REV 依据文件及版本',
  `goods_qty` int(10) DEFAULT '0' COMMENT '良品数量',
  `input_qty` int(10) DEFAULT '0' COMMENT '投入数量',
  `theory_yield` double(5,2) DEFAULT NULL COMMENT '理论良率',
  `actual_yield` double(5,2) DEFAULT NULL COMMENT '实际良率',
  `theory_actual_yield` double(5,2) DEFAULT NULL COMMENT '理论和实际良率比较',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cr_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='化学试剂表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201711 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
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
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB) */;

#
# Data for table "t_ums_workflow_chemical_reagent"
#

INSERT INTO `t_ums_workflow_chemical_reagent` VALUES (8,'1610312','XC160708','2017-11-08','B0135','5H-18',9024,9600,94.00,94.00,100.00,9,'2017-11-20 10:53:09','2017-11-22 00:15:00'),(9,'sdf','sdfs','2017-11-25','sdfsd','sdg',56,55,67.00,101.82,151.97,9,'2017-11-25 15:03:26','2017-11-25 15:03:32');

#
# Structure for table "t_ums_workflow_chemical_reagent_relation"
#

DROP TABLE IF EXISTS `t_ums_workflow_chemical_reagent_relation`;
CREATE TABLE `t_ums_workflow_chemical_reagent_relation` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `out_lot_num` varchar(20) DEFAULT NULL COMMENT '组装站位的OUTPUT LOT#'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学试剂与组装关系表';

#
# Data for table "t_ums_workflow_chemical_reagent_relation"
#

INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES (3,'666666'),(3,'4444444'),(6,'666666'),(6,'4444444'),(6,'3333333'),(7,'666666'),(7,'3333333'),(8,'K170302XX'),(9,'K170302XX');

#
# Structure for table "t_ums_workflow_clean"
#

DROP TABLE IF EXISTS `t_ums_workflow_clean`;
CREATE TABLE `t_ums_workflow_clean` (
  `clean_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `clean_time` date DEFAULT NULL COMMENT '清洗日期',
  `fixture_number` varchar(50) DEFAULT '' COMMENT '光纤的料号及批次号',
  `input_lot_num` varchar(20) DEFAULT '' COMMENT 'polish 完成后产生的LOT#',
  `input_qty` int(10) DEFAULT NULL COMMENT 'input QTY',
  `clean_bom` varchar(255) DEFAULT '' COMMENT 'clean bom',
  `clean_lot_num` varchar(20) DEFAULT NULL COMMENT 'Clean LOT#',
  `scrap_qty` int(10) DEFAULT '0' COMMENT '碎片数量',
  `output_qty` int(10) DEFAULT '0' COMMENT '输出数量',
  `yield` double(5,2) DEFAULT NULL COMMENT '合格率',
  `to_other_qty` int(10) DEFAULT '0' COMMENT 'to other qty',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`clean_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='清洗表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201711 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
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
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB) */;

#
# Data for table "t_ums_workflow_clean"
#

INSERT INTO `t_ums_workflow_clean` VALUES (8,'2017-03-01','','',NULL,'','DX1702021',NULL,1534,99.80,1534,'09-0071','102379092',9,'2017-11-11 11:26:04','2017-11-22 00:03:52'),(9,'2017-03-16','','',NULL,'','CX170214',NULL,1534,99.54,1534,'09-0071','102379092',9,'2017-11-22 00:03:03','2017-11-22 13:08:35'),(10,'2018-04-10','8877','胜多负少',5,'C3','师傅',4,23,69.57,0,'13-0003','水电费',9,'2018-04-10 10:21:50','2018-04-10 10:21:50'),(12,'2018-04-10','8877','胜多负少',5,'C3','师傅',4,23,69.57,0,'13-0003','水电费',9,'2018-04-10 10:21:53','2018-04-10 10:21:53'),(13,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-10 10:21:53','2018-04-11 14:54:09'),(14,'2018-04-18','hhh','jjkhh',675,'C3','csdfs',11,664,98.34,0,'13-0003','sdfs',9,'2018-04-11 14:03:24','2018-04-11 14:03:24'),(15,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:33','2018-04-11 14:57:33'),(16,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:34','2018-04-11 14:57:34'),(17,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:35','2018-04-11 14:57:35'),(18,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:35','2018-04-11 14:57:35'),(19,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:36','2018-04-11 14:57:36'),(20,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:36','2018-04-11 14:57:36'),(21,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:36','2018-04-11 14:57:36'),(22,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:36','2018-04-11 14:57:36'),(23,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:37','2018-04-11 14:57:37'),(24,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:37','2018-04-11 14:57:37'),(25,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:37','2018-04-11 14:57:37'),(26,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:38','2018-04-11 14:57:38'),(27,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:38','2018-04-11 14:57:38'),(28,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:38','2018-04-11 14:57:38'),(29,'2018-04-10','hhh','jjkhh',675,'C3','师傅',11,630,98.25,34,'13-0003','水电费',9,'2018-04-11 14:57:40','2018-04-11 14:57:40');

#
# Structure for table "t_ums_workflow_compound_reagents"
#

DROP TABLE IF EXISTS `t_ums_workflow_compound_reagents`;
CREATE TABLE `t_ums_workflow_compound_reagents` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `compound_reagents_name` varchar(100) DEFAULT NULL COMMENT '混合试剂名称',
  `compound_reagents_sn` varchar(100) DEFAULT NULL COMMENT '混合试剂编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学混合试剂表';

#
# Data for table "t_ums_workflow_compound_reagents"
#

INSERT INTO `t_ums_workflow_compound_reagents` VALUES (6,'chemicalreagenttable207146','dfdfg'),(6,'chemicalreagenttable207144','dfgdg'),(7,'chemicalreagenttable207146','sdfsd'),(7,'chemicalreagenttable207142','sdfsdf'),(8,'chemicalreagenttable207146','CM16052701'),(9,'chemicalreagenttable207146','454');

#
# Structure for table "t_ums_workflow_defect"
#

DROP TABLE IF EXISTS `t_ums_workflow_defect`;
CREATE TABLE `t_ums_workflow_defect` (
  `defect_id` int(11) DEFAULT NULL COMMENT '缺损关联id(如 defect_type为1 则defectid代表polish表唯一标示)',
  `defect_type` int(4) DEFAULT NULL COMMENT '缺损类型 1:polish 2:clean',
  `dataid` int(11) DEFAULT NULL COMMENT '数据字典表唯一标示',
  `defect_value` int(6) DEFAULT NULL COMMENT '缺损值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='缺损记录表';

#
# Data for table "t_ums_workflow_defect"
#

INSERT INTO `t_ums_workflow_defect` VALUES (22,11,9,34),(22,11,5,3),(22,12,56,3),(22,12,52,3),(22,11,9,34),(22,11,5,3),(22,12,56,3),(22,12,52,3),(21,11,9,34),(21,11,5,3),(21,12,56,3),(21,12,52,3),(21,11,9,34),(21,11,5,3),(21,12,56,37),(21,12,52,3),(22,11,9,34),(22,11,5,3),(22,12,56,3),(22,12,52,3),(21,11,9,34),(21,11,5,3),(21,12,56,37),(21,12,52,3),(22,11,9,8),(22,11,5,3),(22,12,56,3),(22,12,52,3),(21,11,9,34),(21,11,5,3),(21,12,56,37),(21,12,52,3),(22,11,9,8),(22,11,5,3),(22,12,56,3),(22,12,52,3),(23,11,9,3),(23,12,56,3),(22,11,9,8),(22,11,5,3),(22,12,56,3),(22,12,52,3),(24,11,9,2),(24,11,11,3),(24,12,56,3),(25,11,9,32),(25,11,47,3),(25,12,56,3),(21,11,9,34),(21,11,5,3),(21,12,56,37),(21,12,52,3),(25,11,9,32),(25,11,47,3),(25,12,56,3),(21,11,9,34),(21,11,5,3),(21,12,56,37),(21,12,52,3),(24,11,9,2),(24,11,11,3),(24,12,56,3),(23,11,9,3),(23,12,56,3),(23,11,9,3),(23,12,56,3),(26,11,9,4),(26,11,1,1),(28,11,1,2),(26,11,9,4),(26,11,1,1),(28,11,1,2),(25,51,124,3),(25,52,112,3),(25,51,124,3),(25,52,112,3),(8,21,67,2),(8,22,57,1),(5,31,88,2),(5,32,44,3),(25,51,124,3),(25,52,112,3),(29,11,9,2),(9,21,76,3),(9,22,66,4),(33,11,9,3),(29,11,9,3),(29,11,9,3),(27,51,124,4),(32,171,213,8),(33,171,213,8),(34,171,213,8),(35,171,213,8),(36,171,213,8),(37,171,213,8),(38,171,213,8),(39,171,213,9),(39,171,216,5),(39,172,224,4),(39,172,227,5),(46,171,213,9),(46,171,216,5),(46,172,224,4),(46,172,227,5),(47,171,213,9),(47,171,216,5),(47,172,224,4),(47,172,227,5),(48,171,213,9),(48,171,216,5),(48,172,224,4),(48,172,227,5),(49,171,213,9),(49,171,216,5),(49,172,224,4),(49,172,227,5),(50,171,213,9),(50,171,216,5),(50,172,224,4),(50,172,227,5),(51,171,213,9),(51,171,216,5),(51,172,224,4),(51,172,227,5),(52,171,213,9),(52,171,216,5),(52,172,224,4),(52,172,227,5),(53,171,213,9),(53,171,216,5),(53,172,224,4),(53,172,227,5),(54,171,213,9),(54,171,216,5),(54,172,224,4),(54,172,227,5),(55,171,213,9),(55,171,216,5),(55,172,224,4),(55,172,227,5),(56,171,213,9),(56,171,216,5),(56,172,224,4),(56,172,227,5),(57,171,213,9),(57,171,216,5),(57,172,224,4),(57,172,227,5),(58,171,213,9),(58,171,216,5),(58,172,224,4),(58,172,227,5),(59,171,213,9),(59,171,216,5),(59,172,224,4),(59,172,227,5),(60,171,213,9),(60,171,216,5),(60,172,224,4),(60,172,227,5),(61,171,213,9),(61,171,216,5),(61,172,224,4),(61,172,227,5),(62,171,213,9),(62,171,216,5),(62,172,224,4),(62,172,227,5),(63,171,213,9),(63,171,216,5),(63,172,224,4),(63,172,227,5),(64,171,213,9),(64,171,216,5),(64,172,224,4),(64,172,227,5),(65,171,213,9),(65,171,216,5),(65,172,224,4),(65,172,227,5),(66,171,213,9),(66,171,216,5),(66,172,224,4),(66,172,227,5),(67,171,213,9),(67,171,216,5),(67,172,224,4),(67,172,227,5),(68,171,213,9),(68,171,216,5),(68,172,224,4),(68,172,227,5),(69,171,213,9),(69,171,216,5),(69,172,224,4),(69,172,227,5),(70,171,213,9),(70,171,216,5),(70,172,224,4),(70,172,227,5),(71,171,213,9),(71,171,216,5),(71,172,224,4),(71,172,227,5),(72,171,213,9),(72,171,216,5),(72,172,224,4),(72,172,227,5),(73,171,213,9),(73,171,216,5),(73,172,224,4),(73,172,227,5),(74,171,213,9),(74,171,216,5),(74,172,224,4),(74,172,227,5),(75,171,213,9),(75,171,216,5),(75,172,224,4),(75,172,227,5),(76,171,213,9),(76,171,216,5),(76,172,224,4),(76,172,227,5),(77,171,213,9),(77,171,216,5),(77,172,224,4),(77,172,227,5),(78,171,213,9),(78,171,216,5),(78,172,224,4),(78,172,227,5),(79,171,213,9),(79,171,216,5),(79,172,224,4),(79,172,227,5),(80,171,213,9),(80,171,216,5),(80,172,224,4),(80,172,227,5),(81,171,213,9),(81,171,216,5),(81,172,224,4),(81,172,227,5),(82,171,213,9),(82,171,216,5),(82,172,224,4),(82,172,227,5),(83,171,213,9),(83,171,216,5),(83,172,224,4),(83,172,227,5),(84,171,213,9),(84,171,216,5),(84,172,224,4),(84,172,227,5),(85,171,213,9),(85,171,216,5),(85,172,224,4),(85,172,227,5),(86,171,213,9),(86,171,216,5),(86,172,224,4),(86,172,227,5),(87,171,213,9),(87,171,216,5),(87,172,224,4),(87,172,227,5),(88,171,213,9),(88,171,216,5),(88,172,224,4),(88,172,227,5),(89,171,213,9),(89,171,216,5),(89,172,224,4),(89,172,227,5),(90,171,213,9),(90,171,216,5),(90,172,224,4),(90,172,227,5),(91,171,213,9),(91,171,216,5),(91,172,224,4),(91,172,227,5),(92,171,213,9),(92,171,216,5),(92,172,224,4),(92,172,227,5),(93,171,213,9),(93,171,216,5),(93,172,224,4),(93,172,227,5),(94,171,213,9),(94,171,216,5),(94,172,224,4),(94,172,227,5),(95,171,213,9),(95,171,216,5),(95,172,224,4),(95,172,227,5),(96,171,213,9),(96,171,216,5),(96,172,224,4),(96,172,227,5),(97,171,213,9),(97,171,216,5),(97,172,224,4),(97,172,227,5),(98,171,213,9),(98,171,216,5),(98,172,224,4),(98,172,227,5),(99,171,213,9),(99,171,216,5),(99,172,224,4),(99,172,227,5),(100,171,213,9),(100,171,216,5),(100,172,224,4),(100,172,227,5),(101,171,213,9),(101,171,216,5),(101,172,224,4),(101,172,227,5),(102,171,213,9),(102,171,216,5),(102,172,224,4),(102,172,227,5),(103,171,213,9),(103,171,216,5),(103,172,224,4),(103,172,227,5),(104,171,213,9),(104,171,216,5),(104,172,224,4),(104,172,227,5),(105,171,213,9),(105,171,216,5),(105,172,224,4),(105,172,227,5),(106,171,213,9),(106,171,216,5),(106,172,224,4),(106,172,227,5),(107,171,213,9),(107,171,216,5),(107,172,224,4),(107,172,227,5),(108,171,213,9),(108,171,216,5),(108,172,224,4),(108,172,227,5),(109,171,213,9),(109,171,216,5),(109,172,224,4),(109,172,227,5),(110,171,213,9),(110,171,216,5),(110,172,224,4),(110,172,227,5),(111,171,213,9),(111,171,216,5),(111,172,224,4),(111,172,227,5),(112,171,213,9),(112,171,216,5),(112,172,224,4),(112,172,227,5),(113,171,213,9),(113,171,216,5),(113,172,224,4),(113,172,227,5),(114,171,213,9),(114,171,216,5),(114,172,224,4),(114,172,227,5),(115,171,213,9),(115,171,216,5),(115,172,224,4),(115,172,227,5),(116,171,213,9),(116,171,216,5),(116,172,224,4),(116,172,227,5),(117,171,213,9),(117,171,216,5),(117,172,224,4),(117,172,227,5),(118,171,213,9),(118,171,216,5),(118,172,224,4),(118,172,227,5),(119,171,213,9),(119,171,216,5),(119,172,224,4),(119,172,227,5),(120,171,213,9),(120,171,216,5),(120,172,224,4),(120,172,227,5),(121,171,213,9),(121,171,216,5),(121,172,224,4),(121,172,227,5),(122,171,213,9),(122,171,216,5),(122,172,224,4),(122,172,227,5),(123,171,213,9),(123,171,216,5),(123,172,224,4),(123,172,227,5),(124,171,213,9),(124,171,216,5),(124,172,224,4),(124,172,227,5),(125,171,213,9),(125,171,216,5),(125,172,224,4),(125,172,227,5),(126,171,213,9),(126,171,216,5),(126,172,224,4),(126,172,227,5),(127,171,213,9),(127,171,216,5),(127,172,224,4),(127,172,227,5),(128,171,213,9),(128,171,216,5),(128,172,224,4),(128,172,227,5),(129,171,213,9),(129,171,216,5),(129,172,224,4),(129,172,227,5),(130,171,213,9),(130,171,216,5),(130,172,224,4),(130,172,227,5),(131,171,213,9),(131,171,216,5),(131,172,224,4),(131,172,227,5),(132,171,213,9),(132,171,216,5),(132,172,224,4),(132,172,227,5),(133,171,213,9),(133,171,216,5),(133,172,224,4),(133,172,227,5),(134,171,213,9),(134,171,216,5),(134,172,224,4),(134,172,227,5),(135,171,213,9),(135,171,216,5),(135,172,224,4),(135,172,227,5),(136,171,213,9),(136,171,216,5),(136,172,224,4),(136,172,227,5),(137,171,213,9),(137,171,216,5),(137,172,224,4),(137,172,227,5),(138,171,213,9),(138,171,216,5),(138,172,224,4),(138,172,227,5),(10,181,232,3),(10,182,242,4),(12,181,232,3),(12,182,242,4),(139,171,213,9),(139,171,216,5),(139,172,224,4),(139,172,227,5),(139,171,213,9),(139,171,216,5),(139,172,224,4),(139,172,227,5),(14,181,232,3),(14,181,234,5),(14,182,242,3),(13,181,232,3),(13,181,234,4),(13,182,242,4),(15,181,232,3),(15,181,234,4),(15,182,242,4),(16,181,232,3),(16,181,234,4),(16,182,242,4),(17,181,232,3),(17,181,234,4),(17,182,242,4),(18,181,232,3),(18,181,234,4),(18,182,242,4),(19,181,232,3),(19,181,234,4),(19,182,242,4),(20,181,232,3),(20,181,234,4),(20,182,242,4),(21,181,232,3),(21,181,234,4),(21,182,242,4),(22,181,232,3),(22,181,234,4),(22,182,242,4),(23,181,232,3),(23,181,234,4),(23,182,242,4),(24,181,232,3),(24,181,234,4),(24,182,242,4),(25,181,232,3),(25,181,234,4),(25,182,242,4),(26,181,232,3),(26,181,234,4),(26,182,242,4),(27,181,232,3),(27,181,234,4),(27,182,242,4),(28,181,232,3),(28,181,234,4),(28,182,242,4),(29,181,232,3),(29,181,234,4),(29,182,242,4);

#
# Structure for table "t_ums_workflow_opticalfilming"
#

DROP TABLE IF EXISTS `t_ums_workflow_opticalfilming`;
CREATE TABLE `t_ums_workflow_opticalfilming` (
  `opf_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `opt_time` date DEFAULT NULL COMMENT '镀膜日期',
  `input_lot_num` varchar(20) DEFAULT NULL COMMENT 'input LOT#',
  `input_qty` int(10) DEFAULT '0' COMMENT 'input Qty(pcs)',
  `fixture_num` varchar(50) NOT NULL COMMENT '光纤的料号及批次号,Fixture#',
  `output_lot_num` varchar(20) DEFAULT NULL COMMENT 'Output LOT#',
  `output_qty` int(10) DEFAULT '0' COMMENT 'output Qty(pcs)',
  `scrap_qty` int(10) DEFAULT '0' COMMENT 'Scrap Qty(pcs)',
  `qc_use_qty` int(10) DEFAULT '0' COMMENT 'QC Use Qty(pcs)',
  `to_aps_qty` int(10) DEFAULT '0' COMMENT 'To APS coating Qty(pcs)',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`opf_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='光学镀膜表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201711 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
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
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB) */;

#
# Data for table "t_ums_workflow_opticalfilming"
#

INSERT INTO `t_ums_workflow_opticalfilming` VALUES (5,'2017-02-10','CX170106',1534,'Q1981','O1701191XH',1534,NULL,36,1498,'12-0003','102367592',9,'2017-11-22 00:06:42','2017-11-22 00:06:42');

#
# Structure for table "t_ums_workflow_platedfilm"
#

DROP TABLE IF EXISTS `t_ums_workflow_platedfilm`;
CREATE TABLE `t_ums_workflow_platedfilm` (
  `pf_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `coating_time` date DEFAULT NULL COMMENT '涂层日期',
  `pf_time` date DEFAULT NULL COMMENT '镀膜日期',
  `input_lot_num` varchar(20) DEFAULT NULL COMMENT 'input LOT#',
  `input_qty` int(10) DEFAULT '0' COMMENT 'input Qty(pcs)',
  `fixture_num` varchar(50) NOT NULL COMMENT '光纤的料号及批次号,Fixture#',
  `aps_bottle` varchar(50) NOT NULL COMMENT '哪一瓶化学溶剂 APS Bottle',
  `output_lot_num` varchar(20) DEFAULT NULL COMMENT 'Output LOT#',
  `output_qty` int(10) DEFAULT '0' COMMENT 'output Qty(pcs)',
  `scrap_qty` int(10) DEFAULT '0' COMMENT 'Scrap Qty(pcs)',
  `under_iqc_qty` int(10) DEFAULT '0' COMMENT 'Under IQC Qty(pcs)',
  `q_num` varchar(20) DEFAULT NULL COMMENT 'Q-NUM',
  `k_num` varchar(20) DEFAULT NULL COMMENT 'K-NUM',
  `qc_use_qty` int(10) DEFAULT '0' COMMENT 'QC Use Qty(pcs)',
  `functional_test_qty` int(10) DEFAULT '0' COMMENT 'Functional Test Qty(pcs)',
  `to_hub_qty` int(10) DEFAULT '0' COMMENT 'To HUB Qty(pcs)',
  `remain_qty` int(10) DEFAULT '0' COMMENT 'REMAIN QTY',
  `aps_condition` text COMMENT 'APS condition',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`pf_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='化学镀膜表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201711 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
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
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB) */;

#
# Data for table "t_ums_workflow_platedfilm"
#

INSERT INTO `t_ums_workflow_platedfilm` VALUES (4,'2017-02-17','2017-02-21','O1701191XH',1534,'Q1453','SI170207','A1702154XH',1534,NULL,1526,NULL,NULL,NULL,8,NULL,NULL,'','14-0014','1111111',9,'2017-11-22 00:10:25','2017-11-22 00:10:25'),(5,'2017-11-25','2017-11-25','sdfs',4,'sdfs','sdfsd','sdfds',45,45,43,NULL,NULL,NULL,NULL,NULL,NULL,'','14-0014','sdfs',9,'2017-11-25 14:59:13','2017-11-25 14:59:18');

#
# Structure for table "t_ums_workflow_polish"
#

DROP TABLE IF EXISTS `t_ums_workflow_polish`;
CREATE TABLE `t_ums_workflow_polish` (
  `polish_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `picking_time` date DEFAULT NULL COMMENT '领料日期',
  `polish_time` date DEFAULT NULL COMMENT '抛光时间',
  `input_lot_num` varchar(20) DEFAULT NULL COMMENT '供应商来料LOT#',
  `input_qty` int(10) unsigned zerofill DEFAULT '0000000000' COMMENT '抛光数量',
  `fixture_number` varchar(50) NOT NULL COMMENT '光纤的料号及批次号',
  `throw_millstone_num` varchar(20) NOT NULL COMMENT '抛磨盘序列号',
  `throw_millstone_position` varchar(10) DEFAULT NULL COMMENT '抛磨盘位置',
  `measured_values` varchar(120) DEFAULT '' COMMENT '测量值，多个测量值以逗号分隔',
  `casual_inspection_sum` int(10) DEFAULT NULL COMMENT '抽检总数',
  `yield` double(5,2) DEFAULT NULL COMMENT '合格率',
  `output_qty` varchar(255) DEFAULT '0' COMMENT '输出数量',
  `polish_lot_num` varchar(20) DEFAULT NULL COMMENT 'polish 完成后产生的LOT#',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `polish_bom` varchar(255) DEFAULT NULL,
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`polish_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COMMENT='抛光表'
/*!50100 PARTITION BY RANGE (to_days(input_time))
(PARTITION p201711 VALUES LESS THAN (736999) ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN (737060) ENGINE = InnoDB,
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
 PARTITION p201912 VALUES LESS THAN (737759) ENGINE = InnoDB) */;

#
# Data for table "t_ums_workflow_polish"
#

INSERT INTO `t_ums_workflow_polish` VALUES (26,'2017-02-13','2017-03-01','XC161216',0000001534,'Q1111','10000','C','13,24,55',1534,99.67,'0','XC161216','09-0080','102418121',NULL,9,'2017-11-11 10:40:03','2017-11-11 11:10:47'),(27,'2017-01-31','2017-03-01','XC161216',0000001534,'Q1230','10001','B','13,14,25',1534,100.00,'0','XC161216','09-0080','102418021',NULL,9,'2017-11-11 11:00:54','2017-11-22 10:48:21'),(28,'2017-02-13','2017-03-01','XC161216',0000001534,'Q1047','10003','B','13,14,25',1534,99.87,'0','XC161216','09-0080','102418121',NULL,9,'2017-11-11 11:10:31','2017-11-11 11:11:05'),(30,'2018-04-10','2018-04-11','998887',0000000076,'9998888','','A','',70,100.00,'0','9887','13-0003','8776','fggff',9,'2018-04-07 20:50:20','2018-04-07 20:50:20'),(31,'2018-04-10','2018-04-11','998887',0000000076,'9998888','','A','',70,100.00,'0','9887','13-0003','8776','fggff',9,'2018-04-07 20:53:34','2018-04-07 20:53:34'),(32,'2018-04-11','2018-04-11','9887',0000000076,'8877','','A','',10,20.00,'0','877','13-0003','iuuuyy','fggff',9,'2018-04-07 21:00:46','2018-04-07 21:00:46'),(33,'2018-04-11','2018-04-11','9887',0000000076,'8877','','A','',10,20.00,'0','877','13-0003','iuuuyy','fggff',9,'2018-04-07 21:00:50','2018-04-07 21:00:50'),(34,'2018-04-11','2018-04-11','9887',0000000076,'8877','','A','',10,20.00,'0','877','13-0003','iuuuyy','fggff',9,'2018-04-07 21:00:51','2018-04-07 21:00:51'),(35,'2018-04-11','2018-04-11','9887',0000000076,'8877','','A','',10,20.00,'0','877','13-0003','iuuuyy','fggff',9,'2018-04-07 21:00:52','2018-04-07 21:00:52'),(36,'2018-04-11','2018-04-11','9887',0000000076,'8877','','A','',10,20.00,'0','877','13-0003','iuuuyy','fggff',9,'2018-04-07 21:00:53','2018-04-07 21:00:53'),(37,'2018-04-11','2018-04-11','9887',0000000076,'8877','','A','',10,20.00,'0','877','13-0003','iuuuyy','fggff',9,'2018-04-07 21:00:53','2018-04-07 21:00:53'),(38,'2018-04-11','2018-04-11','9887',0000000076,'8877','','A','',10,20.00,'0','877','13-0003','iuuuyy','fggff',9,'2018-04-07 21:00:54','2018-04-07 21:00:54'),(39,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,100.00,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-07 22:33:47','2018-04-08 22:28:51'),(45,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,100.00,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 22:46:05','2018-04-08 22:46:05'),(46,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 22:57:23','2018-04-08 22:57:23'),(47,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 22:57:25','2018-04-08 22:57:25'),(48,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 22:57:25','2018-04-08 22:57:25'),(49,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:14','2018-04-08 23:01:14'),(50,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:14','2018-04-08 23:01:14'),(51,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:15','2018-04-08 23:01:15'),(52,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:15','2018-04-08 23:01:15'),(53,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:16','2018-04-08 23:01:16'),(54,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:16','2018-04-08 23:01:16'),(55,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:16','2018-04-08 23:01:16'),(56,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:16','2018-04-08 23:01:16'),(57,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:17','2018-04-08 23:01:17'),(58,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:17','2018-04-08 23:01:17'),(59,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:17','2018-04-08 23:01:17'),(60,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:18','2018-04-08 23:01:18'),(61,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:18','2018-04-08 23:01:18'),(62,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:18','2018-04-08 23:01:18'),(63,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:20','2018-04-08 23:01:20'),(64,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:21','2018-04-08 23:01:21'),(65,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:21','2018-04-08 23:01:21'),(66,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:21','2018-04-08 23:01:21'),(67,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:22','2018-04-08 23:01:22'),(68,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:22','2018-04-08 23:01:22'),(69,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:23','2018-04-08 23:01:23'),(70,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:23','2018-04-08 23:01:23'),(71,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:23','2018-04-08 23:01:23'),(72,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:24','2018-04-08 23:01:24'),(73,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:24','2018-04-08 23:01:24'),(74,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:24','2018-04-08 23:01:24'),(75,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:25','2018-04-08 23:01:25'),(76,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:26','2018-04-08 23:01:26'),(77,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:27','2018-04-08 23:01:27'),(78,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:27','2018-04-08 23:01:27'),(79,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:27','2018-04-08 23:01:27'),(80,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:28','2018-04-08 23:01:28'),(81,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:28','2018-04-08 23:01:28'),(82,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:28','2018-04-08 23:01:28'),(83,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:29','2018-04-08 23:01:29'),(84,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:29','2018-04-08 23:01:29'),(85,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:30','2018-04-08 23:01:30'),(86,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:30','2018-04-08 23:01:30'),(87,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:30','2018-04-08 23:01:30'),(88,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:50','2018-04-08 23:01:50'),(89,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:50','2018-04-08 23:01:50'),(90,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:51','2018-04-08 23:01:51'),(91,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:51','2018-04-08 23:01:51'),(92,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:52','2018-04-08 23:01:52'),(93,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:52','2018-04-08 23:01:52'),(94,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:52','2018-04-08 23:01:52'),(95,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:53','2018-04-08 23:01:53'),(96,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:53','2018-04-08 23:01:53'),(97,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:53','2018-04-08 23:01:53'),(98,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:54','2018-04-08 23:01:54'),(99,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:54','2018-04-08 23:01:54'),(100,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:54','2018-04-08 23:01:54'),(101,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:54','2018-04-08 23:01:54'),(102,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:55','2018-04-08 23:01:55'),(103,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:55','2018-04-08 23:01:55'),(104,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:55','2018-04-08 23:01:55'),(105,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:56','2018-04-08 23:01:56'),(106,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:56','2018-04-08 23:01:56'),(107,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:57','2018-04-08 23:01:57'),(108,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:57','2018-04-08 23:01:57'),(109,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:58','2018-04-08 23:01:58'),(110,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:58','2018-04-08 23:01:58'),(111,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:58','2018-04-08 23:01:58'),(112,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:59','2018-04-08 23:01:59'),(113,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:59','2018-04-08 23:01:59'),(114,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:01:59','2018-04-08 23:01:59'),(115,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:00','2018-04-08 23:02:00'),(116,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:00','2018-04-08 23:02:00'),(117,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:00','2018-04-08 23:02:00'),(118,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:01','2018-04-08 23:02:01'),(119,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:01','2018-04-08 23:02:01'),(120,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:01','2018-04-08 23:02:01'),(121,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:02','2018-04-08 23:02:02'),(122,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:02','2018-04-08 23:02:02'),(123,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:03','2018-04-08 23:02:03'),(124,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:03','2018-04-08 23:02:03'),(125,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:04','2018-04-08 23:02:04'),(126,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:04','2018-04-08 23:02:04'),(127,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:05','2018-04-08 23:02:05'),(128,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:05','2018-04-08 23:02:05'),(129,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:05','2018-04-08 23:02:05'),(130,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:06','2018-04-08 23:02:06'),(131,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:06','2018-04-08 23:02:06'),(132,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:07','2018-04-08 23:02:07'),(133,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:07','2018-04-08 23:02:07'),(134,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:07','2018-04-08 23:02:07'),(135,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:07','2018-04-08 23:02:07'),(136,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:08','2018-04-08 23:02:08'),(137,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:08','2018-04-08 23:02:08'),(138,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'0','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-08 23:02:09','2018-04-08 23:02:09'),(139,'2018-04-07','2018-04-02','jjkhh',0000000675,'hhh','','C','',75,69.33,'675','iiuyuy','15-9008','lkjj','ddddsss',9,'2018-04-10 18:41:41','2018-04-11 14:02:33');

#
# Function "queryChildMenuList"
#

DROP FUNCTION IF EXISTS `queryChildMenuList`;
CREATE FUNCTION `queryChildMenuList`(v_pmenuid INT) RETURNS text CHARSET utf8
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
END;

#
# Function "queryChildRoleList"
#

DROP FUNCTION IF EXISTS `queryChildRoleList`;
CREATE FUNCTION `queryChildRoleList`(v_proleid INT) RETURNS text CHARSET utf8
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
END;

#
# View "menubuttonview"
#

DROP VIEW IF EXISTS `menubuttonview`;
CREATE
  ALGORITHM = UNDEFINED
  VIEW `menubuttonview`
  AS
SELECT
  `t_ums_menuinfo`.`MENUID` AS 'menuid', `t_ums_menuinfo`.`MENUNAME` AS 'menuname', 1 AS 'menutype', `t_ums_menuinfo`.`PMENUID` AS 'pmenuid'
FROM
  `t_ums_menuinfo`
UNION ALL
SELECT
  f.`btnid`, f.`btncname`, 2 AS 'menutype', f.`menuid`
FROM
  `t_ums_menu_button` f
WHERE
  EXISTS (SELECT 1 FROM `t_ums_menuinfo` d WHERE (d.`MENUID` = f.`menuid`));

#
# Function "queryChildMenuButtonList"
#

DROP FUNCTION IF EXISTS `queryChildMenuButtonList`;
CREATE FUNCTION `queryChildMenuButtonList`(v_pmenuid INT) RETURNS text CHARSET utf8
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
END;

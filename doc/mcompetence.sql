/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : mcompetence

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-03-06 21:06:01
*/

SET FOREIGN_KEY_CHECKS=0;

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
  PRIMARY KEY (`OPERATORID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of t_ums_admininfo
-- ----------------------------
INSERT INTO `t_ums_admininfo` VALUES ('9', '超级管理员', 'admin', 'admin', '男', '', null, '13816763234', '13434@1632', null, null, '1', '2', '1', '2017-07-08 00:55:55', '2018-01-07 09:29:00');
INSERT INTO `t_ums_admininfo` VALUES ('13', 'test', 'test', '', '女', '', null, '13816763233', '13816763233@163.com', '', '', '2', '2', '1', '2017-11-21 23:14:53', '2017-12-13 21:43:32');

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
INSERT INTO `t_ums_config` VALUES ('1', 'workflow/polish/tablename', '1', 'polishtable201', null, '2', 'configvalue为t_ums_th_config中的tablename与menuid');
INSERT INTO `t_ums_config` VALUES ('2', 'paging/pagesize', '1', '10', null, '2', '系统默认分页大小');
INSERT INTO `t_ums_config` VALUES ('3', 'excel/export/records/limits', '1', '100000', null, '2', 'excel结果集导出最大限制数');
INSERT INTO `t_ums_config` VALUES ('4', 'dataconfig/type/throwMillstonePosition', '1', '91', null, '2', '抛光盘位置在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('5', 'dataconfig/type/partNum', '1', '90', null, '2', '零件号在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('6', 'dataconfig/type/polishdefect', '1', '1', null, '2', '抛光表中的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('7', 'dataconfig/type/cleandefect', '1', '2', null, '2', '清洗表中的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('8', 'workflow/clean/tablename', '1', 'cleantable202', null, '2', 'configvalue为t_ums_th_config中的tablename与menuid');
INSERT INTO `t_ums_config` VALUES ('9', 'polish/download/subdirectory', '1', 'polish', null, '2', '抛光管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('10', 'clean/download/subdirectory', '1', 'clean', null, '2', '清洗管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('11', 'dataconfig/type/cleandefect/workingface', '1', '21', null, '2', '清洗表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('12', 'dataconfig/type/cleandefect/noworkingface', '1', '22', null, '2', '清洗表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('13', 'dataconfig/type/opticalFilmingDefect/workingface', '1', '31', null, '2', '光学镀膜表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('14', 'dataconfig/type/opticalFilmingDefect/noworkingface', '1', '32', null, '2', '光学镀膜表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('15', 'workflow/opticalFilming/tablename', '1', 'opticalfilmingtable203', null, '2', '光学镀膜流程配置表名');
INSERT INTO `t_ums_config` VALUES ('16', 'opticalFilming/download/subdirectory', '1', 'opticalFilming', null, '2', '光学镀膜管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('17', 'dataconfig/type/opticalFilmingDefect', '1', '3', null, '2', '数据配置表代表光学镀膜 defect的配置类型');
INSERT INTO `t_ums_config` VALUES ('18', 'workflow/PlatedFilm/tablename', '1', 'platedfilmtable204', null, '2', '化学镀膜流程配置表名');
INSERT INTO `t_ums_config` VALUES ('19', 'platedFilm/download/subdirectory', '1', 'platedFilm', null, '2', '化学镀膜管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('20', 'dataconfig/type/polishdefect/workingface', '1', '11', null, '2', '抛光表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('21', 'dataconfig/type/polishdefect/noworkingface', '1', '12', null, '2', '抛光表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('22', 'dataconfig/type/scrapinfo', '1', '92', null, '2', '数据配置表代表scrap info的配置类型');
INSERT INTO `t_ums_config` VALUES ('23', 'dataconfig/type/assemblyDefect', '1', '5', null, '2', '数据配置表代表组装 defect的配置类型');
INSERT INTO `t_ums_config` VALUES ('24', 'workflow/assembly/tablename', '1', 'assemblytable206', null, '2', '组装流程配置表名');
INSERT INTO `t_ums_config` VALUES ('25', 'dataconfig/type/assemblyDefect/workingface', '1', '51', null, '2', '组装表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('26', 'dataconfig/type/assemblyDefect/noworkingface', '1', '52', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('27', 'assembly/download/subdirectory', '1', 'assembly', null, '2', '组装管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('28', 'dataconfig/type/remark', '1', '93', null, '2', '数据配置表代表remark的配置类型');
INSERT INTO `t_ums_config` VALUES ('29', 'dataconfig/type/chemicalReagent', '1', '94', null, '2', '数据配置表代表化学试剂配置类型');
INSERT INTO `t_ums_config` VALUES ('30', 'workflow/chemicalReagent/tablename', '1', 'chemicalreagenttable207', null, '2', '化学试剂流程配置表名');
INSERT INTO `t_ums_config` VALUES ('31', 'chemicalReagent/download/subdirectory', '1', 'chemicalReagent', null, '2', '化学试剂管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('32', 'default/root/menuid', '1', '-1', null, '2', '默认根节点菜单id');
INSERT INTO `t_ums_config` VALUES ('33', 'default/root/roleid', '1', '-1', null, '2', '分页默认角色根节点id');

-- ----------------------------
-- Table structure for t_ums_customers_consuming
-- ----------------------------
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

-- ----------------------------
-- Records of t_ums_customers_consuming
-- ----------------------------

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
INSERT INTO `t_ums_data_button` VALUES ('1', '105', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('2', '105', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('4', '105', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('5', '105', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('6', '105', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('7', '105', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('8', '106', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('9', '106', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('10', '106', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('11', '106', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('12', '106', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('13', '106', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('14', '201', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('15', '201', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('16', '201', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('17', '201', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('18', '201', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '4', null);
INSERT INTO `t_ums_data_button` VALUES ('19', '201', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('20', '201', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('21', '201', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('22', '202', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('23', '202', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('24', '202', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('25', '202', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('26', '202', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '4', null);
INSERT INTO `t_ums_data_button` VALUES ('27', '202', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('28', '202', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('29', '202', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('30', '203', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('31', '203', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('32', '203', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('33', '203', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('34', '203', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '4', null);
INSERT INTO `t_ums_data_button` VALUES ('35', '203', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('36', '203', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('37', '203', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('38', '204', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('39', '204', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('40', '204', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('41', '204', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('42', '204', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '4', null);
INSERT INTO `t_ums_data_button` VALUES ('43', '204', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('44', '204', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('45', '204', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('46', '205', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('47', '205', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('48', '205', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('49', '205', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('50', '205', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '4', null);
INSERT INTO `t_ums_data_button` VALUES ('51', '205', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('52', '205', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('53', '205', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('54', '206', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', '1', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('55', '206', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('56', '206', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('57', '206', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('58', '206', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '4', null);
INSERT INTO `t_ums_data_button` VALUES ('59', '206', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('60', '206', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('61', '206', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '3', null);

-- ----------------------------
-- Table structure for t_ums_data_config
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_data_config`;
CREATE TABLE `t_ums_data_config` (
  `DATAID` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据id',
  `DATATYPE` int(3) NOT NULL COMMENT '数据类型',
  `configname` varchar(20) DEFAULT NULL COMMENT '标题',
  `DESCRIPTION` text COMMENT '描述信息',
  `operatorid` int(11) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`DATAID`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8 COMMENT='数据字典配置表';

-- ----------------------------
-- Records of t_ums_data_config
-- ----------------------------
INSERT INTO `t_ums_data_config` VALUES ('1', '11', '崩边', 'Polishing', '9', null, '2017-08-30 10:08:32');
INSERT INTO `t_ums_data_config` VALUES ('2', '11', '划痕', 'Polishing', '9', null, '2017-08-30 10:08:57');
INSERT INTO `t_ums_data_config` VALUES ('3', '11', '异物', 'Polishing', '9', null, '2017-08-30 10:09:07');
INSERT INTO `t_ums_data_config` VALUES ('5', '11', '印迹', 'Polishing', '9', null, '2017-08-30 10:14:48');
INSERT INTO `t_ums_data_config` VALUES ('9', '11', '其它', 'Polishing', '9', null, '2017-08-30 10:15:15');
INSERT INTO `t_ums_data_config` VALUES ('10', '11', '麻点', 'Polishing', '9', null, '2017-08-30 10:14:10');
INSERT INTO `t_ums_data_config` VALUES ('11', '11', '水印', 'Polishing', '9', null, '2017-08-30 10:14:32');
INSERT INTO `t_ums_data_config` VALUES ('12', '11', '缝隙', 'Polishing', '9', null, '2017-08-30 10:15:11');
INSERT INTO `t_ums_data_config` VALUES ('26', '90', '09-0080', '', '9', '2017-08-20 16:38:45', '2017-08-20 16:38:45');
INSERT INTO `t_ums_data_config` VALUES ('27', '90', '09-0071', '', '9', '2017-08-20 16:39:31', '2017-08-20 16:39:31');
INSERT INTO `t_ums_data_config` VALUES ('29', '90', '12-0003', '', '9', '2017-08-20 16:40:15', '2017-08-20 16:40:15');
INSERT INTO `t_ums_data_config` VALUES ('30', '90', '13-0003', '', '9', '2017-08-20 16:40:40', '2017-08-20 16:40:40');
INSERT INTO `t_ums_data_config` VALUES ('31', '90', '15-9008', '', '9', '2017-08-20 16:41:00', '2017-08-20 16:41:00');
INSERT INTO `t_ums_data_config` VALUES ('32', '90', '14-0014', '', '9', '2017-08-20 16:41:19', '2017-08-20 16:41:19');
INSERT INTO `t_ums_data_config` VALUES ('33', '91', 'A', '', '9', '2017-08-20 16:41:48', '2017-08-20 16:41:48');
INSERT INTO `t_ums_data_config` VALUES ('34', '91', 'B', '', '9', '2017-08-20 16:41:54', '2017-08-20 16:41:54');
INSERT INTO `t_ums_data_config` VALUES ('35', '91', 'C', '', '9', '2017-08-20 16:42:00', '2017-08-20 16:42:00');
INSERT INTO `t_ums_data_config` VALUES ('37', '31', '崩边', '', '9', '2017-08-27 18:05:02', '2017-08-27 18:05:02');
INSERT INTO `t_ums_data_config` VALUES ('38', '31', '划痕', '', '9', '2017-08-27 18:05:16', '2017-08-27 18:05:16');
INSERT INTO `t_ums_data_config` VALUES ('42', '32', '崩边', '', '9', '2017-08-27 18:06:36', '2017-08-27 18:06:36');
INSERT INTO `t_ums_data_config` VALUES ('43', '32', '划痕', '', '9', '2017-08-27 18:06:44', '2017-08-27 18:06:44');
INSERT INTO `t_ums_data_config` VALUES ('44', '32', '异物', '', '9', '2017-08-27 18:06:52', '2017-08-27 18:06:52');
INSERT INTO `t_ums_data_config` VALUES ('47', '11', '胶', 'polishing', '9', '2017-08-30 10:10:06', '2017-08-30 10:14:59');
INSERT INTO `t_ums_data_config` VALUES ('48', '12', '崩边', '', '9', '2017-11-05 13:47:20', '2017-11-05 13:47:20');
INSERT INTO `t_ums_data_config` VALUES ('49', '12', '划痕', '', '9', '2017-11-05 13:47:38', '2017-11-05 13:47:38');
INSERT INTO `t_ums_data_config` VALUES ('50', '12', '异物', '', '9', '2017-11-05 13:47:56', '2017-11-05 13:47:56');
INSERT INTO `t_ums_data_config` VALUES ('51', '12', '印迹', '', '9', '2017-11-05 13:48:24', '2017-11-05 13:48:24');
INSERT INTO `t_ums_data_config` VALUES ('52', '12', '其它', '', '9', '2017-11-05 13:48:46', '2017-11-05 13:48:46');
INSERT INTO `t_ums_data_config` VALUES ('53', '12', '麻点', '', '9', '2017-11-05 13:49:03', '2017-11-05 13:49:03');
INSERT INTO `t_ums_data_config` VALUES ('54', '12', '水印', '', '9', '2017-11-05 13:49:20', '2017-11-05 13:49:20');
INSERT INTO `t_ums_data_config` VALUES ('55', '12', '缝隙', '', '9', '2017-11-05 13:49:38', '2017-11-05 13:49:38');
INSERT INTO `t_ums_data_config` VALUES ('56', '12', '胶', '', '9', '2017-11-05 13:49:51', '2017-11-05 13:49:51');
INSERT INTO `t_ums_data_config` VALUES ('57', '22', '崩边', '', '9', '2017-11-08 22:04:25', '2017-11-08 22:04:25');
INSERT INTO `t_ums_data_config` VALUES ('58', '22', '划痕', '', '9', '2017-11-08 22:04:43', '2017-11-08 22:04:43');
INSERT INTO `t_ums_data_config` VALUES ('59', '22', '异物', '', '9', '2017-11-08 22:04:50', '2017-11-08 22:04:50');
INSERT INTO `t_ums_data_config` VALUES ('60', '22', '棉纱', '', '9', '2017-11-08 22:06:22', '2017-11-08 22:06:22');
INSERT INTO `t_ums_data_config` VALUES ('61', '22', '麻点', '', '9', '2017-11-08 22:06:42', '2017-11-08 22:06:42');
INSERT INTO `t_ums_data_config` VALUES ('62', '22', '水印', '', '9', '2017-11-08 22:06:50', '2017-11-08 22:06:50');
INSERT INTO `t_ums_data_config` VALUES ('63', '22', '印痕', '', '9', '2017-11-08 22:07:10', '2017-11-08 22:07:10');
INSERT INTO `t_ums_data_config` VALUES ('64', '22', '胶', '', '9', '2017-11-08 22:07:17', '2017-11-08 22:07:17');
INSERT INTO `t_ums_data_config` VALUES ('65', '22', '缝隙', '', '9', '2017-11-08 22:07:34', '2017-11-08 22:07:34');
INSERT INTO `t_ums_data_config` VALUES ('66', '22', '其它', '', '9', '2017-11-08 22:07:44', '2017-11-08 22:07:44');
INSERT INTO `t_ums_data_config` VALUES ('67', '21', '崩边', '', '9', '2017-11-08 22:08:10', '2017-11-08 22:08:10');
INSERT INTO `t_ums_data_config` VALUES ('68', '21', '划痕', '', '9', '2017-11-08 22:08:19', '2017-11-08 22:08:19');
INSERT INTO `t_ums_data_config` VALUES ('69', '21', '异物', '', '9', '2017-11-08 22:08:34', '2017-11-08 22:08:34');
INSERT INTO `t_ums_data_config` VALUES ('70', '21', '棉纱', '', '9', '2017-11-08 22:08:56', '2017-11-08 22:08:56');
INSERT INTO `t_ums_data_config` VALUES ('71', '21', '麻点', '', '9', '2017-11-08 22:09:04', '2017-11-08 22:09:04');
INSERT INTO `t_ums_data_config` VALUES ('72', '21', '水印', '', '9', '2017-11-08 22:09:11', '2017-11-08 22:09:11');
INSERT INTO `t_ums_data_config` VALUES ('73', '21', '印迹', '', '9', '2017-11-08 22:09:35', '2017-11-08 22:09:35');
INSERT INTO `t_ums_data_config` VALUES ('74', '21', '胶', '', '9', '2017-11-08 22:09:43', '2017-11-08 22:09:43');
INSERT INTO `t_ums_data_config` VALUES ('75', '21', '缝隙', '', '9', '2017-11-08 22:09:54', '2017-11-08 22:09:54');
INSERT INTO `t_ums_data_config` VALUES ('76', '21', '其它', '', '9', '2017-11-08 22:10:18', '2017-11-08 22:10:18');
INSERT INTO `t_ums_data_config` VALUES ('77', '32', '胶', '', '9', '2017-11-08 22:18:21', '2017-11-08 22:18:21');
INSERT INTO `t_ums_data_config` VALUES ('78', '32', '印迹', '', '9', '2017-11-08 22:18:30', '2017-11-08 22:18:30');
INSERT INTO `t_ums_data_config` VALUES ('79', '32', '其它', '', '9', '2017-11-08 22:18:44', '2017-11-08 22:18:44');
INSERT INTO `t_ums_data_config` VALUES ('80', '31', '异物', '', '9', '2017-11-08 22:19:16', '2017-11-08 22:19:16');
INSERT INTO `t_ums_data_config` VALUES ('81', '31', '胶', '', '9', '2017-11-08 22:20:06', '2017-11-08 22:20:06');
INSERT INTO `t_ums_data_config` VALUES ('82', '31', '印迹', '', '9', '2017-11-08 22:20:13', '2017-11-08 22:20:13');
INSERT INTO `t_ums_data_config` VALUES ('83', '31', '绿膜', '', '9', '2017-11-08 22:21:13', '2017-11-08 22:21:13');
INSERT INTO `t_ums_data_config` VALUES ('84', '31', '彩虹到芯', '', '9', '2017-11-08 22:21:35', '2017-11-08 22:21:35');
INSERT INTO `t_ums_data_config` VALUES ('85', '31', '膜层脱落', '', '9', '2017-11-08 22:22:09', '2017-11-08 22:22:09');
INSERT INTO `t_ums_data_config` VALUES ('86', '31', '膜下异物', '', '9', '2017-11-08 22:22:32', '2017-11-08 22:22:32');
INSERT INTO `t_ums_data_config` VALUES ('87', '31', '缝隙', '', '9', '2017-11-08 22:22:42', '2017-11-08 22:22:42');
INSERT INTO `t_ums_data_config` VALUES ('88', '31', '其它', '', '9', '2017-11-08 22:22:51', '2017-11-08 22:22:51');
INSERT INTO `t_ums_data_config` VALUES ('89', '92', '崩边', '', '9', '2017-11-08 23:12:38', '2017-11-08 23:12:38');
INSERT INTO `t_ums_data_config` VALUES ('90', '92', '划痕', '', '9', '2017-11-08 23:12:50', '2017-11-08 23:12:50');
INSERT INTO `t_ums_data_config` VALUES ('91', '92', '异物', '', '9', '2017-11-08 23:12:57', '2017-11-08 23:12:57');
INSERT INTO `t_ums_data_config` VALUES ('92', '92', '胶', '', '9', '2017-11-08 23:13:04', '2017-11-08 23:13:04');
INSERT INTO `t_ums_data_config` VALUES ('93', '92', '印迹', '', '9', '2017-11-08 23:13:12', '2017-11-08 23:13:12');
INSERT INTO `t_ums_data_config` VALUES ('94', '92', '高低', '', '9', '2017-11-08 23:13:23', '2017-11-08 23:13:23');
INSERT INTO `t_ums_data_config` VALUES ('95', '92', '装反', '', '9', '2017-11-08 23:13:36', '2017-11-08 23:13:36');
INSERT INTO `t_ums_data_config` VALUES ('96', '92', '破点', '', '9', '2017-11-08 23:13:45', '2017-11-08 23:13:45');
INSERT INTO `t_ums_data_config` VALUES ('97', '92', '其它', '', '9', '2017-11-08 23:13:51', '2017-11-08 23:13:51');
INSERT INTO `t_ums_data_config` VALUES ('98', '92', '绿膜', '', '9', '2017-11-08 23:14:25', '2017-11-08 23:14:25');
INSERT INTO `t_ums_data_config` VALUES ('99', '92', '彩虹到芯', '', '9', '2017-11-08 23:14:38', '2017-11-08 23:14:38');
INSERT INTO `t_ums_data_config` VALUES ('100', '92', '膜层脱落', '', '9', '2017-11-08 23:14:54', '2017-11-08 23:14:54');
INSERT INTO `t_ums_data_config` VALUES ('101', '92', '膜下异物', '', '9', '2017-11-08 23:15:06', '2017-11-08 23:15:06');
INSERT INTO `t_ums_data_config` VALUES ('102', '92', '缝隙', '', '9', '2017-11-08 23:15:14', '2017-11-08 23:15:14');
INSERT INTO `t_ums_data_config` VALUES ('103', '92', '棉纱', '', '9', '2017-11-08 23:15:31', '2017-11-08 23:15:31');
INSERT INTO `t_ums_data_config` VALUES ('104', '52', '崩边', '', '9', '2017-11-12 15:36:37', '2017-11-12 15:36:37');
INSERT INTO `t_ums_data_config` VALUES ('105', '52', '划痕', '', '9', '2017-11-12 15:36:48', '2017-11-12 15:36:48');
INSERT INTO `t_ums_data_config` VALUES ('106', '52', '异物', '', '9', '2017-11-12 15:37:02', '2017-11-12 15:37:02');
INSERT INTO `t_ums_data_config` VALUES ('107', '52', '胶', '', '9', '2017-11-12 15:37:08', '2017-11-12 15:37:08');
INSERT INTO `t_ums_data_config` VALUES ('108', '52', '印迹', '', '9', '2017-11-12 15:37:20', '2017-11-12 15:37:20');
INSERT INTO `t_ums_data_config` VALUES ('109', '52', '高低', '', '9', '2017-11-12 15:37:25', '2017-11-12 15:37:25');
INSERT INTO `t_ums_data_config` VALUES ('110', '52', '装反', '', '9', '2017-11-12 15:37:37', '2017-11-12 15:37:37');
INSERT INTO `t_ums_data_config` VALUES ('111', '52', '破点', '', '9', '2017-11-12 15:37:45', '2017-11-12 15:37:45');
INSERT INTO `t_ums_data_config` VALUES ('112', '52', '其它', '', '9', '2017-11-12 15:37:58', '2017-11-12 15:37:58');
INSERT INTO `t_ums_data_config` VALUES ('113', '51', '崩边', '', '9', '2017-11-12 15:38:18', '2017-11-12 15:38:18');
INSERT INTO `t_ums_data_config` VALUES ('114', '51', '划痕', '', '9', '2017-11-12 15:38:29', '2017-11-12 15:38:29');
INSERT INTO `t_ums_data_config` VALUES ('115', '51', '异物', '', '9', '2017-11-12 15:38:42', '2017-11-12 15:38:42');
INSERT INTO `t_ums_data_config` VALUES ('116', '51', '异物', '', '9', '2017-11-12 15:38:48', '2017-11-12 15:38:48');
INSERT INTO `t_ums_data_config` VALUES ('117', '51', '胶', '', '9', '2017-11-12 15:38:53', '2017-11-12 15:38:53');
INSERT INTO `t_ums_data_config` VALUES ('118', '51', '印迹', '', '9', '2017-11-12 15:38:58', '2017-11-12 15:38:58');
INSERT INTO `t_ums_data_config` VALUES ('119', '51', '绿膜', '', '9', '2017-11-12 15:39:08', '2017-11-12 15:39:08');
INSERT INTO `t_ums_data_config` VALUES ('120', '51', '彩虹到芯', '', '9', '2017-11-12 15:39:13', '2017-11-12 15:39:13');
INSERT INTO `t_ums_data_config` VALUES ('121', '51', '膜层脱落', '', '9', '2017-11-12 15:39:25', '2017-11-12 15:39:25');
INSERT INTO `t_ums_data_config` VALUES ('122', '51', '膜下异物', '', '9', '2017-11-12 15:39:30', '2017-11-12 15:39:30');
INSERT INTO `t_ums_data_config` VALUES ('123', '51', '缝隙', '', '9', '2017-11-12 15:39:49', '2017-11-12 15:39:49');
INSERT INTO `t_ums_data_config` VALUES ('124', '51', '其它', '', '9', '2017-11-12 15:39:56', '2017-11-12 15:39:56');
INSERT INTO `t_ums_data_config` VALUES ('125', '93', 'T01', '', '9', '2017-11-12 17:27:44', '2017-11-12 17:27:44');
INSERT INTO `t_ums_data_config` VALUES ('126', '93', 'T02', '', '9', '2017-11-12 17:27:50', '2017-11-12 17:27:50');
INSERT INTO `t_ums_data_config` VALUES ('127', '93', 'T03', '', '9', '2017-11-12 17:27:56', '2017-11-12 17:27:56');
INSERT INTO `t_ums_data_config` VALUES ('128', '93', 'T04', '', '9', '2017-11-12 17:28:02', '2017-11-12 17:28:02');
INSERT INTO `t_ums_data_config` VALUES ('129', '93', 'T05', '', '9', '2017-11-12 17:28:08', '2017-11-12 17:28:08');
INSERT INTO `t_ums_data_config` VALUES ('130', '93', 'T06', '', '9', '2017-11-12 17:28:14', '2017-11-12 17:28:14');
INSERT INTO `t_ums_data_config` VALUES ('131', '93', 'T07', '', '9', '2017-11-12 17:28:21', '2017-11-12 17:28:21');
INSERT INTO `t_ums_data_config` VALUES ('132', '93', 'T08', '', '9', '2017-11-12 17:28:26', '2017-11-12 17:28:26');
INSERT INTO `t_ums_data_config` VALUES ('133', '93', 'T09', '', '9', '2017-11-12 17:28:32', '2017-11-12 17:28:32');
INSERT INTO `t_ums_data_config` VALUES ('134', '93', 'T10', '', '9', '2017-11-12 17:28:43', '2017-11-12 17:28:43');
INSERT INTO `t_ums_data_config` VALUES ('135', '93', 'T11', '', '9', '2017-11-12 17:28:48', '2017-11-12 17:28:48');
INSERT INTO `t_ums_data_config` VALUES ('136', '93', 'T12', '', '9', '2017-11-12 17:28:53', '2017-11-12 17:28:53');
INSERT INTO `t_ums_data_config` VALUES ('137', '93', 'T13', '', '9', '2017-11-12 17:28:58', '2017-11-12 17:28:58');
INSERT INTO `t_ums_data_config` VALUES ('138', '93', 'T14', '', '9', '2017-11-12 17:29:05', '2017-11-12 17:29:05');
INSERT INTO `t_ums_data_config` VALUES ('139', '93', 'T15', '', '9', '2017-11-12 17:29:11', '2017-11-12 17:29:11');
INSERT INTO `t_ums_data_config` VALUES ('140', '93', 'T16', '', '9', '2017-11-12 17:29:16', '2017-11-12 17:29:16');
INSERT INTO `t_ums_data_config` VALUES ('141', '93', 'T17', '', '9', '2017-11-12 17:29:22', '2017-11-12 17:29:22');
INSERT INTO `t_ums_data_config` VALUES ('142', '94', '05-0001|04-0001', '', '9', '2017-11-16 21:49:05', '2017-11-16 21:49:05');
INSERT INTO `t_ums_data_config` VALUES ('143', '94', '05-0003|03-0001', '', '9', '2017-11-16 21:49:59', '2017-11-16 21:49:59');
INSERT INTO `t_ums_data_config` VALUES ('144', '94', '05-0002|05-0067', '', '9', '2017-11-16 21:51:05', '2017-11-16 21:51:05');
INSERT INTO `t_ums_data_config` VALUES ('145', '94', '05-0002|04-0002', '', '9', '2017-11-16 21:59:15', '2017-11-16 21:59:15');
INSERT INTO `t_ums_data_config` VALUES ('146', '94', '05-0004|03-0002', '', '9', '2017-11-16 22:00:07', '2017-11-16 22:00:07');
INSERT INTO `t_ums_data_config` VALUES ('152', '94', '334', '', '9', '2017-12-06 14:14:00', '2017-12-06 14:14:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of t_ums_menuinfo
-- ----------------------------
INSERT INTO `t_ums_menuinfo` VALUES ('1', '基础管理', 'menu-icon glyphicon glyphicon-cog', null, '0', '0', '-1', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('2', '工作流管理', 'menu-icon glyphicon glyphicon-globe', '', '0', '0', '-1', '3', '');
INSERT INTO `t_ums_menuinfo` VALUES ('3', '权限管理', '胜多负少', null, '1', '1', '1', '1', '');
INSERT INTO `t_ums_menuinfo` VALUES ('100', '配置管理', 'menu-icon glyphicons\r\n glyphicons-settings', null, '0', '0', '1', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('101', '用户管理', '\r\nmenu-icon glyphicon glyphicon-user', '/user/userManage', '1', '0', '1', '2', null);
INSERT INTO `t_ums_menuinfo` VALUES ('102', '角色管理', 'menu-icon glyphicon glyphicon-asterisk', '/role/roleManage', '1', '0', '1', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('103', '权限配置管理', 'menu-icon glyphicons \r\nglyphicons-user', '/right/rightManage', '1', '0', '1', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('104', '菜单管理', 'menu-icon glyphicon glyphicon-eye-open', '/menu/menuManage', '1', '0', '1', '5', null);
INSERT INTO `t_ums_menuinfo` VALUES ('105', '缺损管理', 'menu-icon glyphicon glyphicon-book', '/defect/defectManage', '1', '0', '1', '6', null);
INSERT INTO `t_ums_menuinfo` VALUES ('106', '数据配置管理', 'menu-icon glyphicon glyphicons-settings', '/dataconfig/dataConfigManage', '1', '0', '1', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('201', '抛磨', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/polishManage', '1', '0', '2', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('202', '清洗', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/cleanManage', '1', '0', '2', '2', null);
INSERT INTO `t_ums_menuinfo` VALUES ('203', '光学镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/opticalFilmingManage', '1', '0', '2', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('204', '化学镀膜APS', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/platedFilmManage', '1', '0', '2', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('205', '组装', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/assemblyManage', '1', '0', '2', '6', null);
INSERT INTO `t_ums_menuinfo` VALUES ('206', '生化镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/chemicalReagentManage', '1', '0', '2', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('207', 'sdfsrrrrrrrrrrrr', 'rrrrrrrrrrrr', 'rrrrrrrrrr', '0', '1', '1', '3', 'rrrrrrrrrrr');
INSERT INTO `t_ums_menuinfo` VALUES ('208', '权限管理', 'menu-icon glyphicon glyphicon-cog', '', '0', '0', '-1', '2', '');
INSERT INTO `t_ums_menuinfo` VALUES ('209', '按钮管理', 'menu-icon glyphicon glyphicon-eye-open', '', '1', '0', '1', '8', '');
INSERT INTO `t_ums_menuinfo` VALUES ('210', 'erte', 'sfs', 'sdfs', '1', '1', '209', '5', '');
INSERT INTO `t_ums_menuinfo` VALUES ('211', '343', 'sfs', 'sdfs', '1', '1', '209', '4', '');
INSERT INTO `t_ums_menuinfo` VALUES ('212', '菜单管理', 'menu-icon glyphicon glyphicon-eye-open', '', '1', '1', '208', '2', '');
INSERT INTO `t_ums_menuinfo` VALUES ('213', '权限配置管理', 'menu-icon glyphicon glyphicon-eye-open', '', '1', '1', '208', '3', '');
INSERT INTO `t_ums_menuinfo` VALUES ('214', '角色管理', 'menu-icon glyphicon glyphicon-eye-open', '', '1', '1', '208', '4', '');

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
  `RIGHTID` int(10) NOT NULL COMMENT '权限编码',
  `RIGHTTYPE` int(2) NOT NULL COMMENT '权限类型  1 菜单权限',
  `DATAID` int(4) NOT NULL COMMENT '数据权限id,如权限类型为菜单，则dataid则为菜单id，依次类推',
  `DESCRIPTION` text COMMENT '浏览按钮权限描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限信息表';

-- ----------------------------
-- Records of t_ums_right
-- ----------------------------
INSERT INTO `t_ums_right` VALUES ('1', '1', '1', '');
INSERT INTO `t_ums_right` VALUES ('2', '1', '101', null);
INSERT INTO `t_ums_right` VALUES ('3', '1', '102', null);
INSERT INTO `t_ums_right` VALUES ('4', '1', '103', null);
INSERT INTO `t_ums_right` VALUES ('5', '1', '2', null);
INSERT INTO `t_ums_right` VALUES ('6', '1', '201', null);
INSERT INTO `t_ums_right` VALUES ('7', '1', '202', null);
INSERT INTO `t_ums_right` VALUES ('8', '1', '203', null);
INSERT INTO `t_ums_right` VALUES ('9', '1', '204', null);
INSERT INTO `t_ums_right` VALUES ('10', '1', '205', null);
INSERT INTO `t_ums_right` VALUES ('11', '1', '206', null);
INSERT INTO `t_ums_right` VALUES ('12', '1', '104', null);
INSERT INTO `t_ums_right` VALUES ('13', '1', '105', null);
INSERT INTO `t_ums_right` VALUES ('14', '1', '106', null);
INSERT INTO `t_ums_right` VALUES ('15', '2', '1', null);
INSERT INTO `t_ums_right` VALUES ('16', '2', '2', null);
INSERT INTO `t_ums_right` VALUES ('17', '2', '3', null);
INSERT INTO `t_ums_right` VALUES ('18', '2', '4', null);
INSERT INTO `t_ums_right` VALUES ('19', '2', '5', null);
INSERT INTO `t_ums_right` VALUES ('20', '2', '6', null);
INSERT INTO `t_ums_right` VALUES ('21', '2', '7', null);
INSERT INTO `t_ums_right` VALUES ('22', '2', '8', null);
INSERT INTO `t_ums_right` VALUES ('23', '2', '9', null);
INSERT INTO `t_ums_right` VALUES ('24', '2', '10', null);
INSERT INTO `t_ums_right` VALUES ('25', '2', '11', null);
INSERT INTO `t_ums_right` VALUES ('26', '2', '12', null);
INSERT INTO `t_ums_right` VALUES ('27', '2', '13', null);
INSERT INTO `t_ums_right` VALUES ('28', '2', '14', null);
INSERT INTO `t_ums_right` VALUES ('29', '2', '15', null);
INSERT INTO `t_ums_right` VALUES ('30', '2', '16', null);
INSERT INTO `t_ums_right` VALUES ('31', '2', '17', null);
INSERT INTO `t_ums_right` VALUES ('32', '2', '18', null);
INSERT INTO `t_ums_right` VALUES ('33', '2', '19', null);
INSERT INTO `t_ums_right` VALUES ('34', '2', '20', null);
INSERT INTO `t_ums_right` VALUES ('35', '2', '21', null);
INSERT INTO `t_ums_right` VALUES ('36', '2', '22', null);
INSERT INTO `t_ums_right` VALUES ('37', '2', '23', null);
INSERT INTO `t_ums_right` VALUES ('38', '2', '24', null);
INSERT INTO `t_ums_right` VALUES ('39', '2', '25', null);
INSERT INTO `t_ums_right` VALUES ('40', '2', '26', null);
INSERT INTO `t_ums_right` VALUES ('41', '2', '27', null);
INSERT INTO `t_ums_right` VALUES ('42', '2', '28', null);
INSERT INTO `t_ums_right` VALUES ('43', '2', '29', null);
INSERT INTO `t_ums_right` VALUES ('44', '2', '30', null);
INSERT INTO `t_ums_right` VALUES ('45', '2', '31', null);
INSERT INTO `t_ums_right` VALUES ('46', '2', '32', null);
INSERT INTO `t_ums_right` VALUES ('47', '2', '33', null);
INSERT INTO `t_ums_right` VALUES ('48', '2', '34', null);
INSERT INTO `t_ums_right` VALUES ('49', '2', '35', null);
INSERT INTO `t_ums_right` VALUES ('50', '2', '36', null);
INSERT INTO `t_ums_right` VALUES ('51', '2', '37', null);
INSERT INTO `t_ums_right` VALUES ('52', '2', '38', null);
INSERT INTO `t_ums_right` VALUES ('53', '2', '39', null);
INSERT INTO `t_ums_right` VALUES ('54', '2', '40', null);
INSERT INTO `t_ums_right` VALUES ('55', '2', '41', null);
INSERT INTO `t_ums_right` VALUES ('56', '2', '42', null);
INSERT INTO `t_ums_right` VALUES ('57', '2', '43', null);
INSERT INTO `t_ums_right` VALUES ('58', '2', '44', null);
INSERT INTO `t_ums_right` VALUES ('59', '2', '45', null);
INSERT INTO `t_ums_right` VALUES ('60', '2', '46', null);
INSERT INTO `t_ums_right` VALUES ('61', '2', '47', null);
INSERT INTO `t_ums_right` VALUES ('62', '2', '48', null);
INSERT INTO `t_ums_right` VALUES ('63', '2', '49', null);
INSERT INTO `t_ums_right` VALUES ('64', '2', '50', null);
INSERT INTO `t_ums_right` VALUES ('65', '2', '51', null);
INSERT INTO `t_ums_right` VALUES ('66', '2', '52', null);
INSERT INTO `t_ums_right` VALUES ('67', '2', '53', null);
INSERT INTO `t_ums_right` VALUES ('68', '2', '54', null);
INSERT INTO `t_ums_right` VALUES ('69', '2', '55', null);
INSERT INTO `t_ums_right` VALUES ('70', '2', '56', null);
INSERT INTO `t_ums_right` VALUES ('71', '2', '57', null);
INSERT INTO `t_ums_right` VALUES ('72', '2', '58', null);
INSERT INTO `t_ums_right` VALUES ('73', '2', '59', null);
INSERT INTO `t_ums_right` VALUES ('74', '2', '60', null);
INSERT INTO `t_ums_right` VALUES ('75', '2', '61', null);
INSERT INTO `t_ums_right` VALUES ('76', '1', '209', null);

-- ----------------------------
-- Table structure for t_ums_role
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_role`;
CREATE TABLE `t_ums_role` (
  `ROLEID` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `ROLENAME` varchar(60) DEFAULT '' COMMENT '角色名',
  `PROLEID` int(10) DEFAULT NULL,
  `DESCRIPTION` varchar(400) DEFAULT '' COMMENT '角色描述语言值',
  PRIMARY KEY (`ROLEID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of t_ums_role
-- ----------------------------
INSERT INTO `t_ums_role` VALUES ('1', '超级角色', '-1', '');
INSERT INTO `t_ums_role` VALUES ('2', '流程管理', '-1', '');
INSERT INTO `t_ums_role` VALUES ('3', '抛磨_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('4', '抛磨_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('5', '抛磨_更新', null, '');
INSERT INTO `t_ums_role` VALUES ('6', '抛磨_导出', null, '');

-- ----------------------------
-- Table structure for t_ums_rolepermission
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_rolepermission`;
CREATE TABLE `t_ums_rolepermission` (
  `RIGHTID` int(10) NOT NULL COMMENT '权限编码',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与权限对应表';

-- ----------------------------
-- Records of t_ums_rolepermission
-- ----------------------------
INSERT INTO `t_ums_rolepermission` VALUES ('1', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('3', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('4', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('5', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('6', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('7', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('8', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('9', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('10', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('5', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('6', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('7', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('8', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('9', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('10', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('209', '1');

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
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '1', null, '3', '1', null, '', '2', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '2', null, '3', '1', null, 'cleanID', '1', 'cleanid', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '3', null, '3', '1', null, 'cleanTime', '0', 'Clean Date', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '4', null, '3', '1', null, 'cleanLotNum', '0', 'Clean LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '5', null, '3', '1', null, 'scrapQty', '0', 'Scrap Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '6', null, '3', '1', null, 'outputQty', '0', 'Output Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '7', null, '1', '3', null, '', '0', '估计值统计', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '2', '7', null, '1', '1', null, '', '0', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '2', '8', null, '1', '1', null, '', '0', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '2', '9', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '3', '7', null, '1', '1', '21', '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '3', '8', null, '1', '1', '22', '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '3', '9', null, '1', '1', null, 'yield', '0', '合格率', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '10', null, '3', '1', null, 'toOCQty', '0', 'to Optical Coating Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '11', null, '3', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '12', null, '3', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '13', null, '3', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '14', null, '3', '1', null, '', '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '2', null, '2', '1', null, 'opfID', '1', 'opfID', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '3', null, '2', '1', null, 'optTime', '0', 'Date', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '4', null, '2', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '5', null, '2', '1', null, 'inputQty', '0', 'Input Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '6', null, '2', '1', null, 'fixtureNum', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '7', null, '2', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '8', null, '2', '1', null, 'outputQty', '0', 'output Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '9', null, '2', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '10', null, '1', '1', null, null, '0', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '2', '10', '1', '1', '1', '31', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '11', null, '1', '1', null, null, '0', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '2', '11', null, '1', '1', '32', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '12', null, '2', '1', null, 'qcUseQty', '0', 'QC Use Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '13', null, '2', '1', null, 'toAPSQty', '0', 'To APS coating Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '14', null, '2', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '15', null, '2', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '16', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '17', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '1', null, '1', '1', null, '', '2', '', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '2', null, '1', '1', null, 'pfID', '1', 'pfID', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '3', null, '1', '1', null, 'coatingTime', '0', 'Coating Date', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '4', null, '1', '1', null, 'pfTime', '0', 'Date', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '5', null, '1', '1', null, 'inputLotNum', '0', 'Input LOT#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '6', null, '1', '1', null, 'inputQty', '0', 'Input Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '7', null, '1', '1', null, 'fixtureNum', '0', 'Fixture#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '8', null, '1', '1', null, 'apsBottle', '0', 'APS Bottle', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '9', null, '1', '1', null, 'outputLotNum', '0', 'Output LOT#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '10', null, '1', '1', null, 'outputQty', '0', 'Output Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '11', null, '1', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '12', null, '1', '1', null, 'underIQCQty', '0', 'Under IQC Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '13', null, '1', '1', null, 'qNum', '0', 'Q-NUM', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '14', null, '1', '1', null, 'kNum', '0', 'K-NUM', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '15', null, '1', '1', null, 'qcUseQty', '0', 'QC Use Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '16', null, '1', '1', null, 'functionalTestQty', '0', 'Functional Test Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '17', null, '1', '1', null, 'toHUBQty', '0', 'To HUB Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '18', null, '1', '1', null, 'remainQty', '0', 'REMAIN QTY', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '19', null, '1', '1', null, 'apsCondition', '0', 'APS condition', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '20', null, '1', '1', null, 'partNum', '0', 'Part Num', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '21', null, '1', '1', null, 'workOrderNum', '0', 'work order number', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '22', null, '1', '1', null, 'operatorName', '0', '操作员', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '23', null, '1', '1', null, '', '2', '操作', '');
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '1', null, '4', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '2', null, '4', '1', null, 'polishID', '1', 'polishid', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '3', null, '4', '1', null, 'pickingTime', '0', '领料日期', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '4', null, '4', '1', null, 'polishTime', '0', 'Polish Date', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '5', null, '4', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '6', null, '4', '1', null, 'inputQty', '0', 'Input Qty.(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '7', null, '4', '1', null, 'fixtureNumber', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '8', null, '4', '1', null, 'throwMillstoneNum', '0', 'millstone#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '9', null, '4', '1', null, 'throwMillstonePosition', '0', 'Loading Fixture Position', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '10', null, '1', '4', null, null, '0', '估计值统计', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '2', '10', null, '1', '4', null, null, '0', '抛磨后检验', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '10', null, '1', '1', null, null, '0', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '11', null, '1', '1', null, null, '0', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '4', '10', null, '1', '1', '12', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '4', '11', null, '1', '1', '11', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '12', null, '2', '1', null, 'casualInspectionNum', '0', '抽检总数', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '13', null, '2', '1', null, 'yield', '0', '合格率', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '14', null, '4', '1', null, 'polishLotNum', '0', 'Polish LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '16', null, '4', '1', null, 'partNum', '0', 'Part NO', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '17', null, '4', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '18', null, '4', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '19', null, '4', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '15', null, '4', '1', null, 'measuredValues', '0', '测量值', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '2', null, '2', '1', null, 'assemblyID', '1', 'assemblyID', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '3', null, '2', '1', null, 'deliveryTime', '0', 'delivery Date', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '4', null, '2', '1', null, 'trayLotNum', '0', 'TRAY#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '5', null, '2', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '6', null, '2', '1', null, 'inputQty', '0', 'Input Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '7', null, '2', '1', null, 'fixtureNum', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '8', null, '2', '1', null, 'hubLotNum', '0', 'HUB Lot#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '9', null, '2', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '10', null, '2', '1', null, 'outputQty', '0', 'output Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '11', null, '2', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '12', null, '1', '1', null, null, '3', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '13', null, '1', '1', null, null, '3', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '14', null, '2', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '15', null, '2', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '16', null, '2', '1', null, 'remark', '0', 'Remark', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '17', null, '2', '1', null, 'operatorName', '3', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '1', '18', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '2', '12', '1', '1', '1', '51', null, '3', null, null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '2', '13', null, '1', '1', '52', null, '3', null, null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '2', null, '2', '1', null, 'crID', '1', 'crID', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '3', null, '2', '1', null, 'lot', '0', 'Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '4', null, '1', '1', null, null, '0', '混合试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '5', null, '2', '1', null, 'assemblyOutputLotNums', '0', '14-####Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '6', null, '2', '1', null, 'pfOutputLotNums', '0', 'APS Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '7', null, '2', '1', null, 'ocOutputLotNums', '0', 'OP.Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '8', null, '1', '2', null, null, '0', 'Fiber', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '10', null, '2', '1', null, 'coatingStation', '0', 'Coating Station', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '11', null, '2', '1', null, 'docRev', '0', 'Doc.Rev', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '12', null, '2', '1', null, 'goodsQty', '0', 'Goods', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '13', null, '2', '1', null, 'inputQty', '0', 'Input', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '14', null, '2', '1', null, 'theoryYield', '0', 'theoretical Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '15', null, '2', '1', null, 'actualYield', '0', 'actual Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '16', null, '2', '1', null, 'theoryActualYield', '0', 'theoretical VS actual', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '17', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '1', '18', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '2', '8', null, '1', '1', null, 'rawMaterial', '0', 'Raw Material', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '2', '9', null, '1', '1', null, 'inPutDate', '0', 'In Put Date', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'chemicalreagenttable', '2', '4', null, '1', '1', '94', null, '0', null, null);

-- ----------------------------
-- Table structure for t_ums_userpermission
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_userpermission`;
CREATE TABLE `t_ums_userpermission` (
  `OPERATORID` int(8) NOT NULL COMMENT '操作员编号',
  `ROLEID` int(10) NOT NULL COMMENT '角色编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色对应表';

-- ----------------------------
-- Records of t_ums_userpermission
-- ----------------------------
INSERT INTO `t_ums_userpermission` VALUES ('3', '2');
INSERT INTO `t_ums_userpermission` VALUES ('4', '2');
INSERT INTO `t_ums_userpermission` VALUES ('13', '2');
INSERT INTO `t_ums_userpermission` VALUES ('9', '1');

-- ----------------------------
-- Table structure for t_ums_workflow_assembly
-- ----------------------------
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

-- ----------------------------
-- Records of t_ums_workflow_assembly
-- ----------------------------
INSERT INTO `t_ums_workflow_assembly` VALUES ('25', '2017-11-12', 'k94605', 'A1702031', '96', 'Q723', 'JS170120B', 'K170302XX', '3', '3', '15-9008', 'sdfs', 'T05', '9', '2017-11-12 16:24:48', '2017-11-22 00:12:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('27', '2017-11-25', 'dfd', 'sdfs', '3', 'sdcs', 'sds', 'sds', '3', '3', '14-0014', 'we', 'T17', '9', '2017-11-25 19:07:23', '2017-11-25 19:07:23');

-- ----------------------------
-- Table structure for t_ums_workflow_chemical_reagent
-- ----------------------------
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

-- ----------------------------
-- Records of t_ums_workflow_chemical_reagent
-- ----------------------------
INSERT INTO `t_ums_workflow_chemical_reagent` VALUES ('8', '1610312', 'XC160708', '2017-11-08', 'B0135', '5H-18', '9024', '9600', '94.00', '94.00', '100.00', '9', '2017-11-20 10:53:09', '2017-11-22 00:15:00');
INSERT INTO `t_ums_workflow_chemical_reagent` VALUES ('9', 'sdf', 'sdfs', '2017-11-25', 'sdfsd', 'sdg', '56', '55', '67.00', '101.82', '151.97', '9', '2017-11-25 15:03:26', '2017-11-25 15:03:32');

-- ----------------------------
-- Table structure for t_ums_workflow_chemical_reagent_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_chemical_reagent_relation`;
CREATE TABLE `t_ums_workflow_chemical_reagent_relation` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `out_lot_num` varchar(20) DEFAULT NULL COMMENT '组装站位的OUTPUT LOT#'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学试剂与组装关系表';

-- ----------------------------
-- Records of t_ums_workflow_chemical_reagent_relation
-- ----------------------------
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('3', '666666');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('3', '4444444');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('6', '666666');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('6', '4444444');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('6', '3333333');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('7', '666666');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('7', '3333333');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('8', 'K170302XX');
INSERT INTO `t_ums_workflow_chemical_reagent_relation` VALUES ('9', 'K170302XX');

-- ----------------------------
-- Table structure for t_ums_workflow_clean
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_clean`;
CREATE TABLE `t_ums_workflow_clean` (
  `clean_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `clean_time` date DEFAULT NULL COMMENT '清洗日期',
  `clean_lot_num` varchar(20) DEFAULT NULL COMMENT 'Clean LOT#',
  `scrap_qty` int(10) DEFAULT '0' COMMENT '碎片数量',
  `output_qty` int(10) DEFAULT '0' COMMENT '输出数量',
  `yield` double(5,2) DEFAULT NULL COMMENT '合格率',
  `to_oc_qty` int(10) DEFAULT '0' COMMENT '到光学镀膜数量',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`clean_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='清洗表'
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

-- ----------------------------
-- Records of t_ums_workflow_clean
-- ----------------------------
INSERT INTO `t_ums_workflow_clean` VALUES ('8', '2017-03-01', 'DX1702021', null, '1534', '99.80', '1534', '09-0071', '102379092', '9', '2017-11-11 11:26:04', '2017-11-22 00:03:52');
INSERT INTO `t_ums_workflow_clean` VALUES ('9', '2017-03-16', 'CX170214', null, '1534', '99.54', '1534', '09-0071', '102379092', '9', '2017-11-22 00:03:03', '2017-11-22 13:08:35');

-- ----------------------------
-- Table structure for t_ums_workflow_compound_reagents
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_compound_reagents`;
CREATE TABLE `t_ums_workflow_compound_reagents` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `compound_reagents_name` varchar(100) DEFAULT NULL COMMENT '混合试剂名称',
  `compound_reagents_sn` varchar(100) DEFAULT NULL COMMENT '混合试剂编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学混合试剂表';

-- ----------------------------
-- Records of t_ums_workflow_compound_reagents
-- ----------------------------
INSERT INTO `t_ums_workflow_compound_reagents` VALUES ('6', 'chemicalreagenttable207146', 'dfdfg');
INSERT INTO `t_ums_workflow_compound_reagents` VALUES ('6', 'chemicalreagenttable207144', 'dfgdg');
INSERT INTO `t_ums_workflow_compound_reagents` VALUES ('7', 'chemicalreagenttable207146', 'sdfsd');
INSERT INTO `t_ums_workflow_compound_reagents` VALUES ('7', 'chemicalreagenttable207142', 'sdfsdf');
INSERT INTO `t_ums_workflow_compound_reagents` VALUES ('8', 'chemicalreagenttable207146', 'CM16052701');
INSERT INTO `t_ums_workflow_compound_reagents` VALUES ('9', 'chemicalreagenttable207146', '454');

-- ----------------------------
-- Table structure for t_ums_workflow_defect
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_defect`;
CREATE TABLE `t_ums_workflow_defect` (
  `defect_id` int(11) DEFAULT NULL COMMENT '缺损关联id(如 defect_type为1 则defectid代表polish表唯一标示)',
  `defect_type` int(4) DEFAULT NULL COMMENT '缺损类型 1:polish 2:clean',
  `dataid` int(11) DEFAULT NULL COMMENT '数据字典表唯一标示',
  `defect_value` int(6) DEFAULT NULL COMMENT '缺损值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='缺损记录表';

-- ----------------------------
-- Records of t_ums_workflow_defect
-- ----------------------------
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '56', '37');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '56', '37');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '9', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '56', '37');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '9', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '11', '9', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '9', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '11', '9', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '11', '11', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '11', '9', '32');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '11', '47', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '56', '37');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '11', '9', '32');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '11', '47', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '9', '34');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '11', '5', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '56', '37');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '12', '52', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '11', '9', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '11', '11', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '11', '9', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '11', '9', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '12', '56', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '11', '9', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '11', '1', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '11', '1', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '11', '9', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '11', '1', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '11', '1', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '51', '124', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '52', '112', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '51', '124', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '52', '112', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('8', '21', '67', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('8', '22', '57', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('5', '31', '88', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('5', '32', '44', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '51', '124', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '52', '112', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '11', '9', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('9', '21', '76', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('9', '22', '66', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('33', '11', '9', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '11', '9', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '11', '9', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('27', '51', '124', '4');

-- ----------------------------
-- Table structure for t_ums_workflow_opticalfilming
-- ----------------------------
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

-- ----------------------------
-- Records of t_ums_workflow_opticalfilming
-- ----------------------------
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('5', '2017-02-10', 'CX170106', '1534', 'Q1981', 'O1701191XH', '1534', null, '36', '1498', '12-0003', '102367592', '9', '2017-11-22 00:06:42', '2017-11-22 00:06:42');

-- ----------------------------
-- Table structure for t_ums_workflow_platedfilm
-- ----------------------------
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

-- ----------------------------
-- Records of t_ums_workflow_platedfilm
-- ----------------------------
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('4', '2017-02-17', '2017-02-21', 'O1701191XH', '1534', 'Q1453', 'SI170207', 'A1702154XH', '1534', null, '1526', null, null, null, '8', null, null, '', '14-0014', '1111111', '9', '2017-11-22 00:10:25', '2017-11-22 00:10:25');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('5', '2017-11-25', '2017-11-25', 'sdfs', '4', 'sdfs', 'sdfsd', 'sdfds', '45', '45', '43', null, null, null, null, null, null, '', '14-0014', 'sdfs', '9', '2017-11-25 14:59:13', '2017-11-25 14:59:18');

-- ----------------------------
-- Table structure for t_ums_workflow_polish
-- ----------------------------
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
  `polish_lot_num` varchar(20) DEFAULT NULL COMMENT 'polish 完成后产生的LOT#',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`polish_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='抛光表'
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

-- ----------------------------
-- Records of t_ums_workflow_polish
-- ----------------------------
INSERT INTO `t_ums_workflow_polish` VALUES ('26', '2017-02-13', '2017-03-01', 'XC161216', '0000001534', 'Q1111', '10000', 'C', '13,24,55', '1534', '99.67', 'XC161216', '09-0080', '102418121', '9', '2017-11-11 10:40:03', '2017-11-11 11:10:47');
INSERT INTO `t_ums_workflow_polish` VALUES ('27', '2017-01-31', '2017-03-01', 'XC161216', '0000001534', 'Q1230', '10001', 'B', '13,14,25', '1534', '100.00', 'XC161216', '09-0080', '102418021', '9', '2017-11-11 11:00:54', '2017-11-22 10:48:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('28', '2017-02-13', '2017-03-01', 'XC161216', '0000001534', 'Q1047', '10003', 'B', '13,14,25', '1534', '99.87', 'XC161216', '09-0080', '102418121', '9', '2017-11-11 11:10:31', '2017-11-11 11:11:05');

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

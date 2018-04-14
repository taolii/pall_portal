/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : mcompetence

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-04-14 10:57:41
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of t_ums_admininfo
-- ----------------------------
INSERT INTO `t_ums_admininfo` VALUES ('9', '超级管理员', 'admin', 'admin', '1', '', null, '13816763234', '13434@1632', null, null, '1', '2', '1', '2017-07-08 00:55:55', '2018-04-03 16:10:27');
INSERT INTO `t_ums_admininfo` VALUES ('13', 'test', 'test', '', '女', '', null, '13816763233', '13816763233@163.com', '', '', '2', '2', '1', '2017-11-21 23:14:53', '2017-12-13 21:43:32');
INSERT INTO `t_ums_admininfo` VALUES ('15', 'admin111', 'admin3', 'admin', '0', '', null, '13816763233', '13@163.com', '', '', '2', '2', '1', '2018-03-29 17:48:08', '2018-04-03 16:17:43');
INSERT INTO `t_ums_admininfo` VALUES ('16', 'adminsds', 'adminsdssds', 'admin', '1', '', null, '13816763233', '13@163.com', '', '', '1', '2', '1', '2018-04-03 16:00:27', '2018-04-04 03:59:47');
INSERT INTO `t_ums_admininfo` VALUES ('17', 'sdfs', 'admin334', 'sdsff', '0', '', null, '13816763233', 'sfs@163.com', '', '', '1', '2', '1', '2018-04-04 04:01:18', '2018-04-04 04:17:26');

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
INSERT INTO `t_ums_config` VALUES ('1', 'polish/tablename', '1', 'polishtable201', null, '2', 'configvalue为t_ums_th_config中的tablename与menuid');
INSERT INTO `t_ums_config` VALUES ('2', 'paging/pagesize', '1', '10', null, '2', '系统默认分页大小');
INSERT INTO `t_ums_config` VALUES ('3', 'excel/export/records/limits', '1', '100000', null, '2', 'excel结果集导出最大限制数');
INSERT INTO `t_ums_config` VALUES ('4', 'polish/dataconfig/type/throwMillstonePosition', '1', '11', null, '2', '抛光盘位置在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('5', 'dataconfig/type/partNum', '1', '12', null, '2', '零件号在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('6', 'polish/dataconfig/type/defect', '1', '17', null, '2', '抛光表中的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('7', 'clean/dataconfig/type/defect', '1', '2', null, '2', '清洗表中的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('8', 'clean/tablename', '1', 'cleantable202', null, '2', 'configvalue为t_ums_th_config中的tablename与menuid');
INSERT INTO `t_ums_config` VALUES ('9', 'polish/download/subdirectory', '1', 'polish', null, '2', '抛光管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('10', 'clean/download/subdirectory', '1', 'clean', null, '2', '清洗管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('11', 'clean/dataconfig/type/workingface', '1', '181', null, '2', '清洗表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('12', 'clean/dataconfig/type/noworkingface', '1', '182', null, '2', '清洗表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('13', 'opticalFilming/dataconfig/type/workingface', '1', '191', null, '2', '光学镀膜表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('14', 'opticalFilming/dataconfig/type/noworkingface', '1', '192', null, '2', '光学镀膜表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('15', 'opticalFilming/tablename', '1', 'opticalfilmingtable203', null, '2', '光学镀膜流程配置表名');
INSERT INTO `t_ums_config` VALUES ('16', 'opticalFilming/download/subdirectory', '1', 'opticalFilming', null, '2', '光学镀膜管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('17', 'opticalFilming/dataconfig/type/defect', '1', '19', null, '2', '数据配置表代表光学镀膜 defect的配置类型');
INSERT INTO `t_ums_config` VALUES ('18', 'workflow/PlatedFilm/tablename', '1', 'platedfilmtable204', null, '2', '化学镀膜流程配置表名');
INSERT INTO `t_ums_config` VALUES ('19', 'platedFilm/download/subdirectory', '1', 'platedFilm', null, '2', '化学镀膜管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('20', 'polish/dataconfig/type/defect/workingface', '1', '171', null, '2', '抛光表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('21', 'polish/dataconfig/type/defect/noworkingface', '1', '172', null, '2', '抛光表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('22', 'dataconfig/type/scrapinfo', '1', '22', null, '2', '数据配置表代表scrap info的配置类型');
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
INSERT INTO `t_ums_config` VALUES ('34', 'polish/dataconfig/type/polishBom', '1', '14', null, '2', '数据配置表代表抛光模块polish Bom');
INSERT INTO `t_ums_config` VALUES ('35', 'dataconfig/type/list', '1', '1', null, '2', '数据配置表代表基础数据配置列表类型');
INSERT INTO `t_ums_config` VALUES ('37', 'dataconfig/type/workflow', '1', '2', null, '2', '数据配置表代表工作流数据配置列表类型');
INSERT INTO `t_ums_config` VALUES ('36', 'clean/dataconfig/type/cleanBom', '1', '21', null, '2', '数据配置表代表抛光模块Clean Bom');
INSERT INTO `t_ums_config` VALUES ('38', 'polishSel/tablename', '1', 'selpolishtable201', null, '2', '选择抛磨配置表名');
INSERT INTO `t_ums_config` VALUES ('39', 'opticalFilming/dataconfig/type/supplier', '1', '24', null, '2', '光学镀膜表供应商在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('40', 'opticalFilming/dataconfig/type/ocBom', '1', '25', null, '2', '光学镀膜表Optical Coating BOM在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('41', 'cleanSel/tablename', '1', 'selcleantable202', null, '2', '选择清洗配置表名');

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
  `configname` varchar(50) DEFAULT NULL COMMENT '标题',
  `DESCRIPTION` varchar(255) DEFAULT '' COMMENT '描述信息',
  `operatorid` int(11) DEFAULT NULL,
  `CREATETIME` datetime DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`DATAID`)
) ENGINE=InnoDB AUTO_INCREMENT=294 DEFAULT CHARSET=utf8 COMMENT='数据字典配置表';

-- ----------------------------
-- Records of t_ums_data_config
-- ----------------------------
INSERT INTO `t_ums_data_config` VALUES ('2', '1', '缺损类型', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('11', '1', 'throw millstone Position', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('12', '1', 'Part Num', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('13', '1', 'Remark', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('14', '1', 'Polish Bom', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('16', '1', '化学试剂', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('17', '2', 'Polishing', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('18', '2', 'Cleaning', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('19', '2', '光学镀膜', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('20', '2', '组装', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('21', '1', 'Clean Bom', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('22', '1', '缺损信息', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('23', '1', 'Remark', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('24', '1', '供应商', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('25', '1', 'Optical Coating BOM', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('163', '12', '13-0003', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('164', '12', '15-9008', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('165', '12', '14-0014', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('166', '11', 'A', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('167', '11', 'B', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('168', '11', 'C', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('169', '16', '05-0001|04-0001', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('170', '16', '05-0003|03-0001', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('171', '16', '05-0002|04-0002', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('172', '16', '05-0002|05-0067', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('173', '16', '334', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('174', '16', '05-0004|03-0002', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('175', '13', 'T08', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('176', '13', 'T07', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('177', '13', 'T11', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('178', '13', 'T13', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('179', '13', 'T12', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('180', '13', 'T10', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('181', '13', 'T09', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('182', '13', 'T17', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('183', '13', 'T16', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('184', '13', 'T15', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('185', '13', 'T14', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('186', '13', 'T01', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('187', '13', 'T03', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('188', '13', 'T02', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('189', '13', 'T06', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('190', '13', 'T05', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('191', '13', 'T04', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('192', '201', '膜层脱落', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('193', '201', '绿膜', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('194', '201', '彩虹到芯', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('195', '201', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('196', '201', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('197', '201', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('198', '201', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('199', '201', '膜下异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('200', '201', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('201', '201', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('202', '201', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('203', '201', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('204', '202', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('205', '202', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('206', '202', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('207', '202', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('208', '202', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('209', '202', '高低', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('210', '202', '装反', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('211', '202', '破点', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('212', '202', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('213', '171', '麻点', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('214', '171', '崩边', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('215', '171', '划痕', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('216', '171', '异物', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('217', '171', '印迹', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('218', '171', '其它', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('219', '171', '12-0003', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('220', '171', '水印', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('221', '171', '缝隙', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('222', '171', '胶', 'polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('223', '172', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('224', '172', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('225', '172', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('226', '172', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('227', '172', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('228', '172', '麻点', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('229', '172', '水印', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('230', '172', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('231', '172', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('232', '181', '麻点', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('233', '181', '水印', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('234', '181', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('235', '181', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('236', '181', '麻点', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('237', '181', '水印', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('238', '181', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('239', '181', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('240', '181', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('241', '181', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('242', '182', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('243', '182', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('244', '182', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('245', '182', '棉纱', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('246', '182', '麻点', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('247', '182', '水印', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('248', '182', '印痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('249', '182', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('250', '182', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('251', '182', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('252', '191', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('253', '191', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('254', '191', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('255', '191', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('256', '191', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('257', '191', '绿膜', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('258', '191', '彩虹到芯', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('259', '191', '膜层脱落', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('260', '191', '膜下异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('261', '191', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('262', '191', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('263', '192', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('264', '192', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('265', '192', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('266', '192', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('267', '192', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('268', '192', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('269', '14', 'ddd', '', '9', '2018-04-07 01:44:20', '2018-04-07 01:44:20');
INSERT INTO `t_ums_data_config` VALUES ('270', '14', 'ddddsss', '', '9', '2018-04-07 01:44:28', '2018-04-07 01:44:28');
INSERT INTO `t_ums_data_config` VALUES ('271', '14', 'fggff', '', '9', '2018-04-07 01:44:35', '2018-04-07 01:44:35');
INSERT INTO `t_ums_data_config` VALUES ('272', '21', 'C1', '', '9', '2018-04-10 09:45:27', '2018-04-10 09:45:27');
INSERT INTO `t_ums_data_config` VALUES ('273', '21', 'C2', '', '9', '2018-04-10 09:45:34', '2018-04-10 09:45:34');
INSERT INTO `t_ums_data_config` VALUES ('274', '21', 'C3', '', '9', '2018-04-10 09:45:41', '2018-04-10 09:45:41');
INSERT INTO `t_ums_data_config` VALUES ('275', '22', '崩边', '', '9', '2018-04-13 09:59:06', '2018-04-13 09:59:06');
INSERT INTO `t_ums_data_config` VALUES ('276', '22', '划痕', '', '9', '2018-04-13 09:59:15', '2018-04-13 09:59:15');
INSERT INTO `t_ums_data_config` VALUES ('277', '22', '异物', '', '9', '2018-04-13 09:59:36', '2018-04-13 09:59:36');
INSERT INTO `t_ums_data_config` VALUES ('278', '22', '胶', '', '9', '2018-04-13 09:59:50', '2018-04-13 09:59:50');
INSERT INTO `t_ums_data_config` VALUES ('279', '22', '印迹', '', '9', '2018-04-13 10:00:01', '2018-04-13 10:00:01');
INSERT INTO `t_ums_data_config` VALUES ('280', '22', '高低', '', '9', '2018-04-13 10:00:10', '2018-04-13 10:00:10');
INSERT INTO `t_ums_data_config` VALUES ('281', '22', '装反', '', '9', '2018-04-13 10:00:21', '2018-04-13 10:00:21');
INSERT INTO `t_ums_data_config` VALUES ('282', '22', '破点', '', '9', '2018-04-13 10:00:31', '2018-04-13 10:00:31');
INSERT INTO `t_ums_data_config` VALUES ('283', '22', '麻点', '', '9', '2018-04-13 10:00:43', '2018-04-13 10:00:43');
INSERT INTO `t_ums_data_config` VALUES ('284', '22', '其它', '', '9', '2018-04-13 10:01:00', '2018-04-13 10:01:00');
INSERT INTO `t_ums_data_config` VALUES ('285', '22', '膜层脱落', '', '9', '2018-04-13 10:01:21', '2018-04-13 10:01:21');
INSERT INTO `t_ums_data_config` VALUES ('286', '22', '绿膜', '', '9', '2018-04-13 10:01:33', '2018-04-13 10:01:33');
INSERT INTO `t_ums_data_config` VALUES ('287', '22', '彩虹到芯', '', '9', '2018-04-13 10:01:43', '2018-04-13 10:01:43');
INSERT INTO `t_ums_data_config` VALUES ('288', '22', '膜下异物', '', '9', '2018-04-13 10:01:54', '2018-04-13 10:01:54');
INSERT INTO `t_ums_data_config` VALUES ('289', '172', '膜层脱落', '', '9', '2018-04-13 10:02:10', '2018-04-13 10:02:10');
INSERT INTO `t_ums_data_config` VALUES ('290', '24', '华为', '', '9', '2018-04-13 13:49:39', '2018-04-13 13:49:39');
INSERT INTO `t_ums_data_config` VALUES ('291', '24', '中兴', '', '9', '2018-04-13 13:49:46', '2018-04-13 13:49:46');
INSERT INTO `t_ums_data_config` VALUES ('292', '25', '的地方法规', '', '9', '2018-04-14 00:18:49', '2018-04-14 00:18:49');
INSERT INTO `t_ums_data_config` VALUES ('293', '25', '哈哈', '', '9', '2018-04-14 00:18:57', '2018-04-14 00:18:57');

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
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of t_ums_menuinfo
-- ----------------------------
INSERT INTO `t_ums_menuinfo` VALUES ('1', '基础管理', 'menu-icon glyphicon glyphicon-cog', null, '0', '0', '-1', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('2', '工作流管理', 'menu-icon glyphicon glyphicon-globe', '', '0', '0', '-1', '3', '');
INSERT INTO `t_ums_menuinfo` VALUES ('101', '权限管理', '胜多负少', null, '1', '1', '1', '1', '');
INSERT INTO `t_ums_menuinfo` VALUES ('102', '用户管理', '\r\nmenu-icon glyphicon glyphicon-user', '/user/userManage', '1', '0', '1', '2', null);
INSERT INTO `t_ums_menuinfo` VALUES ('103', '角色管理', 'menu-icon glyphicon glyphicon-asterisk', '/role/roleManage', '1', '0', '1', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('104', '权限配置管理', 'menu-icon glyphicons \r\nglyphicons-user', '/right/rightManage', '1', '1', '1', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('105', '菜单管理', 'menu-icon glyphicon glyphicon-eye-open', '/menu/menuManage', '1', '1', '1', '5', null);
INSERT INTO `t_ums_menuinfo` VALUES ('106', '缺损管理', 'menu-icon glyphicon glyphicon-book', '/defect/defectManage', '1', '0', '1', '6', null);
INSERT INTO `t_ums_menuinfo` VALUES ('107', '数据配置管理', 'menu-icon glyphicon glyphicons-settings', '/dataconfig/dataConfigManage', '1', '0', '1', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('108', '按钮管理', 'menu-icon glyphicon glyphicon-eye-open', '/button/buttonManage', '1', '0', '1', '8', '');
INSERT INTO `t_ums_menuinfo` VALUES ('201', '抛磨', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/polishManage', '1', '0', '2', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('202', '清洗', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/cleanManage', '1', '0', '2', '2', null);
INSERT INTO `t_ums_menuinfo` VALUES ('203', '光学镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/opticalFilmingManage', '1', '0', '2', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('204', '化学镀膜APS', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/platedFilmManage', '1', '0', '2', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('205', '组装', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/assemblyManage', '1', '0', '2', '6', null);
INSERT INTO `t_ums_menuinfo` VALUES ('206', '生化镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/chemicalReagentManage', '1', '0', '2', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('207', '二次生化镀膜', 'glyphicons-hand-right', '/workflow/chemicalReagentManage', '1', '0', '2', '8', '');

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
  PRIMARY KEY (`btnid`,`menuid`)
) ENGINE=InnoDB AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8 COMMENT='按钮权限表';

-- ----------------------------
-- Records of t_ums_menu_button
-- ----------------------------
INSERT INTO `t_ums_menu_button` VALUES ('1001', '105', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1002', '105', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1004', '105', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1005', '105', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1006', '105', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1007', '105', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1008', '106', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1009', '106', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1010', '106', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1011', '106', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1012', '106', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1013', '106', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1014', '201', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1015', '201', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1016', '201', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1017', '201', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('1018', '201', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1019', '201', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('1020', '201', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1021', '201', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1022', '202', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1023', '202', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1024', '202', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1025', '202', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('1026', '202', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1027', '202', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('1028', '202', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1029', '202', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1030', '203', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1031', '203', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1032', '203', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1033', '203', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('1034', '203', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1035', '203', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('1036', '203', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1037', '203', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1038', '204', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1039', '204', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1040', '204', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1041', '204', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('1042', '204', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1043', '204', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('1044', '204', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1045', '204', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1046', '205', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1047', '205', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1048', '205', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1049', '205', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('1050', '205', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1051', '205', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('1052', '205', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1053', '205', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1054', '206', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1055', '206', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1056', '206', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1057', '206', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('1058', '206', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1059', '206', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('1060', '206', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1061', '206', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);
INSERT INTO `t_ums_menu_button` VALUES ('1062', '207', 'btn-query', '查询', 'btn btn-primary', 'fa fa-search', null);
INSERT INTO `t_ums_menu_button` VALUES ('1063', '207', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', null);
INSERT INTO `t_ums_menu_button` VALUES ('1064', '207', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', null);
INSERT INTO `t_ums_menu_button` VALUES ('1065', '207', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', null);
INSERT INTO `t_ums_menu_button` VALUES ('1066', '207', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', null);
INSERT INTO `t_ums_menu_button` VALUES ('1067', '207', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', null);
INSERT INTO `t_ums_menu_button` VALUES ('1068', '207', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', null);
INSERT INTO `t_ums_menu_button` VALUES ('1069', '207', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', null);

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
  PRIMARY KEY (`RIGHTID`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COMMENT='权限信息表';

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
INSERT INTO `t_ums_right` VALUES ('8', '1', '106', null);
INSERT INTO `t_ums_right` VALUES ('9', '1', '107', null);
INSERT INTO `t_ums_right` VALUES ('10', '1', '108', null);
INSERT INTO `t_ums_right` VALUES ('11', '1', '201', null);
INSERT INTO `t_ums_right` VALUES ('12', '1', '202', null);
INSERT INTO `t_ums_right` VALUES ('13', '1', '203', null);
INSERT INTO `t_ums_right` VALUES ('14', '1', '204', null);
INSERT INTO `t_ums_right` VALUES ('15', '1', '205', null);
INSERT INTO `t_ums_right` VALUES ('16', '1', '206', null);
INSERT INTO `t_ums_right` VALUES ('17', '1', '207', null);
INSERT INTO `t_ums_right` VALUES ('25', '2', '1001', null);
INSERT INTO `t_ums_right` VALUES ('26', '2', '1002', null);
INSERT INTO `t_ums_right` VALUES ('27', '2', '1003', null);
INSERT INTO `t_ums_right` VALUES ('28', '2', '1004', null);
INSERT INTO `t_ums_right` VALUES ('29', '2', '1005', null);
INSERT INTO `t_ums_right` VALUES ('30', '2', '1006', null);
INSERT INTO `t_ums_right` VALUES ('31', '2', '1007', null);
INSERT INTO `t_ums_right` VALUES ('32', '2', '1008', null);
INSERT INTO `t_ums_right` VALUES ('33', '2', '1009', null);
INSERT INTO `t_ums_right` VALUES ('34', '2', '1010', null);
INSERT INTO `t_ums_right` VALUES ('35', '2', '1011', null);
INSERT INTO `t_ums_right` VALUES ('36', '2', '1012', null);
INSERT INTO `t_ums_right` VALUES ('37', '2', '1013', null);
INSERT INTO `t_ums_right` VALUES ('38', '2', '1014', null);
INSERT INTO `t_ums_right` VALUES ('39', '2', '1015', null);
INSERT INTO `t_ums_right` VALUES ('40', '2', '1016', null);
INSERT INTO `t_ums_right` VALUES ('41', '2', '1017', null);
INSERT INTO `t_ums_right` VALUES ('42', '2', '1018', null);
INSERT INTO `t_ums_right` VALUES ('43', '2', '1019', null);
INSERT INTO `t_ums_right` VALUES ('44', '2', '1020', null);
INSERT INTO `t_ums_right` VALUES ('45', '2', '1021', null);
INSERT INTO `t_ums_right` VALUES ('46', '2', '1022', null);
INSERT INTO `t_ums_right` VALUES ('47', '2', '1023', null);
INSERT INTO `t_ums_right` VALUES ('48', '2', '1024', null);
INSERT INTO `t_ums_right` VALUES ('49', '2', '1025', null);
INSERT INTO `t_ums_right` VALUES ('50', '2', '1026', null);
INSERT INTO `t_ums_right` VALUES ('51', '2', '1027', null);
INSERT INTO `t_ums_right` VALUES ('52', '2', '1028', null);
INSERT INTO `t_ums_right` VALUES ('53', '2', '1029', null);
INSERT INTO `t_ums_right` VALUES ('54', '2', '1030', null);
INSERT INTO `t_ums_right` VALUES ('55', '2', '1031', null);
INSERT INTO `t_ums_right` VALUES ('56', '2', '1032', null);
INSERT INTO `t_ums_right` VALUES ('57', '2', '1033', null);
INSERT INTO `t_ums_right` VALUES ('58', '2', '1034', null);
INSERT INTO `t_ums_right` VALUES ('59', '2', '1035', null);
INSERT INTO `t_ums_right` VALUES ('60', '2', '1036', null);
INSERT INTO `t_ums_right` VALUES ('61', '2', '1037', null);
INSERT INTO `t_ums_right` VALUES ('62', '2', '1038', null);
INSERT INTO `t_ums_right` VALUES ('63', '2', '1039', null);
INSERT INTO `t_ums_right` VALUES ('64', '2', '1040', null);
INSERT INTO `t_ums_right` VALUES ('65', '2', '1041', null);
INSERT INTO `t_ums_right` VALUES ('66', '2', '1042', null);
INSERT INTO `t_ums_right` VALUES ('67', '2', '1043', null);
INSERT INTO `t_ums_right` VALUES ('68', '2', '1044', null);
INSERT INTO `t_ums_right` VALUES ('69', '2', '1045', null);
INSERT INTO `t_ums_right` VALUES ('70', '2', '1046', null);
INSERT INTO `t_ums_right` VALUES ('71', '2', '1047', null);
INSERT INTO `t_ums_right` VALUES ('72', '2', '1048', null);
INSERT INTO `t_ums_right` VALUES ('73', '2', '1049', null);
INSERT INTO `t_ums_right` VALUES ('74', '2', '1050', null);
INSERT INTO `t_ums_right` VALUES ('75', '2', '1051', null);
INSERT INTO `t_ums_right` VALUES ('76', '2', '1052', null);
INSERT INTO `t_ums_right` VALUES ('77', '2', '1053', null);
INSERT INTO `t_ums_right` VALUES ('78', '2', '1054', null);
INSERT INTO `t_ums_right` VALUES ('79', '2', '1055', null);
INSERT INTO `t_ums_right` VALUES ('80', '2', '1056', null);
INSERT INTO `t_ums_right` VALUES ('81', '2', '1057', null);
INSERT INTO `t_ums_right` VALUES ('82', '2', '1058', null);
INSERT INTO `t_ums_right` VALUES ('83', '2', '1059', null);
INSERT INTO `t_ums_right` VALUES ('84', '2', '1060', null);
INSERT INTO `t_ums_right` VALUES ('85', '2', '1061', null);
INSERT INTO `t_ums_right` VALUES ('86', '2', '1062', null);
INSERT INTO `t_ums_right` VALUES ('87', '2', '1063', null);
INSERT INTO `t_ums_right` VALUES ('88', '2', '1064', null);
INSERT INTO `t_ums_right` VALUES ('89', '2', '1065', null);
INSERT INTO `t_ums_right` VALUES ('90', '2', '1066', null);
INSERT INTO `t_ums_right` VALUES ('91', '2', '1067', null);
INSERT INTO `t_ums_right` VALUES ('92', '2', '1068', null);
INSERT INTO `t_ums_right` VALUES ('93', '2', '1069', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of t_ums_role
-- ----------------------------
INSERT INTO `t_ums_role` VALUES ('1', '超级角色', '-1', '');
INSERT INTO `t_ums_role` VALUES ('2', '流程管理', '-1', '');
INSERT INTO `t_ums_role` VALUES ('17', '抛磨_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('18', '抛磨_新增', null, '');
INSERT INTO `t_ums_role` VALUES ('19', '抛磨_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('20', '抛磨_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('21', '抛磨_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('22', '抛磨_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('23', '清洗_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('24', '清洗_新增', null, '');
INSERT INTO `t_ums_role` VALUES ('25', '清洗_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('26', '清洗_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('27', '清洗_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('28', '清洗_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('29', '光学镀膜_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('30', '光学镀膜_新增', null, '');
INSERT INTO `t_ums_role` VALUES ('31', '光学镀膜_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('32', '光学镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('33', '光学镀膜_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('34', '光学镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('35', '化学镀膜_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('36', '化学镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('37', '化学镀膜_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('38', '化学镀膜_新增', null, '');
INSERT INTO `t_ums_role` VALUES ('39', '化学镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('40', '化学镀膜_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('41', '组装_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('42', '组装_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('43', '组装_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('44', '组装_新增', null, '');
INSERT INTO `t_ums_role` VALUES ('45', '组装_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('46', '组装_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('47', '生化镀膜_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('48', '生化镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('49', '生化镀膜_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('50', '生化镀膜_新增', null, '');
INSERT INTO `t_ums_role` VALUES ('51', '生化镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('52', '生化镀膜_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('53', '二次生化镀膜_查看', null, '');
INSERT INTO `t_ums_role` VALUES ('54', '二次生化镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('55', '二次生化镀膜_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('56', '二次生化镀膜_新增', null, '');
INSERT INTO `t_ums_role` VALUES ('57', '二次生化镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('58', '二次生化镀膜_导出', null, '');

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
INSERT INTO `t_ums_rolepermission` VALUES ('1', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('3', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('4', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('5', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('8', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('9', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('10', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('1', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('7', '1');

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
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '7', null, '3', '1', null, 'cleanLotNum', '0', 'Clean LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '8', null, '3', '1', null, 'scrapQty', '0', 'Scrap Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '9', null, '3', '1', null, 'outputQty', '0', 'Output Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '10', null, '1', '3', null, '', '0', '估计值统计', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '2', '10', null, '1', '1', null, '', '0', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '2', '11', null, '1', '1', null, '', '0', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '2', '12', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '3', '10', null, '1', '1', '181', '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '3', '11', null, '1', '1', '182', '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '3', '12', null, '1', '1', null, 'yield', '0', '合格率', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '13', null, '3', '1', null, 'toOtherQty', '0', 'To Other Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '14', null, '3', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '15', null, '3', '1', null, 'workOrderNum', '0', 'Work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '16', null, '3', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '17', null, '3', '1', null, '', '2', '操作', null);
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
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '2', '10', '1', '1', '1', '191', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '11', null, '1', '1', null, null, '0', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '2', '11', null, '1', '1', '192', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '12', null, '2', '1', null, 'qcUseQty', '0', 'QC Use Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '13', null, '2', '1', null, 'toOtherQty', '0', 'To Other Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '14', null, '2', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '15', null, '2', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '18', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '19', null, '2', '1', null, null, '2', '操作', null);
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
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '4', '10', null, '1', '1', '172', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '4', '11', null, '1', '1', '171', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '12', null, '2', '1', null, 'casualInspectionNum', '0', '抽检总数', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '13', null, '2', '1', null, 'yield', '0', '合格率', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '14', null, '4', '1', null, 'polishLotNum', '0', 'Polish LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '17', null, '4', '1', null, 'partNum', '0', 'Part NO', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '18', null, '4', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '20', null, '4', '1', null, 'operatorName', '3', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '21', null, '4', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '16', null, '4', '1', null, 'measuredValues', '0', '测量值', null);
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
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '2', '12', '1', '1', '1', '201', null, '3', null, null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'assemblytable', '2', '13', null, '1', '1', '202', null, '3', null, null);
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
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '19', null, '4', '1', null, 'polishBom', '0', 'Polish Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '4', null, '3', '1', null, 'fixtureNumber', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '5', null, '3', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '6', null, '3', '1', null, 'cleanBom', '0', 'Clean BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '15', null, '4', '1', null, 'outputQty', '1', 'outputQty', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '1', null, '1', '1', null, null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '2', null, '1', '1', null, 'polishID', '1', 'polishid', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '3', null, '1', '1', null, 'pickingTime', '0', '领料日期', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '4', null, '1', '1', null, 'polishTime', '0', 'Polish Date', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '5', null, '1', '1', null, 'fixtureNumber', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '6', null, '1', '1', null, 'throwMillstonePosition', '1', 'Loading Fixture Position', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '7', null, '1', '1', null, 'throwMillstoneNum', '1', 'millstone#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '8', null, '1', '1', null, 'inputQty', '0', 'Input Qty.(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '9', null, '1', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '10', null, '1', '1', null, 'polishLotNum', '0', 'Polish LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '11', null, '1', '1', null, 'outputQty', '1', 'outputQty', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '12', null, '1', '1', null, 'polishBom', '0', 'Polish Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '13', null, '1', '1', null, 'measuredValues', '1', '测量值', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '14', null, '1', '1', null, 'partNum', '0', 'Part NO', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '15', null, '1', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '16', null, '2', '1', null, 'supplier', '0', '供应商', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '17', null, '2', '1', null, 'ocBom', '0', 'Optical Coating BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '1', null, '1', '1', null, '', '1', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '2', null, '1', '1', null, 'cleanID', '1', 'cleanid', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '3', null, '1', '1', null, 'cleanTime', '0', 'Clean Date', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '4', null, '1', '1', null, 'fixtureNumber', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '5', null, '1', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '6', null, '1', '1', null, 'cleanBom', '0', 'Clean BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '7', null, '1', '1', null, 'cleanLotNum', '0', 'Clean LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '8', null, '1', '1', null, 'scrapQty', '0', 'Scrap Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '9', null, '1', '1', null, 'outputQty', '0', 'Output Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '10', null, '1', '1', null, 'toOtherQty', '0', 'To Other Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '11', null, '1', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '12', null, '1', '1', null, 'workOrderNum', '0', 'Work order number', null);

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
INSERT INTO `t_ums_userpermission` VALUES ('15', '13');
INSERT INTO `t_ums_userpermission` VALUES ('15', '12');
INSERT INTO `t_ums_userpermission` VALUES ('15', '9');
INSERT INTO `t_ums_userpermission` VALUES ('15', '8');
INSERT INTO `t_ums_userpermission` VALUES ('15', '6');
INSERT INTO `t_ums_userpermission` VALUES ('15', '5');
INSERT INTO `t_ums_userpermission` VALUES ('15', '4');
INSERT INTO `t_ums_userpermission` VALUES ('15', '2');
INSERT INTO `t_ums_userpermission` VALUES ('15', '1');
INSERT INTO `t_ums_userpermission` VALUES ('16', '58');
INSERT INTO `t_ums_userpermission` VALUES ('16', '57');
INSERT INTO `t_ums_userpermission` VALUES ('16', '54');
INSERT INTO `t_ums_userpermission` VALUES ('16', '53');
INSERT INTO `t_ums_userpermission` VALUES ('16', '50');
INSERT INTO `t_ums_userpermission` VALUES ('16', '49');
INSERT INTO `t_ums_userpermission` VALUES ('16', '46');
INSERT INTO `t_ums_userpermission` VALUES ('16', '45');
INSERT INTO `t_ums_userpermission` VALUES ('16', '41');
INSERT INTO `t_ums_userpermission` VALUES ('16', '37');
INSERT INTO `t_ums_userpermission` VALUES ('17', '58');
INSERT INTO `t_ums_userpermission` VALUES ('17', '56');
INSERT INTO `t_ums_userpermission` VALUES ('17', '54');
INSERT INTO `t_ums_userpermission` VALUES ('17', '52');
INSERT INTO `t_ums_userpermission` VALUES ('17', '50');
INSERT INTO `t_ums_userpermission` VALUES ('17', '49');
INSERT INTO `t_ums_userpermission` VALUES ('17', '48');
INSERT INTO `t_ums_userpermission` VALUES ('17', '46');
INSERT INTO `t_ums_userpermission` VALUES ('17', '45');
INSERT INTO `t_ums_userpermission` VALUES ('17', '44');
INSERT INTO `t_ums_userpermission` VALUES ('17', '40');
INSERT INTO `t_ums_userpermission` VALUES ('17', '38');

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

-- ----------------------------
-- Records of t_ums_workflow_clean
-- ----------------------------
INSERT INTO `t_ums_workflow_clean` VALUES ('8', '2017-03-01', '', '', null, '', 'DX1702021', null, '1534', '99.80', '1534', '09-0071', '102379092', '9', '2017-11-11 11:26:04', '2017-11-22 00:03:52');
INSERT INTO `t_ums_workflow_clean` VALUES ('9', '2017-03-16', '', '', null, '', 'CX170214', null, '1534', '99.54', '1534', '09-0071', '102379092', '9', '2017-11-22 00:03:03', '2017-11-22 13:08:35');
INSERT INTO `t_ums_workflow_clean` VALUES ('10', '2018-04-10', '8877', '胜多负少', '5', 'C3', '师傅', '4', '23', '69.57', '0', '13-0003', '水电费', '9', '2018-04-10 10:21:50', '2018-04-10 10:21:50');
INSERT INTO `t_ums_workflow_clean` VALUES ('12', '2018-04-10', '8877', '胜多负少', '5', 'C3', '师傅', '4', '23', '69.57', '0', '13-0003', '水电费', '9', '2018-04-10 10:21:53', '2018-04-10 10:21:53');
INSERT INTO `t_ums_workflow_clean` VALUES ('13', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-10 10:21:53', '2018-04-11 14:54:09');
INSERT INTO `t_ums_workflow_clean` VALUES ('14', '2018-04-18', 'hhh', 'jjkhh', '675', 'C3', 'csdfs', '11', '664', '98.34', '0', '13-0003', 'sdfs', '9', '2018-04-11 14:03:24', '2018-04-11 14:03:24');
INSERT INTO `t_ums_workflow_clean` VALUES ('15', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:33', '2018-04-11 14:57:33');
INSERT INTO `t_ums_workflow_clean` VALUES ('16', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:34', '2018-04-11 14:57:34');
INSERT INTO `t_ums_workflow_clean` VALUES ('17', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:35', '2018-04-11 14:57:35');
INSERT INTO `t_ums_workflow_clean` VALUES ('18', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:35', '2018-04-11 14:57:35');
INSERT INTO `t_ums_workflow_clean` VALUES ('19', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:36', '2018-04-11 14:57:36');
INSERT INTO `t_ums_workflow_clean` VALUES ('20', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:36', '2018-04-11 14:57:36');
INSERT INTO `t_ums_workflow_clean` VALUES ('21', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:36', '2018-04-11 14:57:36');
INSERT INTO `t_ums_workflow_clean` VALUES ('22', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:36', '2018-04-11 14:57:36');
INSERT INTO `t_ums_workflow_clean` VALUES ('23', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:37', '2018-04-11 14:57:37');
INSERT INTO `t_ums_workflow_clean` VALUES ('24', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:37', '2018-04-11 14:57:37');
INSERT INTO `t_ums_workflow_clean` VALUES ('25', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:37', '2018-04-11 14:57:37');
INSERT INTO `t_ums_workflow_clean` VALUES ('26', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:38', '2018-04-11 14:57:38');
INSERT INTO `t_ums_workflow_clean` VALUES ('27', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:38', '2018-04-11 14:57:38');
INSERT INTO `t_ums_workflow_clean` VALUES ('28', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:38', '2018-04-11 14:57:38');
INSERT INTO `t_ums_workflow_clean` VALUES ('29', '2018-04-10', 'hhh', 'jjkhh', '675', 'C3', '师傅', '11', '630', '98.25', '34', '13-0003', '水电费', '9', '2018-04-11 14:57:40', '2018-04-11 14:57:40');

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
INSERT INTO `t_ums_workflow_defect` VALUES ('32', '171', '213', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('33', '171', '213', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('34', '171', '213', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('35', '171', '213', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('36', '171', '213', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('37', '171', '213', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('38', '171', '213', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('39', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('39', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('39', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('39', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('46', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('46', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('46', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('46', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('47', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('47', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('47', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('47', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('50', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('50', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('50', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('50', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('57', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('57', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('57', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('57', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('58', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('58', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('58', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('58', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('59', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('59', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('59', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('59', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('64', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('64', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('64', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('64', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('80', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('80', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('80', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('80', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('81', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('81', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('81', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('81', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('82', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('82', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('82', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('82', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('83', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('83', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('83', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('83', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('84', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('84', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('84', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('84', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('85', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('85', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('85', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('85', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('86', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('86', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('86', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('86', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('87', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('87', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('87', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('87', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('88', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('88', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('88', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('88', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('89', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('89', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('89', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('89', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('90', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('90', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('90', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('90', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('91', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('91', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('91', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('91', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('92', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('92', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('92', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('92', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('93', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('93', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('93', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('93', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('94', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('94', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('94', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('94', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('96', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('96', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('96', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('96', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('97', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('97', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('97', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('97', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('98', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('98', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('98', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('98', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('99', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('99', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('99', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('99', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('100', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('100', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('100', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('100', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('101', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('101', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('101', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('101', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('102', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('102', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('102', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('102', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('103', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('103', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('103', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('103', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('104', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('104', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('104', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('104', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('105', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('105', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('105', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('105', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('106', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('106', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('106', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('106', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('107', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('107', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('107', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('107', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('108', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('108', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('108', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('108', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('109', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('109', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('109', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('109', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('110', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('110', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('110', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('110', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('111', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('111', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('111', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('111', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('112', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('112', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('112', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('112', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('113', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('113', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('113', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('113', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('114', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('114', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('114', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('114', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('115', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('115', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('115', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('115', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('116', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('116', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('116', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('116', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('119', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('119', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('119', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('119', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('120', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('120', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('120', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('120', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('121', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('121', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('121', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('121', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('122', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('122', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('122', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('122', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('123', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('123', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('123', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('123', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('124', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('124', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('124', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('124', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('125', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('125', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('125', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('125', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('126', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('126', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('126', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('126', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('127', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('127', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('127', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('127', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('128', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('128', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('128', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('128', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('129', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('129', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('129', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('129', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('130', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('130', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('130', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('130', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('131', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('131', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('131', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('131', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('132', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('132', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('132', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('132', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('133', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('133', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('133', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('133', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('135', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('135', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('135', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('135', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('136', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('136', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('136', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('136', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('137', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('137', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('137', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('137', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('138', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('138', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('138', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('138', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('10', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('10', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('12', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('12', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '171', '213', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '171', '216', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '172', '224', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('139', '172', '227', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('14', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('14', '181', '234', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('14', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('13', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('13', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('13', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('15', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('15', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('15', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('16', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('16', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('16', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('17', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('17', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('17', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('18', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('18', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('18', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('19', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('19', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('19', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('20', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('20', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('20', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('21', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('27', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('27', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('27', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '181', '232', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '181', '234', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '182', '242', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('6', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('6', '191', '255', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('6', '192', '263', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('7', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('7', '191', '255', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('7', '192', '263', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('8', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('8', '191', '255', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('8', '192', '263', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('9', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('9', '191', '255', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('9', '192', '263', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('10', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('10', '191', '255', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('10', '192', '263', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('11', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('11', '191', '255', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('11', '192', '263', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '191', '252', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '192', '263', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '192', '266', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '191', '252', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '192', '263', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '192', '266', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '191', '252', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '192', '263', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '192', '266', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '191', '255', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '192', '263', '4');

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
  `to_other_qty` int(10) DEFAULT '0' COMMENT 'To Other Qty(pcs)',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `supplier` varchar(255) DEFAULT '' COMMENT '供应商信息',
  `oc_bom` varchar(255) DEFAULT '' COMMENT 'Optical Coating bom',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`opf_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='光学镀膜表'
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
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('5', '2017-02-10', 'CX170106', '1534', 'Q1981', 'O1701191XH', '1534', null, '36', '1498', '12-0003', '', '', '102367592', '9', '2017-11-22 00:06:42', '2017-11-22 00:06:42');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('6', '2018-04-11', '师傅', '630', 'hhh', '试试', '619', '11', '0', '0', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 09:26:27', '2018-04-14 09:26:27');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('7', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '33', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 09:29:57', '2018-04-14 10:10:13');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('8', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '609', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 09:29:58', '2018-04-14 09:29:58');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('9', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '609', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 09:29:59', '2018-04-14 09:29:59');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('10', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '34', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 09:29:59', '2018-04-14 10:08:32');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('11', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '609', '13', '5', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 09:29:59', '2018-04-14 10:05:43');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('12', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:13:56', '2018-04-14 10:13:56');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('13', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:03', '2018-04-14 10:14:03');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('14', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:03', '2018-04-14 10:14:03');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('15', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:03', '2018-04-14 10:14:03');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('16', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:03', '2018-04-14 10:14:03');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('17', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:04', '2018-04-14 10:14:04');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('18', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:04', '2018-04-14 10:14:04');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('19', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:04', '2018-04-14 10:14:04');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('20', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:04', '2018-04-14 10:14:04');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('21', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:04', '2018-04-14 10:14:04');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('22', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:05', '2018-04-14 10:14:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('23', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:05', '2018-04-14 10:14:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('24', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:05', '2018-04-14 10:14:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('25', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:05', '2018-04-14 10:14:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('26', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:06', '2018-04-14 10:14:06');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('27', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:06', '2018-04-14 10:14:06');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('28', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:06', '2018-04-14 10:14:06');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('29', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:06', '2018-04-14 10:14:06');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('30', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:06', '2018-04-14 10:14:06');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('31', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:07', '2018-04-14 10:14:07');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('32', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:07', '2018-04-14 10:14:07');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('33', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:07', '2018-04-14 10:14:07');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('34', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:07', '2018-04-14 10:14:07');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('35', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:07', '2018-04-14 10:14:07');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('36', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:08', '2018-04-14 10:14:08');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('37', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:08', '2018-04-14 10:14:08');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('38', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:08', '2018-04-14 10:14:08');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('39', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:09', '2018-04-14 10:14:09');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('40', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:14', '2018-04-14 10:14:14');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('41', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:14', '2018-04-14 10:14:14');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('42', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:15', '2018-04-14 10:14:15');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('43', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:15', '2018-04-14 10:14:15');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('44', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:15', '2018-04-14 10:14:15');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('45', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:16', '2018-04-14 10:14:16');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('46', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:16', '2018-04-14 10:14:16');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('47', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:16', '2018-04-14 10:14:16');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('48', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:16', '2018-04-14 10:14:16');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('49', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:17', '2018-04-14 10:14:17');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('50', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:17', '2018-04-14 10:14:17');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('51', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:17', '2018-04-14 10:14:17');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('52', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:18', '2018-04-14 10:14:18');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('53', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:18', '2018-04-14 10:14:18');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('54', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:18', '2018-04-14 10:14:18');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('55', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:19', '2018-04-14 10:14:19');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('56', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:19', '2018-04-14 10:14:19');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('57', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:19', '2018-04-14 10:14:19');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('58', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:20', '2018-04-14 10:14:20');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('59', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:20', '2018-04-14 10:14:20');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('60', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:20', '2018-04-14 10:14:20');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('62', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:21', '2018-04-14 10:14:21');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('63', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:21', '2018-04-14 10:14:21');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('64', '2018-04-12', '师傅', '630', 'hhh', 'ccc', '612', '13', '3', '5', '13-0003', '中兴', '哈哈', 'dd', '9', '2018-04-14 10:14:22', '2018-04-14 10:14:22');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('66', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '618', '12', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:50:58', '2018-04-14 10:50:58');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('67', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '618', '12', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:50:58', '2018-04-14 10:50:58');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('68', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '626', '4', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:52:05', '2018-04-14 10:52:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('69', '2018-04-11', '师傅', '630', 'hhh', 'dddd', '607', '12', '6', '5', '13-0003', '中兴', '哈哈', '444', '9', '2018-04-14 10:54:42', '2018-04-14 10:54:42');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('70', '2018-04-11', '师傅', '630', 'hhh', 'dddd', '607', '12', '6', '5', '13-0003', '中兴', '哈哈', '444', '9', '2018-04-14 10:54:43', '2018-04-14 10:54:43');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('71', '2018-04-11', '师傅', '630', 'hhh', 'dddd', '607', '12', '6', '5', '13-0003', '中兴', '哈哈', '444', '9', '2018-04-14 10:54:44', '2018-04-14 10:54:44');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('72', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '618', '12', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:55:47', '2018-04-14 10:55:47');

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

-- ----------------------------
-- Records of t_ums_workflow_polish
-- ----------------------------
INSERT INTO `t_ums_workflow_polish` VALUES ('26', '2017-02-13', '2017-03-01', 'XC161216', '0000001534', 'Q1111', '10000', 'C', '13,24,55', '1534', '99.67', '0', 'XC161216', '09-0080', '102418121', null, '9', '2017-11-11 10:40:03', '2017-11-11 11:10:47');
INSERT INTO `t_ums_workflow_polish` VALUES ('27', '2017-01-31', '2017-03-01', 'XC161216', '0000001534', 'Q1230', '10001', 'B', '13,14,25', '1534', '100.00', '0', 'XC161216', '09-0080', '102418021', null, '9', '2017-11-11 11:00:54', '2017-11-22 10:48:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('28', '2017-02-13', '2017-03-01', 'XC161216', '0000001534', 'Q1047', '10003', 'B', '13,14,25', '1534', '99.87', '0', 'XC161216', '09-0080', '102418121', null, '9', '2017-11-11 11:10:31', '2017-11-11 11:11:05');
INSERT INTO `t_ums_workflow_polish` VALUES ('30', '2018-04-10', '2018-04-11', '998887', '0000000076', '9998888', '', 'A', '', '70', '100.00', '0', '9887', '13-0003', '8776', 'fggff', '9', '2018-04-07 20:50:20', '2018-04-07 20:50:20');
INSERT INTO `t_ums_workflow_polish` VALUES ('31', '2018-04-10', '2018-04-11', '998887', '0000000076', '9998888', '', 'A', '', '70', '100.00', '0', '9887', '13-0003', '8776', 'fggff', '9', '2018-04-07 20:53:34', '2018-04-07 20:53:34');
INSERT INTO `t_ums_workflow_polish` VALUES ('32', '2018-04-11', '2018-04-11', '9887', '0000000076', '8877', '', 'A', '', '10', '20.00', '0', '877', '13-0003', 'iuuuyy', 'fggff', '9', '2018-04-07 21:00:46', '2018-04-07 21:00:46');
INSERT INTO `t_ums_workflow_polish` VALUES ('33', '2018-04-11', '2018-04-11', '9887', '0000000076', '8877', '', 'A', '', '10', '20.00', '0', '877', '13-0003', 'iuuuyy', 'fggff', '9', '2018-04-07 21:00:50', '2018-04-07 21:00:50');
INSERT INTO `t_ums_workflow_polish` VALUES ('34', '2018-04-11', '2018-04-11', '9887', '0000000076', '8877', '', 'A', '', '10', '20.00', '0', '877', '13-0003', 'iuuuyy', 'fggff', '9', '2018-04-07 21:00:51', '2018-04-07 21:00:51');
INSERT INTO `t_ums_workflow_polish` VALUES ('35', '2018-04-11', '2018-04-11', '9887', '0000000076', '8877', '', 'A', '', '10', '20.00', '0', '877', '13-0003', 'iuuuyy', 'fggff', '9', '2018-04-07 21:00:52', '2018-04-07 21:00:52');
INSERT INTO `t_ums_workflow_polish` VALUES ('36', '2018-04-11', '2018-04-11', '9887', '0000000076', '8877', '', 'A', '', '10', '20.00', '0', '877', '13-0003', 'iuuuyy', 'fggff', '9', '2018-04-07 21:00:53', '2018-04-07 21:00:53');
INSERT INTO `t_ums_workflow_polish` VALUES ('37', '2018-04-11', '2018-04-11', '9887', '0000000076', '8877', '', 'A', '', '10', '20.00', '0', '877', '13-0003', 'iuuuyy', 'fggff', '9', '2018-04-07 21:00:53', '2018-04-07 21:00:53');
INSERT INTO `t_ums_workflow_polish` VALUES ('38', '2018-04-11', '2018-04-11', '9887', '0000000076', '8877', '', 'A', '', '10', '20.00', '0', '877', '13-0003', 'iuuuyy', 'fggff', '9', '2018-04-07 21:00:54', '2018-04-07 21:00:54');
INSERT INTO `t_ums_workflow_polish` VALUES ('39', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '100.00', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-07 22:33:47', '2018-04-08 22:28:51');
INSERT INTO `t_ums_workflow_polish` VALUES ('45', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '100.00', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 22:46:05', '2018-04-08 22:46:05');
INSERT INTO `t_ums_workflow_polish` VALUES ('46', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 22:57:23', '2018-04-08 22:57:23');
INSERT INTO `t_ums_workflow_polish` VALUES ('47', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 22:57:25', '2018-04-08 22:57:25');
INSERT INTO `t_ums_workflow_polish` VALUES ('48', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 22:57:25', '2018-04-08 22:57:25');
INSERT INTO `t_ums_workflow_polish` VALUES ('49', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:14', '2018-04-08 23:01:14');
INSERT INTO `t_ums_workflow_polish` VALUES ('50', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:14', '2018-04-08 23:01:14');
INSERT INTO `t_ums_workflow_polish` VALUES ('51', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:15', '2018-04-08 23:01:15');
INSERT INTO `t_ums_workflow_polish` VALUES ('52', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:15', '2018-04-08 23:01:15');
INSERT INTO `t_ums_workflow_polish` VALUES ('53', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:16', '2018-04-08 23:01:16');
INSERT INTO `t_ums_workflow_polish` VALUES ('54', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:16', '2018-04-08 23:01:16');
INSERT INTO `t_ums_workflow_polish` VALUES ('55', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:16', '2018-04-08 23:01:16');
INSERT INTO `t_ums_workflow_polish` VALUES ('56', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:16', '2018-04-08 23:01:16');
INSERT INTO `t_ums_workflow_polish` VALUES ('57', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:17', '2018-04-08 23:01:17');
INSERT INTO `t_ums_workflow_polish` VALUES ('58', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:17', '2018-04-08 23:01:17');
INSERT INTO `t_ums_workflow_polish` VALUES ('59', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:17', '2018-04-08 23:01:17');
INSERT INTO `t_ums_workflow_polish` VALUES ('60', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:18', '2018-04-08 23:01:18');
INSERT INTO `t_ums_workflow_polish` VALUES ('61', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:18', '2018-04-08 23:01:18');
INSERT INTO `t_ums_workflow_polish` VALUES ('62', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:18', '2018-04-08 23:01:18');
INSERT INTO `t_ums_workflow_polish` VALUES ('63', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:20', '2018-04-08 23:01:20');
INSERT INTO `t_ums_workflow_polish` VALUES ('64', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:21', '2018-04-08 23:01:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('65', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:21', '2018-04-08 23:01:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('66', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:21', '2018-04-08 23:01:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('67', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:22', '2018-04-08 23:01:22');
INSERT INTO `t_ums_workflow_polish` VALUES ('68', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:22', '2018-04-08 23:01:22');
INSERT INTO `t_ums_workflow_polish` VALUES ('69', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:23', '2018-04-08 23:01:23');
INSERT INTO `t_ums_workflow_polish` VALUES ('70', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:23', '2018-04-08 23:01:23');
INSERT INTO `t_ums_workflow_polish` VALUES ('71', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:23', '2018-04-08 23:01:23');
INSERT INTO `t_ums_workflow_polish` VALUES ('72', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:24', '2018-04-08 23:01:24');
INSERT INTO `t_ums_workflow_polish` VALUES ('73', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:24', '2018-04-08 23:01:24');
INSERT INTO `t_ums_workflow_polish` VALUES ('74', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:24', '2018-04-08 23:01:24');
INSERT INTO `t_ums_workflow_polish` VALUES ('75', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:25', '2018-04-08 23:01:25');
INSERT INTO `t_ums_workflow_polish` VALUES ('76', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:26', '2018-04-08 23:01:26');
INSERT INTO `t_ums_workflow_polish` VALUES ('77', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:27', '2018-04-08 23:01:27');
INSERT INTO `t_ums_workflow_polish` VALUES ('78', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:27', '2018-04-08 23:01:27');
INSERT INTO `t_ums_workflow_polish` VALUES ('79', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:27', '2018-04-08 23:01:27');
INSERT INTO `t_ums_workflow_polish` VALUES ('80', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:28', '2018-04-08 23:01:28');
INSERT INTO `t_ums_workflow_polish` VALUES ('81', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:28', '2018-04-08 23:01:28');
INSERT INTO `t_ums_workflow_polish` VALUES ('82', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:28', '2018-04-08 23:01:28');
INSERT INTO `t_ums_workflow_polish` VALUES ('83', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:29', '2018-04-08 23:01:29');
INSERT INTO `t_ums_workflow_polish` VALUES ('84', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:29', '2018-04-08 23:01:29');
INSERT INTO `t_ums_workflow_polish` VALUES ('85', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:30', '2018-04-08 23:01:30');
INSERT INTO `t_ums_workflow_polish` VALUES ('86', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:30', '2018-04-08 23:01:30');
INSERT INTO `t_ums_workflow_polish` VALUES ('87', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:30', '2018-04-08 23:01:30');
INSERT INTO `t_ums_workflow_polish` VALUES ('88', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:50', '2018-04-08 23:01:50');
INSERT INTO `t_ums_workflow_polish` VALUES ('89', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:50', '2018-04-08 23:01:50');
INSERT INTO `t_ums_workflow_polish` VALUES ('90', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:51', '2018-04-08 23:01:51');
INSERT INTO `t_ums_workflow_polish` VALUES ('91', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:51', '2018-04-08 23:01:51');
INSERT INTO `t_ums_workflow_polish` VALUES ('92', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:52', '2018-04-08 23:01:52');
INSERT INTO `t_ums_workflow_polish` VALUES ('93', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:52', '2018-04-08 23:01:52');
INSERT INTO `t_ums_workflow_polish` VALUES ('94', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:52', '2018-04-08 23:01:52');
INSERT INTO `t_ums_workflow_polish` VALUES ('95', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:53', '2018-04-08 23:01:53');
INSERT INTO `t_ums_workflow_polish` VALUES ('96', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:53', '2018-04-08 23:01:53');
INSERT INTO `t_ums_workflow_polish` VALUES ('97', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:53', '2018-04-08 23:01:53');
INSERT INTO `t_ums_workflow_polish` VALUES ('98', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:54', '2018-04-08 23:01:54');
INSERT INTO `t_ums_workflow_polish` VALUES ('99', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:54', '2018-04-08 23:01:54');
INSERT INTO `t_ums_workflow_polish` VALUES ('100', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:54', '2018-04-08 23:01:54');
INSERT INTO `t_ums_workflow_polish` VALUES ('101', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:54', '2018-04-08 23:01:54');
INSERT INTO `t_ums_workflow_polish` VALUES ('102', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:55', '2018-04-08 23:01:55');
INSERT INTO `t_ums_workflow_polish` VALUES ('103', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:55', '2018-04-08 23:01:55');
INSERT INTO `t_ums_workflow_polish` VALUES ('104', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:55', '2018-04-08 23:01:55');
INSERT INTO `t_ums_workflow_polish` VALUES ('105', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:56', '2018-04-08 23:01:56');
INSERT INTO `t_ums_workflow_polish` VALUES ('106', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:56', '2018-04-08 23:01:56');
INSERT INTO `t_ums_workflow_polish` VALUES ('107', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:57', '2018-04-08 23:01:57');
INSERT INTO `t_ums_workflow_polish` VALUES ('108', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:57', '2018-04-08 23:01:57');
INSERT INTO `t_ums_workflow_polish` VALUES ('109', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:58', '2018-04-08 23:01:58');
INSERT INTO `t_ums_workflow_polish` VALUES ('110', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:58', '2018-04-08 23:01:58');
INSERT INTO `t_ums_workflow_polish` VALUES ('111', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:58', '2018-04-08 23:01:58');
INSERT INTO `t_ums_workflow_polish` VALUES ('112', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:59', '2018-04-08 23:01:59');
INSERT INTO `t_ums_workflow_polish` VALUES ('113', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:59', '2018-04-08 23:01:59');
INSERT INTO `t_ums_workflow_polish` VALUES ('114', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:01:59', '2018-04-08 23:01:59');
INSERT INTO `t_ums_workflow_polish` VALUES ('115', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:00', '2018-04-08 23:02:00');
INSERT INTO `t_ums_workflow_polish` VALUES ('116', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:00', '2018-04-08 23:02:00');
INSERT INTO `t_ums_workflow_polish` VALUES ('117', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:00', '2018-04-08 23:02:00');
INSERT INTO `t_ums_workflow_polish` VALUES ('118', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:01', '2018-04-08 23:02:01');
INSERT INTO `t_ums_workflow_polish` VALUES ('119', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:01', '2018-04-08 23:02:01');
INSERT INTO `t_ums_workflow_polish` VALUES ('120', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:01', '2018-04-08 23:02:01');
INSERT INTO `t_ums_workflow_polish` VALUES ('121', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:02', '2018-04-08 23:02:02');
INSERT INTO `t_ums_workflow_polish` VALUES ('122', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:02', '2018-04-08 23:02:02');
INSERT INTO `t_ums_workflow_polish` VALUES ('123', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:03', '2018-04-08 23:02:03');
INSERT INTO `t_ums_workflow_polish` VALUES ('124', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:03', '2018-04-08 23:02:03');
INSERT INTO `t_ums_workflow_polish` VALUES ('125', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:04', '2018-04-08 23:02:04');
INSERT INTO `t_ums_workflow_polish` VALUES ('126', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:04', '2018-04-08 23:02:04');
INSERT INTO `t_ums_workflow_polish` VALUES ('127', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:05', '2018-04-08 23:02:05');
INSERT INTO `t_ums_workflow_polish` VALUES ('128', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:05', '2018-04-08 23:02:05');
INSERT INTO `t_ums_workflow_polish` VALUES ('129', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:05', '2018-04-08 23:02:05');
INSERT INTO `t_ums_workflow_polish` VALUES ('130', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:06', '2018-04-08 23:02:06');
INSERT INTO `t_ums_workflow_polish` VALUES ('131', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:06', '2018-04-08 23:02:06');
INSERT INTO `t_ums_workflow_polish` VALUES ('132', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:07', '2018-04-08 23:02:07');
INSERT INTO `t_ums_workflow_polish` VALUES ('133', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:07', '2018-04-08 23:02:07');
INSERT INTO `t_ums_workflow_polish` VALUES ('134', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:07', '2018-04-08 23:02:07');
INSERT INTO `t_ums_workflow_polish` VALUES ('135', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:07', '2018-04-08 23:02:07');
INSERT INTO `t_ums_workflow_polish` VALUES ('136', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:08', '2018-04-08 23:02:08');
INSERT INTO `t_ums_workflow_polish` VALUES ('137', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:08', '2018-04-08 23:02:08');
INSERT INTO `t_ums_workflow_polish` VALUES ('138', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '0', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-08 23:02:09', '2018-04-08 23:02:09');
INSERT INTO `t_ums_workflow_polish` VALUES ('139', '2018-04-07', '2018-04-02', 'jjkhh', '0000000675', 'hhh', '', 'C', '', '75', '69.33', '675', 'iiuyuy', '15-9008', 'lkjj', 'ddddsss', '9', '2018-04-10 18:41:41', '2018-04-11 14:02:33');

-- ----------------------------
-- View structure for menubuttonview
-- ----------------------------
DROP VIEW IF EXISTS `menubuttonview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menubuttonview` AS select `t_ums_menuinfo`.`MENUID` AS `menuid`,`t_ums_menuinfo`.`MENUNAME` AS `menuname`,1 AS `menutype`,`t_ums_menuinfo`.`PMENUID` AS `pmenuid` from `t_ums_menuinfo` union all select `f`.`btnid` AS `btnid`,`f`.`btncname` AS `btncname`,2 AS `menutype`,`f`.`menuid` AS `menuid` from `t_ums_menu_button` `f` where exists(select 1 from `t_ums_menuinfo` `d` where (`d`.`MENUID` = `f`.`menuid`)) ;

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

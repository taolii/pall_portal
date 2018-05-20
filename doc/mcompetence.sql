/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : mcompetence

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-20 11:19:32
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
INSERT INTO `t_ums_admininfo` VALUES ('9', '超级管理员', 'admin', 'admin', '1', '', null, '13816763234', '13434@1632', null, null, '1', '2', '1', '2017-07-08 00:55:55', '2018-05-20 10:35:28');
INSERT INTO `t_ums_admininfo` VALUES ('13', 'test', 'test', '', '女', '', null, '13816763233', '13816763233@163.com', '', '', '2', '2', '1', '2017-11-21 23:14:53', '2017-12-13 21:43:32');
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
INSERT INTO `t_ums_config` VALUES ('18', 'platedFilm/tablename', '1', 'platedfilmtable204', null, '2', '化学镀膜流程配置表名');
INSERT INTO `t_ums_config` VALUES ('19', 'platedFilm/download/subdirectory', '1', 'platedFilm', null, '2', '化学镀膜管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('20', 'polish/dataconfig/type/defect/workingface', '1', '171', null, '2', '抛光表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('21', 'polish/dataconfig/type/defect/noworkingface', '1', '172', null, '2', '抛光表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('22', 'dataconfig/type/scrapinfo', '1', '22', null, '2', '数据配置表代表scrap info的配置类型');
INSERT INTO `t_ums_config` VALUES ('23', 'assembly/dataconfig/type/defect', '1', '5', null, '2', '数据配置表代表组装 defect的配置类型');
INSERT INTO `t_ums_config` VALUES ('24', 'assembly/tablename', '1', 'assemblytable205', null, '2', '组装流程配置表名');
INSERT INTO `t_ums_config` VALUES ('25', 'assembly/dataconfig/type/workingface', '1', '201', null, '2', '组装表工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('26', 'assembly/dataconfig/type/noworkingface', '1', '202', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('27', 'assembly/download/subdirectory', '1', 'assembly', null, '2', '组装管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('28', 'dataconfig/type/remark', '1', '93', null, '2', '数据配置表代表remark的配置类型');
INSERT INTO `t_ums_config` VALUES ('29', 'chemicalReagent/dataconfig/type/chemicalReagent', '1', '16', null, '2', '数据配置表代表化学试剂配置类型');
INSERT INTO `t_ums_config` VALUES ('30', 'chemicalReagent/tablename', '1', 'chemicalreagenttable206', null, '2', '化学试剂流程配置表名');
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
INSERT INTO `t_ums_config` VALUES ('42', 'reagentMixture/dataconfig/type/mainReagent', '1', '27', null, '2', '混合试剂主试剂在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('43', 'reagentMixture/tablename', '1', 'reagentmixturetable209', null, '2', '混合试剂主试剂配置表名');
INSERT INTO `t_ums_config` VALUES ('44', 'chemicalReagent/dataconfig/type/bioBom', '1', '28', null, '2', '生物镀膜BIO BOM在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('45', 'chemicalReagent/dataconfig/type/bioPatNum', '1', '29', null, '2', '生物镀膜BIO Pat Number在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('46', 'chemicalReagent/dataconfig/type/crOperator1', '1', '30', null, '2', '生物镀膜操作人员1在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('47', 'chemicalReagent/dataconfig/type/crOperator2', '1', '31', null, '2', '生物镀膜操作人员2在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('48', 'chemicalReagent/dataconfig/type/rawMaterial', '1', '32', null, '2', '生物镀膜FIBER RAW MATERIAL在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('49', 'chemicalReagent/dataconfig/type/coatingStation', '1', '33', null, '2', '生物镀膜Coating Station在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('50', 'reagentMixture/dataconfig/type/subReagent', '1', '34', null, '2', '混合试剂子试剂在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('51', 'platedFilm/dataconfig/type/sfBomNum', '1', '35', null, '2', '数据配置表代表sfBomNum的配置类型');
INSERT INTO `t_ums_config` VALUES ('52', 'platedFilm/dataconfig/type/apsCondition', '1', '36', null, '2', '数据配置表代表apsCondition的配置类型');
INSERT INTO `t_ums_config` VALUES ('53', 'opticalFilmingSel/tablename', '1', 'selopticalfilmingtable208', null, '2', '选择光学镀膜配置表名');
INSERT INTO `t_ums_config` VALUES ('54', 'platedFilm/dataconfig/type/fixtureAttribute', '1', '37', null, '2', '数据配置表代表fixture属性的配置类型');
INSERT INTO `t_ums_config` VALUES ('55', 'assembly/dataconfig/type/clamping', '1', '203', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('56', 'assembly/dataconfig/type/installHub', '1', '204', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('57', 'assembly/dataconfig/type/other', '1', '205', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('58', 'assembly/dataconfig/type/clampingCP', '1', '39', null, '2', ' 组装表装夹操作员在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('59', 'assembly/dataconfig/type/clampDownTheCP', '1', '40', null, '2', ' 组装表拆夹操作员在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('60', 'assembly/dataconfig/type/assemblyBoms', '1', '38', null, '2', ' 组装表Assembly bom在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('61', 'twicechemicalReagent/dataconfig/type/bioBom', '1', '28', null, '2', '二次生物镀膜BIO BOM在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('62', 'twicechemicalReagent/dataconfig/type/bioPatNum', '1', '29', null, '2', '二次生物镀膜BIO Pat Number在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('63', 'twicechemicalReagent/dataconfig/type/crOperator1', '1', '30', null, '2', '二次生物镀膜操作人员1在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('64', 'twicechemicalReagent/dataconfig/type/crOperator2', '1', '31', null, '2', '二次生物镀膜操作人员2在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('65', 'twicechemicalReagent/dataconfig/type/rawMaterial', '1', '32', null, '2', '二次生物镀膜FIBER RAW MATERIAL在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('66', 'twicechemicalReagent/dataconfig/type/coatingStation', '1', '33', null, '2', '二次生物镀膜Coating Station在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('67', 'twicechemicalReagent/dataconfig/type/chemicalReagent', '1', '16', null, '2', '数据配置表代表化学试剂配置类型');
INSERT INTO `t_ums_config` VALUES ('68', 'twicechemicalReagent/tablename', '1', 'twicechemicalreagenttable207', null, '2', '二次生物镀膜流程配置表名');
INSERT INTO `t_ums_config` VALUES ('69', 'twicechemicalReagent/download/subdirectory', '1', 'twicechemicalReagent', null, '2', '二次生物镀膜管理页面excel下载子目录名称');

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
INSERT INTO `t_ums_data_button` VALUES ('63', '207', 'btn-add', '添加', 'btn btn-primary btn-sm', 'fa fa-plus', '2', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('64', '207', 'btn-delAll', '批量删除', 'btn btn-primary btn-sm', 'fa fa-remove', '2', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('65', '207', 'btn-export', '导出', 'btn btn-primary btn-sm', 'fa fa-download', '2', '3', null);
INSERT INTO `t_ums_data_button` VALUES ('66', '207', 'btn_refresh', '刷新', 'btn btn-primary btn-sm', 'fa fa-refresh', '2', '4', null);
INSERT INTO `t_ums_data_button` VALUES ('67', '207', 'copyRow', '复制', 'btn btn-primary btn-xs', 'fa fa-copy', '3', '1', null);
INSERT INTO `t_ums_data_button` VALUES ('68', '207', 'editRow', '修改', 'btn btn-primary btn-xs', 'fa fa-edit', '3', '2', null);
INSERT INTO `t_ums_data_button` VALUES ('69', '207', 'delRow', '删除', 'btn btn-primary btn-xs', 'fa fa-trash-o', '3', '3', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=370 DEFAULT CHARSET=utf8 COMMENT='数据字典配置表';

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
INSERT INTO `t_ums_data_config` VALUES ('27', '1', '混合试剂主试剂', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('28', '1', 'BIO BOM', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('29', '1', 'BIO Pat Number ', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('30', '1', '操作人员1', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('31', '1', '操作人员2', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('32', '1', 'FIBER RAW MATERIAL', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('33', '1', 'Coating Station', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('34', '1', '混合试剂子试剂', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('35', '1', 'SF BOM', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('36', '1', 'APS condition', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('37', '1', 'Fixture属性', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('38', '1', 'Assembly Bom', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('39', '1', '装夹工作人员', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('40', '1', '拆夹工作人员', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('166', '11', 'A', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('167', '11', 'B', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('168', '11', 'C', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('169', '16', '05-0001|04-0001', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('170', '16', '05-0003|03-0001', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('171', '16', '05-0002|04-0002', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('172', '16', '05-0002|05-0067', '', '9', null, null);
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
INSERT INTO `t_ums_data_config` VALUES ('200', '201', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('202', '201', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('204', '202', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('205', '202', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('206', '202', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('207', '202', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('213', '171', '麻点', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('214', '171', '崩边', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('215', '171', '划痕', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('216', '171', '异物', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('217', '171', '印迹', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('218', '171', '其它', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('220', '171', '水印', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('221', '171', '缝隙', 'Polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('222', '171', '胶', 'polishing', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('223', '172', '崩边', '', '9', null, '2018-05-12 06:06:35');
INSERT INTO `t_ums_data_config` VALUES ('224', '172', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('225', '172', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('226', '172', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('227', '172', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('228', '172', '麻点', '', '9', null, '2018-05-12 06:07:08');
INSERT INTO `t_ums_data_config` VALUES ('229', '172', '水印', '', '9', null, '2018-05-12 06:07:18');
INSERT INTO `t_ums_data_config` VALUES ('230', '172', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('231', '172', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('232', '181', '麻点', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('233', '181', '水印', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('234', '181', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('238', '181', '印迹', '', '9', null, null);
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
INSERT INTO `t_ums_data_config` VALUES ('290', '24', '华为', '', '9', '2018-04-13 13:49:39', '2018-04-13 13:49:39');
INSERT INTO `t_ums_data_config` VALUES ('291', '24', '中兴', '', '9', '2018-04-13 13:49:46', '2018-04-13 13:49:46');
INSERT INTO `t_ums_data_config` VALUES ('292', '25', '的地方法规', '', '9', '2018-04-14 00:18:49', '2018-04-14 00:18:49');
INSERT INTO `t_ums_data_config` VALUES ('293', '25', '哈哈', '', '9', '2018-04-14 00:18:57', '2018-04-14 00:18:57');
INSERT INTO `t_ums_data_config` VALUES ('294', '26', 'SF Bom1', 'SFBom1', '9', '2018-04-22 21:34:35', '2018-04-22 21:34:35');
INSERT INTO `t_ums_data_config` VALUES ('295', '27', '04-0001', '', '9', '2018-04-21 23:31:46', '2018-04-21 23:31:46');
INSERT INTO `t_ums_data_config` VALUES ('296', '27', '04-0002', '', '9', '2018-04-21 23:31:53', '2018-04-21 23:31:53');
INSERT INTO `t_ums_data_config` VALUES ('297', '27', '04-0003', '', '9', '2018-04-21 23:32:02', '2018-04-21 23:32:02');
INSERT INTO `t_ums_data_config` VALUES ('298', '28', 'BIOBOM1', '', '9', '2018-04-25 22:21:58', '2018-04-25 22:21:58');
INSERT INTO `t_ums_data_config` VALUES ('299', '28', 'BIOBOM2', '', '9', '2018-04-25 22:22:04', '2018-04-25 22:22:04');
INSERT INTO `t_ums_data_config` VALUES ('300', '28', 'BIOBOM3', '', '9', '2018-04-25 22:22:09', '2018-04-25 22:22:09');
INSERT INTO `t_ums_data_config` VALUES ('301', '29', 'BIOPATNUM1', '', '9', '2018-04-25 22:22:32', '2018-04-25 22:22:32');
INSERT INTO `t_ums_data_config` VALUES ('302', '29', 'BIOPATNUM2', '', '9', '2018-04-25 22:22:38', '2018-04-25 22:22:38');
INSERT INTO `t_ums_data_config` VALUES ('303', '29', 'BIOPATNUM3', '', '9', '2018-04-25 22:22:44', '2018-04-25 22:22:44');
INSERT INTO `t_ums_data_config` VALUES ('304', '30', 'CP1', '', '9', '2018-04-25 22:23:04', '2018-04-25 22:23:04');
INSERT INTO `t_ums_data_config` VALUES ('305', '30', 'CP2', '', '9', '2018-04-25 22:23:09', '2018-04-25 22:23:09');
INSERT INTO `t_ums_data_config` VALUES ('306', '30', 'CP3', '', '9', '2018-04-25 22:23:15', '2018-04-25 22:23:15');
INSERT INTO `t_ums_data_config` VALUES ('307', '31', 'CP2', '', '9', '2018-04-25 22:23:29', '2018-04-25 22:23:29');
INSERT INTO `t_ums_data_config` VALUES ('308', '31', 'CP23', '', '9', '2018-04-25 22:23:37', '2018-04-25 22:23:37');
INSERT INTO `t_ums_data_config` VALUES ('309', '31', 'CP24', '', '9', '2018-04-25 22:23:44', '2018-04-25 22:23:44');
INSERT INTO `t_ums_data_config` VALUES ('310', '32', 'FRM1', '', '9', '2018-04-25 22:23:58', '2018-04-25 22:23:58');
INSERT INTO `t_ums_data_config` VALUES ('311', '32', 'FRM2', '', '9', '2018-04-25 22:24:04', '2018-04-25 22:24:04');
INSERT INTO `t_ums_data_config` VALUES ('312', '32', 'FRM3', '', '9', '2018-04-25 22:24:09', '2018-04-25 22:24:09');
INSERT INTO `t_ums_data_config` VALUES ('313', '33', 'CS1', '', '9', '2018-04-25 22:24:18', '2018-04-25 22:24:18');
INSERT INTO `t_ums_data_config` VALUES ('314', '33', 'CS2', '', '9', '2018-04-25 22:24:22', '2018-04-25 22:24:22');
INSERT INTO `t_ums_data_config` VALUES ('315', '33', 'CS3', '', '9', '2018-04-25 22:24:27', '2018-04-25 22:24:27');
INSERT INTO `t_ums_data_config` VALUES ('316', '34', '01-0001', '', '9', '2018-04-27 10:22:35', '2018-04-27 10:22:35');
INSERT INTO `t_ums_data_config` VALUES ('317', '34', '01-0002', '', '9', '2018-04-27 10:22:43', '2018-04-27 10:22:43');
INSERT INTO `t_ums_data_config` VALUES ('318', '34', '01-0003', '', '9', '2018-04-27 10:22:50', '2018-04-27 10:22:50');
INSERT INTO `t_ums_data_config` VALUES ('319', '34', '01-0004', '', '9', '2018-04-27 10:22:59', '2018-04-27 10:22:59');
INSERT INTO `t_ums_data_config` VALUES ('320', '34', '01-0005', '', '9', '2018-04-27 10:23:06', '2018-04-27 10:23:06');
INSERT INTO `t_ums_data_config` VALUES ('321', '34', '02-0001', '', '9', '2018-04-27 10:23:37', '2018-04-27 10:23:37');
INSERT INTO `t_ums_data_config` VALUES ('322', '34', '02-0002', '', '9', '2018-04-27 10:23:44', '2018-04-27 10:23:44');
INSERT INTO `t_ums_data_config` VALUES ('323', '12', '09-0080', '', '9', '2018-05-12 05:25:32', '2018-05-12 05:25:32');
INSERT INTO `t_ums_data_config` VALUES ('324', '181', '崩边', '', '9', '2018-05-12 06:05:27', '2018-05-12 06:05:27');
INSERT INTO `t_ums_data_config` VALUES ('325', '22', '棉纱', '', '9', '2018-05-12 06:12:27', '2018-05-12 06:12:27');
INSERT INTO `t_ums_data_config` VALUES ('326', '181', '棉纱', '', '9', '2018-05-12 06:12:45', '2018-05-12 06:12:45');
INSERT INTO `t_ums_data_config` VALUES ('327', '181', '划痕', '', '9', '2018-05-12 06:13:28', '2018-05-12 06:13:28');
INSERT INTO `t_ums_data_config` VALUES ('328', '181', '异物', '', '9', '2018-05-12 06:14:48', '2018-05-12 06:14:48');
INSERT INTO `t_ums_data_config` VALUES ('329', '192', '彩虹到芯', '', '9', '2018-05-12 06:26:01', '2018-05-12 06:26:01');
INSERT INTO `t_ums_data_config` VALUES ('330', '192', '绿膜', '', '9', '2018-05-12 06:26:09', '2018-05-12 06:26:09');
INSERT INTO `t_ums_data_config` VALUES ('331', '192', '膜下异物', '', '9', '2018-05-12 06:26:24', '2018-05-12 06:26:24');
INSERT INTO `t_ums_data_config` VALUES ('332', '22', '缝隙', '', '9', '2018-05-12 06:30:35', '2018-05-12 06:30:35');
INSERT INTO `t_ums_data_config` VALUES ('333', '192', '缝隙', '', '9', '2018-05-12 06:30:56', '2018-05-12 06:30:56');
INSERT INTO `t_ums_data_config` VALUES ('334', '202', '印迹', '', '9', '2018-05-12 06:35:39', '2018-05-12 06:35:39');
INSERT INTO `t_ums_data_config` VALUES ('335', '202', '绿膜', '', '9', '2018-05-12 06:36:01', '2018-05-12 06:36:01');
INSERT INTO `t_ums_data_config` VALUES ('336', '202', '彩虹到芯', '', '9', '2018-05-12 06:36:59', '2018-05-12 06:36:59');
INSERT INTO `t_ums_data_config` VALUES ('337', '202', '膜下异物', '', '9', '2018-05-12 06:37:10', '2018-05-12 06:37:10');
INSERT INTO `t_ums_data_config` VALUES ('338', '202', '膜层脱落', '', '9', '2018-05-12 06:37:15', '2018-05-12 06:37:15');
INSERT INTO `t_ums_data_config` VALUES ('339', '202', '缝隙', '', '9', '2018-05-12 06:37:24', '2018-05-12 06:37:24');
INSERT INTO `t_ums_data_config` VALUES ('340', '202', '其它', '', '9', '2018-05-12 06:37:38', '2018-05-12 06:37:38');
INSERT INTO `t_ums_data_config` VALUES ('341', '201', '崩边', '', '9', '2018-05-12 06:41:14', '2018-05-12 06:41:14');
INSERT INTO `t_ums_data_config` VALUES ('342', '201', '异物', '', '9', '2018-05-12 06:41:19', '2018-05-12 06:41:19');
INSERT INTO `t_ums_data_config` VALUES ('343', '201', '胶', '', '9', '2018-05-12 06:41:29', '2018-05-12 06:41:29');
INSERT INTO `t_ums_data_config` VALUES ('344', '201', '印迹', '', '9', '2018-05-12 06:41:34', '2018-05-12 06:41:34');
INSERT INTO `t_ums_data_config` VALUES ('345', '201', '高低', '', '9', '2018-05-12 06:41:41', '2018-05-12 06:41:41');
INSERT INTO `t_ums_data_config` VALUES ('346', '201', '装反', '', '9', '2018-05-12 06:41:51', '2018-05-12 06:41:51');
INSERT INTO `t_ums_data_config` VALUES ('347', '201', '破点', '', '9', '2018-05-12 06:42:00', '2018-05-12 06:42:00');
INSERT INTO `t_ums_data_config` VALUES ('348', '12', '09-0071', '', '9', '2018-05-12 06:43:26', '2018-05-12 06:43:26');
INSERT INTO `t_ums_data_config` VALUES ('349', '12', '12-0003', '', '9', '2018-05-12 07:50:06', '2018-05-12 07:50:06');
INSERT INTO `t_ums_data_config` VALUES ('350', '37', 'Q', '', '9', '2018-05-13 22:40:23', '2018-05-13 22:40:23');
INSERT INTO `t_ums_data_config` VALUES ('351', '37', 'K', '', '9', '2018-05-13 22:40:29', '2018-05-13 22:40:29');
INSERT INTO `t_ums_data_config` VALUES ('352', '36', 'APS Condition1', '', '9', '2018-05-13 23:16:14', '2018-05-13 23:16:14');
INSERT INTO `t_ums_data_config` VALUES ('353', '36', 'APS Condition2', '', '9', '2018-05-13 23:16:20', '2018-05-13 23:16:20');
INSERT INTO `t_ums_data_config` VALUES ('354', '36', 'APS Condition3', '', '9', '2018-05-13 23:16:24', '2018-05-13 23:16:24');
INSERT INTO `t_ums_data_config` VALUES ('355', '35', 'SF BOM1', '', '9', '2018-05-13 23:16:49', '2018-05-13 23:16:49');
INSERT INTO `t_ums_data_config` VALUES ('356', '35', 'SF BOM2', '', '9', '2018-05-13 23:16:54', '2018-05-13 23:16:54');
INSERT INTO `t_ums_data_config` VALUES ('357', '35', 'SF BOM3', '', '9', '2018-05-13 23:17:00', '2018-05-13 23:17:00');
INSERT INTO `t_ums_data_config` VALUES ('358', '203', '其它', '', '9', '2018-05-14 21:49:53', '2018-05-14 21:49:53');
INSERT INTO `t_ums_data_config` VALUES ('359', '204', '其它', '', '9', '2018-05-14 21:50:10', '2018-05-14 21:50:10');
INSERT INTO `t_ums_data_config` VALUES ('360', '205', '其它', '', '9', '2018-05-14 21:50:34', '2018-05-14 21:50:34');
INSERT INTO `t_ums_data_config` VALUES ('361', '38', 'Assembly Bom1', '', '9', '2018-05-15 01:27:21', '2018-05-15 01:27:21');
INSERT INTO `t_ums_data_config` VALUES ('362', '38', 'Assembly Bom2', '', '9', '2018-05-15 01:27:31', '2018-05-15 01:27:31');
INSERT INTO `t_ums_data_config` VALUES ('363', '38', 'Assembly Bom3', '', '9', '2018-05-15 01:27:43', '2018-05-15 01:27:43');
INSERT INTO `t_ums_data_config` VALUES ('364', '40', '拆夹工作人员1', '', '9', '2018-05-15 01:28:22', '2018-05-15 01:28:22');
INSERT INTO `t_ums_data_config` VALUES ('365', '40', '拆夹工作人员2', '', '9', '2018-05-15 01:28:32', '2018-05-15 01:28:32');
INSERT INTO `t_ums_data_config` VALUES ('366', '40', '拆夹工作人员3', '', '9', '2018-05-15 01:28:42', '2018-05-15 01:28:42');
INSERT INTO `t_ums_data_config` VALUES ('367', '39', '装夹工作人员1', '', '9', '2018-05-15 01:29:13', '2018-05-15 01:29:13');
INSERT INTO `t_ums_data_config` VALUES ('368', '39', '装夹工作人员2', '', '9', '2018-05-15 01:29:23', '2018-05-15 01:29:23');
INSERT INTO `t_ums_data_config` VALUES ('369', '39', '装夹工作人员3', '', '9', '2018-05-15 01:29:33', '2018-05-15 01:29:33');

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
INSERT INTO `t_ums_menuinfo` VALUES ('103', '角色管理', 'menu-icon glyphicon glyphicon-asterisk', '/role/roleManage', '1', '1', '1', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('104', '权限配置管理', 'menu-icon glyphicons \r\nglyphicons-user', '/right/rightManage', '1', '1', '1', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('105', '菜单管理', 'menu-icon glyphicon glyphicon-eye-open', '/menu/menuManage', '1', '1', '1', '5', null);
INSERT INTO `t_ums_menuinfo` VALUES ('106', '缺损管理', 'menu-icon glyphicon glyphicon-book', '/defect/defectManage', '1', '0', '1', '6', null);
INSERT INTO `t_ums_menuinfo` VALUES ('107', '数据配置管理', 'menu-icon glyphicon glyphicons-settings', '/dataconfig/dataConfigManage', '1', '0', '1', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('108', '按钮管理', 'menu-icon glyphicon glyphicon-eye-open', '/button/buttonManage', '1', '1', '1', '8', '');
INSERT INTO `t_ums_menuinfo` VALUES ('109', '试剂混合', 'menu-icon glyphicons glyphicon-tint', '/reagent/reagentMixtureManage', '1', '0', '1', '9', '');
INSERT INTO `t_ums_menuinfo` VALUES ('201', '抛磨', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/polishManage', '1', '0', '2', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('202', '清洗', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/cleanManage', '1', '0', '2', '2', null);
INSERT INTO `t_ums_menuinfo` VALUES ('203', '光学镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/opticalFilmingManage', '1', '0', '2', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('204', '化学镀膜APS', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/platedFilmManage', '1', '0', '2', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('205', '组装', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/assemblyManage', '1', '0', '2', '6', null);
INSERT INTO `t_ums_menuinfo` VALUES ('206', '生化镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/chemicalReagentManage', '1', '0', '2', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('207', '二次生化镀膜', 'menu-icon glyphicons glyphicons-hand-right', '/workflow/twiceChemicalReagentManage', '1', '0', '2', '8', '');

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
-- Table structure for t_ums_reagentmixture
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_reagentmixture`;
CREATE TABLE `t_ums_reagentmixture` (
  `rmid` bigint(22) NOT NULL AUTO_INCREMENT COMMENT '试剂编号',
  `config_time` datetime NOT NULL COMMENT '配置时间',
  `main_reagent` varchar(50) NOT NULL DEFAULT '' COMMENT '主试剂',
  `rev` varchar(100) DEFAULT '' COMMENT 'Rev',
  `lot_num` varchar(20) DEFAULT '' COMMENT 'LOT#',
  `wo_num` varchar(30) DEFAULT '' COMMENT 'WO#',
  `amount` int(10) DEFAULT NULL COMMENT 'Amount(mg)',
  `ph_value` varchar(20) DEFAULT '' COMMENT 'PH值',
  `concentration` varchar(20) DEFAULT '' COMMENT '浓度',
  `temperature_up_starttime` datetime DEFAULT NULL COMMENT '回温开始时间',
  `temperature_up_endtime` datetime DEFAULT NULL COMMENT '回温结束时间',
  `reagent_temperature` varchar(20) NOT NULL DEFAULT '' COMMENT '试剂温度',
  `config_operator` varchar(20) NOT NULL DEFAULT '' COMMENT '试剂配制操作员',
  `reserver1` varchar(200) NOT NULL DEFAULT '' COMMENT '备注1',
  `reserver2` varchar(200) NOT NULL DEFAULT '' COMMENT '备注2',
  `reserver3` varchar(200) NOT NULL DEFAULT '' COMMENT '备注3',
  `CREATETIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATETIME` datetime DEFAULT NULL COMMENT '状态变更时间',
  `OPERATORID` bigint(22) NOT NULL COMMENT '操作员编号',
  PRIMARY KEY (`rmid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='试剂混合表';

-- ----------------------------
-- Records of t_ums_reagentmixture
-- ----------------------------
INSERT INTO `t_ums_reagentmixture` VALUES ('1', '2018-05-16 00:00:00', '04-0001', 'A', 'CM0010100528', '10052601', '22', null, null, null, null, '', '', '', '', '', '2018-05-16 03:50:44', '2018-05-16 03:50:44', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('2', '2018-05-16 00:00:00', '04-0001', 'A', 'CM0010100529', '10052602', '22', null, null, null, null, '', '', '', '', '', '2018-05-16 03:51:02', '2018-05-16 03:51:02', '9');

-- ----------------------------
-- Table structure for t_ums_reagentmixture_sns
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_reagentmixture_sns`;
CREATE TABLE `t_ums_reagentmixture_sns` (
  `srmid` int(11) NOT NULL AUTO_INCREMENT,
  `rmid` int(11) NOT NULL COMMENT '试剂编号',
  `reagents_field_name` varchar(50) DEFAULT NULL,
  `main_reagent` varchar(100) DEFAULT NULL,
  `reagents_name` varchar(100) DEFAULT NULL COMMENT '试剂名称',
  `reagents_sn` varchar(100) DEFAULT NULL COMMENT '试剂编号',
  PRIMARY KEY (`srmid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='试剂编号表';

-- ----------------------------
-- Records of t_ums_reagentmixture_sns
-- ----------------------------
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('1', '0', 'reagentmixturetable209322', null, '02-0002', 'jjhgff');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('2', '0', 'reagentmixturetable209320', null, '01-0005', 'iiuhgg');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('3', '0', 'reagentmixturetable209319', null, '01-0004', 'kkjhg');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('4', '0', 'reagentmixturetable209317', null, '01-0002', 'kkjhg');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('5', '0', 'reagentmixturetable209322', null, '02-0002', 'jjhgff');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('6', '0', 'reagentmixturetable209320', null, '01-0005', 'iiuhgg');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('7', '0', 'reagentmixturetable209319', null, '01-0004', 'kkjhg');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('8', '0', 'reagentmixturetable209317', null, '01-0002', 'kkjhg');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('9', '1', 'reagentmixturetable209316', '04-0001', '01-0001', 'KD132279');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('10', '1', 'reagentmixturetable209318', '04-0001', '01-0003', 'JF124222');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('11', '2', 'reagentmixturetable209316', '04-0001', '01-0001', 'KD132278');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('12', '2', 'reagentmixturetable209318', '04-0001', '01-0003', 'JF124228');

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
INSERT INTO `t_ums_right` VALUES ('18', '1', '109', null);
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
INSERT INTO `t_ums_rolepermission` VALUES ('18', '1');

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
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '4', null, '3', '1', null, 'fixtureNumber', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '5', null, '3', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '6', null, '3', '1', null, 'cleanBom', '0', 'Clean BOM', null);
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
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '16', null, '2', '1', null, 'supplier', '0', '供应商', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '17', null, '2', '1', null, 'ocBom', '0', 'Optical Coating BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '18', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '19', null, '2', '1', null, null, '2', '操作', null);
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
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '15', null, '4', '1', null, 'outputQty', '1', 'outputQty', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '16', null, '4', '1', null, 'measuredValues', '0', '测量值', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '17', null, '4', '1', null, 'partNum', '0', 'Part NO', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '18', null, '4', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '19', null, '4', '1', null, 'polishBom', '0', 'Polish Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '20', null, '4', '1', null, 'operatorName', '3', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '21', null, '4', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '2', null, '2', '1', null, 'assemblyID', '1', 'assemblyID', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '3', null, '2', '1', null, 'deliveryTime', '0', 'delivery Date', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '4', null, '2', '1', null, 'trayLotNum', '0', 'TRAY#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '5', null, '2', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '6', null, '2', '1', null, 'inputQty', '0', 'Input Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '7', null, '2', '1', null, 'fixtureNum', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '8', null, '2', '1', null, 'hubLotNum', '0', 'HUB Lot#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '9', null, '2', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '10', null, '2', '1', null, 'outputQty', '0', 'output Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '11', null, '2', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '12', null, '1', '1', null, null, '3', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '13', null, '1', '1', null, null, '3', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '14', null, '1', '1', null, null, '3', '拆夹', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '15', null, '1', '1', null, null, '3', '装HUB', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '16', null, '1', '1', null, null, '3', '其它', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '17', null, '2', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '18', null, '2', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '19', null, '2', '1', null, 'clampingCP', '0', '装夹工作人员', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '20', null, '2', '1', null, 'clampDownTheCP', '0', '拆夹工作人员', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '21', null, '2', '1', null, 'assemblyBoms', '0', 'Assembly Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '22', null, '2', '1', null, 'operatorName', '3', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '23', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '2', '12', '1', '1', '1', '201', null, '3', null, null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '2', '13', null, '1', '1', '202', null, '3', null, null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '2', '14', null, '1', '1', '203', null, '3', null, null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '2', '15', null, '1', '1', '204', null, '3', null, null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '2', '16', null, '1', '1', '205', null, '3', null, null);
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
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '1', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '2', null, '1', '1', null, 'rmid', '0', '试剂编号', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '3', null, '1', '1', null, 'configTime', '0', '配置时间', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '4', null, '1', '1', null, 'mainReagent', '0', '主试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '5', null, '1', '1', null, 'rev', '0', 'Rev', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '6', null, '1', '1', null, 'lotNum', '0', 'LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '7', null, '1', '1', null, 'woNum', '0', 'WO#', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '8', null, '1', '1', null, 'amount', '0', 'Amount(mg)', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '10', null, '1', '1', null, 'phValue', '0', 'PH值', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '11', null, '1', '1', null, 'concentration', '0', '浓度', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '12', null, '1', '1', null, 'temperatureUpStarttime', '0', '回温开始时间', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '13', null, '1', '1', null, 'temperatureUpEndtime', '0', '回温结束时间', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '14', null, '1', '1', null, 'reagentTemperature', '0', '试剂温度', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '15', null, '1', '1', null, 'configOperator', '0', '试剂配制操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '16', null, '1', '1', null, 'reserver1', '0', '备注1', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '17', null, '1', '1', null, 'reserver2', '0', '备注2', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '18', null, '1', '1', null, 'reserver3', '0', '备注3', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '19', null, '1', '1', null, null, '0', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '2', null, '2', '1', null, 'crID', '1', 'crID', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '3', null, '2', '1', null, 'lot', '0', 'Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '4', null, '2', '1', null, 'reagentMixture', '2', '混合试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '5', null, '2', '1', null, 'trayLotNums', '0', '18-####Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '7', null, '2', '1', null, 'apsLotNums', '0', 'APS Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '8', null, '2', '1', null, 'ocLotNums', '0', 'OP.Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '11', null, '1', '2', null, null, '0', 'Fiber', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '13', null, '2', '1', null, 'coatingStation', '0', 'Coating Station', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '14', null, '2', '1', null, 'crOperator1', '0', '生化镀膜作业人员1', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '15', null, '2', '1', null, 'crOperator2', '0', '生化镀膜作业人员2', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '16', null, '2', '1', null, 'docRev', '0', '版本', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '17', null, '2', '1', null, 'auxiliaryReagent1', '0', '03-0018 or 03-0067 KB', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '18', null, '2', '1', null, 'auxiliaryReagent2', '0', '05-0079 1ug/ml BPA', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '19', null, '2', '1', null, 'auxiliaryReagent3', '0', '05-0080 6ug/ml HIgG', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '20', null, '2', '1', null, 'polishBoms', '0', 'POLISH BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '22', null, '2', '1', null, 'ocBoms', '0', '光学BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '23', null, '2', '1', null, 'apsBoms', '0', 'APS BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '24', null, '2', '1', null, 'assemblyBoms', '0', '组装 BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '25', null, '2', '1', null, 'bioBom', '0', '生物镀膜 BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '26', null, '2', '1', null, 'goodsQty', '0', 'Goods', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '27', null, '2', '1', null, 'inputQty', '0', 'Input', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '28', null, '2', '1', null, 'theoryYield', '0', 'theoretical Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '29', null, '2', '1', null, 'actualYield', '0', 'actual Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '30', null, '2', '1', null, 'theoryActualYield', '0', 'theoretical VS actual', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '31', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '32', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '2', '11', null, '1', '1', null, 'rawMaterial', '0', 'Raw Material', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '2', '12', null, '1', '1', null, 'inPutDate', '0', 'In Put Date', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '21', null, '2', '1', null, 'cleanBoms', '0', 'Clean BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '9', null, '2', '1', null, 'cleanLotNums', '0', 'Clean Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '10', null, '2', '1', null, 'polishLotNums', '0', 'Polish Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '6', null, '2', '1', null, 'tLotNums', '0', 'T#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '2', null, '2', '1', null, 'opfID', '1', 'opfID', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '3', null, '2', '1', null, 'optTime', '0', 'Date', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '4', null, '2', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '5', null, '2', '1', null, 'inputQty', '0', 'Input Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '6', null, '2', '1', null, 'fixtureNum', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '7', null, '2', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '8', null, '2', '1', null, 'outputQty', '0', 'output Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '9', null, '2', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '10', null, '2', '1', null, 'qcUseQty', '0', 'QC Use Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '11', null, '2', '1', null, 'toOtherQty', '0', 'To Other Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '12', null, '2', '1', null, 'partNum', '0', 'Part Num', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '13', null, '2', '1', null, 'workOrderNum', '0', 'work order number', null);
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '1', null, '1', '1', null, '', '2', '', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '2', null, '1', '1', null, 'pfID', '1', 'pfID', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '3', null, '1', '1', null, 'coatingTime', '0', 'Coating Date', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '4', null, '1', '1', null, 'pfTime', '0', 'Date', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '5', null, '1', '1', null, 'inputLotNum', '0', 'Input LOT#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '6', null, '1', '1', null, 'inputQty', '0', 'Input Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '7', null, '1', '1', null, 'fixtureNum', '0', 'Fixture#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '8', null, '1', '1', null, 'apsBottle', '0', 'APS Bottle', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '9', null, '1', '1', null, 'fixtureAttribute', '0', 'fixture属性', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '10', null, '1', '1', null, 'sfBomNum', '0', 'SF BOM#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '11', null, '1', '1', null, 'outputLotNum', '0', 'Output LOT#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '12', null, '1', '1', null, 'outputQty', '0', 'Output Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '13', null, '1', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '14', null, '1', '1', null, 'underIQCQty', '0', 'Under IQC Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '15', null, '1', '1', null, 'qcUseQty', '0', 'QC Use Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '16', null, '1', '1', null, 'functionalTestQty', '0', 'Functional Test Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '17', null, '1', '1', null, 'toHUBQty', '0', 'To HUB Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '18', null, '1', '1', null, 'remainQty', '0', 'REMAIN QTY', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '19', null, '1', '1', null, 'apsCondition', '0', 'APS condition', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '20', null, '1', '1', null, 'partNum', '0', 'Part Num', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '21', null, '1', '1', null, 'workOrderNum', '0', 'work order number', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '22', null, '1', '1', null, 'operatorName', '0', '操作员', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '23', null, '1', '1', null, '', '2', '操作', '');
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '2', null, '2', '1', null, 'crID', '1', 'crID', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '3', null, '2', '1', null, 'lot', '0', 'Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '4', null, '2', '1', null, 'reagentMixture', '2', '混合试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '5', null, '2', '1', null, 'trayLotNums', '0', '14-####Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '7', null, '2', '1', null, 'apsLotNums', '0', 'APS Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '8', null, '2', '1', null, 'ocLotNums', '0', 'OP.Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '11', null, '1', '2', null, null, '0', 'Fiber', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '13', null, '2', '1', null, 'coatingStation', '0', 'Coating Station', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '14', null, '2', '1', null, 'crOperator1', '0', '生化镀膜作业人员1', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '15', null, '2', '1', null, 'crOperator2', '0', '生化镀膜作业人员2', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '16', null, '2', '1', null, 'docRev', '0', '版本', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '17', null, '2', '1', null, 'auxiliaryReagent1', '0', '03-0018 or 03-0067 KB', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '18', null, '2', '1', null, 'auxiliaryReagent2', '0', '05-0079 1ug/ml BPA', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '19', null, '2', '1', null, 'auxiliaryReagent3', '0', '05-0080 6ug/ml HIgG', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '20', null, '2', '1', null, 'polishBoms', '0', 'POLISH BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '22', null, '2', '1', null, 'ocBoms', '0', '光学BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '23', null, '2', '1', null, 'apsBoms', '0', 'APS BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '24', null, '2', '1', null, 'assemblyBoms', '0', '组装 BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '25', null, '2', '1', null, 'bioBom', '0', '生物镀膜 BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '26', null, '2', '1', null, 'goodsQty', '0', 'Goods', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '27', null, '2', '1', null, 'inputQty', '0', 'Input', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '28', null, '2', '1', null, 'theoryYield', '0', 'theoretical Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '29', null, '2', '1', null, 'actualYield', '0', 'actual Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '30', null, '2', '1', null, 'theoryActualYield', '0', 'theoretical VS actual', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '31', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '32', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '2', '11', null, '1', '1', null, 'rawMaterial', '0', 'Raw Material', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '2', '12', null, '1', '1', null, 'inPutDate', '0', 'In Put Date', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '21', null, '2', '1', null, 'cleanBoms', '0', 'Clean BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '9', null, '2', '1', null, 'cleanLotNums', '0', 'Clean Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '10', null, '2', '1', null, 'polishLotNums', '0', 'Polish Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '6', null, '2', '1', null, 'tLotNums', '0', 'T#', null);

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
  `assembly_bom` varchar(200) DEFAULT NULL COMMENT '组装BOM',
  `output_qty` int(10) DEFAULT NULL COMMENT 'output Qty(pcs)',
  `scrap_qty` int(10) DEFAULT NULL COMMENT 'Scrap Qty(pcs)',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `work_order_num` varchar(20) DEFAULT NULL COMMENT '工单号',
  `remark` varchar(20) DEFAULT NULL COMMENT 'drop down T01….T17  是TRAY#',
  `clamp_down_the_cp` varchar(50) DEFAULT NULL COMMENT '拆夹工作人员',
  `clamping_cp` varchar(50) DEFAULT NULL COMMENT '装夹工作人员',
  `operatorid` int(11) DEFAULT NULL,
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`assembly_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='组装表'
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
INSERT INTO `t_ums_workflow_assembly` VALUES ('25', '2017-11-12', 'k94605', 'A1702031', '96', 'Q723', 'JS170120B', 'K170302XX', null, '3', '3', '15-9008', 'sdfs', 'T05', null, null, '9', '2017-11-12 16:24:48', '2017-11-22 00:12:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('27', '2017-11-25', 'dfd', 'sdfs', '3', 'sdcs', 'sds', 'sds', null, '3', '3', '14-0014', 'we', 'T17', null, null, '9', '2017-11-25 19:07:23', '2017-11-25 19:07:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('36', '2018-05-16', 'K94605', '11111111', '96', 'Q1111', '', 'K17030211', 'Assembly Bom2,Assembly Bom3', '80', '16', '09-0071', '102426646', null, '拆夹工作人员2', '装夹工作人员3', '9', '2018-05-16 03:09:37', '2018-05-16 03:14:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('37', '2018-05-16', 'K94605', '11111111', '96', 'Q1111', '', 'K17030211', 'Assembly Bom2,Assembly Bom3', '91', '5', '09-0071', '102426646', null, '拆夹工作人员2', '装夹工作人员2', '9', '2018-05-16 03:12:21', '2018-05-16 03:12:21');

-- ----------------------------
-- Table structure for t_ums_workflow_biocoating
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_biocoating`;
CREATE TABLE `t_ums_workflow_biocoating` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `lot` varchar(20) DEFAULT NULL COMMENT '试剂混合物的批次，Lot',
  `biobom` varchar(200) DEFAULT NULL COMMENT 'BIO BOM',
  `bio_pat_num` varchar(50) DEFAULT NULL COMMENT 'BIO Pat Number',
  `croperator1` varchar(50) DEFAULT NULL COMMENT ' 操作人员1',
  `croperator2` varchar(50) DEFAULT '' COMMENT ' 操作人员2',
  `raw_material` varchar(20) DEFAULT NULL COMMENT 'FIBER RAW MATERIAL',
  `in_put_date` date DEFAULT NULL COMMENT 'INPUT DATE',
  `coating_station` varchar(20) DEFAULT NULL COMMENT 'BIO 镀膜设备名称/每一个tray需要记录其对应在镀膜设备镀膜时放置的位置',
  `doc_rev` varchar(50) DEFAULT NULL COMMENT 'DOC.REV 依据文件及版本',
  `goods_qty` int(10) DEFAULT '0' COMMENT '良品数量',
  `auxiliary_reagent1` varchar(30) DEFAULT NULL COMMENT '03-0067',
  `auxiliary_reagent2` varchar(30) DEFAULT NULL COMMENT '05-0079 1ug/ml BPA',
  `auxiliary_reagent3` varchar(30) DEFAULT NULL COMMENT '05-0080 6ug/ml HIgG',
  `input_qty` int(10) DEFAULT '0' COMMENT '投入数量',
  `scrap_qty` int(6) DEFAULT NULL COMMENT 'Scrap QTY',
  `receive_qty` int(6) DEFAULT NULL COMMENT '领用QTY',
  `heavy_smoke_qty` int(6) DEFAULT NULL COMMENT '重抽 Qty',
  `to_pqc_qty` int(6) DEFAULT NULL COMMENT 'To PQC QTY',
  `to_other_qty` int(6) DEFAULT NULL COMMENT '其他QTY',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `theory_yield` double(5,2) DEFAULT NULL COMMENT '理论良率',
  `actual_yield` double(5,2) DEFAULT NULL COMMENT '实际良率',
  `theory_actual_yield` double(5,2) DEFAULT NULL COMMENT '理论和实际良率比较',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cr_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='化学试剂表'
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
-- Records of t_ums_workflow_biocoating
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_workflow_biocoating_reagents
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_biocoating_reagents`;
CREATE TABLE `t_ums_workflow_biocoating_reagents` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `reagents_field_name` varchar(255) DEFAULT NULL,
  `main_reagent` varchar(100) DEFAULT NULL COMMENT '混合试剂名称',
  `reagents_name` varchar(100) DEFAULT NULL COMMENT '混合试剂编号',
  `reagents_sn` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学混合试剂表';

-- ----------------------------
-- Records of t_ums_workflow_biocoating_reagents
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_workflow_biocoating_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_biocoating_relation`;
CREATE TABLE `t_ums_workflow_biocoating_relation` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `tray_lot_num` varchar(20) DEFAULT NULL COMMENT '组装站位的OUTPUT LOT#',
  `t_lot_num` varchar(20) DEFAULT NULL COMMENT 'T#'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学试剂与组装关系表';

-- ----------------------------
-- Records of t_ums_workflow_biocoating_relation
-- ----------------------------
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('1', 'K94605', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('2', 'K94605', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('3', 'on', 'T01');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('3', 'on', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('3', 'on', 'T03');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('3', 'on', 'T04');

-- ----------------------------
-- Table structure for t_ums_workflow_biocoatint_reagents
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_biocoatint_reagents`;
CREATE TABLE `t_ums_workflow_biocoatint_reagents` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `reagents_field_name` varchar(255) DEFAULT NULL,
  `main_reagent` varchar(100) DEFAULT NULL COMMENT '混合试剂名称',
  `reagents_name` varchar(100) DEFAULT NULL COMMENT '混合试剂编号',
  `reagents_sn` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学混合试剂表';

-- ----------------------------
-- Records of t_ums_workflow_biocoatint_reagents
-- ----------------------------
INSERT INTO `t_ums_workflow_biocoatint_reagents` VALUES ('2', 'reagentmixturetable209316_9', '04-0001', '01-0001', 'KD132279');
INSERT INTO `t_ums_workflow_biocoatint_reagents` VALUES ('2', 'reagentmixturetable209316_11', '04-0001', '01-0001', 'KD132278');
INSERT INTO `t_ums_workflow_biocoatint_reagents` VALUES ('3', 'reagentmixturetable209316_9', '04-0001', '01-0001', 'KD132279');
INSERT INTO `t_ums_workflow_biocoatint_reagents` VALUES ('3', 'reagentmixturetable209316_11', '04-0001', '01-0001', 'KD132278');

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='清洗表'
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
INSERT INTO `t_ums_workflow_clean` VALUES ('30', '2018-05-12', 'Q1111', 'DX1702021', '1534', 'C3', 'CX170214', '3', '1531', '99.80', '0', '09-0071', '102379092', '9', '2018-05-12 06:03:52', '2018-05-12 07:45:15');
INSERT INTO `t_ums_workflow_clean` VALUES ('32', '2018-05-12', 'Q1111', 'DX1702021', '1534', 'C3', 'CX170214', '5', '1529', '99.67', '0', '09-0071', '102379092', '9', '2018-05-12 07:46:26', '2018-05-12 07:46:26');

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
INSERT INTO `t_ums_workflow_defect` VALUES ('140', '171', '214', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('140', '171', '218', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('30', '181', '241', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('30', '182', '242', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('32', '181', '241', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('32', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '191', '262', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '192', '268', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '191', '262', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '192', '268', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '191', '262', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '192', '268', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('142', '171', '218', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('142', '172', '227', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('142', '172', '225', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('143', '171', '218', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('143', '172', '227', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('143', '172', '225', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('36', '201', '200', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('37', '201', '200', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('36', '201', '200', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('36', '201', '200', '5');

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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='光学镀膜表'
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
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('66', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '618', '12', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:50:58', '2018-04-14 10:50:58');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('67', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '618', '12', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:50:58', '2018-04-14 10:50:58');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('68', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '626', '4', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:52:05', '2018-04-14 10:52:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('69', '2018-04-11', '师傅', '630', 'hhh', 'dddd', '607', '12', '6', '5', '13-0003', '中兴', '哈哈', '444', '9', '2018-04-14 10:54:42', '2018-04-14 10:54:42');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('70', '2018-04-11', '师傅', '630', 'hhh', 'dddd', '607', '12', '6', '5', '13-0003', '中兴', '哈哈', '444', '9', '2018-04-14 10:54:43', '2018-04-14 10:54:43');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('71', '2018-04-11', '师傅', '630', 'hhh', 'dddd', '607', '12', '6', '5', '13-0003', '中兴', '哈哈', '444', '9', '2018-04-14 10:54:44', '2018-04-14 10:54:44');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('72', '2018-04-04', '师傅', '630', 'hhh', 'dddd', '618', '12', '0', '0', '13-0003', '中兴', '哈哈', 'ddd', '9', '2018-04-14 10:55:47', '2018-04-14 10:55:47');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('73', '2018-05-12', 'CX170214', '1529', 'Q1111', 'O1701191XH', '1515', '14', '0', '0', '12-0003', '中兴', '哈哈', '102367592', '9', '2018-05-12 07:49:43', '2018-05-12 07:50:20');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('74', '2018-05-12', 'CX170214', '1529', 'Q1111', 'O1701191XH', '1515', '14', '0', '0', '12-0003', '中兴', '哈哈', '102367592', '9', '2018-05-12 07:51:17', '2018-05-12 07:51:17');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('75', '2018-05-12', 'CX170214', '1529', 'Q1111', 'O1701191XH', '1515', '14', '0', '0', '12-0003', '中兴', '哈哈', '102367592', '9', '2018-05-12 07:56:55', '2018-05-12 07:56:55');

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
  `aps_bottle` varchar(100) DEFAULT NULL COMMENT 'APS Bottle',
  `fixture_attribute` varchar(50) DEFAULT NULL COMMENT 'fixture属性',
  `sf_bom` varchar(50) NOT NULL COMMENT '哪一瓶化学溶剂 sf_bom',
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='化学镀膜表'
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
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('8', '2018-05-14', '2018-05-14', 'O1701191XH', '1515', 'Q1111', '', 'Q', 'SF BOM2', '11111111', '1503', '12', '3', null, null, '0', '5', '4', '5', 'APS Condition1', '09-0071', '11111111', '9', '2018-05-14 10:24:50', '2018-05-14 12:05:42');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('9', '2018-05-14', '2018-05-14', 'O1701191XH', '1515', 'Q1111', null, 'K', 'SF BOM1', '11111111', '1503', '12', '3', null, null, '0', '5', '4', '5', 'APS Condition1', '09-0071', '11111111', '9', '2018-05-14 10:24:50', '2018-05-14 10:24:50');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('11', '2018-05-14', '2018-05-14', 'O1701191XH', '1515', 'Q1111', null, 'K', 'SF BOM1', '11111111', '1503', '12', '3', null, null, '0', '5', '4', '5', 'APS Condition1', '09-0071', '11111111', '9', '2018-05-14 10:24:51', '2018-05-14 10:24:51');

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
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 COMMENT='抛光表'
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
INSERT INTO `t_ums_workflow_polish` VALUES ('140', '2018-05-11', '2018-05-12', 'XC161216', '0000001534', 'Q1111', '', 'A', '', '1534', '99.67', '1534', 'DX1702021', '09-0080', '102418121', 'fggff', '9', '2018-05-12 05:24:17', '2018-05-12 05:53:57');
INSERT INTO `t_ums_workflow_polish` VALUES ('141', '2018-05-11', '2018-05-12', 'XC161216', '0000001534', 'Q1230', '', 'A', '', '1534', '100.00', '1534', 'DX1702021', '09-0080', '102418121', 'fggff', '9', '2018-05-12 05:28:11', '2018-05-12 05:28:11');

-- ----------------------------
-- Table structure for t_ums_workflow_twicebiocoating
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_twicebiocoating`;
CREATE TABLE `t_ums_workflow_twicebiocoating` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标示',
  `lot` varchar(20) DEFAULT NULL COMMENT '试剂混合物的批次，Lot',
  `biobom` varchar(200) DEFAULT NULL COMMENT 'BIO BOM',
  `bio_pat_num` varchar(50) DEFAULT NULL COMMENT 'BIO Pat Number',
  `croperator1` varchar(50) DEFAULT NULL COMMENT ' 操作人员1',
  `croperator2` varchar(50) DEFAULT '' COMMENT ' 操作人员2',
  `raw_material` varchar(20) DEFAULT NULL COMMENT 'FIBER RAW MATERIAL',
  `in_put_date` date DEFAULT NULL COMMENT 'INPUT DATE',
  `coating_station` varchar(20) DEFAULT NULL COMMENT 'BIO 镀膜设备名称/每一个tray需要记录其对应在镀膜设备镀膜时放置的位置',
  `doc_rev` varchar(50) DEFAULT NULL COMMENT 'DOC.REV 依据文件及版本',
  `goods_qty` int(10) DEFAULT '0' COMMENT '良品数量',
  `auxiliary_reagent1` varchar(30) DEFAULT NULL COMMENT '03-0067',
  `auxiliary_reagent2` varchar(30) DEFAULT NULL COMMENT '05-0079 1ug/ml BPA',
  `auxiliary_reagent3` varchar(30) DEFAULT NULL COMMENT '05-0080 6ug/ml HIgG',
  `input_qty` int(10) DEFAULT '0' COMMENT '投入数量',
  `scrap_qty` int(6) DEFAULT NULL COMMENT 'Scrap QTY',
  `receive_qty` int(6) DEFAULT NULL COMMENT '领用QTY',
  `heavy_smoke_qty` int(6) DEFAULT NULL COMMENT '重抽 Qty',
  `to_pqc_qty` int(6) DEFAULT NULL COMMENT 'To PQC QTY',
  `to_other_qty` int(6) DEFAULT NULL COMMENT '其他QTY',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `theory_yield` double(5,2) DEFAULT NULL COMMENT '理论良率',
  `actual_yield` double(5,2) DEFAULT NULL COMMENT '实际良率',
  `theory_actual_yield` double(5,2) DEFAULT NULL COMMENT '理论和实际良率比较',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cr_id`,`input_time`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='化学试剂表'
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
-- Records of t_ums_workflow_twicebiocoating
-- ----------------------------

-- ----------------------------
-- Table structure for t_ums_workflow_twicebiocoating_reagents
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_twicebiocoating_reagents`;
CREATE TABLE `t_ums_workflow_twicebiocoating_reagents` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `reagents_field_name` varchar(255) DEFAULT NULL,
  `main_reagent` varchar(100) DEFAULT NULL COMMENT '混合试剂名称',
  `reagents_name` varchar(100) DEFAULT NULL COMMENT '混合试剂编号',
  `reagents_sn` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学混合试剂表';

-- ----------------------------
-- Records of t_ums_workflow_twicebiocoating_reagents
-- ----------------------------
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('2', 'reagentmixturetable209316_9', '04-0001', '01-0001', 'KD132279');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('2', 'reagentmixturetable209316_11', '04-0001', '01-0001', 'KD132278');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209316_9', '04-0001', '01-0001', 'KD132279');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209316_11', '04-0001', '01-0001', 'KD132278');

-- ----------------------------
-- Table structure for t_ums_workflow_twicebiocoating_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_twicebiocoating_relation`;
CREATE TABLE `t_ums_workflow_twicebiocoating_relation` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `tray_lot_num` varchar(20) DEFAULT NULL COMMENT '组装站位的OUTPUT LOT#',
  `t_lot_num` varchar(20) DEFAULT NULL COMMENT 'T#'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学试剂与组装关系表';

-- ----------------------------
-- Records of t_ums_workflow_twicebiocoating_relation
-- ----------------------------

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

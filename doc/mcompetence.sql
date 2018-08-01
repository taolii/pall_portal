/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : 127.0.0.1:3306
Source Database       : mcompetence

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-08-01 15:27:51
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
  PRIMARY KEY (`OPERATORID`),
  KEY `idx_uaa_account` (`ACCOUNT`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of t_ums_admininfo
-- ----------------------------
INSERT INTO `t_ums_admininfo` VALUES ('9', '超级管理员', 'admin', 'admin', '1', '', null, '13816763234', '13434@1632', null, null, '1', '2', '1', '2017-07-08 00:55:55', '2018-05-20 15:11:56');
INSERT INTO `t_ums_admininfo` VALUES ('19', 'admin', 'test', 'admin', '0', '', null, '13816763233', '13816763233@163.com', '', '', '1', '2', '1', '2018-05-20 15:40:12', '2018-05-28 18:04:06');

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
INSERT INTO `t_ums_config` VALUES ('54', 'platedFilm/dataconfig/type/fixtureAttribute', '1', '47', null, '2', '数据配置表代表fixture属性的配置类型');
INSERT INTO `t_ums_config` VALUES ('55', 'assembly/dataconfig/type/clamping', '1', '203', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('56', 'assembly/dataconfig/type/installHub', '1', '204', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('57', 'assembly/dataconfig/type/other', '1', '205', null, '2', ' 组装表非工作面的缺损信息在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('58', 'assembly/dataconfig/type/clampingCP', '1', '39', null, '2', ' 组装表装夹操作员在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('59', 'assembly/dataconfig/type/clampDownTheCP', '1', '40', null, '2', ' 组装表拆夹操作员在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('60', 'assembly/dataconfig/type/assemblyBoms', '1', '38', null, '2', ' 组装表Assembly bom在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('61', 'twicechemicalReagent/dataconfig/type/bioBom', '1', '41', null, '2', '二次生物镀膜BIO BOM在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('62', 'twicechemicalReagent/dataconfig/type/bioPatNum', '1', '42', null, '2', '二次生物镀膜BIO Pat Number在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('63', 'twicechemicalReagent/dataconfig/type/crOperator1', '1', '43', null, '2', '二次生物镀膜操作人员1在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('64', 'twicechemicalReagent/dataconfig/type/crOperator2', '1', '44', null, '2', '二次生物镀膜操作人员2在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('65', 'twicechemicalReagent/dataconfig/type/rawMaterial', '1', '45', null, '2', '二次生物镀膜FIBER RAW MATERIAL在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('66', 'twicechemicalReagent/dataconfig/type/coatingStation', '1', '46', null, '2', '二次生物镀膜Coating Station在数据配置表中的类型');
INSERT INTO `t_ums_config` VALUES ('67', 'twicechemicalReagent/dataconfig/type/chemicalReagent', '1', '16', null, '2', '数据配置表代表化学试剂配置类型');
INSERT INTO `t_ums_config` VALUES ('68', 'twicechemicalReagent/tablename', '1', 'twicechemicalreagenttable207', null, '2', '二次生物镀膜流程配置表名');
INSERT INTO `t_ums_config` VALUES ('69', 'twicechemicalReagent/download/subdirectory', '1', 'twicechemicalReagent', null, '2', '二次生物镀膜管理页面excel下载子目录名称');
INSERT INTO `t_ums_config` VALUES ('69', 'polish/menuid', '1', '201', null, '2', '抛光流程菜单id');
INSERT INTO `t_ums_config` VALUES ('70', 'clean/menuid', '1', '202', null, '2', '清洗流程菜单id');
INSERT INTO `t_ums_config` VALUES ('71', 'opticalFilming/menuid', '1', '203', null, '2', '光学镀膜流程菜单id');
INSERT INTO `t_ums_config` VALUES ('72', 'platedFilm/menuid', '1', '204', null, '2', '化学镀膜APS流程菜单id');
INSERT INTO `t_ums_config` VALUES ('73', 'assembly/menuid', '1', '205', null, '2', '组装流程菜单id');
INSERT INTO `t_ums_config` VALUES ('74', 'chemicalReagent/menuid', '1', '206', null, '2', '生物镀膜BIO流程菜单id');
INSERT INTO `t_ums_config` VALUES ('75', 'twicechemicalReagent/menuid', '1', '207', null, '2', '二次生物镀膜BIO流程菜单id');
INSERT INTO `t_ums_config` VALUES ('76', 'report/assemblyScrapSummary/tablename', '1', 'assemblyScrapSummarytable301', null, '2', '组装报废汇总配置表名');
INSERT INTO `t_ums_config` VALUES ('77', 'report/productTracking/tablename', '1', 'productTrackingtable302', null, '2', '产出数量追踪配置表名');

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
  PRIMARY KEY (`DATAID`),
  KEY `idx_udc_config_datatype_configname` (`DATATYPE`,`configname`)
) ENGINE=InnoDB AUTO_INCREMENT=830 DEFAULT CHARSET=utf8 COMMENT='数据字典配置表';

-- ----------------------------
-- Records of t_ums_data_config
-- ----------------------------
INSERT INTO `t_ums_data_config` VALUES ('2', '1', '缺损管理_缺损类型', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('11', '1', 'Polish_throwMillstonePosition', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('12', '1', 'PN#', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('14', '1', 'Polish_Bom', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('17', '2', 'Polishing', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('18', '2', 'Cleaning', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('19', '2', '光学镀膜', '', '9', null, '2018-07-10 12:01:38');
INSERT INTO `t_ums_data_config` VALUES ('20', '2', '组装', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('21', '1', 'Clean_Bom', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('22', '1', '缺损管理_缺损信息', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('24', '1', 'OpticalCoating_供应商', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('25', '1', 'OpticalCoating_BOM', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('27', '1', '试剂混合_主试剂', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('28', '1', 'BIO_BOM', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('29', '1', 'BIO_PatNumber ', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('30', '1', 'BIO_操作人员1', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('31', '1', 'BIO_操作人员2', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('32', '1', 'BIO_FiberRawMaterial', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('33', '1', 'BIO_CoatingStation', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('34', '1', '试剂混合_子试剂', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('35', '1', 'APS_BOM', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('36', '1', 'APS_apscondition', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('37', '1', 'Assembly_Fixture属性', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('38', '1', 'Assembly_Bom', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('39', '1', 'Assembly_装夹工作人员', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('40', '1', 'Assembly_拆夹工作人员', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('41', '1', 'Twice_BIO_BOM', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('42', '1', 'Twice_BIO_PatNumber ', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('43', '1', 'Twice_BIO_操作人员1', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('44', '1', 'Twice_BIO_操作人员2', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('45', '1', 'Twice_BIO_FiberRawMaterial', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('46', '1', 'Twice_BIO_CoatingStation', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('47', '1', 'APS_Fixture属性', '', '9', '2018-06-26 15:38:42', '2018-06-26 15:38:46');
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
INSERT INTO `t_ums_data_config` VALUES ('249', '182', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('250', '182', '缝隙', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('251', '182', '其它', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('252', '192', '崩边', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('253', '192', '划痕', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('254', '192', '异物', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('255', '192', '胶', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('256', '192', '印迹', '', '9', null, null);
INSERT INTO `t_ums_data_config` VALUES ('262', '192', '其它', '', '9', null, null);
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
INSERT INTO `t_ums_data_config` VALUES ('294', '26', 'SF Bom1', 'SFBom1', '9', '2018-04-22 21:34:35', '2018-04-22 21:34:35');
INSERT INTO `t_ums_data_config` VALUES ('295', '27', '04-0001', '双长链生物素偶联牛血清白蛋白', '9', '2018-04-21 23:31:46', '2018-07-04 10:01:12');
INSERT INTO `t_ums_data_config` VALUES ('296', '27', '04-0002', '链霉亲和素偶联抗人免疫球蛋白抗体', '9', '2018-04-21 23:31:53', '2018-07-04 10:03:30');
INSERT INTO `t_ums_data_config` VALUES ('297', '27', '04-0003', '短链生物素偶联牛血清白蛋白', '9', '2018-04-21 23:32:02', '2018-07-04 10:03:55');
INSERT INTO `t_ums_data_config` VALUES ('316', '34', '01-0001', '双长链生物素', '9', '2018-04-27 10:22:35', '2018-07-04 12:51:46');
INSERT INTO `t_ums_data_config` VALUES ('318', '34', '01-0003', 'DMF', '9', '2018-04-27 10:22:50', '2018-07-04 12:52:19');
INSERT INTO `t_ums_data_config` VALUES ('319', '34', '01-0004', '10%叠氮化钠溶液', '9', '2018-04-27 10:22:59', '2018-07-04 12:52:50');
INSERT INTO `t_ums_data_config` VALUES ('321', '34', '02-0001', '人免疫球蛋白（HIgG）', '9', '2018-04-27 10:23:37', '2018-07-04 13:05:53');
INSERT INTO `t_ums_data_config` VALUES ('322', '34', '02-0002', '牛血清白蛋白', '9', '2018-04-27 10:23:44', '2018-07-04 13:02:50');
INSERT INTO `t_ums_data_config` VALUES ('323', '12', '09-0080', '', '9', '2018-05-12 05:25:32', '2018-05-12 05:25:32');
INSERT INTO `t_ums_data_config` VALUES ('324', '181', '崩边', '', '9', '2018-05-12 06:05:27', '2018-05-12 06:05:27');
INSERT INTO `t_ums_data_config` VALUES ('325', '22', '棉纱', '', '9', '2018-05-12 06:12:27', '2018-05-12 06:12:27');
INSERT INTO `t_ums_data_config` VALUES ('326', '181', '棉纱', '', '9', '2018-05-12 06:12:45', '2018-05-12 06:12:45');
INSERT INTO `t_ums_data_config` VALUES ('327', '181', '划痕', '', '9', '2018-05-12 06:13:28', '2018-05-12 06:13:28');
INSERT INTO `t_ums_data_config` VALUES ('328', '181', '异物', '', '9', '2018-05-12 06:14:48', '2018-05-12 06:14:48');
INSERT INTO `t_ums_data_config` VALUES ('332', '22', '缝隙', '', '9', '2018-05-12 06:30:35', '2018-05-12 06:30:35');
INSERT INTO `t_ums_data_config` VALUES ('348', '12', '09-0071', '', '9', '2018-05-12 06:43:26', '2018-05-12 06:43:26');
INSERT INTO `t_ums_data_config` VALUES ('349', '12', '12-0003', '', '9', '2018-05-12 07:50:06', '2018-05-12 07:50:06');
INSERT INTO `t_ums_data_config` VALUES ('350', '37', 'Q', '', '9', '2018-05-13 22:40:23', '2018-05-13 22:40:23');
INSERT INTO `t_ums_data_config` VALUES ('351', '37', 'K', '', '9', '2018-05-13 22:40:29', '2018-05-13 22:40:29');
INSERT INTO `t_ums_data_config` VALUES ('358', '203', '其它', '', '9', '2018-05-14 21:49:53', '2018-05-14 21:49:53');
INSERT INTO `t_ums_data_config` VALUES ('359', '204', '其它', '', '9', '2018-05-14 21:50:10', '2018-05-14 21:50:10');
INSERT INTO `t_ums_data_config` VALUES ('360', '205', '其它', '', '9', '2018-05-14 21:50:34', '2018-05-14 21:50:34');
INSERT INTO `t_ums_data_config` VALUES ('364', '40', '拆夹工作人员1', '', '9', '2018-05-15 01:28:22', '2018-05-15 01:28:22');
INSERT INTO `t_ums_data_config` VALUES ('365', '40', '拆夹工作人员2', '', '9', '2018-05-15 01:28:32', '2018-05-15 01:28:32');
INSERT INTO `t_ums_data_config` VALUES ('366', '40', '拆夹工作人员3', '', '9', '2018-05-15 01:28:42', '2018-05-15 01:28:42');
INSERT INTO `t_ums_data_config` VALUES ('367', '39', '装夹工作人员1', '', '9', '2018-05-15 01:29:13', '2018-05-15 01:29:13');
INSERT INTO `t_ums_data_config` VALUES ('368', '39', '装夹工作人员2', '', '9', '2018-05-15 01:29:23', '2018-05-15 01:29:23');
INSERT INTO `t_ums_data_config` VALUES ('369', '39', '装夹工作人员3', '', '9', '2018-05-15 01:29:33', '2018-05-15 01:29:33');
INSERT INTO `t_ums_data_config` VALUES ('386', '32', 'XC160708', '', '9', '2018-05-29 01:04:57', '2018-05-29 01:04:57');
INSERT INTO `t_ums_data_config` VALUES ('387', '32', 'RP160722', '', '9', '2018-05-29 01:05:23', '2018-05-29 01:05:23');
INSERT INTO `t_ums_data_config` VALUES ('388', '32', 'RP160780', '', '9', '2018-05-29 01:05:42', '2018-05-29 01:05:42');
INSERT INTO `t_ums_data_config` VALUES ('389', '32', 'XC160802', '', '9', '2018-05-29 01:05:57', '2018-05-29 01:05:57');
INSERT INTO `t_ums_data_config` VALUES ('390', '41', 'TwiceBioBom1', '', '9', '2018-05-29 23:23:22', '2018-05-29 23:23:22');
INSERT INTO `t_ums_data_config` VALUES ('391', '41', 'TwiceBioBom2', '', '9', '2018-05-29 23:23:26', '2018-05-29 23:23:26');
INSERT INTO `t_ums_data_config` VALUES ('392', '41', 'TwiceBioBom3', '', '9', '2018-05-29 23:23:31', '2018-05-29 23:23:31');
INSERT INTO `t_ums_data_config` VALUES ('399', '42', 'TwiceBioPatNumber1', '', '9', '2018-05-29 23:25:07', '2018-05-29 23:25:07');
INSERT INTO `t_ums_data_config` VALUES ('400', '42', 'TwiceBioPatNumber2', '', '9', '2018-05-29 23:25:12', '2018-05-29 23:25:12');
INSERT INTO `t_ums_data_config` VALUES ('401', '42', 'TwiceBioPatNumber3', '', '9', '2018-05-29 23:25:16', '2018-05-29 23:25:16');
INSERT INTO `t_ums_data_config` VALUES ('408', '12', '18-0004', 'Pro.A', '9', '2018-05-30 13:19:02', '2018-05-30 13:19:02');
INSERT INTO `t_ums_data_config` VALUES ('409', '12', '18-0009', 'SA', '9', '2018-05-30 13:19:50', '2018-05-30 13:19:50');
INSERT INTO `t_ums_data_config` VALUES ('411', '28', '71-0011', 'POUCH ', '9', '2018-05-30 13:24:44', '2018-05-30 13:24:44');
INSERT INTO `t_ums_data_config` VALUES ('412', '28', '09-0060', '黑板', '9', '2018-05-30 13:25:39', '2018-05-30 13:25:39');
INSERT INTO `t_ums_data_config` VALUES ('413', '28', '09-0063', '白板', '9', '2018-05-30 13:26:00', '2018-05-30 13:26:00');
INSERT INTO `t_ums_data_config` VALUES ('415', '27', '03-0001', '10mM 磷酸盐缓冲液，pH7.4', '9', '2018-05-30 13:33:55', '2018-07-04 09:32:05');
INSERT INTO `t_ums_data_config` VALUES ('416', '29', '18-0004', 'Pro.A', '9', '2018-05-30 14:01:48', '2018-05-30 14:01:48');
INSERT INTO `t_ums_data_config` VALUES ('417', '42', '18-0029', 'NTA', '9', '2018-05-30 14:08:21', '2018-05-30 14:08:21');
INSERT INTO `t_ums_data_config` VALUES ('418', '27', '03-0006', '磷酸钠缓冲液，pH 3.75', '9', '2018-06-08 09:13:39', '2018-07-04 09:31:36');
INSERT INTO `t_ums_data_config` VALUES ('419', '27', '03-0012', '7.5mM MES缓冲液，pH5.0', '9', '2018-06-12 09:19:20', '2018-07-04 09:35:57');
INSERT INTO `t_ums_data_config` VALUES ('420', '27', '03-0047', 'HBST缓冲液', '9', '2018-06-12 10:51:06', '2018-07-04 09:51:42');
INSERT INTO `t_ums_data_config` VALUES ('421', '27', '03-0046', '1M氯化镍溶液', '9', '2018-06-12 10:56:02', '2018-06-12 10:56:02');
INSERT INTO `t_ums_data_config` VALUES ('422', '27', '04-0023', 'Biotin-Tris-NTA储液', '9', '2018-06-12 10:56:31', '2018-07-04 11:50:57');
INSERT INTO `t_ums_data_config` VALUES ('423', '27', '03-0005', '20%保护液', '9', '2018-06-12 10:57:11', '2018-06-12 10:57:11');
INSERT INTO `t_ums_data_config` VALUES ('424', '34', '01-0063', 'HEPES试剂包', '9', '2018-06-12 12:09:41', '2018-07-04 13:01:14');
INSERT INTO `t_ums_data_config` VALUES ('425', '34', '01-0048', '氯化钠', '9', '2018-06-12 12:10:12', '2018-06-12 12:10:12');
INSERT INTO `t_ums_data_config` VALUES ('426', '34', '01-0009', '吐温20', '9', '2018-06-12 12:10:36', '2018-06-12 12:10:36');
INSERT INTO `t_ums_data_config` VALUES ('427', '34', '01-0045', 'Proclin300', '9', '2018-06-12 12:10:55', '2018-06-12 12:10:55');
INSERT INTO `t_ums_data_config` VALUES ('428', '34', '01-0062', '氯化镍', '9', '2018-06-12 12:11:34', '2018-06-12 12:11:34');
INSERT INTO `t_ums_data_config` VALUES ('429', '34', '01-0002', 'PBS试剂包(1L)', '9', '2018-06-12 12:12:25', '2018-07-04 13:16:31');
INSERT INTO `t_ums_data_config` VALUES ('430', '34', '01-0011', '蔗糖', '9', '2018-06-12 12:12:40', '2018-06-12 12:12:40');
INSERT INTO `t_ums_data_config` VALUES ('431', '34', '01-0028', '盐酸', '9', '2018-06-12 12:12:55', '2018-06-12 12:12:55');
INSERT INTO `t_ums_data_config` VALUES ('432', '34', '去离子水', '去离子水', '9', '2018-06-12 12:13:11', '2018-06-12 12:13:11');
INSERT INTO `t_ums_data_config` VALUES ('433', '27', '03-0008', 'M保护液', '9', '2018-06-12 12:16:55', '2018-06-12 12:16:55');
INSERT INTO `t_ums_data_config` VALUES ('434', '27', '05-5003', '1M乙醇胺溶液', '9', '2018-06-12 12:17:39', '2018-06-12 12:17:39');
INSERT INTO `t_ums_data_config` VALUES ('436', '34', '01-0026', 'BS3  LOT FI180418', '9', '2018-06-12 12:18:59', '2018-07-10 13:02:51');
INSERT INTO `t_ums_data_config` VALUES ('437', '34', '01-0029', '磷酸二氢钠', '9', '2018-06-12 12:19:30', '2018-06-12 12:19:30');
INSERT INTO `t_ums_data_config` VALUES ('440', '34', '01-0030', '戊二醛', '9', '2018-06-12 12:21:55', '2018-06-12 12:21:55');
INSERT INTO `t_ums_data_config` VALUES ('441', '34', '01-0025', '乙醇胺', '9', '2018-06-12 12:22:36', '2018-06-12 12:22:36');
INSERT INTO `t_ums_data_config` VALUES ('442', '34', '01-0022', '8N 氢氧化钾', '9', '2018-06-12 12:23:29', '2018-06-12 12:23:29');
INSERT INTO `t_ums_data_config` VALUES ('443', '34', '01-0027', '磷酸一氢钠', '9', '2018-06-12 12:24:44', '2018-06-12 12:24:44');
INSERT INTO `t_ums_data_config` VALUES ('445', '34', '03-0007', '磷酸钠缓冲液，pH 7.4', '9', '2018-06-12 12:29:24', '2018-06-12 12:29:24');
INSERT INTO `t_ums_data_config` VALUES ('446', '14', '09-0057', '玻璃光纤', '9', '2018-06-13 15:07:32', '2018-06-13 15:07:32');
INSERT INTO `t_ums_data_config` VALUES ('447', '14', '71-0000', '乐泰胶417（20G/支）', '9', '2018-06-13 15:09:21', '2018-06-13 15:09:21');
INSERT INTO `t_ums_data_config` VALUES ('448', '21', '71-0000', '丙酮', '9', '2018-06-13 15:10:37', '2018-06-13 15:10:37');
INSERT INTO `t_ums_data_config` VALUES ('449', '21', '09-0080', '抛磨后光钎\r\nFIBER,OPTICAL,POLISHED&BEFORE CLEAN', '9', '2018-06-13 15:12:36', '2018-06-13 15:12:36');
INSERT INTO `t_ums_data_config` VALUES ('450', '25', '09-0071', '玻璃光纤，抛光，检验合格，20mm', '9', '2018-06-13 15:12:48', '2018-06-13 15:12:48');
INSERT INTO `t_ums_data_config` VALUES ('451', '35', '12-0003', '光学镀膜光钎，20mm', '9', '2018-06-13 15:14:19', '2018-06-13 15:14:19');
INSERT INTO `t_ums_data_config` VALUES ('452', '35', '09-0078', '100ml APS溶液', '9', '2018-06-13 15:14:59', '2018-06-13 15:14:59');
INSERT INTO `t_ums_data_config` VALUES ('453', '38', '13-0005', 'K-玻璃光钎', '9', '2018-06-13 15:16:59', '2018-06-13 15:16:59');
INSERT INTO `t_ums_data_config` VALUES ('454', '38', '13-0004', 'Q-玻璃光钎', '9', '2018-06-13 15:17:19', '2018-06-13 15:17:19');
INSERT INTO `t_ums_data_config` VALUES ('455', '38', '09-0079', 'Assembly Tip Tray EMPTY', '9', '2018-06-13 15:18:13', '2018-06-13 15:18:13');
INSERT INTO `t_ums_data_config` VALUES ('456', '38', '09-0076', 'HUB ABS透明hub', '9', '2018-06-13 15:18:54', '2018-06-13 15:18:54');
INSERT INTO `t_ums_data_config` VALUES ('457', '38', '71-0015', '胶水 160ml', '9', '2018-06-13 15:19:25', '2018-06-13 15:19:25');
INSERT INTO `t_ums_data_config` VALUES ('458', '11', '1#机器', '', '9', '2018-06-13 16:03:25', '2018-06-13 16:03:25');
INSERT INTO `t_ums_data_config` VALUES ('459', '11', '2#机器', '', '9', '2018-06-13 16:03:41', '2018-06-13 16:03:41');
INSERT INTO `t_ums_data_config` VALUES ('460', '11', '3#机器', '', '9', '2018-06-13 16:03:50', '2018-06-13 16:03:50');
INSERT INTO `t_ums_data_config` VALUES ('461', '11', '4#机器', '', '9', '2018-06-13 16:04:00', '2018-06-13 16:04:00');
INSERT INTO `t_ums_data_config` VALUES ('462', '182', '印迹', '', '9', '2018-06-19 16:19:56', '2018-06-19 16:19:56');
INSERT INTO `t_ums_data_config` VALUES ('465', '24', '海泰', '', '9', '2018-06-19 16:36:31', '2018-06-19 16:36:31');
INSERT INTO `t_ums_data_config` VALUES ('466', '24', '新产业', '', '9', '2018-06-19 16:36:39', '2018-06-19 16:36:39');
INSERT INTO `t_ums_data_config` VALUES ('467', '22', '光纤掉落', '', '9', '2018-06-20 13:21:16', '2018-06-20 13:21:16');
INSERT INTO `t_ums_data_config` VALUES ('468', '182', '光纤掉落', '', '9', '2018-06-20 13:21:34', '2018-07-10 16:44:17');
INSERT INTO `t_ums_data_config` VALUES ('469', '27', '03-0002', 'H保护液', '9', '2018-07-04 09:18:46', '2018-07-04 09:18:46');
INSERT INTO `t_ums_data_config` VALUES ('470', '28', '18-0009', 'SA', '9', '2018-07-04 09:27:31', '2018-07-04 09:27:31');
INSERT INTO `t_ums_data_config` VALUES ('471', '27', '03-0003', '15%保护液', '9', '2018-07-04 09:30:01', '2018-07-04 09:30:01');
INSERT INTO `t_ums_data_config` VALUES ('472', '27', '03-0004', '100mg/mL BSA 溶液', '9', '2018-07-04 09:30:50', '2018-07-04 09:30:50');
INSERT INTO `t_ums_data_config` VALUES ('473', '27', '03-0007', '磷酸钠缓冲液，pH 7.4', '9', '2018-07-04 09:33:22', '2018-07-04 09:33:22');
INSERT INTO `t_ums_data_config` VALUES ('474', '27', '03-0011', '2mg/ml牛胰岛素储液', '9', '2018-07-04 09:34:17', '2018-07-04 09:34:17');
INSERT INTO `t_ums_data_config` VALUES ('475', '27', '03-0015', '6mM利尿磺胺溶液（DMSO）', '9', '2018-07-04 09:37:20', '2018-07-04 09:37:20');
INSERT INTO `t_ums_data_config` VALUES ('476', '27', '03-0016', '0.5% DMSO溶液（PBS）', '9', '2018-07-04 09:38:02', '2018-07-04 09:38:02');
INSERT INTO `t_ums_data_config` VALUES ('477', '27', '03-0017', '700µM生物胞素溶液（PBS）', '9', '2018-07-04 09:38:33', '2018-07-04 09:38:33');
INSERT INTO `t_ums_data_config` VALUES ('478', '27', '03-0018', '动力学缓冲液', '9', '2018-07-04 09:38:53', '2018-07-04 09:38:53');
INSERT INTO `t_ums_data_config` VALUES ('479', '27', '03-0019', '10mM甘氨酸溶液，pH1.7', '9', '2018-07-04 09:39:25', '2018-07-04 09:39:25');
INSERT INTO `t_ums_data_config` VALUES ('480', '27', '03-0020', 'ProA测试试剂', '9', '2018-07-04 09:40:02', '2018-07-04 09:40:02');
INSERT INTO `t_ums_data_config` VALUES ('481', '27', '03-0029', '100ug/mL生物碳酸酐酶', '9', '2018-07-04 09:41:20', '2018-07-04 09:41:20');
INSERT INTO `t_ums_data_config` VALUES ('482', '27', '03-0031', '10ug/mL HIgG1', '9', '2018-07-04 09:42:28', '2018-07-04 09:42:28');
INSERT INTO `t_ums_data_config` VALUES ('483', '27', '03-0032', '5ug/mL HIgG2', '9', '2018-07-04 09:42:51', '2018-07-04 09:42:51');
INSERT INTO `t_ums_data_config` VALUES ('485', '27', '03-0033', '200 nM Anti-HIgG Fab', '9', '2018-07-04 09:44:47', '2018-07-04 09:44:47');
INSERT INTO `t_ums_data_config` VALUES ('486', '27', '03-0034', '20ug/mL牛胰岛素溶液', '9', '2018-07-04 09:45:43', '2018-07-04 09:45:43');
INSERT INTO `t_ums_data_config` VALUES ('487', '27', '03-0035', '100ug/mL HIgG溶液', '9', '2018-07-04 09:46:04', '2018-07-04 09:46:04');
INSERT INTO `t_ums_data_config` VALUES ('488', '27', '03-0036', '6ug/mL HIgG溶液', '9', '2018-07-04 09:46:36', '2018-07-04 09:46:36');
INSERT INTO `t_ums_data_config` VALUES ('489', '27', '03-0037', '1:500 anti-BSA溶液', '9', '2018-07-04 09:47:02', '2018-07-04 09:47:02');
INSERT INTO `t_ums_data_config` VALUES ('490', '27', '03-0038', '10mM甘氨酸溶液，pH1.0', '9', '2018-07-04 09:47:20', '2018-07-04 09:47:20');
INSERT INTO `t_ums_data_config` VALUES ('491', '27', '03-0039', '10mM甘氨酸溶液，pH1.5', '9', '2018-07-04 09:47:41', '2018-07-04 09:47:41');
INSERT INTO `t_ums_data_config` VALUES ('492', '27', '03-0041', '100mM碳酸钠溶液', '9', '2018-07-04 09:48:23', '2018-07-04 09:48:23');
INSERT INTO `t_ums_data_config` VALUES ('493', '27', '03-0042', '10mg/mL海藻酸溶液', '9', '2018-07-04 09:49:11', '2018-07-04 09:49:11');
INSERT INTO `t_ums_data_config` VALUES ('494', '27', '03-0043', '10mM醋酸钠溶液，pH4.0', '9', '2018-07-04 09:49:34', '2018-07-04 09:49:34');
INSERT INTO `t_ums_data_config` VALUES ('495', '27', '03-0044', '10mM醋酸钠溶液，pH5.0', '9', '2018-07-04 09:50:26', '2018-07-04 09:50:26');
INSERT INTO `t_ums_data_config` VALUES ('496', '27', '03-0045', '10mM醋酸钠溶液，pH6.0', '9', '2018-07-04 09:50:45', '2018-07-04 09:50:45');
INSERT INTO `t_ums_data_config` VALUES ('497', '27', '03-0048', '10ug/mL MIgG1', '9', '2018-07-04 09:53:34', '2018-07-04 09:53:34');
INSERT INTO `t_ums_data_config` VALUES ('498', '27', '03-0049', '200 nM Anti-MIgG Fab', '9', '2018-07-04 09:53:54', '2018-07-04 09:53:54');
INSERT INTO `t_ums_data_config` VALUES ('499', '27', '03-0050', '20ug/mL MIgG1', '9', '2018-07-04 09:54:16', '2018-07-04 09:54:16');
INSERT INTO `t_ums_data_config` VALUES ('500', '27', '03-0051', '160nM Anti-MIgG Fab', '9', '2018-07-04 09:54:41', '2018-07-04 09:54:41');
INSERT INTO `t_ums_data_config` VALUES ('501', '27', '03-0052', '0.2M Sulfo-NHS in H2O', '9', '2018-07-04 09:55:32', '2018-07-04 09:55:32');
INSERT INTO `t_ums_data_config` VALUES ('502', '27', '03-0053', '0.4M EDC in H2O', '9', '2018-07-04 09:55:55', '2018-07-04 09:55:55');
INSERT INTO `t_ums_data_config` VALUES ('503', '27', '03-0054', 'Furosemide Panel', '9', '2018-07-04 09:56:22', '2018-07-04 09:56:22');
INSERT INTO `t_ums_data_config` VALUES ('504', '27', '03-0055', '5uM 生物胞素', '9', '2018-07-04 09:56:41', '2018-07-04 09:56:41');
INSERT INTO `t_ums_data_config` VALUES ('505', '27', '03-0056', 'His-ProA Panel', '9', '2018-07-04 09:57:01', '2018-07-04 09:57:01');
INSERT INTO `t_ums_data_config` VALUES ('506', '27', '03-0067', '动力学缓冲液（For Biosensor QC）', '9', '2018-07-04 09:58:10', '2018-07-04 09:58:10');
INSERT INTO `t_ums_data_config` VALUES ('507', '27', '03-0078', '10X动力学缓冲液(ProClin 300)', '9', '2018-07-04 09:58:35', '2018-07-04 09:59:28');
INSERT INTO `t_ums_data_config` VALUES ('508', '27', '03-0123', 'PBS,PH7.4,with Proclin 0.5%', '9', '2018-07-04 09:59:55', '2018-07-04 09:59:55');
INSERT INTO `t_ums_data_config` VALUES ('509', '27', '04-0004', '链霉亲和素三聚体', '9', '2018-07-04 11:43:03', '2018-07-04 11:43:03');
INSERT INTO `t_ums_data_config` VALUES ('510', '27', '04-0005', '长链生物素偶联蛋白A', '9', '2018-07-04 11:43:19', '2018-07-04 11:43:19');
INSERT INTO `t_ums_data_config` VALUES ('511', '27', '04-0006', '双长链生物素偶联蛋白A', '9', '2018-07-04 11:43:34', '2018-07-04 11:43:34');
INSERT INTO `t_ums_data_config` VALUES ('512', '27', '04-0007', '链霉亲和素三聚体（PBS）', '9', '2018-07-04 11:45:02', '2018-07-04 11:45:02');
INSERT INTO `t_ums_data_config` VALUES ('513', '27', '04-0008', '双长链生物素偶联抗鼠免疫球蛋白抗体', '9', '2018-07-04 11:45:30', '2018-07-04 11:45:30');
INSERT INTO `t_ums_data_config` VALUES ('514', '27', '04-0009', '链霉亲和素三聚体（无吐温）', '9', '2018-07-04 11:45:54', '2018-07-04 11:45:54');
INSERT INTO `t_ums_data_config` VALUES ('515', '27', '04-0010', '双长链生物素偶联牛碳酸酐酶', '9', '2018-07-04 11:46:13', '2018-07-04 11:46:13');
INSERT INTO `t_ums_data_config` VALUES ('516', '27', '04-0011', '生物素偶联抗人免疫球蛋白抗体', '9', '2018-07-04 11:46:29', '2018-07-04 11:46:29');
INSERT INTO `t_ums_data_config` VALUES ('517', '27', '04-0013', 'SA conjugate(for SA)', '9', '2018-07-04 11:47:21', '2018-07-04 11:47:21');
INSERT INTO `t_ums_data_config` VALUES ('518', '27', '04-0015', '链霉亲和素三聚体（SSA）', '9', '2018-07-04 11:47:48', '2018-07-04 11:47:48');
INSERT INTO `t_ums_data_config` VALUES ('519', '27', '04-0016', 'Bio-LCLC-anti-HIS双长链生物素偶联抗HIS抗体', '9', '2018-07-04 11:48:10', '2018-07-04 11:48:10');
INSERT INTO `t_ums_data_config` VALUES ('520', '27', '04-0019', '双长链生物素偶联蛋白G', '9', '2018-07-04 11:48:24', '2018-07-04 11:48:24');
INSERT INTO `t_ums_data_config` VALUES ('521', '27', '04-0020', '双长链生物素偶联蛋白L', '9', '2018-07-04 11:49:17', '2018-07-04 11:49:17');
INSERT INTO `t_ums_data_config` VALUES ('522', '27', '04-0021', '双长链生物素偶联抗鼠免疫球蛋白抗体（For AMC)', '9', '2018-07-04 11:49:45', '2018-07-04 11:49:45');
INSERT INTO `t_ums_data_config` VALUES ('523', '27', '04-0022', '双长链生物素偶联抗GST抗体', '9', '2018-07-04 11:50:23', '2018-07-04 11:50:23');
INSERT INTO `t_ums_data_config` VALUES ('524', '27', '04-0026', '双长链生物素-xHIS2母液', '9', '2018-07-04 11:51:38', '2018-07-04 11:51:38');
INSERT INTO `t_ums_data_config` VALUES ('525', '27', '04-0028', '双长链生物素-xHIS母液', '9', '2018-07-04 11:52:07', '2018-07-04 11:52:07');
INSERT INTO `t_ums_data_config` VALUES ('526', '27', '04-0029', 'Biotin-anti-IgG-CH1 Conjugate', '9', '2018-07-04 11:52:30', '2018-07-04 11:52:30');
INSERT INTO `t_ums_data_config` VALUES ('527', '27', '04-0033', 'LC-Biotin-Protein A (Kathon)连接物', '9', '2018-07-04 11:53:09', '2018-07-04 11:53:09');
INSERT INTO `t_ums_data_config` VALUES ('528', '27', '05-0011', '标准品稀释液', '9', '2018-07-04 11:56:02', '2018-07-04 11:56:02');
INSERT INTO `t_ums_data_config` VALUES ('529', '27', '05-0024', '样品稀释液', '9', '2018-07-04 11:56:20', '2018-07-04 11:56:20');
INSERT INTO `t_ums_data_config` VALUES ('530', '27', '05-0033', 'HIgG标准品试剂', '9', '2018-07-04 11:56:47', '2018-07-04 11:56:47');
INSERT INTO `t_ums_data_config` VALUES ('531', '27', '05-0038', 'ProA标准品系列', '9', '2018-07-04 11:57:10', '2018-07-04 11:57:10');
INSERT INTO `t_ums_data_config` VALUES ('532', '27', '05-0039', 'ProA精度测试试剂', '9', '2018-07-04 11:57:44', '2018-07-04 11:57:44');
INSERT INTO `t_ums_data_config` VALUES ('533', '27', '05-0048', 'MIgG标准品试剂', '9', '2018-07-04 12:04:05', '2018-07-04 12:04:05');
INSERT INTO `t_ums_data_config` VALUES ('534', '27', '05-0051', '样品稀释液(W/O)', '9', '2018-07-04 12:04:48', '2018-07-04 12:04:48');
INSERT INTO `t_ums_data_config` VALUES ('535', '27', '05-0052', '10mM甘氨酸溶液，pH2.0', '9', '2018-07-04 12:05:06', '2018-07-04 12:05:06');
INSERT INTO `t_ums_data_config` VALUES ('536', '27', '05-0056', '大浓度范围ProA标准品系列', '9', '2018-07-04 12:05:54', '2018-07-04 12:05:54');
INSERT INTO `t_ums_data_config` VALUES ('537', '27', '05-0058', '5uM生物胞素溶液（PBS）', '9', '2018-07-04 12:06:19', '2018-07-04 12:06:19');
INSERT INTO `t_ums_data_config` VALUES ('538', '27', '05-0067', '样品稀释液(ProClin 300)', '9', '2018-07-04 12:07:19', '2018-07-04 12:07:19');
INSERT INTO `t_ums_data_config` VALUES ('539', '27', '05-0073', 'HIgG平行性测试试剂', '9', '2018-07-04 12:08:56', '2018-07-04 12:08:56');
INSERT INTO `t_ums_data_config` VALUES ('540', '27', '05-0074', 'HIgG精度测试试剂', '9', '2018-07-04 12:09:12', '2018-07-04 12:09:12');
INSERT INTO `t_ums_data_config` VALUES ('541', '27', '05-0075', 'MIgG平行性测试试剂', '9', '2018-07-04 12:09:26', '2018-07-04 12:09:26');
INSERT INTO `t_ums_data_config` VALUES ('542', '27', '05-0076', 'MIgG精度测试试剂', '9', '2018-07-04 12:09:40', '2018-07-04 12:09:40');
INSERT INTO `t_ums_data_config` VALUES ('543', '27', '05-0077', 'HIgG测试试剂', '9', '2018-07-04 12:09:53', '2018-07-04 12:09:53');
INSERT INTO `t_ums_data_config` VALUES ('544', '27', '05-0078', 'MIgG测试试剂', '9', '2018-07-04 12:10:06', '2018-07-04 12:10:06');
INSERT INTO `t_ums_data_config` VALUES ('545', '27', '05-0079', 'Bio-ProA标准品试剂', '9', '2018-07-04 12:10:20', '2018-07-04 12:10:20');
INSERT INTO `t_ums_data_config` VALUES ('546', '27', '05-0080', 'HBC测试试剂', '9', '2018-07-04 12:10:35', '2018-07-04 12:10:35');
INSERT INTO `t_ums_data_config` VALUES ('547', '27', '05-0091', 'ProG标准品系列', '9', '2018-07-04 12:11:04', '2018-07-04 12:11:04');
INSERT INTO `t_ums_data_config` VALUES ('548', '27', '05-0094', 'ProG测试试剂', '9', '2018-07-04 12:11:22', '2018-07-04 12:11:22');
INSERT INTO `t_ums_data_config` VALUES ('549', '27', '05-0096', 'ProL标准品系列', '9', '2018-07-04 12:11:37', '2018-07-04 12:11:37');
INSERT INTO `t_ums_data_config` VALUES ('550', '27', '05-5001', '25ug/mL ProA溶液', '9', '2018-07-04 12:13:20', '2018-07-04 12:13:20');
INSERT INTO `t_ums_data_config` VALUES ('551', '27', '05-5002', '0.4M EDC储液', '9', '2018-07-04 12:13:35', '2018-07-04 12:13:35');
INSERT INTO `t_ums_data_config` VALUES ('552', '27', '05-5004', '0.1M MES溶液', '9', '2018-07-04 12:14:45', '2018-07-04 12:14:45');
INSERT INTO `t_ums_data_config` VALUES ('553', '27', '05-5005', '0.1M NHS储液', '9', '2018-07-04 12:15:00', '2018-07-04 12:15:00');
INSERT INTO `t_ums_data_config` VALUES ('554', '27', '05-5009', 'Bio-ProA稀释液', '9', '2018-07-04 12:15:23', '2018-07-04 12:15:23');
INSERT INTO `t_ums_data_config` VALUES ('555', '27', '05-5012', 'ProG精度测试试剂', '9', '2018-07-04 12:15:39', '2018-07-04 12:15:39');
INSERT INTO `t_ums_data_config` VALUES ('556', '27', '05-5014', '1mg/mL ProA', '9', '2018-07-04 12:16:33', '2018-07-04 12:16:33');
INSERT INTO `t_ums_data_config` VALUES ('557', '27', '05-5015', '1mg/mL His-ProA溶液', '9', '2018-07-04 12:16:52', '2018-07-04 12:16:52');
INSERT INTO `t_ums_data_config` VALUES ('558', '27', '05-5017', 'ProL精度测试试剂', '9', '2018-07-04 12:17:13', '2018-07-04 12:17:13');
INSERT INTO `t_ums_data_config` VALUES ('559', '27', '05-5018', 'Ubi GST Panel', '9', '2018-07-04 12:17:48', '2018-07-04 12:17:48');
INSERT INTO `t_ums_data_config` VALUES ('560', '27', '05-5019', '10ug/mL Ubi-GST ', '9', '2018-07-04 12:18:01', '2018-07-04 12:18:01');
INSERT INTO `t_ums_data_config` VALUES ('561', '27', '05-5020', '50nM Anti-Ubi', '9', '2018-07-04 12:18:15', '2018-07-04 12:18:15');
INSERT INTO `t_ums_data_config` VALUES ('562', '27', '05-5021', 'His-ProA Panel for Ni-NTA', '9', '2018-07-04 12:18:39', '2018-07-04 12:18:39');
INSERT INTO `t_ums_data_config` VALUES ('563', '27', '05-5022', '20 ug/mL His-Pro A', '9', '2018-07-04 12:18:59', '2018-07-04 12:18:59');
INSERT INTO `t_ums_data_config` VALUES ('564', '27', '05-5024', '1mg/mL His-Pro A', '9', '2018-07-04 12:19:46', '2018-07-04 12:19:46');
INSERT INTO `t_ums_data_config` VALUES ('565', '27', '05-5024A', '1 mg/mL His-Pro A for HIS2', '9', '2018-07-04 12:20:11', '2018-07-04 12:20:11');
INSERT INTO `t_ums_data_config` VALUES ('566', '27', '05-5024B', '1 mg/mL His-Pro A for HIS1K', '9', '2018-07-04 12:21:17', '2018-07-04 12:21:17');
INSERT INTO `t_ums_data_config` VALUES ('567', '27', '05-5025', '50mg/mL His-Pro A for NTA PQC', '9', '2018-07-04 12:22:03', '2018-07-04 12:22:03');
INSERT INTO `t_ums_data_config` VALUES ('568', '27', '05-9053', 'ProA平行性测试试剂', '9', '2018-07-04 12:22:25', '2018-07-04 12:22:25');
INSERT INTO `t_ums_data_config` VALUES ('569', '34', '01-0012', '海藻糖', '9', '2018-07-04 12:53:34', '2018-07-04 12:53:34');
INSERT INTO `t_ums_data_config` VALUES ('570', '34', '01-0014', '苯甲脒', '9', '2018-07-04 12:54:16', '2018-07-04 12:54:16');
INSERT INTO `t_ums_data_config` VALUES ('571', '34', '01-0015', '亮肽酶素', '9', '2018-07-04 12:54:33', '2018-07-04 12:54:33');
INSERT INTO `t_ums_data_config` VALUES ('572', '34', '01-0018', '短链生物素', '9', '2018-07-04 12:54:59', '2018-07-04 12:54:59');
INSERT INTO `t_ums_data_config` VALUES ('573', '34', '01-0021', 'MES hydrate', '9', '2018-07-04 12:55:48', '2018-07-04 12:55:48');
INSERT INTO `t_ums_data_config` VALUES ('574', '34', '01-0023', 'EDC', '9', '2018-07-04 12:56:18', '2018-07-04 12:56:18');
INSERT INTO `t_ums_data_config` VALUES ('575', '34', '01-0024', 'NHS', '9', '2018-07-04 12:56:27', '2018-07-04 12:56:27');
INSERT INTO `t_ums_data_config` VALUES ('576', '34', '01-0032', '甘氨酸', '9', '2018-07-04 12:57:29', '2018-07-04 12:57:29');
INSERT INTO `t_ums_data_config` VALUES ('577', '34', '01-0033', '生物胞素', '9', '2018-07-04 12:57:44', '2018-07-04 12:57:44');
INSERT INTO `t_ums_data_config` VALUES ('578', '34', '01-0034', '利尿磺胺', '9', '2018-07-04 12:57:58', '2018-07-04 12:57:58');
INSERT INTO `t_ums_data_config` VALUES ('579', '34', '01-0035', 'DMSO', '9', '2018-07-04 12:58:12', '2018-07-04 12:58:12');
INSERT INTO `t_ums_data_config` VALUES ('580', '34', '01-0046', '醋酸', '9', '2018-07-04 12:58:50', '2018-07-04 12:58:50');
INSERT INTO `t_ums_data_config` VALUES ('581', '34', '01-0054', 'TWEEN 20', '9', '2018-07-04 12:59:30', '2018-07-04 12:59:30');
INSERT INTO `t_ums_data_config` VALUES ('582', '34', '01-0055', '环氧硅烷', '9', '2018-07-04 12:59:46', '2018-07-04 12:59:46');
INSERT INTO `t_ums_data_config` VALUES ('583', '34', '01-0056', '醋酸钠', '9', '2018-07-04 13:00:15', '2018-07-04 13:00:15');
INSERT INTO `t_ums_data_config` VALUES ('584', '34', '01-0057', '碳酸钠', '9', '2018-07-04 13:00:27', '2018-07-04 13:00:27');
INSERT INTO `t_ums_data_config` VALUES ('585', '34', '01-0058', '异丙醇', '9', '2018-07-04 13:00:57', '2018-07-04 13:00:57');
INSERT INTO `t_ums_data_config` VALUES ('586', '34', '01-0066', 'EDC, Pierce', '9', '2018-07-04 13:01:38', '2018-07-04 13:01:38');
INSERT INTO `t_ums_data_config` VALUES ('587', '34', '01-0067', 'PBS, Bottled', '9', '2018-07-04 13:01:51', '2018-07-04 13:01:51');
INSERT INTO `t_ums_data_config` VALUES ('588', '34', '01-0068', 'DISTILLED WATER, Bottled', '9', '2018-07-04 13:02:08', '2018-07-04 13:02:08');
INSERT INTO `t_ums_data_config` VALUES ('589', '34', '02-0005', 'Protein A', '9', '2018-07-04 13:06:31', '2018-07-04 13:23:37');
INSERT INTO `t_ums_data_config` VALUES ('590', '34', '02-0007', 'MIgG', '9', '2018-07-04 13:06:49', '2018-07-04 13:06:49');
INSERT INTO `t_ums_data_config` VALUES ('591', '34', '02-0009', '牛胰岛素', '9', '2018-07-04 13:07:13', '2018-07-04 13:07:13');
INSERT INTO `t_ums_data_config` VALUES ('592', '34', '02-0010', '碳酸酐酶', '9', '2018-07-04 13:07:28', '2018-07-04 13:07:28');
INSERT INTO `t_ums_data_config` VALUES ('593', '34', '02-0013', '人免疫球蛋白2（HIgG2）', '9', '2018-07-04 13:07:55', '2018-07-04 13:07:55');
INSERT INTO `t_ums_data_config` VALUES ('594', '34', '02-0015', '超纯牛血清白蛋白', '9', '2018-07-04 13:08:17', '2018-07-04 13:08:17');
INSERT INTO `t_ums_data_config` VALUES ('595', '34', '02-0016', '人免疫球蛋白1(HIgG1)', '9', '2018-07-04 13:09:17', '2018-07-04 13:09:17');
INSERT INTO `t_ums_data_config` VALUES ('596', '34', '02-0017', '羊抗人免疫球蛋白抗体Fab片段', '9', '2018-07-04 13:09:48', '2018-07-04 13:09:48');
INSERT INTO `t_ums_data_config` VALUES ('597', '34', '02-0019', '兔抗牛血清白蛋白抗体', '9', '2018-07-04 13:10:03', '2018-07-04 13:10:03');
INSERT INTO `t_ums_data_config` VALUES ('598', '34', '02-0031', '鼠免疫球蛋白1(MIgG1)', '9', '2018-07-04 13:10:25', '2018-07-04 13:10:25');
INSERT INTO `t_ums_data_config` VALUES ('599', '34', '02-0032', '羊抗鼠免疫球蛋白抗体Fab片段', '9', '2018-07-04 13:10:43', '2018-07-04 13:10:43');
INSERT INTO `t_ums_data_config` VALUES ('600', '34', '02-0035', '海藻酸', '9', '2018-07-04 13:11:25', '2018-07-04 13:11:25');
INSERT INTO `t_ums_data_config` VALUES ('601', '34', '02-0037', 'Sulfo-NHS', '9', '2018-07-04 13:11:44', '2018-07-04 13:11:44');
INSERT INTO `t_ums_data_config` VALUES ('602', '34', '02-0040', 'Ubiquitin-GST', '9', '2018-07-04 13:12:03', '2018-07-04 13:12:03');
INSERT INTO `t_ums_data_config` VALUES ('603', '34', '02-0043', 'Anti-Ubi', '9', '2018-07-04 13:12:15', '2018-07-04 13:12:15');
INSERT INTO `t_ums_data_config` VALUES ('604', '34', '02-0044', 'Biotin-Tris-NTA(in PBS)', '9', '2018-07-04 13:12:28', '2018-07-04 13:12:28');
INSERT INTO `t_ums_data_config` VALUES ('605', '34', '02-0051', 'HIgG Fab', '9', '2018-07-04 13:12:40', '2018-07-04 13:12:40');
INSERT INTO `t_ums_data_config` VALUES ('606', '34', '02-0052', 'Fab Fragment Goat@HIgG (H+L)', '9', '2018-07-04 13:12:53', '2018-07-04 13:12:53');
INSERT INTO `t_ums_data_config` VALUES ('607', '34', '02-0054', 'Biotin-anti-IgG-CH1', '9', '2018-07-04 13:13:06', '2018-07-04 13:13:06');
INSERT INTO `t_ums_data_config` VALUES ('608', '34', '02-5011', '50mg/mL His-ProA For Anti-HIS（HIS2） Biosensor QC', '9', '2018-07-04 13:15:09', '2018-07-04 13:15:09');
INSERT INTO `t_ums_data_config` VALUES ('609', '34', '02-5018', '50mg/mL His-ProA For Anti-Penta-HIS (HIS1K) Biosensor QC', '9', '2018-07-04 13:15:24', '2018-07-04 13:15:24');
INSERT INTO `t_ums_data_config` VALUES ('610', '34', '02-5019', 'His-rrCRP', '9', '2018-07-04 13:15:37', '2018-07-04 13:15:37');
INSERT INTO `t_ums_data_config` VALUES ('611', '34', '02-5020', 'Anti-rrCRP', '9', '2018-07-04 13:16:06', '2018-07-04 13:16:06');
INSERT INTO `t_ums_data_config` VALUES ('612', '34', '01-0106', 'PBS试剂包（5L）', '9', '2018-07-04 13:16:50', '2018-07-04 13:16:50');
INSERT INTO `t_ums_data_config` VALUES ('613', '34', '01-0005', 'SATA', '9', '2018-07-04 13:19:19', '2018-07-04 13:19:19');
INSERT INTO `t_ums_data_config` VALUES ('614', '34', '01-0006', 'SMCC', '9', '2018-07-04 13:19:42', '2018-07-04 13:19:42');
INSERT INTO `t_ums_data_config` VALUES ('615', '34', '01-0007', 'HYDROXLYLAMINE-HYDROCHLORIDE', '9', '2018-07-04 13:19:57', '2018-07-04 13:19:57');
INSERT INTO `t_ums_data_config` VALUES ('616', '34', '01-0008', 'N-ETHYLMALEIMIDE', '9', '2018-07-04 13:20:13', '2018-07-04 13:20:13');
INSERT INTO `t_ums_data_config` VALUES ('617', '34', '01-0013', 'NHS-LC-BIOTIN, EZ-LINK', '9', '2018-07-04 13:20:29', '2018-07-04 13:20:29');
INSERT INTO `t_ums_data_config` VALUES ('618', '34', '01-0016', 'SODIUM HYDROXIDE，2N （VWR）', '9', '2018-07-04 13:20:44', '2018-07-04 13:20:44');
INSERT INTO `t_ums_data_config` VALUES ('619', '34', '01-0017', 'EDTA', '9', '2018-07-04 13:20:53', '2018-07-04 13:20:53');
INSERT INTO `t_ums_data_config` VALUES ('620', '34', '02-0003', 'ANTI-HUMAN IGG，GOAT FC GAMMA', '9', '2018-07-04 13:21:13', '2018-07-04 13:21:13');
INSERT INTO `t_ums_data_config` VALUES ('621', '34', '02-0004', 'STREPTAVIDIN，RECOMBINANT', '9', '2018-07-04 13:21:30', '2018-07-04 13:21:30');
INSERT INTO `t_ums_data_config` VALUES ('622', '34', '02-0006', 'ANTI-MOUSE IGG, GOAT F(AB\')2 SPECIFIC', '9', '2018-07-04 13:21:42', '2018-07-04 13:21:42');
INSERT INTO `t_ums_data_config` VALUES ('623', '34', '02-0020', 'PENTA-His ANTIBODY, BSA FREE', '9', '2018-07-04 13:21:57', '2018-07-04 13:21:57');
INSERT INTO `t_ums_data_config` VALUES ('624', '34', '02-0025', 'Protein G (1*5mg=5mg)', '9', '2018-07-04 13:22:12', '2018-07-04 13:22:12');
INSERT INTO `t_ums_data_config` VALUES ('625', '34', '02-0027', 'Protein L', '9', '2018-07-04 13:22:28', '2018-07-04 13:22:28');
INSERT INTO `t_ums_data_config` VALUES ('626', '34', '02-0029', 'Goat anti-Mouse IgG Fc', '9', '2018-07-04 13:22:41', '2018-07-04 13:22:41');
INSERT INTO `t_ums_data_config` VALUES ('627', '34', '02-0057', 'STREPTAVIDIN，PROZYME', '9', '2018-07-04 13:22:56', '2018-07-04 13:22:56');
INSERT INTO `t_ums_data_config` VALUES ('628', '34', '02-0039A', 'Anti-GST (Goat) Antibody', '9', '2018-07-04 13:23:10', '2018-07-04 13:23:10');
INSERT INTO `t_ums_data_config` VALUES ('629', '34', '02-0048A', 'Mouse anti-HIS Ab', '9', '2018-07-04 13:23:24', '2018-07-04 13:23:24');
INSERT INTO `t_ums_data_config` VALUES ('633', '191', '崩边', '', '9', '2018-07-10 11:57:21', '2018-07-10 11:57:21');
INSERT INTO `t_ums_data_config` VALUES ('634', '191', '划痕', '', '9', '2018-07-10 11:57:29', '2018-07-10 11:57:29');
INSERT INTO `t_ums_data_config` VALUES ('635', '191', '异物', '', '9', '2018-07-10 11:57:38', '2018-07-10 11:57:38');
INSERT INTO `t_ums_data_config` VALUES ('636', '191', '胶', '', '9', '2018-07-10 11:57:44', '2018-07-10 11:57:44');
INSERT INTO `t_ums_data_config` VALUES ('637', '191', '印迹', '', '9', '2018-07-10 11:57:55', '2018-07-10 11:57:55');
INSERT INTO `t_ums_data_config` VALUES ('639', '191', '绿膜', '', '9', '2018-07-10 11:58:26', '2018-07-10 11:58:26');
INSERT INTO `t_ums_data_config` VALUES ('640', '191', '彩虹到芯', '', '9', '2018-07-10 11:58:44', '2018-07-10 11:58:44');
INSERT INTO `t_ums_data_config` VALUES ('641', '191', '膜层脱落', '', '9', '2018-07-10 11:58:52', '2018-07-10 11:58:52');
INSERT INTO `t_ums_data_config` VALUES ('642', '191', '膜下异物', '', '9', '2018-07-10 11:58:59', '2018-07-10 11:58:59');
INSERT INTO `t_ums_data_config` VALUES ('643', '191', '缝隙', '', '9', '2018-07-10 11:59:07', '2018-07-10 11:59:07');
INSERT INTO `t_ums_data_config` VALUES ('644', '191', '其它', '', '9', '2018-07-10 11:59:12', '2018-07-10 11:59:12');
INSERT INTO `t_ums_data_config` VALUES ('646', '27', '01-0001', '双长链生物素', '9', '2018-07-10 15:25:52', '2018-07-10 15:26:40');
INSERT INTO `t_ums_data_config` VALUES ('647', '27', '01-0002', 'PBS试剂包(1L)', '9', '2018-07-10 15:27:12', '2018-07-10 15:27:12');
INSERT INTO `t_ums_data_config` VALUES ('648', '27', '01-0106', 'PBS试剂包(5L)', '9', '2018-07-10 15:27:30', '2018-07-10 15:27:30');
INSERT INTO `t_ums_data_config` VALUES ('649', '27', '01-0003', 'DMF', '9', '2018-07-10 15:28:02', '2018-07-10 15:28:02');
INSERT INTO `t_ums_data_config` VALUES ('650', '27', '01-0004', '迭氮化钠', '9', '2018-07-10 15:28:37', '2018-07-10 15:28:37');
INSERT INTO `t_ums_data_config` VALUES ('651', '27', '01-0009', '吐温 20', '9', '2018-07-10 15:28:54', '2018-07-10 15:28:54');
INSERT INTO `t_ums_data_config` VALUES ('652', '27', '01-0011', '蔗糖', '9', '2018-07-10 15:29:10', '2018-07-10 15:29:10');
INSERT INTO `t_ums_data_config` VALUES ('653', '27', '01-0012', '海藻糖', '9', '2018-07-10 15:29:23', '2018-07-10 15:29:48');
INSERT INTO `t_ums_data_config` VALUES ('654', '27', '01-0014', '苯甲脒', '9', '2018-07-10 15:30:09', '2018-07-10 15:30:09');
INSERT INTO `t_ums_data_config` VALUES ('655', '27', '01-0015', '亮肽酶素', '9', '2018-07-10 15:30:24', '2018-07-10 15:30:24');
INSERT INTO `t_ums_data_config` VALUES ('656', '27', '01-0018', '短链生物素', '9', '2018-07-10 15:30:41', '2018-07-10 15:30:41');
INSERT INTO `t_ums_data_config` VALUES ('657', '27', '01-0021', 'MES', '9', '2018-07-10 15:30:55', '2018-07-10 15:30:55');
INSERT INTO `t_ums_data_config` VALUES ('658', '27', '01-0022', '氢氧化钾', '9', '2018-07-10 15:31:30', '2018-07-10 15:31:30');
INSERT INTO `t_ums_data_config` VALUES ('659', '27', '01-0023', 'EDC', '9', '2018-07-10 15:31:53', '2018-07-10 15:31:53');
INSERT INTO `t_ums_data_config` VALUES ('660', '27', '01-0024', 'NHS', '9', '2018-07-10 15:32:08', '2018-07-10 15:32:08');
INSERT INTO `t_ums_data_config` VALUES ('661', '27', '01-0025', '乙醇胺', '9', '2018-07-10 15:32:27', '2018-07-10 15:32:27');
INSERT INTO `t_ums_data_config` VALUES ('662', '27', '01-0026', 'BS3', '9', '2018-07-10 15:32:45', '2018-07-10 15:32:45');
INSERT INTO `t_ums_data_config` VALUES ('663', '27', '01-0027', '磷酸一氢钠', '9', '2018-07-10 15:33:11', '2018-07-10 15:33:11');
INSERT INTO `t_ums_data_config` VALUES ('664', '27', '01-0028', '盐酸', '9', '2018-07-10 15:33:28', '2018-07-10 15:33:28');
INSERT INTO `t_ums_data_config` VALUES ('665', '27', '01-0029', '磷酸二氢钠', '9', '2018-07-10 15:33:49', '2018-07-10 15:33:49');
INSERT INTO `t_ums_data_config` VALUES ('666', '27', '01-0030', '戊二醛', '9', '2018-07-10 15:34:09', '2018-07-10 15:34:09');
INSERT INTO `t_ums_data_config` VALUES ('667', '27', '01-0032', '甘氨酸', '9', '2018-07-10 15:34:24', '2018-07-10 15:34:24');
INSERT INTO `t_ums_data_config` VALUES ('668', '27', '01-0033', '生物胞素', '9', '2018-07-10 15:34:40', '2018-07-10 15:34:40');
INSERT INTO `t_ums_data_config` VALUES ('669', '27', '01-0034', '利尿磺胺', '9', '2018-07-10 15:34:55', '2018-07-10 15:34:55');
INSERT INTO `t_ums_data_config` VALUES ('670', '27', '01-0035', 'DMSO', '9', '2018-07-10 15:35:10', '2018-07-10 15:35:10');
INSERT INTO `t_ums_data_config` VALUES ('671', '27', '01-0045', 'Proclin 300 ', '9', '2018-07-10 15:35:40', '2018-07-10 15:35:40');
INSERT INTO `t_ums_data_config` VALUES ('672', '27', '01-0046', '醋酸\r\n', '9', '2018-07-10 15:35:57', '2018-07-10 15:35:57');
INSERT INTO `t_ums_data_config` VALUES ('673', '27', '01-0048', '氯化钠', '9', '2018-07-10 15:36:17', '2018-07-10 15:36:17');
INSERT INTO `t_ums_data_config` VALUES ('674', '27', '01-0054', 'TWEEN 20', '9', '2018-07-10 15:36:35', '2018-07-10 15:36:35');
INSERT INTO `t_ums_data_config` VALUES ('675', '27', '01-0055', '环氧硅烷', '9', '2018-07-10 15:36:52', '2018-07-10 15:36:52');
INSERT INTO `t_ums_data_config` VALUES ('676', '27', '01-0056', '醋酸钠', '9', '2018-07-10 15:37:09', '2018-07-10 15:37:09');
INSERT INTO `t_ums_data_config` VALUES ('677', '27', '01-0057', '碳酸钠', '9', '2018-07-10 15:37:21', '2018-07-10 15:37:21');
INSERT INTO `t_ums_data_config` VALUES ('678', '27', '01-0058', '异丙醇', '9', '2018-07-10 15:37:32', '2018-07-10 15:37:32');
INSERT INTO `t_ums_data_config` VALUES ('679', '27', '01-0062', '氯化镍', '9', '2018-07-10 15:37:44', '2018-07-10 15:37:44');
INSERT INTO `t_ums_data_config` VALUES ('680', '27', '01-0063', 'HEPES试剂包', '9', '2018-07-10 15:37:58', '2018-07-10 15:37:58');
INSERT INTO `t_ums_data_config` VALUES ('681', '27', '01-0066', 'EDC, Pierce', '9', '2018-07-10 15:38:16', '2018-07-10 15:38:16');
INSERT INTO `t_ums_data_config` VALUES ('682', '27', '01-0067', 'PBS, Bottled', '9', '2018-07-10 15:38:29', '2018-07-10 15:38:29');
INSERT INTO `t_ums_data_config` VALUES ('683', '27', '01-0068', 'DISTILLED WATER, Bottled', '9', '2018-07-10 15:38:44', '2018-07-10 15:38:44');
INSERT INTO `t_ums_data_config` VALUES ('684', '27', '02-0001', '人免疫球蛋白（HIgG）', '9', '2018-07-10 15:39:44', '2018-07-10 15:39:44');
INSERT INTO `t_ums_data_config` VALUES ('685', '27', '02-0002', '牛血清白蛋白', '9', '2018-07-10 15:39:58', '2018-07-10 15:39:58');
INSERT INTO `t_ums_data_config` VALUES ('686', '27', '02-0005', 'ProteinA', '9', '2018-07-10 15:40:20', '2018-07-10 15:40:20');
INSERT INTO `t_ums_data_config` VALUES ('687', '27', '02-0007', '鼠免疫球蛋白(MIgG)', '9', '2018-07-10 15:40:43', '2018-07-10 15:40:43');
INSERT INTO `t_ums_data_config` VALUES ('688', '27', '02-0009', '牛胰岛素', '9', '2018-07-10 15:40:57', '2018-07-10 15:40:57');
INSERT INTO `t_ums_data_config` VALUES ('689', '27', '02-0010', '碳酸酐酶', '9', '2018-07-10 15:41:20', '2018-07-10 15:41:20');
INSERT INTO `t_ums_data_config` VALUES ('690', '27', '02-0013', '人免疫球蛋白2(HIgG2)', '9', '2018-07-10 15:41:40', '2018-07-10 15:41:40');
INSERT INTO `t_ums_data_config` VALUES ('691', '27', '02-0015', '超纯牛血清白蛋白', '9', '2018-07-10 15:41:56', '2018-07-10 15:41:56');
INSERT INTO `t_ums_data_config` VALUES ('692', '27', '02-0016', '人免疫球蛋白1(HIgG1)', '9', '2018-07-10 15:42:20', '2018-07-10 15:42:20');
INSERT INTO `t_ums_data_config` VALUES ('693', '27', '02-0017', '羊抗人免疫球蛋白抗体Fab片段', '9', '2018-07-10 15:42:45', '2018-07-10 15:42:45');
INSERT INTO `t_ums_data_config` VALUES ('694', '27', '02-0019', '兔抗牛血清白蛋白抗体', '9', '2018-07-10 15:42:57', '2018-07-10 15:42:57');
INSERT INTO `t_ums_data_config` VALUES ('695', '27', '02-0031', '鼠免疫球蛋白1(MIgG1)', '9', '2018-07-10 15:43:12', '2018-07-10 15:43:22');
INSERT INTO `t_ums_data_config` VALUES ('696', '27', '02-0032', '羊抗鼠免疫球蛋白抗体Fab片段', '9', '2018-07-10 15:43:37', '2018-07-10 15:43:37');
INSERT INTO `t_ums_data_config` VALUES ('697', '27', '02-0035', '海藻酸', '9', '2018-07-10 15:43:49', '2018-07-10 15:43:49');
INSERT INTO `t_ums_data_config` VALUES ('698', '27', '02-0037', 'Sulfo-NHS', '9', '2018-07-10 15:44:10', '2018-07-10 15:44:10');
INSERT INTO `t_ums_data_config` VALUES ('699', '27', '02-0040', 'Ubiquitin-GST', '9', '2018-07-10 15:44:28', '2018-07-10 15:44:28');
INSERT INTO `t_ums_data_config` VALUES ('700', '27', '02-0043', 'Anti-Ubi', '9', '2018-07-10 15:45:14', '2018-07-10 15:45:14');
INSERT INTO `t_ums_data_config` VALUES ('701', '27', '02-0044', 'Biotin-Tris-NTA(in PBS)', '9', '2018-07-10 15:45:29', '2018-07-10 15:45:29');
INSERT INTO `t_ums_data_config` VALUES ('702', '27', '02-0051', 'HIgG Fab', '9', '2018-07-10 15:45:44', '2018-07-10 15:45:44');
INSERT INTO `t_ums_data_config` VALUES ('703', '27', '02-0052', 'Fab Fragment Goat@HIgG (H+L)', '9', '2018-07-10 15:45:59', '2018-07-10 15:45:59');
INSERT INTO `t_ums_data_config` VALUES ('704', '27', '02-0054', 'Biotin-anti-IgG-CH1', '9', '2018-07-10 15:46:13', '2018-07-10 15:46:13');
INSERT INTO `t_ums_data_config` VALUES ('705', '27', '02-5011', '50mg/mL His-ProA For Anti-HIS（HIS2） Biosensor QC', '9', '2018-07-10 15:46:41', '2018-07-10 15:46:41');
INSERT INTO `t_ums_data_config` VALUES ('706', '27', '02-5018', '50mg/mL His-ProA For Anti-Penta-HIS (HIS1K) Biosensor QC', '9', '2018-07-10 15:46:56', '2018-07-10 15:46:56');
INSERT INTO `t_ums_data_config` VALUES ('707', '27', '02-5019', 'His-rrCRP', '9', '2018-07-10 15:47:07', '2018-07-10 15:47:07');
INSERT INTO `t_ums_data_config` VALUES ('708', '27', '02-5020', 'Anti-rrCRP', '9', '2018-07-10 15:47:21', '2018-07-10 15:47:21');
INSERT INTO `t_ums_data_config` VALUES ('709', '27', '01-0005', 'SATA', '9', '2018-07-10 15:48:40', '2018-07-10 15:48:40');
INSERT INTO `t_ums_data_config` VALUES ('710', '27', '01-0006', 'SMCC', '9', '2018-07-10 15:48:52', '2018-07-10 15:48:52');
INSERT INTO `t_ums_data_config` VALUES ('711', '27', '01-0007', 'HYDROXLYLAMINE-HYDROCHLORIDE', '9', '2018-07-10 15:49:03', '2018-07-10 15:49:03');
INSERT INTO `t_ums_data_config` VALUES ('712', '27', '01-0008', 'N-ETHYLMALEIMIDE', '9', '2018-07-10 15:49:15', '2018-07-10 15:49:15');
INSERT INTO `t_ums_data_config` VALUES ('713', '27', '01-0013', 'NHS-LC-BIOTIN, EZ-LINK', '9', '2018-07-10 15:49:26', '2018-07-10 15:49:26');
INSERT INTO `t_ums_data_config` VALUES ('714', '27', '01-0016', 'SODIUM HYDROXIDE，2N （VWR）', '9', '2018-07-10 15:49:38', '2018-07-10 15:49:38');
INSERT INTO `t_ums_data_config` VALUES ('715', '27', '01-0017', 'EDTA', '9', '2018-07-10 15:49:49', '2018-07-10 15:49:49');
INSERT INTO `t_ums_data_config` VALUES ('716', '27', '02-0003', 'ANTI-HUMAN IGG，GOAT FC GAMMA', '9', '2018-07-10 15:50:12', '2018-07-10 15:50:12');
INSERT INTO `t_ums_data_config` VALUES ('717', '27', '02-0004', 'STREPTAVIDIN，RECOMBINANT', '9', '2018-07-10 15:50:23', '2018-07-10 15:50:23');
INSERT INTO `t_ums_data_config` VALUES ('718', '27', '02-0006', 'ANTI-MOUSE IGG, GOAT F(AB\')2 SPECIFIC', '9', '2018-07-10 15:50:37', '2018-07-10 15:50:37');
INSERT INTO `t_ums_data_config` VALUES ('719', '27', '02-0020', 'PENTA-His ANTIBODY, BSA FREE', '9', '2018-07-10 15:50:48', '2018-07-10 15:50:48');
INSERT INTO `t_ums_data_config` VALUES ('720', '27', '02-0025', 'Protein G ', '9', '2018-07-10 15:51:01', '2018-07-10 15:51:01');
INSERT INTO `t_ums_data_config` VALUES ('721', '27', '02-0027', 'Protein L', '9', '2018-07-10 15:51:11', '2018-07-10 15:51:11');
INSERT INTO `t_ums_data_config` VALUES ('722', '27', '02-0029', 'Goat anti-Mouse IgG Fc', '9', '2018-07-10 15:51:22', '2018-07-10 15:51:22');
INSERT INTO `t_ums_data_config` VALUES ('723', '27', '02-0057', 'STREPTAVIDIN，PROZYME', '9', '2018-07-10 15:51:32', '2018-07-10 15:51:32');
INSERT INTO `t_ums_data_config` VALUES ('724', '27', '02-0039A', 'Anti-GST (Goat) Antibody', '9', '2018-07-10 15:51:44', '2018-07-10 15:51:44');
INSERT INTO `t_ums_data_config` VALUES ('725', '27', '02-0048A', 'Mouse anti-HIS Ab', '9', '2018-07-10 15:51:56', '2018-07-10 15:51:56');
INSERT INTO `t_ums_data_config` VALUES ('726', '12', '14-0014', '', '9', '2018-07-10 16:30:36', '2018-07-10 16:30:36');
INSERT INTO `t_ums_data_config` VALUES ('727', '201', '崩边', '', '9', '2018-07-10 16:44:38', '2018-07-10 16:44:38');
INSERT INTO `t_ums_data_config` VALUES ('728', '201', '划痕', '', '9', '2018-07-10 16:44:46', '2018-07-10 16:44:46');
INSERT INTO `t_ums_data_config` VALUES ('729', '201', '异物', '', '9', '2018-07-10 16:44:55', '2018-07-10 16:44:55');
INSERT INTO `t_ums_data_config` VALUES ('730', '201', '胶', '', '9', '2018-07-10 16:45:01', '2018-07-10 16:45:01');
INSERT INTO `t_ums_data_config` VALUES ('731', '201', '印迹', '', '9', '2018-07-10 16:45:10', '2018-07-10 16:45:10');
INSERT INTO `t_ums_data_config` VALUES ('732', '201', '绿膜', '', '9', '2018-07-10 16:45:18', '2018-07-10 16:45:18');
INSERT INTO `t_ums_data_config` VALUES ('733', '201', '彩虹到芯', '', '9', '2018-07-10 16:45:23', '2018-07-10 16:45:23');
INSERT INTO `t_ums_data_config` VALUES ('734', '201', '膜层脱落', '', '9', '2018-07-10 16:45:31', '2018-07-10 16:45:31');
INSERT INTO `t_ums_data_config` VALUES ('735', '201', '膜下异物', '', '9', '2018-07-10 16:45:38', '2018-07-10 16:45:38');
INSERT INTO `t_ums_data_config` VALUES ('736', '201', '缝隙', '', '9', '2018-07-10 16:45:45', '2018-07-10 16:45:45');
INSERT INTO `t_ums_data_config` VALUES ('737', '201', '其它', '', '9', '2018-07-10 16:45:51', '2018-07-10 16:45:51');
INSERT INTO `t_ums_data_config` VALUES ('738', '202', '崩边', '', '9', '2018-07-10 16:46:43', '2018-07-10 16:46:43');
INSERT INTO `t_ums_data_config` VALUES ('739', '202', '划痕', '', '9', '2018-07-10 16:46:50', '2018-07-10 16:46:50');
INSERT INTO `t_ums_data_config` VALUES ('740', '202', '异物', '', '9', '2018-07-10 16:46:57', '2018-07-10 16:46:57');
INSERT INTO `t_ums_data_config` VALUES ('741', '202', '胶', '', '9', '2018-07-10 16:47:14', '2018-07-10 16:47:14');
INSERT INTO `t_ums_data_config` VALUES ('742', '202', '印迹', '', '9', '2018-07-10 16:47:24', '2018-07-10 16:47:24');
INSERT INTO `t_ums_data_config` VALUES ('743', '202', '高低', '', '9', '2018-07-10 16:47:31', '2018-07-10 16:47:31');
INSERT INTO `t_ums_data_config` VALUES ('744', '202', '装反', '', '9', '2018-07-10 16:47:37', '2018-07-10 16:47:37');
INSERT INTO `t_ums_data_config` VALUES ('745', '202', '破点', '', '9', '2018-07-10 16:47:46', '2018-07-10 16:47:46');
INSERT INTO `t_ums_data_config` VALUES ('746', '202', '其它', '', '9', '2018-07-10 16:47:51', '2018-07-10 16:47:51');
INSERT INTO `t_ums_data_config` VALUES ('747', '12', '14-0013', '', '9', '2018-07-10 17:42:57', '2018-07-10 17:42:57');
INSERT INTO `t_ums_data_config` VALUES ('748', '12', '13-0003', '', '9', '2018-07-10 17:43:06', '2018-07-10 17:43:06');
INSERT INTO `t_ums_data_config` VALUES ('749', '29', '18-0009', 'SA', '9', '2018-07-10 20:00:05', '2018-07-10 20:00:05');
INSERT INTO `t_ums_data_config` VALUES ('750', '29', '18-0029', 'Ni-NTA', '9', '2018-07-10 20:00:32', '2018-07-10 20:00:32');
INSERT INTO `t_ums_data_config` VALUES ('751', '32', 'XC171120', '', '9', '2018-07-10 20:17:20', '2018-07-10 20:17:20');
INSERT INTO `t_ums_data_config` VALUES ('752', '33', 'B-0280', '', '9', '2018-07-10 20:18:33', '2018-07-10 20:18:33');
INSERT INTO `t_ums_data_config` VALUES ('753', '33', 'B-0011', '', '9', '2018-07-10 20:19:25', '2018-07-10 20:19:25');
INSERT INTO `t_ums_data_config` VALUES ('754', '33', 'B-0187', '', '9', '2018-07-10 20:19:35', '2018-07-10 20:19:35');
INSERT INTO `t_ums_data_config` VALUES ('755', '29', '18-0001', 'AHQ', '9', '2018-07-12 12:27:54', '2018-07-12 12:27:54');
INSERT INTO `t_ums_data_config` VALUES ('756', '29', '18-0007', 'AMQ', '9', '2018-07-12 12:28:41', '2018-07-12 12:28:41');
INSERT INTO `t_ums_data_config` VALUES ('757', '29', '18-0010', 'APS', '9', '2018-07-12 12:28:51', '2018-07-12 12:28:51');
INSERT INTO `t_ums_data_config` VALUES ('758', '29', '18-0011', 'SSA', '9', '2018-07-12 12:29:00', '2018-07-12 12:29:00');
INSERT INTO `t_ums_data_config` VALUES ('759', '29', '18-0015', 'AHC', '9', '2018-07-12 12:29:11', '2018-07-12 12:29:11');
INSERT INTO `t_ums_data_config` VALUES ('760', '29', '18-0022', 'ProG', '9', '2018-07-12 12:29:22', '2018-07-12 12:29:22');
INSERT INTO `t_ums_data_config` VALUES ('761', '29', '18-0023', 'ProL', '9', '2018-07-12 12:29:30', '2018-07-12 12:29:30');
INSERT INTO `t_ums_data_config` VALUES ('762', '29', '18-0026', 'AR2G', '9', '2018-07-12 12:29:45', '2018-07-12 12:29:45');
INSERT INTO `t_ums_data_config` VALUES ('763', '29', '18-0027', 'GST', '9', '2018-07-12 12:29:55', '2018-07-12 12:29:55');
INSERT INTO `t_ums_data_config` VALUES ('764', '29', '18-0034', 'HIS2', '9', '2018-07-12 12:30:16', '2018-07-12 12:30:16');
INSERT INTO `t_ums_data_config` VALUES ('765', '29', '18-0038', 'HIS1K', '9', '2018-07-12 12:30:28', '2018-07-12 12:30:28');
INSERT INTO `t_ums_data_config` VALUES ('766', '29', '18-0039', 'FAB2G', '9', '2018-07-12 12:30:37', '2018-07-12 12:30:37');
INSERT INTO `t_ums_data_config` VALUES ('767', '47', '请选择', '', '9', '2018-07-12 14:07:47', '2018-07-12 14:07:47');
INSERT INTO `t_ums_data_config` VALUES ('768', '47', 'K', '', '9', '2018-07-12 14:07:58', '2018-07-12 14:07:58');
INSERT INTO `t_ums_data_config` VALUES ('769', '47', 'Q', '', '9', '2018-07-12 14:08:12', '2018-07-12 14:08:12');
INSERT INTO `t_ums_data_config` VALUES ('770', '34', '04-0001', '双长链生物素偶联牛血清白蛋白', '9', '2018-07-17 12:55:50', '2018-07-17 12:55:50');
INSERT INTO `t_ums_data_config` VALUES ('771', '34', '04-0002', '链霉亲和素偶联抗人免疫球蛋白抗体', '9', '2018-07-17 12:56:02', '2018-07-17 12:56:02');
INSERT INTO `t_ums_data_config` VALUES ('772', '34', '04-0003', '短链生物素偶联牛血清白蛋白', '9', '2018-07-17 12:56:16', '2018-07-17 12:56:16');
INSERT INTO `t_ums_data_config` VALUES ('773', '34', '04-0004', '链霉亲和素三聚体', '9', '2018-07-17 12:56:34', '2018-07-17 12:56:34');
INSERT INTO `t_ums_data_config` VALUES ('774', '34', '04-0005', '长链生物素偶联蛋白A', '9', '2018-07-17 12:56:59', '2018-07-17 12:56:59');
INSERT INTO `t_ums_data_config` VALUES ('775', '34', '04-0006', '双长链生物素偶联蛋白A', '9', '2018-07-17 12:57:12', '2018-07-17 12:57:12');
INSERT INTO `t_ums_data_config` VALUES ('776', '34', '04-0007', '链霉亲和素三聚体（PBS）', '9', '2018-07-17 12:57:30', '2018-07-17 12:57:30');
INSERT INTO `t_ums_data_config` VALUES ('777', '34', '04-0008', '双长链生物素偶联抗鼠免疫球蛋白抗体', '9', '2018-07-17 12:57:45', '2018-07-17 12:57:45');
INSERT INTO `t_ums_data_config` VALUES ('778', '34', '04-0009', '链霉亲和素三聚体（无吐温）', '9', '2018-07-17 12:57:58', '2018-07-17 12:57:58');
INSERT INTO `t_ums_data_config` VALUES ('779', '34', '04-0010', '双长链生物素偶联牛碳酸酐酶', '9', '2018-07-17 12:58:18', '2018-07-17 12:58:18');
INSERT INTO `t_ums_data_config` VALUES ('780', '34', '04-0011', '生物素偶联抗人免疫球蛋白抗体', '9', '2018-07-17 12:58:29', '2018-07-17 12:58:29');
INSERT INTO `t_ums_data_config` VALUES ('781', '34', '04-0013', '链霉亲和素三聚体（SA）', '9', '2018-07-17 12:58:43', '2018-07-17 12:58:43');
INSERT INTO `t_ums_data_config` VALUES ('782', '34', '04-0015', '链霉亲和素三聚体（SSA）', '9', '2018-07-17 12:59:06', '2018-07-17 12:59:06');
INSERT INTO `t_ums_data_config` VALUES ('783', '34', '04-0016', 'Bio-LCLC-anti-HIS双长链生物素偶联抗HIS抗体', '9', '2018-07-17 12:59:17', '2018-07-17 12:59:17');
INSERT INTO `t_ums_data_config` VALUES ('784', '34', '04-0019', '双长链生物素偶联蛋白G', '9', '2018-07-17 12:59:30', '2018-07-17 12:59:30');
INSERT INTO `t_ums_data_config` VALUES ('785', '34', '04-0020', '双长链生物素偶联蛋白L', '9', '2018-07-17 12:59:45', '2018-07-17 12:59:45');
INSERT INTO `t_ums_data_config` VALUES ('786', '34', '04-0021', '双长链生物素偶联抗鼠免疫球蛋白抗体（For AMC）', '9', '2018-07-17 12:59:58', '2018-07-17 12:59:58');
INSERT INTO `t_ums_data_config` VALUES ('787', '34', '04-0022', '双长链生物素偶联抗GST抗体', '9', '2018-07-17 13:00:10', '2018-07-17 13:00:10');
INSERT INTO `t_ums_data_config` VALUES ('788', '34', '04-0023', 'Biotin-Tris-NTA储液', '9', '2018-07-17 13:00:24', '2018-07-17 13:00:24');
INSERT INTO `t_ums_data_config` VALUES ('789', '34', '04-0026', '双长链生物素-xHIS2母液', '9', '2018-07-17 13:00:36', '2018-07-17 13:00:36');
INSERT INTO `t_ums_data_config` VALUES ('790', '34', '04-0028', '双长链生物素-xHIS母液', '9', '2018-07-17 13:00:49', '2018-07-17 13:00:49');
INSERT INTO `t_ums_data_config` VALUES ('791', '34', '04-0029', 'Biotin-anti-IgG-CH1', '9', '2018-07-17 13:01:02', '2018-07-17 13:01:02');
INSERT INTO `t_ums_data_config` VALUES ('792', '33', 'B-0012', '', '9', '2018-07-19 15:29:28', '2018-07-19 15:29:28');
INSERT INTO `t_ums_data_config` VALUES ('793', '46', 'B-0011', '', '9', '2018-07-19 15:30:19', '2018-07-19 15:30:19');
INSERT INTO `t_ums_data_config` VALUES ('794', '46', 'B-0012', '', '9', '2018-07-19 15:30:24', '2018-07-19 15:30:24');
INSERT INTO `t_ums_data_config` VALUES ('795', '46', 'B-0187', '', '9', '2018-07-19 15:30:30', '2018-07-19 15:30:30');
INSERT INTO `t_ums_data_config` VALUES ('796', '46', 'B-0280', '', '9', '2018-07-19 15:30:40', '2018-07-19 15:30:40');
INSERT INTO `t_ums_data_config` VALUES ('797', '30', 'B10', '', '9', '2018-07-19 15:37:32', '2018-07-19 15:37:32');
INSERT INTO `t_ums_data_config` VALUES ('798', '30', 'C01', '', '9', '2018-07-19 15:37:40', '2018-07-19 15:37:40');
INSERT INTO `t_ums_data_config` VALUES ('799', '30', 'C05', '', '9', '2018-07-19 15:37:49', '2018-07-19 15:37:49');
INSERT INTO `t_ums_data_config` VALUES ('800', '30', 'C11', '', '9', '2018-07-19 15:37:58', '2018-07-19 15:37:58');
INSERT INTO `t_ums_data_config` VALUES ('801', '30', 'C12', '', '9', '2018-07-19 15:38:02', '2018-07-19 15:38:02');
INSERT INTO `t_ums_data_config` VALUES ('802', '30', 'C13', '', '9', '2018-07-19 15:38:06', '2018-07-19 15:38:06');
INSERT INTO `t_ums_data_config` VALUES ('803', '30', 'C14', '', '9', '2018-07-19 15:38:10', '2018-07-19 15:38:10');
INSERT INTO `t_ums_data_config` VALUES ('804', '31', 'B10', '', '9', '2018-07-19 15:38:30', '2018-07-19 15:38:30');
INSERT INTO `t_ums_data_config` VALUES ('805', '31', 'C01', '', '9', '2018-07-19 15:38:35', '2018-07-19 15:38:35');
INSERT INTO `t_ums_data_config` VALUES ('806', '31', 'C05', '', '9', '2018-07-19 15:38:39', '2018-07-19 15:38:39');
INSERT INTO `t_ums_data_config` VALUES ('807', '31', 'C11', '', '9', '2018-07-19 15:38:44', '2018-07-19 15:38:44');
INSERT INTO `t_ums_data_config` VALUES ('808', '31', 'C12', '', '9', '2018-07-19 15:38:48', '2018-07-19 15:38:48');
INSERT INTO `t_ums_data_config` VALUES ('809', '31', 'C13', '', '9', '2018-07-19 15:38:52', '2018-07-19 15:38:52');
INSERT INTO `t_ums_data_config` VALUES ('810', '31', 'C14', '', '9', '2018-07-19 15:38:56', '2018-07-19 15:38:56');
INSERT INTO `t_ums_data_config` VALUES ('811', '43', 'B10', '', '9', '2018-07-19 15:39:15', '2018-07-19 15:39:15');
INSERT INTO `t_ums_data_config` VALUES ('812', '43', 'C01', '', '9', '2018-07-19 15:39:20', '2018-07-19 15:39:20');
INSERT INTO `t_ums_data_config` VALUES ('813', '43', 'C05', '', '9', '2018-07-19 15:39:24', '2018-07-19 15:39:24');
INSERT INTO `t_ums_data_config` VALUES ('814', '43', 'C11', '', '9', '2018-07-19 15:39:28', '2018-07-19 15:39:28');
INSERT INTO `t_ums_data_config` VALUES ('815', '43', 'C12', '', '9', '2018-07-19 15:39:31', '2018-07-19 15:39:31');
INSERT INTO `t_ums_data_config` VALUES ('816', '43', 'C13', '', '9', '2018-07-19 15:39:35', '2018-07-19 15:39:35');
INSERT INTO `t_ums_data_config` VALUES ('817', '43', 'C14', '', '9', '2018-07-19 15:39:38', '2018-07-19 15:39:38');
INSERT INTO `t_ums_data_config` VALUES ('818', '44', 'B10', '', '9', '2018-07-19 15:40:07', '2018-07-19 15:40:07');
INSERT INTO `t_ums_data_config` VALUES ('819', '44', 'C01', '', '9', '2018-07-19 15:40:11', '2018-07-19 15:40:11');
INSERT INTO `t_ums_data_config` VALUES ('820', '44', 'C05', '', '9', '2018-07-19 15:40:16', '2018-07-19 15:40:16');
INSERT INTO `t_ums_data_config` VALUES ('821', '44', 'C11', '', '9', '2018-07-19 15:40:20', '2018-07-19 15:40:20');
INSERT INTO `t_ums_data_config` VALUES ('822', '44', 'C12', '', '9', '2018-07-19 15:40:23', '2018-07-19 15:40:23');
INSERT INTO `t_ums_data_config` VALUES ('823', '44', 'C13', '', '9', '2018-07-19 15:40:27', '2018-07-19 15:40:27');
INSERT INTO `t_ums_data_config` VALUES ('824', '44', 'C14', '', '9', '2018-07-19 15:40:30', '2018-07-19 15:40:30');
INSERT INTO `t_ums_data_config` VALUES ('825', '30', 'N/A', '', '9', '2018-07-19 15:44:48', '2018-07-19 15:44:48');
INSERT INTO `t_ums_data_config` VALUES ('826', '31', 'N/A', '', '9', '2018-07-19 15:44:57', '2018-07-19 15:44:57');
INSERT INTO `t_ums_data_config` VALUES ('827', '43', 'N/A', '', '9', '2018-07-19 15:45:14', '2018-07-19 15:45:14');
INSERT INTO `t_ums_data_config` VALUES ('828', '44', 'N/A', '', '9', '2018-07-19 15:45:23', '2018-07-19 15:45:23');
INSERT INTO `t_ums_data_config` VALUES ('829', '45', 'XC171120', '', '9', '2018-07-19 16:04:06', '2018-07-19 16:04:06');

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
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of t_ums_menuinfo
-- ----------------------------
INSERT INTO `t_ums_menuinfo` VALUES ('1', '基础管理', 'menu-icon glyphicon glyphicon-cog', null, '0', '0', '-1', '1', null);
INSERT INTO `t_ums_menuinfo` VALUES ('2', '工作流管理', 'menu-icon glyphicon glyphicon-globe', '', '0', '0', '-1', '2', '');
INSERT INTO `t_ums_menuinfo` VALUES ('3', '报表管理', 'menu-icon glyphicon glyphicon-th-list', null, '0', '0', '-1', '3', '');
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
INSERT INTO `t_ums_menuinfo` VALUES ('202', '清洁', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/cleanManage', '1', '0', '2', '2', null);
INSERT INTO `t_ums_menuinfo` VALUES ('203', '光学镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/opticalFilmingManage', '1', '0', '2', '3', null);
INSERT INTO `t_ums_menuinfo` VALUES ('204', '化学镀膜APS', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/platedFilmManage', '1', '0', '2', '4', null);
INSERT INTO `t_ums_menuinfo` VALUES ('205', '组装', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/assemblyManage', '1', '0', '2', '6', null);
INSERT INTO `t_ums_menuinfo` VALUES ('206', '生化镀膜', 'menu-icon glyphicons\r\nglyphicons-hand-right', '/workflow/chemicalReagentManage', '1', '0', '2', '7', null);
INSERT INTO `t_ums_menuinfo` VALUES ('207', '二次生化镀膜', 'menu-icon glyphicons glyphicons-hand-right', '/workflow/twiceChemicalReagentManage', '1', '0', '2', '8', '');
INSERT INTO `t_ums_menuinfo` VALUES ('301', '组装报废汇总', 'menu-icon glyphicons glyphicons-hand-right', '/report/assemblyScrapSummary', '1', '0', '3', '1', '');
INSERT INTO `t_ums_menuinfo` VALUES ('302', '产出数量追踪', 'menu-icon glyphicons glyphicons-hand-right', '/report/productTracking', '1', '0', '3', '2', '');

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
  `amount` double(10,4) DEFAULT NULL COMMENT 'Amount(mg)',
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
  PRIMARY KEY (`rmid`),
  KEY `idx_ur_reagentmiture_reagentmixture` (`lot_num`) USING BTREE,
  KEY `idx_ur_reagentmiture_mainreagent` (`main_reagent`) USING BTREE,
  KEY `idx_ur_reagentmiture_configtime` (`config_time`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='试剂混合表';

-- ----------------------------
-- Records of t_ums_reagentmixture
-- ----------------------------
INSERT INTO `t_ums_reagentmixture` VALUES ('4', '2018-05-28 00:00:00', '03-0006', 'B', 'BF18052802', '102990995', '5000.0000', '3.752', null, null, null, '', '吴雪瑞', '', '', '', '2018-07-10 12:41:19', '2018-07-10 12:50:43', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('5', '2018-05-10 00:00:00', '05-5003', 'B', 'PS18051021', '102966319', '4000.0000', null, null, null, null, '', '居金祥', '', '', '', '2018-07-10 13:07:19', '2018-07-10 13:07:19', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('6', '2018-04-11 00:00:00', '03-0007', 'B', 'BF18041101', '102933171', '4000.0000', null, null, null, null, '', '居金祥', '', '', '', '2018-07-10 13:11:27', '2018-07-10 13:11:27', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('7', '2018-04-11 00:00:00', '03-0008', 'B', 'BF18041102', '102929561', '3900.0000', null, null, null, null, '', '居金祥', '', '', '', '2018-07-10 13:14:42', '2018-07-10 13:15:19', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('9', '2018-04-18 00:00:00', '01-0026', 'NA', 'FI180418', 'NA', null, null, null, null, null, '', 'NA', '', '', '', '2018-07-11 08:50:55', '2018-07-17 12:43:34', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('10', '2018-01-17 00:00:00', '04-0013', 'NA', 'MP180117C', 'NA', null, null, null, null, null, '', 'NA', '', '', '', '2018-07-11 08:52:14', '2018-07-17 13:40:47', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('11', '2018-04-24 00:00:00', '01-0030', 'NA', 'SI180424', 'NA', null, null, null, null, null, '', 'NA', '', '', '', '2018-07-11 08:53:10', '2018-07-17 12:44:26', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('12', '2018-04-23 00:00:00', '03-0005', 'A', 'BF18042301', '102929560', '3985.0000', null, null, null, null, '', '吴学瑞', '', '', '', '2018-07-11 09:27:58', '2018-07-11 09:27:58', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('13', '2018-04-13 00:00:00', '03-0047', 'C', 'BF18041301', '102931409', '5000.0000', null, null, null, null, '', '居金祥', '', '', '', '2018-07-11 09:31:10', '2018-07-17 14:38:11', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('14', '2018-01-16 00:00:00', '03-0046', 'A', 'BF18011602', '102824495', '19.0000', null, null, null, null, '', '张焕成 ', '', '', '', '2018-07-11 09:35:50', '2018-07-11 09:35:50', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('15', '2018-04-13 13:31:21', '01-0001', 'C', 'BF18041301', '102931409', '5000.0000', null, null, null, null, '', '居金祥', '', '', '', '2018-07-17 13:33:10', '2018-07-17 13:33:10', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('16', '2018-01-16 13:41:01', '03-0046', 'A', 'BF18011602', '102824495', '19.0000', null, null, null, null, '', '张焕成 ', '', '', '', '2018-07-17 13:44:42', '2018-07-17 13:44:42', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('17', '2018-04-16 13:44:51', '04-0023', 'A', 'CM18041601', '102938896', '2.0000', null, null, null, null, '', '孟瑞娟', '', '', '', '2018-07-17 13:46:58', '2018-07-17 13:46:58', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('20', '2018-06-06 10:36:00', '03-0006', 'B', 'BF18060601', '102999544', '5000.0000', '3.753', null, null, null, '', '居金祥', '', '', '', '2018-07-19 10:40:06', '2018-07-19 10:40:06', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('21', '2018-04-12 10:44:24', '04-0013', 'NA', 'MP180412A', 'NA', '0.0000', null, null, null, null, '', 'NA', '', '', '', '2018-07-19 10:44:59', '2018-07-19 10:44:59', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('22', '2018-04-12 10:46:37', '04-0013', 'NA', 'MP180412C', 'NA', '0.0000', null, null, null, null, '', 'NA', '', '', '', '2018-07-19 10:47:16', '2018-07-19 10:47:16', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('23', '2018-05-21 10:48:08', '01-0030', 'NA', 'SI180521', 'NA', '0.0000', null, null, null, null, '', 'NA', '', '', '', '2018-07-19 10:48:28', '2018-07-19 10:48:28', '9');
INSERT INTO `t_ums_reagentmixture` VALUES ('24', '2018-05-29 10:49:28', '01-0026', 'NA', 'FI180529', 'NA', '0.0000', null, null, null, null, '', 'NA', '', '', '', '2018-07-19 10:50:21', '2018-07-19 10:50:21', '9');

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
  PRIMARY KEY (`srmid`),
  KEY `idx_urs_sns_rmid` (`rmid`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='试剂编号表';

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
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('19', '4', 'reagentmixturetable209437', '03-0006', '01-0029', 'SI180328');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('20', '5', 'reagentmixturetable209442', '05-5003', '01-0022', 'SI180117');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('21', '5', 'reagentmixturetable209441', '05-5003', '01-0025', 'SI180416A SI180416B SI180416C');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('22', '6', 'reagentmixturetable209443', '03-0007', '01-0027', 'SI170419');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('23', '6', 'reagentmixturetable209431', '03-0007', '01-0028', 'NA');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('26', '7', 'reagentmixturetable209430', '03-0008', '01-0011', 'XY170907');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('27', '7', 'reagentmixturetable209445', '03-0008', '03-0007', 'BF18041101');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('28', '12', 'reagentmixturetable209429', '03-0005', '01-0002', 'SI180416');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('29', '12', 'reagentmixturetable209430', '03-0005', '01-0011', 'XY170907:294  XY180420:506');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('32', '9', 'reagentmixturetable209436', '01-0026', '01-0026', 'FI180418');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('33', '11', 'reagentmixturetable209440', '01-0030', '01-0030', 'SI180424');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('35', '10', 'reagentmixturetable209781', '04-0013', '04-0013', 'MP180117C');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('36', '16', 'reagentmixturetable209428', '03-0046', '01-0062', 'SI170815:4.6835|SI171003:0.0703');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('37', '17', 'reagentmixturetable209604', '04-0023', '02-0044', 'BG180416');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('38', '13', 'reagentmixturetable209426', '03-0047', '01-0009', 'SI170207');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('39', '13', 'reagentmixturetable209427', '03-0047', '01-0045', 'SI170704');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('40', '13', 'reagentmixturetable209425', '03-0047', '01-0048', 'SI170704');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('41', '13', 'reagentmixturetable209424', '03-0047', '01-0063', 'SI170904');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('44', '20', 'reagentmixturetable209437', '03-0006', '01-0029', 'SI180328');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('45', '21', 'reagentmixturetable209781', '04-0013', '04-0013', 'MP180412A');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('46', '22', 'reagentmixturetable209781', '04-0013', '04-0013', 'MP180412C');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('47', '23', 'reagentmixturetable209440', '01-0030', '01-0030', 'SI180521');
INSERT INTO `t_ums_reagentmixture_sns` VALUES ('48', '24', 'reagentmixturetable209436', '01-0026', '01-0026', 'FI180529');

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
INSERT INTO `t_ums_right` VALUES ('19', '1', '3', null);
INSERT INTO `t_ums_right` VALUES ('20', '1', '301', null);
INSERT INTO `t_ums_right` VALUES ('21', '1', '302', null);
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
  PRIMARY KEY (`ROLEID`),
  KEY `idx_ur_role_rolename` (`ROLENAME`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- ----------------------------
-- Records of t_ums_role
-- ----------------------------
INSERT INTO `t_ums_role` VALUES ('1', '超级角色', '-1', '');
INSERT INTO `t_ums_role` VALUES ('2', '流程管理', '-1', '');
INSERT INTO `t_ums_role` VALUES ('3', '报表管理', null, '');
INSERT INTO `t_ums_role` VALUES ('17', '抛磨_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('18', '抛磨_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('19', '抛磨_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('20', '抛磨_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('21', '抛磨_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('22', '抛磨_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('23', '抛磨_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('24', '抛磨_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('25', '清洁_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('26', '清洁_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('27', '清洁_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('28', '清洁_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('29', '清洁_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('30', '清洁_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('31', '清洁_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('32', '清洁_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('33', '光学镀膜_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('34', '光学镀膜_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('35', '光学镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('36', '光学镀膜_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('37', '光学镀膜_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('38', '光学镀膜_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('39', '光学镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('40', '光学镀膜_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('41', '化学镀膜_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('42', '化学镀膜_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('43', '化学镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('44', '化学镀膜_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('45', '化学镀膜_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('46', '化学镀膜_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('47', '化学镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('48', '化学镀膜_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('49', '组装_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('50', '组装_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('51', '组装_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('52', '组装_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('53', '组装_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('54', '组装_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('55', '组装_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('56', '组装_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('57', '生化镀膜_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('58', '生化镀膜_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('59', '生化镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('60', '生化镀膜_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('61', '生化镀膜_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('62', '生化镀膜_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('63', '生化镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('64', '生化镀膜_删除', null, '');
INSERT INTO `t_ums_role` VALUES ('65', '二次生化镀膜_查询', null, '');
INSERT INTO `t_ums_role` VALUES ('66', '二次生化镀膜_添加', null, '');
INSERT INTO `t_ums_role` VALUES ('67', '二次生化镀膜_批量删除', null, '');
INSERT INTO `t_ums_role` VALUES ('68', '二次生化镀膜_导出', null, '');
INSERT INTO `t_ums_role` VALUES ('69', '二次生化镀膜_刷新', null, '');
INSERT INTO `t_ums_role` VALUES ('70', '二次生化镀膜_复制', null, '');
INSERT INTO `t_ums_role` VALUES ('71', '二次生化镀膜_修改', null, '');
INSERT INTO `t_ums_role` VALUES ('72', '二次生化镀膜_删除', null, '');

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
INSERT INTO `t_ums_rolepermission` VALUES ('1', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('7', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('18', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('19', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('20', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '2');
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
INSERT INTO `t_ums_rolepermission` VALUES ('38', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('39', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('40', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('41', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('42', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('43', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('44', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('45', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('46', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('47', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('48', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('49', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('50', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('51', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('52', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('53', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('54', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('55', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('56', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('57', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('58', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('59', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('60', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('61', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('62', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('63', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('64', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('65', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('66', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('67', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('68', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('69', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('70', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('71', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('72', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('73', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('74', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('75', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('76', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('77', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('78', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('79', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('80', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('81', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('82', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('83', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('84', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('85', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('86', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('87', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('88', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('89', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('90', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('91', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('92', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('93', '2');
INSERT INTO `t_ums_rolepermission` VALUES ('38', '17');
INSERT INTO `t_ums_rolepermission` VALUES ('39', '18');
INSERT INTO `t_ums_rolepermission` VALUES ('40', '19');
INSERT INTO `t_ums_rolepermission` VALUES ('41', '20');
INSERT INTO `t_ums_rolepermission` VALUES ('42', '21');
INSERT INTO `t_ums_rolepermission` VALUES ('43', '22');
INSERT INTO `t_ums_rolepermission` VALUES ('44', '23');
INSERT INTO `t_ums_rolepermission` VALUES ('45', '24');
INSERT INTO `t_ums_rolepermission` VALUES ('46', '25');
INSERT INTO `t_ums_rolepermission` VALUES ('47', '26');
INSERT INTO `t_ums_rolepermission` VALUES ('48', '27');
INSERT INTO `t_ums_rolepermission` VALUES ('49', '28');
INSERT INTO `t_ums_rolepermission` VALUES ('50', '29');
INSERT INTO `t_ums_rolepermission` VALUES ('51', '30');
INSERT INTO `t_ums_rolepermission` VALUES ('52', '31');
INSERT INTO `t_ums_rolepermission` VALUES ('53', '32');
INSERT INTO `t_ums_rolepermission` VALUES ('54', '33');
INSERT INTO `t_ums_rolepermission` VALUES ('55', '34');
INSERT INTO `t_ums_rolepermission` VALUES ('56', '35');
INSERT INTO `t_ums_rolepermission` VALUES ('57', '36');
INSERT INTO `t_ums_rolepermission` VALUES ('58', '37');
INSERT INTO `t_ums_rolepermission` VALUES ('59', '38');
INSERT INTO `t_ums_rolepermission` VALUES ('60', '39');
INSERT INTO `t_ums_rolepermission` VALUES ('61', '40');
INSERT INTO `t_ums_rolepermission` VALUES ('62', '41');
INSERT INTO `t_ums_rolepermission` VALUES ('63', '42');
INSERT INTO `t_ums_rolepermission` VALUES ('64', '43');
INSERT INTO `t_ums_rolepermission` VALUES ('65', '44');
INSERT INTO `t_ums_rolepermission` VALUES ('66', '45');
INSERT INTO `t_ums_rolepermission` VALUES ('67', '46');
INSERT INTO `t_ums_rolepermission` VALUES ('68', '47');
INSERT INTO `t_ums_rolepermission` VALUES ('69', '48');
INSERT INTO `t_ums_rolepermission` VALUES ('70', '49');
INSERT INTO `t_ums_rolepermission` VALUES ('71', '50');
INSERT INTO `t_ums_rolepermission` VALUES ('72', '51');
INSERT INTO `t_ums_rolepermission` VALUES ('73', '52');
INSERT INTO `t_ums_rolepermission` VALUES ('74', '53');
INSERT INTO `t_ums_rolepermission` VALUES ('75', '54');
INSERT INTO `t_ums_rolepermission` VALUES ('76', '55');
INSERT INTO `t_ums_rolepermission` VALUES ('77', '56');
INSERT INTO `t_ums_rolepermission` VALUES ('78', '57');
INSERT INTO `t_ums_rolepermission` VALUES ('79', '58');
INSERT INTO `t_ums_rolepermission` VALUES ('80', '59');
INSERT INTO `t_ums_rolepermission` VALUES ('81', '60');
INSERT INTO `t_ums_rolepermission` VALUES ('82', '61');
INSERT INTO `t_ums_rolepermission` VALUES ('83', '62');
INSERT INTO `t_ums_rolepermission` VALUES ('84', '63');
INSERT INTO `t_ums_rolepermission` VALUES ('85', '64');
INSERT INTO `t_ums_rolepermission` VALUES ('86', '65');
INSERT INTO `t_ums_rolepermission` VALUES ('87', '66');
INSERT INTO `t_ums_rolepermission` VALUES ('88', '67');
INSERT INTO `t_ums_rolepermission` VALUES ('89', '68');
INSERT INTO `t_ums_rolepermission` VALUES ('90', '69');
INSERT INTO `t_ums_rolepermission` VALUES ('91', '70');
INSERT INTO `t_ums_rolepermission` VALUES ('92', '71');
INSERT INTO `t_ums_rolepermission` VALUES ('93', '72');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '17');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '18');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '19');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '20');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '21');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '22');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '23');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '24');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '25');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '26');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '27');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '28');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '29');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '30');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '31');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '32');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '33');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '34');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '35');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '36');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '37');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '38');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '39');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '40');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '41');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '42');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '43');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '44');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '45');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '46');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '47');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '48');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '49');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '50');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '51');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '52');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '53');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '54');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '55');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '56');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '57');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '58');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '59');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '60');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '61');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '62');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '63');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '64');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '65');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '66');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '67');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '68');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '69');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '70');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '71');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '72');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '17');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '18');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '19');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '20');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '21');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '22');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '23');
INSERT INTO `t_ums_rolepermission` VALUES ('11', '24');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '25');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '26');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '27');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '28');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '29');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '30');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '31');
INSERT INTO `t_ums_rolepermission` VALUES ('12', '32');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '33');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '34');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '35');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '36');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '37');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '38');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '39');
INSERT INTO `t_ums_rolepermission` VALUES ('13', '40');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '41');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '42');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '43');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '44');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '45');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '46');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '47');
INSERT INTO `t_ums_rolepermission` VALUES ('14', '48');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '49');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '50');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '51');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '52');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '53');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '54');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '55');
INSERT INTO `t_ums_rolepermission` VALUES ('15', '56');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '57');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '58');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '59');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '60');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '61');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '62');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '63');
INSERT INTO `t_ums_rolepermission` VALUES ('16', '64');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '65');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '66');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '67');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '68');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '69');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '70');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '71');
INSERT INTO `t_ums_rolepermission` VALUES ('17', '72');
INSERT INTO `t_ums_rolepermission` VALUES ('19', '3');
INSERT INTO `t_ums_rolepermission` VALUES ('20', '3');
INSERT INTO `t_ums_rolepermission` VALUES ('21', '1');
INSERT INTO `t_ums_rolepermission` VALUES ('21', '3');
INSERT INTO `t_ums_rolepermission` VALUES ('2', '2');

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
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '6', null, '3', '1', null, 'cleanBom', '0', 'Clean Bom', null);
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
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '13', null, '3', '1', null, 'toOtherQty', '0', 'To Other Qty(含掉落光纤)', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '14', null, '3', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'cleantable', '1', '15', null, '3', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
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
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '14', null, '2', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '15', null, '2', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '16', null, '2', '1', null, 'supplier', '0', '供应商', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '17', null, '2', '1', null, 'ocBom', '0', 'Optical Coating Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '18', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('203', 'opticalfilmingtable', '1', '19', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '1', null, '4', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '2', null, '4', '1', null, 'polishID', '1', 'polishid', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '3', null, '4', '1', null, 'pickingTime', '0', '领料日期', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '4', null, '4', '1', null, 'polishTime', '0', 'Polish Date', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '5', null, '4', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '6', null, '4', '1', null, 'inputQty', '0', 'Input Qty.(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '7', null, '4', '1', null, 'fixtureNumber', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '8', null, '4', '1', null, 'throwMillstoneNum', '0', 'Millstone#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '9', null, '4', '1', null, 'throwMillstonePosition', '0', 'Loading Fixture Position', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '10', null, '1', '4', null, null, '0', '估计值统计', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '2', '10', null, '1', '4', null, null, '0', '抛磨后检验', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '10', null, '1', '1', null, null, '0', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '11', null, '1', '1', null, null, '0', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '4', '10', null, '1', '1', '171', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '4', '11', null, '1', '1', '172', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '12', null, '2', '1', null, 'casualInspectionNum', '0', '抽检总数', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '3', '13', null, '2', '1', null, 'yield', '0', '合格率', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '14', null, '4', '1', null, 'polishLotNum', '0', 'Polish LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '15', null, '4', '1', null, 'outputQty', '1', 'OutputQty', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '16', null, '4', '1', null, 'measuredValues', '0', '测量值', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '17', null, '4', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '18', null, '4', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '19', null, '4', '1', null, 'polishBom', '0', 'Polish Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '20', null, '4', '1', null, 'operatorName', '3', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'polishtable', '1', '21', null, '4', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '2', null, '2', '1', null, 'assemblyID', '1', 'assemblyID', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '3', null, '2', '1', null, 'deliveryTime', '0', 'Assembly  Date', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '4', null, '2', '1', null, 'trayLotNum', '0', 'TRAY#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '5', null, '2', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '6', null, '2', '1', null, 'inputQty', '0', 'Input Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '7', null, '2', '1', null, 'fixtureNum', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '8', null, '2', '1', null, 'hubLotNum', '0', 'HUB Lot#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '9', null, '2', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '10', null, '2', '1', null, 'outputQty', '0', 'Output Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '11', null, '2', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '12', null, '1', '1', null, null, '3', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '13', null, '1', '1', null, null, '3', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '14', null, '1', '1', null, null, '3', '拆夹', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '15', null, '1', '1', null, null, '3', '装HUB', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '16', null, '1', '1', null, null, '3', '其它', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '17', null, '2', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('205', 'assemblytable', '1', '18', null, '2', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
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
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '7', null, '1', '1', null, 'throwMillstoneNum', '1', 'Millstone#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '8', null, '1', '1', null, 'inputQty', '0', 'Input Qty.(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '9', null, '1', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '10', null, '1', '1', null, 'polishLotNum', '0', 'Polish LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '11', null, '1', '1', null, 'outputQty', '1', 'OutputQty', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '12', null, '1', '1', null, 'polishBom', '0', 'Polish Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '13', null, '1', '1', null, 'measuredValues', '1', '测量值', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '14', null, '1', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('201', 'selpolishtable', '1', '15', null, '1', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '1', null, '1', '1', null, '', '1', '', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '2', null, '1', '1', null, 'cleanID', '1', 'cleanid', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '3', null, '1', '1', null, 'cleanTime', '0', 'Clean Date', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '4', null, '1', '1', null, 'fixtureNumber', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '5', null, '1', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '6', null, '1', '1', null, 'cleanBom', '0', 'Clean Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '7', null, '1', '1', null, 'cleanLotNum', '0', 'Clean LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '8', null, '1', '1', null, 'scrapQty', '0', 'Scrap Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '9', null, '1', '1', null, 'outputQty', '0', 'Output Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '10', null, '1', '1', null, 'toOtherQty', '0', 'To Other Qty', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '11', null, '1', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('202', 'selcleantable', '1', '12', null, '1', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '2', null, '2', '1', null, 'opfID', '1', 'opfID', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '3', null, '2', '1', null, 'optTime', '0', 'Date', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '4', null, '2', '1', null, 'inputLotNum', '0', 'Input LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '5', null, '2', '1', null, 'inputQty', '0', 'Input Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '6', null, '2', '1', null, 'fixtureNum', '0', 'Fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '7', null, '2', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '8', null, '2', '1', null, 'outputQty', '0', 'Output Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '9', null, '2', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '10', null, '2', '1', null, 'qcUseQty', '0', 'QC Use Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '11', null, '2', '1', null, 'toOtherQty', '0', 'To Other Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '12', null, '2', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('208', 'selopticalfilmingtable', '1', '13', null, '2', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '1', null, '1', '1', null, '', '2', '', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '2', null, '1', '1', null, 'pfID', '1', 'pfID', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '3', null, '1', '1', null, 'coatingTime', '0', 'Coating Date', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '4', null, '1', '1', null, 'pfTime', '0', 'Date', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '5', null, '1', '1', null, 'inputLotNum', '0', 'Input LOT#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '6', null, '1', '1', null, 'inputQty', '0', 'Input Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '7', null, '1', '1', null, 'fixtureNum', '0', 'Fixture#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '8', null, '1', '1', null, 'apsBottle', '0', 'APS Bottle', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '9', null, '1', '1', null, 'fixtureAttribute', '0', 'fixture属性', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '10', null, '1', '1', null, 'sfBomNum', '0', 'APS Bom', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '11', null, '1', '1', null, 'outputLotNum', '0', 'Output LOT#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '12', null, '1', '1', null, 'outputQty', '0', 'Output Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '13', null, '1', '1', null, 'scrapQty', '0', 'Scrap Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '14', null, '1', '1', null, 'underIQCQty', '0', 'Under IQC Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '15', null, '1', '1', null, 'qcUseQty', '0', 'QC Use Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '16', null, '1', '1', null, 'functionalTestQty', '0', 'Functional Test Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '17', null, '1', '1', null, 'toHUBQty', '1', 'To HUB Qty(pcs)', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '18', null, '1', '1', null, 'remainQty', '0', 'REMAIN QTY', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '19', null, '1', '1', null, 'apsCondition', '0', 'APS Condition', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '20', null, '1', '1', null, 'partNum', '0', 'PN#', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '21', null, '1', '1', null, 'workOrderNum', '0', 'Work Order Number', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '22', null, '1', '1', null, 'operatorName', '0', '操作员', '');
INSERT INTO `t_ums_th_config` VALUES ('204', 'platedfilmtable', '1', '23', null, '1', '1', null, '', '2', '操作', '');
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '1', null, '2', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '2', null, '2', '1', null, 'partNum', '0', 'PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '3', null, '2', '1', null, 'workOrderNum', '0', 'Work Order Number', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '4', null, '2', '1', null, 'outputQtys', '0', '产量', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '5', null, '1', '1', null, null, '0', '工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '6', null, '1', '1', null, null, '0', '非工作面', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '7', null, '1', '1', null, null, '0', '拆夹', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '8', null, '1', '1', null, null, '0', '装HUB', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '9', null, '1', '1', null, null, '0', '其它', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '1', '10', null, '2', '1', null, 'scrapQtys', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '2', '5', '1', '1', '1', '201', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '2', '6', null, '1', '1', '202', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '2', '7', null, '1', '1', '203', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '2', '8', null, '1', '1', '204', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('301', 'assemblyScrapSummarytable', '2', '9', null, '1', '1', '205', null, '0', null, null);
INSERT INTO `t_ums_th_config` VALUES ('302', 'productTrackingtable', '1', '1', null, '1', '1', null, 'fixtureNum', '0', 'fixture#', null);
INSERT INTO `t_ums_th_config` VALUES ('302', 'productTrackingtable', '1', '1', null, '1', '1', null, 'outputLotNum', '0', 'Output LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('302', 'productTrackingtable', '1', '4', null, '1', '1', null, 'inputQtys', '0', 'Input Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('302', 'productTrackingtable', '1', '4', null, '1', '1', null, 'outputQtys', '0', 'Output Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('302', 'productTrackingtable', '1', '10', null, '1', '1', null, 'scrapQtys', '0', 'Scrap Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('302', 'productTrackingtable', '1', '10', null, '1', '1', null, 'toOtherQtys', '1', 'To Other Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('302', 'productTrackingtable', '1', '10', null, '1', '1', null, 'diffQtys', '0', 'Diff Qty(pcs)', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '1', null, '1', '1', null, '', '0', '', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '2', null, '1', '1', null, 'rmid', '1', '试剂编号', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '3', null, '1', '1', null, 'configTime', '0', '配置时间', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '4', null, '1', '1', null, 'mainReagent', '0', '主试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '5', null, '1', '1', null, 'subReagent', '0', '混合试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '6', null, '1', '1', null, 'rev', '0', 'Rev', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '7', null, '1', '1', null, 'lotNum', '0', 'LOT#', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '8', null, '1', '1', null, 'woNum', '0', 'WO#', null);
INSERT INTO `t_ums_th_config` VALUES ('209', 'reagentmixturetable', '1', '9', null, '1', '1', null, 'amount', '0', 'Amount(mg)', null);
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
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '3', null, '2', '1', null, 'lot', '0', 'New Lot#', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '4', null, '2', '1', null, 'bioPatNum', '0', 'NEW PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '5', null, '2', '1', null, 'trayNums', '0', 'NEW TRAY#', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '6', null, '2', '1', null, 'oldLotNums', '0', 'Old Lot#', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '7', null, '2', '1', null, 'oldTrayNums', '0', 'Old Tray#', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '8', null, '2', '1', null, 'oldBioPatNums', '0', 'OLD PN#', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '9', null, '2', '1', null, 'reagentMixture', '2', '混合试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '10', null, '1', '2', null, null, '0', 'Fiber', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '12', null, '2', '1', null, 'coatingStation', '0', 'Coating Station', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '13', null, '2', '1', null, 'crOperator1', '0', '生化镀膜作业人员1', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '14', null, '2', '1', null, 'crOperator2', '0', '生化镀膜作业人员2', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '15', null, '2', '1', null, 'docRev', '0', '版本', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '16', null, '2', '1', null, 'auxiliaryReagent1', '0', '03-0018 or 03-0067 KB', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '17', null, '2', '1', null, 'auxiliaryReagent2', '0', '05-0079 1ug/ml BPA', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '18', null, '2', '1', null, 'auxiliaryReagent3', '0', '05-0080 6ug/ml HIgG', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '19', null, '2', '1', null, 'goodsQty', '0', 'Goods', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '20', null, '2', '1', null, 'inputQty', '0', 'Input', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '21', null, '2', '1', null, 'theoryYield', '0', 'Theoretical Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '22', null, '2', '1', null, 'actualYield', '0', 'Actual Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '23', null, '2', '1', null, 'theoryActualYield', '0', 'Theoretical VS Actual', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '24', null, '2', '1', null, 'remark', '0', '备注', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '25', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '1', '26', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '2', '10', null, '1', '1', null, 'rawMaterial', '0', 'Raw Material', null);
INSERT INTO `t_ums_th_config` VALUES ('207', 'twicechemicalreagenttable', '2', '11', null, '1', '1', null, 'inPutDate', '0', 'In Put Date', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '1', null, '2', '1', null, null, '2', null, null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '2', null, '2', '1', null, 'crID', '1', 'crID', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '3', null, '2', '1', null, 'bioPatNum', '0', 'BIO Pat Number', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '4', null, '2', '1', null, 'lot', '0', 'Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '5', null, '2', '1', null, 'reagentMixture', '2', '混合试剂', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '6', null, '2', '1', null, 'trayLotNums', '0', '14-####Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '7', null, '2', '1', null, 'tLotNums', '0', 'T#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '8', null, '2', '1', null, 'apsLotNums', '0', 'APS Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '9', null, '2', '1', null, 'ocLotNums', '0', 'OP.Lot', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '10', null, '2', '1', null, 'cleanLotNums', '0', 'Clean Lot#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '11', null, '2', '1', null, 'polishLotNums', '0', 'Polish Lot#', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '12', null, '1', '2', null, null, '0', 'Fiber', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '14', null, '2', '1', null, 'coatingStation', '0', 'Coating Station', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '15', null, '2', '1', null, 'crOperator1', '0', '生化镀膜作业人员1', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '16', null, '2', '1', null, 'crOperator2', '0', '生化镀膜作业人员2', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '17', null, '2', '1', null, 'docRev', '0', '版本', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '18', null, '2', '1', null, 'auxiliaryReagent1', '0', '03-0018 or 03-0067 KB', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '19', null, '2', '1', null, 'auxiliaryReagent2', '0', '05-0079 1ug/ml BPA', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '20', null, '2', '1', null, 'auxiliaryReagent3', '0', '05-0080 6ug/ml HIgG', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '21', null, '2', '1', null, 'polishBoms', '0', 'POLISH Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '22', null, '2', '1', null, 'cleanBoms', '0', 'Clean BOM', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '23', null, '2', '1', null, 'ocBoms', '0', '光学Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '24', null, '2', '1', null, 'apsBoms', '0', 'APS Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '25', null, '2', '1', null, 'assemblyBoms', '0', '组装 Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '26', null, '2', '1', null, 'bioBom', '0', '生物镀膜 Bom', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '27', null, '2', '1', null, 'goodsQty', '0', 'Goods', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '28', null, '2', '1', null, 'inputQty', '0', 'Input', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '29', null, '2', '1', null, 'theoryYield', '0', 'Theoretical Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '30', null, '2', '1', null, 'actualYield', '0', 'Actual Yield', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '31', null, '2', '1', null, 'theoryActualYield', '0', 'Theoretical VS Actual', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '32', null, '2', '1', null, 'remark', '0', '备注', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '33', null, '2', '1', null, 'operatorName', '0', '操作员', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '1', '34', null, '2', '1', null, null, '2', '操作', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '2', '12', null, '1', '1', null, 'rawMaterial', '0', 'Raw Material', null);
INSERT INTO `t_ums_th_config` VALUES ('206', 'chemicalreagenttable', '2', '13', null, '1', '1', null, 'inPutDate', '0', 'In Put Date', null);

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
INSERT INTO `t_ums_userpermission` VALUES ('3', '2');
INSERT INTO `t_ums_userpermission` VALUES ('4', '2');
INSERT INTO `t_ums_userpermission` VALUES ('9', '1');
INSERT INTO `t_ums_userpermission` VALUES ('19', '58');
INSERT INTO `t_ums_userpermission` VALUES ('19', '57');
INSERT INTO `t_ums_userpermission` VALUES ('19', '56');
INSERT INTO `t_ums_userpermission` VALUES ('19', '55');
INSERT INTO `t_ums_userpermission` VALUES ('19', '54');
INSERT INTO `t_ums_userpermission` VALUES ('19', '53');
INSERT INTO `t_ums_userpermission` VALUES ('19', '52');
INSERT INTO `t_ums_userpermission` VALUES ('19', '51');
INSERT INTO `t_ums_userpermission` VALUES ('19', '50');
INSERT INTO `t_ums_userpermission` VALUES ('19', '49');
INSERT INTO `t_ums_userpermission` VALUES ('19', '48');
INSERT INTO `t_ums_userpermission` VALUES ('19', '47');
INSERT INTO `t_ums_userpermission` VALUES ('19', '46');
INSERT INTO `t_ums_userpermission` VALUES ('19', '45');
INSERT INTO `t_ums_userpermission` VALUES ('19', '44');
INSERT INTO `t_ums_userpermission` VALUES ('19', '43');
INSERT INTO `t_ums_userpermission` VALUES ('19', '42');
INSERT INTO `t_ums_userpermission` VALUES ('19', '41');
INSERT INTO `t_ums_userpermission` VALUES ('19', '40');
INSERT INTO `t_ums_userpermission` VALUES ('19', '39');
INSERT INTO `t_ums_userpermission` VALUES ('19', '38');
INSERT INTO `t_ums_userpermission` VALUES ('19', '37');
INSERT INTO `t_ums_userpermission` VALUES ('19', '36');
INSERT INTO `t_ums_userpermission` VALUES ('19', '35');
INSERT INTO `t_ums_userpermission` VALUES ('19', '34');
INSERT INTO `t_ums_userpermission` VALUES ('19', '33');
INSERT INTO `t_ums_userpermission` VALUES ('19', '32');
INSERT INTO `t_ums_userpermission` VALUES ('19', '31');
INSERT INTO `t_ums_userpermission` VALUES ('19', '30');
INSERT INTO `t_ums_userpermission` VALUES ('19', '29');
INSERT INTO `t_ums_userpermission` VALUES ('19', '28');
INSERT INTO `t_ums_userpermission` VALUES ('19', '27');
INSERT INTO `t_ums_userpermission` VALUES ('19', '26');
INSERT INTO `t_ums_userpermission` VALUES ('19', '25');
INSERT INTO `t_ums_userpermission` VALUES ('19', '24');
INSERT INTO `t_ums_userpermission` VALUES ('19', '23');
INSERT INTO `t_ums_userpermission` VALUES ('19', '22');
INSERT INTO `t_ums_userpermission` VALUES ('19', '21');
INSERT INTO `t_ums_userpermission` VALUES ('19', '20');
INSERT INTO `t_ums_userpermission` VALUES ('19', '19');
INSERT INTO `t_ums_userpermission` VALUES ('19', '18');
INSERT INTO `t_ums_userpermission` VALUES ('19', '17');
INSERT INTO `t_ums_userpermission` VALUES ('19', '3');

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
  PRIMARY KEY (`assembly_id`,`input_time`),
  KEY `idx_uwa_assembly_traylotnum` (`tray_lot_num`),
  KEY `idx_uwa_assembly_inputlotnum` (`input_lot_num`),
  KEY `idx_uwa_assembly_fixturenum` (`fixture_num`),
  KEY `idx_uwa_assembly_outputnum` (`output_lot_num`),
  KEY `idx_uwa_assembly_workordernum` (`work_order_num`),
  KEY `idx_uwa_assembly_partnum` (`part_num`),
  KEY `idx_uwa_assembly_deliverytime` (`delivery_time`),
  KEY `idx_uwa_assembly_operatorid` (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=1269 DEFAULT CHARSET=utf8 COMMENT='组装表'
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
-- Records of t_ums_workflow_assembly
-- ----------------------------
INSERT INTO `t_ums_workflow_assembly` VALUES ('81', '2018-05-28', 'K39173', 'A1805092XH', '96', 'Q1974:53|Q2852:42', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:38:29', '2018-07-10 16:38:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('82', '2018-05-28', 'K39174', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:12', '2018-07-10 16:39:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('83', '2018-05-28', 'K39175', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:17', '2018-07-10 16:39:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('84', '2018-05-28', 'K39176', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:24', '2018-07-10 16:39:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('85', '2018-05-28', 'K39177', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:28', '2018-07-10 16:39:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('86', '2018-05-28', 'K39178', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:32', '2018-07-10 16:39:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('87', '2018-05-28', 'K39179', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:42', '2018-07-10 16:39:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('88', '2018-05-28', 'K39180', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:48', '2018-07-10 16:39:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('89', '2018-05-28', 'K39181', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:39:58', '2018-07-10 16:39:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('90', '2018-05-28', 'K39182', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:40:02', '2018-07-10 16:40:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('91', '2018-05-28', 'K39183', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:40:05', '2018-07-10 16:40:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('92', '2018-05-28', 'K39184', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:40:08', '2018-07-10 16:40:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('93', '2018-05-28', 'K39185', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:40:12', '2018-07-10 16:40:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('94', '2018-05-28', 'K39186', 'A1805092XH', '96', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:40:15', '2018-07-10 16:40:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('95', '2018-05-28', 'K39187', 'A1805092XH', '130', 'Q1974', 'JS171201B', 'K180528XH', null, '96', '34', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:40:19', '2018-07-10 17:45:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('97', '2018-05-28', 'K39188', 'A1805092XH', '96', 'Q1974:51|Q2491:45', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 16:41:01', '2018-07-10 16:41:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('102', '2018-05-28', 'K39266', 'A1805092XH', '96', 'Q1897:91|Q1208:5', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:07:55', '2018-07-10 17:07:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('103', '2018-05-28', 'K39267', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:08:40', '2018-07-10 17:08:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('104', '2018-05-28', 'K39268', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:08:45', '2018-07-10 17:08:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('105', '2018-05-28', 'K39269', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:08:49', '2018-07-10 17:08:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('106', '2018-05-28', 'K39270', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:08:53', '2018-07-10 17:08:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('107', '2018-05-28', 'K39271', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:08:57', '2018-07-10 17:08:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('108', '2018-05-28', 'K39272', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:00', '2018-07-10 17:09:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('109', '2018-05-28', 'K39273', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:03', '2018-07-10 17:09:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('110', '2018-05-28', 'K39274', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:07', '2018-07-10 17:09:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('111', '2018-05-28', 'K39275', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:09', '2018-07-10 17:09:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('112', '2018-05-28', 'K39276', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:12', '2018-07-10 17:09:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('113', '2018-05-28', 'K39277', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:15', '2018-07-10 17:09:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('114', '2018-05-28', 'K39278', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:19', '2018-07-10 17:09:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('115', '2018-05-28', 'K39279', 'A1805092XH', '96', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:09:23', '2018-07-10 17:09:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('117', '2018-05-28', 'K39280', 'A1805092XH', '126', 'Q1897', 'JS171201B', 'K180529XH', null, '96', '30', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:11:07', '2018-07-10 17:46:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('118', '2018-05-28', 'K39281', 'A1805092XH', '96', 'Q1897:51|Q1944:45', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:11:39', '2018-07-10 17:49:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('119', '2018-06-03', 'Q39878', 'A1805092XH', '96', 'Q1282:74|Q1023:22', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:17:34', '2018-07-10 19:07:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('120', '2018-06-03', 'Q39879', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:18:35', '2018-07-10 18:09:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('121', '2018-06-03', 'Q39880', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:18:42', '2018-07-10 18:09:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('122', '2018-06-03', 'Q39881', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:18:47', '2018-07-10 18:08:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('123', '2018-06-03', 'Q39882', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:18:51', '2018-07-10 18:08:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('124', '2018-06-03', 'Q39883', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:18:54', '2018-07-10 18:08:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('125', '2018-06-03', 'Q39884', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:18:57', '2018-07-10 18:05:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('126', '2018-06-03', 'Q39885', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:19:01', '2018-07-10 17:58:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('127', '2018-06-03', 'Q39886', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:19:07', '2018-07-10 17:58:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('128', '2018-06-03', 'Q39887', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:19:10', '2018-07-10 17:58:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('129', '2018-06-03', 'Q39888', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:19:13', '2018-07-10 17:59:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('130', '2018-06-03', 'Q39889', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:19:16', '2018-07-10 18:05:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('131', '2018-06-03', 'Q39890', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:19:22', '2018-07-10 18:00:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('132', '2018-06-03', 'Q39891', 'A1805092XH', '96', 'Q1282', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:19:26', '2018-07-10 18:06:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('134', '2018-06-03', 'Q39892', 'A1805092XH', '111', 'Q1282', 'JS180126', 'Q180603XH', null, '51', '60', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:21:35', '2018-07-10 18:07:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('135', '2018-06-03', 'Q39893', 'A1805092XH', '96', 'Q1282:79|Q1874:17', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:22:17', '2018-07-10 18:06:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('136', '2018-05-27', 'K39066', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:40:35', '2018-07-10 17:40:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('137', '2018-05-27', 'K39067', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:40:40', '2018-07-10 17:40:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('138', '2018-05-27', 'K39068', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:40:43', '2018-07-10 17:40:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('139', '2018-05-27', 'K39069', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:40:46', '2018-07-10 17:40:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('140', '2018-05-27', 'K39070', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:40:51', '2018-07-10 17:40:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('141', '2018-06-06', 'K40296', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:40:54', '2018-07-10 17:40:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('142', '2018-05-27', 'K39071', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:40:56', '2018-07-10 17:40:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('143', '2018-06-06', 'K40297', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:00', '2018-07-10 17:41:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('144', '2018-05-27', 'K39072', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:00', '2018-07-10 17:41:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('145', '2018-05-27', 'K39073', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:03', '2018-07-10 17:41:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('146', '2018-06-06', 'K40298', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:04', '2018-07-10 17:41:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('147', '2018-05-27', 'K39074', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:06', '2018-07-10 17:41:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('148', '2018-06-06', 'K40299', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:09', '2018-07-10 17:41:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('149', '2018-05-27', 'K39075', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:10', '2018-07-10 17:41:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('150', '2018-05-27', 'K39076', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:13', '2018-07-10 17:41:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('151', '2018-06-06', 'K40300', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:16', '2018-07-10 17:41:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('152', '2018-05-27', 'K39077', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:16', '2018-07-10 17:41:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('153', '2018-06-06', 'K40301', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:20', '2018-07-10 17:41:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('154', '2018-05-27', 'K39078', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:21', '2018-07-10 17:41:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('155', '2018-06-06', 'K40302', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:23', '2018-07-10 17:41:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('156', '2018-06-06', 'K40303', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:27', '2018-07-10 17:41:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('157', '2018-05-27', 'K39079', 'A1805092XH', '96', 'Q1758', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:28', '2018-07-10 17:41:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('158', '2018-06-06', 'K40304', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:30', '2018-07-10 17:41:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('159', '2018-06-06', 'K40305', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:34', '2018-07-10 17:41:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('160', '2018-06-06', 'K40306', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:37', '2018-07-10 17:41:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('161', '2018-06-06', 'K40307', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:41', '2018-07-10 17:41:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('162', '2018-06-06', 'K40308', 'A1805153XH', '96', 'Q2815', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:41:46', '2018-07-10 17:41:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('164', '2018-06-06', 'K40309', 'A1805153XH', '145', 'Q2815', 'JS180126', 'K180606XH', null, '96', '49', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:45:37', '2018-07-10 17:45:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('165', '2018-06-06', 'K40310', 'A1805153XH', '96', 'Q2815:89|Q2866:7', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:48:19', '2018-07-10 17:48:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('168', '2018-06-05', 'K40172', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:57:20', '2018-07-10 17:57:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('169', '2018-06-05', 'K40173', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:57:46', '2018-07-10 17:57:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('170', '2018-06-05', 'K40174', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:57:53', '2018-07-10 17:57:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('171', '2018-06-05', 'K40175', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:00', '2018-07-10 17:58:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('172', '2018-06-05', 'K40176', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:07', '2018-07-10 17:58:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('173', '2018-06-05', 'K40177', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:25', '2018-07-10 17:58:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('174', '2018-06-05', 'K40178', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:28', '2018-07-10 17:58:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('175', '2018-06-05', 'K40179', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:32', '2018-07-10 17:58:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('176', '2018-06-05', 'K40180', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:39', '2018-07-10 17:58:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('177', '2018-06-05', 'K40181', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:43', '2018-07-10 17:58:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('178', '2018-06-05', 'K40182', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:47', '2018-07-10 17:58:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('179', '2018-06-05', 'K40183', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:50', '2018-07-10 17:58:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('180', '2018-06-05', 'K40184', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:54', '2018-07-10 17:58:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('181', '2018-06-05', 'K40185', 'A1805153XH', '96', 'Q1235', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 17:58:58', '2018-07-10 17:58:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('182', '2018-06-05', 'K40186', 'A1805153XH', '149', 'Q1235', 'JS180126', 'K180605XH', null, '96', '53', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:02:22', '2018-07-10 18:02:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('183', '2018-06-05', 'K40112', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:05:57', '2018-07-10 18:05:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('184', '2018-06-05', 'K40113', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:06:01', '2018-07-10 18:06:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('185', '2018-06-05', 'K40114', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:00', '2018-07-10 18:16:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('186', '2018-06-05', 'K40115', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:05', '2018-07-10 18:16:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('187', '2018-05-28', 'K39189', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:08', '2018-07-10 18:16:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('188', '2018-06-05', 'K40116', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:10', '2018-07-10 18:16:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('189', '2018-06-05', 'K40117', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:17', '2018-07-10 18:16:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('190', '2018-05-28', 'K39190', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:18', '2018-07-10 18:16:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('191', '2018-06-05', 'K40118', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:21', '2018-07-10 18:16:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('192', '2018-05-28', 'K39191', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:22', '2018-07-10 18:16:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('193', '2018-06-05', 'K40119', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:24', '2018-07-10 18:16:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('194', '2018-05-28', 'K39192', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:26', '2018-07-10 18:16:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('195', '2018-06-05', 'K40120', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:30', '2018-07-10 18:16:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('196', '2018-05-28', 'K39193', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:32', '2018-07-10 18:16:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('197', '2018-06-05', 'K40121', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:35', '2018-07-10 18:16:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('198', '2018-05-28', 'K39194', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:36', '2018-07-10 18:16:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('199', '2018-06-05', 'K40122', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:39', '2018-07-10 18:16:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('200', '2018-05-28', 'K39195', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:40', '2018-07-10 18:16:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('201', '2018-05-28', 'K39196', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:44', '2018-07-10 18:16:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('202', '2018-06-05', 'K40123', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:45', '2018-07-10 18:16:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('203', '2018-06-05', 'K40124', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:49', '2018-07-10 18:16:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('204', '2018-05-28', 'K39198', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:53', '2018-07-10 18:16:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('205', '2018-06-05', 'K40125', 'A1805153XH', '96', 'Q2022', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:53', '2018-07-10 18:16:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('206', '2018-05-28', 'K39199', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:16:56', '2018-07-10 18:16:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('207', '2018-05-28', 'K39200', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:17:03', '2018-07-10 18:17:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('208', '2018-05-28', 'K39201', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:17:10', '2018-07-10 18:17:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('209', '2018-05-28', 'K39202', 'A1805092XH', '96', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:17:15', '2018-07-10 18:17:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('210', '2018-05-28', 'K39203', 'A1805092XH', '110', 'Q2491', 'JS171201B', 'K180528XH', null, '96', '14', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 18:18:33', '2018-07-10 18:18:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('211', '2018-05-29', 'K39327', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:11:50', '2018-07-10 19:11:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('212', '2018-05-29', 'K39328', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:11:54', '2018-07-10 19:11:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('213', '2018-05-29', 'K39329', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:01', '2018-07-10 19:12:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('214', '2018-05-29', 'K39330', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:05', '2018-07-10 19:12:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('215', '2018-05-29', 'K39331', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:09', '2018-07-10 19:12:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('216', '2018-05-29', 'K39332', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:17', '2018-07-10 19:12:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('217', '2018-05-29', 'K39333', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:19', '2018-07-10 19:12:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('218', '2018-05-29', 'K39334', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:22', '2018-07-10 19:12:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('219', '2018-05-29', 'K39335', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:25', '2018-07-10 19:12:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('220', '2018-05-29', 'K39336', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:33', '2018-07-10 19:12:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('221', '2018-05-29', 'K39337', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:37', '2018-07-10 19:12:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('222', '2018-05-29', 'K39338', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:40', '2018-07-10 19:12:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('223', '2018-05-29', 'K39339', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:43', '2018-07-10 19:12:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('224', '2018-05-29', 'K39340', 'A1805093XH', '96', 'Q2026', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:12:48', '2018-07-10 19:12:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('226', '2018-05-29', 'K39341', 'A1805093XH', '116', 'Q2026', 'JS180126', 'K180529XH', '13-0004,13-0005', '96', '20', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:14:44', '2018-07-17 14:10:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('227', '2018-06-05', 'K40126', 'A1805153XH', '132', 'Q2022', 'JS180126', 'K180605XH', null, '96', '36', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:15:18', '2018-07-10 19:15:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('229', '2018-05-30', 'K39357', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:17:30', '2018-07-10 19:17:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('230', '2018-05-30', 'K39358', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:17:37', '2018-07-10 19:17:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('231', '2018-05-30', 'K39359', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:17:41', '2018-07-10 19:17:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('232', '2018-05-30', 'K39360', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:17:47', '2018-07-10 19:17:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('233', '2018-05-30', 'K39361', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:17:50', '2018-07-10 19:17:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('234', '2018-05-30', 'K39362', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:17:53', '2018-07-10 19:17:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('235', '2018-05-30', 'K39363', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:17:56', '2018-07-10 19:17:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('236', '2018-05-30', 'K39364', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:18:00', '2018-07-10 19:18:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('237', '2018-05-30', 'K39365', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:18:03', '2018-07-10 19:18:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('238', '2018-05-30', 'K39366', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:18:06', '2018-07-10 19:18:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('239', '2018-05-30', 'K39367', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:18:09', '2018-07-10 19:18:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('240', '2018-05-30', 'K39368', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:18:12', '2018-07-10 19:18:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('241', '2018-05-30', 'K39369', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:18:18', '2018-07-10 19:18:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('242', '2018-05-30', 'K39370', 'A1805093XH', '96', 'Q1984', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:18:21', '2018-07-10 19:18:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('243', '2018-05-30', 'K39371', 'A1805093XH', '125', 'Q1984', 'JS180126', 'K180530XH', null, '96', '29', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:20:16', '2018-07-10 19:20:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('244', '2018-05-30', 'K39372', 'A1805093XH', '96', 'Q1984:4|Q2845:48', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:20:58', '2018-07-10 19:20:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('245', '2018-05-29', 'K39297', 'A1805151XH', '96', 'Q2088:84|Q1944:12', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:23:19', '2018-07-10 19:23:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('246', '2018-05-29', 'K39298', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:13', '2018-07-10 19:24:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('247', '2018-05-29', 'K39299', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:17', '2018-07-10 19:24:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('248', '2018-05-29', 'K39300', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:26', '2018-07-10 19:24:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('249', '2018-05-29', 'K39301', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:30', '2018-07-10 19:24:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('250', '2018-05-29', 'K39302', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:34', '2018-07-10 19:24:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('251', '2018-05-29', 'K39303', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:38', '2018-07-10 19:24:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('252', '2018-05-29', 'K39304', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:42', '2018-07-10 19:24:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('253', '2018-05-29', 'K39305', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:46', '2018-07-10 19:24:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('254', '2018-05-29', 'K39306', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:50', '2018-07-10 19:24:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('255', '2018-05-29', 'K39307', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:24:58', '2018-07-10 19:24:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('256', '2018-05-29', 'K39308', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:03', '2018-07-10 19:25:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('257', '2018-05-29', 'K39309', 'A1805151XH', '96', 'Q2088', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:10', '2018-07-10 19:25:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('258', '2018-05-29', 'K39282', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:28', '2018-07-10 19:25:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('259', '2018-05-29', 'K39283', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:32', '2018-07-10 19:25:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('260', '2018-05-29', 'K39284', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:34', '2018-07-10 19:25:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('261', '2018-05-29', 'K39285', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:37', '2018-07-10 19:25:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('262', '2018-05-29', 'K39286', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:40', '2018-07-10 19:25:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('263', '2018-05-29', 'K39287', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:43', '2018-07-10 19:25:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('264', '2018-05-29', 'K39288', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:45', '2018-07-10 19:25:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('265', '2018-05-29', 'K39289', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:49', '2018-07-10 19:25:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('266', '2018-05-29', 'K39290', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:53', '2018-07-10 19:25:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('267', '2018-05-29', 'K39291', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:25:57', '2018-07-10 19:25:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('268', '2018-05-29', 'K39292', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:26:00', '2018-07-10 19:26:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('269', '2018-05-29', 'K39293', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:26:03', '2018-07-10 19:26:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('270', '2018-05-29', 'K39294', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:26:06', '2018-07-10 19:26:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('271', '2018-05-29', 'K39295', 'A1805093XH', '96', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:26:10', '2018-07-10 19:26:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('273', '2018-05-29', 'K39310', 'A1805151XH', '131', 'Q2088', 'JS180126', 'K180529XH', null, '96', '35', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:27:04', '2018-07-10 19:27:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('274', '2018-05-29', 'K39296', 'A1805093XH', '116', 'Q1944', 'JS171201B', 'K180529XH', null, '96', '20', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:27:34', '2018-07-10 19:27:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('275', '2018-06-05', 'K39311', 'A1805151XH', '96', 'Q2088:87|Q2004:9', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:29:18', '2018-07-10 19:29:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('276', '2018-05-29', 'K39342', 'A1805151XH', '96', 'Q2049:74|Q2026:22', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:32:54', '2018-07-10 19:32:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('277', '2018-05-29', 'K39312', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:07', '2018-07-10 19:33:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('278', '2018-05-29', 'K39313', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:10', '2018-07-10 19:33:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('279', '2018-05-29', 'K39314', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:14', '2018-07-10 19:33:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('280', '2018-05-29', 'K39315', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:17', '2018-07-10 19:33:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('281', '2018-05-29', 'K39316', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:20', '2018-07-10 19:33:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('282', '2018-05-29', 'K39317', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:23', '2018-07-10 19:33:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('283', '2018-05-29', 'K39318', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:27', '2018-07-10 19:33:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('284', '2018-05-29', 'K39319', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:30', '2018-07-10 19:33:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('285', '2018-05-29', 'K39320', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:35', '2018-07-10 19:33:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('286', '2018-05-29', 'K39321', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:39', '2018-07-10 19:33:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('287', '2018-05-29', 'K39322', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:43', '2018-07-10 19:33:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('288', '2018-05-29', 'K39323', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:45', '2018-07-10 19:33:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('289', '2018-05-29', 'K39324', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:48', '2018-07-10 19:33:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('290', '2018-05-29', 'K39325', 'A1805093XH', '96', 'Q2136', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:50', '2018-07-10 19:33:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('291', '2018-05-29', 'K39343', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:33:56', '2018-07-10 19:33:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('292', '2018-05-29', 'K39344', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:00', '2018-07-10 19:34:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('293', '2018-05-29', 'K39345', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:03', '2018-07-10 19:34:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('294', '2018-05-29', 'K39346', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:10', '2018-07-10 19:34:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('295', '2018-05-29', 'K39347', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:14', '2018-07-10 19:34:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('296', '2018-05-29', 'K39348', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:17', '2018-07-10 19:34:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('297', '2018-05-29', 'K39349', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:21', '2018-07-10 19:34:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('298', '2018-05-29', 'K39350', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:27', '2018-07-10 19:34:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('299', '2018-05-29', 'K39351', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:31', '2018-07-10 19:34:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('300', '2018-05-29', 'K39352', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:35', '2018-07-10 19:34:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('301', '2018-05-29', 'K39353', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:39', '2018-07-10 19:34:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('302', '2018-05-29', 'K39354', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:44', '2018-07-10 19:34:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('303', '2018-05-29', 'K39355', 'A1805151XH', '96', 'Q2049', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:34:48', '2018-07-10 19:34:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('304', '2018-05-29', 'K39326', 'A1805093XH', '122', 'Q2136', 'JS180126', 'K180529XH', null, '96', '26', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:35:41', '2018-07-10 19:35:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('305', '2018-05-29', 'K39356', 'A1805151XH', '135', 'Q2049', 'JS180126', 'K180529XH', null, '96', '39', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:38:02', '2018-07-10 19:38:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('308', '2018-05-30', 'K39389', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:23', '2018-07-10 19:54:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('309', '2018-05-30', 'K39390', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:29', '2018-07-10 19:53:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('310', '2018-05-30', 'K39391', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:32', '2018-07-10 19:53:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('311', '2018-05-30', 'K39392', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:34', '2018-07-10 19:52:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('312', '2018-05-30', 'K39393', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:37', '2018-07-10 19:51:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('313', '2018-05-30', 'K39394', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:39', '2018-07-10 19:51:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('314', '2018-05-30', 'K39395', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:42', '2018-07-10 19:50:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('315', '2018-05-30', 'K39396', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:45', '2018-07-10 19:50:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('316', '2018-05-30', 'K39397', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:48', '2018-07-10 19:49:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('317', '2018-05-30', 'K39398', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:53', '2018-07-10 19:48:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('318', '2018-05-30', 'K39399', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:40:58', '2018-07-10 19:48:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('319', '2018-05-30', 'K39400', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:41:03', '2018-07-10 19:55:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('320', '2018-05-30', 'K39401', 'A1805151XH', '96', 'Q2144', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:41:07', '2018-07-10 19:56:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('321', '2018-05-30', 'K39402', 'A1805151XH', '112', 'Q2144', 'JS180126', 'K180530XH', null, '96', '16', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:43:31', '2018-07-10 19:57:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('322', '2018-05-30', 'K39373', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:43:47', '2018-07-10 19:43:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('323', '2018-05-30', 'K39374', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:43:51', '2018-07-10 19:43:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('324', '2018-05-30', 'K39375', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:43:54', '2018-07-10 19:43:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('325', '2018-05-30', 'K39376', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:43:58', '2018-07-10 19:43:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('326', '2018-05-30', 'K39377', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:01', '2018-07-10 19:44:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('327', '2018-05-30', 'K39378', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:06', '2018-07-10 19:44:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('328', '2018-05-30', 'K39379', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:10', '2018-07-10 19:44:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('329', '2018-05-30', 'K39380', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:15', '2018-07-10 19:44:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('330', '2018-05-30', 'K39381', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:18', '2018-07-10 19:44:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('331', '2018-05-30', 'K39403', 'A1805151XH', '96', 'Q2144:67|Q2828:29', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:19', '2018-07-10 19:56:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('332', '2018-05-30', 'K39382', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:22', '2018-07-10 19:44:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('333', '2018-05-30', 'K39383', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:26', '2018-07-10 19:44:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('334', '2018-05-30', 'K39384', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:30', '2018-07-10 19:44:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('335', '2018-05-30', 'K39385', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:33', '2018-07-10 19:44:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('336', '2018-05-30', 'K39386', 'A1805151XH', '96', 'Q2845', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:44:38', '2018-07-10 19:44:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('337', '2018-05-30', 'K39387', 'A1805151XH', '120', 'Q2845', 'JS180126', 'K180530XH', null, '96', '24', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:46:14', '2018-07-10 19:46:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('338', '2018-05-30', 'K39388', 'A1805151XH', '96', 'Q2144:90|Q2845:6', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:47:36', '2018-07-10 19:47:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('339', '2018-05-30', 'K39404', 'A1805151XH', '96', 'Q1365:79|Q2049:17', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:50:39', '2018-07-10 19:50:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('340', '2018-05-30', 'K39405', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:06', '2018-07-10 19:52:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('341', '2018-05-30', 'K39406', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:10', '2018-07-10 19:52:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('342', '2018-05-30', 'K39407', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:15', '2018-07-10 19:52:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('343', '2018-05-30', 'K39408', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:18', '2018-07-10 19:52:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('344', '2018-05-30', 'K39409', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:22', '2018-07-10 19:52:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('345', '2018-05-30', 'K39410', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:30', '2018-07-10 19:52:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('346', '2018-05-30', 'K39411', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:34', '2018-07-10 19:52:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('347', '2018-05-30', 'K39412', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:38', '2018-07-10 19:52:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('348', '2018-05-30', 'K39413', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:41', '2018-07-10 19:52:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('349', '2018-05-30', 'K39414', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:46', '2018-07-10 19:52:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('350', '2018-05-30', 'K39415', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:49', '2018-07-10 19:52:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('351', '2018-05-30', 'K39416', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:53', '2018-07-10 19:52:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('352', '2018-05-30', 'K39417', 'A1805151XH', '96', 'Q1365', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:52:57', '2018-07-10 19:52:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('353', '2018-05-30', 'K39418', 'A1805151XH', '128', 'Q1365', 'JS180126', 'K180530XH', null, '96', '32', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:54:57', '2018-07-10 19:54:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('354', '2018-05-30', 'K39419', 'A1805151XH', '96', 'Q1365:58|Q677:38', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-10 19:56:19', '2018-07-10 19:56:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('356', '2018-06-05', 'K40097', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:03:49', '2018-07-17 16:03:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('357', '2018-06-05', 'K40098', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:03:56', '2018-07-17 16:03:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('358', '2018-05-30', 'K39482', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:03:58', '2018-07-17 16:03:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('359', '2018-06-05', 'K40099', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:02', '2018-07-17 16:04:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('360', '2018-05-30', 'K39483', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:05', '2018-07-17 16:04:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('361', '2018-05-30', 'K39484', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:09', '2018-07-17 16:04:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('362', '2018-06-05', 'K40100', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:13', '2018-07-17 16:04:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('363', '2018-05-30', 'K39485', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:14', '2018-07-17 16:04:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('364', '2018-05-30', 'K39486', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:20', '2018-07-17 16:04:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('365', '2018-06-05', 'K40101', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:21', '2018-07-17 16:04:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('366', '2018-05-30', 'K39487', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:25', '2018-07-17 16:04:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('367', '2018-06-05', 'K40102', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:28', '2018-07-17 16:04:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('368', '2018-05-30', 'K39488', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:30', '2018-07-17 16:04:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('369', '2018-05-30', 'K39489', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:34', '2018-07-17 16:04:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('370', '2018-06-05', 'K40103', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:37', '2018-07-17 16:04:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('371', '2018-05-30', 'K39490', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:39', '2018-07-17 16:04:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('372', '2018-06-05', 'K40104', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:41', '2018-07-17 16:04:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('373', '2018-05-30', 'K39491', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:44', '2018-07-17 16:04:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('374', '2018-06-05', 'K40105', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:45', '2018-07-17 16:04:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('375', '2018-06-05', 'K40106', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:47', '2018-07-17 16:04:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('376', '2018-05-30', 'K39492', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:49', '2018-07-17 16:04:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('377', '2018-06-05', 'K40107', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:51', '2018-07-17 16:04:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('378', '2018-05-30', 'K39493', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:53', '2018-07-17 16:04:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('379', '2018-06-05', 'K40108', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:54', '2018-07-17 16:04:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('380', '2018-05-30', 'K39494', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:04:58', '2018-07-17 16:04:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('381', '2018-05-30', 'K39495', 'A1805092XH', '96', 'Q673', 'JS171201B', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:05:03', '2018-07-17 16:05:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('382', '2018-06-05', 'K40109', 'A1805153XH', '96', 'Q1382', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:05:11', '2018-07-17 16:05:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('383', '2018-06-05', 'K40110', 'A1805153XH', '118', 'Q1382', 'JS180126', 'K180605XH', null, '96', '22', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:06:43', '2018-07-17 16:06:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('384', '2018-05-30', 'K39496', 'A1805092XH', '114', 'Q673', 'JS171201B', 'K180530XH', null, '96', '18', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:06:59', '2018-07-17 16:06:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('385', '2018-06-05', 'K40111', 'A1805153XH', '96', 'Q1382:74|Q852:22', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:07:34', '2018-07-17 16:09:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('386', '2018-05-27', 'K39051', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:10:58', '2018-07-17 16:10:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('387', '2018-05-27', 'K39052', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:18', '2018-07-17 16:11:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('388', '2018-05-27', 'K39053', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:22', '2018-07-17 16:11:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('389', '2018-05-27', 'K39054', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:27', '2018-07-17 16:11:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('390', '2018-05-27', 'K39055', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:33', '2018-07-17 16:11:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('391', '2018-05-27', 'K39056', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:38', '2018-07-17 16:11:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('392', '2018-05-27', 'K39057', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:43', '2018-07-17 16:11:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('393', '2018-05-27', 'K39058', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:47', '2018-07-17 16:11:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('394', '2018-05-27', 'K39059', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:52', '2018-07-17 16:11:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('395', '2018-05-27', 'K39060', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:11:58', '2018-07-17 16:11:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('396', '2018-05-27', 'K39061', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:12:03', '2018-07-17 16:12:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('397', '2018-05-27', 'K39062', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:12:07', '2018-07-17 16:12:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('398', '2018-05-27', 'K39063', 'A1805092XH', '96', 'Q388', '', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:12:12', '2018-07-17 16:12:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('399', '2018-06-05', 'K40157', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:12:52', '2018-07-17 16:12:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('400', '2018-06-05', 'K40158', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:12:58', '2018-07-17 16:12:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('401', '2018-06-05', 'K40159', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:00', '2018-07-17 16:13:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('402', '2018-06-05', 'K40160', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:06', '2018-07-17 16:13:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('403', '2018-06-05', 'K40161', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:10', '2018-07-17 16:13:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('404', '2018-06-05', 'K40162', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:13', '2018-07-17 16:13:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('405', '2018-06-05', 'K40163', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:16', '2018-07-17 16:13:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('406', '2018-06-05', 'K40164', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:19', '2018-07-17 16:13:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('407', '2018-06-05', 'K40165', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:22', '2018-07-17 16:13:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('408', '2018-06-05', 'K40166', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:24', '2018-07-17 16:13:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('409', '2018-06-05', 'K40167', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:27', '2018-07-17 16:13:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('410', '2018-06-05', 'K40168', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:30', '2018-07-17 16:13:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('411', '2018-06-05', 'K40169', 'A1805153XH', '96', 'Q290', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:33', '2018-07-17 16:13:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('412', '2018-05-27', 'K39064', 'A1805092XH', '190', 'Q388', '', 'K180527XH', null, '96', '94', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:13:42', '2018-07-17 16:13:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('413', '2018-06-05', 'K40170', 'A1805153XH', '132', 'Q290', 'JS180126', 'K180605XH', null, '96', '36', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:15:03', '2018-07-17 16:15:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('414', '2018-05-27', 'K39065', 'A1805092XH', '96', 'Q388:69|Q1758:27', 'JS171201B', 'K180527XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:15:30', '2018-07-17 16:15:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('415', '2018-06-05', 'K40171', 'A1805153XH', '96', 'Q290:75|Q1235:21', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:16:25', '2018-07-17 16:16:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('418', '2018-06-02', 'Q39787', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:04', '2018-07-17 16:22:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('419', '2018-06-02', 'Q39788', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:11', '2018-07-17 16:22:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('420', '2018-06-02', 'Q39789', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:20', '2018-07-17 16:22:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('421', '2018-06-02', 'Q39790', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:25', '2018-07-17 16:22:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('422', '2018-06-02', 'Q39791', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:33', '2018-07-17 16:22:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('423', '2018-06-05', 'K40127', 'A1805153XH', '96', 'Q2161:69|Q2022:27', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:36', '2018-07-17 16:22:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('424', '2018-06-02', 'Q39792', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:38', '2018-07-17 16:22:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('425', '2018-06-02', 'Q39793', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:43', '2018-07-17 16:22:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('426', '2018-06-02', 'Q39794', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:48', '2018-07-17 16:22:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('427', '2018-06-02', 'Q39795', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:22:58', '2018-07-17 16:22:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('428', '2018-06-02', 'Q39796', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:07', '2018-07-17 16:23:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('429', '2018-06-02', 'Q39797', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:12', '2018-07-17 16:23:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('430', '2018-06-05', 'K40128', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:17', '2018-07-17 16:23:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('431', '2018-06-02', 'Q39798', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:17', '2018-07-17 16:23:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('432', '2018-06-05', 'K40129', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:20', '2018-07-17 16:23:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('433', '2018-06-02', 'Q39799', 'A1805093XH', '96', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:23', '2018-07-17 16:23:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('434', '2018-06-05', 'K40130', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:26', '2018-07-17 16:23:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('435', '2018-06-05', 'K40131', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:39', '2018-07-17 16:23:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('436', '2018-06-05', 'K40132', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:42', '2018-07-17 16:23:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('437', '2018-06-05', 'K40133', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:47', '2018-07-17 16:23:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('438', '2018-06-05', 'K40134', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:50', '2018-07-17 16:23:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('439', '2018-06-05', 'K40135', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:52', '2018-07-17 16:23:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('440', '2018-06-05', 'K40136', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:56', '2018-07-17 16:23:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('441', '2018-06-05', 'K40137', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:23:58', '2018-07-17 16:23:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('442', '2018-06-05', 'K40138', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:24:02', '2018-07-17 16:24:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('443', '2018-06-05', 'K40139', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:24:10', '2018-07-17 16:24:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('444', '2018-06-05', 'K40140', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:24:16', '2018-07-17 16:24:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('445', '2018-06-05', 'K40141', 'A1805153XH', '96', 'Q2161', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:24:21', '2018-07-17 16:24:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('446', '2018-06-02', 'Q39800', 'A1805093XH', '117', 'Q2821', 'JS180126', 'Q180602XH', null, '96', '21', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:25:05', '2018-07-17 16:25:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('447', '2018-06-05', 'K40142', 'A1805153XH', '130', 'Q2161', 'JS180126', 'K180605XH', null, '100', '30', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:26:31', '2018-07-17 16:26:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('448', '2018-06-02', 'Q39801', 'A1805093XH', '96', 'Q2821:69|Q1023:27', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:26:34', '2018-07-17 16:26:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('449', '2018-06-05', 'K40187', 'A1805153XH', '96', 'Q1235:4|Q2807:92', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:29:47', '2018-07-17 16:29:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('450', '2018-06-05', 'K40188', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:35', '2018-07-17 16:30:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('451', '2018-06-05', 'K40189', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:39', '2018-07-17 16:30:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('453', '2018-06-05', 'K40190', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:44', '2018-07-17 16:30:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('454', '2018-06-05', 'K40191', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:48', '2018-07-17 16:30:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('455', '2018-06-05', 'K40192', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:51', '2018-07-17 16:30:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('456', '2018-06-05', 'K40193', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:53', '2018-07-17 16:30:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('457', '2018-06-05', 'K40194', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:57', '2018-07-17 16:30:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('458', '2018-06-05', 'K40195', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:30:59', '2018-07-17 16:30:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('459', '2018-06-05', 'K40196', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:31:02', '2018-07-17 16:31:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('460', '2018-06-05', 'K40197', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:31:09', '2018-07-17 16:31:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('461', '2018-06-05', 'K40198', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:31:29', '2018-07-17 16:31:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('462', '2018-06-05', 'K40199', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:31:33', '2018-07-17 16:31:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('463', '2018-06-05', 'K40200', 'A1805153XH', '96', 'Q2807', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:31:38', '2018-07-17 16:31:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('472', '2018-06-05', 'K40201', 'A1805153XH', '120', 'Q2807', 'JS180126', 'K180605XH', null, '96', '24', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:33:07', '2018-07-17 16:33:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('479', '2018-06-05', 'K40202', 'A1805153XH', '96', 'Q2807:56|Q2050:38', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:34:05', '2018-07-17 16:34:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('481', '2018-06-06', 'K40203', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:03', '2018-07-17 16:36:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('482', '2018-06-06', 'K40204', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:12', '2018-07-17 16:36:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('483', '2018-06-06', 'K40205', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:15', '2018-07-17 16:36:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('484', '2018-06-06', 'K40207', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:21', '2018-07-17 16:36:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('485', '2018-06-06', 'K40208', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:24', '2018-07-17 16:36:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('486', '2018-06-06', 'K40209', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:27', '2018-07-17 16:36:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('487', '2018-06-06', 'K40210', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:33', '2018-07-17 16:36:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('488', '2018-06-06', 'K40211', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:35', '2018-07-17 16:36:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('489', '2018-06-06', 'K40212', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:38', '2018-07-17 16:36:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('490', '2018-06-06', 'K40213', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:41', '2018-07-17 16:36:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('491', '2018-06-06', 'K40214', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:44', '2018-07-17 16:36:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('492', '2018-06-06', 'K40215', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:46', '2018-07-17 16:36:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('493', '2018-06-06', 'K40216', 'A1805153XH', '96', 'Q852', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:36:50', '2018-07-17 16:36:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('494', '2018-06-06', 'K40217', 'A1805153XH', '111', 'Q852', 'JS180126', 'K180605XH', null, '96', '15', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:37:52', '2018-07-17 16:37:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('495', '2018-06-03', 'Q39956', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:22', '2018-07-17 16:38:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('496', '2018-06-03', 'Q39957', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:27', '2018-07-17 16:38:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('497', '2018-06-06', 'K40218', 'A1805153XH', '96', 'Q2866:55|Q852:41', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:28', '2018-07-17 16:38:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('498', '2018-06-03', 'Q39958', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:32', '2018-07-17 16:38:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('499', '2018-06-03', 'Q39959', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:38', '2018-07-17 16:38:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('500', '2018-06-03', 'Q39960', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:42', '2018-07-17 16:38:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('501', '2018-06-03', 'Q39961', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:47', '2018-07-17 16:38:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('502', '2018-06-03', 'Q39962', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:51', '2018-07-17 16:38:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('503', '2018-06-03', 'Q39963', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:38:56', '2018-07-17 16:38:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('504', '2018-06-03', 'Q39964', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:39:01', '2018-07-17 16:39:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('505', '2018-06-03', 'Q39965', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:39:06', '2018-07-17 16:39:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('506', '2018-06-03', 'Q39966', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:39:10', '2018-07-17 16:39:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('507', '2018-06-03', 'Q39967', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:39:15', '2018-07-17 16:39:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('508', '2018-06-03', 'Q39968', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:39:20', '2018-07-17 16:39:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('509', '2018-06-03', 'Q39969', 'A1805093XH', '96', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:39:24', '2018-07-17 16:39:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('510', '2018-06-03', 'Q39970', 'A1805093XH', '114', 'Q1478', 'JS180126', 'Q180603XH', null, '96', '18', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:40:54', '2018-07-17 16:40:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('511', '2018-06-03', 'Q39971', 'A1805093XH', '96', 'Q1478:57|Q2501:39', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:41:37', '2018-07-17 16:41:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('512', '2018-06-05', 'K40143', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:15', '2018-07-17 16:44:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('513', '2018-06-05', 'K40144', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:18', '2018-07-17 16:44:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('514', '2018-06-05', 'K40145', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:20', '2018-07-17 16:44:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('515', '2018-06-05', 'K40146', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:24', '2018-07-17 16:44:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('516', '2018-06-05', 'K40147', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:26', '2018-07-17 16:44:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('517', '2018-06-05', 'K40148', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:29', '2018-07-17 16:44:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('518', '2018-06-05', 'K40149', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:31', '2018-07-17 16:44:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('519', '2018-06-05', 'K40150', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:36', '2018-07-17 16:44:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('520', '2018-06-05', 'K40151', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:49', '2018-07-17 16:44:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('521', '2018-06-05', 'K40152', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:52', '2018-07-17 16:44:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('522', '2018-06-05', 'K40153', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:44:56', '2018-07-17 16:44:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('523', '2018-06-05', 'K40154', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:45:02', '2018-07-17 16:45:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('524', '2018-06-05', 'K40155', 'A1805153XH', '96', 'Q1311', '', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:45:05', '2018-07-17 16:45:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('525', '2018-06-05', 'K40156', 'A1805153XH', '140', 'Q1311', '', 'K180605XH', null, '96', '44', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-17 16:47:59', '2018-07-17 16:47:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('542', '2018-06-06', 'K40250', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:00', '2018-07-18 09:45:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('543', '2018-06-06', 'K40251', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:04', '2018-07-18 09:45:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('544', '2018-06-06', 'K40252', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:07', '2018-07-18 09:45:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('545', '2018-06-06', 'K40253', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:09', '2018-07-18 09:45:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('546', '2018-06-06', 'K40254', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:13', '2018-07-18 09:45:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('547', '2018-06-06', 'K40255', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:17', '2018-07-18 09:45:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('548', '2018-06-06', 'K40256', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:20', '2018-07-18 09:45:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('549', '2018-06-06', 'K40257', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:23', '2018-07-18 09:45:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('550', '2018-06-06', 'K40258', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:28', '2018-07-18 09:45:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('551', '2018-06-06', 'K40259', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:35', '2018-07-18 09:45:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('552', '2018-06-06', 'K40260', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:41', '2018-07-18 09:45:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('553', '2018-06-06', 'K40261', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:44', '2018-07-18 09:45:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('554', '2018-06-06', 'K40262', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:45:48', '2018-07-18 09:45:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('555', '2018-06-02', 'Q39817', 'A1805093XH', '96', 'Q1868:52|Q2863:44', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:46:57', '2018-07-18 09:46:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('556', '2018-06-02', 'Q39818', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:17', '2018-07-18 09:53:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('557', '2018-06-02', 'Q39819', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:21', '2018-07-18 09:53:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('558', '2018-06-02', 'Q39820', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:26', '2018-07-18 09:53:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('559', '2018-06-02', 'Q39821', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:30', '2018-07-18 09:53:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('560', '2018-06-02', 'Q39822', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:39', '2018-07-18 09:53:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('561', '2018-06-02', 'Q39823', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:43', '2018-07-18 09:53:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('562', '2018-06-02', 'Q39824', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:50', '2018-07-18 09:53:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('563', '2018-06-02', 'Q39825', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:53:55', '2018-07-18 09:53:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('564', '2018-06-02', 'Q39826', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:54:05', '2018-07-18 09:54:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('565', '2018-06-02', 'Q39827', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:54:09', '2018-07-18 09:54:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('566', '2018-06-02', 'Q39828', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:54:14', '2018-07-18 09:54:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('567', '2018-06-02', 'Q39829', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:54:20', '2018-07-18 09:54:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('568', '2018-06-02', 'Q39830', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:54:25', '2018-07-18 09:54:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('569', '2018-06-02', 'Q39831', 'A1805093XH', '96', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:54:30', '2018-07-18 09:54:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('570', '2018-06-02', 'Q39832', 'A1805093XH', '124', 'Q2863', 'JS180126', 'Q180602XH', null, '96', '28', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 09:56:38', '2018-07-18 09:56:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('571', '2018-06-02', 'Q39756', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:11', '2018-07-18 10:02:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('572', '2018-06-02', 'Q39757', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:15', '2018-07-18 10:02:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('573', '2018-06-02', 'Q39758', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:20', '2018-07-18 10:02:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('574', '2018-06-02', 'Q39759', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:24', '2018-07-18 10:02:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('575', '2018-06-02', 'Q39760', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:30', '2018-07-18 10:02:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('576', '2018-06-02', 'Q39761', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:35', '2018-07-18 10:02:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('577', '2018-06-02', 'Q39762', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:39', '2018-07-18 10:02:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('578', '2018-06-02', 'Q39763', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:44', '2018-07-18 10:02:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('579', '2018-06-02', 'Q39764', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:50', '2018-07-18 10:02:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('580', '2018-06-02', 'Q39765', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:54', '2018-07-18 10:02:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('581', '2018-06-02', 'Q39766', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:02:58', '2018-07-18 10:02:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('582', '2018-06-02', 'Q39767', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:03:03', '2018-07-18 10:03:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('583', '2018-06-02', 'Q39768', 'A1805093XH', '96', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:03:07', '2018-07-18 10:03:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('584', '2018-06-02', 'Q39769', 'A1805093XH', '125', 'Q2002', 'JS180126', 'Q180602XH', null, '96', '29', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:05:18', '2018-07-18 10:05:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('585', '2018-06-08', 'K40480', 'A1805153XH', '96', 'Q987:62|Q1311:34', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:05:28', '2018-07-18 10:05:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('586', '2018-06-02', 'Q39770', 'A1805093XH', '96', 'Q2002:53|Q1990:43', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:04', '2018-07-18 10:06:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('587', '2018-06-08', 'K40481', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:12', '2018-07-18 10:06:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('588', '2018-06-08', 'K40482', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:15', '2018-07-18 10:06:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('589', '2018-06-08', 'K40483', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:18', '2018-07-18 10:06:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('590', '2018-06-08', 'K40484', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:20', '2018-07-18 10:06:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('591', '2018-06-08', 'K40485', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:23', '2018-07-18 10:06:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('592', '2018-06-08', 'K40486', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:26', '2018-07-18 10:06:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('593', '2018-06-08', 'K40487', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:45', '2018-07-18 10:06:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('594', '2018-06-08', 'K40488', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:45', '2018-07-18 10:06:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('595', '2018-06-08', 'K40489', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:45', '2018-07-18 10:06:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('596', '2018-06-08', 'K40490', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:45', '2018-07-18 10:06:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('597', '2018-06-08', 'K40491', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:45', '2018-07-18 10:06:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('598', '2018-06-08', 'K40492', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:51', '2018-07-18 10:06:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('599', '2018-06-08', 'K40493', 'A1805153XH', '96', 'Q987', 'JS180126', 'K180608XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:06:54', '2018-07-18 10:06:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('600', '2018-06-08', 'K40494', 'A1805153XH', '123', 'Q987', 'JS180126', 'K180608XH', null, '96', '27', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:08:41', '2018-07-18 10:08:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('601', '2018-06-02', 'Q39771', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:10:23', '2018-07-18 10:10:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('602', '2018-06-02', 'Q39772', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:10:34', '2018-07-18 10:10:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('603', '2018-06-02', 'Q39773', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:10:39', '2018-07-18 10:10:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('604', '2018-06-02', 'Q39774', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:10:44', '2018-07-18 10:10:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('605', '2018-06-02', 'Q39775', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:10:50', '2018-07-18 10:10:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('606', '2018-06-02', 'Q39776', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:10:57', '2018-07-18 10:10:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('607', '2018-06-02', 'Q39777', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:04', '2018-07-18 10:11:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('608', '2018-06-02', 'Q39778', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:09', '2018-07-18 10:11:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('609', '2018-06-02', 'Q39779', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:16', '2018-07-18 10:11:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('610', '2018-06-02', 'Q39780', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:21', '2018-07-18 10:11:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('611', '2018-06-02', 'Q39781', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:27', '2018-07-18 10:11:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('612', '2018-06-02', 'Q39782', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:31', '2018-07-18 10:11:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('613', '2018-06-02', 'Q39783', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:39', '2018-07-18 10:11:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('614', '2018-06-02', 'Q39784', 'A1805093XH', '96', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:11:44', '2018-07-18 10:11:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('618', '2018-06-01', 'K39621', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:26', '2018-07-18 10:12:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('619', '2018-06-01', 'K39622', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:31', '2018-07-18 10:12:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('620', '2018-06-01', 'K39623', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:33', '2018-07-18 10:12:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('621', '2018-06-01', 'K39624', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:35', '2018-07-18 10:12:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('622', '2018-06-01', 'K39625', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:39', '2018-07-18 10:12:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('623', '2018-06-01', 'K39626', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:42', '2018-07-18 10:12:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('624', '2018-06-01', 'K39627', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:45', '2018-07-18 10:12:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('625', '2018-06-01', 'K39628', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:47', '2018-07-18 10:12:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('626', '2018-06-01', 'K39629', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:50', '2018-07-18 10:12:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('627', '2018-06-01', 'K39630', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:12:55', '2018-07-18 10:12:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('628', '2018-06-01', 'K39631', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:13:01', '2018-07-18 10:13:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('629', '2018-06-01', 'K39632', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:13:04', '2018-07-18 10:13:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('630', '2018-06-02', 'Q39785', 'A1805093XH', '118', 'Q1990', 'JS180126', 'Q180602XH', null, '96', '22', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:13:11', '2018-07-18 10:13:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('631', '2018-06-02', 'Q39786', 'A1805093XH', '96', 'Q2821:84|Q1990:12', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:13:50', '2018-07-18 10:13:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('632', '2018-06-01', 'K39633', 'A1805152XH', '130', 'Q2379', 'JS180126', 'K180601XH', null, '96', '34', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:16:13', '2018-07-18 10:16:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('633', '2018-06-01', 'K39619', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:19:32', '2018-07-18 10:19:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('634', '2018-06-01', 'K39620', 'A1805152XH', '96', 'Q2379', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:19:48', '2018-07-18 10:19:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('635', '2018-06-02', 'Q39802', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:00', '2018-07-18 10:27:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('636', '2018-06-02', 'Q39803', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:13', '2018-07-18 10:27:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('637', '2018-06-02', 'Q39804', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:17', '2018-07-18 10:27:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('638', '2018-05-31', 'K39573', 'A1805152XH', '96', 'Q1781:49|Q2059:47', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:20', '2018-07-18 10:27:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('639', '2018-06-02', 'Q39805', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:22', '2018-07-18 10:27:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('640', '2018-06-02', 'Q39806', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:28', '2018-07-18 10:27:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('641', '2018-06-02', 'Q39807', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:32', '2018-07-18 10:27:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('642', '2018-06-02', 'Q39808', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:36', '2018-07-18 10:27:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('643', '2018-06-02', 'Q39809', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:41', '2018-07-18 10:27:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('644', '2018-06-02', 'Q39810', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:47', '2018-07-18 10:27:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('645', '2018-06-02', 'Q39811', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:27:52', '2018-07-18 10:27:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('646', '2018-05-31', 'K39574', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:05', '2018-07-18 10:28:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('647', '2018-05-31', 'K39575', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:09', '2018-07-18 10:28:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('648', '2018-06-02', 'Q39812', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:12', '2018-07-18 10:28:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('649', '2018-05-31', 'K39576', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:12', '2018-07-18 10:28:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('650', '2018-06-02', 'Q39813', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:16', '2018-07-18 10:28:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('651', '2018-05-31', 'K39577', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:16', '2018-07-18 10:28:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('652', '2018-05-31', 'K39578', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:19', '2018-07-18 10:28:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('653', '2018-06-02', 'Q39814', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:21', '2018-07-18 10:28:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('654', '2018-05-31', 'K39579', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:22', '2018-07-18 10:28:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('655', '2018-06-02', 'Q39815', 'A1805093XH', '96', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:27', '2018-07-18 10:28:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('656', '2018-05-31', 'K39580', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:29', '2018-07-18 10:28:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('657', '2018-05-31', 'K39581', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:33', '2018-07-18 10:28:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('658', '2018-05-31', 'K39582', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:36', '2018-07-18 10:28:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('659', '2018-05-31', 'K39583', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:38', '2018-07-18 10:28:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('660', '2018-05-31', 'K39584', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:42', '2018-07-18 10:28:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('661', '2018-05-31', 'K39585', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:46', '2018-07-18 10:28:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('662', '2018-05-31', 'K39586', 'A1805152XH', '96', 'Q1781', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:28:52', '2018-07-18 10:28:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('663', '2018-06-02', 'Q39816', 'A1805093XH', '122', 'Q1868', 'JS180126', 'Q180602XH', null, '96', '26', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:29:59', '2018-07-18 10:29:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('664', '2018-05-31', 'K39587', 'A1805152XH', '121', 'Q1781', 'JS180126', 'K180531XH', null, '96', '25', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:30:20', '2018-07-18 10:30:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('665', '2018-05-31', 'K39588', 'A1805152XH', '96', 'Q1781:68|Q2216:28', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:31:57', '2018-07-18 10:31:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('680', '2018-05-28', 'K39157', 'A1805093XH', '96', 'Q1469:76|Q2309:20', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:38:04', '2018-07-18 10:38:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('682', '2018-05-28', 'K39158', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:01', '2018-07-18 10:40:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('683', '2018-05-28', 'K39159', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:05', '2018-07-18 10:40:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('684', '2018-05-28', 'K39160', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:10', '2018-07-18 10:40:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('685', '2018-05-28', 'K39161', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:16', '2018-07-18 10:40:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('686', '2018-05-28', 'K39162', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:21', '2018-07-18 10:40:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('687', '2018-05-28', 'K39163', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:25', '2018-07-18 10:40:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('688', '2018-05-28', 'K39164', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:29', '2018-07-18 10:40:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('689', '2018-05-28', 'K39165', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:33', '2018-07-18 10:40:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('690', '2018-05-28', 'K39166', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:38', '2018-07-18 10:40:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('691', '2018-05-28', 'K39167', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:42', '2018-07-18 10:40:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('692', '2018-05-28', 'K39168', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:48', '2018-07-18 10:40:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('693', '2018-05-28', 'K39169', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:53', '2018-07-18 10:40:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('694', '2018-05-28', 'K39170', 'A1805093XH', '96', 'Q1469', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:40:59', '2018-07-18 10:40:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('695', '2018-05-28', 'K39171', 'A1805093XH', '116', 'Q1469', 'JS180126', 'K180528XH', null, '96', '20', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:42:28', '2018-07-18 10:42:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('696', '2018-06-02', 'K39741', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:01', '2018-07-18 10:43:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('697', '2018-06-02', 'K39742', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:09', '2018-07-18 10:43:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('698', '2018-06-02', 'K39743', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:13', '2018-07-18 10:43:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('699', '2018-06-02', 'K39744', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:16', '2018-07-18 10:43:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('700', '2018-06-02', 'K39745', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:19', '2018-07-18 10:43:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('701', '2018-06-02', 'K39746', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:22', '2018-07-18 10:43:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('702', '2018-06-02', 'K39747', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:25', '2018-07-18 10:43:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('703', '2018-06-02', 'K39748', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:29', '2018-07-18 10:43:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('704', '2018-06-02', 'K39749', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:33', '2018-07-18 10:43:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('705', '2018-06-02', 'K39750', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:43', '2018-07-18 10:43:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('706', '2018-06-02', 'K39751', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:46', '2018-07-18 10:43:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('707', '2018-06-02', 'K39752', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:49', '2018-07-18 10:43:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('708', '2018-06-02', 'K39753', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:43:56', '2018-07-18 10:43:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('709', '2018-06-02', 'K39754', 'A1805152XH', '96', 'Q909', 'JS180126', 'K180602XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:44:01', '2018-07-18 10:44:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('710', '2018-05-28', 'K39204', 'A1805093XH', '96', 'Q2309:83|Q2491:13', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:45:14', '2018-07-18 10:45:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('711', '2018-05-28', 'K39205', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:45:52', '2018-07-18 10:45:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('712', '2018-05-28', 'K39206', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:45:56', '2018-07-18 10:45:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('713', '2018-05-28', 'K39207', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:00', '2018-07-18 10:46:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('714', '2018-05-28', 'K39208', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:06', '2018-07-18 10:46:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('715', '2018-06-02', 'K39755', 'A1805152XH', '149', 'Q909', 'JS180126', 'K180602XH', null, '96', '53', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:06', '2018-07-18 13:31:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('716', '2018-05-28', 'K39209', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:10', '2018-07-18 10:46:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('717', '2018-05-28', 'K39210', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:16', '2018-07-18 10:46:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('718', '2018-05-28', 'K39211', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:20', '2018-07-18 10:46:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('719', '2018-05-28', 'K39212', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:27', '2018-07-18 10:46:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('720', '2018-05-28', 'K39213', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:31', '2018-07-18 10:46:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('721', '2018-05-28', 'K39214', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:35', '2018-07-18 10:46:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('722', '2018-05-28', 'K39215', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:40', '2018-07-18 10:46:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('724', '2018-05-28', 'K39216', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:44', '2018-07-18 10:46:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('725', '2018-05-28', 'K39217', 'A1805093XH', '96', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:46:48', '2018-07-18 10:46:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('726', '2018-05-28', 'K39218', 'A1805093XH', '167', 'Q2309', 'JS171201B', 'K180528XH', null, '96', '71', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 10:49:03', '2018-07-18 10:49:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('727', '2018-06-06', 'K40263', 'A1805153XH', '96', 'Q2050', 'JS180126', 'K180606XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 12:24:11', '2018-07-18 12:24:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('728', '2018-06-06', 'K40264', 'A1805153XH', '131', 'Q2050', 'JS180126', 'K180606XH', null, '96', '35', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 12:25:18', '2018-07-18 13:27:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('730', '2018-05-28', 'K39112', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:10', '2018-07-18 13:36:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('731', '2018-05-28', 'K39113', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:16', '2018-07-18 13:36:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('732', '2018-05-28', 'K39114', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:21', '2018-07-18 13:36:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('733', '2018-05-28', 'K39115', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:26', '2018-07-18 13:36:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('734', '2018-05-28', 'K39116', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:33', '2018-07-18 13:36:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('735', '2018-05-28', 'K39117', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:38', '2018-07-18 13:36:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('736', '2018-05-28', 'K39118', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:43', '2018-07-18 13:36:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('737', '2018-05-28', 'K39119', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:48', '2018-07-18 13:36:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('738', '2018-05-28', 'K39120', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:55', '2018-07-18 13:36:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('739', '2018-05-28', 'K39121', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:36:59', '2018-07-18 13:36:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('740', '2018-05-28', 'K39122', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:04', '2018-07-18 13:37:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('741', '2018-05-28', 'K39123', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:09', '2018-07-18 13:37:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('742', '2018-05-28', 'K39124', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:14', '2018-07-18 13:37:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('743', '2018-05-28', 'K39125', 'A1805093XH', '96', 'Q1770', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:19', '2018-07-18 13:37:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('744', '2018-06-01', 'K39634', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:22', '2018-07-18 13:37:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('745', '2018-06-01', 'K39635', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:32', '2018-07-18 13:37:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('746', '2018-06-01', 'K39636', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:36', '2018-07-18 13:37:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('747', '2018-06-01', 'K39637', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:39', '2018-07-18 13:37:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('748', '2018-06-01', 'K39638', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:42', '2018-07-18 13:37:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('749', '2018-06-01', 'K39639', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:46', '2018-07-18 13:37:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('750', '2018-06-01', 'K39640', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:50', '2018-07-18 13:37:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('751', '2018-06-01', 'K39641', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:54', '2018-07-18 13:37:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('752', '2018-06-01', 'K39642', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:37:59', '2018-07-18 13:37:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('753', '2018-06-01', 'K39643', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:38:03', '2018-07-18 13:38:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('754', '2018-06-01', 'K39644', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:38:06', '2018-07-18 13:38:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('755', '2018-06-01', 'K39645', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:38:09', '2018-07-18 13:38:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('756', '2018-06-01', 'K39646', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:38:13', '2018-07-18 13:38:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('757', '2018-06-01', 'K39647', 'A1805152XH', '96', 'Q2205', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:38:16', '2018-07-18 13:38:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('758', '2018-05-28', 'K39126', 'A1805093XH', '114', 'Q1770', 'JS180126', 'K180528XH', null, '96', '18', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:38:41', '2018-07-18 13:38:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('759', '2018-06-01', 'K39648', 'A1805152XH', '127', 'Q2205', 'JS180126', 'K180601XH', null, '96', '31', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:39:52', '2018-07-18 13:39:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('760', '2018-05-28', 'K39219', 'A1805093XH', '96', 'Q1732:82|Q1770:14', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:45:18', '2018-07-18 13:45:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('761', '2018-06-01', 'K39665', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:12', '2018-07-18 13:46:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('762', '2018-06-01', 'K39666', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:17', '2018-07-18 13:46:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('763', '2018-06-01', 'K39667', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:25', '2018-07-18 13:46:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('764', '2018-06-01', 'K39668', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:28', '2018-07-18 13:46:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('765', '2018-06-01', 'K39669', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:33', '2018-07-18 13:46:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('766', '2018-06-01', 'K39670', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:38', '2018-07-18 13:46:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('767', '2018-06-01', 'K39671', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:42', '2018-07-18 13:46:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('768', '2018-05-28', 'K39220', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:44', '2018-07-18 13:46:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('769', '2018-06-01', 'K39672', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:44', '2018-07-18 13:46:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('770', '2018-06-01', 'K39673', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:47', '2018-07-18 13:46:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('771', '2018-05-28', 'K39221', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:48', '2018-07-18 13:46:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('772', '2018-06-01', 'K39674', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:51', '2018-07-18 13:46:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('773', '2018-05-28', 'K39222', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:52', '2018-07-18 13:46:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('774', '2018-06-01', 'K39675', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:55', '2018-07-18 13:46:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('775', '2018-05-28', 'K39223', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:57', '2018-07-18 13:46:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('776', '2018-06-01', 'K39676', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:46:59', '2018-07-18 13:46:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('777', '2018-05-28', 'K39224', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:01', '2018-07-18 13:47:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('778', '2018-06-01', 'K39677', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:03', '2018-07-18 13:47:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('779', '2018-05-28', 'K39225', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:06', '2018-07-18 13:47:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('780', '2018-05-28', 'K39226', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:11', '2018-07-18 13:47:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('781', '2018-06-01', 'K39678', 'A1805152XH', '96', 'Q2216', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:12', '2018-07-18 13:47:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('782', '2018-05-28', 'K39227', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:19', '2018-07-18 13:47:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('783', '2018-05-28', 'K39228', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:26', '2018-07-18 13:47:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('784', '2018-05-28', 'K39229', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:31', '2018-07-18 13:47:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('785', '2018-05-28', 'K39230', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:37', '2018-07-18 13:47:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('786', '2018-05-28', 'K39231', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:41', '2018-07-18 13:47:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('787', '2018-05-28', 'K39232', 'A1805093XH', '96', 'Q1732', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:47:48', '2018-07-18 13:47:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('788', '2018-06-01', 'K39679', 'A1805152XH', '137', 'Q2216', 'JS180126', 'K180601XH', null, '96', '41', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:49:09', '2018-07-18 13:49:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('789', '2018-06-01', 'K39649', 'A1805152XH', '96', 'Q2207:55|Q2205:41', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:52:25', '2018-07-18 13:52:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('790', '2018-06-01', 'K39650', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:52:57', '2018-07-18 13:52:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('791', '2018-06-01', 'K39651', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:01', '2018-07-18 13:53:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('792', '2018-06-01', 'K39653', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:06', '2018-07-18 13:53:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('793', '2018-06-01', 'K39654', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:08', '2018-07-18 13:53:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('794', '2018-05-28', 'K39233', 'A1805093XH', '121', 'Q1732', 'JS180126', 'K180529XH', null, '103', '18', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:11', '2018-07-18 13:53:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('795', '2018-06-01', 'K39656', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:15', '2018-07-18 13:53:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('796', '2018-06-01', 'K39657', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:18', '2018-07-18 13:53:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('797', '2018-06-01', 'K39658', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:22', '2018-07-18 13:53:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('798', '2018-06-01', 'K39659', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:25', '2018-07-18 13:53:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('799', '2018-06-01', 'K39660', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:31', '2018-07-18 13:53:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('800', '2018-06-01', 'K39661', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:39', '2018-07-18 13:53:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('801', '2018-06-01', 'K39662', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:43', '2018-07-18 13:53:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('802', '2018-06-01', 'K39663', 'A1805152XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:53:46', '2018-07-18 13:53:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('803', '2018-05-28', 'K39234', 'A1805093XH', '96', 'Q1732:67|Q2193:29', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:55:32', '2018-07-18 13:55:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('804', '2018-06-01', 'K39664', 'A1805152XH', '119', 'Q2207', 'JS180126', 'K180601XH', null, '96', '23', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:56:38', '2018-07-18 13:56:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('806', '2018-06-01', 'K39726', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:09', '2018-07-18 13:59:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('807', '2018-06-01', 'K39727', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:13', '2018-07-18 13:59:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('808', '2018-06-01', 'K39728', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:16', '2018-07-18 13:59:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('809', '2018-06-01', 'K39729', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:19', '2018-07-18 13:59:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('810', '2018-06-01', 'K39730', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:24', '2018-07-18 13:59:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('811', '2018-06-01', 'K39731', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:27', '2018-07-18 13:59:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('812', '2018-06-01', 'K39732', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:30', '2018-07-18 13:59:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('813', '2018-06-01', 'K39733', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:32', '2018-07-18 13:59:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('814', '2018-06-01', 'K39734', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:35', '2018-07-18 13:59:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('815', '2018-06-01', 'K39735', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:38', '2018-07-18 13:59:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('816', '2018-06-01', 'K39736', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:41', '2018-07-18 13:59:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('817', '2018-05-29', 'K39235', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:41', '2018-07-18 13:59:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('818', '2018-06-01', 'K39737', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:44', '2018-07-18 13:59:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('819', '2018-05-29', 'K39236', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:46', '2018-07-18 13:59:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('820', '2018-06-01', 'K39738', 'A1805152XH', '96', 'Q1417', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:48', '2018-07-18 13:59:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('821', '2018-05-29', 'K39237', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:51', '2018-07-18 13:59:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('822', '2018-05-29', 'K39238', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:55', '2018-07-18 13:59:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('823', '2018-05-29', 'K39239', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 13:59:59', '2018-07-18 13:59:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('824', '2018-05-29', 'K39240', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:05', '2018-07-18 14:00:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('825', '2018-05-29', 'K39241', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:09', '2018-07-18 14:00:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('826', '2018-05-29', 'K39242', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:14', '2018-07-18 14:00:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('827', '2018-05-29', 'K39243', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:18', '2018-07-18 14:00:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('828', '2018-05-29', 'K39244', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:22', '2018-07-18 14:00:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('829', '2018-05-29', 'K39245', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:27', '2018-07-18 14:00:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('830', '2018-05-29', 'K39246', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:31', '2018-07-18 14:00:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('831', '2018-05-29', 'K39247', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:36', '2018-07-18 14:00:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('832', '2018-05-29', 'K39248', 'A1805093XH', '96', 'Q2193', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:00:43', '2018-07-18 14:00:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('833', '2018-05-29', 'K39249', 'A1805093XH', '112', 'Q2193', 'JS180126', 'K180529XH', null, '96', '16', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:01:54', '2018-07-18 14:01:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('834', '2018-06-01', 'K39739', 'A1805152XH', '127', 'Q1417', 'JS180126', 'K180601XH', null, '96', '31', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:02:00', '2018-07-18 14:02:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('835', '2018-06-01', 'K39740', 'A1805152XH', '96', 'Q1417:68|Q2040:28', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:02:53', '2018-07-18 14:02:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('836', '2018-05-29', 'K39250', 'A1805093XH', '96', 'Q2829:63|Q2193:33', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:03:13', '2018-07-18 14:03:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('837', '2018-06-01', 'K39680', 'A1805152XH', '96', 'Q1349:88|Q2216:8', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:04:55', '2018-07-18 14:04:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('838', '2018-06-01', 'K39681', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:18', '2018-07-18 14:05:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('839', '2018-06-01', 'K39682', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:21', '2018-07-18 14:05:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('840', '2018-06-01', 'K39683', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:24', '2018-07-18 14:05:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('841', '2018-06-01', 'K39684', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:26', '2018-07-18 14:05:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('842', '2018-06-01', 'K39685', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:30', '2018-07-18 14:05:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('843', '2018-06-01', 'K39686', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:33', '2018-07-18 14:05:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('844', '2018-06-01', 'K39687', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:35', '2018-07-18 14:05:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('845', '2018-06-01', 'K39688', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:38', '2018-07-18 14:05:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('846', '2018-06-01', 'K39689', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:41', '2018-07-18 14:05:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('847', '2018-06-01', 'K39690', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:49', '2018-07-18 14:05:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('848', '2018-06-01', 'K39691', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:53', '2018-07-18 14:05:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('849', '2018-06-01', 'K39692', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:05:59', '2018-07-18 14:05:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('850', '2018-06-01', 'K39693', 'A1805152XH', '96', 'Q1349', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:06:03', '2018-07-18 14:06:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('851', '2018-06-01', 'K39694', 'A1805152XH', '120', 'Q1349', 'JS180126', 'K180601XH', null, '96', '24', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:07:39', '2018-07-18 14:07:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('852', '2018-06-01', 'K39695', 'A1805152XH', '96', 'Q1349:60|Q2040:36', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:08:20', '2018-07-18 14:08:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('853', '2018-05-28', 'K39080', 'A1805093XH', '96', 'Q1863:56|Q1758:48', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:09:57', '2018-07-18 14:09:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('854', '2018-05-28', 'K39081', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:25', '2018-07-18 14:10:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('855', '2018-05-28', 'K39082', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:29', '2018-07-18 14:10:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('856', '2018-05-28', 'K39083', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:34', '2018-07-18 14:10:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('857', '2018-05-28', 'K39084', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:38', '2018-07-18 14:10:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('858', '2018-05-28', 'K39085', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:42', '2018-07-18 14:10:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('859', '2018-05-28', 'K39086', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:46', '2018-07-18 14:10:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('860', '2018-05-28', 'K39087', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:51', '2018-07-18 14:10:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('861', '2018-05-28', 'K39088', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:55', '2018-07-18 14:10:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('862', '2018-05-28', 'K39089', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:10:59', '2018-07-18 14:10:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('863', '2018-05-28', 'K39090', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:11:05', '2018-07-18 14:11:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('864', '2018-05-28', 'K39091', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:11:09', '2018-07-18 14:11:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('865', '2018-05-28', 'K39092', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:11:13', '2018-07-18 14:11:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('866', '2018-05-28', 'K39093', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:11:17', '2018-07-18 14:11:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('867', '2018-05-28', 'K39094', 'A1805093XH', '96', 'Q1863', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:11:27', '2018-07-18 14:11:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('868', '2018-06-01', 'K39710', 'A1805152XH', '96', 'Q267:53|Q2071:43', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:11:53', '2018-07-18 14:11:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('869', '2018-06-01', 'K39711', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:08', '2018-07-18 14:12:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('870', '2018-06-01', 'K39712', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:14', '2018-07-18 14:12:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('872', '2018-05-28', 'K39095', 'A1805093XH', '107', 'Q1863', 'JS180126', 'K180528XH', null, '96', '11', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:29', '2018-07-18 14:12:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('873', '2018-06-01', 'K39713', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:29', '2018-07-18 14:12:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('874', '2018-06-01', 'K39714', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:32', '2018-07-18 14:12:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('875', '2018-06-01', 'K39715', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:35', '2018-07-18 14:12:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('876', '2018-06-01', 'K39716', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:37', '2018-07-18 14:12:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('877', '2018-06-01', 'K39717', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:40', '2018-07-18 14:12:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('878', '2018-06-01', 'K39718', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:44', '2018-07-18 14:12:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('879', '2018-06-01', 'K39719', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:47', '2018-07-18 14:12:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('880', '2018-06-01', 'K39720', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:53', '2018-07-18 14:12:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('881', '2018-06-01', 'K39721', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:56', '2018-07-18 14:12:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('882', '2018-06-01', 'K39722', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:12:58', '2018-07-18 14:12:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('883', '2018-06-01', 'K39723', 'A1805152XH', '96', 'Q267', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:13:01', '2018-07-18 14:13:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('885', '2018-05-28', 'K39096', 'A1805093XH', '96', 'Q645:85|Q1863:11', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:13:06', '2018-07-18 14:13:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('886', '2018-05-28', 'K39097', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:13:52', '2018-07-18 14:13:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('887', '2018-05-28', 'K39098', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:13:56', '2018-07-18 14:13:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('888', '2018-05-28', 'K39099', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:01', '2018-07-18 14:14:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('889', '2018-05-28', 'K39100', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:07', '2018-07-18 14:14:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('890', '2018-05-28', 'K39101', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:12', '2018-07-18 14:14:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('891', '2018-05-28', 'K39102', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:16', '2018-07-18 14:14:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('892', '2018-05-28', 'K39103', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:21', '2018-07-18 14:14:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('893', '2018-05-28', 'K39104', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:25', '2018-07-18 14:14:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('894', '2018-05-28', 'K39105', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:29', '2018-07-18 14:14:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('895', '2018-05-28', 'K39106', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:34', '2018-07-18 14:14:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('896', '2018-05-28', 'K39107', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:38', '2018-07-18 14:14:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('897', '2018-05-28', 'K39108', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:43', '2018-07-18 14:14:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('898', '2018-06-01', 'K39724', 'A1805152XH', '188', 'Q267', 'JS180126', 'K180601XH', null, '94', '94', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:44', '2018-07-18 14:14:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('899', '2018-05-28', 'K39109', 'A1805093XH', '96', 'Q645', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:14:48', '2018-07-18 14:14:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('900', '2018-06-01', 'K39725', 'A1805152XH', '96', 'Q1417:73|Q267:23', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:15:17', '2018-07-18 14:15:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('901', '2018-05-28', 'K39110', 'A1805093XH', '134', 'Q645', 'JS180126', 'K180528XH', null, '96', '38', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:16:01', '2018-07-18 14:16:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('902', '2018-05-28', 'K39111', 'A1805093XH', '96', 'Q645:51|Q1770:45', 'JS180126', 'K180528XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:16:39', '2018-07-18 14:16:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('903', '2018-05-29', 'K39251', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:15', '2018-07-18 14:22:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('904', '2018-05-29', 'K39252', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:20', '2018-07-18 14:22:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('905', '2018-05-29', 'K39253', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:24', '2018-07-18 14:22:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('906', '2018-05-29', 'K39254', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:28', '2018-07-18 14:22:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('907', '2018-05-29', 'K39255', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:33', '2018-07-18 14:22:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('908', '2018-05-29', 'K39256', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:37', '2018-07-18 14:22:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('909', '2018-05-29', 'K39257', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:41', '2018-07-18 14:22:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('910', '2018-05-29', 'K39258', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:48', '2018-07-18 14:22:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('911', '2018-05-29', 'K39259', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:52', '2018-07-18 14:22:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('912', '2018-05-29', 'K39260', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:22:59', '2018-07-18 14:22:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('913', '2018-05-29', 'K39261', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:23:02', '2018-07-18 14:23:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('914', '2018-05-29', 'K39262', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:23:07', '2018-07-18 14:23:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('915', '2018-05-29', 'K39263', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:23:11', '2018-07-18 14:23:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('916', '2018-05-29', 'K39264', 'A1805093XH', '96', 'Q2829', 'JS180126', 'K180529XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:23:18', '2018-07-18 14:23:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('917', '2018-05-29', 'K39265', 'A1805093XH', '111', 'Q2829', 'JS180126', 'K180529XH', null, '96', '15', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:25:24', '2018-07-18 14:25:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('918', '2018-06-01', 'K39696', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:15', '2018-07-18 14:27:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('919', '2018-06-01', 'K39697', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:22', '2018-07-18 14:27:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('920', '2018-06-01', 'K39698', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:26', '2018-07-18 14:27:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('921', '2018-06-01', 'K39699', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:30', '2018-07-18 14:27:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('922', '2018-06-01', 'K39700', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:35', '2018-07-18 14:27:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('923', '2018-06-01', 'K39701', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:39', '2018-07-18 14:27:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('924', '2018-06-01', 'K39702', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:42', '2018-07-18 14:27:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('925', '2018-06-01', 'K39703', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:46', '2018-07-18 14:27:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('926', '2018-06-01', 'K39704', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:49', '2018-07-18 14:27:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('927', '2018-06-01', 'K39705', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:52', '2018-07-18 14:27:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('928', '2018-06-01', 'K39706', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:27:56', '2018-07-18 14:27:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('929', '2018-06-01', 'K39707', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:28:00', '2018-07-18 14:28:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('930', '2018-06-01', 'K39708', 'A1805152XH', '96', 'Q2040', '', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:28:09', '2018-07-18 14:28:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('931', '2018-05-31', 'K39605', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:18', '2018-07-18 14:30:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('932', '2018-05-31', 'K39606', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:23', '2018-07-18 14:30:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('933', '2018-05-31', 'K39607', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:28', '2018-07-18 14:30:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('934', '2018-05-31', 'K39608', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:32', '2018-07-18 14:30:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('935', '2018-05-31', 'K39609', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:36', '2018-07-18 14:30:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('936', '2018-05-31', 'K39610', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:42', '2018-07-18 14:30:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('937', '2018-05-31', 'K39611', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:47', '2018-07-18 14:30:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('938', '2018-05-31', 'K39612', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:51', '2018-07-18 14:30:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('939', '2018-05-31', 'K39613', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:55', '2018-07-18 14:30:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('940', '2018-05-31', 'K39614', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:30:59', '2018-07-18 14:30:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('941', '2018-06-01', 'K39709', 'A1805152XH', '128', 'Q2040', '', 'K180601XH', null, '96', '32', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:31:20', '2018-07-18 14:31:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('942', '2018-06-01', 'K40003', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:27', '2018-07-18 14:36:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('943', '2018-06-01', 'K40004', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:31', '2018-07-18 14:36:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('944', '2018-06-01', 'K40005', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:35', '2018-07-18 14:36:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('945', '2018-06-01', 'K40006', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:39', '2018-07-18 14:36:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('946', '2018-06-01', 'K40007', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:42', '2018-07-18 14:36:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('947', '2018-06-01', 'K40008', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:46', '2018-07-18 14:36:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('948', '2018-06-01', 'K40009', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:50', '2018-07-18 14:36:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('949', '2018-06-01', 'K40010', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:55', '2018-07-18 14:36:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('950', '2018-06-01', 'K40011', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:36:59', '2018-07-18 14:36:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('951', '2018-06-01', 'K40012', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:37:02', '2018-07-18 14:37:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('952', '2018-06-01', 'K40013', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:37:04', '2018-07-18 14:37:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('953', '2018-06-01', 'K40014', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:37:08', '2018-07-18 14:37:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('954', '2018-06-01', 'K40015', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:37:11', '2018-07-18 14:37:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('955', '2018-06-01', 'K40016', 'A1805152XH', '96', 'Q1775', '', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:37:18', '2018-07-18 14:37:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('956', '2018-05-31', 'K39615', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:39:02', '2018-07-18 14:39:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('957', '2018-05-31', 'K39616', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:39:05', '2018-07-18 14:39:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('958', '2018-05-31', 'K39617', 'A1805151XH', '96', 'Q2071', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:39:11', '2018-07-18 14:39:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('959', '2018-06-01', 'K40017', 'A1805152XH', '125', 'Q1775', '', 'K180604XH', null, '96', '29', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:39:16', '2018-07-18 14:39:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('960', '2018-05-31', 'K39618', 'A1805151XH', '157', 'Q2071', 'JS180126', 'K180531XH', null, '96', '61', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:40:56', '2018-07-18 14:40:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('961', '2018-05-31', 'K39604', 'A1805151XH', '96', 'Q2071:69|Q2850:27', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:43:06', '2018-07-18 14:43:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('962', '2018-06-04', 'K40034', 'A1805152XH', '96', 'Q1315:81|Q2040:15', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:45:54', '2018-07-18 14:45:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('963', '2018-06-04', 'K40035', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:46:08', '2018-07-18 14:46:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('964', '2018-05-31', 'K39558', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:46:34', '2018-07-18 14:46:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('965', '2018-05-31', 'K39559', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:46:38', '2018-07-18 14:46:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('966', '2018-05-31', 'K39560', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:46:43', '2018-07-18 14:46:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('967', '2018-05-31', 'K39561', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:46:48', '2018-07-18 14:46:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('968', '2018-05-31', 'K39562', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:46:52', '2018-07-18 14:46:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('969', '2018-05-31', 'K39563', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:46:56', '2018-07-18 14:46:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('970', '2018-05-31', 'K39564', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:00', '2018-07-18 14:47:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('971', '2018-06-04', 'K40036', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:03', '2018-07-18 14:47:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('972', '2018-05-31', 'K39565', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:05', '2018-07-18 14:47:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('973', '2018-06-04', 'K40037', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:06', '2018-07-18 14:47:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('974', '2018-05-31', 'K39566', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:09', '2018-07-18 14:47:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('975', '2018-06-04', 'K40038', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:09', '2018-07-18 14:47:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('976', '2018-06-04', 'K40039', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:12', '2018-07-18 14:47:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('977', '2018-05-31', 'K39567', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:15', '2018-07-18 14:47:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('978', '2018-05-31', 'K39568', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:19', '2018-07-18 14:47:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('979', '2018-05-31', 'K39569', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:24', '2018-07-18 14:47:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('980', '2018-06-04', 'K40040', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:25', '2018-07-18 14:47:25');
INSERT INTO `t_ums_workflow_assembly` VALUES ('981', '2018-06-04', 'K40041', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:29', '2018-07-18 14:47:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('982', '2018-05-31', 'K39570', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:29', '2018-07-18 14:47:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('983', '2018-06-04', 'K40042', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:32', '2018-07-18 14:47:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('984', '2018-05-31', 'K39571', 'A1805151XH', '96', 'Q2059', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:33', '2018-07-18 14:47:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('985', '2018-06-04', 'K40043', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:37', '2018-07-18 14:47:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('986', '2018-06-04', 'K40044', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:39', '2018-07-18 14:47:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('987', '2018-06-04', 'K40045', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:43', '2018-07-18 14:47:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('988', '2018-06-04', 'K40046', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:47', '2018-07-18 14:47:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('989', '2018-06-04', 'K40047', 'A1805152XH', '96', 'Q1315', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:47:50', '2018-07-18 14:47:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('990', '2018-05-31', 'K39572', 'A1805151XH', '127', 'Q2059', 'JS180126', 'K180531XH', null, '96', '31', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:49:01', '2018-07-18 14:49:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('991', '2018-06-04', 'K40048', 'A1805152XH', '130', 'Q1315', 'JS180126', 'K180604XH', null, '96', '34', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:50:03', '2018-07-18 14:50:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('992', '2018-06-04', 'K39972', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:53:49', '2018-07-18 14:53:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('993', '2018-06-04', 'K39973', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:11', '2018-07-18 14:54:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('994', '2018-06-04', 'K39974', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:13', '2018-07-18 14:54:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('995', '2018-06-04', 'K39975', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:16', '2018-07-18 14:54:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('996', '2018-06-04', 'K39976', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:20', '2018-07-18 14:54:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('997', '2018-06-04', 'K39977', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:24', '2018-07-18 14:54:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('998', '2018-06-04', 'K39978', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:27', '2018-07-18 14:54:27');
INSERT INTO `t_ums_workflow_assembly` VALUES ('999', '2018-06-04', 'K39979', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:31', '2018-07-18 14:54:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1000', '2018-06-04', 'K39980', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:38', '2018-07-18 14:54:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1001', '2018-06-03', 'Q39926', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:54', '2018-07-18 14:54:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1002', '2018-06-04', 'K39981', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:55', '2018-07-18 14:54:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1003', '2018-06-03', 'Q39927', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:58', '2018-07-18 14:54:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1004', '2018-06-04', 'K39982', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:54:59', '2018-07-18 14:54:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1005', '2018-06-04', 'K39983', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:02', '2018-07-18 14:55:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1006', '2018-06-03', 'Q39928', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:03', '2018-07-18 14:55:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1007', '2018-06-04', 'K39984', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:06', '2018-07-18 14:55:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1008', '2018-06-03', 'Q39929', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:07', '2018-07-18 14:55:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1009', '2018-06-04', 'K39985', 'A1805152XH', '96', 'Q1415', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:10', '2018-07-18 14:55:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1010', '2018-06-03', 'Q39930', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:14', '2018-07-18 14:55:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1011', '2018-06-03', 'Q39931', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:18', '2018-07-18 14:55:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1012', '2018-06-03', 'Q39932', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:23', '2018-07-18 14:55:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1013', '2018-06-03', 'Q39933', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:29', '2018-07-18 14:55:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1014', '2018-06-03', 'Q39934', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:34', '2018-07-18 14:55:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1015', '2018-06-03', 'Q39935', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:39', '2018-07-18 14:55:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1016', '2018-06-03', 'Q39936', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:45', '2018-07-18 14:55:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1017', '2018-06-03', 'Q39937', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:55:52', '2018-07-18 14:55:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1018', '2018-06-03', 'Q39938', 'A1805151XH', '96', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:56:05', '2018-07-18 14:56:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1019', '2018-06-04', 'K39986', 'A1805152XH', '111', 'Q1415', 'JS180126', 'K180604XH', null, '96', '15', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:56:57', '2018-07-18 14:56:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1020', '2018-06-03', 'Q39939', 'A1805151XH', '138', 'Q2501', 'JS180126', 'Q180603XH', null, '96', '42', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:57:30', '2018-07-18 14:57:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1021', '2018-06-04', 'K39987', 'A1805152XH', '96', 'Q1415:63|Q1450:33', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:57:35', '2018-07-18 14:57:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1022', '2018-06-03', 'Q39940', 'A1805151XH', '96', 'Q2501:88|Q2048:8', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 14:58:13', '2018-07-18 14:58:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1023', '2018-06-03', 'Q39894', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:01:48', '2018-07-18 15:01:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1024', '2018-06-03', 'Q39895', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:01:54', '2018-07-18 15:01:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1025', '2018-06-03', 'Q39896', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:01:58', '2018-07-18 15:01:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1026', '2018-06-03', 'Q39897', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:04', '2018-07-18 15:02:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1027', '2018-06-03', 'Q39898', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:07', '2018-07-18 15:02:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1028', '2018-06-03', 'Q39899', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:12', '2018-07-18 15:02:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1029', '2018-06-03', 'Q39900', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:18', '2018-07-18 15:02:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1030', '2018-06-04', 'K39988', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:20', '2018-07-18 15:02:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1031', '2018-06-03', 'Q39901', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:22', '2018-07-18 15:02:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1032', '2018-06-03', 'Q39902', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:26', '2018-07-18 15:02:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1033', '2018-06-04', 'K39989', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:28', '2018-07-18 15:02:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1034', '2018-06-03', 'Q39903', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:31', '2018-07-18 15:02:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1035', '2018-06-04', 'K39990', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:33', '2018-07-18 15:02:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1036', '2018-06-03', 'Q39904', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:35', '2018-07-18 15:02:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1037', '2018-06-04', 'K39991', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:38', '2018-07-18 15:02:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1038', '2018-06-03', 'Q39905', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:40', '2018-07-18 15:02:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1039', '2018-06-04', 'K39992', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:43', '2018-07-18 15:02:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1040', '2018-06-03', 'Q39906', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:45', '2018-07-18 15:02:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1041', '2018-06-04', 'K39993', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:47', '2018-07-18 15:02:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1042', '2018-06-03', 'Q39907', 'A1805151XH', '96', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:49', '2018-07-18 15:02:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1043', '2018-06-04', 'K39994', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:50', '2018-07-18 15:02:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1044', '2018-06-04', 'K39995', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:53', '2018-07-18 15:02:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1045', '2018-06-04', 'K39996', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:02:56', '2018-07-18 15:02:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1046', '2018-06-04', 'K39997', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:03:00', '2018-07-18 15:03:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1047', '2018-06-04', 'K39998', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:03:03', '2018-07-18 15:03:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1048', '2018-06-04', 'K39999', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:03:15', '2018-07-18 15:03:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1049', '2018-06-04', 'K40000', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:03:28', '2018-07-18 15:03:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1050', '2018-06-04', 'K40001', 'A1805152XH', '96', 'Q1450', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:03:33', '2018-07-18 15:03:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1051', '2018-06-03', 'Q39908', 'A1805151XH', '119', 'Q1874', 'JS180126', 'Q180603XH', null, '96', '23', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:04:19', '2018-07-18 15:04:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1052', '2018-06-03', 'Q39909', 'A1805151XH', '96', 'Q1874:66|Q2007:30', 'JS180126', 'Q180603XH', null, '96', '0', '14-0013', '102987389', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:05:11', '2018-07-18 15:05:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1053', '2018-06-04', 'K40002', 'A1805152XH', '113', 'Q1450', 'JS180126', 'K180604XH', null, '96', '17', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-18 15:05:37', '2018-07-18 15:05:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1054', '2018-06-04', 'K40018', 'A1805152XH', '96', 'Q2826:53|Q1775:43', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:01:26', '2018-07-19 09:01:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1055', '2018-06-04', 'K40019', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:01:45', '2018-07-19 09:01:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1056', '2018-06-04', 'K40020', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:01:53', '2018-07-19 09:01:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1057', '2018-06-04', 'K40021', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:01:57', '2018-07-19 09:01:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1058', '2018-06-04', 'K40022', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:01', '2018-07-19 09:02:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1059', '2018-06-04', 'K40023', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:05', '2018-07-19 09:02:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1060', '2018-06-04', 'K40024', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:10', '2018-07-19 09:02:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1061', '2018-06-04', 'K40025', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:14', '2018-07-19 09:02:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1062', '2018-06-04', 'K40026', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:18', '2018-07-19 09:02:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1063', '2018-06-04', 'K40027', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:22', '2018-07-19 09:02:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1064', '2018-06-04', 'K40028', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:29', '2018-07-19 09:02:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1065', '2018-06-04', 'K40029', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:34', '2018-07-19 09:02:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1066', '2018-06-04', 'K40030', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:40', '2018-07-19 09:02:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1067', '2018-06-04', 'K40031', 'A1805152XH', '96', 'Q2826', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:02:46', '2018-07-19 09:02:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1068', '2018-05-31', 'K39527', 'A1805151XH', '96', 'Q2321:52|Q786:44', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:03:30', '2018-07-19 09:03:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1069', '2018-05-31', 'K39528', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:03:58', '2018-07-19 09:03:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1070', '2018-05-31', 'K39529', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:02', '2018-07-19 09:04:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1071', '2018-05-31', 'K39530', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:07', '2018-07-19 09:04:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1072', '2018-05-31', 'K39531', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:13', '2018-07-19 09:04:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1073', '2018-05-31', 'K39532', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:17', '2018-07-19 09:04:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1074', '2018-05-31', 'K39533', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:22', '2018-07-19 09:04:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1075', '2018-05-31', 'K39534', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:26', '2018-07-19 09:04:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1076', '2018-05-31', 'K39535', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:31', '2018-07-19 09:04:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1077', '2018-05-31', 'K39536', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:35', '2018-07-19 09:04:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1078', '2018-05-31', 'K39537', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:42', '2018-07-19 09:04:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1079', '2018-06-04', 'K40032', 'A1805152XH', '130', 'Q2826', 'JS180126', 'K180604XH', null, '96', '34', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:45', '2018-07-19 09:04:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1080', '2018-05-31', 'K39538', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:46', '2018-07-19 09:04:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1081', '2018-05-31', 'K39539', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:52', '2018-07-19 09:04:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1082', '2018-05-31', 'K39540', 'A1805151XH', '96', 'Q2321', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:04:59', '2018-07-19 09:04:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1084', '2018-05-31', 'K39541', 'A1805151XH', '134', 'Q2321', 'JS180126', 'K180531XH', null, '96', '38', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:06:53', '2018-07-19 09:06:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1085', '2018-05-31', 'K39542', 'A1805151XH', '96', 'Q2321:82|Q2379:14', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:07:54', '2018-07-19 09:07:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1086', '2018-06-04', 'K40049', 'A1805152XH', '96', 'Q1485:75|Q1315:21', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:08:14', '2018-07-19 09:08:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1087', '2018-06-04', 'K40050', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:08:34', '2018-07-19 09:08:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1088', '2018-06-04', 'K40051', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:08:39', '2018-07-19 09:08:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1089', '2018-06-04', 'K40052', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:08:44', '2018-07-19 09:08:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1090', '2018-06-04', 'K40053', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:08:49', '2018-07-19 09:08:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1091', '2018-06-04', 'K40054', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:08:55', '2018-07-19 09:08:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1092', '2018-06-04', 'K40055', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:09:02', '2018-07-19 09:09:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1093', '2018-06-04', 'K40055', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:09:42', '2018-07-19 09:09:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1094', '2018-06-04', 'K40056', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:09:46', '2018-07-19 09:09:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1095', '2018-06-04', 'K40057', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:09:51', '2018-07-19 09:09:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1096', '2018-06-04', 'K40058', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:09:55', '2018-07-19 09:09:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1097', '2018-06-04', 'K40059', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:10:01', '2018-07-19 09:10:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1098', '2018-05-30', 'K39435', 'A1805151XH', '96', 'Q1774:81|Q677:15', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:13:10', '2018-07-19 09:13:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1099', '2018-05-30', 'K39436', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:13:40', '2018-07-19 09:13:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1100', '2018-05-30', 'K39437', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:13:43', '2018-07-19 09:13:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1101', '2018-05-30', 'K39438', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:13:48', '2018-07-19 09:13:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1102', '2018-05-30', 'K39439', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:13:52', '2018-07-19 09:13:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1103', '2018-05-30', 'K39440', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:13:57', '2018-07-19 09:13:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1104', '2018-05-30', 'K39441', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:01', '2018-07-19 09:14:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1105', '2018-05-30', 'K39442', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:06', '2018-07-19 09:14:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1106', '2018-05-30', 'K39443', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:11', '2018-07-19 09:14:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1107', '2018-05-30', 'K39444', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:18', '2018-07-19 09:14:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1108', '2018-05-30', 'K39445', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:40', '2018-07-19 09:14:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1109', '2018-05-30', 'K39446', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:44', '2018-07-19 09:14:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1110', '2018-05-30', 'K39447', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:49', '2018-07-19 09:14:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1111', '2018-05-30', 'K39448', 'A1805151XH', '96', 'Q1774', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:14:54', '2018-07-19 09:14:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1112', '2018-05-30', 'K39449', 'A1805151XH', '115', 'Q1774', 'JS180126', 'K180530XH', null, '96', '19', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:16:03', '2018-07-19 09:16:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1113', '2018-05-30', 'K39450', 'A1805151XH', '96', 'Q1774:70|Q300:26', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:17:19', '2018-07-19 09:17:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1114', '2018-05-31', 'K39543', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:04', '2018-07-19 09:20:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1115', '2018-05-31', 'K39544', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:08', '2018-07-19 09:20:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1116', '2018-05-31', 'K39545', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:14', '2018-07-19 09:20:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1117', '2018-05-31', 'K39546', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:18', '2018-07-19 09:20:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1118', '2018-05-31', 'K39547', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:23', '2018-07-19 09:20:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1119', '2018-05-31', 'K39548', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:26', '2018-07-19 09:20:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1120', '2018-05-31', 'K39549', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:30', '2018-07-19 09:20:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1121', '2018-05-31', 'K39550', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:35', '2018-07-19 09:20:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1122', '2018-05-31', 'K39551', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:40', '2018-07-19 09:20:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1123', '2018-05-31', 'K39552', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:45', '2018-07-19 09:20:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1124', '2018-05-31', 'K39553', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:49', '2018-07-19 09:20:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1125', '2018-05-31', 'K39554', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:53', '2018-07-19 09:20:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1126', '2018-05-31', 'K39555', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:20:58', '2018-07-19 09:20:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1127', '2018-05-31', 'K39556', 'A1805151XH', '96', 'Q300', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:21:02', '2018-07-19 09:21:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1128', '2018-05-31', 'K39557', 'A1805151XH', '143', 'Q300', 'JS180126', 'K180531XH', null, '96', '47', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:22:36', '2018-07-19 09:22:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1130', '2018-05-31', 'K39512', 'A1805151XH', '96', 'Q673:49|Q786:29|Q2828:18', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:27:29', '2018-07-19 09:27:29');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1131', '2018-05-31', 'K39513', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:27:52', '2018-07-19 09:27:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1132', '2018-05-31', 'K39514', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:27:57', '2018-07-19 09:27:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1133', '2018-05-31', 'K39515', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:01', '2018-07-19 09:28:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1134', '2018-05-31', 'K39516', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:05', '2018-07-19 09:28:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1135', '2018-05-31', 'K39517', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:09', '2018-07-19 09:28:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1136', '2018-05-31', 'K39518', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:16', '2018-07-19 09:28:16');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1137', '2018-05-31', 'K39519', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:20', '2018-07-19 09:28:20');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1138', '2018-05-31', 'K39520', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:26', '2018-07-19 09:28:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1139', '2018-05-31', 'K39521', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:30', '2018-07-19 09:28:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1140', '2018-05-31', 'K39522', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:34', '2018-07-19 09:28:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1141', '2018-05-31', 'K39523', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:39', '2018-07-19 09:28:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1142', '2018-05-31', 'K39524', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:43', '2018-07-19 09:28:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1143', '2018-05-31', 'K39525', 'A1805151XH', '96', 'Q786', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:28:48', '2018-07-19 09:28:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1144', '2018-06-04', 'K40060', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:29:00', '2018-07-19 09:29:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1146', '2018-06-04', 'K40061', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:29:12', '2018-07-19 09:29:12');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1147', '2018-06-04', 'K40062', 'A1805152XH', '96', 'Q1485', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:29:17', '2018-07-19 09:29:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1148', '2018-05-31', 'K39526', 'A1805151XH', '135', 'Q786', 'JS180126', 'K180531XH', null, '96', '39', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:30:47', '2018-07-19 09:30:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1149', '2018-06-04', 'K40063', 'A1805152XH', '131', 'Q1485', 'JS180126', 'K180604XH', null, '96', '35', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:31:10', '2018-07-19 09:31:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1150', '2018-06-04', 'K40064', 'A1805152XH', '96', 'Q1485:63|Q290:33', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:32:00', '2018-07-19 09:32:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1151', '2018-06-05', 'K40080', 'A1805152XH', '96', 'Q359:41|Q1849:28|Q1450:27', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:34:55', '2018-07-19 09:34:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1152', '2018-05-30', 'K39481', 'A1805151XH', '96', 'Q2380:71|Q2850:25', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:34:57', '2018-07-19 09:37:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1153', '2018-06-05', 'K40081', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:31', '2018-07-19 09:35:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1154', '2018-06-05', 'K40082', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:35', '2018-07-19 09:35:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1155', '2018-06-05', 'K40083', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:38', '2018-07-19 09:35:38');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1156', '2018-06-05', 'K40084', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:41', '2018-07-19 09:35:41');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1157', '2018-06-05', 'K40085', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:45', '2018-07-19 09:35:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1158', '2018-06-05', 'K40086', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:48', '2018-07-19 09:35:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1159', '2018-06-05', 'K40087', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:52', '2018-07-19 09:35:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1160', '2018-06-05', 'K40088', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:55', '2018-07-19 09:35:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1161', '2018-06-05', 'K40089', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:35:59', '2018-07-19 09:35:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1163', '2018-06-05', 'K40090', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:14', '2018-07-19 09:36:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1164', '2018-05-31', 'K39589', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:18', '2018-07-19 09:36:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1165', '2018-06-05', 'K40091', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:18', '2018-07-19 09:36:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1166', '2018-05-31', 'K39590', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:22', '2018-07-19 09:36:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1167', '2018-05-31', 'K39591', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:26', '2018-07-19 09:36:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1168', '2018-06-05', 'K40092', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:28', '2018-07-19 09:36:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1169', '2018-05-31', 'K39592', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:31', '2018-07-19 09:36:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1170', '2018-06-05', 'K40093', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:32', '2018-07-19 09:36:32');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1171', '2018-05-31', 'K39593', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:34', '2018-07-19 09:36:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1172', '2018-06-05', 'K40094', 'A1805152XH', '96', 'Q359', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:36', '2018-07-19 09:36:36');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1173', '2018-05-31', 'K39594', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:39', '2018-07-19 09:36:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1174', '2018-06-05', 'K40095', 'A1805152XH', '115', 'Q359', 'JS180126', 'K180605XH', null, '96', '19', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:39', '2018-07-19 09:41:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1176', '2018-05-31', 'K39595', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:45', '2018-07-19 09:36:45');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1177', '2018-05-31', 'K39596', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:49', '2018-07-19 09:36:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1178', '2018-05-31', 'K39597', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:36:53', '2018-07-19 09:36:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1179', '2018-06-05', 'K40096', 'A1805152XH', '96', 'Q1382:78|Q359:18', 'JS180126', 'K180605XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:37:19', '2018-07-19 09:37:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1180', '2018-05-31', 'K39598', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:40:04', '2018-07-19 09:40:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1181', '2018-05-31', 'K39599', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:40:08', '2018-07-19 09:40:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1182', '2018-05-31', 'K39600', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:40:13', '2018-07-19 09:40:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1183', '2018-05-31', 'K39601', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:40:17', '2018-07-19 09:40:17');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1184', '2018-05-31', 'K39602', 'A1805151XH', '96', 'Q2850', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:40:23', '2018-07-19 09:40:23');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1185', '2018-05-31', 'K39603', 'A1805151XH', '121', 'Q2850', 'JS180126', 'K180531XH', null, '96', '25', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:42:10', '2018-07-19 09:42:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1186', '2018-05-31', 'K39497', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:26', '2018-07-19 09:46:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1187', '2018-05-31', 'K39498', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:30', '2018-07-19 09:46:30');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1188', '2018-05-31', 'K39499', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:35', '2018-07-19 09:46:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1189', '2018-05-31', 'K39500', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:40', '2018-07-19 09:46:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1190', '2018-05-31', 'K39501', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:44', '2018-07-19 09:46:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1191', '2018-05-31', 'K39502', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:49', '2018-07-19 09:46:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1192', '2018-05-31', 'K39503', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:53', '2018-07-19 09:46:53');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1193', '2018-05-31', 'K39504', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:46:58', '2018-07-19 09:46:58');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1194', '2018-05-31', 'K39505', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:47:02', '2018-07-19 09:47:02');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1195', '2018-05-31', 'K39506', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:47:07', '2018-07-19 09:47:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1196', '2018-05-31', 'K39507', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:47:11', '2018-07-19 09:47:11');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1197', '2018-05-31', 'K39508', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:47:15', '2018-07-19 09:47:15');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1198', '2018-05-31', 'K39509', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:47:21', '2018-07-19 09:47:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1199', '2018-05-31', 'K39510', 'A1805151XH', '96', 'Q2828', 'JS180126', 'K180531XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:47:26', '2018-07-19 09:47:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1200', '2018-05-31', 'K39511', 'A1805151XH', '124', 'Q2828', 'JS180126', 'K180531XH', null, '96', '28', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:49:21', '2018-07-19 09:49:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1201', '2018-06-04', 'K40065', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:50:33', '2018-07-19 09:50:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1202', '2018-06-04', 'K40066', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:50:44', '2018-07-19 09:50:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1203', '2018-06-04', 'K40068', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:50:54', '2018-07-19 09:50:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1204', '2018-06-04', 'K40069', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:50:57', '2018-07-19 09:50:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1205', '2018-06-04', 'K40070', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:03', '2018-07-19 09:51:03');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1206', '2018-06-04', 'K40071', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:07', '2018-07-19 09:51:07');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1207', '2018-06-04', 'K40072', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:10', '2018-07-19 09:51:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1208', '2018-06-04', 'K40073', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:13', '2018-07-19 09:51:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1209', '2018-06-04', 'K40074', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:21', '2018-07-19 09:51:21');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1210', '2018-06-04', 'K40075', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:26', '2018-07-19 09:51:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1211', '2018-06-04', 'K40076', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:35', '2018-07-19 09:51:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1212', '2018-06-04', 'K40077', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:42', '2018-07-19 09:51:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1213', '2018-06-04', 'K40078', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:51:46', '2018-07-19 09:51:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1214', '2018-05-30', 'K39466', 'A1805151XH', '96', 'Q2004:48|Q2380:48', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:53:04', '2018-07-19 09:53:04');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1215', '2018-05-30', 'K39467', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:53:37', '2018-07-19 09:53:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1216', '2018-05-30', 'K39468', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:53:42', '2018-07-19 09:53:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1217', '2018-05-30', 'K39469', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:53:46', '2018-07-19 09:53:46');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1218', '2018-05-30', 'K39470', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:53:50', '2018-07-19 09:53:50');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1219', '2018-05-30', 'K39471', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:53:55', '2018-07-19 09:53:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1220', '2018-05-30', 'K39472', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:53:59', '2018-07-19 09:53:59');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1221', '2018-05-30', 'K39473', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:06', '2018-07-19 09:54:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1222', '2018-05-30', 'K39474', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:10', '2018-07-19 09:54:10');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1223', '2018-05-30', 'K39475', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:14', '2018-07-19 09:54:14');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1224', '2018-05-30', 'K39476', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:18', '2018-07-19 09:54:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1225', '2018-05-30', 'K39477', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:22', '2018-07-19 09:54:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1226', '2018-05-30', 'K39478', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:28', '2018-07-19 09:54:28');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1227', '2018-05-30', 'K39479', 'A1805151XH', '96', 'Q2380', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:33', '2018-07-19 09:54:33');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1228', '2018-06-04', 'K40079', 'A1805152XH', '145', 'Q1849', 'JS180126', 'K180604XH', null, '96', '49', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:54:34', '2018-07-19 09:54:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1229', '2018-05-30', 'K39480', 'A1805151XH', '148', 'Q2380', 'JS180126', 'K180530XH', null, '96', '52', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:56:01', '2018-07-19 09:56:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1230', '2018-05-30', 'K39451', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 09:59:55', '2018-07-19 09:59:55');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1231', '2018-05-30', 'K39452', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:37', '2018-07-19 10:00:37');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1232', '2018-05-30', 'K39453', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:40', '2018-07-19 10:00:40');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1233', '2018-05-30', 'K39454', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:44', '2018-07-19 10:00:44');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1234', '2018-05-30', 'K39420', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:47', '2018-07-19 10:00:47');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1235', '2018-05-30', 'K39455', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:48', '2018-07-19 10:00:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1236', '2018-05-30', 'K39456', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:51', '2018-07-19 10:00:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1237', '2018-05-30', 'K39421', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:51', '2018-07-19 10:00:51');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1238', '2018-05-30', 'K39457', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:54', '2018-07-19 10:00:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1239', '2018-05-30', 'K39422', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:00:56', '2018-07-19 10:00:56');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1240', '2018-05-30', 'K39423', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:00', '2018-07-19 10:01:00');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1241', '2018-05-30', 'K39424', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:05', '2018-07-19 10:01:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1242', '2018-05-30', 'K39425', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:09', '2018-07-19 10:01:09');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1243', '2018-05-30', 'K39426', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:13', '2018-07-19 10:01:13');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1244', '2018-05-30', 'K39427', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:18', '2018-07-19 10:01:18');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1245', '2018-05-30', 'K39428', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:22', '2018-07-19 10:01:22');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1246', '2018-05-30', 'K39429', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:26', '2018-07-19 10:01:26');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1247', '2018-05-30', 'K39430', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:31', '2018-07-19 10:01:31');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1248', '2018-05-30', 'K39431', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:35', '2018-07-19 10:01:35');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1249', '2018-05-30', 'K39432', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:39', '2018-07-19 10:01:39');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1250', '2018-05-30', 'K39433', 'A1805151XH', '96', 'Q677', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:43', '2018-07-19 10:01:43');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1251', '2018-05-30', 'K39459', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:48', '2018-07-19 10:01:48');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1252', '2018-05-30', 'K39460', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:52', '2018-07-19 10:01:52');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1253', '2018-05-30', 'K39461', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:01:57', '2018-07-19 10:01:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1254', '2018-05-30', 'K39462', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:02:01', '2018-07-19 10:02:01');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1255', '2018-05-30', 'K39463', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:02:06', '2018-07-19 10:02:06');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1256', '2018-05-30', 'K39464', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:02:08', '2018-07-19 10:02:08');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1257', '2018-05-30', 'K39434', 'A1805151XH', '119', 'Q677', 'JS180126', 'K180530XH', null, '96', '23', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:03:05', '2018-07-19 10:03:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1258', '2018-05-30', 'K39465', 'A1805151XH', '115', 'Q2004', 'JS180126', 'K180530XH', null, '96', '19', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:03:57', '2018-07-19 10:03:57');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1260', '2018-06-04', 'K40033', 'A1805152XH', '96', 'Q2826:82|Q2022:14', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:10:49', '2018-07-19 10:10:49');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1262', '2018-06-04', 'K40067', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:29:25', '2018-07-19 10:42:34');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1263', '2018-06-04', 'K39458', 'A1805151XH', '96', 'Q2004', 'JS180126', 'K180530XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:33:42', '2018-07-19 10:33:42');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1264', '2018-06-04', 'K39652', 'A1805151XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:41:19', '2018-07-19 10:41:19');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1265', '2018-06-04', 'K39655', 'A1805151XH', '96', 'Q2207', 'JS180126', 'K180601XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 10:41:24', '2018-07-19 10:41:24');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1266', '2018-06-04', 'K40067', 'A1805152XH', '96', 'Q1849', 'JS180126', 'K180604XH', null, '96', '0', '14-0014', '102987390', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-19 16:24:54', '2018-07-19 16:24:54');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1267', '2018-07-26', '888888888', 'A1805152XH', '103', 'Q1849', '9999', 'ooiyggg', '09-0079', '96', '7', '09-0071', 'llkjj', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-26 15:45:04', '2018-07-26 15:46:05');
INSERT INTO `t_ums_workflow_assembly` VALUES ('1268', '2018-07-26', '888888888', 'A1805152XH', '107', 'Q1849', '9999', 'ooiyggg', '09-0079', '96', '11', '09-0071', 'llkjj', null, '拆夹工作人员1', '装夹工作人员1', '9', '2018-07-26 15:45:51', '2018-07-26 15:45:51');

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
  `raw_material` varchar(100) DEFAULT NULL COMMENT 'FIBER RAW MATERIAL',
  `in_put_date` date DEFAULT NULL COMMENT 'INPUT DATE',
  `coating_station` varchar(100) DEFAULT NULL COMMENT 'BIO 镀膜设备名称/每一个tray需要记录其对应在镀膜设备镀膜时放置的位置',
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
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `theory_yield` varchar(20) DEFAULT NULL COMMENT '理论良率',
  `actual_yield` varchar(20) DEFAULT NULL COMMENT '实际良率',
  `theory_actual_yield` varchar(20) DEFAULT NULL COMMENT '理论和实际良率比较',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cr_id`,`input_time`),
  KEY `idx_uwb_biocoating_lot` (`lot`),
  KEY `idx_uwb_biocoating_biopatnum` (`bio_pat_num`),
  KEY `idx_uwb_biocoating_inputdate` (`in_put_date`),
  KEY `idx_uwb_biocoating_operatorid` (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='生化镀膜表'
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
-- Records of t_ums_workflow_biocoating
-- ----------------------------
INSERT INTO `t_ums_workflow_biocoating` VALUES ('5', '1806071', null, '18-0009', 'CP1', 'CP1', 'XC171120', '2018-06-07', 'B-0280', '17', '10752', '', '', '', '11520', '0', '0', '8', '626', '134', 'T16 T32 T39 T50 T65 T72 T102 T103', null, '100.00', '93.33', '93.33', '9', '2018-07-19 10:33:18', '2018-07-19 10:58:37');
INSERT INTO `t_ums_workflow_biocoating` VALUES ('6', '1806011', null, '18-0009', 'B10', 'C11', 'XC171120', '2018-06-01', 'B-0280', '17', '10752', '', '', '', '11520', '2', '0', '84', '626', '56', 'T12 T14 T20 T63 T64 T88 T102 T111', null, '99.98', '93.33', '93.35', '9', '2018-07-19 15:40:25', '2018-07-19 15:44:05');
INSERT INTO `t_ums_workflow_biocoating` VALUES ('7', '18060713', null, '18-0009', 'B10', 'B10', 'XC171120', '2018-06-07', 'B-0280', '17', '10752', '', '', '', '11520', '0', '0', '8', '626', '134', 'T16 T32 T39 T50 T65 T72 T102 T103', null, '100.00', '93.33', '93.33', '9', '2018-07-19 16:31:14', '2018-07-20 08:28:14');
INSERT INTO `t_ums_workflow_biocoating` VALUES ('8', '18060714', null, '18-0009', 'B10', 'B10', 'XC171120', '2018-06-07', 'B-0280', '17', '10752', '', '', '', '11520', '0', '0', '8', '626', '134', 'T16 T32 T39 T50 T65 T72 T102 T103', null, '100.00', '93.33', '93.33', '9', '2018-07-23 16:36:24', '2018-07-23 16:36:24');

-- ----------------------------
-- Table structure for t_ums_workflow_biocoating_reagents
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_biocoating_reagents`;
CREATE TABLE `t_ums_workflow_biocoating_reagents` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `reagents_field_name` varchar(50) DEFAULT NULL,
  `main_reagent` varchar(20) DEFAULT NULL COMMENT '混合试剂名称',
  `reagents_name` varchar(50) DEFAULT NULL COMMENT '混合试剂编号',
  `reagents_sn` varchar(100) DEFAULT NULL,
  KEY `idx_uwbr_reagents_crid` (`cr_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学混合试剂表'
/*!50100 PARTITION BY HASH (cr_id)
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
-- Records of t_ums_workflow_biocoating_reagents
-- ----------------------------
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209442_20', '05-5003', '01-0022', 'SI180117');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209441_21', '05-5003', '01-0025', 'SI180416A SI180416B SI180416C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209430_26', '03-0008', '01-0011', 'XY170907');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209445_27', '03-0008', '03-0007', 'BF18041101');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209436_48', '01-0026', '01-0026', 'FI180529');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209440_47', '01-0030', '01-0030', 'SI180521');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209781_46', '04-0013', '04-0013', 'MP180412C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209781_45', '04-0013', '04-0013', 'MP180412A');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('5', 'reagentmixturetable209437_44', '03-0006', '01-0029', 'SI180328');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209437_19', '03-0006', '01-0029', 'SI180328');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209442_20', '05-5003', '01-0022', 'SI180117');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209441_21', '05-5003', '01-0025', 'SI180416A SI180416B SI180416C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209430_26', '03-0008', '01-0011', 'XY170907');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209445_27', '03-0008', '03-0007', 'BF18041101');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209781_35', '04-0013', '04-0013', 'MP180117C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209440_33', '01-0030', '01-0030', 'SI180424');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('6', 'reagentmixturetable209436_32', '01-0026', '01-0026', 'FI180418');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209437_19', '03-0006', '01-0029', 'SI180328');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209442_20', '05-5003', '01-0022', 'SI180117');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209441_21', '05-5003', '01-0025', 'SI180416A SI180416B SI180416C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209430_26', '03-0008', '01-0011', 'XY170907');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209445_27', '03-0008', '03-0007', 'BF18041101');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209436_48', '01-0026', '01-0026', 'FI180529');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209440_47', '01-0030', '01-0030', 'SI180521');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209781_46', '04-0013', '04-0013', 'MP180412C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209781_45', '04-0013', '04-0013', 'MP180412A');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('7', 'reagentmixturetable209437_44', '03-0006', '01-0029', 'SI180328');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209437_19', '03-0006', '01-0029', 'SI180328');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209442_20', '05-5003', '01-0022', 'SI180117');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209441_21', '05-5003', '01-0025', 'SI180416A SI180416B SI180416C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209430_26', '03-0008', '01-0011', 'XY170907');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209445_27', '03-0008', '03-0007', 'BF18041101');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209436_48', '01-0026', '01-0026', 'FI180529');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209440_47', '01-0030', '01-0030', 'SI180521');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209781_46', '04-0013', '04-0013', 'MP180412C');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209781_45', '04-0013', '04-0013', 'MP180412A');
INSERT INTO `t_ums_workflow_biocoating_reagents` VALUES ('8', 'reagentmixturetable209437_44', '03-0006', '01-0029', 'SI180328');

-- ----------------------------
-- Table structure for t_ums_workflow_biocoating_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_biocoating_relation`;
CREATE TABLE `t_ums_workflow_biocoating_relation` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `tray_lot_num` varchar(20) DEFAULT NULL COMMENT '组装站位的tray#',
  `t_lot_num` varchar(20) DEFAULT NULL COMMENT 'T#',
  KEY `idx_uwbr_relation_crid` (`cr_id`) USING BTREE,
  KEY `idx_uwbr_relation_traylotnum` (`tray_lot_num`) USING BTREE,
  KEY `idx_uwbr_relation_tlotnum` (`t_lot_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学试剂与组装关系表'
/*!50100 PARTITION BY HASH (cr_id)
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
-- Records of t_ums_workflow_biocoating_relation
-- ----------------------------
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40046', 'T01');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40047', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40048', 'T03');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40049', 'T04');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40050', 'T05');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40051', 'T06');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40052', 'T07');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40053', 'T08');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40054', 'T09');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40055', 'T10');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40056', 'T11');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40057', 'T12');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40058', 'T13');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40059', 'T14');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40060', 'T15');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40061', 'T16');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40062', 'T17');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40063', 'T18');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40064', 'T19');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40065', 'T20');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40066', 'T21');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40067', 'T22');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40068', 'T23');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40069', 'T24');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40070', 'T25');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40071', 'T26');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40072', 'T27');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40073', 'T28');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40074', 'T29');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40075', 'T30');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40076', 'T31');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40077', 'T32');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40078', 'T33');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40079', 'T34');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40080', 'T35');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40081', 'T36');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40082', 'T37');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40083', 'T38');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40084', 'T39');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40085', 'T40');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40086', 'T41');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40087', 'T42');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40088', 'T43');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40089', 'T44');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40090', 'T45');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40091', 'T46');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40092', 'T47');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40093', 'T48');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40094', 'T49');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40095', 'T50');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40096', 'T51');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40097', 'T52');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40098', 'T53');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40099', 'T54');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40100', 'T55');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40101', 'T56');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40102', 'T57');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40103', 'T58');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40104', 'T59');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40105', 'T60');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40106', 'T61');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40107', 'T62');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40108', 'T63');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40109', 'T64');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40110', 'T65');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40111', 'T66');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40112', 'T67');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40113', 'T68');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40114', 'T69');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40115', 'T70');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40116', 'T71');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40117', 'T72');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40118', 'T73');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40119', 'T74');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40120', 'T75');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40121', 'T76');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40122', 'T77');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40123', 'T78');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40124', 'T79');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40125', 'T80');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40126', 'T81');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40127', 'T82');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40128', 'T83');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40129', 'T84');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40130', 'T85');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40131', 'T86');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40132', 'T87');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40133', 'T88');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40134', 'T89');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40135', 'T90');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40136', 'T91');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40137', 'T92');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40138', 'T93');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40139', 'T94');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40140', 'T95');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40141', 'T96');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40142', 'T97');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40143', 'T98');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40144', 'T99');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40145', 'T100');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40146', 'T101');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40147', 'T102');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40148', 'T103');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40149', 'T104');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40150', 'T105');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40151', 'T106');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40152', 'T107');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40153', 'T108');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40154', 'T109');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40155', 'T110');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40156', 'T111');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40157', 'T112');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40158', 'T113');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40159', 'T114');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40160', 'T115');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40161', 'T116');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40162', 'T117');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40163', 'T118');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40164', 'T119');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('5', 'K40165', 'T120');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39286', 'T01');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39287', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39288', 'T03');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39289', 'T04');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39290', 'T05');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39291', 'T06');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39292', 'T07');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39293', 'T08');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39294', 'T09');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39295', 'T10');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39296', 'T11');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39297', 'T12');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39298', 'T13');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39299', 'T14');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39300', 'T15');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39301', 'T16');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39302', 'T17');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39303', 'T18');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39304', 'T19');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39305', 'T20');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39306', 'T21');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39307', 'T22');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39308', 'T23');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39309', 'T24');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39310', 'T25');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39311', 'T26');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39312', 'T27');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39313', 'T28');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39314', 'T29');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39315', 'T30');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39316', 'T31');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39317', 'T32');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39318', 'T33');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39319', 'T34');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39320', 'T35');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39321', 'T36');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39322', 'T37');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39323', 'T38');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39324', 'T39');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39325', 'T40');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39326', 'T41');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39327', 'T42');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39328', 'T43');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39329', 'T44');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39330', 'T45');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39331', 'T46');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39332', 'T47');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39333', 'T48');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39334', 'T49');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39335', 'T50');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39336', 'T51');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39337', 'T52');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39338', 'T53');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39339', 'T54');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39340', 'T55');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39341', 'T56');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39342', 'T57');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39343', 'T58');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39344', 'T59');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39345', 'T60');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39346', 'T61');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39347', 'T62');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39348', 'T63');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39349', 'T64');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39350', 'T65');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39351', 'T66');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39352', 'T67');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39353', 'T68');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39354', 'T69');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39355', 'T70');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39356', 'T71');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39357', 'T72');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39358', 'T73');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39359', 'T74');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39360', 'T75');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39361', 'T76');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39362', 'T77');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39363', 'T78');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39364', 'T79');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39365', 'T80');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39366', 'T81');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39367', 'T82');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39368', 'T83');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39369', 'T84');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39370', 'T85');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39371', 'T86');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39372', 'T87');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39373', 'T88');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39374', 'T89');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39375', 'T90');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39376', 'T91');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39377', 'T92');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39378', 'T93');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39379', 'T94');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39380', 'T95');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39381', 'T96');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39382', 'T97');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39383', 'T98');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39384', 'T99');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39385', 'T100');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39386', 'T101');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39387', 'T102');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39388', 'T103');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39389', 'T104');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39390', 'T105');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39391', 'T106');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39392', 'T107');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39393', 'T108');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39394', 'T109');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39395', 'T110');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39396', 'T111');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39397', 'T112');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39398', 'T113');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39399', 'T114');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39400', 'T115');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39401', 'T116');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39402', 'T117');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39403', 'T118');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39404', 'T119');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('6', 'K39405', 'T120');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39420', 'T01');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39421', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39422', 'T03');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39423', 'T04');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39424', 'T05');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39425', 'T06');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39426', 'T07');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39427', 'T08');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39428', 'T09');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39429', 'T10');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39430', 'T11');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39431', 'T12');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39432', 'T13');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39433', 'T14');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39434', 'T15');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39440', 'T16');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39441', 'T17');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39442', 'T18');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39443', 'T19');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39444', 'T20');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39445', 'T21');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39446', 'T22');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39447', 'T23');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39448', 'T24');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39449', 'T25');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39450', 'T26');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39451', 'T27');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39452', 'T28');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39453', 'T29');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39454', 'T30');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39455', 'T31');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39456', 'T32');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39457', 'T33');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39458', 'T34');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39459', 'T35');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39460', 'T36');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39461', 'T37');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39462', 'T38');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39463', 'T39');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39464', 'T40');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39465', 'T41');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39466', 'T42');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39467', 'T43');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39468', 'T44');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39469', 'T45');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39470', 'T46');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39471', 'T47');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39472', 'T48');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39473', 'T49');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39474', 'T50');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39475', 'T51');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39476', 'T52');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39477', 'T53');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39478', 'T54');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39479', 'T55');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39480', 'T56');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39481', 'T57');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39497', 'T58');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39498', 'T59');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39499', 'T60');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39500', 'T61');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39501', 'T62');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39502', 'T63');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39503', 'T64');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39504', 'T65');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39505', 'T66');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39506', 'T67');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39507', 'T68');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39508', 'T69');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39509', 'T70');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39510', 'T71');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39511', 'T72');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39512', 'T73');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39513', 'T74');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39514', 'T75');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39515', 'T76');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39516', 'T77');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39517', 'T78');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39518', 'T79');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39519', 'T80');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39520', 'T81');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39521', 'T82');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39522', 'T83');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39523', 'T84');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39524', 'T85');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39525', 'T86');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39526', 'T87');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39543', 'T88');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39544', 'T89');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39545', 'T90');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39546', 'T91');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39547', 'T92');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39548', 'T93');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39549', 'T94');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39550', 'T95');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39551', 'T96');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39552', 'T97');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39553', 'T98');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39554', 'T99');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39555', 'T100');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39556', 'T101');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39557', 'T102');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39589', 'T103');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39590', 'T104');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39591', 'T105');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39592', 'T106');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39593', 'T107');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39594', 'T108');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39595', 'T109');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39596', 'T110');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39597', 'T111');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39598', 'T112');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39599', 'T113');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39600', 'T114');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39601', 'T115');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39602', 'T116');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39603', 'T117');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39652', 'T118');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K39655', 'T119');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('7', 'K40033', 'T120');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39341', 'T01');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39402', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39403', 'T03');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39419', 'T04');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39401', 'T05');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39400', 'T06');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39418', 'T07');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39389', 'T08');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39390', 'T09');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39391', 'T10');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39417', 'T11');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39416', 'T12');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39415', 'T13');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39414', 'T14');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39413', 'T15');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39412', 'T16');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39411', 'T17');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39410', 'T18');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39392', 'T19');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39409', 'T20');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39408', 'T21');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39407', 'T22');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39406', 'T23');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39405', 'T24');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39393', 'T25');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39394', 'T26');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39404', 'T27');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39395', 'T28');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39396', 'T29');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39397', 'T30');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39398', 'T31');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39399', 'T32');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39388', 'T33');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39387', 'T34');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39386', 'T35');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39385', 'T36');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39384', 'T37');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39383', 'T38');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39382', 'T39');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39381', 'T40');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39380', 'T41');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39379', 'T42');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39378', 'T43');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39377', 'T44');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39376', 'T45');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39375', 'T46');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39374', 'T47');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39373', 'T48');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39356', 'T49');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39326', 'T50');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39435', 'T01');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39436', 'T02');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39437', 'T03');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39438', 'T04');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39439', 'T05');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39527', 'T06');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39528', 'T07');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39529', 'T08');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39530', 'T09');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39531', 'T10');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39532', 'T11');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39533', 'T12');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39534', 'T13');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39535', 'T14');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39536', 'T15');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39537', 'T16');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39538', 'T17');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39539', 'T18');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39540', 'T19');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39541', 'T20');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39542', 'T21');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39561', 'T22');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39562', 'T23');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39563', 'T24');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39564', 'T25');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39565', 'T26');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39566', 'T27');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39567', 'T28');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39568', 'T29');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39569', 'T30');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39570', 'T31');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39571', 'T32');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39572', 'T33');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39894', 'T34');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39895', 'T35');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39896', 'T36');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39897', 'T37');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39898', 'T38');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39899', 'T39');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39900', 'T40');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39901', 'T41');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39902', 'T42');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39903', 'T43');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39904', 'T44');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39905', 'T45');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39906', 'T46');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39907', 'T47');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39908', 'T48');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39909', 'T49');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39926', 'T50');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39927', 'T51');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39928', 'T52');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39929', 'T53');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39930', 'T54');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39931', 'T55');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39932', 'T56');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39933', 'T57');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39934', 'T58');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39935', 'T59');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39936', 'T60');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39937', 'T61');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39938', 'T62');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39939', 'T63');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'Q39940', 'T64');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39972', 'T65');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39973', 'T66');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39974', 'T67');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39975', 'T68');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39976', 'T69');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39977', 'T70');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39978', 'T71');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39979', 'T72');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39980', 'T73');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39981', 'T74');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39982', 'T75');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39983', 'T76');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39984', 'T77');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39985', 'T78');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39986', 'T79');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39987', 'T80');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39988', 'T81');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39989', 'T82');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39990', 'T83');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39991', 'T84');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39992', 'T85');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39993', 'T86');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39994', 'T87');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39995', 'T88');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39996', 'T89');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39997', 'T90');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39998', 'T91');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K39999', 'T92');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40000', 'T93');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40001', 'T94');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40002', 'T95');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40018', 'T96');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40019', 'T97');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40020', 'T98');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40021', 'T99');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40022', 'T100');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40023', 'T101');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40024', 'T102');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40025', 'T103');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40026', 'T104');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40027', 'T105');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40028', 'T106');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40029', 'T107');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40030', 'T108');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40031', 'T109');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40032', 'T110');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40036', 'T111');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40037', 'T112');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40038', 'T113');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40039', 'T114');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40040', 'T115');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40041', 'T116');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40042', 'T117');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40043', 'T118');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40044', 'T119');
INSERT INTO `t_ums_workflow_biocoating_relation` VALUES ('8', 'K40045', 'T120');

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
  PRIMARY KEY (`clean_id`,`input_time`),
  KEY `idx_uwc_cleaning_cleantime` (`clean_time`),
  KEY `idx_uwc_cleaning_inputlotnum` (`input_lot_num`),
  KEY `idx_uwc_cleaning_fixturenum` (`fixture_number`),
  KEY `idx_uwc_cleaning_cleanlotnum` (`clean_lot_num`),
  KEY `idx_uwc_cleaning_workordernum` (`work_order_num`),
  KEY `idx_uwc_cleaning_partnum` (`part_num`),
  KEY `idx_uwc_cleaning_operatorid` (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COMMENT='清洗表'
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
-- Records of t_ums_workflow_clean
-- ----------------------------
INSERT INTO `t_ums_workflow_clean` VALUES ('36', '2018-03-22', 'Q1282', 'DX1803009', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:23:32', '2018-07-10 10:48:09');
INSERT INTO `t_ums_workflow_clean` VALUES ('37', '2018-03-22', 'Q1974', 'DX1803009', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:24:22', '2018-07-10 10:48:27');
INSERT INTO `t_ums_workflow_clean` VALUES ('38', '2018-03-22', 'Q1897', 'DX1803009', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 15:27:36', '2018-07-10 10:48:45');
INSERT INTO `t_ums_workflow_clean` VALUES ('39', '2018-03-22', 'Q388', 'DX1803009', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:32:13', '2018-07-10 10:47:41');
INSERT INTO `t_ums_workflow_clean` VALUES ('40', '2018-03-22', 'Q673', 'DX1803009', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:32:42', '2018-07-10 10:47:20');
INSERT INTO `t_ums_workflow_clean` VALUES ('41', '2018-03-22', 'Q2491', 'DX1803009', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 15:33:26', '2018-07-10 10:46:56');
INSERT INTO `t_ums_workflow_clean` VALUES ('42', '2018-03-22', 'Q1758', 'DX1803009', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:35:08', '2018-07-10 10:46:25');
INSERT INTO `t_ums_workflow_clean` VALUES ('43', '2018-03-22', 'Q1732', 'DX1803009', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 15:36:03', '2018-07-10 10:46:04');
INSERT INTO `t_ums_workflow_clean` VALUES ('44', '2018-03-22', 'Q1469', 'DX1803009', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:37:03', '2018-07-10 10:45:22');
INSERT INTO `t_ums_workflow_clean` VALUES ('45', '2018-03-22', 'Q2193', 'DX1803010', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:40:23', '2018-07-10 10:44:28');
INSERT INTO `t_ums_workflow_clean` VALUES ('46', '2018-03-22', 'Q2136', 'DX1803010', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:40:42', '2018-07-10 10:41:48');
INSERT INTO `t_ums_workflow_clean` VALUES ('47', '2018-03-22', 'Q2829', 'DX1803010', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:41:07', '2018-07-10 10:40:56');
INSERT INTO `t_ums_workflow_clean` VALUES ('48', '2018-03-22', 'Q1944', 'DX1803010', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:41:49', '2018-07-10 10:40:31');
INSERT INTO `t_ums_workflow_clean` VALUES ('49', '2018-03-22', 'Q1863', 'DX1803010', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 15:43:49', '2018-07-10 10:39:37');
INSERT INTO `t_ums_workflow_clean` VALUES ('50', '2018-03-22', 'Q645', 'DX1803010', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:45:43', '2018-07-10 10:38:37');
INSERT INTO `t_ums_workflow_clean` VALUES ('51', '2018-03-22', 'Q1770', 'DX1803010', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:48:31', '2018-07-10 10:38:16');
INSERT INTO `t_ums_workflow_clean` VALUES ('52', '2018-03-22', 'Q2309', 'DX1803010', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:49:25', '2018-07-10 10:37:55');
INSERT INTO `t_ums_workflow_clean` VALUES ('53', '2018-03-22', 'Q2002', 'DX1803010', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:51:01', '2018-07-10 10:37:34');
INSERT INTO `t_ums_workflow_clean` VALUES ('54', '2018-03-22', 'Q1868', 'DX1803011', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:52:53', '2018-07-10 10:37:11');
INSERT INTO `t_ums_workflow_clean` VALUES ('55', '2018-03-22', 'Q1990', 'DX1803011', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:53:19', '2018-07-10 10:36:53');
INSERT INTO `t_ums_workflow_clean` VALUES ('56', '2018-03-22', 'Q1984', 'DX1803011', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:53:46', '2018-07-10 10:36:33');
INSERT INTO `t_ums_workflow_clean` VALUES ('57', '2018-03-22', 'Q2026', 'DX1803011', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:54:08', '2018-07-10 10:36:12');
INSERT INTO `t_ums_workflow_clean` VALUES ('58', '2018-03-22', 'Q1478', 'DX1803011', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:54:25', '2018-07-10 10:35:52');
INSERT INTO `t_ums_workflow_clean` VALUES ('59', '2018-03-22', 'Q2863', 'DX1803011', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:54:55', '2018-07-10 10:35:32');
INSERT INTO `t_ums_workflow_clean` VALUES ('60', '2018-03-22', 'Q2821', 'DX1803011', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:55:16', '2018-07-10 10:33:48');
INSERT INTO `t_ums_workflow_clean` VALUES ('61', '2018-03-22', 'Q2088', 'DX1803011', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 15:55:55', '2018-07-10 10:33:31');
INSERT INTO `t_ums_workflow_clean` VALUES ('62', '2018-03-22', 'Q2049', 'DX1803011', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:56:20', '2018-07-10 10:33:14');
INSERT INTO `t_ums_workflow_clean` VALUES ('63', '2018-03-22', 'Q2845', 'DX1803012', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 15:57:27', '2018-07-10 10:32:49');
INSERT INTO `t_ums_workflow_clean` VALUES ('64', '2018-03-22', 'Q2004', 'DX1803012', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:57:43', '2018-07-10 10:29:54');
INSERT INTO `t_ums_workflow_clean` VALUES ('65', '2018-03-22', 'Q1365', 'DX1803012', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:58:09', '2018-07-10 10:29:08');
INSERT INTO `t_ums_workflow_clean` VALUES ('66', '2018-03-22', 'Q2144', 'DX1803012', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 15:58:37', '2018-07-10 10:26:23');
INSERT INTO `t_ums_workflow_clean` VALUES ('67', '2018-03-22', 'Q677', 'DX1803012', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 15:59:05', '2018-07-10 10:25:56');
INSERT INTO `t_ums_workflow_clean` VALUES ('68', '2018-03-22', 'Q1485', 'DX1803015', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:01:19', '2018-07-10 10:25:37');
INSERT INTO `t_ums_workflow_clean` VALUES ('69', '2018-03-22', 'Q2380', 'DX1803012', '1534', null, 'CX180309', '6', '1533', '99.61', '1', '09-0071', '102850059', '9', '2018-06-19 16:01:42', '2018-07-10 10:07:25');
INSERT INTO `t_ums_workflow_clean` VALUES ('70', '2018-03-22', 'Q359', 'DX1803015', '1534', null, 'CX180309', '4', '1534', '99.74', '0', '09-0071', '102850059', '9', '2018-06-19 16:01:50', '2018-07-10 10:25:16');
INSERT INTO `t_ums_workflow_clean` VALUES ('71', '2018-03-22', 'Q1774', 'DX1803012', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 16:02:04', '2018-07-10 10:24:46');
INSERT INTO `t_ums_workflow_clean` VALUES ('72', '2018-03-22', 'Q290', 'DX1803015', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 16:02:20', '2018-07-10 10:24:22');
INSERT INTO `t_ums_workflow_clean` VALUES ('73', '2018-03-22', 'Q2828', 'DX1803012', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:02:34', '2018-07-10 10:24:05');
INSERT INTO `t_ums_workflow_clean` VALUES ('74', '2018-03-22', 'Q2850', 'DX1803012', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 16:03:00', '2018-07-10 10:23:46');
INSERT INTO `t_ums_workflow_clean` VALUES ('75', '2018-03-22', 'Q1382', 'DX1803015', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:03:02', '2018-07-10 10:23:26');
INSERT INTO `t_ums_workflow_clean` VALUES ('76', '2018-03-22', 'Q786', 'DX1803013', '1534', null, 'CX180309', '4', '1534', '99.74', '0', '09-0071', '102850059', '9', '2018-06-19 16:03:35', '2018-07-10 10:23:05');
INSERT INTO `t_ums_workflow_clean` VALUES ('77', '2018-03-22', 'Q2022', 'DX1803016', '1534', null, 'CX180309', '7', '1534', '99.54', '0', '09-0071', '102850059', '9', '2018-06-19 16:03:46', '2018-07-10 10:22:27');
INSERT INTO `t_ums_workflow_clean` VALUES ('78', '2018-03-22', 'Q300', 'DX1803013', '1534', null, 'CX180309', '10', '1534', '99.35', '0', '09-0071', '102850059', '9', '2018-06-19 16:04:14', '2018-07-10 10:22:05');
INSERT INTO `t_ums_workflow_clean` VALUES ('79', '2018-03-22', 'Q1235', 'DX1803016', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 16:04:20', '2018-07-10 10:21:37');
INSERT INTO `t_ums_workflow_clean` VALUES ('80', '2018-03-22', 'Q2321', 'DX1803013', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:04:43', '2018-07-10 10:21:19');
INSERT INTO `t_ums_workflow_clean` VALUES ('81', '2018-03-22', 'Q2815', 'DX1803016', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:04:57', '2018-07-10 10:21:00');
INSERT INTO `t_ums_workflow_clean` VALUES ('82', '2018-03-22', 'Q1874', 'DX1803013', '1534', null, 'CX180309', '4', '1534', '99.74', '0', '09-0071', '102850059', '9', '2018-06-19 16:05:10', '2018-07-10 10:20:40');
INSERT INTO `t_ums_workflow_clean` VALUES ('83', '2018-03-22', 'Q2161', 'DX1803016', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:05:22', '2018-07-10 10:20:00');
INSERT INTO `t_ums_workflow_clean` VALUES ('84', '2018-03-22', 'Q2807', 'DX1803016', '1534', null, 'CX180309', '0', '1534', '100.00', '0', '09-0071', '102850059', '9', '2018-06-19 16:05:41', '2018-07-10 10:19:39');
INSERT INTO `t_ums_workflow_clean` VALUES ('85', '2018-03-22', 'Q2501', 'DX1803013', '1534', null, 'CX180309', '7', '1534', '99.54', '0', '09-0071', '102850059', '9', '2018-06-19 16:05:56', '2018-07-10 10:19:12');
INSERT INTO `t_ums_workflow_clean` VALUES ('86', '2018-03-22', 'Q2059', 'DX1803013', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:06:16', '2018-07-10 10:18:08');
INSERT INTO `t_ums_workflow_clean` VALUES ('87', '2018-03-22', 'Q852', 'DX1803016', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:06:21', '2018-07-10 10:18:52');
INSERT INTO `t_ums_workflow_clean` VALUES ('88', '2018-03-22', 'Q1311', 'DX1803016', '1534', null, 'CX180309', '5', '1534', '99.67', '0', '09-0071', '102850059', '9', '2018-06-19 16:07:15', '2018-07-10 10:18:33');
INSERT INTO `t_ums_workflow_clean` VALUES ('89', '2018-03-22', 'Q2050', 'DX1803016', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:07:40', '2018-07-10 10:17:48');
INSERT INTO `t_ums_workflow_clean` VALUES ('90', '2018-03-22', 'Q987', 'DX1803016', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:08:14', '2018-07-10 10:17:28');
INSERT INTO `t_ums_workflow_clean` VALUES ('91', '2018-03-22', 'Q2071', 'DX1803013', '1534', null, 'CX180309', '5', '1534', '99.67', '0', '09-0071', '102850059', '9', '2018-06-19 16:09:16', '2018-07-10 10:16:10');
INSERT INTO `t_ums_workflow_clean` VALUES ('92', '2018-03-22', 'Q2379', 'DX1803013', '1534', null, 'CX180309', '4', '1534', '99.74', '0', '09-0071', '102850059', '9', '2018-06-19 16:09:42', '2018-07-10 10:15:41');
INSERT INTO `t_ums_workflow_clean` VALUES ('93', '2018-03-22', 'Q1781', 'DX1803013', '1534', null, 'CX180309', '7', '1534', '99.54', '0', '09-0071', '102850059', '9', '2018-06-19 16:11:08', '2018-07-10 10:15:16');
INSERT INTO `t_ums_workflow_clean` VALUES ('94', '2018-03-22', 'Q267', 'DX1803014', '1534', null, 'CX180309', '10', '1533', '99.35', '1', '09-0071', '102850059', '9', '2018-06-19 16:11:59', '2018-07-10 10:06:58');
INSERT INTO `t_ums_workflow_clean` VALUES ('95', '2018-03-22', 'Q909', 'DX1803014', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:12:36', '2018-07-10 10:14:49');
INSERT INTO `t_ums_workflow_clean` VALUES ('96', '2018-03-22', 'Q2205', 'DX1803014', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:13:03', '2018-07-10 10:14:26');
INSERT INTO `t_ums_workflow_clean` VALUES ('97', '2018-03-22', 'Q2216', 'DX1803014', '1534', null, 'CX180309', '7', '1534', '99.54', '0', '09-0071', '102850059', '9', '2018-06-19 16:13:41', '2018-07-10 10:13:58');
INSERT INTO `t_ums_workflow_clean` VALUES ('98', '2018-03-22', 'Q2207', 'DX1803014', '1534', null, 'CX180309', '1', '1534', '99.93', '0', '09-0071', '102850059', '9', '2018-06-19 16:14:08', '2018-07-10 10:13:32');
INSERT INTO `t_ums_workflow_clean` VALUES ('99', '2018-03-22', 'Q1417', 'DX1803014', '1534', null, 'CX180309', '5', '1534', '99.67', '0', '09-0071', '102850059', '9', '2018-06-19 16:14:41', '2018-07-10 10:12:09');
INSERT INTO `t_ums_workflow_clean` VALUES ('100', '2018-03-22', 'Q1349', 'DX1803014', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:15:14', '2018-07-10 10:11:42');
INSERT INTO `t_ums_workflow_clean` VALUES ('101', '2018-03-22', 'Q2040', 'DX1803014', '1534', null, 'CX180309', '2', '1533', '99.87', '1', '09-0071', '102850059', '9', '2018-06-19 16:16:50', '2018-07-10 10:06:20');
INSERT INTO `t_ums_workflow_clean` VALUES ('102', '2018-03-22', 'Q1775', 'DX1803014', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:17:14', '2018-07-10 10:11:04');
INSERT INTO `t_ums_workflow_clean` VALUES ('103', '2018-03-22', 'Q1315', 'DX1803015', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:17:56', '2018-07-10 10:10:47');
INSERT INTO `t_ums_workflow_clean` VALUES ('104', '2018-03-22', 'Q1849', 'DX1803015', '1534', null, 'CX180309', '5', '1534', '99.67', '0', '09-0071', '102850059', '9', '2018-06-19 16:19:00', '2018-07-10 10:10:02');
INSERT INTO `t_ums_workflow_clean` VALUES ('105', '2018-03-22', 'Q1415', 'DX1803015', '1534', null, 'CX180309', '2', '1534', '99.87', '0', '09-0071', '102850059', '9', '2018-06-19 16:19:41', '2018-07-10 10:09:31');
INSERT INTO `t_ums_workflow_clean` VALUES ('106', '2018-03-22', 'Q1450', 'DX1803015', '1534', null, 'CX180309', '3', '1534', '99.80', '0', '09-0071', '102850059', '9', '2018-06-19 16:20:09', '2018-07-10 10:08:56');
INSERT INTO `t_ums_workflow_clean` VALUES ('107', '2018-03-22', 'Q2826', 'DX1803015', '1534', null, 'CX180309', '5', '1534', '99.67', null, '09-0071', '102850059', '9', '2018-06-19 16:20:56', '2018-07-10 10:08:30');

-- ----------------------------
-- Table structure for t_ums_workflow_defect
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_defect`;
CREATE TABLE `t_ums_workflow_defect` (
  `defect_id` int(11) DEFAULT NULL COMMENT '缺损关联id(如 defect_type为1 则defectid代表polish表唯一标示)',
  `defect_type` int(4) DEFAULT NULL COMMENT '缺损类型 1:polish 2:clean',
  `dataid` int(11) DEFAULT NULL COMMENT '数据字典表唯一标示',
  `defect_value` int(6) DEFAULT NULL COMMENT '缺损值',
  KEY `idx_uwd_defect_defecttype` (`defect_type`),
  KEY `idx_uwd_defect_dataid` (`dataid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='缺损记录表'
/*!50100 PARTITION BY HASH (defect_id)
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
-- Records of t_ums_workflow_defect
-- ----------------------------
INSERT INTO `t_ums_workflow_defect` VALUES ('192', '172', '223', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('64', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('64', '192', '642', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '201', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '202', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '202', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('384', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '201', '727', '16');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '201', '729', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '201', '733', '20');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '201', '732', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '201', '730', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '202', '739', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('960', '202', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('193', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '191', '253', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '192', '633', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('65', '192', '642', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '739', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '202', '727', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '202', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '202', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '739', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '201', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '202', '727', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '202', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('321', '202', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1', '191', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1', '191', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('833', '201', '727', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('833', '201', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('833', '201', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('833', '201', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('833', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('833', '202', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('833', '202', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('194', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('2', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('2', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '192', '637', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('66', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '201', '731', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '201', '727', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '201', '733', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '202', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '202', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('834', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('898', '201', '727', '20');
INSERT INTO `t_ums_workflow_defect` VALUES ('898', '201', '733', '24');
INSERT INTO `t_ums_workflow_defect` VALUES ('898', '201', '732', '26');
INSERT INTO `t_ums_workflow_defect` VALUES ('898', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('898', '202', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('898', '202', '738', '18');
INSERT INTO `t_ums_workflow_defect` VALUES ('898', '202', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('195', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('3', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('67', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('196', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('4', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('4', '191', '254', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('4', '192', '633', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('4', '192', '635', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('4', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('4', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '192', '644', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '192', '637', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('68', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('197', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '182', '242', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('5', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('5', '191', '254', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('5', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('69', '192', '633', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('901', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('901', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('901', '201', '732', '24');
INSERT INTO `t_ums_workflow_defect` VALUES ('901', '202', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('901', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('901', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('198', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '192', '637', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('70', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '201', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('134', '202', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('199', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('7', '192', '640', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '191', '637', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '191', '633', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '191', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '192', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('71', '192', '252', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('200', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('8', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('8', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '191', '252', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('72', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '201', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '201', '727', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '201', '733', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '201', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '201', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '202', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '202', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('584', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '182', '243', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('9', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '192', '633', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('73', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('202', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '192', '637', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('74', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('203', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('11', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('11', '192', '640', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('11', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '191', '252', '14');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '192', '633', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '192', '640', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('75', '192', '642', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '733', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '732', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '738', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '745', '15');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '733', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '732', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '738', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '745', '15');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '733', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '732', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '738', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '745', '15');
INSERT INTO `t_ums_workflow_defect` VALUES ('715', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('204', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('12', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('12', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '191', '633', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('76', '191', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '201', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '201', '733', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '201', '732', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '202', '739', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '202', '742', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '202', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '202', '740', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1228', '202', '745', '13');
INSERT INTO `t_ums_workflow_defect` VALUES ('205', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '181', '238', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '181', '324', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '191', '252', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('77', '192', '639', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '201', '727', '20');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '201', '729', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('525', '202', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '201', '727', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '201', '733', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '201', '732', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '202', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '202', '738', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('1229', '202', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('142', '171', '218', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('142', '171', '214', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('206', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '181', '324', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '182', '251', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('14', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('14', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '192', '633', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('78', '192', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('143', '171', '214', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('207', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('15', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('15', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '192', '633', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('79', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('208', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('80', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('80', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('81', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('17', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '201', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '201', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '201', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '201', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '202', '727', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '202', '733', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '202', '732', '13');
INSERT INTO `t_ums_workflow_defect` VALUES ('273', '202', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '201', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '201', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '202', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '202', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '202', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '202', '736', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('337', '202', '735', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('146', '172', '223', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('82', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('82', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('18', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('18', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('18', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('210', '201', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('210', '201', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('210', '201', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('210', '202', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('210', '202', '729', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('210', '202', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('210', '202', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '201', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '201', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '201', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '202', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '202', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '202', '733', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '202', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('274', '202', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('211', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('83', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('851', '201', '727', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('851', '201', '733', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('851', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('851', '202', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('851', '202', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('851', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('148', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('212', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('20', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('20', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '201', '727', '17');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '201', '733', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '201', '732', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '202', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '202', '742', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('788', '202', '745', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('149', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('213', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('85', '181', '328', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('85', '182', '242', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('85', '182', '244', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('917', '201', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('917', '201', '733', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('917', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('917', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('917', '202', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('917', '202', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('150', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('214', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('86', '182', '242', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('22', '192', '642', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '201', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '201', '727', '15');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '201', '733', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '201', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '201', '734', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '202', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '202', '742', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '202', '738', '17');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '202', '745', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('726', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '202', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '202', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1174', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('215', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('87', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('87', '181', '328', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '192', '635', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('23', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('663', '201', '733', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('663', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('663', '201', '734', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('663', '202', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('663', '202', '742', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('663', '202', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('663', '202', '745', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('88', '181', '324', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('88', '182', '242', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('24', '192', '640', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('472', '201', '727', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('472', '201', '733', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('472', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('472', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('472', '202', '745', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '201', '728', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '201', '731', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '201', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('600', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('664', '201', '727', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('664', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('664', '201', '733', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('664', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('664', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('664', '202', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '733', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '745', '16');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '733', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '745', '16');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '733', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '201', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('728', '202', '745', '16');
INSERT INTO `t_ums_workflow_defect` VALUES ('1112', '201', '727', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1112', '201', '733', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1112', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1112', '202', '742', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1112', '202', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1112', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('217', '172', '223', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('89', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('25', '192', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('218', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('90', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('90', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('26', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('794', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('794', '202', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('794', '202', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('794', '202', '745', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('794', '202', '743', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('91', '181', '324', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('91', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '202', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1051', '202', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('219', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('92', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('92', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '191', '635', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '191', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '191', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('28', '192', '254', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('412', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('412', '201', '733', '13');
INSERT INTO `t_ums_workflow_defect` VALUES ('412', '201', '732', '71');
INSERT INTO `t_ums_workflow_defect` VALUES ('412', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('412', '202', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('412', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('412', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('157', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('93', '181', '324', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('93', '181', '232', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('29', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('413', '201', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('413', '201', '733', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('413', '201', '732', '12');
INSERT INTO `t_ums_workflow_defect` VALUES ('413', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('413', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('413', '202', '745', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1053', '201', '731', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1053', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1053', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1053', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1053', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1053', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1053', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('158', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('94', '181', '324', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('94', '182', '242', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('30', '192', '635', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('30', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('30', '192', '639', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('990', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('990', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('990', '201', '732', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('990', '202', '746', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('990', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('990', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('990', '202', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '181', '328', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('31', '192', '640', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '202', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '341', '21');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '334', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '204', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '206', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '727', '21');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '734', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '727', '21');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('95', '202', '734', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '201', '728', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '201', '733', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '201', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '202', '745', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('991', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('96', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('96', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('32', '191', '254', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('32', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('32', '192', '635', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('32', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('97', '181', '324', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('97', '182', '242', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '201', '746', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '201', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '201', '742', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '201', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '201', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '201', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '201', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '202', '727', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '202', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('353', '202', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('33', '191', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('33', '191', '635', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('33', '191', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '201', '727', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '201', '733', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '201', '732', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '202', '739', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '202', '742', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '202', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1185', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('98', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('34', '192', '633', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('34', '192', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '740', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('226', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('99', '181', '324', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '201', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '201', '742', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '201', '738', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '202', '728', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '202', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '202', '732', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('227', '202', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('100', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('100', '182', '251', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('36', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('36', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '201', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '201', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '201', '745', '18');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '201', '744', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '201', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '202', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '202', '727', '13');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '202', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('164', '202', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '201', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '201', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '202', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '202', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('804', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('101', '182', '242', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('37', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('37', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('166', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('102', '182', '242', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('38', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('38', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('38', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('167', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('103', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('103', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('39', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('39', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('168', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('104', '181', '238', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('104', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('104', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('40', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('40', '191', '252', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('40', '192', '640', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('872', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('872', '201', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('872', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('872', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '201', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '201', '727', '17');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '201', '733', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '201', '734', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '202', '739', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '202', '740', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1128', '202', '745', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('169', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('105', '182', '242', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('41', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('41', '182', '251', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '201', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '201', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '202', '742', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '202', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '202', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1257', '202', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('170', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('106', '182', '242', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('42', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('42', '192', '635', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('42', '192', '640', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('42', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '201', '731', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '201', '727', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '201', '733', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '201', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1258', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('171', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('107', '181', '324', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('107', '182', '243', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('43', '181', '327', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('43', '182', '251', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('43', '192', '640', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('44', '191', '254', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('44', '192', '635', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('44', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('44', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('173', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('45', '191', '253', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('45', '191', '256', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('45', '191', '252', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('45', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('45', '192', '640', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '201', '727', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '201', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '201', '732', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '202', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '202', '745', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('941', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('46', '192', '633', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('494', '201', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('494', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('494', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('494', '202', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('494', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('175', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('47', '191', '252', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('47', '192', '640', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '191', '252', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '192', '635', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('48', '192', '640', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '201', '739', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '201', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '201', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '201', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '202', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '202', '727', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '202', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '202', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '202', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('304', '202', '734', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '201', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '201', '733', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '201', '732', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '201', '735', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '202', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1200', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '181', '240', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '181', '234', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '192', '635', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('49', '192', '640', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '201', '746', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '201', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '201', '742', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '201', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '201', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '201', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '202', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '202', '727', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '202', '729', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '202', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '202', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('305', '202', '734', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('50', '191', '252', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('50', '192', '633', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('50', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('51', '192', '642', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '201', '739', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '201', '738', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '201', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '202', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '202', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '202', '736', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('243', '202', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1267', '201', '737', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('1267', '201', '737', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('180', '172', '223', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '182', '242', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '191', '253', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '192', '633', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('52', '192', '640', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1268', '202', '746', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1268', '202', '742', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('181', '172', '223', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '191', '253', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '192', '637', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('53', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '738', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '738', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('117', '202', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '172', '223', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '182', '248', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '192', '637', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '192', '633', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('54', '192', '639', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '201', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '201', '738', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '201', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '202', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '202', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '202', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('118', '202', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '201', '739', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '201', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '201', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '201', '745', '19');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '201', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '202', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '202', '733', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('182', '202', '732', '14');
INSERT INTO `t_ums_workflow_defect` VALUES ('630', '201', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('630', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('630', '201', '733', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('630', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('630', '202', '739', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('630', '202', '738', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('630', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('758', '201', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('758', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('758', '201', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('758', '201', '734', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('758', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('758', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('758', '202', '743', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('183', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '191', '256', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '191', '252', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('55', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '201', '728', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '201', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '201', '732', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '201', '734', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '202', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('695', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('759', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('759', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('759', '201', '732', '9');
INSERT INTO `t_ums_workflow_defect` VALUES ('759', '201', '735', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('759', '202', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('759', '202', '740', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('759', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '201', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '201', '727', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '201', '729', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '201', '732', '13');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '201', '735', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1079', '202', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('184', '172', '223', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '192', '635', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('56', '192', '640', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '201', '728', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '201', '733', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '201', '732', '14');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '201', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '202', '739', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '202', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('632', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('185', '172', '223', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('57', '191', '253', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('57', '191', '252', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('57', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('186', '172', '223', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('58', '192', '633', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('58', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '201', '733', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '201', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '201', '734', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '202', '742', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '202', '738', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '202', '745', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('570', '202', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('187', '172', '223', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('59', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('59', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('59', '192', '640', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1019', '201', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1019', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1019', '201', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1019', '201', '735', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1019', '202', '746', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1019', '202', '743', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('188', '172', '223', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '192', '644', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '192', '637', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('60', '192', '640', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '201', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '201', '733', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '201', '732', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '201', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '202', '738', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('1020', '202', '745', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '201', '737', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '201', '729', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '201', '733', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '201', '732', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '201', '735', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '202', '739', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '202', '738', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1084', '202', '743', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '201', '727', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '201', '733', '11');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '201', '735', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '202', '739', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '202', '742', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '202', '738', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1148', '202', '745', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('189', '172', '223', '18');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '182', '244', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '191', '262', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '192', '633', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('61', '192', '640', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '201', '728', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '201', '731', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '201', '727', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '201', '733', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '201', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '202', '740', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '202', '745', '10');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '202', '741', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('1149', '202', '743', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('190', '172', '223', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '181', '324', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '191', '252', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '192', '634', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '192', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('62', '192', '642', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('446', '201', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('446', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('446', '201', '732', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('446', '201', '735', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('446', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('446', '202', '738', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('446', '202', '745', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('510', '201', '731', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('510', '201', '727', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('510', '201', '729', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('510', '201', '733', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('510', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('510', '202', '738', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('510', '202', '740', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('191', '172', '223', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '181', '324', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '192', '633', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '192', '640', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('63', '192', '642', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('383', '201', '727', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('383', '201', '733', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('383', '201', '735', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('383', '202', '742', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('383', '202', '738', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '201', '728', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '201', '727', '8');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '201', '733', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '201', '732', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '202', '746', '2');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '202', '739', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '202', '742', '1');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '202', '738', '6');
INSERT INTO `t_ums_workflow_defect` VALUES ('447', '202', '743', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('959', '201', '727', '5');
INSERT INTO `t_ums_workflow_defect` VALUES ('959', '201', '733', '7');
INSERT INTO `t_ums_workflow_defect` VALUES ('959', '201', '732', '4');
INSERT INTO `t_ums_workflow_defect` VALUES ('959', '202', '739', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('959', '202', '742', '3');
INSERT INTO `t_ums_workflow_defect` VALUES ('959', '202', '738', '7');

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
  PRIMARY KEY (`opf_id`,`input_time`),
  KEY `idx_uwo_opticalgilming_opttime` (`opt_time`),
  KEY `idx_uwo_opticalgilming_inputlotnum` (`input_lot_num`),
  KEY `idx_uwo_opticalgilming_fixturenum` (`fixture_num`),
  KEY `idx_uwo_opticalgilming_outputlotnum` (`output_lot_num`),
  KEY `idx_uwo_opticalgilming_workordernum` (`work_order_num`),
  KEY `idx_uwo_opticalgilming_partnum` (`part_num`),
  KEY `idx_uwo_opticalgilming_supplier` (`supplier`),
  KEY `idx_uwo_opticalgilming_operatorid` (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='光学镀膜表'
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
-- Records of t_ums_workflow_opticalfilming
-- ----------------------------
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('1', '2018-05-15', 'CX180309', '1534', 'Q2136', 'O1804253XH', '1502', '4', '32', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 10:59:22', '2018-07-17 15:53:10');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('2', '2018-05-15', 'CX180309', '1534', 'Q1944', 'O1804253XH', '1534', '2', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 11:01:39', '2018-07-10 12:35:17');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('3', '2018-05-15', 'CX180309', '1534', 'Q1282', 'O1804252XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:33:25', '2018-07-10 12:33:25');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('4', '2018-05-15', 'CX180309', '1534', 'Q1974', 'O1804252XH', '1499', '13', '35', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:41:11', '2018-07-10 12:41:11');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('5', '2018-05-15', 'CX180309', '1534', 'Q1897', 'O1804252XH', '1534', '5', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:46:13', '2018-07-10 12:46:13');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('7', '2018-05-15', 'CX180309', '1534', 'Q388', 'O1804252XH', '1534', '12', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:48:47', '2018-07-10 12:48:47');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('8', '2018-05-15', 'CX180309', '1534', 'Q673', 'O1804252XH', '1534', '2', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:50:52', '2018-07-10 12:50:52');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('9', '2018-05-15', 'CX180309', '1534', 'Q2491', 'O1804252XH', '1534', '1', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:52:58', '2018-07-10 12:52:58');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('11', '2018-05-15', 'CX180309', '1534', 'Q1758', 'O1804252XH', '1472', '9', '62', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:58:26', '2018-07-10 12:58:26');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('12', '2018-05-15', 'CX180309', '1534', 'Q1732', 'O1804253XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 12:59:17', '2018-07-10 13:26:49');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('14', '2018-05-15', 'CX180309', '1534', 'Q1469', 'O1804253XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:00:42', '2018-07-10 13:00:42');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('15', '2018-05-15', 'CX180309', '1534', 'Q2193', 'O1804253XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:05:07', '2018-07-10 13:11:07');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('16', '2018-05-15', 'CX180309', '1534', 'Q2829', 'O1804253XH', '1534', '0', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:05:42', '2018-07-10 13:10:49');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('17', '2018-05-15', 'CX180309', '1534', 'Q1863', 'O1804253XH', '1534', '2', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:06:28', '2018-07-10 13:10:28');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('18', '2018-05-15', 'CX180309', '1534', 'Q645', 'O1804253XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:08:33', '2018-07-10 13:08:33');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('20', '2018-05-15', 'CX180309', '1534', 'Q1770', 'O1804253XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:13:33', '2018-07-10 13:13:33');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('22', '2018-05-15', 'CX180309', '1534', 'Q2309', 'O1804253XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:14:49', '2018-07-10 13:14:49');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('23', '2018-05-15', 'CX180309', '1534', 'Q2002', 'O1804253XH', '1472', '5', '62', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:15:48', '2018-07-10 13:15:48');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('24', '2018-05-15', 'CX180309', '1534', 'Q1868', 'O1804253XH', '1534', '6', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:17:45', '2018-07-10 13:17:45');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('25', '2018-05-15', 'CX180309', '1534', 'Q1990', 'O1804253XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:18:22', '2018-07-10 13:18:22');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('26', '2018-05-15', 'CX180309', '1534', 'Q1984', 'O1804253XH', '1534', '2', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:19:38', '2018-07-10 13:19:38');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('28', '2018-05-15', 'CX180309', '1534', 'Q2026', 'O1804253XH', '1502', '7', '32', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:22:42', '2018-07-17 15:52:46');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('29', '2018-05-15', 'CX180309', '1534', 'Q1478', 'O1804253XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:23:34', '2018-07-10 13:23:34');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('30', '2018-05-15', 'CX180309', '1534', 'Q2863', 'O1804253XH', '1534', '5', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:32:06', '2018-07-10 13:32:06');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('31', '2018-05-15', 'CX180309', '1534', 'Q2821', 'O1804253XH', '1534', '8', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:32:54', '2018-07-10 13:32:54');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('32', '2018-05-15', 'CX180309', '1534', 'Q2088', 'O1804254XH', '1534', '7', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:33:52', '2018-07-10 13:41:10');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('33', '2018-05-15', 'CX180309', '1534', 'Q2049', 'O1804254XH', '1496', '9', '38', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:34:50', '2018-07-17 15:52:18');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('34', '2018-05-15', 'CX180309', '1534', 'Q2845', 'O1804254XH', '1534', '6', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:37:50', '2018-07-10 13:43:07');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('36', '2018-05-15', 'CX180309', '1534', 'Q1365', 'O1804254XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:39:49', '2018-07-10 13:44:34');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('37', '2018-05-15', 'CX180309', '1534', 'Q2144', 'O1804254XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:40:24', '2018-07-10 13:40:24');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('38', '2018-05-15', 'CX180309', '1534', 'Q2004', 'O1804254XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:47:27', '2018-07-10 13:47:27');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('39', '2018-05-15', 'CX180309', '1534', 'Q677', 'O1804254XH', '1534', '3', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:48:19', '2018-07-10 13:48:19');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('40', '2018-05-15', 'CX180309', '1533', 'Q2380', 'O1804254XH', '1533', '12', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:49:14', '2018-07-10 13:49:14');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('41', '2018-05-15', 'CX180309', '1534', 'Q1774', 'O1804254XH', '1534', '0', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:49:59', '2018-07-10 13:49:59');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('42', '2018-05-15', 'CX180309', '1534', 'Q2828', 'O1804254XH', '1501', '10', '33', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:51:10', '2018-07-10 13:51:10');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('43', '2018-05-15', 'CX180309', '1534', 'Q2850', 'O1804254XH', '1534', '5', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:51:55', '2018-07-10 13:51:55');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('44', '2018-05-15', 'CX180309', '1534', 'Q786', 'O1804254XH', '1472', '7', '62', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:53:08', '2018-07-10 13:53:08');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('45', '2018-05-15', 'CX180309', '1534', 'Q2205', 'O1804255XH', '1534', '14', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:54:29', '2018-07-10 14:28:06');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('46', '2018-05-15', 'CX180309', '1534', 'Q2321', 'O1804254XH', '1534', '2', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:55:05', '2018-07-10 13:55:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('47', '2018-05-15', 'CX180309', '1534', 'Q1874', 'O1804254XH', '1534', '10', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:56:09', '2018-07-10 13:56:09');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('48', '2018-05-15', 'CX180309', '1534', 'Q2501', 'O1804254XH', '1534', '9', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:56:57', '2018-07-10 13:56:57');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('49', '2018-05-15', 'CX180309', '1534', 'Q2059', 'O1804254XH', '1534', '8', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 13:57:47', '2018-07-10 13:57:47');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('50', '2018-05-15', 'CX180309', '1534', 'Q2216', 'O1804255XH', '1534', '10', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:30:58', '2018-07-10 14:30:58');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('51', '2018-05-15', 'CX180309', '1534', 'Q2207', 'O1804255XH', '1534', '5', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:31:40', '2018-07-10 14:31:40');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('52', '2018-05-15', 'CX180309', '1534', 'Q1417', 'O1804255XH', '1534', '16', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:32:29', '2018-07-10 14:32:29');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('53', '2018-05-15', 'CX180309', '1534', 'Q1349', 'O1804255XH', '1534', '7', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:33:23', '2018-07-10 14:33:23');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('54', '2018-05-15', 'CX180309', '1533', 'Q2040', 'O1804255XH', '1471', '7', '62', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:34:28', '2018-07-10 14:34:28');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('55', '2018-05-15', 'CX180309', '1534', 'Q1775', 'O1804255XH', '1534', '7', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:36:15', '2018-07-10 14:36:15');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('56', '2018-05-15', 'CX180309', '1534', 'Q1315', 'O1804255XH', '1501', '7', '33', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:37:35', '2018-07-10 14:37:35');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('57', '2018-05-15', 'CX180309', '1534', 'Q1849', 'O1804255XH', '1534', '8', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:38:33', '2018-07-10 14:38:33');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('58', '2018-05-15', 'CX180309', '1534', 'Q1415', 'O1804255XH', '1534', '5', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:41:52', '2018-07-10 14:41:52');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('59', '2018-05-15', 'CX180309', '1534', 'Q1450', 'O1804255XH', '1534', '9', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:42:44', '2018-07-10 14:42:44');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('60', '2018-05-15', 'CX180309', '1534', 'Q2826', 'O1804255XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:43:44', '2018-07-10 14:43:44');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('61', '2018-05-15', 'CX180309', '1534', 'Q1485', 'O1804255XH', '1534', '7', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:44:44', '2018-07-10 14:44:44');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('62', '2018-05-15', 'CX180309', '1534', 'Q359', 'O1804255XH', '1534', '8', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:50:09', '2018-07-10 14:50:09');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('63', '2018-05-15', 'CX180309', '1534', 'Q290', 'O1804261XH', '1534', '7', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:50:58', '2018-07-10 15:03:36');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('64', '2018-05-15', 'CX180309', '1534', 'Q1382', 'O1804261XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:51:57', '2018-07-10 14:51:57');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('65', '2018-05-15', 'CX180309', '1534', 'Q2022', 'O1804261XH', '1534', '16', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:53:45', '2018-07-10 14:53:45');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('66', '2018-05-15', 'CX180309', '1534', 'Q1235', 'O1804261XH', '1534', '4', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:55:20', '2018-07-10 14:55:20');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('67', '2018-05-15', 'CX180309', '1534', 'Q2815', 'O1804261XH', '1500', '6', '34', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:56:02', '2018-07-10 14:56:02');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('68', '2018-05-15', 'CX180309', '1534', 'Q2161', 'O1804261XH', '1534', '6', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:57:02', '2018-07-10 14:57:02');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('69', '2018-05-15', 'CX180309', '1534', 'Q2807', 'O1804261XH', '1534', '2', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:57:48', '2018-07-10 14:57:48');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('70', '2018-05-15', 'CX180309', '1534', 'Q852', 'O1804261XH', '1534', '6', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 14:58:59', '2018-07-10 14:58:59');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('71', '2018-05-15', 'CX180309', '1534', 'Q1311', 'O1804261XH', '1471', '17', '63', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:00:27', '2018-07-17 15:51:20');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('72', '2018-05-15', 'CX180309', '1534', 'Q2050', 'O1804261XH', '1534', '5', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:01:22', '2018-07-10 15:01:22');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('73', '2018-05-15', 'CX180309', '1534', 'Q987', 'O1804261XH', '1502', '7', '32', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:01:59', '2018-07-10 15:01:59');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('74', '2018-05-15', 'CX180309', '1534', 'Q909', 'O1804255XH', '1534', '2', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:30:52', '2018-07-10 15:30:52');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('75', '2018-05-15', 'CX180309', '1533', 'Q267', 'O1804255XH', '1533', '41', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:31:47', '2018-07-10 15:31:47');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('76', '2018-05-15', 'CX180309', '1534', 'Q1781', 'O1804255XH', '1502', '13', '32', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:32:25', '2018-07-17 15:50:19');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('77', '2018-05-15', 'CX180309', '1534', 'Q2379', 'O1804255XH', '1534', '15', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:33:33', '2018-07-10 15:33:33');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('78', '2018-05-15', 'CX180309', '1534', 'Q2071', 'O1804254XH', '1534', '10', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:34:05', '2018-07-10 15:34:05');
INSERT INTO `t_ums_workflow_opticalfilming` VALUES ('79', '2018-05-15', 'CX180309', '1534', 'Q300', 'O1804254XH', '1534', '13', '0', '0', '12-0003', '海泰', null, '102902985', '9', '2018-07-10 15:35:14', '2018-07-10 15:35:14');

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
  `fixture_num` varchar(50) DEFAULT NULL COMMENT '光纤的料号及批次号,Fixture#',
  `aps_bottle` varchar(100) DEFAULT NULL COMMENT 'APS Bottle',
  `fixture_attribute` varchar(50) DEFAULT NULL COMMENT 'fixture属性',
  `sf_bom` varchar(50) DEFAULT NULL COMMENT '哪一瓶化学溶剂 sf_bom',
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
  PRIMARY KEY (`pf_id`,`input_time`),
  KEY `idx_uwp_platedfilm_pftime` (`pf_time`),
  KEY `idx_uwp_platedfilm_inputlotnum` (`input_lot_num`),
  KEY `idx_uwp_platedfilm_fixturenum` (`fixture_num`),
  KEY `idx_uwp_platedfilm_outputlotnum` (`output_lot_num`),
  KEY `idx_uwp_platedfilm_workordernum` (`work_order_num`),
  KEY `idx_uwp_platedfilm_partnum` (`part_num`),
  KEY `idx_uwp_platedfilm_fixtureattribute` (`fixture_attribute`),
  KEY `idx_uwp_platedfilm_operatorid` (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='化学镀膜表'
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
-- Records of t_ums_workflow_platedfilm
-- ----------------------------
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('15', '2018-05-09', null, 'O1804252XH', '1534', 'Q1282', 'SI180403', 'Q', null, 'A1805092XH', '1518', '16', '0', null, null, '8', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:00:42', '2018-07-10 15:05:40');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('16', '2018-05-09', null, 'O1804252XH', '1499', 'Q1974', 'SI180403', 'K', null, 'A1805092XH', '1482', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:20:23', '2018-07-10 15:22:46');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('17', '2018-05-09', null, 'O1804252XH', '1534', 'Q1897', 'SI180403', 'K', null, 'A1805092XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:22:23', '2018-07-10 15:22:23');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('18', '2018-05-09', null, 'O1804252XH', '1534', 'Q388', 'SI180403', 'K', null, 'A1805092XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:26:30', '2018-07-10 15:26:30');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('19', '2018-05-09', null, 'O1804252XH', '1534', 'Q673', 'SI180403', 'K', null, 'A1805092XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:26:38', '2018-07-10 15:27:55');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('20', '2018-05-09', null, 'O1804252XH', '1534', 'Q2491', 'SI180403', 'K', null, 'A1805092XH', '1516', '18', '8', null, null, '0', '10', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:29:48', '2018-07-10 15:29:48');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('21', '2018-05-09', null, 'O1804252XH', '1534', 'Q1758', 'SI180403', 'K', null, 'A1805092XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:29:57', '2018-07-10 15:31:01');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('22', '2018-05-09', null, 'O1804253XH', '1534', 'Q1732', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:32:46', '2018-07-10 15:36:45');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('23', '2018-05-09', null, 'O1804253XH', '1534', 'Q1469', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:34:23', '2018-07-10 15:34:23');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('24', '2018-05-09', null, 'O1804253XH', '1534', 'Q2193', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:35:50', '2018-07-10 15:35:50');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('25', '2018-05-09', null, 'O1804253XH', '1534', 'Q2136', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:39:35', '2018-07-10 15:39:35');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('26', '2018-05-09', null, 'O1804253XH', '1534', 'Q2829', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:41:00', '2018-07-10 15:41:00');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('27', '2018-05-09', null, 'O1804253XH', '1534', 'Q1944', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:42:12', '2018-07-10 15:42:12');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('28', '2018-05-09', null, 'O1804253XH', '1534', 'Q1863', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:43:32', '2018-07-10 15:43:32');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('29', '2018-05-09', null, 'O1804253XH', '1534', 'Q645', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:44:42', '2018-07-10 15:44:42');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('30', '2018-05-09', null, 'O1804253XH', '1534', 'Q1770', 'SI180403', 'K', null, 'A1805093XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:46:03', '2018-07-10 15:46:03');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('31', '2018-05-09', null, 'O1804253XH', '1534', 'Q2309', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:47:01', '2018-07-10 15:47:01');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('32', '2018-05-09', null, 'O1804253XH', '1472', 'Q2002', 'SI180403', 'Q', null, 'A1805093XH', '1426', '46', '38', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:48:51', '2018-07-10 15:53:40');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('33', '2018-05-09', null, 'O1804253XH', '1534', 'Q1868', 'SI180403', 'Q', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:50:03', '2018-07-10 15:50:03');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('34', '2018-05-09', null, 'O1804253XH', '1534', 'Q1990', 'SI180403', 'Q', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:51:27', '2018-07-10 15:51:27');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('35', '2018-05-09', null, 'O1804253XH', '1534', 'Q1984', 'SI180403', 'K', null, 'A1805093XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:52:38', '2018-07-10 15:52:38');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('36', '2018-05-09', null, 'O1804253XH', '1534', 'Q2026', 'SI180403', 'K', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:55:11', '2018-07-10 15:55:11');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('37', '2018-05-09', null, 'O1804253XH', '1534', 'Q1478', 'SI180403', 'Q', null, 'A1805093XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:57:34', '2018-07-10 15:57:34');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('38', '2018-05-09', null, 'O1804253XH', '1534', 'Q2863', 'SI180403', 'Q', null, 'A1805093XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 15:59:41', '2018-07-10 15:59:41');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('39', '2018-04-01', null, 'O1804253XH', '1534', 'Q2821', 'SI180403', 'Q', null, 'A1805093XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:05:42', '2018-07-10 16:05:42');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('40', '2018-05-15', null, 'O1804254XH', '1534', 'Q2088', 'SI180403', 'K', null, 'A1805151XH', '1516', '18', '8', null, null, '0', '10', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:08:50', '2018-07-10 16:08:50');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('41', '2018-05-15', null, 'O1804254XH', '1534', 'Q2049', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:09:50', '2018-07-10 16:09:50');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('42', '2018-05-15', null, 'O1804254XH', '1534', 'Q2845', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:10:53', '2018-07-10 16:10:53');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('43', '2018-05-15', null, 'O1804254XH', '1534', 'Q2004', 'SI180403', 'K', null, 'A1805151XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:11:51', '2018-07-10 16:11:51');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('44', '2018-05-15', null, 'O1804254XH', '1534', 'Q1365', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:13:28', '2018-07-10 16:13:28');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('45', '2018-05-15', null, 'O1804254XH', '1534', 'Q2144', 'SI180403', 'K', null, 'A1805151XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:14:44', '2018-07-10 16:14:44');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('46', '2018-05-15', null, 'O1804254XH', '1534', 'Q677', 'SI180403', 'K', null, 'A1805151XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:15:55', '2018-07-10 16:15:55');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('47', '2018-05-15', null, 'O1804254XH', '1533', 'Q2380', 'SI180403', 'K', null, 'A1805151XH', '1517', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:16:58', '2018-07-10 16:16:58');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('48', '2018-05-15', null, 'O1804254XH', '1534', 'Q1774', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:17:54', '2018-07-10 16:17:54');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('49', '2018-05-15', null, 'O1804254XH', '1501', 'Q2828', 'SI180403', 'K', null, 'A1805151XH', '1455', '46', '38', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:19:42', '2018-07-10 16:19:42');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('50', '2018-05-15', null, 'O1804254XH', '1534', 'Q2850', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:21:00', '2018-07-10 16:21:00');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('51', '2018-05-15', null, 'O1804254XH', '1472', 'Q786', 'SI180403', 'K', null, 'A1805151XH', '1456', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:22:46', '2018-07-10 16:22:46');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('52', '2018-05-15', null, 'O1804254XH', '1534', 'Q300', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:23:56', '2018-07-10 16:23:56');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('53', '2018-05-15', null, 'O1804254XH', '1534', 'Q2321', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:24:52', '2018-07-10 16:24:52');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('54', '2018-05-15', null, 'O1804254XH', '1534', 'Q1874', 'SI180403', 'Q', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:26:59', '2018-07-10 16:26:59');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('55', '2018-05-15', null, 'O1804254XH', '1534', 'Q2501', 'SI180403', 'Q', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:30:04', '2018-07-10 16:30:04');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('56', '2018-05-15', null, 'O1804254XH', '1534', 'Q2059', 'SI180403', 'K', null, 'A1805151XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:32:06', '2018-07-10 16:32:06');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('57', '2018-05-15', null, 'O1804254XH', '1534', 'Q2071', 'SI180403', 'K', null, 'A1805151XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:33:50', '2018-07-10 16:33:50');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('58', '2018-05-15', null, 'O1804255XH', '1534', 'Q2379', 'SI180403', 'K', null, 'A1805152XH', '1488', '46', '38', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:35:27', '2018-07-10 16:35:27');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('59', '2018-05-15', null, 'O1804255XH', '1534', 'Q1781', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:40:10', '2018-07-10 16:41:01');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('60', '2018-05-15', null, 'O1804255XH', '1533', 'Q267', 'SI180403', 'K', null, 'A1805152XH', '1517', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:44:57', '2018-07-10 16:44:57');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('61', '2018-05-15', null, 'O1804255XH', '1533', 'Q909', 'SI180403', 'K', null, 'A1805152XH', '1517', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:44:59', '2018-07-10 16:45:52');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('62', '2018-05-15', null, 'O1804255XH', '1534', 'Q2205', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:46:51', '2018-07-10 16:46:51');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('63', '2018-05-15', null, 'O1804255XH', '1534', 'Q2216', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:47:51', '2018-07-10 16:47:51');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('64', '2018-05-15', null, 'O1804255XH', '1534', 'Q2207', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:47:59', '2018-07-10 16:48:36');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('65', '2018-05-15', null, 'O1804255XH', '1534', 'Q1417', 'SI180403', 'K', null, 'A1805152XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:48:02', '2018-07-10 16:49:09');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('66', '2018-05-15', null, 'O1804255XH', '1534', 'Q1349', 'SI180403', 'K', null, 'A1805152XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:50:16', '2018-07-10 16:50:16');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('67', '2018-05-15', null, 'O1804255XH', '1471', 'Q2040', 'SI180403', 'K', null, 'A1805152XH', '1455', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:51:10', '2018-07-10 16:51:10');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('68', '2018-05-15', null, 'O1804255XH', '1534', 'Q1775', 'SI180403', 'K', null, 'A1805152XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:52:08', '2018-07-10 16:52:08');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('69', '2018-05-15', null, 'O1804255XH', '1501', 'Q1315', 'SI180403', 'K', null, 'A1805152XH', '1484', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:53:41', '2018-07-10 16:53:41');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('70', '2018-05-15', null, 'O1804255XH', '1534', 'Q1849', 'SI180403', 'K', null, 'A1805152XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:57:21', '2018-07-10 17:23:33');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('71', '2018-05-15', null, 'O1804255XH', '1534', 'Q1415', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:58:07', '2018-07-10 16:58:07');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('72', '2018-05-15', null, 'O1804255XH', '1534', 'Q1450', 'SI180403', 'K', null, 'A1805152XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 16:59:47', '2018-07-10 16:59:47');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('73', '2018-05-15', null, 'O1804255XH', '1534', 'Q2826', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:01:33', '2018-07-10 17:01:33');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('74', '2018-05-15', null, 'O1804255XH', '1534', 'Q1485', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:03:16', '2018-07-10 17:03:16');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('75', '2018-05-15', null, 'O1804255XH', '1534', 'Q359', 'SI180403', 'K', null, 'A1805152XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:04:37', '2018-07-10 17:05:11');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('76', '2018-05-15', null, 'O1804261XH', '1534', 'Q290', 'SI180403', 'K', null, 'A1805153XH', '1488', '46', '38', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:07:06', '2018-07-10 17:15:10');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('77', '2018-05-15', null, 'O1804261XH', '1534', 'Q1382', 'SI180403', 'K', null, 'A1805153XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:07:10', '2018-07-10 17:14:32');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('78', '2018-05-15', null, 'O1804261XH', '1534', 'Q2022', 'SI180403', 'K', null, 'A1805153XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:07:13', '2018-07-10 17:13:54');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('79', '2018-05-15', null, 'O1804261XH', '1534', 'Q1235', 'SI180403', 'K', null, 'A1805153XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:10:38', '2018-07-10 17:13:08');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('80', '2018-05-15', null, 'O1804261XH', '1500', 'Q2815', 'SI180403', 'K', null, 'A1805153XH', '1484', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:12:37', '2018-07-10 17:12:37');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('81', '2018-05-15', null, 'O1804261XH', '1534', 'Q2161', 'SI180403', 'K', null, 'A1805153XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:16:22', '2018-07-10 17:16:22');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('82', '2018-05-15', null, 'O1804261XH', '1534', 'Q2807', 'SI180403', 'K', null, 'A1805153XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:17:27', '2018-07-10 17:17:27');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('83', '2018-05-15', null, 'O1804261XH', '1534', 'Q852', 'SI180403', 'K', null, 'A1805153XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:18:29', '2018-07-10 17:18:29');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('84', '2018-05-15', null, 'O1804261XH', '1534', 'Q1311', 'SI180403', 'K', null, 'A1805153XH', '1517', '17', '8', null, null, '0', '9', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:19:30', '2018-07-10 17:19:30');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('85', '2018-05-15', null, 'O1804261XH', '1534', 'Q2050', 'SI180403', 'K', null, 'A1805153XH', '1518', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:20:45', '2018-07-10 17:20:45');
INSERT INTO `t_ums_workflow_platedfilm` VALUES ('86', '2018-05-15', null, 'O1804261XH', '1502', 'Q987', 'SI180403', 'K', null, 'A1805153XH', '1486', '16', '8', null, null, '0', '8', '0', '0', null, '13-0003', '102911894', '9', '2018-07-10 17:22:20', '2018-07-10 17:22:20');

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
  PRIMARY KEY (`polish_id`,`input_time`),
  KEY `idx_uwp_polish_polistime` (`polish_time`),
  KEY `idx_uwp_polish_inputlotnum` (`input_lot_num`),
  KEY `idx_uwp_polish_fixturenum` (`fixture_number`),
  KEY `idx_uwp_polish_polishlotnum` (`polish_lot_num`),
  KEY `idx_uwp_polish_workordernum` (`work_order_num`),
  KEY `idx_uwp_polish_partnum` (`part_num`),
  KEY `idx_uwp_polish_pickingtime` (`picking_time`),
  KEY `idx_uwp_polish_operatorid` (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8 COMMENT='抛光表'
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
-- Records of t_ums_workflow_polish
-- ----------------------------
INSERT INTO `t_ums_workflow_polish` VALUES ('144', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1282', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:38:23', '2018-06-13 16:09:02');
INSERT INTO `t_ums_workflow_polish` VALUES ('145', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1974', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:43:31', '2018-06-13 16:12:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('146', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1897', '', '1#机器', '', '1534', '99.80', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:44:20', '2018-06-13 16:12:01');
INSERT INTO `t_ums_workflow_polish` VALUES ('147', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q388', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:44:36', '2018-06-13 16:11:41');
INSERT INTO `t_ums_workflow_polish` VALUES ('148', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q673', '', '1#机器', '', '1534', '99.93', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:44:49', '2018-06-13 16:11:19');
INSERT INTO `t_ums_workflow_polish` VALUES ('149', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2491', '', '1#机器', '', '1534', '99.87', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:45:07', '2018-06-13 16:10:44');
INSERT INTO `t_ums_workflow_polish` VALUES ('150', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1758', '', '1#机器', '', '1534', '99.93', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:45:18', '2018-06-13 16:10:04');
INSERT INTO `t_ums_workflow_polish` VALUES ('151', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1732', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:45:53', '2018-06-13 16:13:24');
INSERT INTO `t_ums_workflow_polish` VALUES ('152', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1469', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803009', '09-0080', '102850058', null, '9', '2018-06-13 15:46:03', '2018-06-13 16:13:51');
INSERT INTO `t_ums_workflow_polish` VALUES ('153', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2193', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:46:15', '2018-06-13 16:25:00');
INSERT INTO `t_ums_workflow_polish` VALUES ('154', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2136', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:46:28', '2018-06-13 16:24:42');
INSERT INTO `t_ums_workflow_polish` VALUES ('155', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2829', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:46:40', '2018-06-13 16:24:25');
INSERT INTO `t_ums_workflow_polish` VALUES ('156', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1944', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:46:46', '2018-06-13 16:24:07');
INSERT INTO `t_ums_workflow_polish` VALUES ('157', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1863', '', '1#机器', '', '1534', '99.93', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:47:02', '2018-06-13 16:23:48');
INSERT INTO `t_ums_workflow_polish` VALUES ('158', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q645', '', '1#机器', '', '1534', '99.93', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:47:23', '2018-06-13 16:14:59');
INSERT INTO `t_ums_workflow_polish` VALUES ('159', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1770', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:47:31', '2018-06-13 16:15:33');
INSERT INTO `t_ums_workflow_polish` VALUES ('160', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2309', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:47:39', '2018-06-13 16:15:57');
INSERT INTO `t_ums_workflow_polish` VALUES ('161', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2002', '', '1#机器', '', '1534', '100.00', '1534', 'DX1803010', '09-0080', '102850058', null, '9', '2018-06-13 15:47:46', '2018-06-13 16:23:27');
INSERT INTO `t_ums_workflow_polish` VALUES ('162', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1868', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:47:54', '2018-06-13 16:26:10');
INSERT INTO `t_ums_workflow_polish` VALUES ('163', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1990', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:48:01', '2018-06-13 16:25:50');
INSERT INTO `t_ums_workflow_polish` VALUES ('164', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1984', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:48:07', '2018-06-13 16:25:31');
INSERT INTO `t_ums_workflow_polish` VALUES ('165', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2026', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:48:21', '2018-06-13 16:17:17');
INSERT INTO `t_ums_workflow_polish` VALUES ('166', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1478', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:48:34', '2018-06-13 16:17:59');
INSERT INTO `t_ums_workflow_polish` VALUES ('167', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2863', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:48:45', '2018-06-13 16:18:43');
INSERT INTO `t_ums_workflow_polish` VALUES ('168', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2821', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:48:58', '2018-06-13 16:21:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('169', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2088', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:49:06', '2018-06-13 16:22:19');
INSERT INTO `t_ums_workflow_polish` VALUES ('170', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2049', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803011', '09-0080', '102850058', null, '9', '2018-06-13 15:49:12', '2018-06-13 16:22:46');
INSERT INTO `t_ums_workflow_polish` VALUES ('171', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2845', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:49:21', '2018-06-19 15:41:42');
INSERT INTO `t_ums_workflow_polish` VALUES ('172', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2004', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:49:34', '2018-06-19 15:02:50');
INSERT INTO `t_ums_workflow_polish` VALUES ('173', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1365', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:49:43', '2018-06-19 15:02:14');
INSERT INTO `t_ums_workflow_polish` VALUES ('174', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2144', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:49:54', '2018-06-19 15:01:44');
INSERT INTO `t_ums_workflow_polish` VALUES ('175', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q677', '', '2#机器', '', '1534', '99.93', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:50:05', '2018-06-19 15:01:10');
INSERT INTO `t_ums_workflow_polish` VALUES ('176', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2380', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:50:17', '2018-06-19 15:00:24');
INSERT INTO `t_ums_workflow_polish` VALUES ('177', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1774', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:50:23', '2018-06-19 14:59:40');
INSERT INTO `t_ums_workflow_polish` VALUES ('178', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2828', '', '2#机器', '', '1534', '100.00', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:50:29', '2018-06-19 14:58:44');
INSERT INTO `t_ums_workflow_polish` VALUES ('179', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2850', '', '3#机器', '', '1534', '100.00', '1534', 'DX1803012', '09-0080', '102850058', null, '9', '2018-06-13 15:50:44', '2018-06-19 15:40:15');
INSERT INTO `t_ums_workflow_polish` VALUES ('180', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q786', '', '3#机器', '', '1534', '99.80', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:50:53', '2018-06-19 15:11:38');
INSERT INTO `t_ums_workflow_polish` VALUES ('181', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q300', '', '3#机器', '', '1534', '99.74', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:51:02', '2018-06-19 15:11:10');
INSERT INTO `t_ums_workflow_polish` VALUES ('182', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2321', '', '3#机器', '', '1534', '99.87', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:51:13', '2018-06-19 15:10:35');
INSERT INTO `t_ums_workflow_polish` VALUES ('183', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1874', '', '3#机器', '', '1534', '99.93', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:51:22', '2018-06-19 15:05:04');
INSERT INTO `t_ums_workflow_polish` VALUES ('184', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2501', '', '3#机器', '', '1534', '99.67', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:51:32', '2018-06-19 15:04:29');
INSERT INTO `t_ums_workflow_polish` VALUES ('185', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2059', '', '3#机器', '', '1534', '99.80', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:51:41', '2018-06-19 15:03:59');
INSERT INTO `t_ums_workflow_polish` VALUES ('186', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2071', '', '3#机器', '', '1534', '99.67', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:51:52', '2018-06-19 15:12:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('187', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2379', '', '3#机器', '', '1534', '99.80', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:52:00', '2018-06-19 15:13:00');
INSERT INTO `t_ums_workflow_polish` VALUES ('188', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1781', '', '3#机器', '', '1534', '99.61', '1534', 'DX1803013', '09-0080', '102850058', null, '9', '2018-06-13 15:52:10', '2018-06-19 15:13:37');
INSERT INTO `t_ums_workflow_polish` VALUES ('189', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q267', '', '3#机器', '', '1534', '98.83', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:52:23', '2018-06-19 15:14:33');
INSERT INTO `t_ums_workflow_polish` VALUES ('190', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q909', '', '3#机器', '', '1534', '99.93', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:52:33', '2018-06-19 15:15:04');
INSERT INTO `t_ums_workflow_polish` VALUES ('191', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2205', '', '3#机器', '', '1534', '99.74', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:52:41', '2018-06-19 15:15:33');
INSERT INTO `t_ums_workflow_polish` VALUES ('192', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2216', '', '3#机器', '', '1534', '99.67', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:52:49', '2018-06-19 15:17:15');
INSERT INTO `t_ums_workflow_polish` VALUES ('193', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2207', '', '3#机器', '', '1534', '99.93', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:53:42', '2018-06-19 15:17:55');
INSERT INTO `t_ums_workflow_polish` VALUES ('194', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1417', '', '3#机器', '', '1534', '99.87', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:53:50', '2018-06-19 15:18:26');
INSERT INTO `t_ums_workflow_polish` VALUES ('195', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1349', '', '3#机器', '', '1534', '99.93', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:54:01', '2018-06-19 15:19:08');
INSERT INTO `t_ums_workflow_polish` VALUES ('196', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2040', '', '3#机器', '', '1534', '99.87', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:54:14', '2018-06-19 15:19:35');
INSERT INTO `t_ums_workflow_polish` VALUES ('197', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1775', '', '3#机器', '', '1534', '99.93', '1534', 'DX1803014', '09-0080', '102850058', null, '9', '2018-06-13 15:54:24', '2018-06-19 15:20:10');
INSERT INTO `t_ums_workflow_polish` VALUES ('198', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1315', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803015', '09-0080', '102850058', null, '9', '2018-06-13 15:54:42', '2018-06-19 15:20:53');
INSERT INTO `t_ums_workflow_polish` VALUES ('199', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1849', '', '4#机器', '', '1534', '99.87', '1534', 'DX1803015', '09-0080', '102850058', null, '9', '2018-06-13 15:54:53', '2018-06-19 15:21:28');
INSERT INTO `t_ums_workflow_polish` VALUES ('200', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1415', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803015', '09-0080', ' 102850058', null, '9', '2018-06-19 15:26:31', '2018-06-19 15:56:14');
INSERT INTO `t_ums_workflow_polish` VALUES ('201', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1450', '', '4#机器', '', '1534', '100.00', '1534', 'DX1803015', '09-0080', ' 102850058', null, '9', '2018-06-19 15:26:59', '2018-06-19 15:55:58');
INSERT INTO `t_ums_workflow_polish` VALUES ('203', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2826', '', '4#机器', '', '1534', '99.87', '1534', 'DX1803015', '09-0080', ' 102850058', null, '9', '2018-06-19 15:27:42', '2018-06-19 15:55:41');
INSERT INTO `t_ums_workflow_polish` VALUES ('204', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1485', '', '4#机器', '', '1534', '99.87', '1534', 'DX1803015', '09-0080', ' 102850058', null, '9', '2018-06-19 15:28:03', '2018-06-19 15:55:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('205', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q359', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803015', '09-0080', ' 102850058', null, '9', '2018-06-19 15:28:20', '2018-06-19 15:55:02');
INSERT INTO `t_ums_workflow_polish` VALUES ('206', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q290', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803015', '09-0080', ' 102850058', null, '9', '2018-06-19 15:28:43', '2018-06-19 15:54:40');
INSERT INTO `t_ums_workflow_polish` VALUES ('207', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1382', '', '4#机器', '', '1534', '99.87', '1534', 'DX1803015', '09-0080', ' 102850058', null, '9', '2018-06-19 15:28:59', '2018-06-19 15:54:18');
INSERT INTO `t_ums_workflow_polish` VALUES ('209', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2022', '', '4#机器', '', '1534', '100.00', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:29:43', '2018-06-19 15:53:56');
INSERT INTO `t_ums_workflow_polish` VALUES ('211', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1235', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:30:39', '2018-06-19 15:53:33');
INSERT INTO `t_ums_workflow_polish` VALUES ('212', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2815', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:30:55', '2018-06-19 15:53:12');
INSERT INTO `t_ums_workflow_polish` VALUES ('213', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2161', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:31:09', '2018-06-19 15:52:52');
INSERT INTO `t_ums_workflow_polish` VALUES ('214', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2807', '', '4#机器', '', '1534', '99.87', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:31:44', '2018-06-19 15:51:46');
INSERT INTO `t_ums_workflow_polish` VALUES ('215', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q852', '', '4#机器', '', '1534', '99.93', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:32:01', '2018-06-19 15:51:21');
INSERT INTO `t_ums_workflow_polish` VALUES ('216', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q1311', '', '4#机器', '', '1534', '100.00', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:32:14', '2018-06-19 15:50:57');
INSERT INTO `t_ums_workflow_polish` VALUES ('217', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q2050', '', '4#机器', '', '1534', '99.80', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:32:33', '2018-06-19 15:50:29');
INSERT INTO `t_ums_workflow_polish` VALUES ('218', '2018-01-31', '2018-03-14', 'XC171120', '0000001534', 'Q987', '', '4#机器', '', '1534', '99.87', '1534', 'DX1803016', '09-0080', ' 102850058', null, '9', '2018-06-19 15:32:44', '2018-06-19 15:49:55');

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
  `raw_material` varchar(100) DEFAULT NULL COMMENT 'FIBER RAW MATERIAL',
  `in_put_date` date DEFAULT NULL COMMENT 'INPUT DATE',
  `coating_station` varchar(100) DEFAULT NULL COMMENT 'BIO 镀膜设备名称/每一个tray需要记录其对应在镀膜设备镀膜时放置的位置',
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
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `part_num` varchar(20) DEFAULT NULL COMMENT '零件号',
  `theory_yield` varchar(20) DEFAULT NULL COMMENT '理论良率',
  `actual_yield` varchar(20) DEFAULT NULL COMMENT '实际良率',
  `theory_actual_yield` varchar(20) DEFAULT NULL COMMENT '理论和实际良率比较',
  `operatorid` int(11) NOT NULL COMMENT '操作员id',
  `input_time` datetime NOT NULL COMMENT '录入时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cr_id`,`input_time`),
  KEY `idx_uwt_twicebiocoating_lot` (`lot`),
  KEY `idx_uwt_twicebiocoating_biopatnum` (`bio_pat_num`),
  KEY `idx_uwt_twicebiocoating_inputdate` (`in_put_date`),
  KEY `idx_uwt_twicebiocoating_operatorid` (`operatorid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='二次生化镀膜表'
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
-- Records of t_ums_workflow_twicebiocoating
-- ----------------------------
INSERT INTO `t_ums_workflow_twicebiocoating` VALUES ('3', '1806072', null, '18-0029', 'B10', 'N/A', 'XC171120', '2018-01-31', 'B-0011', '6', '3264', '', '', '', '3840', '0', '0', '0', '500', '76', 'T01 T16 T20 T21 T32 T40', null, '100.00', '85.0', '85.0', '9', '2018-07-17 14:33:48', '2018-07-19 16:06:19');
INSERT INTO `t_ums_workflow_twicebiocoating` VALUES ('4', '1806073', null, '18-0029', 'C11', 'N/A', 'XC171120', '2018-01-31', 'B-0187', '6', '3264', '', '', '', '3840', '0', '0', '0', '500', '76', 'T01 T16 T20 T21 T32 T40', null, '100.00', '85.0', '85.0', '9', '2018-07-19 15:57:33', '2018-07-19 16:05:23');

-- ----------------------------
-- Table structure for t_ums_workflow_twicebiocoating_reagents
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_twicebiocoating_reagents`;
CREATE TABLE `t_ums_workflow_twicebiocoating_reagents` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `reagents_field_name` varchar(50) DEFAULT NULL,
  `main_reagent` varchar(20) DEFAULT NULL COMMENT '混合试剂名称',
  `reagents_name` varchar(50) DEFAULT NULL COMMENT '混合试剂编号',
  `reagents_sn` varchar(50) DEFAULT NULL,
  KEY `idx_uwtr_reagents` (`cr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学混合试剂表'
/*!50100 PARTITION BY HASH (cr_id)
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
-- Records of t_ums_workflow_twicebiocoating_reagents
-- ----------------------------
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('2', 'reagentmixturetable209604_37', '04-0023', '02-0044', 'BG180416');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('2', 'reagentmixturetable209428_36', '03-0046', '01-0062', 'SI170815:4.6835|SI171003:0.0703');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('2', 'reagentmixturetable209429_28', '03-0005', '01-0002', 'SI180416');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('2', 'reagentmixturetable209430_29', '03-0005', '01-0011', 'XY170907:294  XY180420:506');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209604_37', '04-0023', '02-0044', 'BG180416');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209428_36', '03-0046', '01-0062', 'SI170815:4.6835|SI171003:0.0703');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209429_28', '03-0005', '01-0002', 'SI180416');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209430_29', '03-0005', '01-0011', 'XY170907:294  XY180420:506');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209426_38', '03-0047', '01-0009', 'SI170207');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209427_39', '03-0047', '01-0045', 'SI170704');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209425_40', '03-0047', '01-0048', 'SI170704');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('3', 'reagentmixturetable209424_41', '03-0047', '01-0063', 'SI170904');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209429_28', '03-0005', '01-0002', 'SI180416');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209430_29', '03-0005', '01-0011', 'XY170907:294  XY180420:506');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209428_36', '03-0046', '01-0062', 'SI170815:4.6835|SI171003:0.0703');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209604_37', '04-0023', '02-0044', 'BG180416');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209426_38', '03-0047', '01-0009', 'SI170207');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209427_39', '03-0047', '01-0045', 'SI170704');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209425_40', '03-0047', '01-0048', 'SI170704');
INSERT INTO `t_ums_workflow_twicebiocoating_reagents` VALUES ('4', 'reagentmixturetable209424_41', '03-0047', '01-0063', 'SI170904');

-- ----------------------------
-- Table structure for t_ums_workflow_twicebiocoating_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_ums_workflow_twicebiocoating_relation`;
CREATE TABLE `t_ums_workflow_twicebiocoating_relation` (
  `cr_id` int(11) NOT NULL COMMENT '化学试剂唯一标示',
  `tray_num` varchar(20) DEFAULT NULL COMMENT '组装站位的OUTPUT LOT#',
  `old_lot_num` varchar(20) DEFAULT NULL COMMENT 'old Lot#',
  `old_tray_num` varchar(20) DEFAULT NULL,
  `old_bio_pat_num` varchar(20) DEFAULT NULL,
  KEY `idx_uwtr_relation_crid` (`cr_id`) USING BTREE,
  KEY `idx_uwtr_relation_traynum` (`tray_num`),
  KEY `idx_uwtr_relation_oldlotnum` (`old_lot_num`),
  KEY `idx_uwtr_relation_oldtraynum` (`old_tray_num`),
  KEY `idx_uwtr_relation_oldbiopatnum` (`old_bio_pat_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='化学试剂与组装关系表'
/*!50100 PARTITION BY HASH (cr_id)
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
-- Records of t_ums_workflow_twicebiocoating_relation
-- ----------------------------
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T01', '1806011', 'T13', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T02', '1806011', 'T04', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T03', '1806011', 'T16', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T04', '1806011', 'T24', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T05', '1806011', 'T26', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T06', '1806011', 'T28', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T07', '1806011', 'T50', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T08', '1806011', 'T51', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T09', '1806011', 'T52', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T10', '1806011', 'T53', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T11', '1806011', 'T54', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T12', '1806011', 'T55', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T13', '1806011', 'T57', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T14', '1806011', 'T58', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T15', '1806011', 'T59', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T16', '1806011', 'T61', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T17', '1806011', 'T62', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T18', '1806011', 'T65', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T19', '1806011', 'T67', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T20', '1806011', 'T69', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T21', '1806011', 'T74', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T22', '1806011', 'T75', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T23', '1806011', 'T78', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('1', 'T24', '1806011', 'T79', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T01', '1806011', 'T13', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T02', '1806011', 'T04', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T03', '1806011', 'T16', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T04', '1806011', 'T24', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T05', '1806011', 'T26', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T06', '1806011', 'T28', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T07', '1806011', 'T50', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T08', '1806011', 'T51', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T09', '1806011', 'T52', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T10', '1806011', 'T53', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T11', '1806011', 'T54', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T12', '1806011', 'T55', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T13', '1806011', 'T57', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T14', '1806011', 'T58', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T15', '1806011', 'T59', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T16', '1806011', 'T61', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T17', '1806011', 'T62', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T18', '1806011', 'T65', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T19', '1806011', 'T67', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T20', '1806011', 'T69', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T21', '1806011', 'T74', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T22', '1806011', 'T75', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T23', '1806011', 'T78', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T24', '1806011', 'T79', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T25', '1806011', 'T97', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T26', '1806011', 'T99', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T27', '1806011', 'T100', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T28', '1806011', 'T101', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T29', '1806011', 'T103', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T30', '1806011', 'T104', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T31', '1806011', 'T105', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T32', '1806011', 'T106', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T33', '1806011', 'T107', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T34', '1806011', 'T108', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T35', '1806011', 'T109', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T36', '1806011', 'T110', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T37', '1806011', 'T112', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T38', '1806011', 'T116', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T39', '1806011', 'T117', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('2', 'T40', '1806011', 'T119', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T01', '1806011', 'T13', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T02', '1806011', 'T04', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T03', '1806011', 'T16', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T04', '1806011', 'T24', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T05', '1806011', 'T26', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T06', '1806011', 'T28', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T07', '1806011', 'T50', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T08', '1806011', 'T51', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T09', '1806011', 'T52', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T10', '1806011', 'T53', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T11', '1806011', 'T54', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T12', '1806011', 'T55', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T13', '1806011', 'T57', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T14', '1806011', 'T58', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T15', '1806011', 'T59', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T16', '1806011', 'T61', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T17', '1806011', 'T62', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T18', '1806011', 'T65', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T19', '1806011', 'T67', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T20', '1806011', 'T69', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T21', '1806011', 'T74', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T22', '1806011', 'T75', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T23', '1806011', 'T78', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T24', '1806011', 'T79', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T25', '1806011', 'T97', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T26', '1806011', 'T99', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T27', '1806011', 'T100', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T28', '1806011', 'T101', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T29', '1806011', 'T103', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T30', '1806011', 'T104', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T31', '1806011', 'T105', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T32', '1806011', 'T106', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T33', '1806011', 'T107', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T34', '1806011', 'T108', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T35', '1806011', 'T109', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T36', '1806011', 'T110', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T37', '1806011', 'T112', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T38', '1806011', 'T116', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T39', '1806011', 'T117', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('3', 'T40', '1806011', 'T119', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T01', '1806011', 'T02', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T02', '1806011', 'T03', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T03', '1806011', 'T05', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T04', '1806011', 'T06', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T05', '1806011', 'T07', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T06', '1806011', 'T08', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T07', '1806011', 'T11', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T08', '1806011', 'T21', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T09', '1806011', 'T22', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T10', '1806011', 'T23', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T11', '1806011', 'T25', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T12', '1806011', 'T27', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T13', '1806011', 'T32', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T14', '1806011', 'T41', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T15', '1806011', 'T42', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T16', '1806011', 'T43', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T17', '1806011', 'T44', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T18', '1806011', 'T45', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T19', '1806011', 'T46', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T20', '1806011', 'T47', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T21', '1806011', 'T48', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T22', '1806011', 'T49', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T23', '1806011', 'T66', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T24', '1806011', 'T68', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T25', '1806011', 'T70', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T26', '1806011', 'T71', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T27', '1806011', 'T72', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T28', '1806011', 'T81', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T29', '1806011', 'T82', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T30', '1806011', 'T83', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T31', '1806011', 'T84', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T32', '1806011', 'T85', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T33', '1806011', 'T86', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T34', '1806011', 'T90', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T35', '1806011', 'T91', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T36', '1806011', 'T92', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T37', '1806011', 'T94', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T38', '1806011', 'T113', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T39', '1806011', 'T114', '18-0009');
INSERT INTO `t_ums_workflow_twicebiocoating_relation` VALUES ('4', 'T40', '1806011', 'T115', '18-0009');

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

package com.pall.mts.common.constants;

public class KeyConstants {
	
	/*
	 * 菜单默认一级目录的父节点
	 */
	public static final int MENU_DEFAULT_ROOT_PARENTID=-1;
	
	/*
	 * 分页默认菜单根节点id
	 */
	public static final String DEFAULT_ROOT_MENU_ID="default/root/menuid";
	/*
	 * 分页默认角色根节点id
	 */
	public static final String DEFAULT_ROOT_ROLE_ID="default/root/roleid";
	/*
	 *excel结果集导出最大限制数
	 */
	public static final String EXCEL_EXPORT_RECORDS_LIMITS="excel/export/records/limits";
	/*
	 * 分页默认起始页号
	 */
	public static final int PAGE_DEFAULT_START_NO=1;
	/*
	 * 分页默认页大小
	 */
	public static final String PAGE_DEFAULT_PAGE_SIZE="paging/pagesize";
	/*
	 * 初始化excel样式配置对象时设置的标题栏配置名
	 */
	public static final String EXCEL_CELL_STYLE_HEADLINE_CONFIGNAME_XLSX="headline_xlsx";
	/*
	 * 初始化excel样式配置对象时设置的数据记录配置名
	 */
	public static final String EXCEL_CELL_STYLE_DATA_CONFIGNAME_XLSX="data_xlsx";
	/*
	 * 初始化excel样式配置对象时设置的标题栏配置名
	 */
	public static final String EXCEL_CELL_STYLE_HEADLINE_CONFIGNAME_XLS="headline_xls";
	/*
	 * 初始化excel样式配置对象时设置的数据记录配置名
	 */
	public static final String EXCEL_CELL_STYLE_DATA_CONFIGNAME_XLS="data_xls";
	
	/*
	 * execl文件后缀
	 */
	public static final String EXCEL_SUFFIX_XLSX=".xlsx";
	/*
	 * execl文件后缀
	 */
	public static final String EXCEL_SUFFIX_XLS=".xls";
	/*
	 * 权限表中button对应的righttype
	 */
	public static final String RIGHT_BUTTON_RIGHTTYPE="right/button/righttype";
	/*
	 * 权限表中menu对应的righttype
	 */
	public static final String RIGHT_MENU_RIGHTTYPE="right/menu/righttype";
	/*
	 * 数据配置表代表基础数据配置列表类型
	 */
	public static final String DATACONFIG_TYPE_LIST="dataconfig/type/list";
	/*
	 * 数据配置表代表part NO的配置类型 
	 */
	public static final String DATACONFIG_TYPE_PARTNUM="dataconfig/type/partNum";
	/*
	 * 数据配置表代表工作流数据配置列表类型
	 */
	public static final String DATACONFIG_TYPE_WORKFLOW="dataconfig/type/workflow";
	/*
	 * 数据配置表代表scrap info的配置类型
	 */
	public static final String DATACONFIG_TYPE_SCRAP_INFO="dataconfig/type/scrapinfo";
	/*
	 * 数据配置表代表remark的配置类型
	 */
	public static final String DATACONFIG_TYPE_REMARK="dataconfig/type/remark";
	/*
	 * 抛光流程配置表名
	 */
	public static final String POLISH_TABLENAME="polish/tablename";
	/*
	 * 抛光流程菜单id
	 */
	public static final String POLISH_MENUID="polish/menuid";
	/*
	 * 选择抛磨配置表名
	 */
	public static final String POLISHSEL_TABLENAME="polishSel/tablename";
	/*
	 * 数据配置表代表抛光模块polish Bom
	 */
	public static final String POLISH_DATACONFIG_TYPE_POLISHBOM="polish/dataconfig/type/polishBom";
	/*
	 * 数据配置表代表polish defect的配置类型
	 */
	public static final String POLISH_DATACONFIG_TYPE_DEFECT="polish/dataconfig/type/defect";
	/*
	 * 数据配置表代表throwMillstonePosition的配置类型
	 */
	public static final String POLISH_DATACONFIG_TYPE_THROWMILLSTONEPOS="polish/dataconfig/type/throwMillstonePosition";
	/*
	 * 抛光表工作面的缺损信息在数据配置表中的类型
	 */
	public static final String POLISH_DATACONFIG_TYPE_DEFECT_WF="polish/dataconfig/type/defect/workingface";
	/*
	 * 抛光表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String POLISH_DATACONFIG_TYPE_DEFECT_NWF="polish/dataconfig/type/defect/noworkingface";
	/*
	 * 抛光管理页面excel下载子目录名称
	 */
	public static final String POLISH_DOWNLOAD_SUBDIRECTORY="polish/download/subdirectory";
	/*
	 * 清洁流程配置表名
	 */
	public static final String CLEAN_TABLENAME="clean/tablename";
	/*
	 * 清洁流程菜单id
	 */
	public static final String CLEAN_MENUID="clean/menuid";
	/*
	 * 选择清洁配置表名
	 */
	public static final String CLEANSEL_TABLENAME="cleanSel/tablename";
	
	/*
	 * 数据配置表代表抛光模块Clean Bom
	 */
	public static final String CLEAN_DATACONFIG_TYPE_CLEANBOM="clean/dataconfig/type/cleanBom";
	/*
	 * 数据配置表代表clean defect的配置类型
	 */
	public static final String CLEAN_DATACONFIG_TYPE_DEFECT="clean/dataconfig/type/defect";
	
	/*
	 * 清洁表工作面的缺损信息在数据配置表中的类型
	 */
	public static final String CLEAN_DATACONFIG_TYPE_DEFECT_WF="clean/dataconfig/type/workingface";
	/*
	 * 清洁表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String CLEAN_DATACONFIG_TYPE_DEFECT_NWF="clean/dataconfig/type/noworkingface";
	
	/*
	 * 清洁管理页面excel下载子目录名称
	 */
	public static final String CLEAN_DOWNLOAD_SUBDIRECTORY="clean/download/subdirectory";
	/*
	 * 光学镀膜流程配置表名
	 */
	public static final String OPTICALFILMING_TABLENAME="opticalFilming/tablename";
	/*
	 * 光学镀膜流程菜单id
	 */
	public static final String OPTICALFILMING_MENUID="opticalFilming/menuid";
	/*
	 * 光学镀膜表Optical Coating BOM在数据配置表中的类型
	 */
	public static final String OPTICALFILMING_DATACONFIG_TYPE_OCBOM="opticalFilming/dataconfig/type/ocBom";
	/*
	 * 光学镀膜表供应商在数据配置表中的类型
	 */
	public static final String OPTICALFILMING_DATACONFIG_TYPE_SUPPLIER="opticalFilming/dataconfig/type/supplier";
	/*
	 * 数据配置表代表光学镀膜 defect的配置类型
	 */
	public static final String OPTICALFILMING_DATACONFIG_TYPE_DEFECT="opticalFilming/dataconfig/type/Defect";
	/*
	 * 光学镀膜表工作面的缺损信息在数据配置表中的类型
	 */
	public static final String OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF="opticalFilming/dataconfig/type/workingface";
	/*
	 * 光学镀膜表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF="opticalFilming/dataconfig/type/noworkingface";
	/*
	 * 光学镀膜管理页面excel下载子目录名称
	 */
	public static final String OPTICALFILMING_DOWNLOAD_SUBDIRECTORY="opticalFilming/download/subdirectory";
	/*
	 * 选择光学镀膜配置表名
	 */
	public static final String OPTICALFILMINGSEL_TABLENAME="opticalFilmingSel/tablename";
	/*
	 * 化学镀膜APS流程配置表名
	 */
	public static final String PLATEDFILM_TABLENAME="platedFilm/tablename";
	/*
	 * 化学镀膜APS流程菜单id
	 */
	public static final String PLATEDFILM_MENUID="platedFilm/menuid";
	/*
	 * 化学镀膜APS管理页面excel下载子目录名称
	 */
	public static final String PLATEDFILM_DOWNLOAD_SUBDIRECTORY="platedFilm/download/subdirectory";
	/*
	 * 化学镀膜APS数据配置表代表SF BOM的配置类型 
	 */
	public static final String PLATEDFILM_DATACONFIG_TYPE_SFBOMNUM="platedFilm/dataconfig/type/sfBomNum";
	/*
	 * 化学镀膜APS数据配置表代表APS condition的配置类型 
	 */
	public static final String PLATEDFILM_DATACONFIG_TYPE_APSCONDITION="platedFilm/dataconfig/type/apsCondition";

	/*
	 * 化学镀膜APS数据配置表代表fixture属性的配置类型 
	 */
	public static final String PLATEDFILM_DATACONFIG_TYPE_FIXTUREATTRIBUTE="platedFilm/dataconfig/type/fixtureAttribute";
	/*
	 * 组装流程配置表名
	 */
	public static final String ASSEMBLY_TABLENAME="assembly/tablename";
	/*
	 * 组装流程流程菜单id
	 */
	public static final String ASSEMBLY_MENUID="assembly/menuid";
	/*
	 * 数据配置表代表组装 defect的配置类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_DEFECT="assembly/dataconfig/type/defect";
	/*
	 * 组装表工作面的缺损信息在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_DEFECT_WF="assembly/dataconfig/type/workingface";
	/*
	 * 组装表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_DEFECT_NWF="assembly/dataconfig/type/noworkingface";
	/*
	 * 组装表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_DEFECT_CLAMPING="assembly/dataconfig/type/clamping";
	/*
	 * 组装表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_DEFECT_INSTALLHUB="assembly/dataconfig/type/installHub";
	/*
	 * 组装表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_DEFECT_OTHER="assembly/dataconfig/type/other";
	/*
	 *  组装表装夹操作员在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_CLAMPING_CP="assembly/dataconfig/type/clampingCP";
	/*
	 *  组装表拆夹操作员在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_CLAMP_DOWN_THE_CP="assembly/dataconfig/type/clampDownTheCP";
	/*
	 *  组装表Assembly bom在数据配置表中的类型
	 */
	public static final String ASSEMBLY_DATACONFIG_TYPE_ASSEMBLY_BOMS="assembly/dataconfig/type/assemblyBoms";
	/*
	 * 组装管理页面excel下载子目录名称
	 */
	public static final String ASSEMBLY_DOWNLOAD_SUBDIRECTORY="assembly/download/subdirectory";
	
	/*
	 * 混合试剂主试剂在数据配置表中的类型
	 */
	public static final String REAGENTMIXTURE_DATACONFIG_TYPE_MAINREAGENT="reagentMixture/dataconfig/type/mainReagent";
	/*
	 * 混合试剂子试剂在数据配置表中的类型
	 */
	public static final String REAGENTMIXTURE_DATACONFIG_TYPE_SUBREAGENT="reagentMixture/dataconfig/type/subReagent";
	/*
	 * 混合试剂主试剂配置表名
	 */
	public static final String REAGENTMIXTURE_TABLENAME="reagentMixture/tablename";
	
	/*
	 * 生物镀膜BIO流程配置表名
	 */
	public static final String CHEMICALREAGENT_TABLENAME="chemicalReagent/tablename";
	/*
	 * 生物镀膜BIO流程菜单id
	 */
	public static final String CHEMICALREAGENT_MENUID="chemicalReagent/menuid";
	/*
	 * 生物镀膜BIO管理页面excel下载子目录名称
	 */
	public static final String CHEMICALREAGENT_DOWNLOAD_SUBDIRECTORY="chemicalReagent/download/subdirectory";
	/*
	 * 数据配置表代表化学试剂配置类型
	 */
	public static final String CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT="chemicalReagent/dataconfig/type/chemicalReagent";
	/*
	 * 生物镀膜BIO BOM在数据配置表中的类型
	 */
	public static final String CHEMICALREAGENT_DATACONFIG_TYPE_BIOBOM="chemicalReagent/dataconfig/type/bioBom";
	/*
	 *生物镀膜BIO Pat Number在数据配置表中的类型
	 */
	public static final String CHEMICALREAGENT_DATACONFIG_TYPE_BIOPATNUM="chemicalReagent/dataconfig/type/bioPatNum";
	/*
	 * 生物镀膜操作人员1在数据配置表中的类型
	 */
	public static final String CHEMICALREAGENT_DATACONFIG_TYPE_COP1="chemicalReagent/dataconfig/type/crOperator1";
	/*
	 * 生物镀膜操作人员2在数据配置表中的类型
	 */
	public static final String CHEMICALREAGENT_DATACONFIG_TYPE_COP2="chemicalReagent/dataconfig/type/crOperator2";
	/*
	 * 生物镀膜FIBER RAW MATERIAL在数据配置表中的类型
	 */
	public static final String CHEMICALREAGENT_DATACONFIG_TYPE_RAWMATERIAL="chemicalReagent/dataconfig/type/rawMaterial";
	/*
	 * 生物镀膜Coating Station在数据配置表中的类型
	 */
	public static final String CHEMICALREAGENT_DATACONFIG_TYPE_COATINGSTATION="chemicalReagent/dataconfig/type/coatingStation";
	/*
	 * t_ums_th_config表中生化镀膜配置汇合试剂属性名
	 */
	public static final String CHEMICALREAGENT_THCONFIG_REAGENTMIXTURE="chemicalReagent/thConfig/reagentMixture";
	/*
	 * 生物镀膜BIO流程配置表名
	 */
	public static final String TWICE_CHEMICALREAGENT_TABLENAME="twicechemicalReagent/tablename";
	/*
	 * 二次生物镀膜BIO流程菜单id
	 */
	public static final String TWICE_CHEMICALREAGENT_MENUID="twicechemicalReagent/menuid";
	/*
	 * 生物镀膜BIO管理页面excel下载子目录名称
	 */
	public static final String TWICE_CHEMICALREAGENT_DOWNLOAD_SUBDIRECTORY="twicechemicalReagent/download/subdirectory";
	/*
	 * 数据配置表代表化学试剂配置类型
	 */
	public static final String TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT="twicechemicalReagent/dataconfig/type/chemicalReagent";
	/*
	 * 生物镀膜BIO BOM在数据配置表中的类型
	 */
	public static final String TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_BIOBOM="twicechemicalReagent/dataconfig/type/bioBom";
	/*
	 *生物镀膜BIO Pat Number在数据配置表中的类型
	 */
	public static final String TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_BIOPATNUM="twicechemicalReagent/dataconfig/type/bioPatNum";
	/*
	 * 生物镀膜操作人员1在数据配置表中的类型
	 */
	public static final String TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_COP1="twicechemicalReagent/dataconfig/type/crOperator1";
	/*
	 * 生物镀膜操作人员2在数据配置表中的类型
	 */
	public static final String TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_COP2="twicechemicalReagent/dataconfig/type/crOperator2";
	/*
	 * 生物镀膜FIBER RAW MATERIAL在数据配置表中的类型
	 */
	public static final String TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_RAWMATERIAL="twicechemicalReagent/dataconfig/type/rawMaterial";
	/*
	 * 生物镀膜Coating Station在数据配置表中的类型
	 */
	public static final String TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_COATINGSTATION="twicechemicalReagent/dataconfig/type/coatingStation";
	/*
	 * t_ums_th_config表中二次生化镀膜配置汇合试剂属性名
	 */
	public static final String TWICE_CHEMICALREAGENT_THCONFIG_REAGENTMIXTURE="twicechemicalReagent/thConfig/reagentMixture";
	/*
	 * 组装报废汇总配置表名
	 */
	public static final String REPORT_ASSEMBLY_SCRAP_SUMMARY_TABLENAME="report/assemblyScrapSummary/tablename";
	/*
	 * 产出数量追踪配置表名
	 */
	public static final String REPORT_PRODUCTTRACKING_TABLENAME="report/productTracking/tablename";
	/*
	 * 组装报废汇总页面excel下载子目录名称
	 */
	public static final String REPORT_ASSEMBLY_SCRAP_SUMMARY_DOWNLOAD_SUBDIRECTORY="report/assemblyScrapSummary/download/subdirectory";
}

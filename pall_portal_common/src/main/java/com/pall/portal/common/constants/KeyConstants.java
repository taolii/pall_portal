package com.pall.portal.common.constants;

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
	 * 清洗流程配置表名
	 */
	public static final String CLEAN_TABLENAME="clean/tablename";
	/*
	 * 选择清洗配置表名
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
	 * 清洗表工作面的缺损信息在数据配置表中的类型
	 */
	public static final String CLEAN_DATACONFIG_TYPE_DEFECT_WF="clean/dataconfig/type/workingface";
	/*
	 * 清洗表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String CLEAN_DATACONFIG_TYPE_DEFECT_NWF="clean/dataconfig/type/noworkingface";
	
	/*
	 * 清洗管理页面excel下载子目录名称
	 */
	public static final String CLEAN_DOWNLOAD_SUBDIRECTORY="clean/download/subdirectory";
	/*
	 * 光学镀膜流程配置表名
	 */
	public static final String OPTICALFILMING_TABLENAME="opticalFilming/tablename";
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
	 * 数据配置表代表组装 defect的配置类型
	 */
	public static final String DATACONFIG_TYPE_ASSEMBLY_DEFECT="dataconfig/type/assemblyDefect";
	/*
	 * 数据配置表代表化学试剂配置类型
	 */
	public static final String DATACONFIG_TYPE_CHEMICAL_REAGENT="dataconfig/type/chemicalReagent";
	
	/*
	 * 光学镀膜流程配置表名
	 */
	public static final String WORKFLOW_PLATEDFILM_TABLENAME="workflow/PlatedFilm/tablename";
	/*
	 * 光学镀膜管理页面excel下载子目录名称
	 */
	public static final String PLATEDFILM_DOWNLOAD_SUBDIRECTORY="platedFilm/download/subdirectory";
	
	/*
	 * 组装流程配置表名
	 */
	public static final String WORKFLOW_ASSEMBLY_TABLENAME="workflow/assembly/tablename";
	/*
	 * 组装表工作面的缺损信息在数据配置表中的类型
	 */
	public static final String DATACONFIG_TYPE_ASSEMBLY_DEFECT_WF="dataconfig/type/assemblyDefect/workingface";
	/*
	 * 组装表非工作面的缺损信息在数据配置表中的类型
	 */
	public static final String DATACONFIG_TYPE_ASSEMBLY_DEFECT_NWF="dataconfig/type/assemblyDefect/noworkingface";
	/*
	 * 组装管理页面excel下载子目录名称
	 */
	public static final String ASSEMBLY_DOWNLOAD_SUBDIRECTORY="assembly/download/subdirectory";
	/*
	 * 化学试剂流程配置表名
	 */
	public static final String WORKFLOW_CHEMICALREAGENT_TABLENAME="workflow/chemicalReagent/tablename";
	/*
	 * 化学试剂管理页面excel下载子目录名称
	 */
	public static final String CHEMICALREAGENT_DOWNLOAD_SUBDIRECTORY="chemicalReagent/download/subdirectory";
	
}

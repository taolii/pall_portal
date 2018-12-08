package com.pall.wdpts.common.constants;

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
	 * Excel插入符号类型
	 */
	public static final int EXCEL_INSERT_SYMBOL_TYPE=4;
	/*
	 * Excel插入拨码类型
	 */
	public static final int EXCEL_INSERT_DAILSWITCH_TYPE=5;
	public static final int EXCEL_INSERT_DAILSWITCH_EXPORT_TYPE=10;
	/*
	 * Excel插入符号类型
	 */
	public static final int[] EXCEL_INSERT_SYMBOL_TYPE_CHECK={0x2611,0x2610};
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
	 * DSP装配流程跟踪单流程菜单id
	 */
	public static final String TRACKINGLIST_DSP_MENUID="tracklinglist/dsp/menuid";
	/*
	 * DSP装配流程跟踪单流程配置表名
	 */
	public static final String TRACKINGLIST_DSP_TABLENAME="tracklinglist/dsp/tablename";
	/*
	 * DSP装配流程跟踪单流程导出模板
	 */
	public static final String TRACKINGLIST_DSP_TEMPLATENAME="tracklinglist/dsp/templatename";
	/*
	 * DSP装配流程跟踪单流程下载子目录名称
	 */
	public static final String TRACKINGLIST_DSP_DOWNLOAD_SUBDIRECTORY="trackinglist/dsp/download/subdirectory";
	
	/*
	 * 水箱装配流程跟踪单流程菜单id
	 */
	public static final String TRACKINGLIST_CISTERN_MENUID="tracklinglist/cistern/menuid";
	/*
	 * 水箱装配流程跟踪单流程配置表名
	 */
	public static final String TRACKINGLIST_CISTERN_TABLENAME="tracklinglist/cistern/tablename";
	/*
	 * 水箱装配流程跟踪单流程导出模板
	 */
	public static final String TRACKINGLIST_CISTERN_TEMPLATENAME="tracklinglist/cistern/templatename";
	/*
	 * 水箱装配流程跟踪单流程下载子目录名称
	 */
	public static final String TRACKINGLIST_CISTERN_DOWNLOAD_SUBDIRECTORY="trackinglist/cistern/download/subdirectory";
	
	/*
	 * 预处理装配流程跟踪单流程菜单id
	 */
	public static final String TRACKINGLIST_PREPROCESSING_MENUID="tracklinglist/preprocessing/menuid";
	/*
	 * 预处理装配流程跟踪单流程配置表名
	 */
	public static final String TRACKINGLIST_PREPROCESSING_TABLENAME="tracklinglist/preprocessing/tablename";
	/*
	 * 预处理装配流程跟踪单流程导出模板
	 */
	public static final String TRACKINGLIST_PREPROCESSING_TEMPLATENAME="tracklinglist/preprocessing/templatename";
	/*
	 * 预处理装配流程跟踪单流程下载子目录名称
	 */
	public static final String TRACKINGLIST_PREPROCESSING_DOWNLOAD_SUBDIRECTORY="trackinglist/preprocessing/download/subdirectory";
	/*
	 * 预处理装配流程跟踪单word模板assemble配置信息 起始行_属性key|属性key 属性key数量和table表格列数相同
	 */
	public static final String TRACKINGLIST_PREPROCESSING_WORD_ASSEMBLECONFIG="trackinglist/preprocessing/word/assembleConfig";
	
	/*
	 * 主机装配流程跟踪单流程菜单id
	 */
	public static final String TRACKINGLIST_MAINFRAME_MENUID="tracklinglist/mainFrame/menuid";
	/*
	 * 主机装配流程跟踪单流程配置表名
	 */
	public static final String TRACKINGLIST_MAINFRAME_TABLENAME="tracklinglist/mainFrame/tablename";
	/*
	 * 主机装配流程跟踪单流程导出模板
	 */
	public static final String TRACKINGLIST_MAINFRAME_TEMPLATENAME="tracklinglist/mainFrame/templatename";
	/*
	 * 主机装配流程跟踪单流程下载子目录名称
	 */
	public static final String TRACKINGLIST_MAINFRAME_DOWNLOAD_SUBDIRECTORY="trackinglist/mainFrame/download/subdirectory";
	/*
	 * DSP配置_DSP型号/Model
	 */
	public static final String SETTING_DSP_DATACONFIG_TYPE_DSPMODEL="setting/dsp/dataconfig/type/dspModel";
	/*
	 * 水箱配置_水箱型号/Model
	 */
	public static final String SETTING_CISTERN_DATACONFIG_TYPE_CISTERNMODEL="setting/cistern/dataconfig/type/cisternModel";
	/*
	 * 预处理配置_名称/Model
	 */
	public static final String SETTING_PREPROCESSING_DATACONFIG_TYPE_PREPROCESSINGMODEL="setting/preprocessing/dataconfig/type/preprocessingModel";
	/*
	 * 主机_主机型号/Model
	 */
	public static final String SETTING_MAINFRAME_DATACONFIG_TYPE_MAINFRAMEMODEL="setting/mainframe/dataconfig/type/mainframeModel";
	
}

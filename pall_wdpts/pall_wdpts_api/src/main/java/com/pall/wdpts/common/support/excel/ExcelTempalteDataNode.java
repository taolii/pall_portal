package com.pall.wdpts.common.support.excel;

import java.util.List;
import java.util.Map;

/*
 * Excel Tempalte对象信息
 */
public class ExcelTempalteDataNode{
	/*
	 * Excel Tempalte替换信息,不包括新添加行数据
	 */
	private Map<String, String> replaceTemplateDatas;
	/*
	 * Excel Tempalte表格替换信息,新增行记录
	 */
	private Map<String,List<Map<String, String>>> newAddRowDatas;
	
	public Map<String, String> getReplaceTemplateDatas() {
		return replaceTemplateDatas;
	}
	public void setReplaceTemplateDatas(Map<String, String> replaceTemplateDatas) {
		this.replaceTemplateDatas = replaceTemplateDatas;
	}
	public Map<String, List<Map<String, String>>> getNewAddRowDatas() {
		return newAddRowDatas;
	}
	public void setNewAddRowDatas(Map<String, List<Map<String, String>>> newAddRowDatas) {
		this.newAddRowDatas = newAddRowDatas;
	}
	
 }  
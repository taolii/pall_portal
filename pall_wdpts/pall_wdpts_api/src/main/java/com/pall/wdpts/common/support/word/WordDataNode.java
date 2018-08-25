package com.pall.wdpts.common.support.word;

import java.util.List;
import java.util.Map;

/*
 * word对象信息
 */
public class WordDataNode{
	/*
	 * word文档替换信息,不包括表格行数据
	 */
	private Map<String, String> documentDatas;
	/*
	 * word表格替换信息
	 */
	private Map<String,List<Map<String, String>>> tableRowsDatas;
	public Map<String, String> getDocumentDatas() {
		return documentDatas;
	}
	public void setDocumentDatas(Map<String, String> documentDatas) {
		this.documentDatas = documentDatas;
	}
	public Map<String, List<Map<String, String>>> getTableRowsDatas() {
		return tableRowsDatas;
	}
	public void setTableRowsDatas(Map<String, List<Map<String, String>>> tableRowsDatas) {
		this.tableRowsDatas = tableRowsDatas;
	}
 }  

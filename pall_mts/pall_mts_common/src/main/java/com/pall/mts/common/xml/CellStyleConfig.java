package com.pall.mts.common.xml;

import javax.xml.bind.annotation.XmlRootElement;

/*
 * 单元格样式配置对象
 */
@XmlRootElement(name="cellStyleConfig") 
public class CellStyleConfig {
	/*
	 * excel头部样式配置
	 */
	private CellXMLStyleConfig headlineStyleConfig;
	/*
	 * excel数据记录样式配置
	 */
	private CellXMLStyleConfig cellDataStyleConfig;
	public CellXMLStyleConfig getHeadlineStyleConfig() {
		return headlineStyleConfig;
	}
	public void setHeadlineStyleConfig(CellXMLStyleConfig headlineStyleConfig) {
		this.headlineStyleConfig = headlineStyleConfig;
	}
	public CellXMLStyleConfig getCellDataStyleConfig() {
		return cellDataStyleConfig;
	}
	public void setCellDataStyleConfig(CellXMLStyleConfig cellDataStyleConfig) {
		this.cellDataStyleConfig = cellDataStyleConfig;
	}
	
}

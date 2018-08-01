package com.pall.wdpts.common.xml;

import javax.xml.bind.annotation.XmlRootElement;

/*
 * 单元格数据样式配置对象
 */
@XmlRootElement(name="cellXMLStyleConfig") 
public class CellXMLStyleConfig {
	/*
	 * 单元格字体样式配置
	 */
	private CellFontStyleConfig cellFontStyleConfig;
	/*
	 * 单元格内容居中
	 */
	private String alignment;
	/*
	 * 边框颜色
	 */
	private String bottomBorderColor;
	/*
	 * 单元格背景色
	 */
	private String fillBackgroundColor;
	/*
	 * 单元格前景色
	 */
	private String fillForegroundColor;
	/*
	 * 垂直对齐方式
	 */
	private String verticalAlignment;
	/*
	 * 是否自动换行
	 */
	private String wrapText;
	/*
	 * 下边框大小
	 */
	private String borderBottom;
	/*
	 * 上边框大小
	 */
	private String borderTop;
	/*
	 * 右边框大小
	 */
	private String borderRight;
	/*
	 * 左边框大小
	 */
	private String borderLeft;
	
	public CellFontStyleConfig getCellFontStyleConfig() {
		return cellFontStyleConfig;
	}
	public void setCellFontStyleConfig(CellFontStyleConfig cellFontStyleConfig) {
		this.cellFontStyleConfig = cellFontStyleConfig;
	}
	public String getAlignment() {
		return alignment;
	}
	public void setAlignment(String alignment) {
		this.alignment = alignment;
	}
	public String getBottomBorderColor() {
		return bottomBorderColor;
	}
	public void setBottomBorderColor(String bottomBorderColor) {
		this.bottomBorderColor = bottomBorderColor;
	}
	public String getFillBackgroundColor() {
		return fillBackgroundColor;
	}
	public void setFillBackgroundColor(String fillBackgroundColor) {
		this.fillBackgroundColor = fillBackgroundColor;
	}
	public String getFillForegroundColor() {
		return fillForegroundColor;
	}
	public void setFillForegroundColor(String fillForegroundColor) {
		this.fillForegroundColor = fillForegroundColor;
	}
	public String getVerticalAlignment() {
		return verticalAlignment;
	}
	public void setVerticalAlignment(String verticalAlignment) {
		this.verticalAlignment = verticalAlignment;
	}
	public String getWrapText() {
		return wrapText;
	}
	public void setWrapText(String wrapText) {
		this.wrapText = wrapText;
	}
	public String getBorderBottom() {
		return borderBottom;
	}
	public void setBorderBottom(String borderBottom) {
		this.borderBottom = borderBottom;
	}
	public String getBorderTop() {
		return borderTop;
	}
	public void setBorderTop(String borderTop) {
		this.borderTop = borderTop;
	}
	public String getBorderRight() {
		return borderRight;
	}
	public void setBorderRight(String borderRight) {
		this.borderRight = borderRight;
	}
	public String getBorderLeft() {
		return borderLeft;
	}
	public void setBorderLeft(String borderLeft) {
		this.borderLeft = borderLeft;
	}
	
}

package com.pall.wdpts.common.xml;

import javax.xml.bind.annotation.XmlRootElement;

/*
 * 单元格字体样式配置对象
 */
@XmlRootElement(name="cellFontStyleConfig") 
public class CellFontStyleConfig {
	/*
	 * 字体大小
	 */
	private String fontHeightInPoints;
	/*
	 * 字体格式
	 */
	private String fontName;
	/*
	 * 字体颜色
	 */
	private String color;
	public String getFontHeightInPoints() {
		return fontHeightInPoints;
	}
	public void setFontHeightInPoints(String fontHeightInPoints) {
		this.fontHeightInPoints = fontHeightInPoints;
	}
	public String getFontName() {
		return fontName;
	}
	public void setFontName(String fontName) {
		this.fontName = fontName;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
}

package com.pall.portal.init;

import java.io.IOException;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.alibaba.druid.util.StringUtils;
import com.google.common.io.Files;
import com.pall.portal.common.constants.KeyConstants;
import com.pall.portal.common.xml.CellFontStyleConfig;
import com.pall.portal.common.xml.CellStyleConfig;
import com.pall.portal.common.xml.CellXMLStyleConfig;

/*
 * excel样式配置初始化器
 * 暂时不支持
 */
//@Component
public class CellStyleConfigInitiator {
	/*
	 * 系统日志
	 */
	private final static Logger logger = LoggerFactory.getLogger(CellStyleConfigInitiator.class);  
	/*
	 * excel样式配置对象
	 */
	private static CellStyleConfig cellStyleConfig;
	private static Map<String,CellStyle> cellStyleConfigMap=new ConcurrentHashMap<String,CellStyle>();
	private static Map<String,HorizontalAlignment> horizontalAlignmentMap=new ConcurrentHashMap<String,HorizontalAlignment>();
	private static Map<String,VerticalAlignment> verticalAlignmentMap=new ConcurrentHashMap<String,VerticalAlignment>();
	static{
		horizontalAlignmentMap.put("center", HorizontalAlignment.CENTER);
		horizontalAlignmentMap.put("center_selection", HorizontalAlignment.CENTER_SELECTION);
		horizontalAlignmentMap.put("distributed", HorizontalAlignment.DISTRIBUTED);
		horizontalAlignmentMap.put("fill", HorizontalAlignment.FILL);
		horizontalAlignmentMap.put("general", HorizontalAlignment.GENERAL);
		horizontalAlignmentMap.put("justify", HorizontalAlignment.JUSTIFY);
		horizontalAlignmentMap.put("left", HorizontalAlignment.LEFT);
		horizontalAlignmentMap.put("right", HorizontalAlignment.RIGHT);
		
		verticalAlignmentMap.put("bottom", VerticalAlignment.BOTTOM);
		verticalAlignmentMap.put("center", VerticalAlignment.CENTER);
		verticalAlignmentMap.put("distributed", VerticalAlignment.DISTRIBUTED);
		verticalAlignmentMap.put("justify", VerticalAlignment.JUSTIFY);
		verticalAlignmentMap.put("top", VerticalAlignment.TOP);
	}
	/*
	 * 初始化
	 */
	//@PostConstruct
	public void initialize(){
		Resource configStyleResource=new ClassPathResource("config/source/xml/export_excel_style.xml");
		String configStyleXml="";
		try{
			configStyleXml= Files.toString(configStyleResource.getFile(), Charset.forName("UTF-8"));
		}catch(IOException e){
			logger.error("acquire cell style config file exception:",e);
			return;
		}
		JAXBContext jc;
		try {
			jc = JAXBContext.newInstance(CellStyleConfig.class);  
			Unmarshaller unmar = jc.createUnmarshaller();  
			cellStyleConfig = (CellStyleConfig) unmar.unmarshal(new StringReader(configStyleXml)); 
		} catch (JAXBException e) {
			logger.error("acquire cell style config  exception when xml transform cellStyleConfig Object:",e);
			return;
		} 
	}
	/*
	 * 获取单元格样式
	 * @param cellTypeName 样式类型名 (头部样式名:headline和数据记录名 data)
	 * @param defaultCellStyle 默认单元格样式对象
	 * @return
	 */
	public static CellStyle getCellStyle(String cellTypeName,CellStyle defaultCellStyle,Font defaultFont){
		 CellStyle configCellStyle=cellStyleConfigMap.get(cellTypeName);
		 if(true){
			 configCellStyle=defaultCellStyle;
			 if(KeyConstants.EXCEL_CELL_STYLE_HEADLINE_CONFIGNAME_XLSX.equals(cellTypeName)||
					 KeyConstants.EXCEL_CELL_STYLE_HEADLINE_CONFIGNAME_XLS.equals(cellTypeName)){
				 CellXMLStyleConfig cellHeadLineStyleConfig=cellStyleConfig.getHeadlineStyleConfig();
				 if(null!=cellHeadLineStyleConfig){
					 configCellStyle=getConfigCellStyle(configCellStyle,defaultFont,cellHeadLineStyleConfig);
				 }
			 }else{
				 CellXMLStyleConfig cellDataStyleConfig=cellStyleConfig.getCellDataStyleConfig();
				 if(null!=cellDataStyleConfig){
					 configCellStyle=getConfigCellStyle(configCellStyle,defaultFont,cellDataStyleConfig);
				 }
			 }
			 configCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			/* configCellStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
			 configCellStyle.setFillBackgroundColor(HSSFColor.SKY_BLUE.index);
			 
			 configCellStyle.setBorderBottom(BorderStyle.valueOf((short)1));
			 configCellStyle.setBorderTop(BorderStyle.valueOf((short)1));  
			 configCellStyle.setBorderRight(BorderStyle.valueOf((short)1));  
			 configCellStyle.setBorderBottom(BorderStyle.valueOf((short)1));  
			 configCellStyle.setBorderLeft(BorderStyle.valueOf((short)1));  
			 
			 configCellStyle.setAlignment(HorizontalAlignment.CENTER);
			 configCellStyle.setBottomBorderColor(HSSFColor.GREEN.index);
			 configCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);;
			 configCellStyle.setWrapText(true);// 指定单元格自动换行   
*/
			 cellStyleConfigMap.put(cellTypeName, configCellStyle);
		 };
		return configCellStyle;
	}
	/*
	 * 封装单元格样式
	 * @param cellTypeName 样式类型名 (头部样式名:headline和数据记录名 data)
	 * @param defaultCellStyle 默认单元格样式对象
	 * @return
	 */
	private static CellStyle getConfigCellStyle(CellStyle configCellStyle,Font defaultFont,CellXMLStyleConfig cellXMLStyleConfig){
		try{
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getAlignment()) && null!=horizontalAlignmentMap.get(cellXMLStyleConfig.getAlignment().toLowerCase())){
				 configCellStyle.setAlignment(horizontalAlignmentMap.get(cellXMLStyleConfig.getAlignment().toLowerCase()));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getBottomBorderColor())){
				 configCellStyle.setBottomBorderColor(Short.parseShort(cellXMLStyleConfig.getBottomBorderColor()));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getFillBackgroundColor())){
				 configCellStyle.setFillBackgroundColor(Short.parseShort(cellXMLStyleConfig.getFillBackgroundColor()));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getFillForegroundColor())){
				 configCellStyle.setFillForegroundColor(Short.parseShort(cellXMLStyleConfig.getFillForegroundColor()));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getVerticalAlignment()) && null!=verticalAlignmentMap.get(cellXMLStyleConfig.getAlignment().toLowerCase())){
				 configCellStyle.setVerticalAlignment(verticalAlignmentMap.get(cellXMLStyleConfig.getAlignment().toLowerCase()));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getBorderBottom()) && StringUtils.isNumber(cellXMLStyleConfig.getBorderBottom())){
				 configCellStyle.setBorderBottom(BorderStyle.valueOf(Short.parseShort(cellXMLStyleConfig.getBorderBottom())));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getBorderLeft()) && StringUtils.isNumber(cellXMLStyleConfig.getBorderLeft())){
				 configCellStyle.setBorderLeft(BorderStyle.valueOf(Short.parseShort(cellXMLStyleConfig.getBorderLeft())));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getBorderRight()) && StringUtils.isNumber(cellXMLStyleConfig.getBorderRight())){
				 configCellStyle.setBorderRight(BorderStyle.valueOf(Short.parseShort(cellXMLStyleConfig.getBorderRight())));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getBorderTop()) && StringUtils.isNumber(cellXMLStyleConfig.getBorderTop())){
				 configCellStyle.setBorderTop(BorderStyle.valueOf(Short.parseShort(cellXMLStyleConfig.getBorderTop())));
			 }
			 if(!StringUtils.isEmpty(cellXMLStyleConfig.getWrapText())){
				 configCellStyle.setWrapText(Boolean.parseBoolean(cellXMLStyleConfig.getWrapText()));
			 }
			 CellFontStyleConfig cellFontStyleConfig=cellXMLStyleConfig.getCellFontStyleConfig();
			 if(cellFontStyleConfig!=null){
				 configCellStyle.setFont(defaultFont);
				 if(!StringUtils.isEmpty(cellFontStyleConfig.getColor())&& StringUtils.isNumber(cellFontStyleConfig.getColor())){
					 defaultFont.setColor(Short.parseShort(cellFontStyleConfig.getColor()));
				 }
				 if(!StringUtils.isEmpty(cellFontStyleConfig.getFontHeightInPoints())&& StringUtils.isNumber(cellFontStyleConfig.getFontHeightInPoints())){
					 defaultFont.setFontHeightInPoints(Short.parseShort(cellFontStyleConfig.getFontHeightInPoints()));
				 }
				 if(!StringUtils.isEmpty(cellFontStyleConfig.getFontName())){
					 defaultFont.setFontName(cellFontStyleConfig.getFontName());
				 }
			 }
		}catch(Exception e){
			logger.error("parse excel style config xml exception:",e);
		}
		 return configCellStyle;
	}
}

package com.pall.wdpts.common.tools;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.ReflectionUtils;

import com.alibaba.druid.util.StringUtils;
import com.pall.wdpts.common.support.excel.ExcelDataNode;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
import com.pall.wdpts.init.TableDataConfigInitiator;
import com.pall.wdpts.repository.entity.workflow.ChemicalCompoundReagentsEntity;
import com.pall.wdpts.repository.entity.workflow.DefectEntity;

public class ExcelTools {
	/*
	 * 封装Excel数据信息
	 * @param tableName 表格对应的配置表名
	 * @param objEntitys需要遍历的对象信息
	 * @param currentRowNum excel写入记录的行位置
	 * @return 
	 */
	public static Map<Integer,List<ExcelDataNode>> getExcelDatas(String tableName,List<?> objEntitys,int currentRowNum){
		Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
		Map<String,ExcelHeaderNode> fieldNameBindMap=TableDataConfigInitiator.getExcelFieldBindConfig(tableName);
	   	 for(Object objEntity:objEntitys){
	   		 List<ExcelDataNode> excelDataNodes=new ArrayList<ExcelDataNode>();
	   		 Map<String,Field> fieldMap=ReflectUtils.getBeanPropertyFields(objEntity.getClass());
	   		 if(fieldMap!=null && fieldMap.size()>0){
	   			 for(String fieldName:fieldMap.keySet()){
	   				fieldMap.get(fieldName).setAccessible(true); 
	   				if(ReflectUtils.isPrimitive(fieldMap.get(fieldName).getType()) && null!=fieldNameBindMap.get(fieldName)){
		   				ExcelDataNode excelDataNode=new ExcelDataNode();
		   				excelDataNode.setColNum(fieldNameBindMap.get(fieldName).getColNum());
		   				Object obj=ReflectionUtils.getField(fieldMap.get(fieldName), objEntity);
		   				excelDataNode.setData(obj==null?"":String.valueOf(obj));
			        	excelDataNodes.add(excelDataNode);
		   			 }else if(fieldMap.get(fieldName).getType() == java.util.List.class){
		   				 if(fieldMap.get(fieldName).getGenericType() instanceof ParameterizedType){
		   					ParameterizedType pt = (ParameterizedType)fieldMap.get(fieldName).getGenericType();
		   					if(pt!=null &&  pt.getActualTypeArguments()!=null && pt.getActualTypeArguments().length>0){
		   						if(pt.getActualTypeArguments()[0]==ChemicalCompoundReagentsEntity.class){
		   							List<ChemicalCompoundReagentsEntity> chemicalCompoundReagents=(List<ChemicalCompoundReagentsEntity>)ReflectionUtils.getField(fieldMap.get(fieldName), objEntity);
		   							if(chemicalCompoundReagents!=null){
		   								for(ChemicalCompoundReagentsEntity ChemicalCompoundReagentsEntity:chemicalCompoundReagents){
		   									//if(StringUtils.isEmpty(ChemicalCompoundReagentsEntity.getCompoundReagentsName()))continue;
				   							/* if(null!=fieldNameBindMap.get(ChemicalCompoundReagentsEntity.getCompoundReagentsName())){
									   				ExcelDataNode excelDataNode=new ExcelDataNode();
									   				excelDataNode.setColNum(fieldNameBindMap.get(ChemicalCompoundReagentsEntity.getCompoundReagentsName()).getColNum());
									   				excelDataNode.setData(ChemicalCompoundReagentsEntity.getCompoundReagentsSN());
										        	excelDataNodes.add(excelDataNode);
							   				   }*/
				   							}
		   							}
		   						}else if(pt.getActualTypeArguments()[0]==DefectEntity.class){
		   							List<DefectEntity> defectEntitys=(List<DefectEntity>)ReflectionUtils.getField(fieldMap.get(fieldName), objEntity);
		   							if(defectEntitys!=null){
		   								for(DefectEntity defectEntity:defectEntitys){
		   									if(StringUtils.isEmpty(defectEntity.getFieldName()))continue;
				   							 if(null!=fieldNameBindMap.get(defectEntity.getFieldName())){
									   				ExcelDataNode excelDataNode=new ExcelDataNode();
									   				excelDataNode.setColNum(fieldNameBindMap.get(defectEntity.getFieldName()).getColNum());
									   				excelDataNode.setData(String.valueOf(defectEntity.getDefectValue()));
										        	excelDataNodes.add(excelDataNode);
							   				   }
				   							}
		   							}
		   						}
		   					}
		   				 }
		   			 }
	   			 }
	   		 }
	   		 rowdatas.put(currentRowNum, excelDataNodes);
	   		 currentRowNum++;
	   	 }
	   	 return rowdatas;
	}
}

package com.pall.mts.common.tools;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.util.ReflectionUtils;

import com.alibaba.druid.util.StringUtils;
import com.pall.mts.common.constants.KeyConstants;
import com.pall.mts.common.support.excel.ExcelDataNode;
import com.pall.mts.common.support.excel.ExcelHeaderNode;
import com.pall.mts.init.TableDataConfigInitiator;
import com.pall.mts.init.UmsConfigInitiator;
import com.pall.mts.repository.entity.workflow.ChemicalCompoundReagentsEntity;
import com.pall.mts.repository.entity.workflow.DefectEntity;

public class ExcelTools {
	/*
	 * 封装Excel数据信息
	 * @param fieldNameBindMap 表格对应的配置信息
	 * @param objEntitys需要遍历的对象信息
	 * @param currentRowNum excel写入记录的行位置
	 * @return 
	 */
	public static Map<Integer,List<ExcelDataNode>> getExcelDatas(Map<String,ExcelHeaderNode> fieldNameBindMap,List<?> objEntitys,int currentRowNum){
		Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
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
		   								for(ChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity:chemicalCompoundReagents){
		   									if(StringUtils.isEmpty(chemicalCompoundReagentsEntity.getMainReagent()+chemicalCompoundReagentsEntity.getReagentsName()))continue;
				   								if(null!=fieldNameBindMap.get(chemicalCompoundReagentsEntity.getMainReagent()+"|"+chemicalCompoundReagentsEntity.getReagentsName())){
									   				ExcelDataNode excelDataNode=new ExcelDataNode();
									   				excelDataNode.setColNum(fieldNameBindMap.get(chemicalCompoundReagentsEntity.getMainReagent()+"|"+chemicalCompoundReagentsEntity.getReagentsName()).getColNum());
									   				excelDataNode.setData(chemicalCompoundReagentsEntity.getReagentsSn());
										        	excelDataNodes.add(excelDataNode);
							   				   }
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
	/*
	 * 封装Excel头部信息
	 * @param fieldNameBindMap 表格对应的配置信息
	 * @param objEntitys需要遍历的对象信息
	 * @param currentRowNum excel写入记录的行位置
	 * @return 
	 */
	public static Map<String,Map<?,?>> getExcelHeaders(Map<String,ExcelHeaderNode> fieldNameBindMap,Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap,Map<Integer,List<ExcelHeaderNode>> replaceHeadlinesMap,String replaceFieldName){
		Map<String,Map<?,?>> execlHeaderMap=new HashMap<String,Map<?,?>>();
		Map<String,ExcelHeaderNode> tempFieldNameBindMap=new HashMap<String,ExcelHeaderNode>();
		
		Map<Integer,List<ExcelHeaderNode>> tempExcelheadlinesMap=new HashMap<Integer,List<ExcelHeaderNode>>();
		
		ExcelHeaderNode replaceExcelHeaderNode=fieldNameBindMap.get(replaceFieldName);
		int startColNum=-1;
		if(replaceExcelHeaderNode!=null){
			startColNum=replaceExcelHeaderNode.getColNum();
		}
        if(startColNum!=-1 && replaceHeadlinesMap!=null){
        	for(Integer rownum:excelheadlinesMap.keySet()){
        		List<ExcelHeaderNode> tempExcelHeaderNodes=new ArrayList<ExcelHeaderNode>();
        		List<ExcelHeaderNode> excelHeaderNodes=excelheadlinesMap.get(rownum);
        		if(CollectionUtils.isEmpty(excelHeaderNodes))continue;
        		int chemicalEndColNum=startColNum;
        		List<ExcelHeaderNode> chemicalHeaderNodes=replaceHeadlinesMap.get(rownum);
    			if(!CollectionUtils.isEmpty(chemicalHeaderNodes)){
    				for(ExcelHeaderNode tempChemicalExcelHeaderNode:chemicalHeaderNodes){
    					ExcelHeaderNode tempNode=new ExcelHeaderNode();
	        			BeanUtils.copyProperties(tempChemicalExcelHeaderNode, tempNode);
    					if(!StringUtils.isEmpty(tempNode.getFieldName())){
    						tempFieldNameBindMap.put(tempNode.getFieldName(), tempNode);
    					}
    					tempNode.setColNum(tempNode.getColNum()+startColNum-1);
    					if(chemicalEndColNum<tempNode.getColNum()+tempNode.getCellspan())chemicalEndColNum=tempNode.getColNum()+tempNode.getCellspan();
    					tempExcelHeaderNodes.add(tempNode);
    				}
    				
    			}
        		for(ExcelHeaderNode excelHeaderNode:excelHeaderNodes){
        			ExcelHeaderNode tempNode=new ExcelHeaderNode();
        			BeanUtils.copyProperties(excelHeaderNode, tempNode);
        			if(tempNode.getColNum()==startColNum){
        				continue;
        			}else if(tempNode.getColNum()>startColNum){
        				tempNode.setColNum(tempNode.getColNum()+chemicalEndColNum-startColNum-1);
        				tempExcelHeaderNodes.add(tempNode);
        			}else{
        				tempExcelHeaderNodes.add(tempNode);
        			}
        			if(!StringUtils.isEmpty(tempNode.getFieldName())){
						tempFieldNameBindMap.put(tempNode.getFieldName(), tempNode);
					}
        		}
        		tempExcelheadlinesMap.put(rownum, tempExcelHeaderNodes);
        	}
        }else{
        	tempExcelheadlinesMap=excelheadlinesMap;
        	tempFieldNameBindMap=fieldNameBindMap;
        }
        execlHeaderMap.put("fieldNameBind", tempFieldNameBindMap);
        execlHeaderMap.put("excelheadlines", tempExcelheadlinesMap);
	   	return execlHeaderMap;
	}
}

package com.pall.wdpts.common.tools;

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
import com.pall.wdpts.common.constants.KeyConstants;
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
	/*
	 * 封装Excel模板数据信息
	 * @param excelTemplateMap excel模板对象
	 * @param objEntity需要遍历的对象信息
	 * @param currentRowNum excel写入记录的行位置
	 * @return 
	 */
	public static Map<Integer,List<ExcelHeaderNode>> getExcelTempateDatas(Map<Integer,List<ExcelHeaderNode>> excelTemplateMap,Object objEntity,int currentRowNum){
		if(excelTemplateMap==null) return excelTemplateMap;
		Map<String,Field> fieldMap=ReflectUtils.getBeanPropertyFields(objEntity.getClass());
 		if(fieldMap==null || fieldMap.size()<=0) return excelTemplateMap;
 		Map<Integer,List<ExcelHeaderNode>> templateDatas=new HashMap<Integer,List<ExcelHeaderNode>>();
 		for(int rownum:excelTemplateMap.keySet()){
 			if(null==templateDatas.get(rownum))templateDatas.put(rownum, new ArrayList<ExcelHeaderNode>());
 			if(!CollectionUtils.isEmpty(excelTemplateMap.get(rownum))){
 				for(ExcelHeaderNode excelHeaderNode:excelTemplateMap.get(rownum)){
 					ExcelHeaderNode tempExcelHeaderNode=new ExcelHeaderNode();
 					BeanUtils.copyProperties(excelHeaderNode, tempExcelHeaderNode);
 					templateDatas.get(rownum).add(tempExcelHeaderNode);
 				}
 			}
 		}
 		for(String fieldName:fieldMap.keySet()){
 			fieldMap.get(fieldName).setAccessible(true);
 			if(ReflectUtils.isPrimitive(fieldMap.get(fieldName).getType())){
 				Object obj=ReflectionUtils.getField(fieldMap.get(fieldName), objEntity);
 				replaceTemplateData(templateDatas,fieldName,obj==null?"":String.valueOf(obj));
 			}else if(fieldMap.get(fieldName).getType() == java.util.List.class){
 				List<?> subObjEntitys=(List<?>)ReflectionUtils.getField(fieldMap.get(fieldName), objEntity);
 				templateDatas=insertTemplateData(-1,templateDatas,getReplaceDataByFieldName(templateDatas,fieldName),subObjEntitys);
 			}
 		}
	   return templateDatas;
	}
	/*
	 * 替换excel模板对象信息
	 * @param excelTemplateMap excel模板配置对象
	 * @param fieldName 替换的属性名
	 * @param fieldValue 替换的属性值
	 * @return
	 */
	private static void replaceTemplateData(Map<Integer,List<ExcelHeaderNode>> templateDatas,String fieldName,String fieldValue){
		if(null==templateDatas)return;
		for(int rowNum:templateDatas.keySet()){
			List<ExcelHeaderNode> excelHeaderNodes=templateDatas.get(rowNum);
			if(!CollectionUtils.isEmpty(excelHeaderNodes)){
				for(ExcelHeaderNode excelHeaderNode:excelHeaderNodes){
					if(fieldName.equals(excelHeaderNode.getFieldName())){
						excelHeaderNode.setHeadline(fieldValue);
						return;
					}
				}
			}
		}
	}
	/*
	 * 替换模板数据
	 * @param excelTemplateMap excel模板配置对象
	 * @param excelHeaderNodes excel模板新添加行对象模板
	 * @param objEntitys 新添加行对象信息
	 * @return 新的模板信息对象
	 */
	private static Map<Integer,List<ExcelHeaderNode>> insertTemplateData(int initRowNum,Map<Integer,List<ExcelHeaderNode>> excelTemplateMap,List<ExcelHeaderNode> excelHeaderNodes,List<?> objEntitys){
		int replaceRowNum=initRowNum;
		if(CollectionUtils.isEmpty(objEntitys) || CollectionUtils.isEmpty(excelHeaderNodes)) return excelTemplateMap;
		Map<Integer,List<ExcelHeaderNode>> templateDatas=new HashMap<Integer,List<ExcelHeaderNode>>();
		for(Object objEntity:objEntitys){
			Map<String,Field> fieldMap=ReflectUtils.getBeanPropertyFields(objEntity.getClass());
			if(null!=fieldMap){
				for(String fieldName:fieldMap.keySet()){
					fieldMap.get(fieldName).setAccessible(true);
					if(ReflectUtils.isPrimitive(fieldMap.get(fieldName).getType())){
		 				Object obj=ReflectionUtils.getField(fieldMap.get(fieldName), objEntity);
		 				for(ExcelHeaderNode excelHeaderNode:excelHeaderNodes){
		 					if(initRowNum==-1) {
		 						initRowNum=excelHeaderNode.getRowNum()+1;
		 						replaceRowNum=initRowNum;
		 					}
		 					if(null==templateDatas.get(initRowNum)) {
		 						templateDatas.put(initRowNum, new ArrayList<ExcelHeaderNode>());
		 					}
		 					if(!StringUtils.isEmpty(excelHeaderNode.getFieldName()) && excelHeaderNode.getFieldName().endsWith(":"+fieldName)){
		 						ExcelHeaderNode tempExcelHeaderNode=new ExcelHeaderNode();
			 					BeanUtils.copyProperties(excelHeaderNode, tempExcelHeaderNode);
			 					tempExcelHeaderNode.setRowNum(initRowNum);
		 						tempExcelHeaderNode.setHeadline(obj==null?"":String.valueOf(obj));
		 						if(!StringUtils.isEmpty(tempExcelHeaderNode.getHeadline()) && KeyConstants.EXCEL_INSERT_SYMBOL_TYPE==tempExcelHeaderNode.getInvisible()){
		 							String[] datas=tempExcelHeaderNode.getHeadline().split("\\|");
		 							int checked=0;
		 							if(datas.length>=2 && !StringUtils.isEmpty(datas[0])){
		 								String tempData=datas[0];
		 								if(datas[0].indexOf("_")!=-1){
		 									String temp=datas[0].substring(0, datas[0].indexOf("_"));
		 									if(StringUtils.isNumber(temp)){
		 										checked=Integer.parseInt(temp);
		 										tempData=datas[0].substring(datas[0].indexOf("_")+1,datas[0].length());
		 									}
		 								}
		 								String headLine="";
		 								for(int i=0;i<datas.length;i++){
		 									if(i==0 && i==checked){
		 										headLine=headLine+new String(KeyConstants.EXCEL_INSERT_SYMBOL_TYPE_CHECK,0,1)+"  "+tempData+"  ";
		 									}else if(i==0 && i!=checked){
		 										headLine=headLine+new String(KeyConstants.EXCEL_INSERT_SYMBOL_TYPE_CHECK,1,1)+"  "+tempData+"  ";
		 									}else if(i==checked){
		 										headLine=headLine+new String(KeyConstants.EXCEL_INSERT_SYMBOL_TYPE_CHECK,0,1)+"  "+datas[i]+"  ";
		 									}else{
		 										headLine=headLine+new String(KeyConstants.EXCEL_INSERT_SYMBOL_TYPE_CHECK,1,1)+"  "+datas[i]+"  ";
		 									}
		 								}
		 								tempExcelHeaderNode.setHeadline(headLine);
		 							}
		 						}
		 						templateDatas.get(initRowNum).add(tempExcelHeaderNode);
		 					}
		 				}
		 			}else if(fieldMap.get(fieldName).getType() == java.util.List.class){
		 				List<?> subObjEntitys=(List<?>)ReflectionUtils.getField(fieldMap.get(fieldName), objEntity);
		 				templateDatas.putAll(insertTemplateData(-1,templateDatas,excelHeaderNodes,subObjEntitys));
		 			}
				}
				initRowNum++;
			}
		}
		if(null!=excelTemplateMap){
			int newAddRowSize=templateDatas.size();
			for(int rownum:excelTemplateMap.keySet()){
				if(rownum>=replaceRowNum){
					templateDatas.put(rownum+newAddRowSize, excelTemplateMap.get(rownum));
					if(!CollectionUtils.isEmpty(excelTemplateMap.get(rownum))){
						for(ExcelHeaderNode excelHeaderNode:excelTemplateMap.get(rownum)){
							excelHeaderNode.setRowNum(rownum+newAddRowSize);
						}
					}
				}else{
					templateDatas.put(rownum, excelTemplateMap.get(rownum));
				}
			}
		}
		return templateDatas;
	}
	/*
	 * 根据属性名获取替换数据所在的行和替换信息
	 * @param excelTemplateMap excel模板配置对象
	 * @param fieldName list集合子对象属性名
	 */
	private static List<ExcelHeaderNode> getReplaceDataByFieldName(Map<Integer,List<ExcelHeaderNode>> templateDatas,String fieldName){
		if(null!=templateDatas){
			for(int rowNum:templateDatas.keySet()){
				List<ExcelHeaderNode> excelHeaderNodes=templateDatas.get(rowNum);
				if(!CollectionUtils.isEmpty(excelHeaderNodes)){
					for(ExcelHeaderNode excelHeaderNode:excelHeaderNodes){
						if(!StringUtils.isEmpty(excelHeaderNode.getFieldName()) && excelHeaderNode.getFieldName().startsWith(fieldName+":")){
							return excelHeaderNodes;
						}
					}
				}
			}
		}
		return null;
	}
}

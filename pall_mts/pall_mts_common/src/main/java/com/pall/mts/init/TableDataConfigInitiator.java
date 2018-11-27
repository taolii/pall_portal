package com.pall.mts.init;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.pall.mts.common.support.excel.ExcelHeaderNode;
import com.pall.mts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.mts.service.dataconfig.DataConfigManageService;

/*
 * 初始化系统标题配置表
 */
@Component
public class TableDataConfigInitiator {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass()); 
	/*
	 * Map对象映射  key1:表名  key2:行号
	 */
	private static Map<String,Map<Integer,List<TableHeaderConfigEntity>>> tableHeaderMap=new ConcurrentHashMap<String,Map<Integer,List<TableHeaderConfigEntity>>>();
	/*
	 * Map对象映射  key1:表名  key2:绑定属性名
	 */
	private static Map<String,Map<String,ExcelHeaderNode>> tableFieldBindConfigMap=new ConcurrentHashMap<String,Map<String,ExcelHeaderNode>>();
	/*
	 * Map对象映射  key1:表名  key2:绑定属性名
	 */
	private static Map<String,Map<String,ExcelHeaderNode>> excelFieldBindConfigMap=new ConcurrentHashMap<String,Map<String,ExcelHeaderNode>>();
	/*
	 * Map对象映射  key1:表名  key2:行号
	 */
	private static Map<String,Map<Integer,List<ExcelHeaderNode>>> excelHeaderMap=new ConcurrentHashMap<String,Map<Integer,List<ExcelHeaderNode>>>();
	/*
	 * 数据配置管理服务
	 */
	@Autowired
	private DataConfigManageService dataConfigManageService;
	@PostConstruct
	public void initialize(){
		Map<String,Map<Integer,List<TableHeaderConfigEntity>>> tempTableHeaderMap=new ConcurrentHashMap<String,Map<Integer,List<TableHeaderConfigEntity>>>();
		/*
		 * 表格中动态data列信息
		 */
		Map<String,Map<Integer,List<TableHeaderConfigEntity>>> dynamicDataMap=new ConcurrentHashMap<String,Map<Integer,List<TableHeaderConfigEntity>>>();
		try {
			List<TableHeaderConfigEntity> tableHeaderConfigs=dataConfigManageService.queryTableHeaderConfigList();
			if(tableHeaderConfigs!=null && tableHeaderConfigs.size()>0){
				for(TableHeaderConfigEntity tableHeaderConfig:tableHeaderConfigs){
					if(null==tempTableHeaderMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid())){
						tempTableHeaderMap.put(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid(),new HashMap<Integer,List<TableHeaderConfigEntity>>());
						tempTableHeaderMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).put(tableHeaderConfig.getLineNum(), new ArrayList<TableHeaderConfigEntity>());
					}else if(null==tempTableHeaderMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).get(tableHeaderConfig.getLineNum())){
						tempTableHeaderMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).put(tableHeaderConfig.getLineNum(), new ArrayList<TableHeaderConfigEntity>());
					};
					if(tableHeaderConfig.getDataid()!=0){
						if(null==dynamicDataMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid())){
							dynamicDataMap.put(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid(),new HashMap<Integer,List<TableHeaderConfigEntity>>());
							dynamicDataMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).put(tableHeaderConfig.getLineNum(), new ArrayList<TableHeaderConfigEntity>());
						}else if(null==dynamicDataMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).get(tableHeaderConfig.getLineNum())){
							dynamicDataMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).put(tableHeaderConfig.getLineNum(), new ArrayList<TableHeaderConfigEntity>());
						}
						dynamicDataMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).get(tableHeaderConfig.getLineNum()).add(tableHeaderConfig);
						//如果同一个表格含有多行动态配置，则打印系统错误
						if(dynamicDataMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).size()>1){
							logger.error("table "+tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()+" config dynamic defect info error:"+
							JSON.toJSONString(dynamicDataMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()),SerializerFeature.WriteMapNullValue));
							continue;
						}
					}
					tempTableHeaderMap.get(tableHeaderConfig.getTableName()+tableHeaderConfig.getMenuid()).get(tableHeaderConfig.getLineNum()).add(tableHeaderConfig);
				}
			}
		} catch (Exception e) {
			logger.error("initial system table header config  exception",e);
		}
		
		//根据标题头动态变化对象更新表格列信息和占用列数
		updateTableColInfo(tempTableHeaderMap,dynamicDataMap);
		tableHeaderMap=tempTableHeaderMap;
		excelHeaderMap.clear();
		tableFieldBindConfigMap.clear();
		excelFieldBindConfigMap.clear();
		
	}
	
	/*
	 * 根据标题头动态变化对象更新表格列信息和占用列数
	 * @param tableHeaderMap 标题头对象  Map对象映射  key1:表名  key2:行号
	 * @param dynamicDataMap 标题头动态变化对象 Map对象映射  key1:表名  key2:行号
	 * @return 
	 */
	private void updateTableColInfo(Map<String,Map<Integer,List<TableHeaderConfigEntity>>> tableHeaderMap,Map<String,Map<Integer,List<TableHeaderConfigEntity>>> dynamicDataMap){
		for(String tableName:dynamicDataMap.keySet()){
			//行数据
			Map<Integer,List<TableHeaderConfigEntity>> tableRowHeaderConfigMap=tableHeaderMap.get(tableName);
			//动态数据
			Map<Integer,List<TableHeaderConfigEntity>> dynamicRowDataMap=dynamicDataMap.get(tableName);
			if(null!=dynamicRowDataMap && dynamicRowDataMap.size()>0){
				//动态数据所在行，每列存在的数据个数 key:列号 value：对象个数
				Map<Integer,Integer> colsObjectNumDynamicDataMap=new TreeMap<Integer,Integer>();
				int dynamicRowNum=-1;
				//获取动态数据所在行号
				for(Integer rowNum:dynamicRowDataMap.keySet()){
					dynamicRowNum=rowNum;
				}
				for(TableHeaderConfigEntity tableHeaderConfig:dynamicRowDataMap.get(dynamicRowNum)){
					if(null==colsObjectNumDynamicDataMap.get(tableHeaderConfig.getColNum())){
						colsObjectNumDynamicDataMap.put(tableHeaderConfig.getColNum(), 1);
					}else{
						colsObjectNumDynamicDataMap.put(tableHeaderConfig.getColNum(), colsObjectNumDynamicDataMap.get(tableHeaderConfig.getColNum())+1);
					}
				}
				if(colsObjectNumDynamicDataMap!=null && colsObjectNumDynamicDataMap.size()>0){
					int tempDynamicColNum=0;
					for(int dynamicColNum:colsObjectNumDynamicDataMap.keySet()){
						if(tempDynamicColNum==0){
							tempDynamicColNum=dynamicColNum;
						}else if(dynamicColNum>tempDynamicColNum){
							tempDynamicColNum=colsObjectNumDynamicDataMap.get(tempDynamicColNum)+dynamicColNum-1;
						}
						for(int rowNum:tableRowHeaderConfigMap.keySet()){
							List<TableHeaderConfigEntity> tempTableHeaderConfigs=tableRowHeaderConfigMap.get(rowNum);
							Collections.sort(tempTableHeaderConfigs);
							TableHeaderConfigEntity temptableHeaderConfig=null;
							for(TableHeaderConfigEntity tableHeaderConfig:tempTableHeaderConfigs){
								//大于当前列的，则各行列累加
								if(tableHeaderConfig.getColNum()>tempDynamicColNum && colsObjectNumDynamicDataMap.get(dynamicColNum)>1){
									tableHeaderConfig.setColNum(tableHeaderConfig.getColNum()+colsObjectNumDynamicDataMap.get(dynamicColNum)-1);
								}else if(tableHeaderConfig.getColNum()==tempDynamicColNum){
									if(dynamicRowNum==rowNum){
										if(temptableHeaderConfig==null){
											temptableHeaderConfig=tableHeaderConfig;
										}else{
											tableHeaderConfig.setColNum(temptableHeaderConfig.getColNum()+temptableHeaderConfig.getCols());
											temptableHeaderConfig=tableHeaderConfig;
										}
									}else{
										//不是当前行,则占用列数累加
										tableHeaderConfig.setCols(tableHeaderConfig.getCols()+colsObjectNumDynamicDataMap.get(dynamicColNum)-1);
									}
								}else{
									if(dynamicRowNum!=rowNum){
										if(tableHeaderConfig.getCols()>1 && tableHeaderConfig.getColNum()+tableHeaderConfig.getCols()>tempDynamicColNum){
											tableHeaderConfig.setCols(tableHeaderConfig.getCols()+colsObjectNumDynamicDataMap.get(dynamicColNum)-1);
										}
									}
								}
							}
						}
					}
				}
				/*for(int rowNum:tableRowHeaderConfigMap.keySet()){
					List<TableHeaderConfigEntity> tempTableHeaderConfigs=tableRowHeaderConfigMap.get(rowNum);
					Collections.sort(tempTableHeaderConfigs);
					TableHeaderConfigEntity temptableHeaderConfig=null;
					for(TableHeaderConfigEntity tableHeaderConfig:tempTableHeaderConfigs){
						if(dynamicRowNum!=rowNum && null!=colsObjectNumDynamicDataMap.get(tableHeaderConfig.getColNum())){
							int oldColNum=tableHeaderConfig.getColNum();
							int maxColNum=tableHeaderConfig.getCols()+tableHeaderConfig.getColNum()-1;
							for(Integer colNum:colsObjectNumDynamicDataMap.keySet()){
								if(colNum>=oldColNum && colNum<=maxColNum){
									tableHeaderConfig.setCols(tableHeaderConfig.getCols()+colsObjectNumDynamicDataMap.get(colNum)-1);
									if(temptableHeaderConfig!=null){
										tableHeaderConfig.setColNum(temptableHeaderConfig.getColNum()+temptableHeaderConfig.getCols());
									}
								}
							}
							temptableHeaderConfig=tableHeaderConfig;
							continue;
						}
						if(temptableHeaderConfig!=null){
							if(colsObjectNumDynamicDataMap!=null){
								for(Integer colNum:colsObjectNumDynamicDataMap.keySet()){
									if(tableHeaderConfig.getColNum()>colNum){
										tableHeaderConfig.setColNum(tableHeaderConfig.getColNum()+colsObjectNumDynamicDataMap.get(colNum));
									}
								}
							}
							if(tableHeaderConfig.getColNum()<=temptableHeaderConfig.getColNum()){
								tableHeaderConfig.setColNum(temptableHeaderConfig.getColNum()+temptableHeaderConfig.getCols());
							}
							temptableHeaderConfig=tableHeaderConfig;
						}else if(dynamicRowNum==rowNum){
							temptableHeaderConfig=tableHeaderConfig;
						}
					}
				}*/
			}
		}
	}
	/*
	 * 根据表名获取标题头信息 
	 * @param tableName 表名
	 * @return  map key:行号 value:每行对象数
	 */
	public static Map<Integer,List<TableHeaderConfigEntity>> getTableHeaderConfig(String tableName){
		return tableHeaderMap.get(tableName);
	}
	
	/*
	 * 获取表格记录中绑定对象的属性名信息
	 * @param tableName 表名
	 * @return  map key:属性名 value:包含此属性的对象
	 */
	public static Map<String,ExcelHeaderNode> getTableFieldBindConfig(String tableName){
		Map<String,ExcelHeaderNode> tempTableFieldBindConfigMap=tableFieldBindConfigMap.get(tableName);
		if(tempTableFieldBindConfigMap==null){
			Map<Integer,List<TableHeaderConfigEntity>> tempMap= tableHeaderMap.get(tableName);
			tempTableFieldBindConfigMap=new HashMap<String,ExcelHeaderNode>();
			if(tempMap!=null){
				for(Integer rowNum:tempMap.keySet()){
					for(TableHeaderConfigEntity tableHeaderConfig:tempMap.get(rowNum)){
						if(!StringUtils.isEmpty(tableHeaderConfig.getFieldName())){
							ExcelHeaderNode excelHeaderNode=new ExcelHeaderNode();
							excelHeaderNode.setCellspan(tableHeaderConfig.getCols());
							excelHeaderNode.setColNum(tableHeaderConfig.getColNum());
							excelHeaderNode.setFieldName(tableHeaderConfig.getFieldName());
							excelHeaderNode.setHeadline(tableHeaderConfig.getHeadline());
							excelHeaderNode.setRowNum(tableHeaderConfig.getLineNum());
							excelHeaderNode.setRowspan(tableHeaderConfig.getRows());
							excelHeaderNode.setInvisible(tableHeaderConfig.getInvisible());
							excelHeaderNode.setDefectType(tableHeaderConfig.getDataType());
							tempTableFieldBindConfigMap.put(tableHeaderConfig.getFieldName(), excelHeaderNode);
						}
					}
				}
			}
			
			tableFieldBindConfigMap.put(tableName, tempTableFieldBindConfigMap);
		}
		return tempTableFieldBindConfigMap;
	}
	/*
	 * 获取表格记录中绑定对象的属性名信息
	 * @param tableName 表名
	 * @return  map key:属性名 value:包含此属性的对象
	 */
	public static Map<Integer,List<ExcelHeaderNode>> getExcelHeaderConfig(String tableName){
		Map<Integer,List<ExcelHeaderNode>> excelRowHeaderMap=excelHeaderMap.get(tableName);
		if(excelRowHeaderMap==null){
			 Map<Integer,List<TableHeaderConfigEntity>> headlinesMap=getTableHeaderConfig(tableName);
			 excelRowHeaderMap=new HashMap<Integer,List<ExcelHeaderNode>>();
			 List<Integer> hiddenColNums=new ArrayList<Integer>();
		        if(headlinesMap!=null && headlinesMap.size()>0){
		        	for(Integer rownum:headlinesMap.keySet()){
		        		for(TableHeaderConfigEntity headLineConfigEntity:headlinesMap.get(rownum)){
		        			/*
		        			 * 隐藏数据不输出
		        			 */
		        			if(headLineConfigEntity.getInvisible()==1 || headLineConfigEntity.getInvisible()==2){
		        				hiddenColNums.add(headLineConfigEntity.getColNum());
		        				continue;
		        			}
		        			ExcelHeaderNode excelHeaderNode=new ExcelHeaderNode();
		        			excelHeaderNode.setCellspan(headLineConfigEntity.getCols());
		        			excelHeaderNode.setColNum(headLineConfigEntity.getColNum());
		        			excelHeaderNode.setHeadline(headLineConfigEntity.getHeadline());
		        			excelHeaderNode.setRowNum(headLineConfigEntity.getLineNum());
		        			excelHeaderNode.setRowspan(headLineConfigEntity.getRows());
		        			excelHeaderNode.setFieldName(headLineConfigEntity.getFieldName());
		        			
		        			if(excelRowHeaderMap.get(rownum)==null){
		        				excelRowHeaderMap.put(rownum, new ArrayList<ExcelHeaderNode>());
		        			}
		        			excelRowHeaderMap.get(rownum).add(excelHeaderNode);
		        		}
		        	}
		        }
		        
		     //根据去掉隐藏数据后根据最新标题头计算列信息和占用列数
		     updateExcelColInfo(excelRowHeaderMap,hiddenColNums);
		     excelHeaderMap.put(tableName, excelRowHeaderMap);
		}
		return excelRowHeaderMap;
	}
	/*
	 * 根据标题头是否隐藏更新excel列信息和占用列数
	 * @param excelRowHeaderMap 标题头对象  Map对象映射  key:行号
	 * @param hiddenCol隐藏列信息
	 * @return 
	 */
	private static void updateExcelColInfo(Map<Integer,List<ExcelHeaderNode>> excelRowHeaderMap,List<Integer> hiddenColNums){
		for(int j=hiddenColNums.size()-1;j>0;j--){
			for(int rowNum:excelRowHeaderMap.keySet()){
				List<ExcelHeaderNode> excelHeaderNodes=excelRowHeaderMap.get(rowNum);
				Collections.sort(excelHeaderNodes);
				ExcelHeaderNode tempExcelHeaderNode=null;
				for(ExcelHeaderNode excelHeaderNode:excelHeaderNodes){
					if(tempExcelHeaderNode==null){
						if(hiddenColNums.get(j)<excelHeaderNode.getColNum()){
							excelHeaderNode.setColNum(excelHeaderNode.getColNum()-1);
							tempExcelHeaderNode=excelHeaderNode;
						}else if(hiddenColNums.get(j)<excelHeaderNode.getColNum()+excelHeaderNode.getCellspan()){
							//excelHeaderNode.setCellspan(excelHeaderNode.getCellspan()-1);
							excelHeaderNode.setColNum(excelHeaderNode.getColNum()-1);
							tempExcelHeaderNode=excelHeaderNode;
						}
						continue;
					}
					excelHeaderNode.setColNum(excelHeaderNode.getColNum()-1);
					tempExcelHeaderNode=excelHeaderNode;
				}
			}
		}
	}
	/*
	 * 获取Excel中绑定对象的属性名信息
	 * @param tableName 表名
	 * @return  map key:属性名 value:包含此属性的对象
	 */
	public static Map<String,ExcelHeaderNode> getExcelFieldBindConfig(String tableName){
		Map<String,ExcelHeaderNode> tempExcelFieldBindConfigMap=excelFieldBindConfigMap.get(tableName);
		if(tempExcelFieldBindConfigMap==null){
			Map<Integer,List<ExcelHeaderNode>> tempMap= getExcelHeaderConfig(tableName);
			tempExcelFieldBindConfigMap=new HashMap<String,ExcelHeaderNode>();
			for(Integer rowNum:tempMap.keySet()){
				for(ExcelHeaderNode excelHeaderNode:tempMap.get(rowNum)){
					if(!StringUtils.isEmpty(excelHeaderNode.getFieldName())){
						tempExcelFieldBindConfigMap.put(excelHeaderNode.getFieldName(), excelHeaderNode);
					}
				}
			}
			excelFieldBindConfigMap.put(tableName, tempExcelFieldBindConfigMap);
		}
		return tempExcelFieldBindConfigMap;
	}
}

package com.pall.portal.init;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.pall.portal.repository.entity.dataconfig.DataConfigEntity;
import com.pall.portal.service.dataconfig.DataConfigManageService;

/*
 * 初始化数据配置表
 */
@Component
public class DataConfigInitiator {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	private static Map<String,List<DataConfigEntity>> dataConfigMap=new ConcurrentHashMap<String,List<DataConfigEntity>>();
	/*
	 * 数据配置管理服务
	 */
	@Autowired
	private DataConfigManageService dataConfigManageService;
	@PostConstruct
	public void initialize(){
		Map<String,List<DataConfigEntity>> tempDataConfigMap=new ConcurrentHashMap<String,List<DataConfigEntity>>();
		try {
			List<DataConfigEntity> dataConfigEntitys=dataConfigManageService.queryDataConfigList();
			if(dataConfigEntitys!=null && dataConfigEntitys.size()>0){
				for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
					if(null==tempDataConfigMap.get(String.valueOf(dataConfigEntity.getDataType()))){
						tempDataConfigMap.put(String.valueOf(dataConfigEntity.getDataType()),new ArrayList<DataConfigEntity>());
					};
					tempDataConfigMap.get(String.valueOf(dataConfigEntity.getDataType())).add(dataConfigEntity);
				}
			}
		} catch (Exception e) {
			logger.error("init data config  exception",e);
		}
		dataConfigMap=tempDataConfigMap;
	}
	/*
	 * 获取数据配置信息
	 * @param dataConfigType 数据配置类型
	 * @return
	 */
	public static List<DataConfigEntity> getDataConfig(String dataConfigType){
		return dataConfigMap.get(dataConfigType);
	}
}

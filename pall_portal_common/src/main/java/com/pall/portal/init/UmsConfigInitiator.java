	package com.pall.portal.init;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.druid.util.StringUtils;
import com.pall.portal.repository.entity.dataconfig.UmsConfigEntity;
import com.pall.portal.service.dataconfig.DataConfigManageService;

/*
 * 初始化同一配置表
 */
@Component
public class UmsConfigInitiator {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	/*
	 * key:configName
	 */
	private static Map<String,UmsConfigEntity> umsConfigMap=new ConcurrentHashMap<String,UmsConfigEntity>();
	/*
	 * 数据配置管理服务
	 */
	@Autowired
	private DataConfigManageService dataConfigManageService;
	@PostConstruct
	public void initialize(){
		Map<String,UmsConfigEntity> tempUmsConfigMap=new ConcurrentHashMap<String,UmsConfigEntity>();
		try {
			List<UmsConfigEntity> umsConfigEntitys=dataConfigManageService.queryUmsConfigList();
			if(umsConfigEntitys!=null && umsConfigEntitys.size()>0){
				for(UmsConfigEntity umsConfigEntity:umsConfigEntitys){
					if(!StringUtils.isEmpty(umsConfigEntity.getConfigValue())){
						tempUmsConfigMap.put(umsConfigEntity.getConfigName(),umsConfigEntity);
					}
				}
			}
		} catch (Exception e) {
			logger.error("init ums config  exception",e);
		}
		umsConfigMap=tempUmsConfigMap;
	}
	/*
	 * 获取系统默认配置值
	 * @param configName 配置名
	 * @return
	 */
	public static String getDataConfig(String configName){
		return umsConfigMap.get(configName).getConfigValue();
	}
}

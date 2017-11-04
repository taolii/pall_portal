package com.pall.portal.common.i18n;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.pall.portal.common.tools.StringTools;
@Component
public class ResourceDiscovery {
	private final  Logger logger = LoggerFactory.getLogger(this.getClass());
	@Value("${spring.messages.default.basename}")
	private String defaultLocationPattern;
	@Value("${spring.messages.extension.basename}")
	private String extensionLocationPattern;
	
	@Autowired
	private ResourceBundleMessageSource messageSource;
	@PostConstruct
	private void init(){
		ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
		String projectPath=new File(this.getClass().getClassLoader().getResource("").getPath()).getPath();
		List<Resource> ResourcesList=new ArrayList<Resource>();
		Resource[] resources=getResources(resolver,defaultLocationPattern);
		if(!StringUtils.isEmpty(resources)){
			ResourcesList.addAll(Arrays.asList(resources));
		}
		if(!StringUtils.isEmpty(extensionLocationPattern)){
			String[] locations=StringUtils.split(extensionLocationPattern, ",");
			if(!StringUtils.isEmpty(locations)){
				for(String location:locations){
					if(StringUtils.isEmpty(location))continue;
					resources=getResources(resolver,location);
					if(!StringUtils.isEmpty(resources)){
						ResourcesList.addAll(Arrays.asList(resources));
					}
				}
			}
		}
		String[] baseNames=getBaseNames(ResourcesList,projectPath);
		if(!StringUtils.isEmpty(baseNames)){
			messageSource.addBasenames(baseNames);
		}
	}
	public String[] getBaseNames(List<Resource> resources,String projectPath){
		Set<String> removeDupSet=new HashSet<String>();
		for(Resource resource:resources){
			try {
				String baseName=resource.getFile().getPath().replace(projectPath, "");
				int index=StringTools.lastIndexOf(baseName,".",1);
				if(index!=-1){
					baseName=baseName.substring(1, index);
				}
				index=StringTools.lastIndexOf(baseName,"_",2);
				if(index!=-1){
					baseName=baseName.substring(0, index);
				}
				removeDupSet.add(baseName);
			} catch (IOException e) {
				if(logger.isErrorEnabled()){
					logger.error("error",e);
				}
			}
		}
		String[] baseNames=new String[removeDupSet.size()];
		return removeDupSet.toArray(baseNames);
	}
	
	/*
	 * 获取资源文件
	 */
	private Resource[] getResources(ResourcePatternResolver resolver,String location){
		Resource[] resources=null;
		try {
			resources=resolver.getResources(location);
		} catch (IOException e) {
			e.printStackTrace();
			if(logger.isErrorEnabled()){
				logger.error("error",e);
			}
		}
		return resources;
	}
}

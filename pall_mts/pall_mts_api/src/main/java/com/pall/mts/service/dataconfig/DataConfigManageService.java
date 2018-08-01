package com.pall.mts.service.dataconfig;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.repository.entity.dataconfig.DataConfigEntity;
import com.pall.mts.repository.entity.dataconfig.DataConfigQueryFormEntity;
import com.pall.mts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.mts.repository.entity.dataconfig.UmsConfigEntity;

/*
 * 数据配置管理服务
 */
@Service
public interface DataConfigManageService {
	/*
	 * 根据条件查询数据配置信息
	 * @param dataConfigQueryFormEntity 数据配置列表查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryDataConfigList(DataConfigQueryFormEntity  dataConfigQueryFormEntity) throws Exception;
	/*
	 * 删除数据字典信息
	 * @param dataids 需要删除的数据字典列表
	 * @return 删除结果
	 */
	public BaseResponse delDataConfig(List<String> dataids) throws Exception;
	/*
	 * 新增数据字典信息
	 * @param dataConfigEntity 数据字典对象
	 * @return 结果
	 */
	public BaseResponse addDataConfig(DataConfigEntity dataConfigEntity) throws Exception;
	/*
	 * 修改数据字典信息
	 * @param dataConfigEntity 数据字典对象
	 * @return 结果
	 */
	public BaseResponse modDataConfig(DataConfigEntity dataConfigEntity) throws Exception;
	/*
	 * 查询系统标题配置表
	 * 
	 * @return 查询结果
	 */
	public List<TableHeaderConfigEntity> queryTableHeaderConfigList() throws Exception;
	/*
	 * 查询系统数据配置表
	 * 
	 * @return 查询结果
	 */
	public List<DataConfigEntity> queryDataConfigList() throws Exception;
	/*
	 * 查询系统同一配置表
	 * @return 查询结果
	 */
	public List<UmsConfigEntity> queryUmsConfigList() throws Exception;
}

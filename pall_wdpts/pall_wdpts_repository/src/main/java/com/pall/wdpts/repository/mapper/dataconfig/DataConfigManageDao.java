package com.pall.wdpts.repository.mapper.dataconfig;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pall.wdpts.repository.entity.dataconfig.DataConfigEntity;
import com.pall.wdpts.repository.entity.dataconfig.DataConfigQueryFormEntity;
import com.pall.wdpts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.wdpts.repository.entity.dataconfig.UmsConfigEntity;
public interface DataConfigManageDao {
	/*
	 * 根据条件查询数据配置信息
	 * @param dataConfigQueryFormEntity 数据配置列表查询对象
	 * @return 查询结果
	 */
	public List<DataConfigEntity> queryDataConfigList(DataConfigQueryFormEntity  dataConfigQueryFormEntity);
	/*
	 * 根据条件查询数据配置总记录数
	 * @param dataConfigQueryFormEntity 数据配置列表查询对象
	 * @return 查询结果
	 */
	public int queryDataConfigTotalRecords(DataConfigQueryFormEntity  dataConfigQueryFormEntity);
	/*
	 * 删除数据字典信息
	 * @param dataids 删除数据字典信息
	 * @return 
	 */
	public int delDataConfig(@Param("dataids") List<String> dataids);
	/*
	 * 新增数据字典信息
	 * @param dataConfigEntity 数据字典对象
	 * @return 结果
	 */
	public int addDataConfig(DataConfigEntity dataConfigEntity);
	/*
	 * 修改数据字典信息
	 * @param dataConfigEntity 数据字典对象
	 * @return 结果
	 */
	public int modDataConfig(DataConfigEntity dataConfigEntity);
	/*
	 * 查询系统标题配置表
	 * 
	 * @return 查询结果
	 */
	public List<TableHeaderConfigEntity> queryTableHeaderConfigList();
	/*
	 * 查询系统同一配置表
	 * @return 查询结果
	 */
	public List<UmsConfigEntity> queryUmsConfigList();
}

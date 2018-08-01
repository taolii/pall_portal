package com.pall.mts.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.mts.repository.entity.workflow.AssemblyEntity;
import com.pall.mts.repository.entity.workflow.AssemblyQueryFormEntity;

/*
 * 工作流数据访问层
 */
@Repository("assemblyDao")
public interface AssemblyDao {
	/*
	 * 根据条件查询组装记录信息
	 * @param assemblyQueryFormEntity 组装信息查询对象
	 * @return 查询结果
	 */
	public List<AssemblyEntity> queryAssemblyQueryList(AssemblyQueryFormEntity  assemblyQueryFormEntity);
	/*
	 * 根据条件查询组装记录数
	 * @param assemblyQueryFormEntity 组装信息查询对象
	 * @return 查询结果
	 */
	public int queryAssemblyQueryTotalRecords(AssemblyQueryFormEntity  assemblyQueryFormEntity);
	/*
	 * 添加组装信息
	 * @param assemblyEntity 组装信息
	 * @return 添加结果
	 */
	public int addAssembly(AssemblyEntity assemblyEntity) throws Exception;
	/*
	 * 修改组装信息
	 * @param assemblyEntity 组装信息
	 * @return 修改结果
	 */
	public int modifyAssembly(AssemblyEntity assemblyEntity) throws Exception;
	/*
	 * 删除组装信息
	 * @param assemblyIDS 需要删除的组装信息列表
	 * @return 删除结果
	 */
	public int delAssembly(@Param("assemblyIDS") List<Integer> assemblyIDS) throws Exception;
	
}

package com.pall.mts.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.mts.repository.entity.workflow.CleanEntity;
import com.pall.mts.repository.entity.workflow.CleanQueryFormEntity;

/*
 * 工作流数据访问层
 */
@Repository("cleanDao")
public interface CleanDao {
	/*
	 * 根据条件查询清洁记录信息
	 * @param cleanQueryFormEntity 清洁信息查询对象
	 * @return 查询结果
	 */
	public List<CleanEntity> queryCleanList(CleanQueryFormEntity cleanQueryFormEntity);
	/*
	 * 根据条件查询清洁记录数
	 * @param cleanQueryFormEntity 清洁信息查询对象
	 * @return 查询结果
	 */
	public int queryCleanTotalRecords(CleanQueryFormEntity cleanQueryFormEntity);
	/*
	 * 添加清洁信息
	 * @param cleanEntity 清洁信息
	 * @return 添加结果
	 */
	public int addClean(CleanEntity cleanEntity) throws Exception;
	/*
	 * 修改清洁信息
	 * @param cleanEntity 清洁信息
	 * @return 修改结果
	 */
	public int modifyClean(CleanEntity cleanEntity) throws Exception;
	/*
	 * 删除清洁信息
	 * @param cleanIDs 需要删除的清洁信息列表
	 * @return 删除结果
	 */
	public int delClean(@Param("cleanIDs") List<Integer> cleanIDs) throws Exception;
	
}

package com.pall.wdpts.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.workflow.PolishEntity;
import com.pall.wdpts.repository.entity.workflow.PolishQueryFormEntity;

/*
 * 工作流数据访问层
 */
@Repository("polishDao")
public interface PolishDao {
	/*
	 * 根据条件查询抛光记录信息
	 * @param polishQueryFormEntity 抛光信息查询对象
	 * @return 查询结果
	 */
	public List<PolishEntity> queryPolishList(PolishQueryFormEntity polishQueryFormEntity);
	/*
	 * 根据条件查询抛光记录数
	 * @param polishQueryFormEntity 抛光信息查询对象
	 * @return 查询结果
	 */
	public int queryPolishTotalRecords(PolishQueryFormEntity polishQueryFormEntity);
	/*
	 * 添加抛光信息
	 * @param polishEntity 抛光信息
	 * @return 添加结果
	 */
	public int addPolish(PolishEntity polishEntity) throws Exception;
	/*
	 * 修改抛光信息
	 * @param polishEntity 抛光信息
	 * @return 修改结果
	 */
	public int modifyPolish(PolishEntity polishEntity) throws Exception;
	/*
	 * 删除抛光信息
	 * @param polishIDs 需要删除的抛光信息列表
	 * @return 删除结果
	 */
	public int delPolish(@Param("polishIDs") List<Integer> polishIDs) throws Exception;
}

package com.pall.wdpts.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.workflow.TwiceChemicalCompoundReagentsEntity;
import com.pall.wdpts.repository.entity.workflow.TwiceChemicalReagentEntity;
import com.pall.wdpts.repository.entity.workflow.TwiceChemicalReagentMixtureQueryFormEntity;
import com.pall.wdpts.repository.entity.workflow.TwiceChemicalReagentQueryFormEntity;
import com.pall.wdpts.repository.entity.workflow.TwiceChemicalReagentRelationEntity;

/*
 * 工作流数据访问层
 */
@Repository("twiceChemicalReagentDao")
public interface TwiceChemicalReagentDao {
	/*
	 * 根据条件查询生化镀膜记录信息
	 * @param twiceChemicalReagentQueryFormEntity 生化镀膜信息查询对象
	 * @return 查询结果
	 */
	public List<TwiceChemicalReagentEntity> queryTwiceChemicalReagentList(TwiceChemicalReagentQueryFormEntity  twiceChemicalReagentQueryFormEntity);
	/*
	 * 根据条件查询生化镀膜记录数
	 * @param twiceChemicalReagentQueryFormEntity 生化镀膜信息查询对象
	 * @return 查询结果
	 */
	public int queryTwiceChemicalReagentTotalRecords(TwiceChemicalReagentQueryFormEntity  twiceChemicalReagentQueryFormEntity);
	/*
	 * 根据条件查询化学试剂混合信息
	 * @param twiceChemicalReagentMixtureQueryFormEntity 化学混合试剂查询对象
	 * @return 查询结果
	 */
	public List<TwiceChemicalCompoundReagentsEntity> queryTwiceChemicalReagentMixtureList(TwiceChemicalReagentMixtureQueryFormEntity  twiceChemicalReagentMixtureQueryFormEntity);
	/*
	 * 根据条件查询生化镀膜记录数
	 * @param twiceChemicalReagentMixtureQueryFormEntity 生化镀膜信息查询对象
	 * @return 查询结果
	 */
	public int queryTwiceChemicalReagentMixtureTotalRecords(TwiceChemicalReagentMixtureQueryFormEntity  twiceChemicalReagentMixtureQueryFormEntity);
	/*
	 * 添加生化镀膜信息
	 * @param twiceChemicalReagentEntity 生化镀膜对象
	 * @return 添加结果
	 */
	public int addTwiceChemicalReagent(TwiceChemicalReagentEntity twiceChemicalReagentEntity) throws Exception;
	/*
	 * 添加化学混合试剂信息
	 * @param twiceCompoundReagents 化学混合试剂集合
	 * @return 添加结果
	 */
	public int addTwiceChemicalCompoundReagents(TwiceChemicalCompoundReagentsEntity twiceCompoundReagents) throws Exception;
	/*
	 * 添加生化镀膜关联关系对象
	 * @param twiceChemicalReagentRelations 化学混合试剂对象
	 * @return 添加结果
	 */
	public int addTwiceChemicalReagentRelations(List<TwiceChemicalReagentRelationEntity> twiceChemicalReagentRelations) throws Exception;
	/*
	 * 删除化学混合试剂信息
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public int delTwiceChemicalCompoundReagents(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 删除生化镀膜关联关系对象
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public int delTwiceChemicalReagentRelations(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 修改生化镀膜信息
	 * @param twiceChemicalReagentEntity 生化镀膜信息
	 * @return 修改结果
	 */
	public int modifyTwiceChemicalReagent(TwiceChemicalReagentEntity twiceChemicalReagentEntity) throws Exception;
	/*
	 * 删除生化镀膜信息
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 删除结果
	 */
	public int delTwiceChemicalReagent(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 查询化学混合试剂信息
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public List<TwiceChemicalCompoundReagentsEntity> queryTwiceChemicalCompoundReagents(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 查询生化镀膜关联关系对象
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public List<TwiceChemicalReagentRelationEntity> queryTwiceChemicalReagentRelations(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 查询生化镀膜关联关系对象
	 * @param crID 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public List<TwiceChemicalReagentRelationEntity> getTwiceChemicalReagentRelations(@Param("crID") String crID) throws Exception;
	
}

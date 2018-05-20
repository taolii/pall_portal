package com.pall.portal.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.repository.entity.workflow.ChemicalCompoundReagentsEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentMixtureQueryFormEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentQueryFormEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentRelationEntity;

/*
 * 工作流数据访问层
 */
@Repository("chemicalReagentDao")
public interface ChemicalReagentDao {
	/*
	 * 根据条件查询生化镀膜记录信息
	 * @param chemicalReagentQueryFormEntity 生化镀膜信息查询对象
	 * @return 查询结果
	 */
	public List<ChemicalReagentEntity> queryChemicalReagentList(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity);
	/*
	 * 根据条件查询生化镀膜记录数
	 * @param chemicalReagentQueryFormEntity 生化镀膜信息查询对象
	 * @return 查询结果
	 */
	public int queryChemicalReagentTotalRecords(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity);
	/*
	 * 根据条件查询化学试剂混合信息
	 * @param chemicalReagentMixtureQueryFormEntity 化学混合试剂查询对象
	 * @return 查询结果
	 */
	public List<ChemicalCompoundReagentsEntity> queryChemicalReagentMixtureList(ChemicalReagentMixtureQueryFormEntity  chemicalReagentMixtureQueryFormEntity);
	/*
	 * 根据条件查询生化镀膜记录数
	 * @param chemicalReagentQueryFormEntity 生化镀膜信息查询对象
	 * @return 查询结果
	 */
	public int queryChemicalReagentMixtureTotalRecords(ChemicalReagentMixtureQueryFormEntity  chemicalReagentMixtureQueryFormEntity);
	/*
	 * 添加生化镀膜信息
	 * @param chemicalReagentEntity 生化镀膜对象
	 * @return 添加结果
	 */
	public int addChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception;
	/*
	 * 添加化学混合试剂信息
	 * @param compoundReagents 化学混合试剂集合
	 * @return 添加结果
	 */
	public int addChemicalCompoundReagents(ChemicalCompoundReagentsEntity compoundReagents) throws Exception;
	/*
	 * 添加生化镀膜关联关系对象
	 * @param chemicalReagentRelations 化学混合试剂对象
	 * @return 添加结果
	 */
	public int addChemicalReagentRelations(List<ChemicalReagentRelationEntity> chemicalReagentRelations) throws Exception;
	/*
	 * 删除化学混合试剂信息
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public int delChemicalCompoundReagents(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 删除生化镀膜关联关系对象
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public int delChemicalReagentRelations(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 修改生化镀膜信息
	 * @param chemicalReagentEntity 生化镀膜信息
	 * @return 修改结果
	 */
	public int modifyChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception;
	/*
	 * 删除生化镀膜信息
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 删除结果
	 */
	public int delChemicalReagent(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 查询化学混合试剂信息
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public List<ChemicalCompoundReagentsEntity> queryChemicalCompoundReagents(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 查询生化镀膜关联关系对象
	 * @param crIDs 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public List<ChemicalReagentRelationEntity> queryChemicalReagentRelations(@Param("crIDs") List<Integer> crIDs) throws Exception;
	/*
	 * 查询生化镀膜关联关系对象
	 * @param crID 需要删除的生化镀膜信息列表
	 * @return 添加结果
	 */
	public List<ChemicalReagentRelationEntity> getChemicalReagentRelations(@Param("crID") String crID) throws Exception;
	
}

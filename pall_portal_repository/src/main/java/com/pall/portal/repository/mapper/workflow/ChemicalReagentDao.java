package com.pall.portal.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentQueryFormEntity;

/*
 * 工作流数据访问层
 */
@Repository("chemicalReagentDao")
public interface ChemicalReagentDao {
	/*
	 * 根据条件查询化学试剂记录信息
	 * @param chemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 查询结果
	 */
	public List<ChemicalReagentEntity> queryChemicalReagentList(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity);
	/*
	 * 根据条件查询化学试剂记录数
	 * @param chemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 查询结果
	 */
	public int queryChemicalReagentTotalRecords(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity);
	/*
	 * 添加化学试剂信息
	 * @param chemicalReagentEntity 化学试剂对象
	 * @return 添加结果
	 */
	public int addChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception;
	/*
	 * 修改化学试剂信息
	 * @param chemicalReagentEntity 化学试剂信息
	 * @return 修改结果
	 */
	public int modifyChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception;
	/*
	 * 删除化学试剂信息
	 * @param crIDs 需要删除的化学试剂信息列表
	 * @return 删除结果
	 */
	public int delChemicalReagent(@Param("crIDs") List<Integer> crIDs) throws Exception;
	
}

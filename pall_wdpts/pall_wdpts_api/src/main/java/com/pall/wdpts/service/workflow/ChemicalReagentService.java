package com.pall.wdpts.service.workflow;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.wdpts.repository.entity.workflow.ChemicalReagentMixtureQueryFormEntity;
import com.pall.wdpts.repository.entity.workflow.ChemicalReagentQueryFormEntity;

/*
 * 工作流服务接口
 */
@Service
public interface ChemicalReagentService {
	/*
	 * 根据条件查询化学试剂记录信息
	 * @param chemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryChemicalReagentList(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity) throws Exception;
	/*
	 * 根据条件查询化学试剂混合信息
	 * @param chemicalReagentMixtureQueryFormEntity 化学混合试剂查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryChemicalReagentMixtureList(ChemicalReagentMixtureQueryFormEntity  chemicalReagentMixtureQueryFormEntity) throws Exception;
	/*
	 * 添加化学试剂信息
	 * @param chemicalReagentEntity 化学试剂信息
	 * @return 添加结果
	 */
	public BaseResponse addChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception;
	/*
	 * 修改化学试剂信息
	 * @param chemicalReagentEntity 化学试剂信息
	 * @return 修改结果
	 */
	public BaseResponse modifyChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception;
	/*
	 * 删除化学试剂信息
	 * @param crIDs 需要删除的化学试剂信息列表
	 * @return 删除结果
	 */
	public BaseResponse delChemicalReagent(List<Integer> crIDs) throws Exception;
	/*
	 * 导出化学试剂信息
	 * @param chemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportChemicalReagent(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity) throws Exception;
	/*
	 * 导出化学试剂信息
	 * @param chemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 导出结果
	 */
	public ChemicalReagentEntity getChemicalReagent(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity) throws Exception;
}

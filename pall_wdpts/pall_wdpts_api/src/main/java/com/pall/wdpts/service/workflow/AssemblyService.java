package com.pall.wdpts.service.workflow;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.workflow.AssemblyEntity;
import com.pall.wdpts.repository.entity.workflow.AssemblyQueryFormEntity;

/*
 * 工作流服务接口
 */
@Service
public interface AssemblyService {
	/*
	 * 根据条件查询组装记录信息
	 * @param assemblyQueryFormEntity 组装信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryAssemblyList(AssemblyQueryFormEntity  assemblyQueryFormEntity) throws Exception;
	/*
	 * 添加组装信息
	 * @param assemblyEntity 组装信息
	 * @return 添加结果
	 */
	public BaseResponse addAssembly(AssemblyEntity assemblyEntity) throws Exception;
	/*
	 * 修改组装信息
	 * @param assemblyEntity 组装信息
	 * @return 修改结果
	 */
	public BaseResponse modifyAssembly(AssemblyEntity assemblyEntity) throws Exception;
	/*
	 * 删除光学镀膜信息
	 * @param assemblyIDS 需要删除的组装信息列表
	 * @return 删除结果
	 */
	public BaseResponse delAssembly(List<Integer> assemblyIDS) throws Exception;
	/*
	 * 导出光学镀膜信息
	 * @param assemblyQueryFormEntity 组装信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportAssembly(AssemblyQueryFormEntity  assemblyQueryFormEntity) throws Exception;
}

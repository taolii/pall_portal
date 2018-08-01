package com.pall.wdpts.service.workflow;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.workflow.CleanEntity;
import com.pall.wdpts.repository.entity.workflow.CleanQueryFormEntity;

/*
 * 工作流服务接口
 */
@Service
public interface CleanService {
	/*
	 * 根据条件查询清洁记录信息
	 * @param cleanQueryFormEntity 清洁信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryCleanList(CleanQueryFormEntity cleanQueryFormEntity) throws Exception;
	/*
	 * 添加清洁信息
	 * @param cleanEntity 清洁信息
	 * @return 添加结果
	 */
	public BaseResponse addClean(CleanEntity cleanEntity) throws Exception;
	/*
	 * 修改清洁信息
	 * @param cleanEntity 清洁信息
	 * @return 修改结果
	 */
	public BaseResponse modifyClean(CleanEntity cleanEntity) throws Exception;
	/*
	 * 删除清洁信息
	 * @param cleanIDs 需要删除的清洁信息列表
	 * @return 删除结果
	 */
	public BaseResponse delClean(List<Integer> cleanIDs) throws Exception;
	/*
	 * 导出清洁信息
	 * @param cleanQueryFormEntity 
	 * @return 导出结果
	 */
	public BaseResponse exportClean(CleanQueryFormEntity cleanQueryFormEntity) throws Exception;
}

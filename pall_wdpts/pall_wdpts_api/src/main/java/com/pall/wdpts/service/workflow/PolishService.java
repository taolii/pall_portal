package com.pall.wdpts.service.workflow;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.workflow.PolishEntity;
import com.pall.wdpts.repository.entity.workflow.PolishQueryFormEntity;

/*
 * 工作流服务接口
 */
@Service
public interface PolishService {
	/*
	 * 根据条件查询抛光记录信息
	 * @param polishQueryFormEntity 抛光信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPolishList(PolishQueryFormEntity polishQueryFormEntity) throws Exception;
	/*
	 * 添加抛光信息
	 * @param polishEntity 抛光信息
	 * @return 添加结果
	 */
	public BaseResponse addPolish(PolishEntity polishEntity) throws Exception;
	/*
	 * 修改抛光信息
	 * @param polishEntity 抛光信息
	 * @return 修改结果
	 */
	public BaseResponse modifyPolish(PolishEntity polishEntity) throws Exception;
	/*
	 * 删除抛光信息
	 * @param polishIDs 需要删除的抛光信息列表
	 * @return 删除结果
	 */
	public BaseResponse delPolish(List<Integer> polishIDs) throws Exception;
	/*
	 * 导出抛光信息
	 * @param polishQueryFormEntity 
	 * @return 导出结果
	 */
	public BaseResponse exportPolish(PolishQueryFormEntity polishQueryFormEntity) throws Exception;
}

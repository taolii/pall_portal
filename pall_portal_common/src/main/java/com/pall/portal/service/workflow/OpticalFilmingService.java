package com.pall.portal.service.workflow;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity;
import com.pall.portal.repository.entity.workflow.OpticalFilmingQueryFormEntity;

/*
 * 工作流服务接口
 */
@Service
public interface OpticalFilmingService {
	/*
	 * 根据条件查询光学镀膜记录信息
	 * @param opticalFilmingQueryFormEntity 光学镀膜信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryOpticalFilmingList(OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity) throws Exception;
	/*
	 * 添加光学镀膜信息
	 * @param opticalCoatingEntity 光学镀膜信息
	 * @return 添加结果
	 */
	public BaseResponse addOpticalFilming(OpticalCoatingEntity opticalCoatingEntity) throws Exception;
	/*
	 * 修改光学镀膜信息
	 * @param opticalCoatingEntity 光学镀膜信息
	 * @return 修改结果
	 */
	public BaseResponse modifyOpticalFilming(OpticalCoatingEntity opticalCoatingEntity) throws Exception;
	/*
	 * 删除光学镀膜信息
	 * @param optIDs 需要删除的光学镀膜信息列表
	 * @return 删除结果
	 */
	public BaseResponse delOpticalFilming(List<Integer> optIDs) throws Exception;
	/*
	 * 导出光学镀膜信息
	 * @param opticalFilmingQueryFormEntity 光学镀膜信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportOpticalFilming(OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity) throws Exception;
}

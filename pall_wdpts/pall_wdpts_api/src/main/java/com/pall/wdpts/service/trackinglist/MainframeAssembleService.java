package com.pall.wdpts.service.trackinglist;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.MainframeEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;

/*
 * 工作流服务接口
 */
@Service
public interface MainframeAssembleService {
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeAssembleFormQueryEntity 主机装配查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMainframeAssembleList(MainframeFormQueryEntity  mainframeAssembleFormQueryEntity) throws Exception;
	/*
	 * 添加主机装配信息
	 * @param mainframeAssembleEntity 主机装配信息
	 * @return 添加结果
	 */
	public BaseResponse addMainframeAssemble(MainframeEntity mainframeAssembleEntity) throws Exception;
	/*
	 * 修改主机装配信息
	 * @param MainframeAssembleEntity 主机装配信息
	 * @return 修改结果
	 */
	public BaseResponse modifyMainframeAssemble(MainframeEntity mainframeAssembleEntity) throws Exception;
	/*
	 * 删除主机装配信息
	 * @param mainframeAssembleIDS 需要删除的主机装配列表
	 * @return 删除结果
	 */
	public BaseResponse delMainframeAssemble(List<Integer> mainframeAssembleIDS) throws Exception;
	/*
	 * 导出主机装配信息
	 * @param mainframeAssembleFormQueryEntity 主机装配信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportMainframeAssemble(MainframeFormQueryEntity  mainframeAssembleFormQueryEntity) throws Exception;
}

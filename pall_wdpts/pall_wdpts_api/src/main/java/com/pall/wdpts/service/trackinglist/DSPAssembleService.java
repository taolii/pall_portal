package com.pall.wdpts.service.trackinglist;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.DSPEntity;
import com.pall.wdpts.repository.entity.trackinglist.DSPFormQueryEntity;

/*
 * 工作流服务接口
 */
@Service
public interface DSPAssembleService {
	/*
	 * 根据条件查询DSP装配记录信息
	 * @param dspAssembleFormQueryEntity DSP装配查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryDSPAssembleList(DSPFormQueryEntity  dspAssembleFormQueryEntity) throws Exception;
	/*
	 * 添加DSP装配信息
	 * @param dspAssembleEntity DSP装配信息
	 * @return 添加结果
	 */
	public BaseResponse addDSPAssemble(DSPEntity dspAssembleEntity) throws Exception;
	/*
	 * 修改DSP装配信息
	 * @param dspAssembleEntity DSP装配信息
	 * @return 修改结果
	 */
	public BaseResponse modifyDSPAssemble(DSPEntity dspAssembleEntity) throws Exception;
	/*
	 * 删除DSP装配信息
	 * @param dspAssembleIDS 需要删除的DSP装配列表
	 * @return 删除结果
	 */
	public BaseResponse delDSPAssemble(List<Integer> dspAssembleIDS) throws Exception;
	/*
	 * 导出DSP装配信息
	 * @param dspAssembleFormQueryEntity DSP装配信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportDSPAssemble(DSPFormQueryEntity  dspAssembleFormQueryEntity) throws Exception;
}

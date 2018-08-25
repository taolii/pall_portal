package com.pall.wdpts.service.trackinglist;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.CisternEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternFormQueryEntity;

/*
 * 工作流服务接口
 */
@Service
public interface CisternAssembleService {
	/*
	 * 根据条件查询水箱装配记录信息
	 * @param cisternAssembleFormQueryEntity 水箱装配查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryCisternAssembleList(CisternFormQueryEntity  cisternAssembleFormQueryEntity) throws Exception;
	/*
	 * 添加水箱装配信息
	 * @param cisternAssembleEntity 水箱装配信息
	 * @return 添加结果
	 */
	public BaseResponse addCisternAssemble(CisternEntity cisternAssembleEntity) throws Exception;
	/*
	 * 修改水箱装配信息
	 * @param cisternAssembleEntity 水箱装配信息
	 * @return 修改结果
	 */
	public BaseResponse modifyCisternAssemble(CisternEntity cisternAssembleEntity) throws Exception;
	/*
	 * 删除水箱装配信息
	 * @param cisternAssembleIDS 需要删除的水箱装配列表
	 * @return 删除结果
	 */
	public BaseResponse delCisternAssemble(List<Integer> cisternAssembleIDS) throws Exception;
	/*
	 * 导出水箱装配信息
	 * @param cisternAssembleFormQueryEntity 水箱装配信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportCisternAssemble(CisternFormQueryEntity  cisternAssembleFormQueryEntity) throws Exception;
}

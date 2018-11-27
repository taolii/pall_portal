package com.pall.wdpts.service.trackinglist;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.CisternEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingFormQueryEntity;

/*
 * 工作流服务接口
 */
@Service
public interface CisternService {
	/*
	 * 根据条件查询水箱装配记录信息
	 * @param cisternFormQueryEntity 水箱装配查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryCisternList(CisternFormQueryEntity  cisternFormQueryEntity) throws Exception;
	/*
	 * 根据条件导出水箱装配记录信息
	 * @param cisternFormQueryEntity 水箱装配查询对象
	 * @return 查询结果
	 */
	public List<CisternEntity> exportCisternList(CisternFormQueryEntity  cisternFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询水箱装配记录信息
	 * @param cisternID 水箱装配查询对象
	 * @return 查询结果
	 */
	public CisternEntity queryCistern(String  cisternID) throws Exception;
	/*
	 * 添加水箱装配信息
	 * @param cisternAssembleEntity 水箱装配信息
	 * @return 添加结果
	 */
	public BaseResponse addCistern(CisternEntity cisternEntity) throws Exception;
	/*
	 * 修改水箱装配信息
	 * @param cisternAssembleEntity 水箱装配信息
	 * @return 修改结果
	 */
	public BaseResponse modifyCistern(CisternEntity cisternEntity) throws Exception;
	/*
	 * 删除水箱装配信息
	 * @param cisternAssembleIDS 需要删除的水箱装配列表
	 * @return 删除结果
	 */
	public BaseResponse delCistern(List<Integer> cisternIDS) throws Exception;
	/*
	 * 根据条件查询水箱装配信息
	 * @param csid 水箱唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryCisternAssembleList(String  cisternID) throws Exception;
	/*
	 * 根据条件查询水箱配置信息
	 * @param cisternSettingFormQueryEntity 水箱配置查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryCisternSettingList(CisternSettingFormQueryEntity  cisternSettingFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询水箱配置信息
	 * @param csid 水箱配置唯一标示
	 * @return 查询结果
	 */
	public CisternSettingEntity queryCisternSetting(String  csid) throws Exception;
	/*
	 * 添加水箱装配配置信息
	 * @param cisternSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse addCisternSetting(CisternSettingEntity cisternSettingEntity) throws Exception;
	/*
	 * 修改水箱装配配置信息
	 * @param cisternSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse modCisternSetting(CisternSettingEntity cisternSettingEntity) throws Exception;
	/*
	 * 删除水箱装配配置信息
	 * @param csids 删除列表信息
	 * @return 添加结果
	 */
	public BaseResponse delCisternSetting(List<Integer> csids) throws Exception;
	/*
	 * 根据条件查询水箱装配配置信息
	 * @param csid 水箱配置唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryCisternSettingAssembleList(String  csid) throws Exception;
	
}

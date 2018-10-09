package com.pall.wdpts.service.trackinglist;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.MainframeEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingFormQueryEntity;

/*
 * 工作流服务接口
 */
@Service
public interface MainframeService {
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeFormQueryEntity 主机装配查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMainframeList(MainframeFormQueryEntity  mainframeFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeID 主机配查询对象
	 * @return 查询结果
	 */
	public MainframeEntity queryMainframe(String  mainframeID) throws Exception;
	/*
	 * 添加主机装配信息
	 * @param mainframeEntity 主机装配信息
	 * @return 添加结果
	 */
	public BaseResponse addMainframe(MainframeEntity mainframeEntity) throws Exception;
	/*
	 * 修改主机装配信息
	 * @param MainframeEntity 主机装配信息
	 * @return 修改结果
	 */
	public BaseResponse modifyMainframe(MainframeEntity mainframeEntity) throws Exception;
	/*
	 * 删除主机装配信息
	 * @param mainframeIDS 需要删除的主机装配列表
	 * @return 删除结果
	 */
	public BaseResponse delMainframe(List<Integer> mainframeIDS) throws Exception;
	/*
	 * 根据条件查询主机装配信息
	 * @param mid 主机唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMainframeAssembleList(String  mainframeID) throws Exception;
	/*
	 * 根据条件查询 主机送检信息
	 * @param mainframeID 主机唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMainframeInspectList(String  mainframeID) throws Exception;
	/*
	 * 根据条件查询主机配置信息
	 * @param mainframeSettingFormQueryEntity 主机配置查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMainframeSettingList(MainframeSettingFormQueryEntity  mainframeSettingFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询主机配置信息
	 * @param msid 主机配置唯一标示
	 * @return 查询结果
	 */
	public MainframeSettingEntity queryMainframeSetting(String  msid) throws Exception;
	/*
	 * 添加主机装配配置信息
	 * @param mainframeSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse addMainframeSetting(MainframeSettingEntity mainframeSettingEntity) throws Exception;
	/*
	 * 修改主机装配配置信息
	 * @param mainframeSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse modMainframeSetting(MainframeSettingEntity mainframeSettingEntity) throws Exception;
	/*
	 * 删除主机装配配置信息
	 * @param msids 删除列表信息
	 * @return 添加结果
	 */
	public BaseResponse delMainframeSetting(List<Integer> msids) throws Exception;
	/*
	 * 根据条件查询主机装配配置信息
	 * @param msid 主机配置唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMainframeSettingAssembleList(String  msid) throws Exception;
	/*
	 * 根据条件查询 主机送检配置信息
	 * @param msid 主机配置唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMainframeSettingInspectList(String  msid) throws Exception;
}

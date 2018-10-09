package com.pall.wdpts.service.trackinglist;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.DspEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingFormQueryEntity;

/*
 * 工作流服务接口
 */
@Service
public interface DspService {
	/*
	 * 根据条件查询Dsp装配记录信息
	 * @param dspFormQueryEntity Dsp装配查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryDspList(DspFormQueryEntity  dspFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询Dsp装配记录信息
	 * @param dspID Dsp装配查询对象
	 * @return 查询结果
	 */
	public DspEntity queryDsp(String  dspID) throws Exception;
	/*
	 * 添加Dsp装配信息
	 * @param dspEntity Dsp装配信息
	 * @return 添加结果
	 */
	public BaseResponse addDsp(DspEntity dspEntity) throws Exception;
	/*
	 * 修改Dsp装配信息
	 * @param dspEntity Dsp装配信息
	 * @return 修改结果
	 */
	public BaseResponse modifyDsp(DspEntity dspEntity) throws Exception;
	/*
	 * 删除Dsp装配信息
	 * @param dspAssembleIDS 需要删除的Dsp装配列表
	 * @return 删除结果
	 */
	public BaseResponse delDsp(List<Integer> dspIDS) throws Exception;
	/*
	 * 根据条件查询Dsp装配信息
	 * @param dspID Dsp唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryDspAssembleList(String  dspID) throws Exception;
	/*
	 * 根据条件查询Dsp配置信息
	 * @param dspSettingFormQueryEntity Dsp配置查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryDspSettingList(DspSettingFormQueryEntity  dspSettingFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询Dsp配置信息
	 * @param dsid Dsp配置唯一标示
	 * @return 查询结果
	 */
	public DspSettingEntity queryDspSetting(String  dsid) throws Exception;
	/*
	 * 添加Dsp装配配置信息
	 * @param dspSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse addDspSetting(DspSettingEntity dspSettingEntity) throws Exception;
	/*
	 * 修改Dsp装配配置信息
	 * @param dspSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse modDspSetting(DspSettingEntity dspSettingEntity) throws Exception;
	/*
	 * 删除Dsp装配配置信息
	 * @param dsids 删除列表信息
	 * @return 添加结果
	 */
	public BaseResponse delDspSetting(List<Integer> dsids) throws Exception;
	/*
	 * 根据条件查询Dsp装配配置信息
	 * @param dsid Dsp配置唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryDspSettingAssembleList(String  dsid) throws Exception;
}

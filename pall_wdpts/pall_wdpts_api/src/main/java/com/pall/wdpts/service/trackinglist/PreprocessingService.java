package com.pall.wdpts.service.trackinglist;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingFormQueryEntity;

/*
 * 工作流服务接口
 */
@Service
public interface PreprocessingService {
	/*
	 * 根据条件查询预处理装配记录信息
	 * @param preprocessingFormQueryEntity 预处理装配查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPreprocessingList(PreprocessingFormQueryEntity  preprocessingFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询预处理装配记录信息
	 * @param preprocessingID 预处理装配查询对象
	 * @return 查询结果
	 */
	public PreprocessingEntity queryPreprocessing(String  preprocessingID) throws Exception;
	/*
	 * 添加预处理装配信息
	 * @param preprocessingEntity 预处理装配信息
	 * @return 添加结果
	 */
	public BaseResponse addPreprocessing(PreprocessingEntity preprocessingEntity) throws Exception;
	/*
	 * 修改预处理装配信息
	 * @param preprocessingEntity 预处理装配信息
	 * @return 修改结果
	 */
	public BaseResponse modifyPreprocessing(PreprocessingEntity preprocessingEntity) throws Exception;
	/*
	 * 删除预处理装配信息
	 * @param preprocessingAssembleIDS 需要删除的预处理装配列表
	 * @return 删除结果
	 */
	public BaseResponse delPreprocessing(List<Integer> preprocessingIDS) throws Exception;
	/*
	 * 根据条件查询预处理装配信息
	 * @param psid 预处理唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPreprocessingAssembleList(String  preprocessingID) throws Exception;
	/*
	 * 根据条件查询 预处理送检信息
	 * @param preprocessingID 预处理唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPreprocessingInspectList(String  preprocessingID) throws Exception;
	/*
	 * 根据条件查询预处理配置信息
	 * @param preprocessingSettingFormQueryEntity 预处理配置查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPreprocessingSettingList(PreprocessingSettingFormQueryEntity  preprocessingSettingFormQueryEntity) throws Exception;
	/*
	 * 根据条件查询预处理配置信息
	 * @param psid 预处理配置唯一标示
	 * @return 查询结果
	 */
	public PreprocessingSettingEntity queryPreprocessingSetting(String  psid) throws Exception;
	/*
	 * 添加预处理装配配置信息
	 * @param preprocessingSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse addPreprocessingSetting(PreprocessingSettingEntity preprocessingSettingEntity) throws Exception;
	/*
	 * 修改预处理装配配置信息
	 * @param preprocessingSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public BaseResponse modPreprocessingSetting(PreprocessingSettingEntity preprocessingSettingEntity) throws Exception;
	/*
	 * 删除预处理装配配置信息
	 * @param psids 删除列表信息
	 * @return 添加结果
	 */
	public BaseResponse delPreprocessingSetting(List<Integer> psids) throws Exception;
	/*
	 * 根据条件查询预处理装配配置信息
	 * @param psid 预处理配置唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPreprocessingSettingAssembleList(String  psid) throws Exception;
	/*
	 * 根据条件查询 预处理送检配置信息
	 * @param psid 预处理配置唯一标示
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPreprocessingSettingInspectList(String  psid) throws Exception;
}

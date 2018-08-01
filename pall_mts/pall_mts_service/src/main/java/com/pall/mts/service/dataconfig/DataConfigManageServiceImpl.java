package com.pall.mts.service.dataconfig;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.mts.common.constants.IResponseConstants;
import com.pall.mts.common.datatables.Entity.DatatablesView;
import com.pall.mts.common.i18n.ResourceUtils;
import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.repository.entity.dataconfig.DataConfigEntity;
import com.pall.mts.repository.entity.dataconfig.DataConfigQueryFormEntity;
import com.pall.mts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.mts.repository.entity.dataconfig.UmsConfigEntity;
import com.pall.mts.repository.mapper.dataconfig.DataConfigManageDao;
import com.pall.mts.service.dataconfig.DataConfigManageService;

/*
 * 数据配置管理服务
 */
@Repository
public class DataConfigManageServiceImpl implements DataConfigManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private DataConfigManageDao dataConfigManageDao;
	
	@Override
	public BaseTablesResponse queryDataConfigList(DataConfigQueryFormEntity  dataConfigQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=dataConfigManageDao.queryDataConfigTotalRecords(dataConfigQueryFormEntity);
			//分页查询结果集
			List<DataConfigEntity> dataConfigEntitys=dataConfigManageDao.queryDataConfigList(dataConfigQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(dataConfigQueryFormEntity.getDraw());
			if(dataConfigEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(dataConfigEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dataconfigmanage.service.queryDataConfigList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.service.queryDataConfigList.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delDataConfig(List<String> dataids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			dataConfigManageDao.delDataConfig(dataids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dataconfigmanage.delDataconfig.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.delDataconfig.service.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse addDataConfig(DataConfigEntity dataConfigEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//查询configName是否存在
			DataConfigQueryFormEntity dataConfigQueryFormEntity=new DataConfigQueryFormEntity();
			dataConfigQueryFormEntity.setDataType(dataConfigEntity.getDataType());
			dataConfigQueryFormEntity.setConfigName(dataConfigEntity.getConfigName());
			int totalCount=dataConfigManageDao.queryDataConfigTotalRecords(dataConfigQueryFormEntity);
			if(totalCount>=1){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(dataConfigEntity.getConfigName()+resourceUtils.getMessage("dataconfigmanage.configName.exists"));
				return baseResponse;
			}
			int resultNum=dataConfigManageDao.addDataConfig(dataConfigEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.addDataconfig.dao.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dataconfigmanage.addDataconfig.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.addDataconfig.service.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modDataConfig(DataConfigEntity dataConfigEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			
			int resultNum=dataConfigManageDao.modDataConfig(dataConfigEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.modDataconfig.dao.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dataconfigmanage.modDataconfig.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.modDataconfig.service.exception"));
		}
		return baseResponse;
	}
	@Override
	public List<TableHeaderConfigEntity> queryTableHeaderConfigList() throws Exception {
		return dataConfigManageDao.queryTableHeaderConfigList();
	}
	@Override
	public List<DataConfigEntity> queryDataConfigList() throws Exception {
		DataConfigQueryFormEntity  dataConfigQueryFormEntity=new DataConfigQueryFormEntity();
		dataConfigQueryFormEntity.setStartPageNum(0);
		dataConfigQueryFormEntity.setPageSize(Integer.MAX_VALUE);
		List<DataConfigEntity> dataConfigEntitys=dataConfigManageDao.queryDataConfigList(dataConfigQueryFormEntity);
		return dataConfigEntitys;
	}
	@Override
	public List<UmsConfigEntity> queryUmsConfigList() throws Exception {
		return dataConfigManageDao.queryUmsConfigList();
	}

}

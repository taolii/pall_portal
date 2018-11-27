package com.pall.wdpts.service.trackinglist;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.datatables.Entity.DatatablesView;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.MainframeAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeInspectEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingInspectEntity;
import com.pall.wdpts.repository.mapper.trackinglist.MainframeDao;

/*
 * 工作流服务接口
 */
@Repository
public class MainframeServiceImpl implements MainframeService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private MainframeDao mainframeDao;
	@Autowired
	private ResourceUtils resourceUtils;
	
	@Override
	public BaseTablesResponse queryMainframeList(
			MainframeFormQueryEntity mainframeFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=mainframeDao.queryMainframeTotalRecords(mainframeFormQueryEntity);
			//分页查询结果集
			List<MainframeEntity> mainframeAssembleEntitys=mainframeDao.queryMainframeList(mainframeFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(mainframeFormQueryEntity.getDraw());
			if(mainframeAssembleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(mainframeAssembleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframeList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframeList.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse addMainframe(MainframeEntity mainframeEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			MainframeFormQueryEntity mainframeFormQueryEntity=new MainframeFormQueryEntity();
			mainframeFormQueryEntity.setSerialNo(mainframeEntity.getSerialNo());
			int records=mainframeDao.queryMainframeTotalRecords(mainframeFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.form.serialNo.exists"));
				return baseResponse;
			}
			int resultNum=mainframeDao.addMainframe(mainframeEntity);
			if(resultNum>0){
				//添加主机装配配置信息
				List<MainframeAssembleEntity> mainframeAssembles=mainframeEntity.getAssembleRecords();
				if(mainframeAssembles!=null && mainframeAssembles.size()>0){
					for(MainframeAssembleEntity mainframeAssembleEntity:mainframeAssembles){
						mainframeAssembleEntity.setMainframeID(mainframeEntity.getMainframeID());
					}
					resultNum=mainframeDao.addMainframeAssembles(mainframeAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加主机送检配置信息
				List<MainframeInspectEntity> mainframeInspects=mainframeEntity.getInspectRecords();
				if(mainframeInspects!=null && mainframeInspects.size()>0){
					for(MainframeInspectEntity mainframeInspectEntity:mainframeInspects){
						mainframeInspectEntity.setMainframeID(mainframeEntity.getMainframeID());
					}
					resultNum=mainframeDao.addMainframeInspects(mainframeInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframe.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.addMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.addMainframe.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modifyMainframe(MainframeEntity mainframeEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			MainframeFormQueryEntity mainframeFormQueryEntity=new MainframeFormQueryEntity();;
			mainframeFormQueryEntity.setStartPageNum(0);
			mainframeFormQueryEntity.setPageSize(Integer.MAX_VALUE);
			mainframeFormQueryEntity.setSerialNo(mainframeEntity.getSerialNo());
			List<MainframeEntity> mainframeEntitys=mainframeDao.queryMainframeList(mainframeFormQueryEntity);
			if(null!=mainframeEntitys && mainframeEntitys.size()>=1){
				if(mainframeEntitys.size()==1 && mainframeEntitys.get(0).getSerialNo().equals(mainframeEntity.getSerialNo())){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.form.serialNo.exists"));
					return baseResponse;
				}
			}
			int resultNum=mainframeDao.modMainframe(mainframeEntity);
			if(resultNum>0){
				List<Integer> mainframeids=new ArrayList<Integer>();
				mainframeids.add(mainframeEntity.getMainframeID());
				mainframeDao.delMainframeAssembles(mainframeids);
				mainframeDao.delMainframeInspects(mainframeids);
				//添加主机装配配置信息
				List<MainframeAssembleEntity> mainframeAssembles=mainframeEntity.getAssembleRecords();
				if(mainframeAssembles!=null && mainframeAssembles.size()>0){
					for(MainframeAssembleEntity mainframeAssembleEntity:mainframeAssembles){
						mainframeAssembleEntity.setMainframeID(mainframeEntity.getMainframeID());
					}
					resultNum=mainframeDao.addMainframeAssembles(mainframeAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加主机送检配置信息
				List<MainframeInspectEntity> mainframeInspects=mainframeEntity.getInspectRecords();
				if(mainframeInspects!=null && mainframeInspects.size()>0){
					for(MainframeInspectEntity mainframeInspectEntity:mainframeInspects){
						mainframeInspectEntity.setMainframeID(mainframeEntity.getMainframeID());
					}
					resultNum=mainframeDao.addMainframeInspects(mainframeInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.modMainframe.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.modMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.modMainframe.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delMainframe(List<Integer> mainframeIDS) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			mainframeDao.delMainframeInspects(mainframeIDS);
			mainframeDao.delMainframeAssembles(mainframeIDS);
			mainframeDao.delMainframe(mainframeIDS);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.delMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.delMainframe.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryMainframeSettingList(
			MainframeSettingFormQueryEntity mainframeSettingFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=mainframeDao.queryMainframeSettingTotalRecords(mainframeSettingFormQueryEntity);
			//分页查询结果集
			List<MainframeSettingEntity> mainframeSettingEntitys=mainframeDao.queryMainframeSettingList(mainframeSettingFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(mainframeSettingFormQueryEntity.getDraw());
			if(mainframeSettingEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(mainframeSettingEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframeSettingList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframeSettingList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addMainframeSetting(MainframeSettingEntity mainframeSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//判断mainframePn是否存在
			MainframeSettingFormQueryEntity mainframeSettingFormQueryEntity=new MainframeSettingFormQueryEntity();
			mainframeSettingFormQueryEntity.setMainframePn(mainframeSettingEntity.getMainframePn());
			int records=mainframeDao.queryMainframeSettingTotalRecords(mainframeSettingFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.form.mainframePn.exists"));
				return baseResponse;
			}
			int resultNum=mainframeDao.addMainframeSetting(mainframeSettingEntity);
			if(resultNum>0){
				//添加主机装配配置信息
				List<MainframeSettingAssembleEntity> mainframeSettingAssembles=mainframeSettingEntity.getMainframeSettingAssembles();
				if(mainframeSettingAssembles!=null && mainframeSettingAssembles.size()>0){
					for(MainframeSettingAssembleEntity mainframeSettingAssembleEntity:mainframeSettingAssembles){
						mainframeSettingAssembleEntity.setMsid(mainframeSettingEntity.getMsid());;
					}
					resultNum=mainframeDao.addMainframeSettingAssembles(mainframeSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加主机送检配置信息
				List<MainframeSettingInspectEntity> mainframeSettingInspects=mainframeSettingEntity.getMainframeSettingInspects();
				if(mainframeSettingInspects!=null && mainframeSettingInspects.size()>0){
					for(MainframeSettingInspectEntity mainframeSettingInspectEntity:mainframeSettingInspects){
						mainframeSettingInspectEntity.setMsid(mainframeSettingEntity.getMsid());;
					}
					resultNum=mainframeDao.addMainframeSettingInspects(mainframeSettingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeSettingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.addMainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.addMainframeSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modMainframeSetting(MainframeSettingEntity mainframeSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			MainframeSettingFormQueryEntity mainframeSettingFormQueryEntity=new MainframeSettingFormQueryEntity();
			mainframeSettingFormQueryEntity.setMainframePn(mainframeSettingEntity.getMainframePn());
			mainframeSettingFormQueryEntity.setStartPageNum(0);
			mainframeSettingFormQueryEntity.setPageSize(Integer.MAX_VALUE);
			List<MainframeSettingEntity> mainframeSettingEntitys=mainframeDao.queryMainframeSettingList(mainframeSettingFormQueryEntity);
			if(null!=mainframeSettingEntitys && mainframeSettingEntitys.size()>=1){
				if(mainframeSettingEntitys.size()==1 && mainframeSettingEntitys.get(0).getMainframePn().equals(mainframeSettingEntity.getMainframePn())){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.form.mainframePn.exists"));
					return baseResponse;
				}
			}
			int resultNum=mainframeDao.modMainframeSetting(mainframeSettingEntity);
			if(resultNum>0){
				List<Integer> msids=new ArrayList<Integer>();
				msids.add(mainframeSettingEntity.getMsid());
				mainframeDao.delMainframeSettingAssembles(msids);
				mainframeDao.delMainframeSettingInspects(msids);
				//添加主机装配配置信息
				List<MainframeSettingAssembleEntity> mainframeSettingAssembles=mainframeSettingEntity.getMainframeSettingAssembles();
				if(mainframeSettingAssembles!=null && mainframeSettingAssembles.size()>0){
					for(MainframeSettingAssembleEntity mainframeSettingAssembleEntity:mainframeSettingAssembles){
						mainframeSettingAssembleEntity.setMsid(mainframeSettingEntity.getMsid());;
					}
					resultNum=mainframeDao.addMainframeSettingAssembles(mainframeSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加主机送检配置信息
				List<MainframeSettingInspectEntity> mainframeSettingInspects=mainframeSettingEntity.getMainframeSettingInspects();
				if(mainframeSettingInspects!=null && mainframeSettingInspects.size()>0){
					for(MainframeSettingInspectEntity mainframeSettingInspectEntity:mainframeSettingInspects){
						mainframeSettingInspectEntity.setMsid(mainframeSettingEntity.getMsid());;
					}
					resultNum=mainframeDao.addMainframeSettingInspects(mainframeSettingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.addMainframeSettingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.dao.modMainframeSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.modMainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.modMainframeSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delMainframeSetting(List<Integer> psids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			mainframeDao.delMainframeSettingInspects(psids);
			mainframeDao.delMainframeSettingAssembles(psids);
			mainframeDao.delMainframeSetting(psids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.delMainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.delMainframeSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryMainframeSettingAssembleList(String psid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<MainframeSettingAssembleEntity> mainframeSettingAssembles=mainframeDao.queryMainframeSettingAssembleList(psid);
			DatatablesView datatablesViews=new DatatablesView();
			if(mainframeSettingAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(mainframeSettingAssembles.size());
				datatablesViews.setRecordsTotal(mainframeSettingAssembles.size());
				datatablesViews.setData(mainframeSettingAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryMainframeSettingInspectList(String  msid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<MainframeSettingInspectEntity> mainframeSettingInspects=mainframeDao.queryMainframeSettingInspectList(msid);
			DatatablesView datatablesViews=new DatatablesView();
			if(mainframeSettingInspects!=null){
				datatablesViews.setiTotalDisplayRecords(mainframeSettingInspects.size());
				datatablesViews.setRecordsTotal(mainframeSettingInspects.size());
				datatablesViews.setData(mainframeSettingInspects);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public MainframeSettingEntity queryMainframeSetting(String msid) throws Exception {
		MainframeSettingEntity mainframeSettingEntity=null;
		try{
			MainframeSettingFormQueryEntity mainframeSettingFormQuery=new MainframeSettingFormQueryEntity();
			mainframeSettingFormQuery.setPageSize(1);
			mainframeSettingFormQuery.setStartPageNum(0);
			mainframeSettingFormQuery.setMsid(msid);
			List<MainframeSettingEntity> mainframeSettingEntitys=mainframeDao.queryMainframeSettingList(mainframeSettingFormQuery);
			if(mainframeSettingEntitys!=null && mainframeSettingEntitys.size()>0){
				mainframeSettingEntity=mainframeSettingEntitys.get(0);
				mainframeSettingEntity.setMainframeSettingAssembles(mainframeDao.queryMainframeSettingAssembleList(msid));
				mainframeSettingEntity.setMainframeSettingInspects(mainframeDao.queryMainframeSettingInspectList(msid));
			}
		}catch(Exception e){
			throw e;
		}
		return mainframeSettingEntity;
	}

	@Override
	public MainframeEntity queryMainframe(String mainframeID) throws Exception {
		MainframeEntity mainframeEntity=null;
		try{
			MainframeFormQueryEntity mainframeFormQuery=new MainframeFormQueryEntity();
			mainframeFormQuery.setPageSize(1);
			mainframeFormQuery.setStartPageNum(0);
			mainframeFormQuery.setMainframeID(mainframeID);
			List<MainframeEntity> mainframeEntitys=mainframeDao.queryMainframeList(mainframeFormQuery);
			if(mainframeEntitys!=null && mainframeEntitys.size()>0){
				mainframeEntity=mainframeEntitys.get(0);
				mainframeEntity.setAssembleRecords(mainframeDao.queryMainframeAssembleList(mainframeID));
				mainframeEntity.setInspectRecords(mainframeDao.queryMainframeInspectList(mainframeID));
			}
		}catch(Exception e){
			throw e;
		}
		return mainframeEntity;
	}

	@Override
	public BaseTablesResponse queryMainframeAssembleList(String mainframeID) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<MainframeAssembleEntity> mainframeAssembles=mainframeDao.queryMainframeAssembleList(mainframeID);
			DatatablesView datatablesViews=new DatatablesView();
			if(mainframeAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(mainframeAssembles.size());
				datatablesViews.setRecordsTotal(mainframeAssembles.size());
				datatablesViews.setData(mainframeAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryMainframeInspectList(String mainframeID) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<MainframeInspectEntity> mainframeInspects=mainframeDao.queryMainframeInspectList(mainframeID);
			DatatablesView datatablesViews=new DatatablesView();
			if(mainframeInspects!=null){
				datatablesViews.setiTotalDisplayRecords(mainframeInspects.size());
				datatablesViews.setRecordsTotal(mainframeInspects.size());
				datatablesViews.setData(mainframeInspects);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframeAssembleList.exception"));
		}
		return baseResponse;
	}
	@Override
	public List<MainframeEntity> exportMainframeList(MainframeFormQueryEntity mainframeFormQueryEntity) throws Exception {
		List<MainframeEntity> mainframeEntitys=null;
		try{
			mainframeFormQueryEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=mainframeDao.queryMainframeTotalRecords(mainframeFormQueryEntity);
			if(totalRecords==0){
				return new ArrayList<MainframeEntity>();
			}
			//分页查询结果集
			mainframeFormQueryEntity.setPageSize(totalRecords);
			mainframeEntitys=mainframeDao.queryMainframeList(mainframeFormQueryEntity);
		}catch(Exception e){
			throw e;
		}
		return mainframeEntitys;
	}
	
}

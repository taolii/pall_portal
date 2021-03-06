package com.pall.mts.service.workflow;

import java.util.ArrayList;
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
import com.pall.mts.repository.entity.workflow.PlatedFilmEntity;
import com.pall.mts.repository.entity.workflow.PlatedFilmQueryFormEntity;
import com.pall.mts.repository.mapper.workflow.PlatedFilmDao;

/*
 * 工作流服务实现类
 */
@Repository
public class PlatedFilmServiceImpl implements PlatedFilmService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private PlatedFilmDao platedFilmDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryPlatedFilmList(PlatedFilmQueryFormEntity  platedFilmQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=platedFilmDao.queryPlatedFilmTotalRecords(platedFilmQueryFormEntity);
			//分页查询结果集
			List<PlatedFilmEntity> platedFilmEntitys=platedFilmDao.queryPlatedFilmList(platedFilmQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(platedFilmQueryFormEntity.getDraw());
			if(platedFilmEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(platedFilmEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("platedfilmManage.workflow.service.queryPlatedFilmList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.service.queryPlatedFilmList.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse addPlatedFilm(PlatedFilmEntity platedFilmEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			PlatedFilmQueryFormEntity platedFilmQueryFormEntity=new PlatedFilmQueryFormEntity();
			platedFilmQueryFormEntity.setFixtureNum(platedFilmEntity.getFixtureNum());
			platedFilmQueryFormEntity.setInputLotNum(platedFilmEntity.getInputLotNum());
			int totalCount=platedFilmDao.queryPlatedFilmTotalRecords(platedFilmQueryFormEntity);
			if(totalCount>=1){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.service.addPlatedFilm.fixtureandinputlotnum.exists"));
				return baseResponse;
			}
			int resultNum=platedFilmDao.addPlatedFilm(platedFilmEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.dao.addPlatedFilm.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("platedfilmManage.workflow.service.addPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.service.addPlatedFilm.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse  modifyPlatedFilm(PlatedFilmEntity platedFilmEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			PlatedFilmQueryFormEntity platedFilmQueryFormEntity=new PlatedFilmQueryFormEntity();
			platedFilmQueryFormEntity.setStartPageNum(0);
			platedFilmQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			platedFilmQueryFormEntity.setFixtureNum(platedFilmEntity.getFixtureNum());
			platedFilmQueryFormEntity.setInputLotNum(platedFilmEntity.getInputLotNum());
			List<PlatedFilmEntity> platedFilmEntitys=platedFilmDao.queryPlatedFilmList(platedFilmQueryFormEntity);
			if(null!=platedFilmEntitys && platedFilmEntitys.size()>=1){
				if(platedFilmEntitys.size()==1 && platedFilmEntitys.get(0).getPfID().intValue()==platedFilmEntity.getPfID().intValue()){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.service.modifyPlatedFilm.fixtureandinputlotnum.exists"));
					return baseResponse;
				}
			}
			int resultNum=platedFilmDao.modifyPlatedFilm(platedFilmEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.dao.modifyPlatedFilm.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("platedfilmManage.workflow.service.modifyPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.service.modifyPlatedFilm.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delPlatedFilm(List<Integer> pfIDs)  throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			platedFilmDao.delPlatedFilm(pfIDs);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("platedfilmManage.workflow.service.delPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.service.delPlatedFilm.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse exportPlatedFilm(PlatedFilmQueryFormEntity  platedFilmQueryFormEntity)  throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			platedFilmQueryFormEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=platedFilmDao.queryPlatedFilmTotalRecords(platedFilmQueryFormEntity);
			if(totalRecords==0){
				baseResponse.setReturnObjects(new ArrayList<PlatedFilmEntity>());
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				return baseResponse;
			}
			//分页查询结果集
			platedFilmQueryFormEntity.setPageSize(totalRecords);
			List<PlatedFilmEntity> opticalCoatingEntitys=platedFilmDao.queryPlatedFilmList(platedFilmQueryFormEntity);
			baseResponse.setReturnObjects(opticalCoatingEntitys);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("platedfilmManage.workflow.service.exportPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.workflow.service.exportPlatedFilm.exception"));
		}
		return baseResponse;
	}
	
}

package com.pall.wdpts.service.trackinglist;

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
import com.pall.wdpts.repository.entity.trackinglist.MainframeEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;
import com.pall.wdpts.repository.mapper.trackinglist.MainframeAssembleDao;

/*
 * 工作流服务接口
 */
@Repository
public class MainframeAssembleServiceImpl implements MainframeAssembleService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private MainframeAssembleDao mainframeAssembleDao;
	@Autowired
	private ResourceUtils resourceUtils;
	
	@Override
	public BaseTablesResponse queryMainframeAssembleList(
			MainframeFormQueryEntity mainframeAssembleFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=mainframeAssembleDao.queryMainframeTotalRecords(mainframeAssembleFormQueryEntity);
			//分页查询结果集
			List<MainframeEntity> mainframeAssembleEntitys=mainframeAssembleDao.queryMainframeList(mainframeAssembleFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(mainframeAssembleFormQueryEntity.getDraw());
			if(mainframeAssembleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(mainframeAssembleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("mainframeAssemble.service.queryMainframeAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeAssemble.service.queryMainframeAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addMainframeAssemble(MainframeEntity mainframeAssembleEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse modifyMainframeAssemble(MainframeEntity mainframeAssembleEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse delMainframeAssemble(List<Integer> mainframeAssembleIDS) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse exportMainframeAssemble(MainframeFormQueryEntity mainframeAssembleFormQueryEntity)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}

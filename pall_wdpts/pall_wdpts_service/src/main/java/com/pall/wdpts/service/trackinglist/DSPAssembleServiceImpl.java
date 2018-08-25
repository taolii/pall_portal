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
import com.pall.wdpts.repository.entity.trackinglist.DSPEntity;
import com.pall.wdpts.repository.entity.trackinglist.DSPFormQueryEntity;
import com.pall.wdpts.repository.entity.workflow.AssemblyEntity;
import com.pall.wdpts.repository.mapper.trackinglist.DSPAssembleDao;

/*
 * 工作流服务接口
 */
@Repository
public class DSPAssembleServiceImpl implements  DSPAssembleService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private DSPAssembleDao dspAssembleDao;
	@Autowired
	private ResourceUtils resourceUtils;

	@Override
	public BaseTablesResponse queryDSPAssembleList(DSPFormQueryEntity dspAssembleFormQueryEntity)
			throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=dspAssembleDao.queryDSPTotalRecords(dspAssembleFormQueryEntity);
			//分页查询结果集
			List<DSPEntity> dspAssembleEntitys=dspAssembleDao.queryDSPList(dspAssembleFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(dspAssembleFormQueryEntity.getDraw());
			if(dspAssembleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(dspAssembleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dspAssemble.service.queryDSPAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dspAssemble.service.queryDSPAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addDSPAssemble(DSPEntity dspAssembleEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse modifyDSPAssemble(DSPEntity dspAssembleEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse delDSPAssemble(List<Integer> dspAssembleIDS) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse exportDSPAssemble(DSPFormQueryEntity dspAssembleFormQueryEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}

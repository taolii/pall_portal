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
import com.pall.wdpts.repository.entity.trackinglist.CisternEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternFormQueryEntity;
import com.pall.wdpts.repository.entity.workflow.AssemblyEntity;
import com.pall.wdpts.repository.mapper.trackinglist.CisternAssembleDao;

/*
 * 工作流服务接口
 */
@Repository
public class CisternAssembleServiceImpl implements CisternAssembleService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private CisternAssembleDao cisternAssembleDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryCisternAssembleList(CisternFormQueryEntity cisternAssembleFormQueryEntity)
			throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=cisternAssembleDao.queryCisternTotalRecords(cisternAssembleFormQueryEntity);
			//分页查询结果集
			List<CisternEntity> cisternAssembleEntitys=cisternAssembleDao.queryCisternList(cisternAssembleFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(cisternAssembleFormQueryEntity.getDraw());
			if(cisternAssembleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(cisternAssembleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cisternAssemble.service.queryCisternAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cisternAssemble.service.queryCisternAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addCisternAssemble(CisternEntity cisternAssembleEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse modifyCisternAssemble(CisternEntity cisternAssembleEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse delCisternAssemble(List<Integer> cisternAssembleIDS) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseResponse exportCisternAssemble(CisternFormQueryEntity cisternAssembleFormQueryEntity)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}

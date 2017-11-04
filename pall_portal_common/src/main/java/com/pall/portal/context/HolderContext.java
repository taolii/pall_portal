package com.pall.portal.context;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.response.BaseResponse;

public class HolderContext {
	/*
	 * 封装校验结果
	 */
	public static  BaseResponse  getBindingResult(BindingResult result){
		BaseResponse baseResponse=new BaseResponse();
		if(result.hasFieldErrors()){
			Map<String,Set<String>> errorMap=new HashMap<String,Set<String>>();
			StringBuffer results=new StringBuffer();
			if(null!=result.getFieldErrors()&&result.getFieldErrors().size()>0){
				for(FieldError  fieldError:result.getFieldErrors()){
					if(errorMap.get(fieldError.getField())==null){
						errorMap.put(fieldError.getField(), new HashSet<String>());
					}
					errorMap.get(fieldError.getField()).add(fieldError.getDefaultMessage());
				}
				int j=errorMap.size();
				for(String key:errorMap.keySet()){
					for(String error:errorMap.get(key)){
						results.append(error);
						results.append(";");
					}
					j--;
					if(j>0){
						results.append("<br/>");
						results.append("<i class='glyphicon glyphicon-play'></i>");
					}
				}
				baseResponse.setResultMsg(results.toString());
			}
	        baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
		}else{
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}
		return baseResponse;
	}
}

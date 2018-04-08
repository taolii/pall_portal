package com.pall.portal.interceptor;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.util.IOUtils;
import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.exception.ErrorInfo;
import com.pall.portal.common.exception.SystemException;
import com.pall.portal.common.response.BaseResponse;

@ControllerAdvice
public class GlobalExceptionHandler {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	@ExceptionHandler(value = SystemException.class)
    public ModelAndView   systemExceptionHandler(Model model, HttpServletRequest req, SystemException e,HttpServletResponse response) {
    	if(isAjax(req)){
    		dealAjaxException(e,response);
            return null;
    	}else{
    		ModelAndView mav = new ModelAndView();
            mav.addObject("exception", e);
            mav.addObject("url", "errors/system");
    		ErrorInfo<String> er = new ErrorInfo<String>();
            er.setCode(ErrorInfo.ERROR);
            er.setMessage(e.toString());
            er.setUrl(req.getRequestURL().toString());
            er.setParams(req.getQueryString());
            er.setDatas("发生异常，无法继续进行！");
            model.addAttribute("errorInfo", er);
            mav.setViewName("errors/system");
            return mav;
    	}
    }
   
    @ExceptionHandler(value = Exception.class)
    public ModelAndView  defaultExceptionHandler(Model model, HttpServletRequest req, Exception e,HttpServletResponse response) {
    	if(isAjax(req)){
            dealAjaxException(e,response);
            return null;
    	}else{
    		ErrorInfo<String> er = new ErrorInfo<String>();
            ModelAndView mav = new ModelAndView();
            mav.addObject("exception", e);
            mav.addObject("url", req.getRequestURL());
            er.setCode(ErrorInfo.ERROR);
            er.setMessage(e.toString());
            er.setUrl(req.getRequestURL().toString());
            er.setParams(req.getQueryString());
            er.setDatas("发生异常，无法继续进行！");
            er.setUrl(req.getRequestURL().toString());
            model.addAttribute("errorInfo", er);
            mav.setViewName("errors/default");
            return mav;
    	}
    }
    /*
     * 判断请求是否为ajax请求
     */
    private Boolean isAjax(HttpServletRequest request){
        String requestType  = request.getHeader("X-Requested-With");
        if(IResponseConstants.HEADER_REQUEST_TYPE.equals(requestType)){
        	return true;
        }else{
        	return false;
        }
    }
    /*
     * 处理Ajax异常信息
     */
    private void dealAjaxException(Exception ex, HttpServletResponse response) {
    	BaseResponse baseResponse=new BaseResponse();
        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = null;
        try {
        	baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
        	baseResponse.setResultMsg(ex.getMessage());
            writer = response.getWriter();
            writer.write(String.valueOf(JSON.toJSONString(baseResponse)));
            writer.flush();
        } catch (IOException e) {
        	logger.error("error",e);
        } finally {
            IOUtils.close(writer);
        }
    }
}


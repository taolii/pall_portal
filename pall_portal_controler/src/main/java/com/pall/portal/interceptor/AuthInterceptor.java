package com.pall.portal.interceptor;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.util.IOUtils;
import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.interceptor.support.AuthToken;

/*
 * 授权拦截器
 */
public class AuthInterceptor extends HandlerInterceptorAdapter{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	/*
	 * 需要放通的URL集合
	 */
	private Set<String> noFilterPathSet;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        AuthToken at = (AuthToken)session.getAttribute(AuthToken.SESSION_NAME);
        if(at==null||at.getUserEntity()==null) {
        	if(noFilterPathSet.contains(request.getServletPath())){
        		return  super.preHandle(request, response, handler);
        	}else{
        		if(isAjax(request)){
                    dealAjaxException(response);
                    return false;
            	}else{
            		response.sendRedirect(request.getContextPath()+"/login");
                    return false;
            	}
        	}
        }
        return super.preHandle(request, response, handler);
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
    private void dealAjaxException(HttpServletResponse response) {
    	BaseResponse baseResponse=new BaseResponse();
        response.setContentType("application/json;charset=utf-8");
        PrintWriter writer = null;
        try {
        	baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
        	baseResponse.setResultMsg(resourceUtils.getMessage("authInterceptor.preHandle.session.invalid"));
            writer = response.getWriter();
            writer.write(String.valueOf(JSON.toJSONString(baseResponse)));
            writer.flush();
        } catch (IOException e) {
        	logger.error("error",e);
        } finally {
            IOUtils.close(writer);
        }
    }
	public Set<String> getNoFilterPathSet() {
		return noFilterPathSet;
	}
	public void setNoFilterPathSet(Set<String> noFilterPathSet) {
		this.noFilterPathSet = noFilterPathSet;
	}
}

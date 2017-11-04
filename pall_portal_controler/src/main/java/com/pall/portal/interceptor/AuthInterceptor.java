package com.pall.portal.interceptor;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.pall.portal.common.exception.SystemException;
import com.pall.portal.interceptor.support.AuthToken;

/*
 * 授权拦截器
 */
public class AuthInterceptor extends HandlerInterceptorAdapter{
	/*
	 * 需要放通的URL集合
	 */
	private Set<String> noFilterPathSet;
	@Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        AuthToken at = (AuthToken)session.getAttribute(AuthToken.SESSION_NAME);
        if(at==null||at.getUserEntity()==null) {
        	if(noFilterPathSet.contains(request.getRequestURI())){
        		return  super.preHandle(request, response, handler);
        	}else{
        		response.sendRedirect(request.getContextPath()+"/login");
                return false;
        	}
        } else {
            boolean isAdmin = false;
            try {
                isAdmin = at.getUserEntity().getOperatorType()==1; //是否为超级管理员
            } catch (Exception e) {
            }
//			System.out.println(isAdmin);
            if(!isAdmin) {
            	HandlerMethod hm = (HandlerMethod)handler;
                //不是超级管理人员，就需要判断是否有权限访问某些功能
                String className = hm.getBean().getClass().getName();
                String methodName = hm.getMethod().getName();
                String curUrl = className.substring(className.lastIndexOf(".")+1, className.length())+"."+methodName;
                List<String> authList = at.getAuthList();
                if(!authList.contains(curUrl)) {throw new SystemException("无权限访问，请与管理员联系！");}
            }
        }
        return super.preHandle(request, response, handler);
    }
	public Set<String> getNoFilterPathSet() {
		return noFilterPathSet;
	}
	public void setNoFilterPathSet(Set<String> noFilterPathSet) {
		this.noFilterPathSet = noFilterPathSet;
	}
	
}

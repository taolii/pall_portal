package com.pall.wdpts.module.login;

import java.awt.image.BufferedImage;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.interceptor.support.AuthToken;
import com.pall.wdpts.repository.entity.login.LoginEntity;
import com.pall.wdpts.repository.entity.menu.TreeMenuInfo;
import com.pall.wdpts.repository.entity.user.UserEntity;
import com.pall.wdpts.service.login.LoginService;
import com.pall.wdpts.service.menu.MenuManageService;
/*
 * 用户登录控制器
 */
@Controller
public class LoginController {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	/*
	 * 登录服务认证服务
	 */
	@Autowired
	private LoginService loginService;
	/*
	 * 菜单管理服务
	 */
	@Autowired
	private MenuManageService menuManageService;
	/*
	 * 当前系统版本
	 */
	@Value("${System.verion}")
	private String nowSystemVersion;
	/*
	 * 资源类
	 */
	@Autowired
	private MessageSource messageSource;
	@Autowired
	private DefaultKaptcha captchaProducer;
	/*
	 * 用户登录
	 */
	@RequestMapping(value="login")
    public String login(Model model, HttpServletRequest request) {
		 String method = request.getMethod(); //获取请求方式，GET或POST
	        try {
	            if("get".equalsIgnoreCase(method)) {
	                return "login/login";
	            } else if("post".equalsIgnoreCase(method)) {
	            	String sessionValidCode=(String)request.getSession().getAttribute(AuthToken.VALID_CODE_NAME);
	                String username = request.getParameter("username"); //用户名
	                String password = request.getParameter("password"); //密码
	                String validCode=request.getParameter("validCode"); //验证码
	                LoginEntity loginEntity=new LoginEntity();
	                loginEntity.setLoginName(username);
	                loginEntity.setLoginPasswd(password);
	                loginEntity.setValidCode(validCode);
	                loginEntity.setSessionValidCode(sessionValidCode);
	                BaseResponse baseResponse = loginService.isLogin(loginEntity);
	                if(IResponseConstants.RESPONSE_CODE_SUCCESS!=baseResponse.getResultCode()){
	                	model.addAttribute("errMsg", baseResponse.getResultMsg());
	                    return "login/login";
	                }else{
	                	UserEntity userEntity=(UserEntity)baseResponse.getReturnObjects().get(0);
	                	AuthToken at = new AuthToken();
	                    at.setLoginIP(request.getRemoteAddr());
	                    at.setLoginTime(new Date());
	                    at.setUserEntity(userEntity);
	                    at.setNowSystemVersion(nowSystemVersion);
	                    baseResponse=menuManageService.getMenusByPMenuid(KeyConstants.MENU_DEFAULT_ROOT_PARENTID,String.valueOf(userEntity.getOperatorid()));
	                    if(IResponseConstants.RESPONSE_CODE_SUCCESS!=baseResponse.getResultCode()){
		                	model.addAttribute("errMsg", baseResponse.getResultMsg());
		                    return "login/login";
		                }else{
		                	at.setAuthMenus((List<TreeMenuInfo>)baseResponse.getReturnObjects());
		                }
	                    request.getSession().setAttribute(AuthToken.SESSION_NAME, at);
	                    return "redirect:/index";
	                }
	            }
	        } catch (Exception e) {
	        	logger.error(messageSource.getMessage("user.login.error.login.exception", null, LocaleContextHolder.getLocale()),e);
	        	model.addAttribute("errMsg", messageSource.getMessage("user.login.error.login.exception", null, LocaleContextHolder.getLocale()));
	        }
	        return "login/login";
    }
	/*
	 * 用户退出
	 */
	@RequestMapping(value="logout")
    public  String logout(Model model,HttpServletRequest request) {
		//清除会话
		request.getSession().removeAttribute(AuthToken.SESSION_NAME);
		return "redirect:/login";
    }
	/*
	 * 获取图片验证码
	 */
	@RequestMapping(value="getValidCode", method= RequestMethod.GET)
    public @ResponseBody String getValidCode(Model model, HttpServletRequest request,HttpServletResponse response) {
		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control","no-store, no-cache, must-revalidate"); 
		response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		response.setHeader("Pragma", "no-cache"); 
		response.setContentType("image/jpeg");
		String validCode = captchaProducer.createText();
		ServletOutputStream out=null;
		try{
			request.getSession().setAttribute(AuthToken.VALID_CODE_NAME, validCode);
			BufferedImage bi = captchaProducer.createImage(validCode);
			out = response.getOutputStream(); 
			ImageIO.write(bi, "jpg", out);
		}catch(Exception e){
			logger.error(messageSource.getMessage("user.login.error.getValidCode.exception", null, LocaleContextHolder.getLocale()),e);
			model.addAttribute("errMsg", messageSource.getMessage("user.login.error.getValidCode.exception", null, LocaleContextHolder.getLocale()));
		}finally{
			try{
				if(out!=null){
					out.close();
				}
			}catch(Exception e){
				logger.error(messageSource.getMessage("user.login.error.getValidCode.exception", null, LocaleContextHolder.getLocale()),e);
				model.addAttribute("errMsg", messageSource.getMessage("user.login.error.getValidCode.exception", null, LocaleContextHolder.getLocale()));
			}
		}
	    return null;
    }
}

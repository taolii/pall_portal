package com.pall.portal.module.menu;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pall.portal.service.menu.MenuManageService;

@Controller
public class MenuController {
	@Autowired
	private MenuManageService menuManageService;
	@RequestMapping(value="getAllmenus", method= RequestMethod.GET)
    public String list(Model model, Integer page, HttpServletRequest request) {
		
        return "main/main";
    }
	public void setMenuManageService(MenuManageService menuManageService) {
		this.menuManageService = menuManageService;
	}
}

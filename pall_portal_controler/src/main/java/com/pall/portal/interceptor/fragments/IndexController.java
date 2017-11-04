package com.pall.portal.interceptor.fragments;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {
	
	@RequestMapping(value="/", method= RequestMethod.GET)
    public String root(Model model, Integer page, HttpServletRequest request) {
        return "redirect:/login";
    }
	@RequestMapping(value="index", method= RequestMethod.GET)
    public String index(Model model, Integer page, HttpServletRequest request) {
        return "index";
    }
	@RequestMapping(value="home", method= RequestMethod.GET)
    public String home(Model model, Integer page, HttpServletRequest request) {
        return "home";
    }
}

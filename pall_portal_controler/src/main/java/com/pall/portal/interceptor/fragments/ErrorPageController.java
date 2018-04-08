package com.pall.portal.interceptor.fragments;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/error")
public class ErrorPageController {

    @RequestMapping(value = "404",method= RequestMethod.GET)
    public String error404(Model model, HttpServletRequest request) {
        return "errors/404";
    }

    @RequestMapping(value = "400",method= RequestMethod.GET)
    public String error400(Model model, HttpServletRequest request) {
        return "errors/400";
    }

    @RequestMapping(value = "500",method= RequestMethod.GET)
    public String error500(Model model, HttpServletRequest request) {
        return "errors/500";
    }
}
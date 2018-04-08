package com.pall.portal.interceptor.fragments;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppErrorController {

    @RequestMapping(value = "404")
    public String error404(Model model, HttpServletRequest request) {
        return "errors/404";
    }

    @RequestMapping(value = "400")
    public String error400(Model model, HttpServletRequest request) {
        return "errors/404";
    }

    @RequestMapping(value = "500")
    public String error500(Model model, HttpServletRequest request) {
        return "errors/500";
    }
}
package com.wtf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AnnouncementController {

    @RequestMapping(value = "/announcement", method = RequestMethod.GET)
    public ModelAndView showIndexPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("announcement/announcement"); // JSP 파일의 경로 설정
        return modelAndView;
    }
}
package com.wtf.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MovieController {

    @RequestMapping(value = "/movieDetail", method = RequestMethod.GET)
    public ModelAndView showMovieDetailPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("movie/movieDetail");
        return modelAndView;
    }

    @RequestMapping(value = "/board", method = RequestMethod.GET)
    public ModelAndView showMainBoardPage(@RequestParam Map<String, Object> map, HttpServletRequest request) {
    	HttpSession session = request.getSession();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("movie/mainBoard");
        return modelAndView;
    }

    @RequestMapping(value = "/dailyMovie", method = RequestMethod.GET)
    public ModelAndView showDailyMoviePage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("movie/dailyMovie");
        return modelAndView;
    }

    @RequestMapping(value = "/HowMuchDailyMovie", method = RequestMethod.GET)
    public ModelAndView showHowMuchDailyMoviePage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("movie/HowMuchDailyMovie");
        return modelAndView;
    }

    @RequestMapping(value = "/SearchMovie", method = RequestMethod.GET)
    public ModelAndView SearchMoviePage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("movie/SearchMovie");
        return modelAndView;
    }
    
    @RequestMapping(value = "/recommend", method = RequestMethod.GET)
    public ModelAndView recommendPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("movie/recommend");
        return modelAndView;
    }
}
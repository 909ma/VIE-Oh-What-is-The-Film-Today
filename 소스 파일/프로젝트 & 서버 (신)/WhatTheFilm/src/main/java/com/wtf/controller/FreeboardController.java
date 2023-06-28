package com.wtf.controller;

import com.wtf.freeboard.FreeboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/freeboard")
public class FreeboardController {

    private final FreeboardService freeboardService;

    @Autowired
    public FreeboardController(FreeboardService freeboardService) {
        this.freeboardService = freeboardService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView showIndexPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("freeboard/freeboard");
        return modelAndView;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public ModelAndView create() {
        return new ModelAndView("freeboard/create");
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public ModelAndView createPost(@RequestParam HashMap<String, Object> paramMap) {
        ModelAndView mav = new ModelAndView();
        freeboardService.create(paramMap);
        mav.setViewName("redirect:/freeboard/list");
        return mav;
    }

    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public ModelAndView detail(@RequestParam("postId") int postId) {
        HashMap<String, Object> detailMap = freeboardService.getDetail(postId);
        ModelAndView mav = new ModelAndView();
        mav.addObject("data", detailMap);
        mav.addObject("postId", postId);
        mav.setViewName("freeboard/detail");
        return mav;
    }

    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public ModelAndView update(@RequestParam("postId") int postId) {
        HashMap<String, Object> detailMap = freeboardService.getDetail(postId);
        ModelAndView mav = new ModelAndView();
        mav.addObject("data", detailMap);
        mav.setViewName("freeboard/update");
        return mav;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView updatePost(@RequestParam HashMap<String, Object> paramMap) {
        ModelAndView mav = new ModelAndView();
        boolean isUpdateSuccess = freeboardService.update(paramMap);
        if (isUpdateSuccess) {
            int postId = Integer.parseInt(paramMap.get("postId").toString());
            mav.setViewName("redirect:/freeboard/detail?postId=" + postId);
        } else {
            mav = update(Integer.parseInt(paramMap.get("postId").toString()));
        }
        return mav;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ModelAndView deletePost(@RequestParam("postId") int postId) {
        ModelAndView mav = new ModelAndView();
        boolean isDeleteSuccess = freeboardService.delete(postId);
        if (isDeleteSuccess)
            mav.setViewName("redirect:/freeboard/list");
        else
            mav.setViewName("redirect:/freeboard/detail?postId=" + postId);
        return mav;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "nowPage", required = false) String nowPage,
                             @RequestParam HashMap<String, Object> paramMap) {

        double CNT = 10.0;
        int LIMITCOUNT = (int) CNT;
        if (nowPage != null) {
            int now = Integer.parseInt(nowPage);
            int skipCount = 0;
            if (now > 1)
                skipCount = (now - 1) * LIMITCOUNT;
            paramMap.put("skipCount", skipCount);
        } else {
            paramMap.put("skipCount", 0);
        }

        List<HashMap<String, Object>> list = freeboardService.getList(paramMap);

        ModelAndView mav = new ModelAndView();
        mav.addObject("data", list);

        int totalCount = (int) Math.ceil(freeboardService.countFreeboard(paramMap) / CNT);
        mav.addObject("totalCount", totalCount);

        int nowPos = nowPage == null ? 1 : Integer.parseInt(nowPage);
        if (nowPos <= 0)
            nowPos = 1;
        mav.addObject("nowPage", nowPos);

        int endPage = (int) (Math.ceil(nowPos / CNT) * LIMITCOUNT);
        int startPage = 0;
        if (endPage > totalCount) {
            startPage = endPage - LIMITCOUNT + 1;
            endPage = totalCount;
        } else {
            startPage = endPage - LIMITCOUNT + 1;
        }
        if (startPage <= 0)
            startPage = 1;

        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);

        if (paramMap.containsKey("keyword")) {
            mav.addObject("keyword", paramMap.get("keyword"));
        }

        mav.setViewName("freeboard/list");
        return mav;
    }
}

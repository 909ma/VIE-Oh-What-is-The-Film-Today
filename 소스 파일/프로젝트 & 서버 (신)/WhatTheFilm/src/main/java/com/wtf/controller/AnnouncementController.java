package com.wtf.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.wtf.announcement.AnnouncementService;

@Controller
@RequestMapping("/announcement") // "/announcement"으로 매핑 변경
public class AnnouncementController {

    @Autowired
    private AnnouncementService announcementService;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView showIndexPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("announcement/announcement");
        return modelAndView;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public ModelAndView create() {
        return new ModelAndView("announcement/create");
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public ModelAndView createPost(@RequestParam Map<String, Object> map) {
        ModelAndView mav = new ModelAndView();
        announcementService.create(map);
        mav.setViewName("redirect:/announcement/list"); // 리다이렉트 수정
        return mav;
    }

    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public ModelAndView detail(@RequestParam("noticeId") int noticeId) { // 매개변수 수정
        Map<String, Object> detailMap = announcementService.getDetail(noticeId);
        ModelAndView mav = new ModelAndView();
        mav.addObject("data", detailMap);
        mav.addObject("noticeId", noticeId);
        mav.setViewName("announcement/detail");
        return mav;
    }

    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public ModelAndView update(@RequestParam("noticeId") int noticeId) { // 매개변수 수정
        Map<String, Object> detailMap = announcementService.getDetail(noticeId);
        ModelAndView mav = new ModelAndView();
        mav.addObject("data", detailMap);
        mav.setViewName("announcement/update");
        return mav;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ModelAndView updatePost(@RequestParam Map<String, Object> map) {
        ModelAndView mav = new ModelAndView();
        boolean isUpdateSuccess = announcementService.update(map);
        if (isUpdateSuccess) {
            int noticeId = Integer.parseInt(map.get("noticeId").toString());
            mav.setViewName("redirect:/announcement/detail?noticeId=" + noticeId); // 리다이렉트 수정
        } else {
            mav = update(Integer.parseInt(map.get("noticeId").toString())); // 리다이렉트 수정
        }
        return mav;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ModelAndView deletePost(@RequestParam("noticeId") int noticeId) {
        ModelAndView mav = new ModelAndView();
        boolean isDeleteSuccess = announcementService.delete(noticeId);
        if (isDeleteSuccess)
            mav.setViewName("redirect:/announcement/list");
        else
            mav.setViewName("redirect:/announcement/detail?noticeId=" + noticeId);
        return mav;
    }


    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "nowPage", required = false) String nowPage,
            @RequestParam Map<String, Object> map) {

        double CNT = 2.0;
        int LIMITCOUNT = (int) CNT;
        if (nowPage != null) {
            int now = Integer.parseInt(nowPage);
            int skipCount = 0;
            if (now > 1)
                skipCount = (now - 1) * LIMITCOUNT;
            map.put("skipCount", skipCount);
        } else {
            map.put("skipCount", 0);
        }

        List<Map<String, Object>> list = announcementService.getList(map);

        ModelAndView mav = new ModelAndView();
        mav.addObject("data", list);

        int totalCount = (int) Math.ceil(announcementService.countNoticeBoard(map) / CNT);
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

        if (map.containsKey("keyword")) {
            mav.addObject("keyword", map.get("keyword"));
        }

        mav.setViewName("announcement/list");
        return mav;
    }


}

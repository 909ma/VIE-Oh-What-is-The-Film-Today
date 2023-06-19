package com.wtf.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;

	// 회원가입 화면
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView showRegisterPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("member/join"); // JSP 파일 경로 및 파일명
		return modelAndView;
	}
	
	// 회원가입 처리
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView registerPost(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();

		// 중복 확인 로직 추가
		String loginId = (String) map.get("loginid");
		String nickname = (String) map.get("nickname");

		boolean isDuplicateId = memberService.isLoginIdDuplicated(loginId);
		boolean isDuplicateNickname = memberService.isNicknameDuplicated(nickname);

		if (isDuplicateId) {
			mav.addObject("idMessage", "이미 사용 중인 아이디입니다.");
			mav.setViewName("member/join"); // JSP 파일 경로 및 파일명
		} else if (isDuplicateNickname) {
			mav.addObject("nicknameMessage", "이미 사용 중인 닉네임입니다.");
			mav.setViewName("member/join"); // JSP 파일 경로 및 파일명
		} else {
			String memberId = memberService.create(map);
			mav.setViewName("redirect:/login");
		}

		return mav;
	}
    
	//로그인 화면
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("member/login"); // JSP 파일 경로 및 파일명
		return modelAndView;
	}
    
}
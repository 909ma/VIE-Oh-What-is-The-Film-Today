package com.wtf.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	@Autowired
	MemberServiceImpl memberServiceImpl;
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
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login_post(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		Map<String, Object> userpw = this.memberService.login_ok(map);
		//오류 확인용
		
		System.out.println(map.get("loginid"));
		System.out.println(map.get("password"));
		PasswordEncoder p = new BCryptPasswordEncoder();

		//System.out.println(p.matches(map.get("pw").toString(), userpw.get("pw").toString()));

		if (map.get("password") == null || (String) map.get("loginid") == null) {

			
			mav.setViewName("redirect:/login"); //jsp경로

		} else {
			try {
				if (p.matches(map.get("password").toString(), userpw.get("password").toString())) {
					
					HttpSession session = request.getSession();
					session.setAttribute("loginid", map.get("loginid"));
					mav.setViewName("redirect:/board");
					
				} else {
					mav.setViewName("redirect:/register");
				}
			} catch (Exception e) {
				//f
				mav.setViewName("redirect:/index");
				return mav;
			}
			
			
		}

		return mav;

	}
	
    // 로그아웃 처리
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/index"; // 로그아웃 후 로그인 페이지로 리다이렉트
    }

    // 회원정보 수정 처리
    @RequestMapping(value = "/edituser", method = RequestMethod.GET)
    public ModelAndView editUserPost(@RequestParam Map<String, Object> map) {
    	ModelAndView mav = new ModelAndView();
    	boolean isUpdateSuccess = this.memberService.edituser(map);
    	if(isUpdateSuccess) {
    		mav.setViewName("redirect:/board");
    	}else {
    		mav=this.editUserPost(map);
    	}  	
    	return mav;
    }
    
    //
    
}
    

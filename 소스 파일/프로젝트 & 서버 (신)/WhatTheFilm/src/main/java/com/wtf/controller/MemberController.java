package com.wtf.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
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
	// 회원가입
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView showRegisterPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("member/join"); // JSP 파일 경로 및 파일명
		return modelAndView;
	}
	
	// 회원가입기능
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView registerPost(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		

		// 아이디 닉네임 중복확인
		String loginId = (String) map.get("loginid");
		String nickname = (String) map.get("nickname");

		boolean isDuplicateId = memberService.isLoginIdDuplicated(loginId);
		boolean isDuplicateNickname = memberService.isNicknameDuplicated(nickname);

		if (isDuplicateId) {
			mav.addObject("idMessage", "중복된 아이디.");
			mav.setViewName("member/join"); // JSP
		} else if (isDuplicateNickname) {
			mav.addObject("nicknameMessage", "중복된 닉네임.");
			mav.setViewName("member/join"); // JSP
		} else {
			String memberId = memberService.create(map);
			mav.setViewName("redirect:/login");
		}

		return mav;
	}
    
	//로그인화면
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("member/login"); // JSP 파일 경로 및 파일명
		return modelAndView;
	}
	
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login_post(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		Map<String, Object> userpw = this.memberService.login_ok(map);
		System.out.println("login post");
		
		System.out.println(map.get("loginid"));
		System.out.println(map.get("password"));
		PasswordEncoder p = new BCryptPasswordEncoder();

		//System.out.println(p.matches(map.get("pw").toString(), userpw.get("pw").toString()));

		if (map.get("password") == null || (String) map.get("loginid") == null) {

			//아이디나 비밀번호 입력하지 않으면 로그인 창으로
			mav.setViewName("redirect:/login"); //jsp

		} else {
			try {
				if (p.matches(map.get("password").toString(), userpw.get("password").toString())) {
					//로그인 성공
					HttpSession session = request.getSession();
					session.setAttribute("loginid", map.get("loginid"));
					mav.setViewName("redirect:/board");
					
				} else {
					//등록된 아이디가 없으면 회원가입 창으로
					mav.setViewName("redirect:/register");
				}
			} catch (Exception e) {
				//예외
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
    //고객 정보(내 정보)
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public ModelAndView detail(@RequestParam Map<String, Object> map, HttpServletRequest request) {


        ModelAndView mav = new ModelAndView();
       
		try {
			request.setCharacterEncoding("utf-8");
			HttpSession hs = request.getSession();
			String loginid = (String) hs.getAttribute("loginid");
			System.out.println("멤아이디 : " + loginid);
			map.put("loginid", loginid);
	        Map<String, Object> detailMap = this.memberService.detail(map);

			 System.out.println("1detailmap="+detailMap);
	        //String member_id = map.get("memberID").toString(); 
	        //mav.addObject("memberID", member_id);
			
			mav.addObject("loginid", loginid);
			System.out.println("id:"+loginid);
			
			mav.addObject("data", detailMap);	
			map.put("data", detailMap);
	        System.out.println("what???");
	        System.out.println(map);
			 System.out.println("2detailmap="+detailMap);
			//select detail 로 가져오고
			//그거를 data안에 삽입		
	        mav.setViewName("/member/detail");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return mav;
    }
   //수정 화면
    @RequestMapping(value="/update", method = {RequestMethod.GET}) 
    public ModelAndView update(@RequestParam Map<String, Object> map) {
    	System.out.println("매앱 : " + map);

		ModelAndView mav = new ModelAndView();
		
    	Map<String, Object> detailMap = new HashMap<String, Object>();
    	detailMap.put("myloginid", map.get("loginid"));
    	detailMap.put("oldnickname", map.get("nickname"));
    	detailMap.put("oldbirthyear", map.get("birthyear"));
    	//System.out.println("디테일맵 : " + detailMap);
		mav.addObject("data", detailMap);
		mav.setViewName("/member/update");
		return mav;
    }
    //수정 기능
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView updatePost(@RequestParam Map<String, Object> map) {

		ModelAndView mav = new ModelAndView();
		System.out.println("mappp: " + map);
		//System.out.println(mav);
		boolean isUpdateSuccess = this.memberService.edit(map);
		System.out.println("성공여부 : " + isUpdateSuccess);
		if (isUpdateSuccess) {
			String loginid = map.get("loginid").toString();
			System.out.println(loginid);
	    	Map<String, Object> detailMap = this.memberService.detail(map);
	    	System.out.println("디테일-맵 : " + detailMap);
			mav.addObject("data", detailMap);
			mav.setViewName("/member/detail");
		} else {
			mav = this.update(map);
		}

		return mav;
	}
    
}
    

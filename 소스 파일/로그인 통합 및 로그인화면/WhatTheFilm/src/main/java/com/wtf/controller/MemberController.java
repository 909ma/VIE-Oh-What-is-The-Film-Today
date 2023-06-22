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
	// ȸ������ ȭ��
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView showRegisterPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("member/join"); // JSP ���� ��� �� ���ϸ�
		return modelAndView;
	}
	
	// ȸ������ ó��
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView registerPost(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView();
		
		

		// �ߺ� Ȯ�� ���� �߰�
		String loginId = (String) map.get("loginid");
		String nickname = (String) map.get("nickname");

		boolean isDuplicateId = memberService.isLoginIdDuplicated(loginId);
		boolean isDuplicateNickname = memberService.isNicknameDuplicated(nickname);

		if (isDuplicateId) {
			mav.addObject("idMessage", "�̹� ��� ���� ���̵��Դϴ�.");
			mav.setViewName("member/join"); // JSP ���� ��� �� ���ϸ�
		} else if (isDuplicateNickname) {
			mav.addObject("nicknameMessage", "�̹� ��� ���� �г����Դϴ�.");
			mav.setViewName("member/join"); // JSP ���� ��� �� ���ϸ�
		} else {
			String memberId = memberService.create(map);
			mav.setViewName("redirect:/login");
		}

		return mav;
	}
    
	//�α��� ȭ��
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("member/login"); // JSP ���� ��� �� ���ϸ�
		return modelAndView;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login_post(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		Map<String, Object> userpw = this.memberService.login_ok(map);
		//���� Ȯ�ο�
		
		System.out.println(map.get("loginid"));
		System.out.println(map.get("password"));
		PasswordEncoder p = new BCryptPasswordEncoder();

		//System.out.println(p.matches(map.get("pw").toString(), userpw.get("pw").toString()));

		if (map.get("password") == null || (String) map.get("loginid") == null) {

			//아이디나 비밀번호 입력하지 않으면 로그인 창으로
			mav.setViewName("redirect:/login"); //jsp���

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
	
	

}
    

package project.spring.yse;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SignUpController {
	
	  @Autowired
	    private UserService userService;

	    @Autowired
	    private BCryptPasswordEncoder passwordEncoder;

	    // 회원가입 입력 화면
	    @RequestMapping(value = "/register", method = RequestMethod.GET)
	    public ModelAndView register() {
	        return new ModelAndView("user/signUp");
	    }

	    // 회원등록
	    @RequestMapping(value = "/register", method = RequestMethod.POST)
	    public ModelAndView createPost(@RequestParam Map<String, Object> map) {
	        ModelAndView mav = new ModelAndView();

	        String userNumber = this.userService.regist(map);
	        if (userNumber == null) {
	            mav.setViewName("redirect:/register"); // 등록 실패시 원래 사이트로
	        } else if (userNumber.equals("Duplicate")) {
	            mav.setViewName("user/signUp"); // 중복 가입 시 다시 회원가입 페이지로
	            mav.addObject("errorMessage", "이미 사용 중인 아이디 또는 닉네임입니다."); // 경고 메시지 전달
	        } else {
	            mav.setViewName("redirect:/Hello"); // 등록 성공시 완료사이트로 이동
	        }

	        return mav;
	    }
}
package com.mycompany.mycompany;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class indexController {
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView index() {
		return new ModelAndView("index");
	}

	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public ModelAndView board() {
		return new ModelAndView("/board/mainBoard");
	}

	@RequestMapping(value = "/dailyMovie", method = RequestMethod.GET)
	public ModelAndView dailyMovie() {
		return new ModelAndView("/movie/dailyMovie");
	}

	@RequestMapping(value = "/HowMuchDailyMovie", method = RequestMethod.GET)
	public ModelAndView HowMuchDailyMovie() {
		return new ModelAndView("/movie/HowMuchDailyMovie");
	}

}

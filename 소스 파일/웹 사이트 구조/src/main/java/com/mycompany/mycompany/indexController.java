package com.mycompany.mycompany;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class indexController {	
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public ModelAndView create() {
		return new ModelAndView("index");
	}
	
}

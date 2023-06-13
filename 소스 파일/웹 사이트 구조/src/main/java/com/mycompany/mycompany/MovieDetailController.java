package com.mycompany.mycompany;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MovieDetailController {
    @RequestMapping(value = "/movieDetail", method = RequestMethod.GET)
    public ModelAndView movieDetail() {
        return new ModelAndView("/board/movieDetail");
    }
}

package com.mymvc.myproject;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
public class BookServiceImpl implements BookService{
	
	@Autowired
	BookDAO bookDao;
	
	@Override
	public String create(Map<String, Object> map) {
		int affectRowCOunt = this.bookDao.insert(map);
		if(affectRowCOunt==1) {
			return map.get("book_id").toString();
		}
		return null;
	}

	@Override
	public Map<String, Object> detail(Map<String, Object> map){
		return this.bookDao.selectDetail(map);
	}
	
	@RequestMaping(value="/detail", method=RequestMethod.GET)
	public ModelAndView detail(@RequestParam Map<String, Object> map) {
		Map<String, Object> detailMap = this.bookService.detail(map);
		System.out.println(detailMap);
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", detailMap);
		String bookId = ap/get("bookId").toString();
		mav.addObject("bookId", bookId);
		mav.setViewName("/book/detail");;
		return mav;
	}
]

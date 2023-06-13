package com.mymvc.myproject;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BookDAO {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insert(Map<String, Object> map){
		return this.sqlSessionTemplate.insert("book.insert", map);
	}
	public Map<String, Object> selectDetail(Map<String, Object>map){
		return this.selectDetail.sqlSessionTemplate.selectOne("book.select_detail", map);
	}
}

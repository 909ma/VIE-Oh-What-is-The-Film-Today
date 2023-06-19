package com.wtf.controller;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("member.insert", map);
	}
	
	public int countByLoginId(String loginId) {
		return this.sqlSessionTemplate.selectOne("member.countByLoginId", loginId);
	}
	
	public int countByNickname(String nickname) {
		return this.sqlSessionTemplate.selectOne("member.countByNickname", nickname);
	}
	
}

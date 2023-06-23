package com.wtf.controller;

import java.lang.reflect.Member;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {
	
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	//?Ù¬Ù¯Ý:ÙVÙ®??
	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("member.insert", map);
	}
	//ÜúÜ¡???Ý3 ?Ý<Ü¬Ý˜?Ùç??
	public int countByLoginId(String loginId) {
		return this.sqlSessionTemplate.selectOne("member.countByLoginId", loginId);
	}
	//Ù¥Ü¢ÝšÙO?? ?Ý<Ü¬Ý˜?Ùç??
	public int countByNickname(String nickname) {
		return this.sqlSessionTemplate.selectOne("member.countByNickname", nickname);
	}
	//Ù4?ÙNÙO?? ÙN?Ù¥?ÙNÙ¬????ÙN?
	public Map<String, Object> Login_Check(Map<String, Object> map){
		 return this.sqlSessionTemplate.selectOne("member.login_ok", map);
		 
	 }
	//ÒA¶¥¸÷¥¡ ®¸÷
	public  int editUser(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("member.edit_user", map);
	}

}
	




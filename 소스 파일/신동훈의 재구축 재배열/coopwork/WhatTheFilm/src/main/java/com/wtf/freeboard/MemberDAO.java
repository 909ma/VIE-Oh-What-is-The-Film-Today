package com.wtf.freeboard;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	

	public boolean id_check(String id) {
		return (Integer)this.sqlSessionTemplate.selectOne("hospital.id_check",id) == 0 ? true : false;
	}
	
	public int join(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("hospital.join",map);
	}

	public MemberDTO login(Map<String, String> map) {
		return this.sqlSessionTemplate.selectOne("hospital.login",map);
	}
	
	public MemberDTO detail(String id){
		return this.sqlSessionTemplate.selectOne("hospital.detail",id);
	}
	
	public int modify(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("hospital.modify", map);
	}
	
	public int delete(String id) {
		return this.sqlSessionTemplate.delete("hospital.delete",id);
	}
	
	public List<MemberDTO> staff_list(String m_code) {
		return this.sqlSessionTemplate.selectList("hospital.staff_list",m_code);
	}
}

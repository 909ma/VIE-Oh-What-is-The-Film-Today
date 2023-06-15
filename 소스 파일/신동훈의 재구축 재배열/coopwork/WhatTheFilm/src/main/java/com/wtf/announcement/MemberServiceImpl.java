package com.wtf.announcement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberDAO dao;
	
	// 아이디 중복 체크 확인
	@Override
	public boolean id_check(String id) {
		return this.dao.id_check(id);
	}
	
	// 회원가입
	@Override
	public String join(Map<String, Object> map) {
		int affectRowCount = this.dao.join(map);
		if(affectRowCount == 1) {
			return map.get("id").toString();
		}
		return null;
	}
	
	// 로그인
	@Override
	public MemberDTO login(HashMap<String, String> map) {
		return this.dao.login(map);
	}
	
	// 회원 상세 화면
	@Override
	public MemberDTO detail(String id){
		return this.dao.detail(id);
	}
	
	// 회원 정보 수정
	@Override
	public boolean modify(Map<String, Object> map) {
		int affectRowCount = this.dao.modify(map);
		return affectRowCount == 1;
	}
	
	// 회원 탈퇴
	@Override
	public boolean delete(String id) {
		int affectRowCount = this.dao.delete(id);
		return affectRowCount == 1;
	}
	
	// 의료진 목록 조회
	@Override
	public List<MemberDTO> staff_list(String m_code) {
		return this.dao.staff_list(m_code);
	}
	
}

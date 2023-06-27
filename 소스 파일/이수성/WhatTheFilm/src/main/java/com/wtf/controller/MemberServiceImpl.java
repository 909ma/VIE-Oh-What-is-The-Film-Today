package com.wtf.controller;

import java.lang.reflect.Member;
import java.util.Map;

//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberDao memberDao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    //회원가입
    @Override
    public String create(Map<String, Object> map) {

        // ���̵�� �г��� �ߺ� �˻�
        String loginId = (String) map.get("loginid");
        String nickname = (String) map.get("nickname");
        int loginIdCount = memberDao.countByLoginId(loginId);
        int nicknameCount = memberDao.countByNickname(nickname);
        
        if (loginIdCount > 0) {
            // ���̵� �ߺ��� ���
            return "���̵� �̹� ��� ���Դϴ�.";
        }
        
        if (nicknameCount > 0) {
            // �г����� �ߺ��� ���
            return "�г����� �̹� ��� ���Դϴ�.";
        }

        // ��й�ȣ ��ȣȭ
        String password = (String) map.get("password");
        String encodedPassword = passwordEncoder.encode(password);
        map.put("password", encodedPassword);
        

        int affectRowCount = this.memberDao.insert(map);
        if (affectRowCount == 1) {
            return map.get("member_id").toString();
        }
        return null;
    }
    //아이디 중복확인
    @Override
    public boolean isLoginIdDuplicated(String loginId) {
        int count = memberDao.countByLoginId(loginId);
        return count > 0;
    }
    //닉네임 중복확인
    @Override
    public boolean isNicknameDuplicated(String nickname) {
        int count = memberDao.countByNickname(nickname);
        return count > 0;
    }
    //로그인
	@Override
	public boolean login(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return true;
	}
	//로그인
	@Override
	public Map<String, Object> login_ok(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.memberDao.Login_Check(map);
	}
   // 마이페이지
	@Override
	public Map<String, Object> detail(Map<String, Object> map) {
		
		System.out.println("멤버서비스입플  디테일 = " + map);
		return this.memberDao.selectDetail(map);
	}
	
	@Override  
	public boolean edit(Map<String, Object> map) {  
		System.out.println("member 서비스 임플 : " +map);
	int affectRowCount = this.memberDao.update(map);  
	return affectRowCount == 1;  

	}  
	

}
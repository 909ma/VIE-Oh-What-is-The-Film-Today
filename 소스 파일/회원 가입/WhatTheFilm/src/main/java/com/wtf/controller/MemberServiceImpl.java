package com.wtf.controller;

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

    @Override
    public String create(Map<String, Object> map) {

        // 아이디와 닉네임 중복 검사
        String loginId = (String) map.get("loginid");
        String nickname = (String) map.get("nickname");
        int loginIdCount = memberDao.countByLoginId(loginId);
        int nicknameCount = memberDao.countByNickname(nickname);
        
        if (loginIdCount > 0) {
            // 아이디가 중복된 경우
            return "아이디가 이미 사용 중입니다.";
        }
        
        if (nicknameCount > 0) {
            // 닉네임이 중복된 경우
            return "닉네임이 이미 사용 중입니다.";
        }

        // 비밀번호 암호화
        String password = (String) map.get("password");
        String encodedPassword = passwordEncoder.encode(password);
        map.put("password", encodedPassword);

        int affectRowCount = this.memberDao.insert(map);
        if (affectRowCount == 1) {
            return map.get("member_id").toString();
        }
        return null;
    }

	@Override
	public boolean isLoginIdDuplicated(String loginId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isNicknameDuplicated(String nickname) {
		// TODO Auto-generated method stub
		return false;
	}
}

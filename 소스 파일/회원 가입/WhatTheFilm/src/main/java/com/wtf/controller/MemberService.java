package com.wtf.controller;

import java.util.Map;

public interface MemberService {

	String create(Map<String, Object> map);

	boolean isLoginIdDuplicated(String loginId);

	boolean isNicknameDuplicated(String nickname);
	

}

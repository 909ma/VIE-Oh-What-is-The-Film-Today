package com.wtf.controller;

import java.util.Map;

public interface MemberService {

	String create(Map<String, Object> map);

	boolean isLoginIdDuplicated(String loginId);

	boolean isNicknameDuplicated(String nickname);

	boolean login(Map<String, Object> map);

	Map<String, Object> login_ok(Map<String, Object> map);

	boolean edit(Map<String, Object> map);

	Map<String, Object> detail(Map<String, Object> map);

	

}

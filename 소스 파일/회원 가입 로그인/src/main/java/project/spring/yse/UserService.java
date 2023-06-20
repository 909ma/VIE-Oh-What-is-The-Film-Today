package project.spring.yse;

import java.util.Map;

public interface UserService {

	String regist(Map<String, Object> map);
	boolean checkDuplicate(String loginID, String nickname);

}
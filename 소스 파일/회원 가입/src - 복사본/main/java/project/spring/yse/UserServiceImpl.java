package project.spring.yse;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao userDao;
	
	@Autowired
    BCryptPasswordEncoder passwordEncoder;
	
	
    @Override
    public String regist(Map<String, Object> map){
        String loginID = (String) map.get("LoginID");
        String nickname = (String) map.get("Nickname");

        // ID 또는 닉네임이 이미 존재하는지 확인합니다.
        boolean isDuplicate = userDao.checkDuplicate(loginID, nickname);
        if (isDuplicate) {
            return "Duplicate";
        }

        // 사용자 삽입을 수행합니다.
        String rawPassword = (String) map.get("Password");
        String encodedPassword = passwordEncoder.encode(rawPassword);
        map.put("Password", encodedPassword);

        int affectedRowCount = userDao.insert(map);
        if (affectedRowCount == 1) {
            return map.get("UserNumber").toString();
        }

        return null;
    }


	@Override
	public boolean checkDuplicate(String loginID, String nickname) {
		// TODO Auto-generated method stub
		return false;
	}


	
	
}
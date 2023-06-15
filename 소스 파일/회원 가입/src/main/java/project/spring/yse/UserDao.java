package project.spring.yse;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public int insert(Map<String, Object> map) {
        return this.sqlSessionTemplate.insert("user.insert", map);
    }

    public boolean checkDuplicate(String loginID, String nickname) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("loginID", loginID);
        paramMap.put("nickname", nickname);
        Integer count = sqlSessionTemplate.selectOne("user.checkDuplicate", paramMap);
        return count != null && count > 0;
    }
    

 
}
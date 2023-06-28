package com.wtf.freeboard;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeboardDao {

    private final SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    public FreeboardDao(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    public int insert(HashMap<String, Object> paramMap) {
        return sqlSessionTemplate.insert("freeboard.insert", paramMap);
    }

    public HashMap<String, Object> selectDetail(int postId) {
        return sqlSessionTemplate.selectOne("freeboard.selectDetail", postId);
    }

    public int update(HashMap<String, Object> paramMap) {
        return sqlSessionTemplate.update("freeboard.update", paramMap);
    }

    public int delete(int postId) {
        return sqlSessionTemplate.delete("freeboard.delete", postId);
    }

    public List<HashMap<String, Object>> selectList(HashMap<String, Object> paramMap) {
        return sqlSessionTemplate.selectList("freeboard.selectList", paramMap);
    }

    public int countFreeboard(HashMap<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("freeboard.countFreeboard", paramMap);
    }

    public int incrementViews(int postId) {
        return sqlSessionTemplate.update("freeboard.incrementViews", postId);
    }
}

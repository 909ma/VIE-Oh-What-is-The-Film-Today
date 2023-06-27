package com.wtf.announcement;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AnnouncementDao {
  
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;

  public int insert(Map<String, Object> map) {
    return this.sqlSessionTemplate.insert("notice.insert", map);
  }

  public Map<String, Object> selectDetail(int noticeId) {
    return this.sqlSessionTemplate.selectOne("notice.selectDetail", noticeId);
  }

  public int update(Map<String, Object> map) {
    return this.sqlSessionTemplate.update("notice.update", map);
  }

  public int delete(int noticeId) {
    return this.sqlSessionTemplate.delete("notice.delete", noticeId);
  }

  public List<Map<String, Object>> selectList(Map<String, Object> map) {
    return this.sqlSessionTemplate.selectList("notice.selectList", map);
  }

  public int countNoticeBoard(Map<String, Object> map) {
    return this.sqlSessionTemplate.selectOne("notice.countNoticeBoard", map);
  }

}

package com.wtf.announcement;

import java.util.List;
import java.util.Map;

public interface AnnouncementService {

    void create(Map<String, Object> map);

    Map<String, Object> getDetail(int noticeId);

    boolean update(Map<String, Object> map);

    boolean delete(int noticeId);

    List<Map<String, Object>> getList(Map<String, Object> map);

    int countNoticeBoard(Map<String, Object> map);

}

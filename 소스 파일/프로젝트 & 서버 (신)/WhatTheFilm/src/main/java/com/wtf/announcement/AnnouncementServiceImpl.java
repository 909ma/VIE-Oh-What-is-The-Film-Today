package com.wtf.announcement;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AnnouncementServiceImpl implements AnnouncementService {

    @Autowired
    private AnnouncementDao announcementDao;

    @Override
    public void create(Map<String, Object> map) {
        announcementDao.insert(map);
    }

    @Override
    public Map<String, Object> getDetail(int noticeId) {
        return announcementDao.selectDetail(noticeId);
    }

    @Override
    public boolean update(Map<String, Object> map) {
        int result = announcementDao.update(map);
        return result > 0;
    }

    @Override
    public boolean delete(int noticeId) {
        int result = announcementDao.delete(noticeId);
        return result > 0;
    }

    @Override
    public List<Map<String, Object>> getList(Map<String, Object> map) {
        return announcementDao.selectList(map);
    }

    @Override
    public int countNoticeBoard(Map<String, Object> map) {
        return announcementDao.countNoticeBoard(map);
    }
}

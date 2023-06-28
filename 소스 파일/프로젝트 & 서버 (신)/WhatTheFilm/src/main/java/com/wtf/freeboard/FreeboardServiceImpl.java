package com.wtf.freeboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class FreeboardServiceImpl implements FreeboardService {

    private final FreeboardDao freeboardDao;

    @Autowired
    public FreeboardServiceImpl(FreeboardDao freeboardDao) {
        this.freeboardDao = freeboardDao;
    }

    @Override
    public void create(HashMap<String, Object> paramMap) {
        freeboardDao.insert(paramMap);
    }

    @Override
    public HashMap<String, Object> getDetail(int postId) {
        return freeboardDao.selectDetail(postId);
    }

    @Override
    public boolean update(HashMap<String, Object> paramMap) {
        int result = freeboardDao.update(paramMap);
        return result > 0;
    }

    @Override
    public boolean delete(int postId) {
        int result = freeboardDao.delete(postId);
        return result > 0;
    }

    @Override
    public List<HashMap<String, Object>> getList(HashMap<String, Object> paramMap) {
        return freeboardDao.selectList(paramMap);
    }

    @Override
    public int countFreeboard(HashMap<String, Object> paramMap) {
        return freeboardDao.countFreeboard(paramMap);
    }

    @Override
    public boolean incrementViews(int postId) {
        int result = freeboardDao.incrementViews(postId);
        return result > 0;
    }
}

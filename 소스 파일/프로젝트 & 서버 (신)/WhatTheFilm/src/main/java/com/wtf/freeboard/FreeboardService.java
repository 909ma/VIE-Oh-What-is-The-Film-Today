package com.wtf.freeboard;

import java.util.HashMap;
import java.util.List;

public interface FreeboardService {
    void create(HashMap<String, Object> paramMap);
    HashMap<String, Object> getDetail(int postId);
    boolean update(HashMap<String, Object> paramMap);
    boolean delete(int postId);
    List<HashMap<String, Object>> getList(HashMap<String, Object> paramMap);
    int countFreeboard(HashMap<String, Object> paramMap);
    boolean incrementViews(int postId);
}

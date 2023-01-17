package com.mongo.db.service;

import java.util.List;

import com.mongo.db.PostVO;

public interface MongoService {
	
	List<PostVO> getNaverList(String addr) throws Exception;
	boolean createCollection() throws Exception;
}

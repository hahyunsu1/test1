package com.mongo.db.mapper;

import java.util.List;

import com.mongo.db.PostVO;

public interface MongoMapper {
	
	boolean createCollection(String colName) throws Exception;
	
	List<PostVO> getNaverList(String colName, String addr) throws Exception;
}

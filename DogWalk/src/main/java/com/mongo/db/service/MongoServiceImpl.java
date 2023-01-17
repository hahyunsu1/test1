package com.mongo.db.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mongo.db.PostVO;
import com.mongo.db.mapper.MongoMapper;

@Service
public class MongoServiceImpl implements MongoService {
	
	
	@Autowired
	private MongoMapper mMapper;
	@Override
	public List<PostVO> getNaverList(String addr) throws Exception {
		String collectionName="동물병원현황";
		return this.mMapper.getNaverList(collectionName, addr);
	}
	@Override
	public boolean createCollection() throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

}

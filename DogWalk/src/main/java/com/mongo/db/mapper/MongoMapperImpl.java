package com.mongo.db.mapper;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.mongo.db.PostVO;

@Repository
public class MongoMapperImpl implements MongoMapper {
	
	@Resource(name="mongoTemplate")
	private MongoTemplate mTemplate;
	@Override
	public boolean createCollection(String colName) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public List<PostVO> getNaverList(String colName, String addr) throws Exception {
		

		return this.mTemplate.find(Query.query(Criteria.where("REFINE_LOTNO_ADDR").regex(addr)),PostVO.class,colName);
	}

}

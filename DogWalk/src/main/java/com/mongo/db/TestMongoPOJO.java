package com.mongo.db;

//static import 문을 이용하여 클래스명을 생략하고 사용해보자.
//eq(), gt(), lt(), gte()...
import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Filters.ne;
import static com.mongodb.client.model.Updates.combine;
import static com.mongodb.client.model.Updates.set;
import static org.bson.codecs.configuration.CodecRegistries.fromProviders;
import static org.bson.codecs.configuration.CodecRegistries.fromRegistries;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

import org.bson.codecs.configuration.CodecRegistry;
import org.bson.codecs.pojo.PojoCodecProvider;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import com.mongodb.ConnectionString;
import com.mongodb.MongoClientSettings;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.InsertManyResult;
import com.mongodb.client.result.UpdateResult;

public class TestMongoPOJO {
	
	String db="동물병원현황";
	String table="posts";
	MongoClient mclient;
	MongoDatabase mdb;
	MongoCollection<PostVO> mcol;
	Scanner sc=new Scanner(System.in);
	
	public TestMongoPOJO() {
		this.mappingPojo();
	}

		private void mappingPojo() {
			ConnectionString conStr = new ConnectionString("mongodb://localhost:27017");
			CodecRegistry pojoCodec = fromProviders(PojoCodecProvider.builder().automatic(true).build());
			CodecRegistry codecRegistry = fromRegistries(MongoClientSettings.getDefaultCodecRegistry(), pojoCodec);
			MongoClientSettings clientSettings = MongoClientSettings.builder().applyConnectionString(conStr)
					.codecRegistry(codecRegistry).build();
			
			mclient = MongoClients.create(clientSettings);
			//몽고클라이언트 객체를 생성한뒤 이를 통해 몽고데이터베이스를 얻어온다.
			mdb = mclient.getDatabase(db);
		}// ----------------------------------
	
	
	public void findAll() {
		mcol=mdb.getCollection(table,PostVO.class);
		FindIterable<PostVO> cursor=mcol.find();
		MongoCursor<PostVO> mcr=cursor.iterator();
		List<PostVO> arr=new ArrayList<>();
		System.out.println("*******POSTS 목록***********");
		while(mcr.hasNext()) {
			PostVO vo=mcr.next();
			arr.add(vo);
			System.out.println(vo.getTitle()+"\t"+vo.getAuthor()+"\t"+vo.getWdate());
		}
	}//////////////////////
	
}

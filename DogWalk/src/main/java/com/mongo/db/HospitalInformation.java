package com.mongo.db;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

import org.bson.Document;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.result.InsertOneResult;

public class HospitalInformation {
	MongoClient mclient;
	MongoDatabase mongodb;
	MongoCollection<Document> mcol;
	Scanner sc=new Scanner(System.in);
	
	public HospitalInformation() {
		mclient=MongoClients.create("mongodb://localhost:27017");
		mongodb=mclient.getDatabase("동물병원현황");
		mcol=mongodb.getCollection("posts");
		System.out.println("몽고디비 동물병원현황 데이터베이스 접속 완료");		
		
		
	}
	public void close() {
		if(mclient!=null) {
			mclient.close();
		}
	}//-----------------
	
	//모든 목록 가져오기
	public void selectPostsAll() {
		FindIterable<Document> cursor=mcol.find();
		for(Document doc:cursor) {
			String title=doc.get("title").toString();
			//System.out.println(title);
			System.out.println(doc.toJson());//json문자열을 반환
		}
	}//------------------------------
	public void selectPostsAll2() {
		FindIterable<Document> cr=mcol.find();
		MongoCursor<Document> mcr= cr.iterator();
		while(mcr.hasNext()) {
			Document doc=mcr.next();
			String title=doc.getString("title");
			String author=doc.getString("author");
			String wdate=doc.getString("wdate");
			System.out.println(title+"\t"+author+"\t"+wdate);
		}
		
	}//---------------------------
	

	public static void main(String[] args) {
		HospitalInformation app=new HospitalInformation();
		//app.insertPosts();
		System.out.println("---POSTS목록 가져오기----");
		app.selectPostsAll();
		System.out.println("---POSTS목록 가져오기2----");
		app.selectPostsAll2();
		
		
	}//--------------------
	

}


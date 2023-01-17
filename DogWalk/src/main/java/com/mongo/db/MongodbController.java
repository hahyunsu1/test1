package com.mongo.db;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;

import javax.inject.Inject;

import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.member.controller.MemberController;
import com.mongo.db.service.MongoService;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class MongodbController {
	/*
	 * MongoClient mclient; MongoDatabase mongodb; MongoCollection<Document> mcol;
	 * Scanner sc=new Scanner(System.in);
	 * 
	 * public MongodbController() {
	 * mclient=MongoClients.create("mongodb://localhost:27017");
	 * mongodb=mclient.getDatabase("동물병원현황"); mcol=mongodb.getCollection("동물병원현황");
	 * System.out.println("몽고디비 mydb데이터베이스 접속 완료");
	 * 
	 * }
	 * 
	 * public void close() { if(mclient!=null) { mclient.close(); } }
	 */
	
	
	@Inject
	private MongoService mService;
	
	

	
	@GetMapping(value="/list", produces = "application/json")
	public List<PostVO> getNaverList(String addr) throws Exception{
		log.info("addr==="+addr);
		List<PostVO> arrList=this.mService.getNaverList(addr);
		log.info("arrList==="+arrList);
		return arrList;
	}
	
}

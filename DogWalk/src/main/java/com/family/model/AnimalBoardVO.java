package com.family.model;

import java.sql.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AnimalBoardVO {
	
	private String mode;//쓰기 수정 삭제
	private int cnum; //글번호
	private String userid;//유저아이디
	private String nick; //작성자 닉네임
	private String cpass; //게시글패스워드
	private String title; //게시글 제목
	private String content; //게시글 내용
	private String mail_fk;
	private Date wdate;
	private int cnt;//조회수
	private String filename;//물리적 파일명
	private String originFilename;//원본 파일명
	private long filesize;//첨부파일 크기
	
	private String pet;//동물
	private int price;
	
	private String myaddr;
	private String Old_filename;
	
}

package com.family.board.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class BoardVO {
	int cnum;
	
	int bno;
	String title;
	String content;
	String writer;
	Date regdate;
	Date updatedate;
	int views;
}

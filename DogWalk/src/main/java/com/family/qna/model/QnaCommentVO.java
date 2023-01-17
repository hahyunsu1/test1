package com.family.qna.model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class QnaCommentVO {
	
	private int qnaindex;
	private int qaindex;  //Qna 인덱스(FK)
	private String userid;
	private int qnalike;
	private String content;
	private String scstate;
	private String rtime;
	private int refer;
	private int depth;
	private int step;
}

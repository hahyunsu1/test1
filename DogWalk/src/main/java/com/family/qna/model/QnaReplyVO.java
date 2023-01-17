package com.family.qna.model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class QnaReplyVO {

	private String title;
	private String id;
	private int qaindex;
	private String content;
	private String qartime;
}

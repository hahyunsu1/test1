package com.message.model;

import lombok.Data;




@Data
public class ChatMember {
	
	private int mem_number;
	private int room_number;
	private String user_email;
	private String user_nickname;
}

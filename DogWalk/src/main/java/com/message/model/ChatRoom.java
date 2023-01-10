package com.message.model;
import lombok.Data;




@Data
public class ChatRoom {
	private int room_number;
	private String room_title;
	private String user_email;
	private int room_count;
	private String room_secret;
	private int room_pwd;
	
	//join
	private String user_nickname;
	
		
	private int current_count;
}

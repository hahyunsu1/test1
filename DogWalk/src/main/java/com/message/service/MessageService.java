package com.message.service;

import java.util.HashMap;

import com.message.model.Message;

public interface MessageService {

	int writeMessage(Message message);

	HashMap<String, Object> sPageView(String cp, String ps, String userid);

	HashMap<String, Object> rPageView(String cp, String ps, String userid);

	Message getMessage(String msindex, String ruserid);

	int deleteMessage(Message msindex);

	

	
	

}

package com.message.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.message.model.ChatMember;
import com.message.model.ChatRoom;

public interface ChatService {

	
	//채팅방 리스트
	public List<ChatRoom> getChatList() throws ClassNotFoundException, SQLException;
	
	//채팅방 만들기
	public String createChatRoom(ChatRoom chatroom, HttpSession session, HttpServletRequest requset) throws ClassNotFoundException, SQLException;
	
	//채팅방 들어가기
	public String selectChatRoomByRn(int room_number, HttpServletRequest request, Model model) throws ClassNotFoundException, SQLException;
		
	
	//채팅방 멤버리스트 닉네임 불러오기
	public List<ChatMember> getMemberList(int room_number) throws ClassNotFoundException, SQLException;
		
	//채팅방 비밀번호 불러오기
	public int getRoomPwd(int room_number) throws ClassNotFoundException, SQLException;	
	
	//채팅방 나가기	
	public String exitChatRoom(String user_email, int room_number) throws ClassNotFoundException, SQLException;
		
	//채팅방 삭제하기
	public String deleteChatRoom(int room_number) throws ClassNotFoundException, SQLException;
}

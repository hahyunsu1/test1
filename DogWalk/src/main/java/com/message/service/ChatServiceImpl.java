package com.message.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.member.model.MemberVO;
import com.message.mapper.ChatMapper;
import com.message.model.ChatMember;
import com.message.model.ChatRoom;

@Service("chatServiceImpl")
public class ChatServiceImpl implements ChatService {

	private SqlSession sqlsession;
	
	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	
	//채팅방 리스트
	public List<ChatRoom> getChatList() throws ClassNotFoundException, SQLException {
		ChatMapper ChatMapper = sqlsession.getMapper(ChatMapper.class);
		return ChatMapper.getChatList();
	}
	
	
	//채팅방 만들기
	public String createChatRoom(ChatRoom chatroom, HttpSession session, HttpServletRequest requset) throws ClassNotFoundException, SQLException {
		ChatMapper ChatMapper = sqlsession.getMapper(ChatMapper.class);
		MemberVO user = (MemberVO)session.getAttribute("member");
		String userid = user.getUserid();
		String nick = user.getNick();
		System.out.println("값을 보자"+userid);
		System.out.println("값을 보자"+nick);
		
		if(chatroom.getRoom_secret() == null){ 
			chatroom.setRoom_secret("N"); 
		}else { 
			chatroom.setRoom_secret("Y"); 
			}
				
		
		chatroom.setUser_email(userid);
		chatroom.setUser_nickname(nick);
		ChatMapper.createChatRoom(chatroom);
		return "redirect:selectChatRoomByRn?room_number="+chatroom.getRoom_number();
	}
	
	//채팅방 들어가기
	public String selectChatRoomByRn(int room_number, HttpServletRequest request, Model model) throws ClassNotFoundException, SQLException {
		ChatMapper ChatMapper = sqlsession.getMapper(ChatMapper.class);
		ChatRoom chatroom = ChatMapper.selectChatRoomByRn(room_number);
		int currentCount = ChatMapper.getMemberCount(room_number);
		int totalCount = chatroom.getRoom_count();

		if (currentCount < totalCount) {
			
			
			 HttpSession session = request.getSession(); 
			 MemberVO user = (MemberVO)session.getAttribute("member");
			
			 String userid = user.getUserid();
			 int userCount = ChatMapper.countUserInRoom(room_number, userid);
			 
			 if(userCount > 0) {
				 ChatMapper.removeMember(userid, room_number);
			 }
			 
			 
			ChatMapper.addMember(room_number, userid);
			
			 model.addAttribute("user_email", userid);
			 model.addAttribute("chat", chatroom);
			
			
			
			return "chat/chatRoom";
		}
			return "redirect:chatList";
		}
	
		//채팅방 멤버리스트 닉네임 불러오기
		public List<ChatMember> getMemberList(int room_number) throws ClassNotFoundException, SQLException {
			ChatMapper ChatMapper = sqlsession.getMapper(ChatMapper.class);
			return ChatMapper.getMemberList(room_number);
		}
		
		//채팅방 비밀번호 불러오기
		public int getRoomPwd(int room_number) throws ClassNotFoundException, SQLException {
			ChatMapper ChatMapper = sqlsession.getMapper(ChatMapper.class);
			return ChatMapper.getRoomPwd(room_number);
		}
	
	
	
		//채팅방 나가기	
		public String exitChatRoom(String user_email, int room_number) throws ClassNotFoundException, SQLException {
			ChatMapper ChatMapper = sqlsession.getMapper(ChatMapper.class);
			ChatMapper.removeMember(user_email, room_number);
			return "redirect:/chatList.bit";
		}
		
		//채팅방 삭제하기
		public String deleteChatRoom(int room_number) throws ClassNotFoundException, SQLException {
			ChatMapper ChatMapper = sqlsession.getMapper(ChatMapper.class);
			//ChatMapper.removeMember(user_email, room_number);
			ChatMapper.deleteChatRoom(room_number);
			return "redirect:/chatList.bit";
		}

}

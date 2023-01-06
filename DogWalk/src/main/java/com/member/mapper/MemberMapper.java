package com.member.mapper;

import java.util.List;

import com.member.model.MemberVO;

public interface MemberMapper {
	 int MemberJoin(MemberVO member);//회원등록
	 
	 int idCheck(String userid);
	 
	 int nickCheck(String nick);
	 
	 MemberVO memberLogin(MemberVO member);//로그인
	 
	 int updateMember(MemberVO member);
	 
	 MemberVO selectById(String userid);
	 
	 public List<String> getNick(String nick);
	 
	 public int editPwd(String pwd,String userid);
	 
	 public int deleteUser(String userid);
	 
	 public int editUser(MemberVO user);
	 
	 public MemberVO getUser(String userid);
}

package com.member.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	private int idx;
	private String name;
	private String userid;
	private String pwd;
	private String hp1,hp2,hp3;
	private String post;
	private String addr1,addr2;
	private java.sql.Date indate;
	private int status; //회원상태(0:일반회원, 1:비회원, -1:비매너회원, -2:정지회원 99:운영진)
	private String nick;
	private String mail;
	private String rrn1,rrn2;
	private String snstype;
	
	public String getAllHp() {
		return hp1+"-"+hp2+"-"+hp3;
	}
	
	public String getAllAddr() {
		return "["+post+"]"+addr1+" "+addr2;
	}
	
	public String getAllRrn() {
		return rrn1+"-"+rrn2;
	}
	
}



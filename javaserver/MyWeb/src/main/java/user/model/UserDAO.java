package user.model;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import common.util.*;
import memo.model.MemoVO;
public class UserDAO {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	public UserDAO() {
		System.out.println("UserDAO생성자()...");
	}
	public UserVO loginCheck(String userid,String pwd) throws SQLException, NotUserException{
		try {
			con=DBUtil.getCon();
			UserVO user = this.selectUserByUserid(userid);
			if(user==null) {//아이디가 없는 경우 => 예외 발생
				throw new NotUserException(userid+"란 아이디는 존재하지 않아요");
				
			}
			//비밀번호 일치여부를 체크
			String dbPwd=user.getPwd();
			if(!dbPwd.equals(pwd)) {//비밀번호가 틀린경우 => 예외 발생
				throw new NotUserException("비밀번호가 일치하지 않아요");
			}
			return user;//아이디와 비번이 일치한 경우 user를 반환
		} finally {
			close();
		}
	}
	private UserVO selectUserByUserid(String userid) throws SQLException{
		try {
			con=DBUtil.getCon();
			String sql="select member.*, decode(status,0,'활동회원',-1,'정지회원',-2,'탈퇴회원',9,'관리자') statusStr from member where userid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			List<UserVO> arr=makeList(rs);
			if(arr!=null&&arr.size()==1) {
				UserVO user=arr.get(0);
				return user;
			}
			return null;
		} finally {
			close();
		}
	}
	public boolean idCheck(String userid) throws SQLException{
		try {
			con=DBUtil.getCon();
			StringBuilder buf=new StringBuilder("select idx from member where userid=?");
			String sql=buf.toString();
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			
			boolean b=rs.next();//b가 true면 해당 아이디가 있다는 얘기=>false를 반환
			return !b;
		}finally {
			close();
		}
	}
	
	public int insertUser(UserVO user) throws SQLException{
		try {
			con=DBUtil.getCon();
			StringBuilder buf=new StringBuilder("insert into member ")
					.append(" values(member_seq.nextval,?,?,?,?,?,?,?,?,?,sysdate,1000,0)");
			String sql=buf.toString();
			ps=con.prepareStatement(sql);
			ps.setString(1, user.getName());
			ps.setString(2, user.getUserid());
			ps.setString(3, user.getPwd());
			ps.setString(4, user.getHp1());
			ps.setString(5, user.getHp2());
			ps.setString(6, user.getHp3());
			ps.setString(7, user.getPost());
			ps.setString(8, user.getAddr1());
			ps.setString(9, user.getAddr2());
			return ps.executeUpdate();
		}finally {
			close();
		}
	}
	public List<UserVO> listUser() throws SQLException{
		try {
			con=DBUtil.getCon();
			StringBuilder buf=new StringBuilder("select member.*,")
				.append(" decode(status,0,'활동회원',-1,'정지회원',-2,'탈퇴회원',9,'관리자') statusStr")
				.append(" from member order by idx desc");
			String sql=buf.toString();
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			List<UserVO> arr=makeList(rs);
			return arr;
		}finally {
			close();
		}
	}
	
	private List<UserVO> makeList(ResultSet rs) throws SQLException{
		List<UserVO> arr=new ArrayList<>();
		while(rs.next()) {
			int idx=rs.getInt("idx");
			String name=rs.getString("name");
			String userid=rs.getString("userid");
			String pwd=rs.getString("pwd");
			String hp1=rs.getString("hp1");
			String hp2=rs.getString("hp2");
			String hp3=rs.getString("hp3");
			String post=rs.getString("post");
			String addr1=rs.getString("addr1");
			String addr2=rs.getString("addr2");
			java.sql.Date indate=rs.getDate("indate");
			int mileage=rs.getInt("mileage");
			int status=rs.getInt("status");
			String statusStr=rs.getString("statusStr");
			UserVO user
			=new UserVO(idx,name,userid,pwd,hp1,hp2,hp3,post,addr1,addr2,indate,mileage,status,statusStr);
			arr.add(user);
		}
		return arr;
	}
	public UserVO selectUserByIdx(int idx) throws SQLException{
		try {
			con=DBUtil.getCon();
			String sql="select member.*, decode(status,0,'활동회원',-1,'정지회원',-2,'탈퇴회원',9,'관리자') statusStr from member where idx=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			List<UserVO> arr=makeList(rs);
			if(arr==null&&arr.size()==0) {
				return null;
			}
			UserVO user=arr.get(0);
			return user;
		} finally {
			close();
		}
	}
	public int updateUser(UserVO user) throws SQLException{
		try {
			con=DBUtil.getCon();
			StringBuilder buf=new StringBuilder("update member set name=?, userid=?,pwd=?, hp1=?,hp2=?,hp3=?, ")
										.append(" post=?, addr1=?,addr2=?, status=? where idx=?");
			String sql=buf.toString();
			ps=con.prepareStatement(sql);
			ps.setString(1, user.getName());
			ps.setString(2, user.getUserid());
			ps.setString(3, user.getPwd());
			ps.setString(4, user.getHp1());
			ps.setString(5, user.getHp2());
			ps.setString(6, user.getHp3());
			ps.setString(7, user.getPost());
			ps.setString(8, user.getAddr1());
			ps.setString(9, user.getAddr2());
			ps.setInt(10, user.getStatus());
			ps.setInt(11, user.getIdx());
			
			return ps.executeUpdate();
		} finally {
			close();
		}
	}
	public void close() { 
		try {
			if(rs!=null) rs.close();
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		}catch(SQLException e) {
			System.out.println("close() error: "+e);
		}
	}
}

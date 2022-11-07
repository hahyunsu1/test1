package memo.model;
import java.sql.*;
import java.util.*;

import common.util.*;

//Data Access Object : 모델에 속하며 영속성(Persistence) 계층이라고 부른다.
public class MemoDAO {
	
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	public int insertMemo(MemoVO memo) throws SQLException{
		try {
			con=DBUtil.getCon();
			//String Limmutable (불변성) 원본은 변하지 않음.+(문자열결합)
			//StringBuilder.StringBuffer : 문자열을 메모리 버퍼에 넣고 수정.삭제,삽입 등의 편집작업을 할 수 있음
			StringBuilder buf=new StringBuilder("INSERT INTO memo(idx,name,msg,wdate) ")
					.append(" VALUES(memo_seq.nextval,?,?,sysdate)");
			String sql=buf.toString();
//			String sql="INSERT INTO memo(idx,name,msg,wdate)";
//			sql+=" VALUES(memo_seq.nextval,?,?,sysdate)";
			ps=con.prepareStatement(sql);			
			
			ps.setString(1, memo.getName());
			ps.setString(2, memo.getMsg());
			int n=ps.executeUpdate();
//			ps.execute();
			return n;
		}finally {
			close();
		}
	}
	
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}

	public List<MemoVO> selectMemoAll() throws SQLException{
		try {
			con=DBUtil.getCon();
			StringBuilder buf=new StringBuilder("select idx,rpad(name,12,' ')name, rpad(msg,100,' ')msg,")
					.append(" wdate from memo order by idx desc");
			String sql=buf.toString();
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			List<MemoVO> arr=makeList(rs);
			return arr;
		}finally {
			close();
		}
		
	}

	private List<MemoVO> makeList(ResultSet rs) throws SQLException {
		List<MemoVO> arr=new ArrayList<>();
		while(rs.next()) {
			int idx=rs.getInt("idx");
			String name=rs.getString("name");
			String msg=rs.getString("msg");
			java.sql.Date wdate=rs.getDate("wdate");
			MemoVO vo=new MemoVO(idx,name,msg,wdate);
			arr.add(vo);
		}
		return arr;
	}

	public int deleteMemo(int idx) throws SQLException{
		try {
		con=DBUtil.getCon();
		StringBuilder buf=new StringBuilder("delete from memo where idx = ?");
				
		String sql=buf.toString();
		ps=con.prepareStatement(sql);
		ps.setInt(1,idx);
		int n=ps.executeUpdate();
		
		return n;
		}finally {
			close();
		}
		
	}

	public MemoVO selectMemo(int idx) throws SQLException{
		
		try {
			con=DBUtil.getCon();
			StringBuilder buf=new StringBuilder("SELECT idx,name,msg,wdate FROM memo WHERE idx= ?");		
			String sql=buf.toString();
			ps=con.prepareStatement(sql);
			ps.setInt(1,idx);
			rs=ps.executeQuery();			
			List<MemoVO> arr=makeList(rs);
			if(arr!=null && arr.size()==1) {
				return arr.get(0);
			}
			return null;
		}finally {
			close();
		}
	}
	public int updateMemo(MemoVO vo) throws SQLException{
		try {
			con=DBUtil.getCon();
			StringBuilder buf=new StringBuilder("update memo set name=?, msg=? ")
					.append(" where idx=?");
			String sql=buf.toString();
			ps=con.prepareStatement(sql);			
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getMsg());
			ps.setInt(3, vo.getIdx());
			int n=ps.executeUpdate();
			return n;
		}finally {
			close();
		}
	}

	public List<MemoVO> findMemo(int type, String keyword) throws SQLException {
		try {
			con=DBUtil.getCon();
			String colName=(type==0)?"name":"msg";
			StringBuilder buf=new StringBuilder("SELECT idx,name,msg,wdate FROM memo ")
			.append(" WHERE "+colName+" like ?");
			
			String sql=buf.toString();
			ps=con.prepareStatement(sql);
			ps.setString(1,"%"+keyword+"%");
			rs=ps.executeQuery();			
			List<MemoVO> arr=makeList(rs);
			
			
			
			return arr;
			
		}finally {
			close();
		}
	}
}

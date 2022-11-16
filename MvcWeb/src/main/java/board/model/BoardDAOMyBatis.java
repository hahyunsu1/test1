package board.model;

import org.apache.ibatis.io.*;
import org.apache.ibatis.session.*;
import org.apache.ibatis.session.defaults.DefaultSqlSessionFactory;

import java.util.*;
import java.io.*;

public class BoardDAOMyBatis {
	// 어떤 mapper를 사용할지 정함(네임스페이스 지정 필수)
	private final String NS = "board.model.BoardMapper";
	// 세션팩토리를 얻는 메소드 구성
	String resource = "common/config/mybatis-config.xml";
	private SqlSession ses;

	private SqlSessionFactory getSessionFactory() {

		try {
			InputStream is = Resources.getResourceAsStream(resource);
			SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(is);
			return factory;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

	}

	/**[게시판 목록 관련]총 게시글 수 가져오기*/
		public int getTotalCount() {
		ses=this.getSessionFactory().openSession();
		int count=ses.selectOne(NS+".totalCount");
		if(ses!=null) ses.close();
		return count;
		
	}

	public int insertBoard(BoardVO vo) {
		ses=this.getSessionFactory().openSession();//디폴트가 수동 커밋이다.
		int n=ses.insert(NS+".insertBoard",vo);
		if(n>0) {
			ses.commit();
		}else {
			ses.rollback();
		}
		if(ses!=null) ses.close();
		return n;
	}

	public List<BoardVO> listBoard() {
		ses=this.getSessionFactory().openSession();
		//다중행을 가져올 떄는 selectList()
		//단일행을 가져올 떄는 selectOne()
		List<BoardVO> arr=ses.selectList(NS+".listBoard");
		if(ses!=null) ses.close();
		return arr;
	}

	public List<BoardVO> viewBoard(String num) {
		ses=this.getSessionFactory().openSession();
		List<BoardVO> arr=ses.selectList(NS+".boardView",num);
		if(ses!=null) ses.close();
		return arr;
	}

	public BoardVO viewBoard(int num) {
		try {
		ses=this.getSessionFactory().openSession();
		BoardVO vo=ses.selectOne(NS+".viewBoard",num);
		return vo;
		}finally {
			close();
		}
	}
	public void close() {
		if(ses!=null) ses.close();
	}

	public int deleteBoard(int num) {
		try {
		ses=this.getSessionFactory().openSession(true);
		//디폴트가 수동 커밋이다. 매개변수로 true를 넘기면 auto commit된다
		int n=ses.insert(NS+".deleteBoard",num);		
		return n;
		}finally {
			close();
		}
	
	}

	public int updateBoard(BoardVO vo) {
		try {
			ses=this.getSessionFactory().openSession(true);
			int n=ses.insert(NS+".updateBoard",vo);
			return n;
		} finally {
			close();
		}
	}
}

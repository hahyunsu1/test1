package com.family.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.family.board.model.BoardVO;

public interface BoardMapper {
	//DB 에서 사용할 쿼리문의 메서드 이름을 정의하는곳
	// interface 실제 구현된 메서드가 들어갈 수 없음 추상 메서드만 들어갈 수 있다
	//접근제어자 리턴타입 메서드이름 (파라미터......);
	public int boardCount();
	//@Select("select * from tbl_board where bno > 0")
	
	public List<BoardVO> getList();

	void insert(BoardVO VO);
	
	BoardVO read(Long cnum);
	
	int delete (Long cnum);
}

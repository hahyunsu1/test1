package com.family.service;

import java.util.List;
import java.util.Map;


import com.family.model.AnimalBoardVO;
import com.family.model.PagingVO;

public interface AnimalBoardService {
	int insertBoard(AnimalBoardVO amb);
	
	List<AnimalBoardVO> selectBoardAll(Map<String,Integer> map);
	List<AnimalBoardVO> selectBoardAllPaging(PagingVO pageing);
	
	List<AnimalBoardVO> findBoard(PagingVO paging);
	
	int getTotalCount();//총게시글 수
	int getTotalCount(PagingVO paging);//검색한 총 게시글
	
	AnimalBoardVO selectBoardByIdx(Integer idx);//글번호로 해당글 가져오기
	
	int updateCnt(Integer idx);//조회수 증가
	
	String selectPwd(Integer idx);//수정글 가져오기
	int deleteBoard(Integer idx);//삭제
	int updateBoard(AnimalBoardVO amb);//수정
	
}

package com.family.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.family.mapper.AnimalBoardMapper;
import com.family.model.AnimalBoardVO;
import com.family.model.PagingVO;

@Service("animalBoardServiceImpl")
public class AnimalBoardServiceImpl implements AnimalBoardService {
	
	@Autowired
	private AnimalBoardMapper aniMapper;
	
	@Override
	public int insertBoard(AnimalBoardVO amb) {
		System.out.println(amb);
		return this.aniMapper.insertBoard(amb);
	}

	@Override
	public List<AnimalBoardVO> selectBoardAll(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return this.aniMapper.selectBoardAll(map);
	}

	@Override
	public List<AnimalBoardVO> selectBoardAllPaging(PagingVO pageing) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AnimalBoardVO> findBoard(PagingVO paging) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getTotalCount(PagingVO paging) {
		
		return this.aniMapper.getTotalCount(paging);
	}

	@Override
	public AnimalBoardVO selectBoardByIdx(Integer cnum) {
		
		return this.aniMapper.selectBoardByIdx(cnum);
	}

	@Override
	public int updateCnt(Integer cnum) {
		
		return this.aniMapper.updateCnt(cnum);
	}

	@Override
	public String selectPwd(Integer idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteBoard(Integer cnum) {
		
		return this.aniMapper.deleteBoard(cnum);
	}

	@Override
	public int updateBoard(AnimalBoardVO amb) {
		
		return this.aniMapper.updateBoard(amb);
	}

	@Override
	public AnimalBoardVO selectBoardUser(AnimalBoardVO amb) {
		
		return this.aniMapper.selectBoardUser(amb);
	}

}

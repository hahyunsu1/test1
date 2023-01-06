package com.family.board.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.family.board.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardMapper boardMapper;
	
	@Override
	public int boardCount() {
		return boardMapper.boardCount();
	}
	
}

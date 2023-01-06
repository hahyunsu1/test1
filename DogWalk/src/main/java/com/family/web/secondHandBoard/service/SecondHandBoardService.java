package com.family.web.secondHandBoard.service;

import com.family.web.secondHandBoard.model.SecondHandBoardVO;

import java.util.List;

public interface SecondHandBoardService {

    List<SecondHandBoardVO> selectAll(Integer page,
                                      String searchType,
                                      String keyword);

    SecondHandBoardVO selectByCnum(Long cnum);

    void insert(SecondHandBoardVO secondHandBoardVO);

    int count();
}

package com.family.web.secondHandBoard.mapper;

import com.family.web.secondHandBoard.model.SecondHandBoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SecondHandBoardMapper {
    List<SecondHandBoardVO> selectAll(@Param("start") Integer start,
                                      @Param("end") Integer end,
                                      @Param("searchType") String searchType,
                                      @Param("keyword") String keyword);

    SecondHandBoardVO selectByCnum(Long cnum);

    void insert(SecondHandBoardVO secondHandBoardVO);

    int count();
}

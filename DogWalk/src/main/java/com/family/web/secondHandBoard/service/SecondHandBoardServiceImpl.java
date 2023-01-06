package com.family.web.secondHandBoard.service;

import com.family.web.secondHandBoard.mapper.SecondHandBoardMapper;
import com.family.web.secondHandBoard.model.SecondHandBoardVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SecondHandBoardServiceImpl implements SecondHandBoardService {
    private final SecondHandBoardMapper secondHandBoardMapper;

    @Override
    public List<SecondHandBoardVO> selectAll(Integer page, String searchType, String keyword) {
        Integer start = 0;
        Integer end = 10;
        if (page != null) {
            start = (page - 1) * 10;
            end = page * 10;
        }
        return secondHandBoardMapper.selectAll(start, end, searchType, keyword);
    }

    @Override
    public SecondHandBoardVO selectByCnum(Long cnum) {
        return secondHandBoardMapper.selectByCnum(cnum);
    }

    @Override
    public void insert(SecondHandBoardVO secondHandBoardVO) {
        secondHandBoardMapper.insert(secondHandBoardVO);
    }

    @Override
    public int count() {
        return secondHandBoardMapper.count();
    }
}

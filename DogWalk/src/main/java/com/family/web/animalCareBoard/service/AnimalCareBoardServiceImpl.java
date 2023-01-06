package com.family.web.animalCareBoard.service;

import com.family.web.animalCareBoard.mapper.AnimalCareBoardMapper;
import com.family.web.animalCareBoard.model.AnimalCareBoardVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AnimalCareBoardServiceImpl implements AnimalCareBoardService {
    private final AnimalCareBoardMapper animalCareBoardMapper;

    @Override
    public List<AnimalCareBoardVO> selectAll(String tag, String kinds, Integer page) {
        Integer start = 0;
        Integer end = 6;
        if (page != null) {
            start = (page - 1) * 6;
            end = page * 6;
        }
        return animalCareBoardMapper.selectAll(tag, kinds, start, end);
    }

    @Override
    public void insert(AnimalCareBoardVO animalCareBoardVO) {
        animalCareBoardMapper.insert(animalCareBoardVO);
    }

    @Override
    public int count() {
        return animalCareBoardMapper.count();
    }
}

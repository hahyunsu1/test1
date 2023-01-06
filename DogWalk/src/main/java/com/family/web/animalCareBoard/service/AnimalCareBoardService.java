package com.family.web.animalCareBoard.service;

import com.family.web.animalCareBoard.model.AnimalCareBoardVO;

import java.util.List;

public interface AnimalCareBoardService {
    List<AnimalCareBoardVO> selectAll(String tag,
                                      String kinds,
                                      Integer page);

    void insert(AnimalCareBoardVO animalCareBoardVO);

    int count();
}

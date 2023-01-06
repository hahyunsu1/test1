package com.family.web.animalCareBoard.mapper;

import com.family.web.animalCareBoard.model.AnimalCareBoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AnimalCareBoardMapper {
    List<AnimalCareBoardVO> selectAll(@Param("tag") String tag,
                                      @Param("kinds") String kinds,
                                      @Param("start") Integer start,
                                      @Param("end") Integer end);

    void insert(AnimalCareBoardVO animalCareBoardVO);
    int count();

}

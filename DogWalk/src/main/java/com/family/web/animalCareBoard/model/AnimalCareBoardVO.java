package com.family.web.animalCareBoard.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AnimalCareBoardVO {
    private Long cnum;
    private String nickFk;
    private String cpss;
    private String title;
    private String content;
    private String kinds;
    private String tags;
    private LocalDate wdate;
    private Long cnt;
    private String filename;
    private String oldFilename;
    private Long filesize;
}
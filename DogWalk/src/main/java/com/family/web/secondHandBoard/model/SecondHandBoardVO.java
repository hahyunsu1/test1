package com.family.web.secondHandBoard.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SecondHandBoardVO {
    private Long cnum;
    private String nick_fk;
    private String cpss;
    private String title;
    private Long price;
    private String category;
    private String content;
    private LocalDate wdate;
    private Long cnt;
    private String filename;
    private String oldFilename;
    private Long filesize;
}

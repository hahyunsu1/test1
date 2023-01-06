package com.family.web.secondHandBoard.controller;

import com.family.web.animalCareBoard.model.AnimalCareBoardVO;
import com.family.web.secondHandBoard.model.SecondHandBoardVO;
import com.family.web.secondHandBoard.service.SecondHandBoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping(path = "second-hand")
@RequiredArgsConstructor
public class SecondHandBoardController {
    private final SecondHandBoardService secondHandBoardService;

    @GetMapping
    public String secondHand(Model model,
                             @RequestParam(value = "page", required = false) Integer page,
                             @RequestParam(value = "searchType", required = false) String searchType,
                             @RequestParam(value = "keyword", required = false) String keyword) {
        List<SecondHandBoardVO> secondHandBoardVOList = secondHandBoardService.selectAll(page, searchType,
                keyword);
        model.addAttribute("list", secondHandBoardVOList);

        int count = secondHandBoardService.count();
        int end = count % 10 == 0 ? (count / 10) : (count / 10) + 1;
        model.addAttribute("end", end);
        if (page != null) model.addAttribute("page", page);
        if (searchType != null) model.addAttribute("searchType", searchType);
        if (keyword != null) model.addAttribute("keyword", keyword);
        model.addAttribute("end", end);

        return "/board/second-hand/list";
    }

    @GetMapping(path = "{cnum}")
    public String secondHand(@PathVariable String cnum,
                             Model model) {

        SecondHandBoardVO secondHandBoardVO = secondHandBoardService.selectByCnum(Long.parseLong(cnum));
        model.addAttribute("item", secondHandBoardVO);

        return "/board/second-hand/detail";
    }

    @GetMapping(path = "write")
    public String writeView() {
        return "/board/second-hand/write";
    }

    @PostMapping(path = "write")
    public String postSecondHand(SecondHandBoardVO secondHandBoardVO,
                                 HttpServletRequest req,
                                 @RequestParam("file") MultipartFile file) {

        String upDir = "/Users/PC/Documents/work/DogWalk/src/main/webapp/static/image";
        System.out.println("upDIR : " + upDir);
        File dir = new File(upDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        if (!file.isEmpty()) {
            String originFname = file.getOriginalFilename();
            long fsize = file.getSize();

            UUID uuid = UUID.randomUUID();
            String filename = uuid.toString() + "_" + originFname;//물리적파일명=>실제 업로드시킬 파일명

            //3_2) 업로드 처리
            try {
                file.transferTo(new File(upDir, filename));
            } catch (Exception e) {
            }

            //4) BoardVO객체에 filename,originFilename,filesize 셋팅
            secondHandBoardVO.setFilename(filename);
            secondHandBoardVO.setOldFilename(originFname);
            secondHandBoardVO.setFilesize(fsize);
        }
        secondHandBoardService.insert(secondHandBoardVO);
        return "redirect:/";
    }


}

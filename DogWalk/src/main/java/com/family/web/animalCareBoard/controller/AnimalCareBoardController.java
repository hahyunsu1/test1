package com.family.web.animalCareBoard.controller;

import com.family.web.animalCareBoard.model.AnimalCareBoardVO;
import com.family.web.animalCareBoard.service.AnimalCareBoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping(path = "animal-care")
@Log4j
@RequiredArgsConstructor
public class AnimalCareBoardController {
    private final AnimalCareBoardService animalCareBoardService;

    @GetMapping
    public String animalCare(Model model,
                             @RequestParam(value = "tag", required = false) String tag,
                             @RequestParam(value = "kinds", required = false) String kinds,
                             @RequestParam(value = "page", required = false) Integer page) {
        List<AnimalCareBoardVO> animalCareBoardVOList = animalCareBoardService.selectAll(tag, kinds, page);
        model.addAttribute("list", animalCareBoardVOList);

        int count = animalCareBoardService.count();
        int end = count % 6 == 0 ? (count / 6) : (count / 6) + 1;
        model.addAttribute("end", end);
        if (kinds != null) {
            model.addAttribute("kinds", kinds);
        }
        return "/board/animal-care/list";
    }

    @GetMapping(path = "write")
    public String writeView() {
        return "/board/animal-care/write";
    }

    @PostMapping(path = "write")
    public String postAnimalCare(AnimalCareBoardVO animalCareBoardVO,
                                 HttpServletRequest req,
                                 @RequestParam("file") MultipartFile file) {

        String upDir = "/Users/PC/Documents/work/DogWalk/src/main/webapp/static/image";
        System.out.println("upDIR : " +upDir);
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
                log.info("upDir===" + upDir);
            } catch (Exception e) {
                log.error("board write upload error:" + e);
            }

            //4) BoardVO객체에 filename,originFilename,filesize 셋팅
            animalCareBoardVO.setFilename(filename);
            animalCareBoardVO.setOldFilename(originFname);
            animalCareBoardVO.setFilesize(fsize);
        }
        animalCareBoardService.insert(animalCareBoardVO);
        return "redirect:/";
    }

}

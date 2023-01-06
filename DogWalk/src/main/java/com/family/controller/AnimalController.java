package com.family.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import com.common.CommonUtil;
import com.family.model.AnimalBoardVO;
import com.family.model.PagingVO;
import com.family.service.AnimalBoardService;

import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/comanimal")
@Log4j
public class AnimalController {
	
	@Resource(name="animalBoardServiceImpl")
	private AnimalBoardService animalBoardService;
	
	@Inject
	private CommonUtil util;
	
	@GetMapping("/comanimalwrite")
	public String animalForm() {
		
		return "comanimal/comanimalwrite";
	}
	@PostMapping("/comanimalwrite")
	public String animalInsert(Model m,@RequestParam("mfilename") MultipartFile mfilename,
			@ModelAttribute AnimalBoardVO amb,HttpServletRequest req) {
		
		ServletContext app=req.getServletContext();
		String upImg=app.getRealPath("/resources/animal_board_images");
		
		File img=new File(upImg);
		if(!img.exists()) { 
			img.mkdirs();
		}
		if(!mfilename.isEmpty()) {
			String originFname=mfilename.getOriginalFilename();
			long fsize=mfilename.getSize();
		
		
			UUID uuid=UUID.randomUUID();
			String filename=uuid.toString()+"_"+originFname;
			
			if(amb.getMode().equals("edit")&& amb.getOld_filename()!=null) {
				File delImg=new File(upImg,amb.getOld_filename());
				if(delImg.exists()) {
					boolean b=delImg.delete();
				}//if
			}//if
			try {
				mfilename.transferTo(new File(upImg,filename));
				log.info("upImg=====>"+upImg);
			}catch(Exception e) {
				log.error("글쓰기 error"+e);
			}
			amb.setFilename(filename);
			amb.setOriginFilename(originFname);
			amb.setFilesize(fsize);
		
		}//if
		if(amb.getNick_fk()==null||amb.getTitle()==null||amb.getCpass()==null||amb.getPet()==null||
				amb.getNick_fk().trim().isEmpty()||amb.getTitle().trim().isEmpty()||
				amb.getCpass().trim().isEmpty()||amb.getPet().trim().isEmpty()) {
			return "redirect:write";
			
		}
		int n=0;
		String str="",loc="";
		if("write".equals(amb.getMode())) {
			n=this.animalBoardService.insertBoard(amb);
			str="글쓰기 ";
		}
		
		if("edit".equals(amb.getMode())) {
			n=this.animalBoardService.updateBoard(amb);
			str="글수정 ";
		}
		str+=(n>0)?"성공":"실패";
		loc=(n>0)?"animal_boardlist":"javascript:history.back()";
		log.info(m+"/"+str+"/"+loc);
		return util.addMsgLoc(m, str, loc);
	}
	/*@GetMapping("/animal_boardlist")
	public String animalBoardListPaging(Model m,@ModelAttribute("page") PagingVO page,
			HttpServletRequest req,@RequestHeader("user-Agent") String userAgent) {
		String myctx=req.getContextPath();
		HttpSession ses=req.getSession();
		
		int totalCount
	}*/
	 @GetMapping("/animal_boardlist")
	 public String animalBoardList(Model m,@RequestParam(defaultValue = "1")int cpage) {
		 if(cpage<=0) {
			 cpage=1;
		 }
		 
		 int totalCount=this.animalBoardService.getTotalCount(null);
		 
		 int pageSize=5;
		 int pageCount=(totalCount-1)/pageSize+1;
		 
		 if(cpage>pageCount) {
			 cpage=pageCount;
		 }
		 int start=(cpage-1)*pageSize;
		 int end=start+(pageSize+1);
		 
		 Map<String,Integer> map=new HashMap<>();
		 map.put("start", Integer.valueOf(start));
		 map.put("end", Integer.valueOf(end));
		 
		 List<AnimalBoardVO> ambArr=this.animalBoardService.selectBoardAll(map);
		
		 m.addAttribute("ambArr",ambArr); 
		 m.addAttribute("totalCount",totalCount);
		 m.addAttribute("pageCount",pageCount);
		 m.addAttribute("cpage",cpage);
		 log.info(ambArr);
		 log.info("/"+m);
		 return "comanimal/animal_boardlist";
	 }
	 @GetMapping("/view/{cnum}")
	 public String animalBoardView(Model m,@PathVariable("cnum") int cnum) {
		 int n=this.animalBoardService.updateCnt(cnum);
		 AnimalBoardVO amb=this.animalBoardService.selectBoardByIdx(cnum);
		 m.addAttribute("amb",amb);
		 return "comanimal/animal_board_view";
	 }
	 @PostMapping("/delete")
	 public String boardDelete(Model m,
				HttpServletRequest req,
				@RequestParam(defaultValue = "0") int cnum,
				@RequestParam(defaultValue = "") String cpass) {
			//log.info("num==="+num+"/ passwd==="+passwd);
			if(cnum==0||cpass.isEmpty()) {
				return "redirect:animal_boardlist";
			}
			//해당 글을 db에서 가져오기
			AnimalBoardVO vo=this.animalBoardService.selectBoardByIdx(cnum);
			if(vo==null) {
				return util.addMsgBack(m, "해당 글은 존재하지 않아요");
			}
			//비밀번호 일치여부 체크해서 일치하면 삭제처리
			String dbPwd=vo.getCpass();
			if(!dbPwd.equals(cpass)) {
				return util.addMsgBack(m, "비밀번호가 일치하지 않아요");
			}
			//db에서 글 삭제처리
			int n=this.animalBoardService.deleteBoard(cnum);
			
			ServletContext app=req.getServletContext();
			String upDir=app.getRealPath("/resources/spring_board_images");
			//log.info("updir===>"+upDir);
			//서버에 업로드한 첨부파일이 있다면 서버에서 삭제 처리
			if(n>0 && vo.getFilename()!=null) {
				File f=new File(upDir,vo.getFilename());
				if(f.exists()) {
					boolean b=f.delete();
					//log.info("파일삭제 여부: "+b);
				}
			}
			String str=(n>0)?"글 삭제 성공":"삭제 실패";
			String loc=(n>0)?"animal_boardlist":"javascript:history.back()";
			
			return util.addMsgLoc(m, str, loc);
		}
		@PostMapping("/edit")
		public String boardEditform(Model m,
				@RequestParam(defaultValue = "0") int cnum,
				@RequestParam(defaultValue = "") String cpass) {
			AnimalBoardVO vo=this.animalBoardService.selectBoardByIdx(cnum);
			//1.글번호,비번 유효성 체크==> list redirect이동
			if(cnum==0||cpass.isEmpty()) {
				return "redirect:animal_boardlist";
			}
			
			//2. 글번호로 해당 글 내용가져오기 없으면 "없는 글입니다"
			if(vo==null) {
				return util.addMsgBack(m, "없는 글입니다");
			}
			//3.비번 체크->일치 하지 않으면 "불일치"back이동
			String dbPwd=vo.getCpass();
			if(!dbPwd.equals(cpass)) {
				return util.addMsgBack(m, "비밀번호가 일치하지 않아요");
			}
			//4.Model에 해당 글 저장"board"
			m.addAttribute("amb",vo);
			return "comanimal/animal_board_Edit";
		}
}

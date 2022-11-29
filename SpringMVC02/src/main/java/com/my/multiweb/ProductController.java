package com.my.multiweb;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.model.ProductVO;
import com.shop.service.ShopService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ProductController {
	
	@Inject
	private ShopService shopService;
	
	//pspec(HIT,NEW,BEST) 별로 상품목록 가져오기
	@GetMapping("/prodPspec")
	public String productByPspec(Model m,@RequestParam(name="pspec",defaultValue = "HIT")String pspec) {
		log.info("pspec====>"+pspec);
		List<ProductVO> pList=shopService.selectByPspec(pspec);
		
		m.addAttribute("pList",pList);
		
		return "shop/mallHit";
	}
	/*
	 * /prodDetai?pnum=1
	 * 
	 * ==>ProductController에서 매핑하기
	 * 
	 * ShopService의 selectByPnum(pnum) 호출
	 * 
	 * 모델에 저장 "prod", ProductVO 저장
	 * 
	 * "shop/prodDetail" --------------------------------------------- 상품번호로 상품정보
	 * 가져오기
	 */
	@GetMapping("/prodDetail")
	public String productDetail(Model m,@RequestParam(defaultValue = "0")int pnum) {
		log.info(pnum);
		if(pnum==0) {
			return "redirect:index";//redirect방식으로 이동
		}
		ProductVO vo=shopService.selectByPnum(pnum);
		m.addAttribute("prod",vo);
		return "shop/prodDetail";
	}

}

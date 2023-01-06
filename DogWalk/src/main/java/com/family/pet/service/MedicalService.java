package com.family.pet.service;

import java.util.HashMap;
import java.util.List;

import com.family.pet.model.Mrecord;
import com.family.pet.model.PetVO;

public interface MedicalService {
	
		//병원이용 기록 등록하기
		public int medicalRegister(Mrecord mrecord);
		
		//병원이용기록 리스트 가져오기
		public HashMap<String, Object> getMrecordList(String cp, String ps, String userid);
		//PETNAME가져오기
		public HashMap<String, Object> getPetname(String userid);
		//병원 이용기록 상세보기 
		public Mrecord getMrecordDetail(String mindex);
		//병원 이용기록 글 수정
		public int editMrecord(Mrecord mrecord);
			
		//병원 이용기록 글 삭제
		public int deleteMrecord(Mrecord mrecord);
		//반려동물 petname 가져오기
		public List<PetVO> getPetInfo(String userid);

}

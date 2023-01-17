package com.family.pet.service;

import java.util.List;

import com.family.pet.model.PetLikeVO;
import com.family.pet.model.PetVO;
import com.family.pet.model.ScheduleVO;
import com.member.model.MemberVO;

public interface PetService {
	
	public MemberVO normalLogin(MemberVO userid);
	//반려동물 등록하기
	public int newPet(PetVO pet);
	
	//반려동물 정보 가져오기
	public List<PetVO> getPetInfo(String userid);
		
	
	//반려동물 수정할 정보 가져오기
	public PetVO editPetInfo(int petindex);
	
	
	
	//반려동물 정보 수정
	public int updatePetInfo(PetVO pet);
	//반려동물 정보 삭제
	public int deletePet(int petindex);
	
	// 일정 모두 불러오기
	public List<ScheduleVO> getSchedule(String userid);
	public List<PetVO> getRecommendPetList(List<PetVO> petList, MemberVO user);
	public List<PetVO> getPetPicture(String userid);
	public PetVO getPet(int petindex);
	public PetLikeVO isFollowPet(String petindex, String userid);
	public int followPet(PetLikeVO petLike);
	public int unFollowPet(PetLikeVO petLike);
	public List<PetLikeVO> getPetLike(String userid);
}

package com.family.pet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.family.pet.model.PetLikeVO;

public interface PetLikeMapper {
	
	
	
	// 반려동물 좋아요(팔로우) 등록	
	public int followPet(PetLikeVO petlike);
	
	// 반려동물 좋아요(언팔로우) 취소
	
	public int unFollowPet(PetLikeVO petlike);
	
	// 반려동물 좋아요(팔로우) 여부
	
	public PetLikeVO isFollowPet( @Param("petindex") int petindex, @Param("userid") String userid);

	public List<PetLikeVO> getPetLike(@Param("userid") String userid);

}

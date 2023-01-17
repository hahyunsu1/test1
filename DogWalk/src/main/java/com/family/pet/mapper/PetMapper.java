package com.family.pet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.family.pet.model.PetVO;

public interface PetMapper {
	
	// 반려동물 등록
			
			public int newPet(PetVO pet);

			// 반려동물 정보 가져오기
			//@Select("select * from pet where userid = #{userid}")
			@Select("select p.*, s.SCANAME as scaname, m.MCANAME as mcaname " 
					+ "from PET p "
					+ "left outer join SUBCATEGORY s on p.SCATEGORY = s.SCATEGORY "
				    + "left outer join MAINCATEGORY m on p.MCATEGORY = m.MCATEGORY "
				    + "where userid = #{userid}")
			public List<PetVO> getPetInfo(@Param("userid") String userid);
			
			// 반려동물 수정할 정보 가져오기
			@Select("select p.*, s.SCANAME as scaname, m.MCANAME as mcaname " 
					+ "from PET p "
					+ "left outer join SUBCATEGORY s on p.SCATEGORY = s.SCATEGORY "
				    + "left outer join MAINCATEGORY m on p.MCATEGORY = m.MCATEGORY "
				    + "where petindex = #{petindex}")
			public PetVO editPetInfo(@Param("petindex") int petindex);
			
			// 반려동물 정보 수정
			@Update("update PET set petname=#{petname}, mcategory=#{mcategory}, scategory=#{scategory}, sex=#{sex}, age=#{age}, "
					+ "petsize=#{petsize}, weight=#{weight}, hlength=#{hlength}, nstate=#{nstate}, petimg=#{petimg}, memo=#{memo} "
					+ "where petindex=#{petindex}")
			public int updatePetInfo(PetVO pet);
			
			// 반려동물 삭제
			@Delete("delete from PET where petindex = #{petindex}")
			public int deletePet(@Param("petindex") int petindex);

			// 메인에 뿌릴 이름 정보만 가져오기
			@Select("select petname from PET where userid = #{userid}")
			public List<String> getSimplePetInfo(@Param("userid") String userid);
			
			// 반려동물 사진만 가져오기 >> 추천 동물 로직에도 사용하기 위해 전체 정보 가져오는 것으로 임시 변경
			@Select("select * from PET where userid = #{userid}")
			public List<PetVO> getPetPicture(@Param("userid") String userid);


			// 어드민 > 동물 리스트 조회  ajax
			@Select("select * from PET")
			public List<PetVO> getPetList(@Param("userid") String userid); 

			// 반려동물 한 마리 정보 가져오기			
			public PetVO getPet(int petindex);
			// 메인> 추천 반려동물 (품종) 3마리 추천
			
			public List<PetVO> getSameCategoryPet(String userid, String scategory);
			// 메인> 추천 반려동물 (비슷한 나이(개월)) 3마리 추천
			public List<PetVO> getSimilarAgePet(String userid, int age);
			// 메인> 추천 반려동물 (가까운 거리) 3마리 추천
			public List<PetVO> getNearPet(String userid);
}

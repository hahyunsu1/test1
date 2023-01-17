package com.family.pet.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.family.pet.mapper.PetLikeMapper;
import com.family.pet.mapper.PetMapper;
import com.family.pet.mapper.ScheduleMapper;
import com.family.pet.model.PetLikeVO;
import com.family.pet.model.PetVO;
import com.family.pet.model.ScheduleVO;
import com.member.mapper.MemberMapper;
import com.member.model.MemberVO;

@Service("petServiceImpl")
public class PetServiceImpl implements PetService {
	
	private SqlSession sqlsession;
	
	@Autowired
	MemberMapper MemberMapper;

	@Autowired
	PetMapper PetMapper;
	
	@Autowired
	ScheduleMapper ScheduleMapper;
	
	@Autowired
	PetLikeMapper petLikeMapper;
	
	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Override
	public MemberVO normalLogin(MemberVO userid) {
		MemberMapper = sqlsession.getMapper(MemberMapper.class);
		return MemberMapper.memberLogin(userid);
	}

	@Override
	public int newPet(PetVO pet) {
		int result = 0;
		
		try {
			PetMapper = sqlsession.getMapper(PetMapper.class);
			result = PetMapper.newPet(pet);
		} catch (Exception e) {
			System.out.println("managementService newPet() 문제 발생" + e.getMessage());
		}
		return result;
	}

	@Override
	public List<PetVO> getPetInfo(String userid) {
		PetMapper = sqlsession.getMapper(PetMapper.class);
		return PetMapper.getPetInfo(userid);
	}

	@Override
	public PetVO editPetInfo(int petindex) {
		PetVO pet = null;
				
				try {
					
					PetMapper = sqlsession.getMapper(PetMapper.class);
					pet = PetMapper.editPetInfo(petindex);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
		return pet;
	}

	@Override
	public int updatePetInfo(PetVO pet) {

		int result = 0;
		
		try {
			PetMapper = sqlsession.getMapper(PetMapper.class);
			result = PetMapper.updatePetInfo(pet);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deletePet(int petindex) {
		int result = 0;
		
		try {
			PetMapper = sqlsession.getMapper(PetMapper.class);
			result = PetMapper.deletePet(petindex);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<ScheduleVO> getSchedule(String userid) {
		List<ScheduleVO> list = null;
		
		try {
			ScheduleMapper = sqlsession.getMapper(ScheduleMapper.class);
			list = ScheduleMapper.getSchedule(userid);
			System.out.println("list**3**3*"+list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	public List<PetVO> getPetPicture(String userid) {
		List<PetVO> list = null;
		list = PetMapper.getPetPicture(userid);
		return list;
	}
	
	//동물 친구 추천 리스트 조회
		public List<PetVO>getRecommendPetList(List<PetVO> petList, MemberVO user){
			List<PetVO> list = new ArrayList<PetVO>();
			Map<Integer,PetVO> map = new HashMap<>();
			
			for(PetVO pet: petList) {
				// 같은 품종의 동물 친구			
				List<PetVO> tmpList1 = PetMapper.getSameCategoryPet(pet.getUserid(), pet.getScategory());
				for(PetVO recomPet: tmpList1) {
					recomPet.setRelatedPet(pet.getPetindex()); //어떤 반려동물과 관련되어 있는지 추가
					recomPet.setRecomType("kind");
					System.out.println("추천 동물 친구: "+ recomPet);
					//list.add(recomPet);
					map.put(recomPet.getPetindex(), recomPet);
					System.out.println("추천 리스트" + map);
				}
		
				// 비슷한 나이대의 동물 친구
				List<PetVO> tmpList2 = PetMapper.getSimilarAgePet(pet.getUserid(), pet.getAge());
				for(PetVO recomPet: tmpList2) {
					recomPet.setRelatedPet(pet.getPetindex()); //어떤 반려동물과 관련되어 있는지 추가
					recomPet.setRecomType("age");
					System.out.println("추천 동물 친구: "+ recomPet);
					//list.add(recomPet);
					map.put(recomPet.getPetindex(), recomPet);
					System.out.println("추천 리스트" + map);
				}
				// 가까운 거리에 사는 동물 친구
				// 유저의 위치 정보
				List<PetVO> tmpList3 = PetMapper.getNearPet(pet.getUserid());
				for(PetVO recomPet: tmpList3) {
					recomPet.setRelatedPet(pet.getPetindex()); //어떤 반려동물과 관련되어 있는지 추가
					recomPet.setRecomType("dist");
					System.out.println("추천 동물 친구: "+ recomPet);
					//list.add(recomPet);
					map.put(recomPet.getPetindex(), recomPet);
					System.out.println("추천 리스트" + map);
				}
			}
			
			System.out.println("섞기 전: "+ map);
			// 배열을 랜덤하게 섞어주는 작업
			for (PetVO petVO : map.values()) {
				System.out.println("$$$$$$$$$$$$$"+petVO);
				list.add(petVO);
			}
			Collections.shuffle(list);
			System.out.println("섞은 후: "+ list);
			
			
			// 배열 중 6개만 뽑기  //6개가 안되면 에러 발생 >> 리스트가  null이면 패스			
			if(list.size()>6) {
				list = list.subList(0, 6);
			}
			System.out.println("추천리스트 최종: "+ list);
			
			
			return list;
		}

		@Override
		public PetVO getPet(int petindex) {
			PetMapper = sqlsession.getMapper(PetMapper.class);
			return PetMapper.getPet(petindex);
		}

		

		@Override
		public int followPet(PetLikeVO petLike) {
			int result = 0;

			try {

				petLikeMapper = sqlsession.getMapper(PetLikeMapper.class);
				result = petLikeMapper.followPet(petLike);

			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			System.out.println("result2==="+result);
			return result;
		}

		@Override
		public int unFollowPet(PetLikeVO petLike) {
			int result = 0;

			try {

				petLikeMapper = sqlsession.getMapper(PetLikeMapper.class);
				result = petLikeMapper.unFollowPet(petLike);
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			System.out.println("result3==="+result);
			return result;
		}
		
		@Override
		public PetLikeVO isFollowPet(String petindex, String userid) {
			PetLikeVO petLike = null;

			try {

				petLikeMapper = sqlsession.getMapper(PetLikeMapper.class);
				petLike = petLikeMapper.isFollowPet(Integer.parseInt(petindex), userid);

			} catch (Exception e) {
				System.out.println(e.getMessage());
			}

			return petLike;
		}

		@Override
		public List<PetLikeVO> getPetLike(String userid) {
			
			List<PetLikeVO> list = null;
			list = petLikeMapper.getPetLike(userid);
			return list;
		}
		

}

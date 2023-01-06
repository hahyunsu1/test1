package com.family.pet.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.family.pet.mapper.PetMapper;
import com.family.pet.mapper.ScheduleMapper;
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
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}

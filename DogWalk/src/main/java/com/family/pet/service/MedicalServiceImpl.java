package com.family.pet.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.family.pet.mapper.MrecordDao;
import com.family.pet.mapper.PetMapper;
import com.family.pet.model.Mrecord;
import com.family.pet.model.PetVO;
import com.member.mapper.MemberMapper;



@Service("medicalServiceImpl")
public class MedicalServiceImpl implements MedicalService {

	private static final Logger logger = LoggerFactory.getLogger(MedicalService.class);
	
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Autowired
	MemberMapper MemberMapper;
	
	@Autowired
	PetMapper PetMapper;
	
	@Autowired
	MrecordDao mrecordDao;
	
	
	//병원이용 기록 등록하기
	public int medicalRegister(Mrecord mrecord) {
		
		int result = 0;
		
		try {
			mrecordDao = sqlsession.getMapper(MrecordDao.class);
			result = mrecordDao.medicalRegister(mrecord);
		} catch (Exception e) {
			System.out.println("MedicalService write() 문제 발생" + e.getMessage());
		}
		
		return result;
	}
	
	//병원이용기록 리스트 가져오기
	public HashMap<String, Object> getMrecordList(String cp, String ps, String userid) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// List 페이지 처음 호출
		if (ps == null || ps.trim().equals("")) {
			// default 값 설정
			ps = "5"; // 5개씩
		}

		if (cp == null || cp.trim().equals("")) {
			// default 값 설정
			cp = "1"; // 1번째 페이지 보겠다
		}
		
		int pageSize = Integer.parseInt(ps);
		int cpage = Integer.parseInt(cp);
		int pageCount = 0;

		logger.info("pageSize :" + pageSize);
		logger.info("cpage :" + cpage);
		
		// DAO 데이터 받아오기
		List<Mrecord> mrecordList = null;

		// mapper 를 통한 인터페이스 연결
		MrecordDao mrecordDao = sqlsession.getMapper(MrecordDao.class);

		int totalMrecordCount = mrecordDao.getMrecordCount(userid);
		//
		mrecordList = mrecordDao.getMrecordList(cpage, pageSize, userid);

		// 페이지 크기에 맞춰 페이지 수 구하기
		if (totalMrecordCount % pageSize == 0) {
			pageCount = totalMrecordCount / pageSize;
		} else {
			pageCount = (totalMrecordCount / pageSize) + 1;
		}
		
		map.put("mrecordList", mrecordList);
		map.put("cpage", cpage);
		map.put("pageSize", pageSize);
		map.put("pageCount", pageCount);
		map.put("totalMrecordCount", totalMrecordCount);
		
		return map;
		
	}
	//PETNAME가져오기
	public HashMap<String, Object> getPetname(String userid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		List<Mrecord> petNameList = null;
		
		int totalMrecordCount = mrecordDao.getMrecordCount(userid);
		petNameList = mrecordDao.getPetname(userid);
		
		System.out.println("totalMrecordCount:" + totalMrecordCount );
		System.out.println("petNameList:" + petNameList);
		map.put("petNameList", petNameList);
		map.put("totalMrecordCount", totalMrecordCount);
		
		return map;
		
	}
	//병원 이용기록 상세보기 
		public Mrecord getMrecordDetail(String mindex) {
					
			Mrecord mrecord = null;

			mrecordDao = sqlsession.getMapper(MrecordDao.class);
			mrecord = mrecordDao.getMrecordDetail(mindex);
								
			return mrecord;
		}
		//병원 이용기록 글 수정
		public int editMrecord(Mrecord mrecord) {

			mrecordDao = sqlsession.getMapper(MrecordDao.class);
										
			return mrecordDao.editMrecord(mrecord);
		}
		
		//병원 이용기록 글 삭제
		public int deleteMrecord(Mrecord mrecord) {

			mrecordDao = sqlsession.getMapper(MrecordDao.class);
			
			return mrecordDao.deleteMrecord(mrecord);
		}
		
		//반려동물 petname 가져오기
		public List<PetVO> getPetInfo(String userid) {

			PetMapper = sqlsession.getMapper(PetMapper.class);
			return PetMapper.getPetInfo(userid);
			
		}

}

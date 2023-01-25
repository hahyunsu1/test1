package com.member.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.family.pet.mapper.PetMapper;
import com.family.pet.model.PetVO;
import com.member.mapper.MemberMapper;
import com.member.model.MemberVO;

@Service("MemberServiceImpl")
public class MemberServiceImpl implements MemberService {
	//하현수 추가-----
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	@Autowired
	PetMapper petMapper;
	/////추가
	@Autowired
	private MemberMapper membermapper;
	//회원가입
	@Override
	public int MemberJoin(MemberVO member){
		return this.membermapper.MemberJoin(member);
	}
	
	@Override
	public int idCheck(String userid) {
		return this.membermapper.idCheck(userid);
	}

	@Override
	public int nickCheck(String nick) {
		return this.membermapper.nickCheck(nick);
	}
	
	/* 로그인 */
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        return this.membermapper.memberLogin(member);
    }
    
    @Override
    public int updateMember(MemberVO member) throws Exception{
    	return this.membermapper.updateMember(member);
    }
 
    @Override
	public int removeMember(String userid) {
		int result = membermapper.removeMember(userid);
		return result;
	}
    
    
    @Override
	public MemberVO selectById(String userid) {
		
		return this.membermapper.selectById(userid);
	}
    
    //하현수 추가
    @Override
    public List<PetVO> getPetInfo(String userid) {
		petMapper = sqlsession.getMapper(PetMapper.class);
		return petMapper.getPetInfo(userid);
	}
	
	
    @Override
	public MemberVO normalLogin(String userid) {
		
		membermapper = sqlsession.getMapper(MemberMapper.class);

		return membermapper.getUser(userid);
	}

    @Override
	public List<MemberVO> adminUserList() {
		return membermapper.adminUserList();
}
	@Override
	public List<MemberVO> adminUserList2() {
		return membermapper.adminUserList2();
	}
	
	@Override
	public void successId(String id) {
		membermapper.successId(id);
	}

	@Override
	public void failed(String id) {
		membermapper.failed(id);
	}
	@Override
	public void dropUser(String id) {
		membermapper.dropUser(id);
		
	}

	



}

package com.family.pet.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.family.pet.model.Mrecord;




public interface MrecordDao {
			// 병원이용기록 등록
			@Insert("insert into MRECORD(mindex,userid, petindex, hname, vdate, vreason)"
					+ "values (MRECORD_seq.nextval,#{userid}, #{petindex}, #{hname}, #{vdate}, #{vreason})")
			public int medicalRegister(Mrecord mrecord);

			
			
			//전체 병원기록 리스트 가져오기
			public List<Mrecord> getMrecordList(int cpage, int pageSize, String userid);
			
			
			public List<Mrecord> getPetname(@Param("userid") String userid);
			
			//병원기록 수			
			public int getMrecordCount(@Param("userid") String userid);//
			
			// 병원진료  상세 조회
			@Select("select m.*, p.petname from MRECORD m join PET p on m.petindex=p.petindex where mindex = #{mindex}")
			public Mrecord getMrecordDetail(@Param("mindex") String mindex);
			
			// 병원진료  수정 
			@Update("update MRECORD set petindex=#{petindex}, hname=#{hname}, vdate=#{vdate}, vreason=#{vreason} where mindex=#{mindex}")
			public int editMrecord(Mrecord mrecord);
			
			// 병원진료 글 삭제
			@Delete("delete from MRECORD where mindex=#{mindex}")
			public int deleteMrecord(Mrecord mrecord);
			
	
}

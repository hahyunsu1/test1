package com.family.pet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.family.pet.model.ScheduleVO;

public interface ScheduleMapper {
	//일정 등록
		public int newSchedule(ScheduleVO schedule);
		
		
		@SelectKey(before = true, keyProperty = "sindex", resultType = int.class, statement =  "select com_ani_board_seq.nextval from dual" )
		public int getLastSindex();
		//일정 불러오기
		@Select("select sindex, petindex, userid, title, content, is_complete, start_date, end_date, allDay, daysofweek, groupId, adncdnoti, color "
				+ "from SCHEDULE where userid = #{userid}")
		public List<ScheduleVO> getSchedule(@Param("userid") String userid);
		
		//일정 업데이트
		@Update("update SCHEDULE set petindex=#{petindex},title=#{title}, content=#{content}, is_complete=#{is_complete}, "
				+ "start_date=#{start_date}, end_date=#{end_date}, allDay=#{allDay}, daysofweek=#{daysofweek}, groupId=#{groupId}, adncdnoti=#{adncdnoti}, color=#{color} "
				+ "where sindex=#{sindex}")
		public int updateSchedule(ScheduleVO schedule);
		
		//일정 업데이트
		@Update("update SCHEDULE set start_date=#{start_date}, end_date=#{end_date} where sindex=#{sindex}")
		public int dndUpdateSchedule(ScheduleVO schedule);
		
		//일정 삭제
		@Delete("delete from SCHEDULE where sindex=#{sindex}")
		public int deleteSchedule(@Param("sindex") String sindex);
		
		//특정 유저의 특정 동물 스케쥴 가져오기
		@Select("select p.petindex, p.userid, p.petname, p.petimg, s.sindex, s.title, s.start " + 
				"from PET p join SCHEDULE s " + 
				"on p.USERID = s.USERID and p.PETINDEX = s.PETINDEX " + 
				"where p.userid = #{userid} and p.petname = #{petname} " +
			    "and start>= SUBTIME( NOW(), TIMEDIFF( NOW(), CAST(DATE(NOW()) AS DATETIME))) " + 
				"order by start desc limit 3")
		public List<ScheduleVO> getMyPetSchedule(@Param("userid") String userid, @Param("petname") String petname);
}

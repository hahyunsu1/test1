package com.family.pet.model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ScheduleVO {
	
	private int sindex;
	private int petindex;
	private String userid;
	private String title;
	private String content;
	private String is_complete;
	private String start_date;
	private String end_date;
	private String allDay;
	private String daysofweek;
	private String adncdnoti;
	private String color;
	private String groupId;
	
	//임시
	private String petname;
	private String petimg;
}

package com.family.pet.model;


import lombok.Data;

import lombok.ToString;

@Data
@ToString
public class Mrecord {
	
	private int mindex;
	private int petindex;
	private String userid;
	private String vdate;
	private String vreason;
	private String hname;
	
	//반려동물 이름 받아오는 용도
	private String petname;

}

package com.family.pet.model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PetLikeVO {
	
	private int lindex;
	private String userid;
	private int petindex;
	
	//임시
	private String myid;
	private String whosepet;
	private String petname;
	private String petimg;
}


package com.member.model;

import lombok.Data;

@Data
public class FacebookInfo {
	
	private String id;
    private String email;
    private String name;
    
    
    public FacebookInfo() {

    }
    
    public FacebookInfo(String id, String email, String name) {
        this.id = id;
        this.email = email;
        this.name = name;
    }
}

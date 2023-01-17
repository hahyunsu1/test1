package com.member.model;

import lombok.Data;

@Data
public class AuthInfo {
	
	private String clientId;
    private String clientSecret;
    
    
    public AuthInfo(String clientId, String clientSecret) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
    }
}

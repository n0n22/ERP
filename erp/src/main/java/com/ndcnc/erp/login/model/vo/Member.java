package com.ndcnc.erp.login.model.vo;

import lombok.Data;

@Data
public class Member {

	private int memNo; // MEM_NO NUMBER PRIMARY KEY,
	private String memEmail; // MEM_EMAIL VARCHAR2(30),
	private String memPw; // MEM_PW VARCHAR2(15),
	private String memName; // MEM_NAME VARCHAR2(20),
	private String memMobile; // MEM_MOBILE CHAR(13)
	
	
	
}

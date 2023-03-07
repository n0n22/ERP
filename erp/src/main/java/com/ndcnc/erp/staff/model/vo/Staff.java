package com.ndcnc.erp.staff.model.vo;

import java.util.List;

import lombok.Data;

@Data
public class Staff {

	private int staff_no;
	private String staff_name;
	private String jumin_no;
	private String school_code;
	private String department_code;
	private List<String> skill_code;
	private String graduate_day;
	
	
}

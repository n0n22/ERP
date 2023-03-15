package com.ndcnc.erp.staff.model.vo;

import java.util.List;

import lombok.Data;

@Data
public class SearchCondition {

	private String staff_name;			// 이름
	private String jumin_no;			// 성별
	private String department_name;		// 부서
	private List<String> school_name;	// 학력
	private List<String> skill_name;	// 기술
	private String graduate_day1;		// 졸업년도 1
	private String graduate_day2;		// 졸업년도 2
	
	private int cpage; // 현재페이지
	
	private List<String> skill_name2;	// 추가기술
	private String skillCondition;		// 필수 여부
	
	private String orderCondition;		// 정렬 조건
	private String desc;				// 오름,내림차순
	
}





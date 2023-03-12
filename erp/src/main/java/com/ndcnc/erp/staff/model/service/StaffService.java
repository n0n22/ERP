package com.ndcnc.erp.staff.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ndcnc.erp.staff.model.dao.StaffDao;
import com.ndcnc.erp.staff.model.vo.PageInfo;
import com.ndcnc.erp.staff.model.vo.SearchCondition;
import com.ndcnc.erp.staff.model.vo.Staff;

@Service
public class StaffService {

	@Autowired
	private StaffDao staffDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 사원 등록 
	public int inputStaff(Staff newStaff) {
		return staffDao.inputStaff(newStaff, sqlSession);
	}
	
	// 사원 전체 목록 개수
	public int selectAllListCount() {
		return staffDao.selectAllListCount(sqlSession);
	}
	
	// 사원 전체 목록
	public ArrayList<Staff> selectAllList(PageInfo pi) {
		return staffDao.selectAllList(pi, sqlSession);
	}
	
	// 사원 검색 목록 개수
	public int selectStaffCount(SearchCondition sc) {
		return staffDao.selectStaffCount(sc, sqlSession);
	}
	
	// 사원 검색 목록
	public ArrayList<Staff> selectStaff(SearchCondition sc, PageInfo pi) {
		return staffDao.selectStaff(sc, pi, sqlSession);
	}
	
	// 사원 상세 정보 조회
	public Staff selectStaffInfo(int staff_no) {
		return staffDao.selectStaffInfo(staff_no, sqlSession);
	}
	
	// 사원 정보 수정
	public int updateStaff(Staff staff) {
		return staffDao.updateStaff(staff, sqlSession);
	}
	
	public int deleteStaff(int staff_no) {
		return staffDao.deleteStaff(staff_no, sqlSession);
	}
	
	// 기술 목록 조회
	public ArrayList<String> selectSkill() {
		return staffDao.selectSkill(sqlSession);
	}
	
	
	
}

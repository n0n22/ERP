package com.ndcnc.erp.staff.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	// 사원 등록 - 기술 있을때
	@Transactional
	public int inputStaff(Staff newStaff) {
		return staffDao.insertStaff(newStaff, sqlSession)
				+ staffDao.updateSkill(newStaff.getSkill_name(), sqlSession)
				+ staffDao.insertStaffSkill(newStaff, sqlSession);
	}
	
	// 사원 등록 - 기술 없을 때
	public int inputStaffOnly(Staff newStaff) {
		return staffDao.insertStaff(newStaff, sqlSession);
	}
	
	// 사원 전체 목록 개수
	public int selectAllListCount() {
		return staffDao.selectAllListCount(sqlSession);
	}
	
	// 사원 전체 목록
	public ArrayList<Staff> selectAllList(HashMap<String, Object> selectMap, PageInfo pi) {
		return staffDao.selectAllList(selectMap, pi, sqlSession);
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
	
	// 사원 정보 수정 - 기술이 있을 때
	@Transactional
	public int updateStaff(Staff staff) {
		return staffDao.updateStaff(staff, sqlSession)
				+ staffDao.deleteStaffSkills(staff.getStaff_no(), sqlSession)
				+ staffDao.updateSkill(staff.getSkill_name(), sqlSession)
				+ staffDao.insertNewStaffSkill(staff, sqlSession);
	}
	
	// 사원 정보 수정 - 기술이 없을 때
	@Transactional
	public int updateStaffInfo(Staff staff) {
		return staffDao.updateStaff(staff, sqlSession)
				+ staffDao.deleteStaffSkills(staff.getStaff_no(), sqlSession);
	}
	
	// 사원 정보 삭제
	public int deleteStaff(int staff_no) {
		return staffDao.deleteStaff(staff_no, sqlSession);
	}
	
	// 기술 목록 조회
	public ArrayList<String> selectSkill() {
		return staffDao.selectSkill(sqlSession);
	}
	
	
	
}

package com.ndcnc.erp.staff.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ndcnc.erp.staff.model.vo.Staff;

@Repository
public class StaffDao {

	@Transactional
	public int inputStaff(Staff newStaff, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("staffMapper.insertStaff", newStaff) * sqlSession.update("staffMapper.insertStaffSkill", newStaff);
	}
	
	
	
}

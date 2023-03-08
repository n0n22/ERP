package com.ndcnc.erp.staff.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ndcnc.erp.staff.model.vo.PageInfo;
import com.ndcnc.erp.staff.model.vo.Staff;

@Repository
public class StaffDao {

	
	// 사원 등록
	@Transactional
	public int inputStaff(Staff newStaff, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("staffMapper.insertStaff", newStaff) * sqlSession.insert("staffMapper.insertStaffSkill", newStaff);
	}
	
	
	// 사원 전체 목록 개수
	public int selectAllListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("staffMapper.selectAllListCount");
	}
	
	// 사원 전체 목록
	public ArrayList<Staff> selectAllList(PageInfo pi, SqlSessionTemplate sqlSession) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("staffMapper.selectAllList", rowBounds);
	}
	
	
	
	
}

package com.ndcnc.erp.staff.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.ndcnc.erp.staff.model.vo.PageInfo;
import com.ndcnc.erp.staff.model.vo.SearchCondition;
import com.ndcnc.erp.staff.model.vo.Staff;

@Repository
public class StaffDao {

	
	// 사원 등록
	@Transactional
	public int inputStaff(Staff newStaff, SqlSessionTemplate sqlSession) {
		sqlSession.update("staffMapper.updateSkill", newStaff.getSkill_name());
		return sqlSession.insert("staffMapper.insertStaff", newStaff)
				* sqlSession.insert("staffMapper.insertStaffSkill", newStaff);
	}
	
	
	// 사원 전체 목록 개수
	public int selectAllListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("staffMapper.selectAllListCount");
	}
	
	// 사원 전체 목록
	public ArrayList<Staff> selectAllList(PageInfo pi, SqlSessionTemplate sqlSession) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("staffMapper.selectAllList", null, rowBounds);
	}
	
	// 사원 검색 목록 개수
	public int selectStaffCount(SearchCondition sc, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("staffMapper.selectStaffCount", sc);
	}
	
	// 사원 검색 목록
	public ArrayList<Staff> selectStaff(SearchCondition sc, PageInfo pi, SqlSessionTemplate sqlSession) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("staffMapper.selectStaff", sc, rowBounds);
	}
	
	// 사원 상세 정보 조회
	public Staff selectStaffInfo(int staff_no, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("staffMapper.staffCollectionResultSet", staff_no);
	}
	
	// 사원 정보 수정
	@Transactional
	public int updateStaff(Staff staff, SqlSessionTemplate sqlSession) {
		return sqlSession.update("staffMapper.updateStaff", staff)
			   * sqlSession.delete("staffMapper.deleteStaffSkills", staff.getStaff_no())
			   * sqlSession.insert("staffMapper.insertStaffSkill", staff);
	}
	
	// 사원 정보 삭제
	public int deleteStaff(int staff_no, SqlSessionTemplate sqlSession) {
		return sqlSession.delete("staffMapper.deleteStaff", staff_no);
	}
	
	
	
	
}

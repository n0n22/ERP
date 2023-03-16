package com.ndcnc.erp.staff.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ndcnc.erp.staff.model.vo.PageInfo;
import com.ndcnc.erp.staff.model.vo.SearchCondition;
import com.ndcnc.erp.staff.model.vo.Staff;

@Repository
public class StaffDao {

	
	// 사원 등록
	public int insertStaff(Staff newStaff, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("staffMapper.insertStaff", newStaff);
	}
	
	// 기술 등록
	public int updateSkill(List<String> staff_name, SqlSessionTemplate sqlSession) {
		return sqlSession.update("staffMapper.updateSkill", staff_name);
	}
	
	// 사원 기술 등록
	public int insertStaffSkill(Staff newStaff, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("staffMapper.insertStaffSkill", newStaff);
	}
	
	
	
	// 사원 전체 목록 개수
	public int selectAllListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("staffMapper.selectAllListCount");
	}
	
	// 사원 전체 목록
	public ArrayList<Staff> selectAllList(HashMap<String, Object> selectMap, PageInfo pi, SqlSessionTemplate sqlSession) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("staffMapper.selectAllList", selectMap, rowBounds);
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
	public int updateStaff(Staff staff, SqlSessionTemplate sqlSession) {
		return sqlSession.update("staffMapper.updateStaff", staff);
	}
	
	// 이전 기술 삭제
	public int deleteStaffSkills(int staff_no, SqlSessionTemplate sqlSession) {
		return sqlSession.delete("staffMapper.deleteStaffSkills", staff_no);
	}
	
	// 사원 새로운 기술 추가
	public int insertNewStaffSkill(Staff newStaff, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("staffMapper.insertNewStaffSkill", newStaff);
	}
	
	// 사원 정보 삭제
	public int deleteStaff(int staff_no, SqlSessionTemplate sqlSession) {
		return sqlSession.delete("staffMapper.deleteStaff", staff_no);
	}
	
	// 기술 목록 조회
	public ArrayList<String> selectSkill(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("staffMapper.selectSkill", null);
	}
	
	
	
}

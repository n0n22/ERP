<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내담 - 사원등록</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>

	.outer {
        width: 1200px;
        padding: 10px;
    }
    
	button {
		margin: 3px;
	}

	th {
		text-align: center;
	}

	.button-area {
		text-align: center;
	}


</style>



</head>
<body>
	
	

    <div class="outer">

        <div class="insert-area">
            <form method="post" action="staffInput.do" id="inputForm">

                <table id="insert-table" class="table table-bordered">
                    <thead>
                        <tr>
                            <th colspan="6" class="color"><h4>사원 정보 등록</h4></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th class="color">이름</th>
                            <td>
                                <input type="text" name="staff_name" required>
                            </td>
                            <th class="color">주민번호</th>
                            <td>
                            	<input type="hidden" name="jumin_no" id="juminNo">                            	
                                <input type="text" id="jumin_no1" required> 
                                &nbsp; - &nbsp;
                                <input type="password" id="jumin_no2" required>
                            </td>
                            <th class="color">부서</th>
                            <td>
                                <select name="department_name">
                                    <option value=""></option>
                                    <option value="ICT사업부">ICT사업부</option>
                                    <option value="디지털트윈사업부">디지털트윈사업부</option>
                                    <option value="SI사업부">SI사업부</option>
                                    <option value="반도체사업부">반도체사업부</option>
                                    <option value="기업부설연구소">기업부설연구소</option>
                                    <option value="전략기획팀">전략기획팀</option>
                                    <option value="경영지원팀">경영지원팀</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="color">학력</th>
                            <td>
                                <label><input type="radio" name="school_name" value="고졸"> 고졸</label> &nbsp;
                                <label><input type="radio" name="school_name" value="전문대졸"> 전문대졸</label> &nbsp;
                                <label><input type="radio" name="school_name" value="일반대졸"> 일반대졸</label> &nbsp;
                            </td>
                            <th class="color">기술</th>
                            <td colspan="3">
                                <label><input type="checkbox" name="skill_name" class="skillCheckbox" value="Java"> Java</label> &nbsp;
                                <label><input type="checkbox" name="skill_name" class="skillCheckbox" value="JSP"> JSP</label> &nbsp;
                                <label><input type="checkbox" name="skill_name" class="skillCheckbox" value="ASP"> ASP</label> &nbsp;
                                <label><input type="checkbox" name="skill_name" class="skillCheckbox" value="PHP"> PHP</label> &nbsp;
                                <label><input type="checkbox" name="skill_name" class="skillCheckbox" value="Delphi"> Delphi</label> &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <th class="color">졸업일</th>
                            <td colspan="5">
                            	<input type="hidden" id="graduateDay" name="graduate_day">
                                <select name="graduate_year" id="year">
                                    <option></option>
                                </select>
                                	년	
                                <select name="graduate_month" id="month">
                                    <option></option>
                                    <option value="02">02</option>
                                    <option value="08">08</option>
                                </select>
                                	월
                        </tr>
                        <tr>
                        	<th>추가기술</th>
                        	<td>
								<input type="text" id="skillInputAuto">
								<button type="button" class="btn btn-sm btn-outline-secondary" onclick="addSkill(this);">추가</button>
                        	</td>
                        	<td colspan="4" id="addSkills">
                        		
                        	</td>
                        </tr>
                    </tbody>
                </table>
                <div class="button-area">
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="inputSubmit();">등록</button>
                    <button type="reset" class="btn btn-sm btn-outline-secondary" onclick="resetSkill();">초기화</button>
                </div>
				<div id="addSkillInput">
				
				</div>
            </form>
        </div>



    </div>
    
   	<!-- 등록 후 확인 창 띄우기 -->
   	<c:if test="${not empty alertMsg}">
   		<script>
   			alert('${ alertMsg }');
   			// 부모창의 함수 호출
   			opener.parent.selectAll('번호', 'desc', 1);
   			// opener.parent.location='/erp';
   			window.close();
   		</script>
   	</c:if>
    
    <script>
	
		
	
		// 페이지 로딩 시 실행
		$(function() {
		
			
			// 주민등록번호 확인
			$('#jumin_no1').focusout(function() {
				var regExp1 = /\d{2}([0]\d|[1][0-2])([0][1-9]|[1-2]\d|[3][0-1])/;
				
				if($('#jumin_no1').val() != '' && !regExp1.test($('#jumin_no1').val())) {
					alert('잘못된 주민등록번호입니다.');
				}
				
			});
			
			$('#jumin_no2').focusout(function() {
				var regExp2 = /[1-4]\d{6}/;
				
				if($('#jumin_no1').val() != '' && !regExp2.test($('#jumin_no2').val())) {
					alert('잘못된 주민등록번호입니다.');
				}
			});
			
			
	 		// 전체 기술 목록 불러오기
	 		var addSkills = [];
	 		
			// 자동완성 실행
	 		autocomplete(addSkills);
	 		
			// 졸업년도 option 생성
	 		yearOption();
			
			
		});
		
	 	// 졸업년도 option 생성
	 	function yearOption() {
		    var year =  new Date().getFullYear();
			
		    for(var i = 1980 ; i <= (year + 3) ; i++) {
		        $('#year').append('<option value="' + i + '">' + i + '</option>');
		    }
	 		
	 	}
		
		
		
		
	 	// ----------------- 자동완성 -----------------------
		
		
	 	function autocomplete(addSkills) {
	 		
	 		selectSkills(addSkills);
	 		
			// 자동완성
	 		$('#skillInputAuto').autocomplete({
	 			source: addSkills,
	 		    autoFocus: true
	 		});
	 		
	 	}
	 	
	 	
	 	// 자동완성을 위한 기술 목록 조회
	 	function selectSkills(addSkills) {
	 		$.ajax({
	 			url : 'selectSkill.do',
	 			type : 'post',
	 			success : function(data) {
					for(var i = 0; i < data.length; i++) {
						addSkills.push(data[i]);
					}
	 			},
	 			error : function() {
	 				console.log('selectSkills AJAX 실행 오류');
	 			}
	 		});
	 	}
		
		
		// ------------------ 추가기술 -----------------------
		
		var inSkill = [];
		
		// 추가기술 추가
		function addSkill(e) {
    		
    		let skill = $(e).prev().val();

	   		if(skill == '') { // 입력하지 않고 버튼을 누르는 경우
	   			alert('기술을 입력해주세요.');
	   		}
	   		else {
	    		if(inSkill.indexOf(skill) != -1) {
	    			alert('이미 추가한 기술입니다.');
	    		}
	    		else {
	    			inSkill.push(skill); // 중복 확인을 위해 배열에 넣기
		    		
		    		$('#addSkills').append('<button type="button" class="btn btn-sm btn-light" onclick="removeSkill(this);">' + skill + '</button>');
		    		$('#addSkillInput').append('<input type="hidden" name="skill_name" value="' + skill + '">');
	    		}	    			
	   		}
	   		$(e).prev().val('');
    	}	
    
    	// 추가기술 삭제
    	function removeSkill(e) {
    		
    		let skills = $(e).siblings();
    		let skillInputs = $('#addSkillInput input[value="' + $(e).text() + '"]').siblings();
    		$('#addSkills').html(skills);
    		$('#addSkillInput').html(skillInputs);
			inSkill.splice(inSkill.indexOf($(e).text()), 1);
    	}
    	
    	
    	// 추가기술 초기화
    	function resetSkill() {
			inSkill = [];
			
			$('#addSkillInput').html('');
			$('#addSkills').html('');	
    	}
    	
   		
   		
   		
   		// ---------------------- 등록 조건 확인 ----------------------
   		
   		// 이름 작성 확인
   		function checkName() {
   			if($('input[name=staff_name]').val() == '') {
   				alert('이름을 입력해주세요.');
   				return false;
   			}
   			return true;
   		}
   		
		// 주민등록번호 확인 및 값 추출
		function checkJumin() {
			
			if($('#jumin_no1').val() == '' || $('#jumin_no2').val() == '') {
				alert('주민등록번호를 입력해주세요.');
				return false;
			}
			
			let jumin_no = '';
			jumin_no += $('#jumin_no1').val() + '-' + $('#jumin_no2').val();
			$('#juminNo').val(jumin_no);
			
			return true;
		}
   		
   		// 	부서 선택 확인
   		function checkDepartment() {
   			
   			if($('select[name=department_name] option:selected').val() == '') {
   				alert('부서를 선택해주세요.');
   				return false;
   			}
			return true;       			
   		};
   		
   		
   		// 학력 선택 확인
   		function checkSchool() {
   			if($('input[name=school_name]:checked').length == 0) {
   				alert('학력을 선택해주세요.');
   				return false;
   			}
			return true;       			
   		};
   		
    	// 졸업년월 확인 및 추출
   		function graduateDateCheck() {
   			let graduateDay = '';
   			graduateDay += $('#year option:selected').val() + '/' + $('#month option:selected').val();
   			if(graduateDay.length < 7) {
   				alert('졸업일을 선택해주세요');
   				return false;
   			}
   			$('#graduateDay').val(graduateDay);
   			return true;
    	};
   		
    	/*
    	
   		// 기술이 필수일 때 기술 선택 확인
		function checkSkill() {
   			
    		let flag = 0;
    		
    		$('.skillCheckbox').each(function() {
   				if($(this).is(':checked')) {
   					flag++;
   				}        	
    		});
   			
    		if(flag == 0) {
				alert('기술을 선택해주세요.');        			
    			return false;
    		}
    		
    		return true;
   		};

   		*/
    	
    	
    	// 조건 확인 후 form 태그 submit
    	function inputSubmit() {
    		let flag = checkName() && checkJumin() && checkDepartment() && 
    		           checkSchool() && graduateDateCheck();
    		
    		// 확인 완료 - 요청 보내기
    		if(flag && confirm('저장하시겠습니까?')) {
				$('#inputForm').submit();        				
			}
    	};
   		

		
		
		
	
	</script>


	
    
    
    

	


</body>
</html>
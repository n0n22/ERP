<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
            <form method="post" action="updateStaff.do" id="updateForm">
				<input type="hidden" value="${ staff.staff_no }" name="staff_no">
                <table id="insert-table" class="table table-bordered">
                    <thead>
                        <tr>
                            <th colspan="6" class="color"><h4>사원 정보 확인</h4></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th class="color">이름</th>
                            <td>
                                <input type="text" name="staff_name" required value="${ staff.staff_name }">
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
                                <input type="radio" name="school_name" value="고졸">고졸 &nbsp;
                                <input type="radio" name="school_name" value="전문대졸">전문대졸 &nbsp;
                                <input type="radio" name="school_name" value="일반대졸" checked>일반대졸 &nbsp;
                            </td>
                            <th class="color">기술</th>
                            <td colspan="3">
                                <input type="checkbox" name="skill_name" class="skillCheckbox" value="Java">Java &nbsp;
                                <input type="checkbox" name="skill_name" class="skillCheckbox" value="JSP">JSP &nbsp;
                                <input type="checkbox" name="skill_name" class="skillCheckbox" value="ASP">ASP &nbsp;
                                <input type="checkbox" name="skill_name" class="skillCheckbox" value="PHP">PHP &nbsp;
                                <input type="checkbox" name="skill_name" class="skillCheckbox" value="Delphi">Delphi &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <th class="color">졸업일</th>
                            <td colspan="5">
                            	<input type="hidden" id="graduateDay" name="graduate_day">
                                <select name="graduate_year" id="year" onchange="graduateDateCheck();">
                                    <option></option>
                                </select>
                                년	
                                <select name="graduate_month" id="month" onchange="graduateDateCheck();">
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
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateFormSubmit();">수정</button>
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="deleteFormSubmit();">삭제</button>
                </div>
                <div id="addSkillInput">
				
				</div>
            </form>
        </div>
        
        
        <form method="post" action="deleteStaff.do" id="deleteForm">
        	<input type="hidden" value="${ staff.staff_no }" name="staff_no">
        </form>


    </div>
    
    
   	<!-- 등록 후 확인 창 띄우기 -->
   	<c:if test="${not empty alertMsg}">
   		<script>
   			alert('${alertMsg}');
   		</script>
   	</c:if>
    <!-- 등록 후 확인 창 띄우고 닫기 -->
   	<c:if test="${not empty deleteAlertMsg}">
   		<script>
   			alert('${deleteAlertMsg}');
   			window.close();
   		</script>
   	</c:if>
    
    
	<script>

		// 페이지 로딩 시 실행
		$(function() {
		
			// 주민등록번호 확인
			$('#jumin_no1').focusout(function() {
				
				var regExp1 = /\d{2}([0]\d|[1][0-2])([0][1-9]|[1-2]\d|[3][0-1])/;
			
				if(!regExp1.test($('#jumin_no1').val())) {
					alert('잘못된 주민등록번호입니다.');
				}
			
			})
			
			$('#jumin_no2').focusout(function() {
				
				var regExp2 = /[1-4]\d{6}/;
				
				if(!regExp2.test($('#jumin_no2').val())) {
					alert('잘못된 주민등록번호입니다.');
				}
				
			})
			
			
			
	 		// 졸업년도 option 생성
	 		yearOption();
			
		
			// ---------------- 조회한 정보 입력 --------------
			
			// 조회한 주민등록번호 입력
			var jumin = '${staff.jumin_no}';
			$('#jumin_no1').val(jumin.substring(0, 6));
			$('#jumin_no2').val(jumin.substring(7, 14));
			
			
			// 조회한 부서 입력
			$('select[name=department_name] option').each(function() {
				if($(this).val() == '${staff.department_name}') {
					$(this).attr('selected', true);
				}
			});
			
			// 조회한 학력 입력
			$('input[name=school_name]').each(function() {
				if($(this).val() == '${staff.school_name}') {
					$(this).attr('checked', true);
				}
			});
			
			// 조회한 기술 입력
			var skills = [];
			skills = '${staff.skill_name}';
			if(skills != '[]') {
				skills = skills.replace('[', '');
				skills = skills.replace(']', '');
				var skillList = skills.split(', '); 
	
				
				var basicSkills = ['Java', 'JSP', 'ASP', 'PHP', 'Delphi'];
				var addSkillList = [];
				for(var i = 0; i < skillList.length; i++) {
					if(basicSkills.indexOf(skillList[i]) > -1) {
						$('input[value=' + skillList[i] + ']').attr('checked', true);
					}
					else {					
						addSkillList.push(skillList[i]);
					}
				}
				
				console.log(addSkillList.length);
				for(var i = 0; i < addSkillList.length; i++) {
		    		$('#addSkills').append('<button type="button"  class="btn btn-sm btn-light" onclick="removeSkill(this);">' + addSkillList[i] + '</button>');
		    		$('#addSkillInput').append('<input type="hidden" name="skill_name" value="' + addSkillList[i] + '">');
				}
			}
			
			// 조회한 졸업년도 입력
			var gday = '${ staff.graduate_day }';
			gday = gday.trim().split('/');
	
			$('#year option').each(function() {
				if($(this).val() == gday[0]) {
					$(this).attr('selected', true);
				}
			});
			$('#month option').each(function() {
				if($(this).val() == gday[1]) {
					$(this).attr('selected', true);
				}
			});
			
			
			
			
	 		// 전체 기술 목록 불러오기
	 		var addSkills = [];
	 		
			// 자동완성 실행
	 		autocomplete(addSkills);

			
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
			console.log(jumin_no);
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
   		

   		
    	
    	
    	// 조건 확인 후 form 태그 submit
    	function updateFormSubmit() {
    		let flag = checkName() && checkJumin() && checkDepartment() && 
    		           checkSchool() && graduateDateCheck();
    		
    		// 확인 완료 - 요청 보내기
    		if(flag) {
    			if(confirm('수정하시겠습니까?')) {
        			$('#updateForm').submit();        				
    			} else {
    				alert('취소되었습니다.');
    			}
    			
    		}
    		else {
    			console.log(flag);        			
    		}
    		
    		
    	};
   		

    	
    	// 삭제 form태그 실행
    	function deleteFormSubmit() {
    		if(confirm('정말로 삭제하시겠습니까?')) {
	    		$('#deleteForm').submit();    			
    		}
    		else {
    			alert('취소되었습니다.');
    		}
    	};
		
    	
		
	
	</script>


	
    
    
    
    
    
    



</body>
</html>
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
    }
	
	
	.search-area, .body-area {
		width: 900px;
		margin: auto;
		
	}
	
	label {
		cursor: pointer;
	}
	
	a {
		text-decorate: none;
		color: black;
	}
	

	.list-page-area {
		text-align: center;
	}



</style>


</head>




<body>

    
    <div class="outer">
		<form action="" method="post" id="searchConditionForm">
	        <div class="search-area">
	            <table id="search-table" class="table table-bordered">
	                <thead>
	                    <tr>
	                        <th colspan="6" class="color"><h3 align="center">사원 정보 검색</h3></th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <th class="color">이름</th>
	                        <td>
	                            <input type="text" name="staff_name">
	                        </td>
	                        <th class="color">성별</th>
	                        <td>
	                            <label><input type="checkbox" name="jumin" value="남" id="gender1"> 남</label> &nbsp;&nbsp;
	                            <label><input type="checkbox" name="jumin" value="여" id="gender2"> 여 </label>&nbsp;&nbsp;
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
	                            <label><input type="checkbox" name="school_name" value="고졸"> 고졸</label> &nbsp;
	                            <label><input type="checkbox" name="school_name" value="전문대졸"> 전문대졸</label> &nbsp;
	                            <label><input type="checkbox" name="school_name" value="일반대졸"> 일반대졸</label> &nbsp;
	                        </td>
	                        <th class="color">기술</th>
	                        <td colspan="3">
	                            <label><input type="checkbox" name="skill_name" value="Java"> Java</label> &nbsp;
	                            <label><input type="checkbox" name="skill_name" value="JSP"> JSP</label> &nbsp;
	                            <label><input type="checkbox" name="skill_name" value="ASP"> ASP</label> &nbsp;
	                            <label><input type="checkbox" name="skill_name" value="PHP"> PHP</label> &nbsp;
	                            <label><input type="checkbox" name="skill_name" value="Delphi"> Delphi</label> &nbsp;
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="color">졸업일</th>
	                        <td colspan="5">
	                            <select name="" id="year1">
	                                <option></option>
	                            </select>
	                            	년
	                            <select name="" id="month1">
	                                <option></option>
	                                <option>02</option>
	                                <option>08</option>
	                            </select>
	                            	월
	                            &nbsp;~&nbsp;
	                            <select name="" id="year2">
	                                <option></option>
	                            </select>
	                           		년
	                            <select name="" id="month2">
	                                <option></option>
	                                <option>02</option>
	                                <option>08</option>
	                            </select>
	                            	월
	                        </td>
	                    </tr>
	                    <tr>
	                    	<th>추가기술</th>
	                    	<td>
	                    		<input type="text" id="skillInputAuto">
	                    		<button type="button" onclick="addSkill(this);">추가</button>
	                    	</td>
	                    	<td>
	                    		<label><input type="checkbox" name="skillCondition" value="필수"> 필수</label>
	                    	</td>
	                    	<td colspan="3" id="addSkills">
                        		
                        	</td>
	                    </tr>
	                    <tr>
	                    	<td colspan="6" align="center">
	    							<button type="button" onclick="searchStaff(1);">검색</button>	 &nbsp;&nbsp;              	
				                    <button type="button" id="resetBtn" onclick="resetAllCondition();">검색조건초기화</button>
	                    	</td>
	                    </tr>
	                
	                </tbody>
	            </table>
	            <div class="button-area">
	                <div class="search-button-area">
	    				<table>
	    					<tr>
	    						<td>
	    						</td>
	    						<td>
	    						    <button type="button" onclick="selectAll('번호', 'desc', 1);">전부검색</button>
				                    <button type="button" onclick="clearTable();">초기화</button>
				                    <button type="button" onclick="openEnrollForm();">등록</button>
	    						</td>
	    					</tr>
	    				</table>
	                </div>
				</div>
	        </div>
	        <input type="hidden" id="juminNo" name="jumin_no">
	        <input type="hidden" id="graduateDay1" name="graduate_day1">
	        <input type="hidden" id="graduateDay2" name="graduate_day2">
	        <input type="hidden" id="cpage" name="cpage">
	        <div id="addSkillInput">
	        
	        </div>
		</form>

        <div class="body-area">

            <div class="list-area">
                <div class="list-count">
                	<span id="listCount"></span>
                	<span id="orderSelect"></span>
                </div>
                <div class="list-order">
                	
                </div>
                <div class="list-table-area">
                	<table id="listTable" class="table table-bordered">
                		<thead>
                			
                		</thead>
                		<tbody>
                		
                		</tbody>
                	</table>
                </div>
                <div class="list-page-area">
    				<span id="pageArea"></span>
                </div>
            </div>


        </div>

		<form id="updelForm">
			<input type="hidden" id="staffNo" name="staff_no">
		</form>


    </div>
    
    
    
    
	<script>
	
	 	
	 	// 페이지 로딩 후 바로 실행
	 	$(function() {
	
	 		// 졸업년도 option태그 생성
	 		yearOption();
	 		
	 		
	 		// 졸업년도1 선택하면 졸업년도2 변경
	 		$('#year1').change(function() {
	 			let selectYear = $('#year1 option:selected').val();
	 			
	 			$('#year2 option').each(function() {
	 				if($(this).val() == selectYear) {
	 					$(this).attr('selected', true);
	 				}
	 			})
	 		});
	 		
	 		// 졸업월1 선택하면 졸업월2 변경
	 		$('#month1').change(function() {
	 			let selectMonth = $('#month1 option:selected').val();
	 			
	 			$('#month2 option').each(function() {
	 				if($(this).val() == selectMonth) {
	 					$(this).attr('selected', true);
	 				}
	 			})
	 		});
			
	 		
	 		
	 		// 전체 기술 목록 불러오기
	 		var addSkills = [];
		
	 		
	 		/*
	 		// 페이지에 돌아올 때마다 기술목록 조회 (등록 시 새로운 기술이 등록될 수 있으므로)
	 		window.addEventListener('focus', function() {
	 			addSkills = [];
	 			selectSkills(addSkills);
	 			console.log(addSkills);
	 		}, false);
			*/
	 		
			// 자동완성 실행
	 		autocomplete(addSkills);
	 		

	 	});
	 	
	 	
	 	function autocomplete(addSkills) {
	 		
	 		selectSkills(addSkills);
	 		
			// 자동완성
	 		$('#skillInputAuto').autocomplete({
	 		    source: addSkills,
	 		    focus: function (event, ui) {
	 		    	return false;
	 		    },
	 		    select: function (event, ui) {},
	 		    minLength: 1,
	 		    delay: 100,
	 		    autoFocus: true,
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
	 	
	 	// 졸업년도 option 생성
	 	function yearOption() {
		    var year =  new Date().getFullYear();
			
		    for(var i = 1950 ; i <= (year + 3) ; i++) {
		        $('#year1').append('<option value="' + i + '">' + i + '</option>');
		        $('#year2').append('<option value="' + i + '">' + i + '</option>');
		    }
	 		
	 	}
	 	
		// 새창으로 등록폼 띄우기
        function openEnrollForm() {
            window.open('staffInputForm.do', '등록', 'width=1250, height=400, location=yes, menubar=yes, scrollbar=no');
        }
		
		// 새창으로 수정삭제폼 띄우기
		function openUpdelForm(e) {
			window.open('', '수정/삭제', 'width=1250, height=400, location=yes, menubar=yes, scrollbar=no');
		
			$('#staffNo').val($(e).parent().siblings().first().text());
			
			updelForm.action = 'staffUpdelForm.do';
			updelForm.target = '수정/삭제';
			updelForm.method = 'post';
			
			updelForm.submit();
		}
		
		
		
		// 전체검색 AJAX
		function selectAll(order, desc, cpage) {
			
			$('#resetBtn').click();
			clearTable();

			$.ajax({
				
				url : 'selectAll.do',
				type : 'post',
				data : {cpage: cpage, orderCondition: order, desc: desc},
				success : function(map) {
					map.str = 'selectAll';
					// 검색 결과 처리
					setList(map);
					
					if(map.list.length != 0) {
						// 페이징 처리
						pagination(map);
					}
				},
				error : function() {
					console.log('selectAll AJAX 오류');
				}
			});
		};
				
		
		// 검색
		function searchStaff(cpage) {
			
			clearTable();
			
			setGraduateDay();
			setJuminNo();
			setCpage(cpage);
			
			$.ajax({
				url : 'searchStaff.do',
				type : 'post',
				data : $('#searchConditionForm').serialize(),
				success : function(map) {
					// 검색 결과 처리
					setList(map);
					if(map.list.length != 0) {
						// 페이징 처리
						pagination(map.pi, 'searchStaff');
					}
				},
				error : function() {
					console.log('searchStaff AJAX 오류');
				}				
			});
		};
		
		
		
		// 검색 결과 목록 처리
		function setList(map) {
			
			// 전체 검색 건수 추가
			$('#listCount').text('총 ' + map.pi.listCount + '건');
			
			let method = '';
			method += map.str + "('" + map.orderCondition + "','" + map.desc + "',1)";
			console.log(method);
			
			// 테이블 머리 추가           
			let tableHead = '<tr>' 
							+ '<th>번호</th>'
							+ '<th>이름</th>' 
							+ '<th>성별</th>'
							+ '<th>부서</th>'
							+ '<th>졸업일</th>'
							+ '<th></th>'
						  + '</tr>'
			
			$('#listTable thead').html(tableHead);
			
			$('#listTable thead th').each(function() {
				if($(this).text() == map.orderCondition && map.desc == 'desc') {
					$(this).append('<span>▼</span>');
				} 
				else if ($(this).text() == map.orderCondition) {
					$(this).append('<span>▲</span>');
				}
			})
			
			// 테이블 컬럼 추가
			var str = '';
			if(map.list.length != 0) {
				for(var i = 0; i < map.list.length ;i++) {
					str += '<tr>'
							+ '<td>' + map.list[i].staff_no + '</td>'
							+ '<td>' + map.list[i].staff_name + '</td>'
							+ '<td>' + map.list[i].jumin_no + '</td>'
							+ '<td>' + map.list[i].department_name + '</td>'
							+ '<td>' + map.list[i].graduate_day + '</td>'
							+ '<td><button type="button" onclick="openUpdelForm(this);">수정/삭제</button></td>'
						+ '</tr>';						
				}
			}
			else {
				str += '<tr><td colspan="6">조회된 결과가 없습니다.</td></tr>'
			}
			$('#listTable tbody').html(str);
			
		}
		
		// 페이징 처리
		function pagination(map) {

			let method = '';
			method += map.str + "('" + map.orderCondition + "','" + map.desc + "',";
			let pageStr = '';
			
			// 첫 페이지 버튼
			pageStr += '<a href="#" onclick="' + method + '1);return false">처음</a>&nbsp;';
			// pageStr += `<a href="#" onclick="${map.str}(${map.orderCondition}, ${map.desc}, 1); return false">처음</a>`;
			// 이전페이지 버튼
			if(map.pi.startPage < map.pi.pageLimit) {
				pageStr += '<a href="#" onclick="return false">&lt;</a>&nbsp;';	
			}
			else {
				pageStr += '<a href="#" onclick="'  + method +  (pi.startPage - 1)  + ');return false">&lt;</a>&nbsp;';				
			}
			// 페이지 버튼
			for(var i = map.pi.startPage; i <= map.pi.endPage; i++) {
				if(i != map.pi.currentPage) {
					pageStr += '<a href="" onclick="'  + method +  i + ');return false">' + i + '</a>&nbsp;';
				}
				else {
					pageStr += '<a href="" onclick="'  + method +  i + ');return false">[' + i + ']</a>&nbsp;';
				}
			}
			// 다음페이지 버튼
			if(map.pi.maxPage == map.pi.endPage) {
				pageStr += '<a href="" onclick="return false">&gt;</a>&nbsp;';	
			}
			else {
				pageStr += '<a href="" onclick="'  + method + (map.pi.endPage + 1)  + ');return false">&gt;</a>&nbsp;';				
			}
			// 마지막 페이지 버튼
			pageStr += '<a href="" onclick="'  + method + map.pi.maxPage + ');return false">끝</a>&nbsp;';
			
			// 영역에 추가
			$('#pageArea').html(pageStr);
		}
		
		// 초기화
		function clearTable() {
			
			$('#listCount').text('');
			$('#listTable thead').html('');
			$('#listTable tbody').html('');
			$('#pageArea').html('');
			
		}

		
		// 추가 기술을 담을 배열
	   	var inSkill = [];
			
	   	// 추가 기술 추가 버튼 클릭 시 버튼 생성
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
		    		
		    		$('#addSkills').append('<button type="button" onclick="removeSkill(this);">' + skill + '</button>');
		    		$('#addSkillInput').append('<input type="hidden" name="skill_name2" value="' + skill + '">');

	    		}	    			
	   		}
	   		$(e).prev().val('');
	   	}	
	   
	   	// 추가기술 삭제
	   	function removeSkill(e) {
	   		let skills = $(e).siblings();
	   		let skillInput = $('#addSkillInput input[value=' + $(e).text() + ']').siblings();
	   		$('#addSkills').html(skills);
	   		$('#addSkillInput').html(skillInput);
	   		inSkill.splice(inSkill.indexOf($(e).text()), 1);
	   	}
			
		// 선택한 졸업년도를 input type=hidden에 넣기
		function setGraduateDay() {
			
   			let graduateDay1 = '';
   			let graduateDay2 = '';
   			graduateDay1 += $('#year1 option:selected').val() + $('#month1 option:selected').val();
   			graduateDay2 += $('#year2 option:selected').val() + $('#month2 option:selected').val();
   			
   			if(!(graduateDay1 <= graduateDay2)) {
   				alert("올바른 졸업년도를 입력하세요.");
   			}
   			else {
	   			$('#graduateDay1').val(graduateDay1);
	   			$('#graduateDay2').val(graduateDay2);
   			}   			
		}
		
		// 선택한 성별을 input type=hidden에 넣기
		function setJuminNo() {
			
			let flag = 0;
			$('input[name=jumin]').each(function() {
				if($(this).is(':checked')) {
					flag++;
				}		
			})
			
			if(flag == 0 || flag == 2) {
				$('#juminNo').val('all');
			}
			else {
				$('#juminNo').val($('input[name=jumin]:checked').val());
			}
			
		}
		
		// 선택한 현재 페이지를 input type=hidden에 넣기 - VO 변수에 담기 위해서
		function setCpage(cpage) {
			$('#cpage').val(cpage);
		}
		
		// 검색조건 초기화
		function resetAllCondition() {
			
			$('#searchConditionForm input[type=text]').each(function() {
				$(this).val('');
			}) 
			
			$('#searchConditionForm input[type=checkbox], #searchConditionForm input[type=radio]').each(function() {
				$(this).attr('checked', false);
			})
			
			$('#searchConditionForm option').each(function() {
				$(this).attr('selected', false);
			})
			
			inSkill = [];
			
			$('#addSkillInput').html('');
			$('#addSkills').html('');	
			
			
		}
	
	
	
	</script>
		
		
    
    


</body>
</html>
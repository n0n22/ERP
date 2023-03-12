<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.min.js"></script>
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

<script>

 	
 	
 	$(function() {

 		yearOption();
 		
 		$('#year1').change(function() {
 			let selectYear = $('#year1 option:selected').val();
 			console.log(selectYear);
 			
 			$('#year2 option').each(function() {
 				if($(this).val() == selectYear) {
 					$(this).attr('selected', true);
 				}
 			})
 			
 		})
 		
 		
 		$('#month1').change(function() {
 			let selectMonth = $('#month1 option:selected').val();
 			
 			
 			$('#month2 option').each(function() {
 				if($(this).val() == selectMonth) {
 					$(this).attr('selected', true);
 				}
 			})
 			
 		})
 		
 		
 		
 	});
    
 	
 	// 졸업년도 option 생성
 	function yearOption() {
	    var year =  new Date().getFullYear();
		
	    for(var i = (year-50) ; i <= (year + 3) ; i++) {
	        $('#year1').append('<option value="' + i + '">' + i + '</option>');
	        $('#year2').append('<option value="' + i + '">' + i + '</option>');
	    }
 		
 	}
 	
 	
 	
	
 	
    

	

</script>





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
	                    		<input type="text">
	                    		<button type="button">추가</button>
	                    	</td>
	                    </tr>
	                    <tr>
	                    	<td colspan="6" align="center">
	    							<button type="button" onclick="searchStaff(1);">검색</button>	 &nbsp;&nbsp;              	
				                    <button type="reset" id="resetBtn">검색조건초기화</button>
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
	    						    <button type="button" onclick="selectAll(1);">전부검색</button>
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
		</form>
		<script>
		
			function setGraduateDay() {
				
       			let graduateDay1 = '';
       			let graduateDay2 = '';
       			graduateDay1 += $('#year1 option:selected').val() + $('#month1 option:selected').val();
       			graduateDay2 += $('#year2 option:selected').val() + $('#month2 option:selected').val();
       			$('#graduateDay1').val(graduateDay1);
       			$('#graduateDay2').val(graduateDay2);
				
			}
			
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
			
			function setCpage(cpage) {
				$('#cpage').val(cpage);			
			}
		
		
		
		
		</script>
		
		
        <div class="body-area">

            <div class="list-area">
                <div class="list-count">
                	<span id="listCount"></span>
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
    
		// 새창으로 등록폼 띄우기
        function openEnrollForm() {
            window.open('staffInputForm.do', '등록', 'width=1250,height=400,location=yes,menubar=yes,scrollbar=no');
        }
		
		// 새창으로 수정삭제폼 띄우기
		function openUpdelForm(e) {
			
			window.open('', '수정/삭제', 'width=1250, height=400, location=yes,menubar=yes');
		
			$('#staffNo').val($(e).parent().siblings().first().text());
			
			updelForm.action = 'staffUpdelForm.do';
			updelForm.target = '수정/삭제';
			updelForm.method = 'post';
			
			updelForm.submit();
		}
		
		
		
		// 전체검색 AJAX
		function selectAll(cpage) {
			
			$('#resetBtn').click();

			$.ajax({
				
				url : 'selectAll.do',
				type : 'post',
				data : {cpage: cpage},
				success : function(map) {

					// 검색 결과 처리
					setList(map);
					
					// 페이징 처리
					pagination(map.pi, 'selectAll');
					
				},
				error : function() {
					console.log('selectAll AJAX 오류');
				}
				
			});
		};
		

		
		
		// 검색
		function searchStaff(cpage) {
			
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
					
					// 페이징 처리
					pagination(map.pi, 'searchStaff');
					
				},
				error : function() {
					
				}				
				
			});
			
		};
		
		
		
		// 검색 결과 처리
		function setList(map) {
			
			// 전체 검색 건수 추가
			$('#listCount').text('총 ' + map.pi.listCount + '건');
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
				str += '<tr><td colspan="6">조회된 결과가 없습니다.<td></tr>'
			}
			$('#listTable tbody').html(str);
			
		}
		
		
		
		// 페이징 처리
		function pagination(pi, str) {
			
			let pageStr = '';
			
			// 첫 페이지 버튼
			pageStr += '<a href="" onclick="' + str + '(1);return false">처음</a>&nbsp;';
			// 이전페이지 버튼
			if(pi.startPage < pi.pageLimit) {
				pageStr += '<a href="" onclick="return false">&lt;</a>&nbsp;';	
			}
			else {
				pageStr += '<a href="" onclick="' + str + '(' + (pi.startPage - 1)  + ');return false">&lt;</a>&nbsp;';				
			}
			// 페이지 버튼
			for(var i = pi.startPage; i <= pi.endPage; i++) {
				if(i != pi.currentPage) {
					pageStr += '<a href="" onclick="' + str + '(' + i + ');return false">' + i + '</a>&nbsp;';
				}
				else {
					pageStr += '<a href="" onclick="' + str + '(' + i + ');return false">[' + i + ']</a>&nbsp;';
				}
			}
			// 다음페이지 버튼
			if(pi.maxPage == pi.endPage) {
				pageStr += '<a href="" onclick="return false">&gt;</a>&nbsp;';	
			}
			else {
				pageStr += '<a href="" onclick="' + str + '(' + (pi.endPage + 1)  + ');return false">&gt;</a>&nbsp;';				
			}
			// 마지막 페이지 버튼
			pageStr += '<a href="" onclick="' + str + '(' + pi.maxPage + ');return false">끝</a>&nbsp;';
			
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
		
		/*
		// 해당 창으로 돌아왔을때, 실행시킴
		window.addEventListener('focus', function() {
			selectAll(1);
		}, false);
		*/
		


    </script>


</body>
</html>
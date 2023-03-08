<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.min.js"></script>

<style>
    .outer {
        width: 1200px;
    }

    
    #search-table {
        margin: auto;
        border: 1px solid black;
        border-collapse: collapse;
    }

    #search-table th, #search-table td {
        border: 1px solid black;
    }

    #search-table .color {
        background-color: lightgray;
    }

    .button-area>div {
        margin: auto;
    }




</style>


</head>

<script>

 	
 	
 	$(function() {

 		yearOption();
 		
 		
 	});
    
 	
 	// 졸업년도 option 생성
 	function yearOption() {
	    var year =  new Date().getFullYear();
		
	    for(var i = (year-50) ; i <= year ; i++) {
	        $('#year1').append('<option value="' + i + '">' + i + '</option>');
	        $('#year2').append('<option value="' + i + '">' + i + '</option>');
	    }
 		
 	}
	
 	
    

	

</script>





<body>

    
    <div class="outer">

        <div class="search-area">
            <table id="search-table">
                <thead>
                    <tr>
                        <th colspan="6" class="color">사원 정보 검색</th>
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
                            <input type="checkbox" name="jumin_no">남 &nbsp;&nbsp;
                            <input type="checkbox" name="jumin_no">여 &nbsp;&nbsp;
                        </td>
                        <th class="color">부서</th>
                        <td>
                            <select name="department_name">
                                <option></option>
                                <option>ICT사업부</option>
                                <option>디지털트윈사업부</option>
                                <option>SI사업부</option>
                                <option>반도체사업부</option>
                                <option>기업부설연구소</option>
                                <option>전략기획팀</option>
                                <option>경영지원팀</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th class="color">학력</th>
                        <td>
                            <input type="checkbox" name="school_name">고졸 &nbsp;
                            <input type="checkbox" name="school_name">전문대졸 &nbsp;
                            <input type="checkbox" name="school_name">일반대졸 &nbsp;
                        </td>
                        <th class="color">기술</th>
                        <td colspan="3">
                            <input type="checkbox" name="skill_name">Java &nbsp;
                            <input type="checkbox" name="skill_name">JSP &nbsp;
                            <input type="checkbox" name="skill_name">ASP &nbsp;
                            <input type="checkbox" name="skill_name">PHP &nbsp;
                            <input type="checkbox" name="skill_name">Delphi &nbsp;
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
                </tbody>
            </table>
        </div>
        <div class="body-area">

            <div class="button-area">
                <div class="search-button-area">
    				<table>
    					<tr>
    						<td>
    							<button type="submit">검색</button>
    						</td>
    						<td>
    						    <button type="button" onclick="selectAll(1);">전부검색</button>
			                    <button type="button">초기화</button>
			                    <button type="button" onclick="openEnrollForm();">등록</button>
    						</td>
    					</tr>
    				</table>
                </div>
            </div>
            <div class="list-area">
                <div class="list-count">
                	<span id="listCount"></span>
                </div>
                <div class="list-table-area">
                	<table id="listTable">
                		<thead>
                			
                		</thead>
                		<tbody>
                		
                		</tbody>
                	</table>
                </div>
                <div class="list-page-area">
    
                </div>
            </div>


        </div>




    </div>

    <script>
    
		// 새창으로 등록폼 띄우기
        function openEnrollForm() {
            window.open('staffInputForm.do', '등록', 'width=1100,height=200,location=yes,menubar=yes,scrollbar=no');
        }
		
		
		// 전체검색 AJAX
		function selectAll(cpage) {
			
			console.log(cpage);
			
			$.ajax({
				
				url : 'selectAll.do',
				type : 'post',
				data : {cpage: cpage},
				success : function(map) {
					console.log(map);
					console.log(map.list.length);

					$('#listCount').text('총 ' + map.pi.listCount + '건');
					$('#listTable thead').html('<tr><th>번호</th><th>이름</th><th>성별</th><th>부서</th><th>졸업일</th><th></th></tr>')
					
					var str = '';
					for(var i = 0; i < map.list.length ;i++) {
						console.log(map.list.length);
						console.log(map.list[i]);
						str += '<tr>'
								+ '<td>' + map.list[i].staff_no + '</td>'
								+ '<td>' + map.list[i].staff_name + '</td>'
								+ '<td>' + map.list[i].jumin_no + '</td>'
								+ '<td>' + map.list[i].department_name + '</td>'
								+ '<td>' + map.list[i].graduate_day + '</td>'
								+ '<td><button type="button">수정/삭제</button></td>'
							+ '</tr>';						
					}
					
					$('#listTable tbody').html(str);
					
					
					
				},
				error : function() {
					console.log('selectAll AJAX 오류');
				}
				
				
			});
			
		}
		
		


		
		


    </script>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
<style>
    .outer {
        width: 1200px;
    }
    
    #insert-table {
        margin: auto;
        border: 1px solid black;
        border-collapse: collapse;
    }

    #insert-table th, #insert-table td {
        border: 1px solid black;
    }

    #insert-table .color {
        background-color: lightgray;
    }

    .button-area>div {
        margin: auto;
    }




</style>



</head>
<body>
	
	<script>
	
		// 주민등록번호 값 전달
		function juminCheck() {
			let jumin_no = '';
			
			jumin_no += $('#jumin_no1').val() + '-' + $('#jumin_no2').val();

			$('#juminNo').val(jumin_no);		
		}
		
	
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
			
			
		});
		
		
		
		
		
	
	</script>


	

    <div class="outer">

        <div class="insert-area">
            <form method="post" action="staffInput.do" id="inputForm">

                <table id="insert-table">
                    <thead>
                        <tr>
                            <th colspan="6" class="color">사원 정보 등록</th>
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
                                <input type="text" id="jumin_no1" required onchange="juminCheck();"> 
                                &nbsp; - &nbsp;
                                <input type="password" id="jumin_no2" required onchange="juminCheck();">
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
                                    <c:forEach var="i" begin="1950" end="2023">
                                        <option value=${ i }>${ i }</option>
                                    </c:forEach>
                                </select>
                                년	
                                <select name="graduate_month" id="month" onchange="graduateDateCheck();">
                                    <option></option>
                                    <option value="02">02</option>
                                    <option value="08">08</option>
                                </select>
                                월
                        </tr>
                    </tbody>
                </table>
                <div class="button-area">
                    <button type="button" onclick="inputSubmit();">등록</button>
                    <button type="reset">초기화</button>
                </div>

            </form>
        </div>
       	
       	
       
        <script>
       		
        
        	// 졸업년월 추출
       		function graduateDateCheck() {
       			let graduateDay = '';
       			graduateDay += $('#year option:selected').val() + '/' + $('#month option:selected').val();
       			
       			$('#graduateDay').val(graduateDay);
       		};
       		
       		// 	부서 선택 확인
       		function checkDepartment() {
       			
       			if($('select[name=department_name] option:selected').val() == '') {
       				alert('부서를 선택해주세요.');
       				return false;
       			}
       			     			
				return true;       			
       		};
       		
       		
       		// 기술 선택 확인
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
       		
        	
        	
        	// 조건 확인 후 form 태그 submit
        	function inputSubmit() {
        		let flag = checkDepartment() && checkSkill();
        		
        		// 확인 완료 - 요청 보내기
        		if(flag) {
        			if(confirm('저장하시겠습니까?')) {
	        			$('#inputForm').submit();        				
        			} else {
        				arlert('취소되었습니다.');
        			}
        			
        		}
        		else {
        			console.log(flag);        			
        		}
        		
        		
        	};
       		

       
       
        </script>


       	<!-- 등록 후 확인 창 띄우기 -->
       	<c:if test="${not empty alertMsg}">
       		<script>
       			alert('${ alertMsg }');      		
       			window.close();
       		</script>
       	</c:if>


    </div>

	


</body>
</html>
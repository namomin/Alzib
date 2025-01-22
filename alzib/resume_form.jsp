<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
    
    String AId = (String) session.getAttribute("sid");

    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // JDBC 드라이버 로드
       

        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성
        String query = "SELECT AName, ABirth, APhone, AEmail FROM Alba WHERE AId = ?";

        // PreparedStatement 객체 생성
        pstmt = con.prepareStatement(query);

        // SQL 쿼리에 파라미터 값 설정
        pstmt.setString(1, AId);

        // SQL 실행 및 결과 가져오기
        rs = pstmt.executeQuery();

        // 결과가 있을 경우
        if (rs.next()) {
            // 결과에서 필드 값 가져오기
            String AName = rs.getString("AName");
            String ABirth = rs.getString("ABirth");
            String APhone = rs.getString("APhone");
            String AEmail = rs.getString("AEmail");

%>
<html>
<head>
<meta charset="utf-8">
<title>이력서 작성</title>
<link href="resume.css" rel="stylesheet" type="text/css">
	
<script>
	// 원 자동 입력 코드
    function addWon() {
      var payInput = document.getElementById("payInput");
      var inputValue = payInput.value.replace(/[^0-9]/g, '');

      if (inputValue) {
        payInput.value = inputValue + '원';
      } else {
        payInput.value = '';
      }
    }
	
        function toggleHighSchool() {
            var checkbox = document.getElementById("high");
            var highDiv = document.getElementById("high0");

            if (checkbox.checked) {
                highDiv.style.display = "block"; // 체크됐을 때 보이기
            } else {
                highDiv.style.display = "none"; // 체크 해제됐을 때 숨기기
            }
        }
	
	
        function toggleCollege() {
            var checkbox = document.getElementById("college");
            var collegeDiv = document.getElementById("college0");

            if (checkbox.checked) {
                collegeDiv.style.display = "block"; // 체크됐을 때 보이기
            } else {
                collegeDiv.style.display = "none"; // 체크 해제됐을 때 숨기기
            }
        }
	
	
        var numOfWorkExperiences = 1; // 초기 경력 사항 개수

        function toggleCareerInput() {
            var careerDiv = document.getElementById("Career");
            var newRadio = document.getElementById("new");

            if (newRadio.checked) {
                careerDiv.style.display = "none"; // 신입일 때 숨김
            } else {
                careerDiv.style.display = "block"; // 경력일 때 보이기
            }
        }

        function addWorkExperience() {
            if (numOfWorkExperiences < 5) { // 최대 5개까지만 추가 가능
                numOfWorkExperiences++;
                var careerDiv = document.getElementById("Career");
                var newCareerInputs = document.createElement("div");
                newCareerInputs.innerHTML = '<input type="text" name="RCareer' + (numOfWorkExperiences * 2 - 1) + '" placeholder="점포/회사명">&nbsp;' +
                    '<input type="text" name="RCareer' + (numOfWorkExperiences * 2) + '" placeholder="기간"><br>';
                careerDiv.appendChild(newCareerInputs);
            } else {
                alert("최대 5개의 경력 사항만 추가 가능합니다.");
            }
        }
</script>
</head>

<body>
<form name="resume" method="post" action="resume_formResult.jsp">
<div class="wrap">
	<div class="border_wrap">
		
		<div class="header">
			<hr><h1>기본정보</h1><hr>
		</div>
		
		<div class="content">
			<table id="inform"> 
			<tr>
				<td>
				<input type="hidden" name="AName" value="<%=AName%>"><font color="#689ADE">이름</font>&nbsp; <%=AName%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="ABirth" value="<%=ABirth%>"><font color="#689ADE">생년월일</font>&nbsp; <%=ABirth%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="APhone" value="<%=APhone%>"><font color="#689ADE">전화번호</font>&nbsp; <%=APhone%>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="AEmail" value="<%=AEmail%>"><font color="#689ADE">이메일</font>&nbsp; <%=AEmail%>
				</td>
			</tr>
		</table>
<%
	   } else {
            // 세션에서 AId에 해당하는 정보를 찾을 수 없는 경우에 대한 처리
            out.println("해당하는 정보를 찾을 수 없습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 자원 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>		
			
		<div class="sub_title">
			<h3>이력서 제목 *</h3>
		</div>
		<div class="sub_content">
		<input type="text" name="RTitle" placeholder="이력서 제목을 입력해주세요" required>
		</div>
			
		<div class="sub_title">
			<h3>학력 정보 *</h3>
		</div>
		<div class="sub_content">
			<select name="RAbility1">
						<option value="초등학교">초등학교</option>
						<option value="중학교">중학교</option>
						<option value="고등학교">고등학교</option>
						<option value="대학교 (2,3년제)">대학교 (2,3년제)</option>
						<option value="대학교 (4년제)">대학교 (4년제)</option>
						<option value="대학원">대학원</option>
					</select>&nbsp;
					<select name="RAbility2">
						<option value="졸업">졸업</option>
						<option value="재학">재학</option>
						<option value="휴학">휴학</option>
						<option value="중퇴">중퇴</option>
						<option value="수료">수료</option>
			</select>
		</div>
			
		<div class="sub_title">
			<h3>학력 상세 입력 (선택)</h3>
		</div>
		<div class="sub_content">
					<input type="checkbox" id='high' onchange="toggleHighSchool()"> 고등학교&nbsp;
					<div id="high0" style="display: none;">
						<input type="text" name="RHigh" placeholder="학교명">
					</div>
					<br>
					<input type="checkbox" id="college" onchange="toggleCollege()"> 대학교&nbsp;
					<div id="college0" style="display: none;">
						<input type="text" name="RCollege1" placeholder="학교명">&nbsp;
						<input type="text" name="RCollege2" placeholder="전공">
					</div>
		</div>
			
		<div class="sub_title">
			<h3>경력사항 *</h3>
		</div>
		<div class="sub_content">
			<input type="radio" name="RCareer0" value="신입" id="new"> 신입
			<br>
			<input type="radio" name="RCareer0" value="경력" id="senior"> 경력&nbsp;
			<div id="Career">
			<input type="text" name="RCareer1" placeholder="점포/회사명">&nbsp;
			<input type="text" name="RCareer2" placeholder="근무기간"><br><br>
			</div>
			<input type="button" value="경력추가" onclick="addWorkExperience()">
		</div>
			
		<div class="header">
			<hr><h1>희망 근무 조건</h1><hr>
		</div>
		<div class="content">
			<div class="sub_title">
				<h3>근무 지역 *</h3>
			</div>
			<div class="sub_content">
				<select name="HArea1">&nbsp;&nbsp;
               	<option value="전국">전국</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="인천">인천</option>
				<option value="강원">강원</option>
				<option value="대전">대전</option>
				<option value="세종">세종</option>
				<option value="충남">충남</option>
				<option value="충북">충북</option>
				<option value="부산">부산</option>
				<option value="울산">울산</option>
				<option value="경남">경남</option>
				<option value="경북">경북</option>
				<option value="대구u">대구</option>
				<option value="광주">광주</option>
				<option value="전남">전남</option>
				<option value="전북">전북</option>
				<option value="제주">제주</option>
            	</select>
				&nbsp;<input type="checkbox" name="HArea2" value="재택 근무"> 재택 근무
			</div>
			
			<div class="sub_title">
				<h3>업직종 *</h3>
			</div>
			<div class="sub_content">
					<input type="checkbox" name="HType1" value="무관"> 무관
					<input type="checkbox" name="HType2" value="외식/음료"> 외식/음료
					<input type="checkbox" name="HType3" value="매장 관리/판매"> 매장 관리/판매
					<input type="checkbox" name="HType4" value="서비스"> 서비스
					<input type="checkbox" name="HType5" value="사무직"> 사무직
				<br>
					<input type="checkbox" name="HType6" value="고객 상담/리서치/영업"> 고객 상담/리서치/영업
					<input type="checkbox" name="HType7" value="IT/기술"> IT/기술
					<input type="checkbox" name="HType8" value="디자인"> 디자인
					<input type="checkbox" name="HType9" value="미디어"> 미디어
					<input type="checkbox" name="HType10" value="운전/배달"> 운전/배달
					<input type="checkbox" name="HType11" value="교육/강사"> 교육/강사
			</div>
			<div class="sub_title">
				<h3>근무 형태 *</h3>
			</div>
			<div class="sub_content">
					<input type="radio" name="HForm" value="알바"> 알바&nbsp;
					<input type="radio" name="HForm" value="정규직"> 정규직&nbsp;
					<input type="radio" name="HForm" value="계약직"> 계약직&nbsp;
					<input type="radio" name="HForm" value="파견직"> 파견직&nbsp;
					<input type="radio" name="HForm" value="인턴"> 인턴&nbsp;
					<input type="radio" name="HForm" value="프리랜서"> 프리랜서&nbsp;
					<input type="radio" name="HForm" value="연수생/교육생"> 연수생/교육생<br><br>
			</div>
			
			<div class="sub_title">
				<h3>근무 기간 *</h3>
			</div>
			<div class="sub_content">
					<input type="radio" name="HPeriod" value="무관"> 무관&nbsp;
					<input type="radio" name="HPeriod" value="하루"> 하루&nbsp;
					<input type="radio" name="HPeriod" value="1주일 이하"> 1주일 이하&nbsp;
					<input type="radio" name="HPeriod" value="1주일~1개월"> 1주일~1개월&nbsp;
					<input type="radio" name="HPeriod" value="1개월~3개월"> 1개월~3개월&nbsp;
					<input type="radio" name="HPeriod" value="3개월~6개월"> 3개월~6개월&nbsp;
					<input type="radio" name="HPeriod" value="6개월~1년"> 6개월~1년&nbsp;
					<input type="radio" name="HPeriod" value="1년 이상"> 1년 이상&nbsp;
			</div>
			
			<div class="sub_title">
				<h3>근무 요일 *</h3>
			</div>
			<div class="sub_content">
					<select name="HDay">
						<option value="무관">무관</option>
						<option value="월~일">월~일</option>
						<option value="월~토">월~토</option>
						<option value="월~금">월~금</option>
						<option value="주말 (토,일)">주말 (토,일)</option>
						<option value="주6일">주6일</option>
						<option value="주5일">주5일</option>
						<option value="주5일">주5일</option>
						<option value="주3일">주3일</option>
						<option value="주2일">주2일</option>
						<option value="주1일">주1일</option>
					</select>
			</div>
			
			<div class="sub_title">
				<h3>근무 시간 *</h3>
			</div>
			<div class="sub_content">
					<select name="HTime">
						<option value="무관">무관</option>
						<option value="오전 파트">오전 파트</option>
						<option value="오후 파트">오후 파트</option>
						<option value="저녁 파트">저녁 파트</option>
						<option value="새벽 파트">새벽 파트</option>
						<option value="오전~오후 파트">오전~오후 파트</option>
						<option value="오후~저녁 파트">오후~저녁 파트</option>
						<option value="저녁~새벽 파트">저녁~새벽 파트</option>
						<option value="새벽~오전 파트">새벽~오전 파트</option>
						<option value="올타임 (8시간 이상)">올타임 (8시간 이상)</option>
            		</select>
			</div>
			
			<div class="sub_title">
				<h3>희망 급여 *</h3>
			</div>
			<div class="sub_content">
					<input type="text" name="HSalary1" id="payInput" placeholder="희망 급여를 입력해주세요. ※ 2024년 기준 최저 시급은 9,860원입니다. ※" oninput="addWon()" required>
					<br><br>
					<input type="checkbox" name="HSalary2" id="pcon" value="추후 협의"> 추후 협의			
			</div>
		</div>
		
		<div class="header">
			<hr><h1>소개</h1><hr>
		</div>
		<div class="content">
			<div class="sub_title">
				<h3>자기소개</h3>
			</div>	
			<div class="sub_content">
				<textarea name="RIntroduce" cols="80" rows="15" placeholder="자기소개를 입력해주세요"></textarea>
			</div>
			
			<div class="sub_title">
				<h3>기타사항</h3>
			</div>	
			<div class="sub_content">
				<textarea name="REtc" cols="80" rows="15" placeholder="이외에 기업에게 추가로 전하고 싶은 말을 입력해 주세요"></textarea>
			</div>
		</div>
		
		<br><br>
		<div id="button">
			<input type="submit" value="등 록">
			<a href="mypageAlba.jsp">
				<input type="button" value="취 소">
			</a>
			
		</div>	
			
		</div>
		
	</div>
</div>
</form>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
    // 세션에서 BId 값 가져오기
    String bId = (String) session.getAttribute("sid");

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
        String query = "SELECT BStore, BName, BAddress, BPhone, BEmail FROM Boss WHERE BId = ?";

        // PreparedStatement 객체 생성
        pstmt = con.prepareStatement(query);

        // SQL 쿼리에 파라미터 값 설정
        pstmt.setString(1, bId);

        // SQL 실행 및 결과 가져오기
        rs = pstmt.executeQuery();

        // 결과가 있을 경우
        if (rs.next()) {
            // 결과에서 필드 값 가져오기
            String bStore = rs.getString("BStore");
            String bName = rs.getString("BName");
            String bAddress = rs.getString("BAddress");
            String bPhone = rs.getString("BPhone");
            String bEmail = rs.getString("BEmail");
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>post</title>
<link href="post.css" rel="stylesheet" type="text/css">

<script>
    // 요일 지정 라디오 버튼
    var dayselRadio = document.getElementById("daysel");
    // 요일 협의 라디오 버튼
    var dayconRadio = document.getElementById("daycon");
    // 요일 선택 체크박스들
    var daysCheckboxes = document.querySelectorAll("input[name^='day']");

    // 페이지 로드시 초기 상태 설정
    if (dayconRadio.checked) {
        disableCheckboxes();
    }

    // 요일 협의 라디오 버튼을 클릭했을 때
    dayconRadio.addEventListener("click", function() {
        disableCheckboxes();
    });

    // 요일 지정 라디오 버튼을 클릭했을 때
    dayselRadio.addEventListener("click", function() {
        enableCheckboxes();
    });

    // 요일 선택 체크박스 활성화 함수
    function enableCheckboxes() {
        for (var i = 0; i < daysCheckboxes.length; i++) {
            daysCheckboxes[i].disabled = false;
        }
    }

    // 요일 선택 체크박스 비활성화 함수
    function disableCheckboxes() {
        for (var i = 0; i < daysCheckboxes.length; i++) {
            daysCheckboxes[i].disabled = true;
            // 체크박스 선택 해제
            daysCheckboxes[i].checked = false;
        }
    }
</script>
</head>

<body>
<form name="post" method="post" action="postResult.jsp" >
<div class="wrap">
	<div class="border_wrap">
		<div class="header">
			<hr><h1>기본정보</h1><hr>
		</div>
		
		<div class="content">
			<table id="inform"> 
			<tr>
				<td>
				<input type="hidden" name="BStore" value="<%= bStore %>"><font color="#689ADE">회사/점포명</font>&nbsp; <%= bStore %>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="BName" value="<%= bName %>"><font color="#689ADE">대표자명</font>&nbsp; <%= bName %>&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td>
				<input type="hidden" name="BAddress" value="<%= bAddress %>"><font color="#689ADE">회사/점포 주소</font>&nbsp; <%= bAddress %>&nbsp;&nbsp;
				</td>
				<td>
				<input type="hidden" name="BPhone" value="<%= bPhone %>"><font color="#689ADE">전화번호</font>&nbsp; <%= bPhone %>
				</td>
				<td>
				<input type="hidden" name="BEmail" value="<%= bEmail %>"><font color="#689ADE">이메일</font>&nbsp; <%= bEmail %>
				</td>
			</tr>
		</table>
		</div>
		
<!--
<%
        } else {
            // 세션에서 BId에 해당하는 정보를 찾을 수 없는 경우에 대한 처리
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
-->	
		<div class="header">
			<hr><h1>공고 작성</h1><hr>
		</div>
		
		<div class="content">
			<div class="sub_title">
				<h3>공고 제목 *</h3>
			</div>
			<div class="sub_content">
				<input type="text" name="Title" placeholder="공고 제목을 입력해주세요" required>
			</div>
		</div>
			
		<div class="content">
			<div class="sub_title">
				<h3>업직종 *</h3>
			</div>
			<div class="sub_content">
				<select name="Category">
						<option value="외식/음료">외식/음료</option>
						<option value="매장 관리/판매">매장 관리/판매</option>
						<option value="서비스">서비스</option>
						<option value="사무직">사무직</option>
						<option value="고객 상담/리서치/영업">고객 상담/리서치/영업</option>
						<option value="IT/기술">IT/기술</option>
						<option value="디자인">디자인</option>
						<option value="미디어">미디어</option>
						<option value="운전/배달">운전/배달</option>
						<option value="교육/강사">교육/강사</option>
					</select>
			</div>
			
			<div class="sub_title">
				<h3>고용 형태 *</h3>
			</div>
			<div class="sub_content">
				<input type="radio" name="Type" value="알바"> 알바&nbsp;
					<input type="radio" name="Type" value="정규직"> 정규직&nbsp;
					<input type="radio" name="Type" value="계약직"> 계약직&nbsp;
					<input type="radio" name="Type" value="파견직"> 파견직&nbsp;
					<input type="radio" name="Type" value="인턴"> 인턴&nbsp;
					<input type="radio" name="Type" value="프리랜서"> 프리랜서&nbsp;
					<input type="radio" name="Type" value="연수생/교육생"> 연수생/교육생
			</div>
			
			<div class="sub_title">
				<h3>모집인원 *</h3>
			</div>
			<div class="sub_content">
				<select name="Personnel">
						<option value="인원 미정">인원 미정</option>
						<option value="1명">1명</option>
						<option value="2명">2명</option>
						<option value="3명">3명</option>
						<option value="4명">4명</option>
						<option value="5명">5명</option>
						<option value="6명 이상">6명 이상</option>
					</select>
			</div>
			
			<div class="sub_title">
				<h3>성별/연령/학력</h3>
			</div>
			<div class="sub_content">
				<select name="Sex">
						<option value="성별 무관" selected>성별 무관</option>
						<option value="여자만">여자만</option>
						<option value="남자만">남자만</option>
					</select>&nbsp;
					<select name="Age">
						<option value="연령 무관" selected>연령 무관</option>
						<option value="16세~20세">16세~20세</option>
						<option value="20대">20대</option>
						<option value="30대">30대</option>
						<option value="40대">40대</option>
						<option value="50대">50대</option>
						<option value="60세 이상">60세 이상</option>
					</select>&nbsp;
					<select name="Ability">
						<option value="학력 무관" selected>학력 무관</option>
						<option value="초등학교 졸업">초등학교 졸업</option>
						<option value="중학교 졸업">중학교 졸업</option>
						<option value="고등학교 졸업">고등학교 졸업</option>
						<option value="대학교 재학/졸업">대학교 재학/졸업</option>
						<option value="대학원 재학/졸업">대학원 재학/졸업</option>
					</select>
					<br><br>
					<p>※ 합리적 이유없이 성별/연령을 제한하는 경우 <font color="red"><b>벌금</b></font>이 부과될 수 있습니다. ※</p>
			</div>
			
			<div class="sub_title">
				<h3>우대조건 (선택)</h3>
			</div>
			<div class="sub_content">
				<input type="checkbox" name="preferential1" value="인근 거주"> 인근 거주
					<input type="checkbox" name="preferential2" value="유사 업무 경험"> 유사 업무 경험
					<input type="checkbox" name="preferential3" value="관련 자격증 소지"> 관련 자격증 소지
			</div>
		</div>
		
		<div class="header">
			<hr><h1>근무 조건</h1><hr>
		</div>
		<div class="content">
			<div class="sub_title">
				<h3>근무 기간 *</h3>
			</div>
			<div class="sub_content">
				<input type="radio" name="Period" value="하루"> 하루&nbsp;
					<input type="radio" name="Period" value="1주일 이하"> 1주일 이하&nbsp;
					<input type="radio" name="Period" value="1주일~1개월"> 1주일~1개월&nbsp;
					<input type="radio" name="Period" value="1개월~3개월"> 1개월~3개월&nbsp;
					<input type="radio" name="Period" value="3개월~6개월"> 3개월~6개월&nbsp;
					<input type="radio" name="Period" value="6개월~1년"> 6개월~1년&nbsp;
					<input type="radio" name="Period" value="1년 이상"> 1년 이상&nbsp;
					<input type="radio" name="Period" value="협의 가능"> 협의 가능
			</div>
			
			<div class="sub_title">
				<h3>근무 요일 *</h3>
			</div>
			<div class="sub_content">
				<input type="radio" name="Selector" id="daysel" value="요일 지정"> 요일 지정&nbsp;
						<input type="radio" name="Selector" id="daycon" value="요일 협의"> 요일 협의
						<br><br>
						<input type="checkbox" name="day1" id="mon" value="월"> 월
						<input type="checkbox" name="day2" id="tue" value="화"> 화
						<input type="checkbox" name="day3" id="wed" value="수"> 수
						<input type="checkbox" name="day4" id="thu" value="목"> 목
						<input type="checkbox" name="day5" id="fri" value="금"> 금
						<input type="checkbox" name="day6" id="sat" value="토"> 토
						<input type="checkbox" name="day7" id="sun" value="일"> 일
			</div>
			
			<div class="sub_title">
				<h3>근무 시간 *</h3>
			</div>
			<div class="sub_content">
				<select name="Time1">
						<option value="시간 협의" selected>시간 협의</option>
						<option value="1시">1시</option>
						<option value="2시">2시</option>
						<option value="3시">3시</option>
						<option value="4시">4시</option>
						<option value="5시">5시</option>
						<option value="6시">6시</option>
						<option value="7시">7시</option>
						<option value="8시">8시</option>
						<option value="9시">9시</option>
						<option value="10시">10시</option>
						<option value="11시">11시</option>
						<option value="12시">12시</option>
						<option value="13시">13시</option>
						<option value="14시">14시</option>
						<option value="15시">15시</option>
						<option value="16시">16시</option>
						<option value="17시">17시</option>
						<option value="18시">18시</option>
						<option value="19시">19시</option>
						<option value="20시">20시</option>
						<option value="21시">21시</option>
						<option value="22시">22시</option>
						<option value="23시">23시</option>
						<option value="24시">24시</option>
				</select>
				&nbsp;~&nbsp;
				<select name="Time2">
						<option value="시간 협의" selected>시간 협의</option>
						<option value="1시">1시</option>
						<option value="2시">2시</option>
						<option value="3시">3시</option>
						<option value="4시">4시</option>
						<option value="5시">5시</option>
						<option value="6시">6시</option>
						<option value="7시">7시</option>
						<option value="8시">8시</option>
						<option value="9시">9시</option>
						<option value="10시">10시</option>
						<option value="11시">11시</option>
						<option value="12시">12시</option>
						<option value="13시">13시</option>
						<option value="14시">14시</option>
						<option value="15시">15시</option>
						<option value="16시">16시</option>
						<option value="17시">17시</option>
						<option value="18시">18시</option>
						<option value="19시">19시</option>
						<option value="20시">20시</option>
						<option value="21시">21시</option>
						<option value="22시">22시</option>
						<option value="23시">23시</option>
						<option value="24시">24시</option>
					</select>
			</div>
			
			<div class="sub_title">
				<h3>급여 *</h3>
			</div>
			<div class="sub_content">
				<input type="radio" name="Pay1" id="timep" value="시급"> 시급&nbsp;
					<input type="radio" name="Pay1" id="dayp" value="일급"> 입급&nbsp;
					<input type="radio" name="Pay1" id="weekp" value="주급"> 주급&nbsp;
					<input type="radio" name="Pay1" id="monp" value="월급"> 월급&nbsp;
					<input type="radio" name="Pay1" id="yearp" value="연봉"> 연봉&nbsp;
					<input type="radio" name="Pay1" id="onep" value="건별"> 건별
					<br><br>
					<input type="text" name="Pay2" id="payInput" placeholder="금액을 입력해주세요. ※ 2024년 기준 최저 시급은 9,860원입니다. ※" oninput="addWon()" required>
			</div>
			
			<div class="sub_title">
				<h3>복리후생 (선택)</h3>
			</div>
			<div class="sub_content">
				<input type="checkbox" name="Welfare1" value="건강 보험"> 건강 보험&nbsp;
					<input type="checkbox" name="Welfare2" value="통근 버스 운행"> 통근 버스 운행&nbsp;
					<input type="checkbox" name="Welfare3" value="숙식 제공"> 숙식 제공&nbsp;
					<input type="checkbox" name="Welfare4" value="식사 제공"> 식사 제공&nbsp;
					<input type="checkbox" name="Welfare5" value="고용 보험"> 고용 보험&nbsp;
					<input type="checkbox" name="Welfare6" value="퇴직금"> 퇴직금&nbsp;
					<input type="checkbox" name="Welfare7" value="근무복 지급"> 근무복 지급&nbsp;
			</div>
			<br><br>
			<textarea name="Etc" cols="80" rows="15" placeholder="지원자에게 이외의 기타 요구 사항이나 전달 사항이 있다면 이곳에 입력해주세요."></textarea>
		</div>
			
			
	</div>	
</div>
</form>
</body>
</html>
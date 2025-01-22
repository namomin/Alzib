<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<html>
<head>
<meta charset="utf-8">
<title>필터</title>
<link href="fillter.css" rel="stylesheet" type="text/css">
<style>
		.nav{
			text-align: left;
			margin-left: 24%;
			margin-bottom: 15px;
			width: 20%;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
			background-color: white;
		}

		a{
			color: #689ADE;
			text-decoration: none;
		}

		a:hover{
			color:#CADCF4;
		}
</style>
</head>
<body>
<div class="wrap">
<div class="nav">
		<span><a href="post_list.jsp">알바 검색</a> > <a href="fillterSearch.jsp">필터 검색</a></span>
	</div>
	<div class="border_wrap">
	<form method="post" action="filterSearchResult.jsp">	
		<header>
			<hr>
				<h2><font color="#689ADE">검색 조건 설정</font></h2>
			<hr>
		</header>
		
		<div class="filter">
			<label for="type">업직종</label>
			<br>
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
			
			<label for="Time ">근무 시간</label>
			<br>
            <select name="Time1" class="time">
				<option value="시간 협의">시간 협의</option>
				<option value="1시" selected>1시</option>
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
			&nbsp;-&nbsp;
			<select name="Time2" class="time">
				<option value="시간 협의">시간 협의</option>
				<option value="1시">1시</option>
				<option value="2시">2시</option>
				<option value="3시">3시</option>
				<option value="4시" selected>4시</option>
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
			
			
			<label for="day">근무 요일</label>
			<br>
				<input type="radio" name="Selector" id="daysel" value="요일 지정"> 요일 지정 &nbsp;&nbsp;
				<input type="radio" name="Selector" id="daycon" value="요일 협의" checked> 요일 협의
				<br>
				<input type="checkbox" name="day1" id="mon" value="월"> 월
			&nbsp;
				<input type="checkbox" name="day2" id="tue" value="화"> 화
			&nbsp;
				<input type="checkbox" name="day3" id="wed" value="수"> 수
			&nbsp;
				<input type="checkbox" name="day4" id="thu" value="목"> 목
			&nbsp;
				<input type="checkbox" name="day5" id="fri" value="금"> 금
			&nbsp;
				<input type="checkbox" name="day6" id="sat" value="토"> 토
			&nbsp;
				<input type="checkbox" name="day7" id="sun" value="일"> 일
			
			<br>
			<label for="Period">근무 기간</label>
            <select name="Period">
				<option value="하루">하루</option>
                <option value="1주일 이하">1주일 이하</option>
				<option value="1주일~1개월">1주일~1개월</option>
				<option value="1개월~3개월">1개월~3개월</option>
				<option value="3개월~6개월">3개월~6개월</option>
				<option value="6개월~1년">6개월~1년</option>
				<option value="1년 이상">1년 이상</option>
				<option value="협의 가능">협의 가능</option>
            </select>
			
			<br>
			<label for="sex">성별</label>
            <select name="Sex">
				<option value="성별 무관" selected>성별 무관</option>
				<option value="여자만">여자만</option>
				<option value="남자만">남자만</option>
			</select>
			
			<br>
			<label for="age">연령</label>
    		<select name="Age">
				<option value="연령 무관" selected>연령 무관</option>
				<option value="16세~20세">16세~20세</option>
				<option value="20대">20대</option>
				<option value="30대">30대</option>
				<option value="40대">40대</option>
				<option value="50대">50대</option>
				<option value="60세 이상">60세 이상</option>
			</select>
			
			<br>
			<label for="Type">고용 형태</label>
            <select name="Type">
                <option value="알바">알바</option>
				<option value="정규직">정규직</option>
				<option value="계약직">계약직</option>
				<option value="파견직">파견직</option>
				<option value="인턴">인턴</option>
				<option value="프리랜서">프리랜서</option>
				<option value="연수생/교육생">연수생/교육생</option>
            </select>
			
		</div>
		
		<button onclick="applyFilters()" id="in">적용</button>
		</form>
	</div>	
</div>
</body>
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
</html>

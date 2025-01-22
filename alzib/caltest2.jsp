<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.Map, java.util.List, java.util.ArrayList, java.util.HashMap" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알바 시간표</title>
    <style>
        @charset "utf-8";
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        body {
            font-family: 'GmarketSansMedium';
            margin: 0 auto;
            padding-top: 20px;
        }

        .calendar {
            text-align: center;
            border-collapse: collapse;
            width: 1500px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .calendar tr, .calendar td {
            padding: 10px;
            height: 70px;
            border: 1px solid #ccc;
        }

        .calendar th {
            background-color: #CADCF4;
        }

        .calendar td {
            cursor: pointer;
            vertical-align: top;
            text-align: left;
        }

        button#prevMonthBtn {
            font-size: 15px; /* 버튼의 글꼴 크기 */
            padding: 8px 8px; /* 버튼의 안쪽 여백 */
            background-color: #689ADE; /* 버튼의 배경색 */
            color: #fff; /* 버튼의 텍스트 색상 */
            border: none; /* 버튼의 테두리 없음 */
            border-radius: 4px; /* 버튼의 테두리 모서리 둥글게 */
            cursor: pointer;
        }

        button#prevMonthBtn:hover {
            background-color: #ccc; /* 마우스 호버 시 버튼의 배경색 변경 */
        }

        #nextMonthBtn {
            font-size: 15px; /* 버튼의 글꼴 크기 */
            padding: 8px 8px; /* 버튼의 안쪽 여백 */
            background-color: #689ADE; /* 버튼의 배경색 */
            color: #fff; /* 버튼의 텍스트 색상 */
            border: none; /* 버튼의 테두리 없음 */
            border-radius: 4px; /* 버튼의 테두리 모서리 둥글게 */
            cursor: pointer;
        }

        button#prevMonthBtn:hover {
            background-color: #ccc; /* 마우스 호버 시 버튼의 배경색 변경 */
        }

        #currentMonth {
            margin: 30px;
        }

        button {
            font-size: 15px; /* 버튼의 글꼴 크기 */
            padding: 8px 8px; /* 버튼의 안쪽 여백 */
            background-color: #689ADE; /* 버튼의 배경색 */
            color: #fff; /* 버튼의 텍스트 색상 */
            border: none; /* 버튼의 테두리 없음 */
            border-radius: 4px; /* 버튼의 테두리 모서리 둥글게 */
            cursor: pointer;
        }

        button:hover {
            background-color: #ccc; /* 마우스 호버 시 버튼의 배경색 변경 */
        }

        #button {
            margin: 0 auto;
            text-align: center;
            padding-top: 20px;
        }

        a {
            text-decoration: none;
            color: #fff;
        }
		.calendar td {
    cursor: pointer;
    vertical-align: top;
    text-align: left;
    width: 100px; /* 일정이 표시되는 셀의 너비를 조절합니다. */
    white-space: nowrap; /* 텍스트가 너무 길 경우 줄바꿈을 방지합니다. */
    overflow: hidden; /* 너무 긴 텍스트를 숨깁니다. */
    text-overflow: ellipsis; /* 너무 긴 텍스트를 자를 때 생략 부호를 표시합니다. */
}
    </style>
</head>
<body>

<%
// 현재 날짜 가져오기
java.util.Calendar cal = java.util.Calendar.getInstance();
int currentMonth = cal.get(java.util.Calendar.MONTH);
int currentYear = cal.get(java.util.Calendar.YEAR);

// 월 변경 버튼 처리
String action = request.getParameter("action");
if (action != null) {
    if (action.equals("prev")) {
        cal.add(java.util.Calendar.MONTH, -1);
    } else if (action.equals("next")) {
        cal.add(java.util.Calendar.MONTH, 1);
    }
    currentMonth = cal.get(java.util.Calendar.MONTH); // 변경된 월 다시 설정
    currentYear = cal.get(java.util.Calendar.YEAR); // 변경된 년도 다시 설정
}

String CId = (String) session.getAttribute("sid");
int hourly = 0;

// 데이터베이스 연결 정보
String DB_URL = "jdbc:mysql://localhost:3306/alzib";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

Map<String, List<String[]>> scheduleMap = new HashMap<>(); // 일정을 저장할 Map 객체 생성

try {
    // 데이터베이스 연결
    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
    
    // SQL 쿼리 실행하여 데이터베이스에서 일정 불러오기
    String query = "SELECT CTime, CSchedule, CCalendar FROM Calendar WHERE YEAR(CCalendar) = ? AND MONTH(CCalendar) = ? AND CId = ?";
    pstmt = conn.prepareStatement(query);
    pstmt.setInt(1, currentYear);
    pstmt.setInt(2, currentMonth + 1);
	pstmt.setString(3, CId);
    rs = pstmt.executeQuery();
    
    // 결과 처리
    while (rs.next()) {
        String date = rs.getString("CCalendar");
        String time = rs.getString("CTime");
        String schedule = rs.getString("CSchedule");
        String[] event = {time, schedule};

		hourly += Integer.parseInt(time);
        
        // Map에 해당 날짜의 일정 추가
        if (!scheduleMap.containsKey(date)) {
            scheduleMap.put(date, new ArrayList<>());
        }
        scheduleMap.get(date).add(event);
        
        // 추가된 일정 정보 출력
      // out.println("날짜: " + date + ", 시간: " + time + ", 일정: " + schedule + "<br>");
    }
    
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // 리소스 해제
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>

<%
int Hourlywage = hourly * 9860;
%>

<h2>알바 시간표</h2>

<table class="calendar">
    <thead>
        <tr>
            <th colspan="7">
                <a href="?action=prev">&lt;</a>
                <%= new java.text.SimpleDateFormat("MMMM yyyy").format(cal.getTime()) %>
                <a href="?action=next">&gt;</a>
            </th>
        </tr>
        <tr>
            <th>일</th>
            <th>월</th>
            <th>화</th>
            <th>수</th>
            <th>목</th>
            <th>금</th>
            <th>토</th>
        </tr>
    </thead>
    <tbody>
        <% 
        // 첫째 날의 요일
        cal.set(currentYear, currentMonth, 1);
        int firstDayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
        
        // 이전 달 마지막 날짜
        cal.add(java.util.Calendar.MONTH, -1);
        int lastDayOfPrevMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
        
        // 이번 달 마지막 날짜
        cal.add(java.util.Calendar.MONTH, 1);
        int lastDayOfMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
        
        // 날짜 표시
        int dayCount = 1;
        for (int i = 0; i < 6; i++) {
            out.print("<tr>");
            for (int j = 1; j <= 7; j++) {
                if ((i == 0 && j < firstDayOfWeek) || dayCount > lastDayOfMonth) {
                    // 이전 달의 일 또는 다음 달의 일
                    int day = (j <= firstDayOfWeek) ? (lastDayOfPrevMonth - firstDayOfWeek + j + 1) : (dayCount - lastDayOfMonth);
                    out.print("<td style='color: gray;'>" + day + "</td>");
                } else {
                    // 이번 달의 일
                    String date = String.format("%d.%02d.%02d", currentYear, currentMonth + 1, dayCount);
                    out.print("<td id='" + date + "' onclick=\"showEventForm('" + date + "')\">" + dayCount + "<br>");
                    
                    // 해당 날짜에 일정이 있으면 출력
                    if (scheduleMap.containsKey(date)) {
                        List<String[]> events = scheduleMap.get(date);
                        for (String[] event : events) {
                            out.print(event[0] + "시간" + " " + event[1] + "<br>");
                        }
                    }
                    
                    out.println("</td>");
                    dayCount++;
                }
            }
            out.print("</tr>");
            if (dayCount > lastDayOfMonth) break;
        }
        %>
    </tbody>
</table>

<div id="eventForm" style="display: none;">
    <h3>근무일 추가</h3>
    <form action="CalendarResult.jsp" method="post">
        <label for="cTime">시간:</label>
        <select name="cTime">
<option value="1">1시간</option>
<option value="2">2시간</option>
<option value="3">3시간</option>
<option value="4">4시간</option> 
<option value="5">5시간</option>
<option value="6">6시간</option>
<option value="7">7시간</option>
<option value="8">8시간</option>
<option value="9">9시간</option>
<option value="10">10시간</option>
<option value="11">11시간</option>
<option value="12">12시간</option>
<option value="13">13시간</option>
<option value="14">14시간</option>
<option value="15">15시간</option>
<option value="16">16시간</option>
<option value="17">17시간</option>
<option value="18">18시간</option>
<option value="19">19시간</option>
<option value="20">20시간</option>
<option value="21">21시간</option>
<option value="22">22시간</option>
<option value="23">23시간</option>
<option value="24">24시간</option>     
</select><br><br>
        <label for="cSchedule">근무지:</label>
        <input type="text" id="cSchedule" name="cSchedule" required><br><br>
        <input type="hidden" id="selectedDate" name="selectedDate">
        <input type="submit" value="등록"><br><br>
    </form>
</div>
<center>
<br><br>
<button onclick="showSalary()">급여 확인</button>
</center>
<div id="salaryInfo" style="display: none;">

	<p>ex)A지점</p>
    <p>시급: 9860원</p>
    <p>총 근무시간: <%= hourly %></p>
    <p>약 <%= Hourlywage %>원</p>
<br>
	<p>ex)B지점</p>
    <p>시급: 9860원</p>
    <p>총 근무시간: <%= hourly %></p>
    <p>약 <%= Hourlywage %>원</p>
</div>


<script>
    function showEventForm(date) {
        document.getElementById('selectedDate').value = date;
        document.getElementById('eventForm').style.display = 'block';
    }

	function showSalary() {
        var salaryDiv = document.getElementById("salaryInfo");
        salaryDiv.style.display = "block";
    }

</script>

</body>
</html>

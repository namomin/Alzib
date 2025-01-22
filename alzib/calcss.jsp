<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.Map, java.util.List, java.util.ArrayList, java.util.HashMap" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알바 시간표</title>
	<link href="cal.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	String myid = (String) session.getAttribute("sid");
    if (myid == null) {
        response.sendRedirect("login.jsp");
    }

    java.util.Calendar cal = java.util.Calendar.getInstance();
    int currentMonth = cal.get(java.util.Calendar.MONTH);
    int currentYear = cal.get(java.util.Calendar.YEAR);

    String action = request.getParameter("action");
    if (action != null) {
        if (action.equals("prev")) {
            cal.add(java.util.Calendar.MONTH, -1);
        } else if (action.equals("next")) {
            cal.add(java.util.Calendar.MONTH, 0);
        }
        currentMonth = cal.get(java.util.Calendar.MONTH); 
        currentYear = cal.get(java.util.Calendar.YEAR); 
    }


	String CId = (String) session.getAttribute("sid");


    int hourly = 0;

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Map<String, List<String[]>> scheduleMap = new HashMap<>();

    try {
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        String query = "SELECT CTime, CSchedule, CCalendar FROM Calendar WHERE YEAR(CCalendar) = ? AND MONTH(CCalendar) = ? AND CId = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, currentYear);
        pstmt.setInt(2, currentMonth + 1);
        pstmt.setString(3, CId);
        rs = pstmt.executeQuery();
        
        while (rs.next()) {
            String date = rs.getString("CCalendar");
            String time = rs.getString("CTime");
            String schedule = rs.getString("CSchedule");
            String[] event = {time, schedule};

            hourly += Integer.parseInt(time);
            
            if (!scheduleMap.containsKey(date)) {
                scheduleMap.put(date, new ArrayList<>());
            }
            scheduleMap.get(date).add(event);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    int Hourlywage = hourly * 9860; 
%>

<h2 align="center" style="margin-bottom: 40px;">알바 시간표</h2>

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
        cal.set(currentYear, currentMonth, 1);
        int firstDayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
        
        cal.add(java.util.Calendar.MONTH, -1);
        int lastDayOfPrevMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
        
        cal.add(java.util.Calendar.MONTH, 1);
        int lastDayOfMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
        
        int dayCount = 1;
        for (int i = 0; i < 6; i++) {
    out.print("<tr>");
    for (int j = 1; j <= 7; j++) {
        if ((i == 0 && j < firstDayOfWeek) || dayCount > lastDayOfMonth) {
            int day = (j <= firstDayOfWeek) ? (lastDayOfPrevMonth - firstDayOfWeek + j + 1) : (dayCount - lastDayOfMonth);
            out.print("<td style='color: gray;'>" + day + "</td>");
        } else {
            String date = String.format("%d.%02d.%02d", currentYear, currentMonth + 1, dayCount);
            out.print("<td id='" + date + "' onclick=\"toggleDateSelection(this, '" + date + "')\">" + dayCount + "<br>");
            
            if (scheduleMap.containsKey(date)) {
                List<String[]> events = scheduleMap.get(date);
                for (String[] event : events) {
                    // event[1]이 근무지의 이름이라고 가정하고, 해당 근무지의 색상을 데이터베이스에서 가져옵니다.
                    String placeName = event[1];
                    String backgroundColor = ""; // 근무지의 색상을 저장할 변수
                    try {
                        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
                        String colorQuery = "SELECT CColor FROM CPlace WHERE CName = ?";
                        pstmt = conn.prepareStatement(colorQuery);
                        pstmt.setString(1, placeName);
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            backgroundColor = rs.getString("CColor");
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
                    
                    // 배경색을 적용한 스케줄을 출력합니다.
                    out.print("<span style='background-color: " + backgroundColor + ";'>" + placeName + " " + event[0] + "시간</span><br>");
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

<center>
    <br><br>
	<button onclick="showPlace()">근무지 추가/삭제</button>
	<button onclick="showEventForm()">일정 추가/삭제</button>
	<button onclick="showBulkEventForm()">일괄 근무일 추가</button>
    <button onclick="showSalary()">급여 확인</button>
</center>

<div id="eventForm" style="display: none;" class="form">
	<div id="placeForm1" style="height: 250px;">
    <h2>근무일 추가</h2>
    <form action="CalendarResult.jsp" method="post">
        <label for="cTime">근무한 시간:</label>
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
        <label for="cSchedule">근무한 근무지:</label>
		<select id="cSchedule" name="cSchedule">
			<%
            try {
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace 테이블에서 현재 세션의 CId와 일치하는 레코드를 조회합니다.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // 선택 목록에 근무지를 동적으로 추가합니다.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
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
		</select><br><br>
        <input type="hidden" id="selectedDate" name="selectedDate">
		<input type="submit" value="등록"><br><br>
    </form>
	</div>
	
	<div id="placeForm2" style="height: 250px;">
	 <h2>근무일 일정 삭제</h2>
        <form action="CalendarDelete.jsp" method="post">
            <label for="deleteC">삭제할 일정 선택:</label>
            <select id="deleteC" name="deleteC">
                <!-- 여기에 근무지 목록을 동적으로 추가해야 함 -->
				<%
            try {
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace 테이블에서 현재 세션의 CId와 일치하는 레코드를 조회합니다.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // 선택 목록에 근무지를 동적으로 추가합니다.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
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
            </select><br><br>
			<div><font color="gray">선택한 날짜의 근무지 일정을 삭제할 수 있습니다.</font></div>
			<input type="hidden" id="selectedDate2" name="selectedDate2">
			<br>
            <input type="submit" value="삭제">
        </form>
		</div>
</div>


    <div id="bulkForm" style="display: none;" class="form">
        <h3>일괄 근무일 추가</h3>
		<form action="CalendarsResult1.jsp" method="post">
        <label for="bulkCTime">근무한 시간:</label>
        <select id="bulkCTime" name="bulkCTime">
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
        <label for="bulkCSchedule">근무한 근무지:</label>
		<select id="bulkCSchedule" name="bulkCSchedule">
			<%
            try {
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace 테이블에서 현재 세션의 CId와 일치하는 레코드를 조회합니다.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // 선택 목록에 근무지를 동적으로 추가합니다.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
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
		</select><br><br>
        <label for="bulkSelectedDays">요일: </label>
        <input type="checkbox" id="monday" name="bulkSelectedDays1" value="월">
        <label for="monday">월</label>
        <input type="checkbox" id="tuesday" name="bulkSelectedDays2" value="화">
        <label for="tuesday">화</label>
        <input type="checkbox" id="wednesday" name="bulkSelectedDays3" value="수">
        <label for="wednesday">수</label>
        <input type="checkbox" id="thursday" name="bulkSelectedDays4" value="목">
        <label for="thursday">목</label>
        <input type="checkbox" id="friday" name="bulkSelectedDays5" value="금">
        <label for="friday">금</label>
        <input type="checkbox" id="saturday" name="bulkSelectedDays6" value="토">
        <label for="saturday">토</label>
        <input type="checkbox" id="sunday" name="bulkSelectedDays7" value="일">
        <label for="sunday">일</label><br><br>
        <input type="submit" value="등록">
		</form>
    </div>
	<div id="placeForm" style="display: none;" class="form">
	<div id="placeForm1">
        <h2>근무지 추가</h2>
        <form action="CalplaceResult.jsp" method="post">
            <label for="cname">근무지 이름:</label>
            <input type="text" id="cname" name="cname" required><br><br>

            <label for="cpay">시급:</label>
            <input type="number" id="cpay" name="cpay" required><br><br>

            <label for="csalary">급여 종류:</label>
            <select id="csalary" name="csalary">
                <option value="일급">일급</option>
                <option value="주급">주급</option>
                <option value="월급">월급</option>
            </select><br><br>

            <label for="ccolor">글자 색상:</label>
            <select id="ccolor" name="ccolor">
                <option value="Yellow">노란색</option>
                <option value="Green">초록색</option>
                <option value="Blue">파란색</option>
                <option value="Red">빨간색</option>
				<option value="orange">주황색</option>
            </select><br><br>

            <input type="submit" value="추가">
        </form>
		</div>
		<div id="placeForm2">
        <h2>근무지 삭제</h2>
        <form action="CalplaceDelete.jsp" method="post">
            <label for="deleteP">근무지 선택:</label>
            <select id="deleteP" name="deleteP">
                <!-- 여기에 근무지 목록을 동적으로 추가해야 함 -->
				<%
            try {

				request.setCharacterEncoding("UTF-8");
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace 테이블에서 현재 세션의 CId와 일치하는 레코드를 조회합니다.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // 선택 목록에 근무지를 동적으로 추가합니다.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
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
            </select><br><br>
			<div><font color="red">※근무지를 삭제하면 해당 근무지 일정도 삭제 됩니다※</font></div>
            <input type="submit" value="삭제">
        </form>
		</div>
    </div>

<div id="salaryInfo" style="display: none;" class="form">

<%
try {
    String months = "2024.04%";
    request.setCharacterEncoding("UTF-8");
    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // CPlace 테이블에서 현재 세션의 CId와 일치하는 레코드를 조회합니다.
    String placeQuery = "SELECT * FROM CPlace WHERE CId = ?";
    pstmt = conn.prepareStatement(placeQuery);
    pstmt.setString(1, CId);
    rs = pstmt.executeQuery();

    // 선택 목록에 근무지를 동적으로 추가합니다.
    while (rs.next()) {
        String CName = rs.getString("CName");
        String CSalary = rs.getString("CSalary");
        String CPay = rs.getString("CPay");

        if (CSalary.equals("월급")) {
            // 월급인 경우에 대한 처리
            String calendarQuery = "SELECT CTime, CSchedule, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND CCalendar like ?";
            pstmt = conn.prepareStatement(calendarQuery);
            pstmt.setString(1, CId);
            pstmt.setString(2, CName);
            pstmt.setString(3, months);
            ResultSet calendarRs = pstmt.executeQuery();

            int totalHours = 0;
            int monthlySalary = 0;

			while (calendarRs.next()) {
		    int CTime = calendarRs.getInt("CTime");
		    totalHours += CTime;
		    monthlySalary += (CTime * Integer.parseInt(CPay));
		}

            // 전체 월별 총 근무시간과 전체 월급을 먼저 계산 및 출력
%>
<div id="salaryInfo1" style="border-bottom: 1px solid #ccc; padding: 10px; ">
	<div id="salaryInfo2">
    <h3><%= CName %> 근무지 <%= CSalary %> 내역</h3>
    <p>
        4월 <%= CName %>에서 총 <%= totalHours %>시간 근무<br>
        전체 월급: <%= monthlySalary %>원
    </p>
    <p>근무내역:</p>
    <ul>
        <% 
		ResultSet calendarRs2 = pstmt.executeQuery();
		while (calendarRs2.next()) { %>
            <li><%= calendarRs2.getString("CCalendar") %>에 <%= CName %>에서 총 <%= calendarRs2.getInt("CTime") %>시간 근무 급여: <%= (calendarRs2.getInt("CTime") * Integer.parseInt(CPay)) %>원</li>
        <% } %>
    </ul>
	</div>
</div>
<%
            calendarRs2.close();
        }
        else if (CSalary.equals("주급")) {
            // 주급인 경우에 대한 처리
            // 예시로 주급 처리 부분을 작성하였으나 실제로 데이터를 처리할 코드로 변경해야 합니다.
            String calendarQuery1 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
            pstmt = conn.prepareStatement(calendarQuery1);
            pstmt.setString(1, CId);
            pstmt.setString(2, CName);
            pstmt.setString(3, "2024.04.01");
            pstmt.setString(4, "2024.04.07");
            ResultSet calendarRs = pstmt.executeQuery();

            int totalHours1 = 0;
            int monthlySalary1 = 0;

            // 전체 월별 총 근무시간과 전체 월급을 먼저 계산 및 출력
			while (calendarRs.next()) {
		    int CTime = calendarRs.getInt("CTime");
		    totalHours1 += CTime;
		    monthlySalary1 += (CTime * Integer.parseInt(CPay));
		}
%>
<div id="salaryInfo1" style="border-bottom: 1px solid #ccc; padding: 10px;">
	<div id="salaryInfo2">
    <h3><%= CName %> 근무지 <%= CSalary %> 내역</h3>
    <p>
        4월1일~4월7일에 <%= CName %>에서 총 <%= totalHours1 %>시간 근무
        주급: <%= monthlySalary1 %>원<br>
    </p>

<%
            calendarRs.close();

		String calendarQuery2 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
		pstmt = conn.prepareStatement(calendarQuery2);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, "2024.04.08");
		pstmt.setString(4, "2024.04.14");
		ResultSet calendarRs2 = pstmt.executeQuery();

		int totalHours2 = 0;
		int monthlySalary2 = 0;

		while (calendarRs2.next()) {
		    int CTime = calendarRs2.getInt("CTime");
		    totalHours2 += CTime;
		    monthlySalary2 += (CTime * Integer.parseInt(CPay));
		}
%>

    <p>
        4월8일~4월14일에 <%= CName %>에서 총 <%= totalHours2 %>시간 근무
        주급: <%= monthlySalary2 %>원<br>
    </p>

<%
		calendarRs2.close();

		String calendarQuery3 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
		pstmt = conn.prepareStatement(calendarQuery3);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, "2024.04.15");
		pstmt.setString(4, "2024.04.21");
		ResultSet calendarRs3 = pstmt.executeQuery();

		int totalHours3 = 0;
		int monthlySalary3 = 0;

		while (calendarRs3.next()) {
		    int CTime = calendarRs3.getInt("CTime");
		    totalHours3 += CTime;
		    monthlySalary3 += (CTime * Integer.parseInt(CPay));
		}
%>

    <p>
        4월15일~4월21일에 <%= CName %>에서 총 <%= totalHours3 %>시간 근무
        주급: <%= monthlySalary3 %>원<br>
    </p>

<%
		calendarRs3.close();

		String calendarQuery4 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
		pstmt = conn.prepareStatement(calendarQuery4);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, "2024.04.22");
		pstmt.setString(4, "2024.04.28");
		ResultSet calendarRs4 = pstmt.executeQuery();

		int totalHours4 = 0;
		int monthlySalary4 = 0;

		while (calendarRs4.next()) {
		    int CTime = calendarRs4.getInt("CTime");
		    totalHours4 += CTime;
		    monthlySalary4 += (CTime * Integer.parseInt(CPay));
		}
%>

    <p>
        4월22일~4월28일에 <%= CName %>에서 총 <%= totalHours4 %>시간 근무
        주급: <%= monthlySalary4 %>원<br>
    </p>

<%
		calendarRs4.close();

		String calendarQuery5 = "SELECT CTime, CSchedule, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND CCalendar like ?";
		pstmt = conn.prepareStatement(calendarQuery5);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, months);
		ResultSet calendarRs5 = pstmt.executeQuery();
            // 전체 월별 총 근무시간과 전체 월급을 먼저 계산 및 출력
%>

    <p>근무내역:</p>
    <ul>
        <% while (calendarRs5.next()) { %>
            <li><%= calendarRs5.getString("CCalendar") %>에 <%= CName %>에서 총 <%= calendarRs5.getInt("CTime") %>시간 근무급여: <%= (calendarRs5.getInt("CTime") * Integer.parseInt(CPay)) %>원</li>
        <% } %>
    </ul>
	</div>
</div>
<%
		calendarRs5.close();
        }
        else {
            // 월급, 주급이 아닌 경우에 대한 처리
            // 예시로 처리 부분을 작성하였으나 실제로 데이터를 처리할 코드로 변경해야 합니다.
            String calendarQuery = "SELECT CTime, CSchedule, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND CCalendar like ?";
            pstmt = conn.prepareStatement(calendarQuery);
            pstmt.setString(1, CId);
            pstmt.setString(2, CName);
            pstmt.setString(3, months);
            ResultSet calendarRs = pstmt.executeQuery();
%>
<div id="salaryInfo1" style="border-bottom: 1px solid #ccc; padding: 10px;">
	<div id="salaryInfo2">
    <h3><%= CName %> 근무지 <%= CSalary %> 내역</h3>
    <p>근무내역:</p>
    <ul>
        <% while (calendarRs.next()) { %>
            <li><%= calendarRs.getString("CCalendar") %>에 <%= CName %>에서 총 <%= calendarRs.getInt("CTime") %>시간 근무 일급: <%= (calendarRs.getInt("CTime") * Integer.parseInt(CPay)) %>원</li>
        <% } %>
    </ul>
	</div>
</div>
<%
        }
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

</div>

<script>
    var selectedDate = null; // 선택된 날짜를 저장하기 위한 변수
    var selectedDateElement = null; // 이전에 선택된 날짜의 엘리먼트를 저장하기 위한 변수

    function selectDate(dateElement, date) {
        // 선택된 날짜를 업데이트하고 표시를 변경
        if (selectedDateElement !== null) {
            // 이전에 선택된 날짜의 표시를 원래대로 돌림
            selectedDateElement.style.backgroundColor = '';
        }

        selectedDateElement = dateElement;
        selectedDate = date;
        selectedDateElement.style.backgroundColor = 'yellow'; // 선택된 날짜를 노란색으로 표시
    }

    function toggleDateSelection(dateElement, date) {
        // 날짜 선택 상태를 토글하고 표시를 변경
        if (selectedDateElement === dateElement) {
            // 이전에 선택된 날짜를 다시 클릭했을 때 선택 해제
            selectedDateElement.style.backgroundColor = '';
            selectedDateElement = null;
            selectedDate = null;
        } else {
            // 다른 날짜를 클릭했을 때 선택 상태 변경
            selectDate(dateElement, date);
        }
    }
        
    function bulkRegister() {
        var selectedDays = document.getElementById('bulkSelectedDays').value.split(',');
        var time = document.getElementById('bulkCTime').value;
        var schedule = document.getElementById('bulkCSchedule').value;

        var result = "입력한 내용:<br>";
        for (var i = 0; i < selectedDays.length; i++) {
            result += selectedDays[i] + ": " + time + "시간 " + schedule + "<br>";
        }
        
        document.getElementById('bulkForm').innerHTML = result;
    }

	function showPlace() {
        hideAllForms();
        var placeDiv = document.getElementById("placeForm");
        placeDiv.style.display = "block";
    }

    function showEventForm() {
        hideAllForms();
        if (selectedDate) {
            document.getElementById('selectedDate').value = selectedDate;
			document.getElementById('selectedDate2').value = selectedDate;
            var eventForm = document.getElementById('eventForm');
            eventForm.style.display = 'block';
        } else {
            alert('날짜를 선택하세요.');
        }
    }

    function showBulkEventForm() {
        hideAllForms();
        var bulkForm = document.getElementById("bulkForm");
        bulkForm.style.display = "block";
    }

    function showSalary() {
        hideAllForms();
        var salaryDiv = document.getElementById("salaryInfo");
        salaryDiv.style.display = "block";
    }

    function hideAllForms() {
        var forms = document.getElementsByClassName("form");
        for (var i = 0; i < forms.length; i++) {
            forms[i].style.display = "none";
        }
    }
</script>

</body>

</html>

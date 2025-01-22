<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*, java.util.Map, java.util.List, java.util.ArrayList, java.util.HashMap" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>�ٹ��ð�ǥ</title>
	<link href="cal.css" rel="stylesheet" type="text/css">
	<style>
		.nav{
			text-align: left;
			margin-left: 15%;
			width: 20%;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
			margin-bottom: 30px;
		}

		.nav a{
			color: #689ADE;
			text-decoration: none;
		}

		.nav a:hover{
			color:#CADCF4;
		}

		.title{
			margin-left: 15%;
			width: 70%;
		}
</style>
<script>
	window.addEventListener('DOMContentLoaded', (event) => {
        // �������� �ε�Ǹ� showSalary �Լ��� ȣ���մϴ�.
        showSalary();
    });
</script>
</head>
<body>
<%
	String myid = (String) session.getAttribute("sid");
    if (myid == null) {
        response.sendRedirect("login.jsp");
    }

	DecimalFormat formatter = new DecimalFormat("#,###");

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
<div class="nav">
		<span><a href="main.jsp">Ȩ</a> > ���Ǳ�� > <a href="Calendar_alba.jsp">�ٹ� �ð�ǥ</a></span>
</div>
<h2 align="center" style="margin-bottom: 40px; margin-top: 0;">�ٹ��ð�ǥ</h2>

<table class="calendar">
    <thead>
        <tr>
            <th colspan="7">
                <h3><a href="?action=prev">&lt;</a>
                <%= new java.text.SimpleDateFormat("yyyy�� MMMM").format(cal.getTime()) %>
                <a href="?action=next">&gt;</a></h3>
            </th>
        </tr>
        <tr>
            <th>��</th>
            <th>��</th>
            <th>ȭ</th>
            <th>��</th>
            <th>��</th>
            <th>��</th>
            <th>��</th>
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
            out.print("<td style='color: white;'>" + day + "</td>");
        } else {
            String date = String.format("%d.%02d.%02d", currentYear, currentMonth + 1, dayCount);
            out.print("<td id='" + date + "' onclick=\"toggleDateSelection(this, '" + date + "')\">" + dayCount + "<br>");
            
            if (scheduleMap.containsKey(date)) {
                List<String[]> events = scheduleMap.get(date);
                for (String[] event : events) {
                    // event[1]�� �ٹ����� �̸��̶�� �����ϰ�, �ش� �ٹ����� ������ �����ͺ��̽����� �����ɴϴ�.
                    String placeName = event[1];
                    String backgroundColor = ""; // �ٹ����� ������ ������ ����
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
                        // ���ҽ� ����
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    
                    // ������ ������ �������� ����մϴ�.
                    out.print("<span style='background-color: " + backgroundColor + ";'>" + placeName + " " + event[0] + "�ð�</span><br>");
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
	<button onclick="showPlace()">�ٹ��� �߰�/����</button>
	<button onclick="showBulkEventForm()">�ϰ� �ٹ��� �߰�</button>
	<button onclick="showEventForm()">���� �߰�/����</button>
    <button onclick="showSalary()">�޿� Ȯ��</button>
</center>

<div id="eventForm" style="display: none;" class="form">
	<div id="placeForm1" style="height: 250px;">
    <h2>�ٹ��� �߰�</h2>
    <form action="CalendarResult.jsp" method="post">
        <label for="cTime">�ٹ��� �ð�:</label>
        <select name="cTime">
            <option value="1">1�ð�</option>
            <option value="2">2�ð�</option>
            <option value="3">3�ð�</option>
            <option value="4">4�ð�</option> 
            <option value="5">5�ð�</option>
            <option value="6">6�ð�</option>
            <option value="7">7�ð�</option>
            <option value="8">8�ð�</option>
            <option value="9">9�ð�</option>
            <option value="10">10�ð�</option>
            <option value="11">11�ð�</option>
            <option value="12">12�ð�</option>
            <option value="13">13�ð�</option>
            <option value="14">14�ð�</option>
            <option value="15">15�ð�</option>
            <option value="16">16�ð�</option>
            <option value="17">17�ð�</option>
            <option value="18">18�ð�</option>
            <option value="19">19�ð�</option>
            <option value="20">20�ð�</option>
            <option value="21">21�ð�</option>
            <option value="22">22�ð�</option>
            <option value="23">23�ð�</option>
            <option value="24">24�ð�</option> 
        </select><br><br>
        <label for="cSchedule">�ٹ��� �ٹ���:</label>
		<select id="cSchedule" name="cSchedule">
			<%
            try {
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace ���̺��� ���� ������ CId�� ��ġ�ϴ� ���ڵ带 ��ȸ�մϴ�.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // ���� ��Ͽ� �ٹ����� �������� �߰��մϴ�.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // ���ҽ� ����
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
		<input type="submit" value="���"><br><br>
    </form>
	</div>
	
	<div id="placeForm2" style="height: 250px;">
	 <h2>�ٹ��� ���� ����</h2>
        <form action="CalendarDelete.jsp" method="post">
            <label for="deleteC">������ ���� ����:</label>
            <select id="deleteC" name="deleteC">
                <!-- ���⿡ �ٹ��� ����� �������� �߰��ؾ� �� -->
				<%
            try {
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace ���̺��� ���� ������ CId�� ��ġ�ϴ� ���ڵ带 ��ȸ�մϴ�.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // ���� ��Ͽ� �ٹ����� �������� �߰��մϴ�.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // ���ҽ� ����
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
			<div><font color="gray">������ ��¥�� �ٹ��� ������ ������ �� �ֽ��ϴ�.</font></div>
			<input type="hidden" id="selectedDate2" name="selectedDate2">
			<br>
            <input type="submit" value="����">
        </form>
		</div>
</div>


    <div id="bulkForm" style="display: none;" class="form">
        <h3>�ϰ� �ٹ��� �߰�</h3>
		<form action="CalendarsResult1.jsp" method="post">
        <label for="bulkCTime">�ٹ��� �ð�:</label>
        <select id="bulkCTime" name="bulkCTime">
            <option value="1">1�ð�</option>
            <option value="2">2�ð�</option>
            <option value="3">3�ð�</option>
            <option value="4">4�ð�</option> 
            <option value="5">5�ð�</option>
            <option value="6">6�ð�</option>
            <option value="7">7�ð�</option>
            <option value="8">8�ð�</option>
            <option value="9">9�ð�</option>
            <option value="10">10�ð�</option>
            <option value="11">11�ð�</option>
            <option value="12">12�ð�</option>
            <option value="13">13�ð�</option>
            <option value="14">14�ð�</option>
            <option value="15">15�ð�</option>
            <option value="16">16�ð�</option>
            <option value="17">17�ð�</option>
            <option value="18">18�ð�</option>
            <option value="19">19�ð�</option>
            <option value="20">20�ð�</option>
            <option value="21">21�ð�</option>
            <option value="22">22�ð�</option>
            <option value="23">23�ð�</option>
            <option value="24">24�ð�</option> 
        </select><br><br>
        <label for="bulkCSchedule">�ٹ��� �ٹ���:</label>
		<select id="bulkCSchedule" name="bulkCSchedule">
			<%
            try {
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace ���̺��� ���� ������ CId�� ��ġ�ϴ� ���ڵ带 ��ȸ�մϴ�.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // ���� ��Ͽ� �ٹ����� �������� �߰��մϴ�.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // ���ҽ� ����
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
        <label for="bulkSelectedDays">����: </label>
        <input type="checkbox" id="monday" name="bulkSelectedDays1" value="��">
        <label for="monday">��</label>
        <input type="checkbox" id="tuesday" name="bulkSelectedDays2" value="ȭ">
        <label for="tuesday">ȭ</label>
        <input type="checkbox" id="wednesday" name="bulkSelectedDays3" value="��">
        <label for="wednesday">��</label>
        <input type="checkbox" id="thursday" name="bulkSelectedDays4" value="��">
        <label for="thursday">��</label>
        <input type="checkbox" id="friday" name="bulkSelectedDays5" value="��">
        <label for="friday">��</label>
        <input type="checkbox" id="saturday" name="bulkSelectedDays6" value="��">
        <label for="saturday">��</label>
        <input type="checkbox" id="sunday" name="bulkSelectedDays7" value="��">
        <label for="sunday">��</label><br><br>
        <input type="submit" value="���">
		</form>
    </div>

	<div id="placeForm" style="display: none;" class="form">
	<div id="placeForm1" style="height: 350px;">
        <h2>�ٹ��� �߰�</h2>
        <form action="CalplaceResult.jsp" method="post">
            <label for="cname">�ٹ��� �̸�:</label>
            <input type="text" id="cname" name="cname" required><br><br>

            <label for="cpay">�ñ�:</label>
            <input type="number" id="cpay" name="cpay" required><br><br>

            <label for="csalary">�޿� ����:</label>
            <select id="csalary" name="csalary">
                <option value="�ϱ�">�ϱ�</option>
                <option value="�ֱ�">�ֱ�</option>
                <option value="����">����</option>
            </select><br><br>

            <label for="ccolor">���� ����:</label>
            <select id="ccolor" name="ccolor">
                <option value="Yellow">�����</option>
                <option value="Yellowgreen">�ʷϻ�</option>
                <option value="Skyblue">�Ķ���</option>
                <option value="Pink">��ȫ��</option>
				<option value="orange">��Ȳ��</option>
            </select><br><br>

            <input type="submit" value="�߰�">
        </form>
		</div>
		<div id="placeForm2">
        <h2>�ٹ��� ����</h2>
        <form action="CalplaceDelete.jsp" method="post">
            <label for="deleteP">�ٹ��� ����:</label>
            <select id="deleteP" name="deleteP">
                <!-- ���⿡ �ٹ��� ����� �������� �߰��ؾ� �� -->
				<%
            try {

				request.setCharacterEncoding("UTF-8");
                conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // CPlace ���̺��� ���� ������ CId�� ��ġ�ϴ� ���ڵ带 ��ȸ�մϴ�.
                String placeQuery = "SELECT CName FROM CPlace WHERE CId = ?";
                pstmt = conn.prepareStatement(placeQuery);
                pstmt.setString(1, CId);
                rs = pstmt.executeQuery();

                // ���� ��Ͽ� �ٹ����� �������� �߰��մϴ�.
                while (rs.next()) {
                    String placeName = rs.getString("CName");
        %>
                    <option value="<%= placeName %>"><%= placeName %></option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // ���ҽ� ����
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
			<div><font color="red">�رٹ����� �����ϸ� �ش� �ٹ��� ������ ���� �˴ϴ١�</font></div>
            <input type="submit" value="����">
        </form>
		</div>
    </div>

<div id="salaryInfo" style="display: none;" class="form">

<%
try {
    String months = "2024.06%";
    request.setCharacterEncoding("UTF-8");
    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // CPlace ���̺��� ���� ������ CId�� ��ġ�ϴ� ���ڵ带 ��ȸ�մϴ�.
    String placeQuery = "SELECT * FROM CPlace WHERE CId = ?";
    pstmt = conn.prepareStatement(placeQuery);
    pstmt.setString(1, CId);
    rs = pstmt.executeQuery();

    // ���� ��Ͽ� �ٹ����� �������� �߰��մϴ�.
    while (rs.next()) {
        String CName = rs.getString("CName");
        String CSalary = rs.getString("CSalary");
        String CPay = rs.getString("CPay");

        if (CSalary.equals("����")) {
            // ������ ��쿡 ���� ó��
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
		
		String Paymm1 = formatter.format(monthlySalary);
            // ��ü ���� �� �ٹ��ð��� ��ü ������ ���� ��� �� ���
%>
<div id="salaryInfo1" style="border-bottom: 1px solid #ccc; padding: 10px; ">
	<div id="salaryInfo2">
    <h3><%= CName %> �ٹ��� <%= CSalary %> ����</h3>
    <p>
        6�� <%= CName %>���� �� <%= totalHours %>�ð� �ٹ�<br>
        ��ü ����: <%= Paymm1 %>��
    </p>
    <p>�ٹ�����:</p>
    <ul>
        <% 
		ResultSet calendarRs2 = pstmt.executeQuery();
		while (calendarRs2.next()) { 
			int Paym2 = calendarRs2.getInt("CTime") * Integer.parseInt(CPay);
			String Paymm2 = formatter.format(Paym2);
			%>
            <li><%= calendarRs2.getString("CCalendar") %>�� <%= CName %>���� �� <%= calendarRs2.getInt("CTime") %>�ð� �ٹ� �޿�: <%= Paymm2 %>��</li>
        <% } %>
    </ul>
	</div>
</div>
<%
            calendarRs2.close();
        }
        else if (CSalary.equals("�ֱ�")) {
            // �ֱ��� ��쿡 ���� ó��
            // ���÷� �ֱ� ó�� �κ��� �ۼ��Ͽ����� ������ �����͸� ó���� �ڵ�� �����ؾ� �մϴ�.
            String calendarQuery1 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
            pstmt = conn.prepareStatement(calendarQuery1);
            pstmt.setString(1, CId);
            pstmt.setString(2, CName);
            pstmt.setString(3, "2024.06.03");
            pstmt.setString(4, "2024.06.09");
            ResultSet calendarRs = pstmt.executeQuery();

            int totalHours1 = 0;
            int monthlySalary1 = 0;

            // ��ü ���� �� �ٹ��ð��� ��ü ������ ���� ��� �� ���
			while (calendarRs.next()) {
		    int CTime = calendarRs.getInt("CTime");
		    totalHours1 += CTime;
		    monthlySalary1 += (CTime * Integer.parseInt(CPay));
		}
		String Payww1 = formatter.format(monthlySalary1);
%>
<div id="salaryInfo1" style="border-bottom: 1px solid #ccc; padding: 10px;">
	<div id="salaryInfo2">
    <h3><%= CName %> �ٹ��� <%= CSalary %> ����</h3>
    <p>
        6��3��~6��9�Ͽ� <%= CName %>���� �� <%= totalHours1 %>�ð� �ٹ�
        �ֱ�: <%= Payww1 %>��<br>
    </p>

<%
            calendarRs.close();

		String calendarQuery2 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
		pstmt = conn.prepareStatement(calendarQuery2);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, "2024.06.10");
		pstmt.setString(4, "2024.06.16");
		ResultSet calendarRs2 = pstmt.executeQuery();

		int totalHours2 = 0;
		int monthlySalary2 = 0;

		while (calendarRs2.next()) {
		    int CTime = calendarRs2.getInt("CTime");
		    totalHours2 += CTime;
		    monthlySalary2 += (CTime * Integer.parseInt(CPay));
		}
		String Payww2 = formatter.format(monthlySalary2);
%>

    <p>
        6��10��~6��16�Ͽ� <%= CName %>���� �� <%= totalHours2 %>�ð� �ٹ�
        �ֱ�: <%= Payww2 %>��<br>
    </p>

<%
		calendarRs2.close();

		String calendarQuery3 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
		pstmt = conn.prepareStatement(calendarQuery3);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, "2024.06.17");
		pstmt.setString(4, "2024.06.23");
		ResultSet calendarRs3 = pstmt.executeQuery();

		int totalHours3 = 0;
		int monthlySalary3 = 0;

		while (calendarRs3.next()) {
		    int CTime = calendarRs3.getInt("CTime");
		    totalHours3 += CTime;
		    monthlySalary3 += (CTime * Integer.parseInt(CPay));
		}
		String Payww3 = formatter.format(monthlySalary3);
%>

    <p>
        6��17��~6��23�Ͽ� <%= CName %>���� �� <%= totalHours3 %>�ð� �ٹ�
        �ֱ�: <%= Payww3 %>��<br>
    </p>

<%
		calendarRs3.close();

		String calendarQuery4 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
		pstmt = conn.prepareStatement(calendarQuery4);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, "2024.06.24");
		pstmt.setString(4, "2024.06.30");
		ResultSet calendarRs4 = pstmt.executeQuery();

		int totalHours4 = 0;
		int monthlySalary4 = 0;

		while (calendarRs4.next()) {
		    int CTime = calendarRs4.getInt("CTime");
		    totalHours4 += CTime;
		    monthlySalary4 += (CTime * Integer.parseInt(CPay));
		}
		String Payww4 = formatter.format(monthlySalary4);
%>

    <p>
        6��24��~6��30�Ͽ� <%= CName %>���� �� <%= totalHours4 %>�ð� �ٹ�
        �ֱ�: <%= Payww4 %>��<br>
    </p>

<%
		calendarRs4.close();

		//String calendarQuery6 = "SELECT CTime, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND //STR_TO_DATE(CCalendar, '%Y.%m.%d') BETWEEN ? AND ?";
		//pstmt = conn.prepareStatement(calendarQuery6);
		//pstmt.setString(1, CId);
		//pstmt.setString(2, CName);
		//pstmt.setString(3, "2024.05.27");
		//pstmt.setString(4, "2024.06.02");
		//ResultSet calendarRs6 = pstmt.executeQuery();

	//	int totalHours6 = 0;
	//	int monthlySalary6 = 0;

	//	while (calendarRs6.next()) {
	//	    int CTime = calendarRs6.getInt("CTime");
	//	    totalHours6 += CTime;
	//	    monthlySalary6 += (CTime * Integer.parseInt(CPay));
	//	}
	//	String Payww6 = formatter.format(monthlySalary6);
%>

  <%--  <p> --%>
  <%--      6��0��~6��0�Ͽ� <%= CName %>���� �� <%= totalHours6 %>�ð� �ٹ� --%>
  <%--      �ֱ�: <%= Payww6 %>��<br> --%>
  <%--  </p> --%>

<%
		//calendarRs6.close();

		String calendarQuery5 = "SELECT CTime, CSchedule, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND CCalendar like ?";
		pstmt = conn.prepareStatement(calendarQuery5);
		pstmt.setString(1, CId);
		pstmt.setString(2, CName);
		pstmt.setString(3, months);
		ResultSet calendarRs5 = pstmt.executeQuery();
            // ��ü ���� �� �ٹ��ð��� ��ü ������ ���� ��� �� ���
%>

    <p>�ٹ�����:</p>
    <ul>
        <% while (calendarRs5.next()) { 
		int Payw5 = calendarRs5.getInt("CTime") * Integer.parseInt(CPay);
		String Payww5 = formatter.format(Payw5);
		%>
            <li><%= calendarRs5.getString("CCalendar") %>�� <%= CName %>���� �� <%= calendarRs5.getInt("CTime") %>�ð� �ٹ��޿�: <%= Payww5 %>��</li>
        <% } %>
    </ul>
	</div>
</div>
<%
		calendarRs5.close();
        }
        else {
            // ����, �ֱ��� �ƴ� ��쿡 ���� ó��
            // ���÷� ó�� �κ��� �ۼ��Ͽ����� ������ �����͸� ó���� �ڵ�� �����ؾ� �մϴ�.
            String calendarQuery = "SELECT CTime, CSchedule, CCalendar FROM Calendar WHERE CId = ? AND CSchedule = ? AND CCalendar like ?";
            pstmt = conn.prepareStatement(calendarQuery);
            pstmt.setString(1, CId);
            pstmt.setString(2, CName);
            pstmt.setString(3, months);
            ResultSet calendarRs = pstmt.executeQuery();
%>
<div id="salaryInfo1" style="border-bottom: 1px solid #ccc; padding: 10px;">
	<div id="salaryInfo2">
    <h3><%= CName %> �ٹ��� <%= CSalary %> ����</h3>
    <p>�ٹ�����:</p>
    <ul>
        <% while (calendarRs.next()) { 
		int Payd = calendarRs.getInt("CTime") * Integer.parseInt(CPay);
		String Paydd = formatter.format(Payd);
		%>
            <li><%= calendarRs.getString("CCalendar") %>�� <%= CName %>���� �� <%= calendarRs.getInt("CTime") %>�ð� �ٹ� �ϱ�: <%= Paydd %>��</li>
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
    // ���ҽ� ����
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
    var selectedDate = null; // ���õ� ��¥�� �����ϱ� ���� ����
    var selectedDateElement = null; // ������ ���õ� ��¥�� ������Ʈ�� �����ϱ� ���� ����

    function selectDate(dateElement, date) {
        // ���õ� ��¥�� ������Ʈ�ϰ� ǥ�ø� ����
        if (selectedDateElement !== null) {
            // ������ ���õ� ��¥�� ǥ�ø� ������� ����
            selectedDateElement.style.backgroundColor = '';
        }

        selectedDateElement = dateElement;
        selectedDate = date;
        selectedDateElement.style.backgroundColor = '#eeeeee'; // ���õ� ��¥�� ��������� ǥ��
    }

    function toggleDateSelection(dateElement, date) {
        // ��¥ ���� ���¸� ����ϰ� ǥ�ø� ����
        if (selectedDateElement === dateElement) {
            // ������ ���õ� ��¥�� �ٽ� Ŭ������ �� ���� ����
            selectedDateElement.style.backgroundColor = '';
            selectedDateElement = null;
            selectedDate = null;
        } else {
            // �ٸ� ��¥�� Ŭ������ �� ���� ���� ����
            selectDate(dateElement, date);
        }
    }
        
    function bulkRegister() {
        var selectedDays = document.getElementById('bulkSelectedDays').value.split(',');
        var time = document.getElementById('bulkCTime').value;
        var schedule = document.getElementById('bulkCSchedule').value;

        var result = "�Է��� ����:<br>";
        for (var i = 0; i < selectedDays.length; i++) {
            result += selectedDays[i] + ": " + time + "�ð� " + schedule + "<br>";
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
            alert('��¥�� �����ϼ���.');
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

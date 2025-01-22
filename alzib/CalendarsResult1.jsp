<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calendar Result</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String bulkCTime = request.getParameter("bulkCTime");
    String bulkCSchedule = request.getParameter("bulkCSchedule");

    String[] selectedDays = new String[7];
    for (int i = 1; i <= 7; i++) {
        String checkboxName = "bulkSelectedDays" + i;
        String day = request.getParameter(checkboxName);
        if (day != null) {
            selectedDays[i - 1] = day;
        }
    }
    
    // 선택된 요일 출력
    //out.print("선택된 요일: ");
    for (String day : selectedDays) {
        if (day != null) {
            out.print(day + " ");
        }
    }
    //out.print("<br>");

    // 해당하는 요일에 대한 날짜 생성하여 Days 변수에 저장
    List<String> Days = new ArrayList<>();
    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.set(java.util.Calendar.YEAR, cal.get(java.util.Calendar.YEAR));
    cal.set(java.util.Calendar.MONTH, cal.get(java.util.Calendar.MONTH));
    cal.set(java.util.Calendar.DAY_OF_MONTH, 1); // 첫째 날로 설정

    for (int i = 1; i <= cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); i++) {
        int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK); // 현재 요일
        String dayOfWeekString = null;
        switch (dayOfWeek) {
            case java.util.Calendar.SUNDAY:
                dayOfWeekString = "일";
                break;
            case java.util.Calendar.MONDAY:
                dayOfWeekString = "월";
                break;
            case java.util.Calendar.TUESDAY:
                dayOfWeekString = "화"; 
                break;
            case java.util.Calendar.WEDNESDAY:
                dayOfWeekString = "수";
                break;
            case java.util.Calendar.THURSDAY:
                dayOfWeekString = "목";
                break;
            case java.util.Calendar.FRIDAY:
                dayOfWeekString = "금";
                break;
            case java.util.Calendar.SATURDAY:
                dayOfWeekString = "토";
                break;
        }

        // 선택된 요일만 고려하여 날짜를 추가
        if (isSelectedDay(selectedDays, dayOfWeekString)) {
            Days.add(cal.get(java.util.Calendar.YEAR) + "." + String.format("%02d", cal.get(java.util.Calendar.MONTH) + 1) + "." + String.format("%02d", i));
        }

        cal.add(java.util.Calendar.DATE, 1); // 다음 날짜로 이동
    }
    
    // Days 변수에 저장된 날짜 출력
    //out.print("해당하는 요일의 날짜: ");
    for (String day : Days) {
        out.print(day + " ");
    }
%>

<%!
    // 선택된 요일인지 확인하는 메서드
    boolean isSelectedDay(String[] selectedDays, String dayOfWeekString) {
        for (String day : selectedDays) {
            if (day != null && day.equals(dayOfWeekString)) {
                return true;
            }
        }
        return false;
    }
%>

<%-- 값을 CalendarResultv4.jsp로 전달하는 form --%>
<form id="autoSubmitForm" action="CalendarsResult2.jsp" method="post">
    <input type="hidden" name="bulkCTime" value="<%= bulkCTime %>">
    <input type="hidden" name="bulkCSchedule" value="<%= bulkCSchedule %>">
    <%-- Days 값을 콤마로 구분하여 전달 --%>
    <input type="hidden" name="Days" value="<%= String.join(",", Days) %>">
    <!-- 필요한 경우 추가적인 hidden input을 만들어서 값을 전달할 수 있습니다. -->
</form>

<%-- 자동으로 제출되도록 스크립트 추가 --%>
<script>
    document.getElementById('autoSubmitForm').submit();
</script>
<%=Days%>
</body>
</html>

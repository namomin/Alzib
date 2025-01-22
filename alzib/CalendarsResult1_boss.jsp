<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
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
	String cTimea1 = request.getParameter("cTimea1");
	String cTimea2 = request.getParameter("cTimea2");

    String[] selectedDays = new String[7];
    for (int i = 1; i <= 7; i++) {
        String checkboxName = "bulkSelectedDays" + i;
        String day = request.getParameter(checkboxName);
        if (day != null) {
            selectedDays[i - 1] = day;
        }
    }
    
    // ���õ� ���� ���
    //out.print("���õ� ����: ");
    for (String day : selectedDays) {
        if (day != null) {
            //out.print(day + " ");
        }
    }
    //out.print("<br>");

    // �ش��ϴ� ���Ͽ� ���� ��¥ �����Ͽ� Days ������ ����
    List<String> Days = new ArrayList<>();
    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.set(java.util.Calendar.YEAR, cal.get(java.util.Calendar.YEAR));
    cal.set(java.util.Calendar.MONTH, cal.get(java.util.Calendar.MONTH));
    cal.set(java.util.Calendar.DAY_OF_MONTH, 1); // ù° ���� ����

    for (int i = 1; i <= cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); i++) {
        int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK); // ���� ����
        String dayOfWeekString = null;
        switch (dayOfWeek) {
            case java.util.Calendar.SUNDAY:
                dayOfWeekString = "��";
                break;
            case java.util.Calendar.MONDAY:
                dayOfWeekString = "��";
                break;
            case java.util.Calendar.TUESDAY:
                dayOfWeekString = "ȭ"; 
                break;
            case java.util.Calendar.WEDNESDAY:
                dayOfWeekString = "��";
                break;
            case java.util.Calendar.THURSDAY:
                dayOfWeekString = "��";
                break;
            case java.util.Calendar.FRIDAY:
                dayOfWeekString = "��";
                break;
            case java.util.Calendar.SATURDAY:
                dayOfWeekString = "��";
                break;
        }

        // ���õ� ���ϸ� ����Ͽ� ��¥�� �߰�
        if (isSelectedDay(selectedDays, dayOfWeekString)) {
            Days.add(cal.get(java.util.Calendar.YEAR) + "." + String.format("%02d", cal.get(java.util.Calendar.MONTH) + 1) + "." + String.format("%02d", i));
        }

        cal.add(java.util.Calendar.DATE, 1); // ���� ��¥�� �̵�
    }
    
    // Days ������ ����� ��¥ ���
    //out.print("�ش��ϴ� ������ ��¥: ");
    for (String day : Days) {
        //out.print(day + " ");
    }
%>

<%!
    // ���õ� �������� Ȯ���ϴ� �޼���
    boolean isSelectedDay(String[] selectedDays, String dayOfWeekString) {
        for (String day : selectedDays) {
            if (day != null && day.equals(dayOfWeekString)) {
                return true;
            }
        }
        return false;
    }
%>

<%-- ���� CalendarResultv4.jsp�� �����ϴ� form --%>
<form id="autoSubmitForm" action="CalendarsResult2_boss.jsp" method="post">
    <input type="hidden" name="bulkCTime" value="<%= bulkCTime %>">
    <input type="hidden" name="bulkCSchedule" value="<%= bulkCSchedule %>">
	<input type="hidden" name="cTimea1" value="<%= cTimea1 %>">
	<input type="hidden" name="cTimea2" value="<%= cTimea2 %>">
    <%-- Days ���� �޸��� �����Ͽ� ���� --%>
    <input type="hidden" name="Days" value="<%= String.join(",", Days) %>">
    <!-- �ʿ��� ��� �߰����� hidden input�� ���� ���� ������ �� �ֽ��ϴ�. -->
</form>

<%-- �ڵ����� ����ǵ��� ��ũ��Ʈ �߰� --%>
<script>
    document.getElementById('autoSubmitForm').submit();
</script>
<%=Days%>
</body>
</html>

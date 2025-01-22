<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>채용</title>
<link href="applicant.css" rel="stylesheet" type="text/css">
<!--동일한 이력서를 채용할 경우 이미 채용되었단 스크립트를 띄우려했는데 동작안함ㅠoㅠ-->
<script>
function showAlert(message) {
    alert(message);
    window.history.back();
}
</script>
</head>
<body>
<%
try {
	String Title = request.getParameter("Title");
    String applyId = request.getParameter("applyId");
    String PostNum = request.getParameter("PostNum");
    String RId = request.getParameter("RId");
    String BId = request.getParameter("BId");

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // 이미 채용된 이력서인지 확인
    String checkEmployedQuery = "SELECT state FROM apply WHERE applyId = ?";
    PreparedStatement checkEmployedStmt = con.prepareStatement(checkEmployedQuery);
    checkEmployedStmt.setString(1, applyId);
    ResultSet employedRs = checkEmployedStmt.executeQuery();
    boolean isEmployed = false;
    if (employedRs.next()) {
        String state = employedRs.getString("state");
        if (state != null && state.equals("합격")) {
            isEmployed = true;
        }
    }
    employedRs.close();
    checkEmployedStmt.close();

    if (isEmployed) {
        // 이미 채용된 경우 경고 메시지 표시 후 이전 페이지로 되돌아감
        String message = "이미 채용된 이력서입니다.";
        out.println("<script>showAlert('" + message + "');</script>");
        con.close();
        response.sendRedirect("apply_resume.jsp?PostNum=" + PostNum + "&BId=" + BId);

    } else {
        // apply 테이블 업데이트
        String updateApplyQuery = "UPDATE apply SET state = '합격' WHERE applyId = ?";
        PreparedStatement updateApplyStmt = con.prepareStatement(updateApplyQuery);
        updateApplyStmt.setString(1, applyId);
        updateApplyStmt.executeUpdate();
        updateApplyStmt.close();

        // post 테이블에서 해당 게시물에 대한 BStore 정보 가져오기
        String selectBStoreQuery = "SELECT BStore FROM post WHERE PostNum = ?";
        PreparedStatement selectBStoreStmt = con.prepareStatement(selectBStoreQuery);
        selectBStoreStmt.setString(1, PostNum);
        ResultSet bStoreRs = selectBStoreStmt.executeQuery();
        String BStore = "";
        if (bStoreRs.next()) {
            BStore = bStoreRs.getString("BStore");
        }

        // resume 테이블에서 해당 RId에 대한 데이터 가져오기
        String selectResumeQuery = "SELECT AId, AName, HDay, HTime, HSalary FROM resume WHERE RId = ?";
        PreparedStatement selectResumeStmt = con.prepareStatement(selectResumeQuery);
        selectResumeStmt.setString(1, RId);
        ResultSet rs = selectResumeStmt.executeQuery();

        // employee 테이블에 데이터 삽입
        if (rs.next()) {
            String AId = rs.getString("AId");
            String AName = rs.getString("AName");
            String HDay = rs.getString("HDay");
            String HTime = rs.getString("HTime");
            String HSalary = rs.getString("HSalary");

            String state = "근무중";
            String insertEmployeeQuery = "INSERT INTO employee (RId, AName, HDay, HTime, HSalary, BId, state, AId, BStore) VALUES (?, ?, ?, ?, ?, ?, ?,? ,?)";
            PreparedStatement insertEmployeeStmt = con.prepareStatement(insertEmployeeQuery);
            insertEmployeeStmt.setString(1, RId);
            insertEmployeeStmt.setString(2, AName);
            insertEmployeeStmt.setString(3, HDay);
            insertEmployeeStmt.setString(4, HTime);
            insertEmployeeStmt.setString(5, HSalary);
            insertEmployeeStmt.setString(6, BId);
            insertEmployeeStmt.setString(7, state);
            insertEmployeeStmt.setString(8, AId);
            insertEmployeeStmt.setString(9, BStore);

            insertEmployeeStmt.executeUpdate();
        }

        rs.close();
        selectResumeStmt.close();
        con.close();

        response.sendRedirect("mypageBoss.jsp");
    }
} catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>

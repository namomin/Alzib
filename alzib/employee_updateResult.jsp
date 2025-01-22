<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String EId = request.getParameter("EId"); // EId 파라미터 추가
		String HDay = request.getParameter("HDay");
		String HTime = request.getParameter("HTime");
		String HSalary = request.getParameter("HSalary");

        String sql = "UPDATE employee SET HDay=?, HTime=?, HSalary=? WHERE EId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, HDay);
        pstmt.setString(2, HTime);
        pstmt.setString(3, HSalary);
        pstmt.setString(4, EId); // EId로 수정
		pstmt.executeUpdate();

		response.sendRedirect("mypageBoss.jsp");

    } catch(Exception e) {
		out.println(e);
}
%>	
</body>
</html>

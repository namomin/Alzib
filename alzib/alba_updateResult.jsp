<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>회원 정보 수정 완료</title>
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

        String myid = (String) session.getAttribute("sid");

        String AId = request.getParameter("AId");
		String AName = request.getParameter("AName");
		String ABirth = request.getParameter("ABirth");
		String APhone = request.getParameter("APhone");
		String AEmail = request.getParameter("AEmail");

        String sql = "UPDATE alba SET AName=?, ABirth=?, APhone=?, AEmail=? WHERE AId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, AName);
        pstmt.setString(2, ABirth);
        pstmt.setString(3, APhone);
        pstmt.setString(4, AEmail);
        pstmt.setString(5, myid);

		pstmt.executeUpdate();

		response.sendRedirect("mypageAlba.jsp");

    } catch(Exception e) {
		out.println(e);
}
%>	
</body>
</html>
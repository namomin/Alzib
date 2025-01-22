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

        String BId = request.getParameter("BId");
		String BName = request.getParameter("BName");
		String BPhone = request.getParameter("BPhone");
		String BEmail = request.getParameter("BEmail");
		String BBusiness = request.getParameter("BBusiness");
		String BStore = request.getParameter("BStore");
		String BAddress = request.getParameter("BAddress");

        String sql = "UPDATE boss SET BName=?, BPhone=?, BEmail=?, BBusiness=?, BStore=?, BAddress=? WHERE BId=?";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, BName);
        pstmt.setString(2, BPhone);
        pstmt.setString(3, BEmail);
        pstmt.setString(4, BBusiness);
		pstmt.setString(5, BStore);
		pstmt.setString(6, BAddress);
        pstmt.setString(7, myid);

		pstmt.executeUpdate();

		response.sendRedirect("mypageBoss.jsp");

    } catch(Exception e) {
		out.println(e);
}
%>	
</body>
</html>
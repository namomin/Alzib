<%@ page contentType = "text/html; charset=euc-kr"%>
<%@ page import = "java.sql.*"%>
<html><head><title>알바생 정보 삭제 완료</title></head>
<body>

<%
try {
 	 String DB_URL="jdbc:mysql://localhost:3306/alzib";
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
	 String key = request.getParameter("EId");
	 
     String jsql = "delete from employee where EId=?";        
	 PreparedStatement  pstmt = con.prepareStatement(jsql);
	 pstmt.setString(1, key);
	
 	 pstmt.executeUpdate();

 
	 response.sendRedirect("mypageBoss.jsp");


    } catch (Exception e) {
    	out.println(e);
}
%>
</body>
</html>
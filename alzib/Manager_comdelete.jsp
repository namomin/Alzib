<%@ page contentType = "text/html; charset=euc-kr"%>
<%@ page import = "java.sql.*"%>
<html><head><title>삭제 완료</title></head>
<body>

<%
try {
 	 String DB_URL="jdbc:mysql://localhost:3306/alzib";
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
	 String CId = request.getParameter("CId");
	 
     String jsql = "delete from comment where CId=?";        
	 PreparedStatement  pstmt = con.prepareStatement(jsql);
	 pstmt.setString(1, CId);
	
 	 pstmt.executeUpdate();

 
	 response.sendRedirect("Manager_comment.jsp");


    } catch (Exception e) {
    	out.println(e);
}
%>
</body>
</html>
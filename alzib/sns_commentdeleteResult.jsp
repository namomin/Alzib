<%@ page contentType = "text/html; charset=euc-kr"%>
<%@ page import = "java.sql.*"%>
<html><head><title>��� ���� �Ϸ�</title></head>
<body>

<%
try {
 	 String DB_URL="jdbc:mysql://localhost:3306/alzib";
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
	 String key = request.getParameter("CId");
	 
     String jsql = "delete from comment where CId=?";        
	 PreparedStatement  pstmt = con.prepareStatement(jsql);
	 pstmt.setString(1, key);
	
 	 pstmt.executeUpdate();
%>
 
 <jsp:forward page="sns_mycomment.jsp"/>

<%
    } catch (Exception e) {
    	out.println(e);
}
%>
</body>
</html>
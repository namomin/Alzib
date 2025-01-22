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
	
	 String BId = request.getParameter("BId");
	 
     String jsql1 = "delete from Boss where BId=?";        
	 PreparedStatement  pstmt1 = con.prepareStatement(jsql1);
	 pstmt1.setString(1, BId);
	
 	 pstmt1.executeUpdate();

	 String jsql2 = "delete from sns where SWId=?";        
	 PreparedStatement  pstmt2 = con.prepareStatement(jsql2);
	 pstmt2.setString(1, BId);
	
 	 pstmt2.executeUpdate();

	 String jsql3 = "delete from comment where CWId=?";        
	 PreparedStatement  pstmt3 = con.prepareStatement(jsql3);
	 pstmt3.setString(1, BId);
	
 	 pstmt3.executeUpdate();

	 String jsql4 = "delete from post where BId=?";        
	 PreparedStatement  pstmt4 = con.prepareStatement(jsql4);
	 pstmt4.setString(1, BId);
	
 	 pstmt4.executeUpdate();

	 String jsql5 = "delete from scrap where userId=?";        
     PreparedStatement pstmt5 = con.prepareStatement(jsql5);
     pstmt5.setString(1, BId);
    
     pstmt5.executeUpdate();

	 String jsql6 = "delete from calendar where CId=?";        
     PreparedStatement pstmt6 = con.prepareStatement(jsql6);
     pstmt6.setString(1, BId);
    
     pstmt6.executeUpdate();

	 String jsql7 = "delete from cplace where CId=?";        
     PreparedStatement pstmt7 = con.prepareStatement(jsql7);
     pstmt7.setString(1, BId);
     
     pstmt7.executeUpdate();
 
	 response.sendRedirect("Manager_Bmember.jsp");

    } catch (Exception e) {
    	out.println(e);
}
%>
</body>
</html>
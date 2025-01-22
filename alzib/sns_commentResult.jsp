<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>댓글 업로드</title>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

	String SId = request.getParameter("SId");
	String CWId = request.getParameter("CWId");
	String CText = request.getParameter("CText");

try {

 	 String DB_URL="jdbc:mysql://localhost:3306/alzib";  
     String DB_ID="multi";  
     String DB_PASSWORD="abcd"; 
 	 
	 Class.forName("org.gjt.mm.mysql.Driver"); 
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	 String jsql = "INSERT INTO comment (SId, CWId, CText) VALUES (?,?,?)";	

	 PreparedStatement pstmt  = con.prepareStatement(jsql);
	 pstmt.setString(1,SId);
	 pstmt.setString(2,CWId);
	 pstmt.setString(3,CText);

	 pstmt.executeUpdate();
%>

<jsp:forward page="sns_comment.jsp?SId=<%=SId%>"/>

<%
  } catch(Exception e) { 
		out.println(e);
}

%>

</body>
</html>

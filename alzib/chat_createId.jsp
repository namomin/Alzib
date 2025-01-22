<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>chatId 생성</title>
</head>
<body>
<%
    String BId = request.getParameter("BId");
    String AId = request.getParameter("AId");
    String chatId = null;
	String AName = request.getParameter("AName");
    
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        String insertQuery = "INSERT INTO chat (BId, AId) VALUES (?, ?)";
        PreparedStatement insertPstmt = con.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
        insertPstmt.setString(1, BId);
        insertPstmt.setString(2, AId);
        insertPstmt.executeUpdate();
        
        ResultSet generatedKeys = insertPstmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            chatId = generatedKeys.getString(1);
        }
        
        generatedKeys.close();
        insertPstmt.close();
        con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>

<%
    if (chatId != null) {
        response.sendRedirect("chat.jsp?BId=" + BId + "&AId=" + AId + "&chatId=" + chatId + "&AName=" + AName);
    } else {
    }
%>

</body>
</html>

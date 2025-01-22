<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
    String AId = request.getParameter("AId");
    String APasswd = request.getParameter("APasswd");
    String AName = request.getParameter("AName");
    String ABirth = request.getParameter("ABirth");
    String APhone = request.getParameter("APhone");
    String AEmail = request.getParameter("AEmail");
    
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";
    
    Connection con = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        String jsql = "INSERT INTO alba (AId, APasswd, AName, ABirth, APhone, AEmail) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, AId);
        pstmt.setString(2, APasswd);
        pstmt.setString(3, AName);
        pstmt.setString(4, ABirth);
        pstmt.setString(5, APhone);
        pstmt.setString(6, AEmail);

        pstmt.executeUpdate();
        %>
        <script>alert("회원가입이 완료되었습니다.");</script>
        <%
			response.sendRedirect("index.html");
    } catch (Exception e) {
        e.printStackTrace();
        %>
        <script>alert("회원가입에 실패했습니다. 다시 시도해주세요.");</script>
        <%
			response.sendRedirect("alba_update.jsp");
    } finally {
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
    String bId = request.getParameter("BId");
    String bPasswd = request.getParameter("BPasswd");
    String bName = request.getParameter("BName");
    String bPhone = request.getParameter("BPhone");
    String bEmail = request.getParameter("BEmail");
    String bBusiness = request.getParameter("BBusiness");
    String bStore = request.getParameter("BStore");
    String bAddress = request.getParameter("BAddress");
    
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";
    
    Connection con = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        String jsql = "INSERT INTO boss (bId, bPasswd, bName, bPhone, bEmail, bBusiness, bStore, bAddress) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, bId);
        pstmt.setString(2, bPasswd);
        pstmt.setString(3, bName);
        pstmt.setString(4, bPhone);
        pstmt.setString(5, bEmail);
        pstmt.setString(6, bBusiness);
        pstmt.setString(7, bStore);
        pstmt.setString(8, bAddress);
        pstmt.executeUpdate();

		response.sendRedirect("index.html");
        %>
        <%
    } catch (Exception e) {
        e.printStackTrace();
        %>
        <script>alert("회원가입에 실패했습니다. 다시 시도해주세요.");</script>
        <%
    } finally {
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    }
%>

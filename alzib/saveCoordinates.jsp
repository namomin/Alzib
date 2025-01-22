<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String x = request.getParameter("x");
    String y = request.getParameter("y");

    String url = "jdbc:mysql://localhost:3306/alzib";
    String user = "multi";
    String password = "abcd";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);
        String sql = "INSERT INTO map (x, y) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, x);
        pstmt.setString(2, y);
        pstmt.executeUpdate();
        conn.close();
        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

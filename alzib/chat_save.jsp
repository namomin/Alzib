<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String message = request.getParameter("message");
    String BId = request.getParameter("BId");
    String AId = request.getParameter("AId");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTime = sdf.format(new Date());

    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    try {
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String query = "INSERT INTO chat (BId, AId, Bchat, Bdate) VALUES (?, ?, ?, ?)";

        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, BId);
        pstmt.setString(2, AId);
        pstmt.setString(3, message);
        pstmt.setString(4, currentTime);

        pstmt.executeUpdate();

        pstmt.close();
        con.close();

        response.sendRedirect("chat.jsp?BId=" + BId + "&AId=" + AId);

    } catch (Exception e) {
        out.println(e);
    }
%>

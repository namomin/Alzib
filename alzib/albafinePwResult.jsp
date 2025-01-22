<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";
    String aId = request.getParameter("aId");
    String aName = request.getParameter("aName");
    String aBirth = request.getParameter("aBirth");
    String aEmail = request.getParameter("aEmail");
    String aPassword = null;

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        String sql = "SELECT APasswd FROM Alba WHERE AId = ? AND AName = ? AND ABirth = ? AND AEmail = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, aId);
        pstmt.setString(2, aName);
        pstmt.setString(3, aBirth);
        pstmt.setString(4, aEmail);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            aPassword = rs.getString("APasswd");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    } finally {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { /* 무시 */ }
        }
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { /* 무시 */ }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { /* 무시 */ }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과</title>
</head>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
body {
    font-family: 'GmarketSansMedium', sans-serif;
    background: #f1f1f1;
    margin: 0;
    padding: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
}

form {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 500px;
    width: 100%;
}

h1 {
    color: #689ADE;
    margin-top: 0;
    margin-bottom: 20px;
    text-align: center;
}

input[type="text"] {
    border: 2px solid #689ADE;
    height: 20px;
    padding: 10px;
    box-shadow: 5px 5px 5px rgba(33, 86, 158, 0.5);
}
</style>
<body>
<form>
    <h1>비밀번호 찾기 결과</h1>
    <% if (aPassword != null) { %>
        <p>회원님의 비밀번호는 <%= aPassword %> 입니다.</p>
    <% } else { %>
        <p>일치하는 회원 정보를 찾을 수 없습니다.</p>
    <% } %>
	</form>
</body>
</html>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>채팅</title>
<link href="chat.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
	String AName = request.getParameter("AName");
    String BId = request.getParameter("BId");
    String AId = request.getParameter("AId");
    
    String Achat = "";
    String Adate = "";
    String Bchat = "";
    String Bdate = "";
    
    boolean chatExists = false;
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        String query = "SELECT * FROM chat WHERE BId = ? AND AId = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, BId);
        pstmt.setString(2, AId);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            chatExists = true;
            Achat = rs.getString("Achat");
            Adate = rs.getString("Adate");
            Bchat = rs.getString("Bchat");
            Bdate = rs.getString("Bdate");
        }
        
        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>

<% if (chatExists) { %>
<form name="chat" action="chat_save.jsp?AId=<%=AId%>&BId=<%=BId%>" method="post">
    <div class="wrap">
        <div class="border_wrap">
            <div class="header_wrap">
                <table>
                    <tr>
                        <td id="back"><a href="apply_resume.jsp">< </a></td>
                        <td id="name"><h3><%=AName%></h3></td>
                    </tr>
                </table>
            </div>
            <div class="chat">
                <div class="date">2024-03-23</div>
                <div class="chat_wrap">
                    <div class="left"><%=Achat%></div>
                    <div id="left_time"><span><%=Adate%></span></div>
                    <div class="right"><%=Bchat%></div>
                    <div id="right_time"><span><%=Bdate%> &nbsp;</span></div>
                </div>
            </div>
            <div class="send">
                <table>
                    <tr>
                        <td>
                            <input type="text" placeholder="메세지를 입력하세요">
                        </td>
                        <td id="send">
                            <input type="submit" value="전송">
                        </td>
                    </tr>
                </table>
            </div>
        </div>  
    </div>
</form>
<% } else { %>
    <% response.sendRedirect("chat_createId.jsp?BId=" + BId + "&AId=" + AId); %>
<% } %>

</body>
</html>

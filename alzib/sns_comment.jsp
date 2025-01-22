<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>댓글 입력</title>
    <link href="sns_comment.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    String myid = (String) session.getAttribute("sid");

    if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
    }

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String Sid = request.getParameter("SId");

        String jsql = "SELECT * FROM sns WHERE SId = ?";
        PreparedStatement pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, Sid);

        ResultSet rs = pstmt.executeQuery();
        rs.next();

        String SId =  rs.getString("SId");
%>

<div class="wrap">
<div class="comment_wrap">
        <div class="head_wrap">
            <h3>댓글</h3>
        </div>

        <div class="write_wrap">
            <form name="commentwrite" action="sns_commentResult.jsp" method="post">
                <table>
                    <tr>
                        <td>
							<input type="text" name="CText" id="comment_write" placeholder="댓글을 입력하세요" required>
							<input type="hidden" name="SId" value="<%=SId%>">
							<input type="hidden" name="CWId" value="<%=myid%>">
						</td>
                        <td>
							<input type="submit" value="등록" id="comment_submit">
						</td>
                    </tr>
                </table>
            </form>
        </div>
    <div class="read_wrap">
    <%
        String commentSql = "SELECT * FROM comment WHERE SId = ?";
        PreparedStatement commentStmt = con.prepareStatement(commentSql);
        commentStmt.setString(1, Sid);

        ResultSet commentRs = commentStmt.executeQuery();

        while (commentRs.next()) {
            String CText = commentRs.getString("CText");
            String Cdate = commentRs.getString("Cdate");
    %>

    
        <table id="comment_view">
            <tr>
                <td id="comment_date"><%=Cdate%></td>
            </tr>
            <tr>
                <td id="comment_content"><%=CText%></td>
            </tr>
        </table>
    

    <%
        }
    %>
	</div>
	</div>
</div>

<%
    } catch (Exception e) {
        out.println(e);
    }
%>
</body>
</html>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>내가 쓴 게시글</title>
    <link href="sns_mywrite.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="wrap">
    <div class="wrap2">
        <h2>스크랩한 게시글</h2>
        <div class="table_wrap">
            <table>
                <th><a href="sns_mywrite.jsp">작성글</a></th>
                <th><a href="sns_mycomment.jsp">작성댓글</a></th>
                <th><a href="sns_myscrap.jsp"><font color="#0E448F">스크랩</font></a></th>
            </table>

            <%
            try {
                String myid = (String) session.getAttribute("sid");

                if (myid == null) {
                    response.sendRedirect("login.jsp");
                }

                String DB_URL="jdbc:mysql://localhost:3306/alzib";
                String DB_ID="multi";
                String DB_PASSWORD="abcd";

                Class.forName("org.gjt.mm.mysql.Driver");
                Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String jsql = "SELECT sns.SId, sns.SWId, sns.Title, sns.Content, sns.Sdate, sns.Viewcount " +
                "FROM sns " + "INNER JOIN scrap ON sns.SId = scrap.SId " + "WHERE scrap.userId = ? " + "ORDER BY sns.Sdate DESC";

                PreparedStatement pstmt = con.prepareStatement(jsql);
                pstmt.setString(1, myid);

                ResultSet rs = pstmt.executeQuery();

                while(rs.next()){
                    int SId =  rs.getInt("SId");
                    String SWId =  rs.getString("SWId");
                    String Title = rs.getString("Title");
                    String Content = rs.getString("Content");
                    String Sdate = rs.getString("Sdate");
					int Viewcount = rs.getInt("Viewcount");
            %>
                    <div class="detailview">
                        <a href="sns_detailview.jsp?SId=<%=SId%>">
                            <table>
                                <tr><td><h3><%=Title%></h3></td></tr>
                                <tr><td id="date"><%=Sdate%> &nbsp; 조회수<%=Viewcount%> &nbsp; 스크랩 
<%
	try {
		String checkSql = "SELECT COUNT(*) AS count FROM scrap WHERE SId = ?";
		PreparedStatement checkStmt = con.prepareStatement(checkSql);
		checkStmt.setInt(1, SId);
		ResultSet checkResult = checkStmt.executeQuery();
		checkResult.next();
		int count = checkResult.getInt("count");

		// Scrap 테이블에서 해당 SId 값을 가진 레코드의 수를 출력
		out.println("<span style=\"font-size: 13px;\">" + count + "</span>");

} catch (Exception e) {
out.println(e);
}
%>								
								</td>
                                    <td id="font">
                                        <a href="sns_scrapdelete.jsp?SId=<%=SId%>">취소</a>
                                    </td>
                                </tr>
                            </table>
                        </a>
                    </div>
<%
}
} catch (Exception e) {
out.println(e);
}
%>

            <br><br>
            <center>
                <a href="snsmain.jsp"><input type="button" value="돌아가기"></a>
            </center>
        </div>
    </div>
</div>

</body>
</html>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>���� �� �Խñ�</title>
    <link href="sns_mywrite.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="wrap">
    <div class="wrap2">
        <h2>��ũ���� �Խñ�</h2>
        <div class="table_wrap">
            <table>
                <th><a href="sns_mywrite.jsp">�ۼ���</a></th>
                <th><a href="sns_mycomment.jsp">�ۼ����</a></th>
                <th><a href="sns_myscrap.jsp"><font color="#0E448F">��ũ��</font></a></th>
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
                                <tr><td id="date"><%=Sdate%> &nbsp; ��ȸ��<%=Viewcount%> &nbsp; ��ũ�� 
<%
	try {
		String checkSql = "SELECT COUNT(*) AS count FROM scrap WHERE SId = ?";
		PreparedStatement checkStmt = con.prepareStatement(checkSql);
		checkStmt.setInt(1, SId);
		ResultSet checkResult = checkStmt.executeQuery();
		checkResult.next();
		int count = checkResult.getInt("count");

		// Scrap ���̺��� �ش� SId ���� ���� ���ڵ��� ���� ���
		out.println("<span style=\"font-size: 13px;\">" + count + "</span>");

} catch (Exception e) {
out.println(e);
}
%>								
								</td>
                                    <td id="font">
                                        <a href="sns_scrapdelete.jsp?SId=<%=SId%>">���</a>
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
                <a href="snsmain.jsp"><input type="button" value="���ư���"></a>
            </center>
        </div>
    </div>
</div>

</body>
</html>

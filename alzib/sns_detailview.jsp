<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>sns �Խñ� �󼼺���</title>
<link href="sns_detailview.css" rel="stylesheet" type="text/css">
<style>
		.nav{
			text-align: left;
			margin-left: 0px;
			width: 20%;
			height: auto;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
			margin-bottom: 15px;
			margin-top: 0px;
		}

		.nav a{
			color: #689ADE;
			text-decoration: none;
		}

		.nav a:hover{
			color:#CADCF4;
		}
</style>
</head>
<body>
<div class="wrap">

	<div class="main">
	<%
	String myid = (String) session.getAttribute("sid");
	if (session.getAttribute("sid") == null) {
        response.sendRedirect("login.jsp");
    }
	try {
		String DB_URL="jdbc:mysql://localhost:3306/alzib";
		String DB_ID="multi";
		String DB_PASSWORD="abcd";
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
		String SId = request.getParameter("SId");
		String jsql = "select * from sns where SId = ?";
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, SId);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			String Title = rs.getString("Title");
			String Content = rs.getString("Content");
			String Category = rs.getString("Category");
			String Sdate = rs.getString("Sdate");
			int Viewcount = rs.getInt("Viewcount");
			int heart = rs.getInt("heart");

			Viewcount++; // ��ȸ�� ����
			heart++; // ���ƿ�� ����(������ ��ȸ�� ��ȸ��ó�� ����)

			String updateSql = "UPDATE sns SET Viewcount = ?, heart = ? WHERE SId = ?";
			PreparedStatement updateStmt = con.prepareStatement(updateSql);
			updateStmt.setInt(1, Viewcount);
			updateStmt.setInt(2, heart);
			updateStmt.setString(3, SId);
			updateStmt.executeUpdate();

			// ī�װ� �̸� ����
			String Category_name;
			if (Category.equals("free"))
				Category_name = "�����Խ���";
			else if (Category.equals("information"))
				Category_name = "�˹ٲ����Խ���";
			else if (Category.equals("complain"))
				Category_name = "�ϼҿ��Խ���";
			else if (Category.equals("q"))
				Category_name = "�����Խ���";
			else 
				Category_name = "�ı�Խ���";
	%>
<div class="nav">
		<span><a href="main.jsp">Ȩ</a> > <a href="snsmain.jsp">Ŀ�´�Ƽ</a></span>
</div>
		<div class="back_button">
		<a href="snsmain.jsp"><input type="button" value="<" id="back"></a>
		</div>
		<div class="board_wrap">
			<div class="head_wrap">
				<table>
					<tr>
						<td><a href="sns_categoryview.jsp?Category=<%=Category%>"><font color="#0047A9"><%=Category_name%></font></a></td>
					</tr>
					<tr>
						<td><h2><%=Title%></h2></td>
					</tr>
					<tr>
						<td><font color="gray" size="2"><%=Sdate%> &nbsp ��ȸ��&nbsp<%=Viewcount%></font></td>
					</tr>
				</table>
			</div>

			<div class="content_wrap">
				<table>
					<tr>
						<td><%=Content%></td>
					</tr>
					<tr>
						<td id="like">
    <form name="Scrap" action="sns_scrapResult.jsp" method="post">
        <input type="hidden" name="SId" value="<%=SId%>">
        <input type="submit" value="��ũ��" id="scrap_button">
        <%-- Scrap ���̺��� �ش� SId ���� ���� ���ڵ��� ���� ��� --%>
        <%
    try {
        String checkSql = "SELECT COUNT(*) AS count FROM scrap WHERE SId = ?";
        PreparedStatement checkStmt = con.prepareStatement(checkSql);
        checkStmt.setString(1, SId);
        ResultSet checkResult = checkStmt.executeQuery();
        checkResult.next();
        int count = checkResult.getInt("count");

        // Scrap ���̺��� �ش� SId ���� ���� ���ڵ��� ���� ���
        out.println("<span style=\"font-size: 13px;\">" + count + "</span>");


        con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>
    </form>
</td>

					</tr>
				</table>
			</div>
		</div>

	<div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
	<!-- sns_comment.html ���� �ҷ�����-->
	<iframe src="sns_comment.jsp?SId=<%=SId%>" frameborder="0" scrolling="auto" width="700" height="900" style="display:block; margin:auto;"></iframe>
	</div>
	<%
		}
	} catch(Exception e) {
		out.println(e);
	}
	%>
	</div>

	
</div>
</body>
</html>

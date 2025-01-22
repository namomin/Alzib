<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>���� ���� ������</title>
<link href="Manager_CSS.css" rel="stylesheet" type="text/css">

<style>
	form{
		margin-top: 3px;
		margin-bottom: 3px;
	}
	
	select{
		font-family: 'GmarketSansMedium', sans-serif;
		border: 2px solid #689ADE;
		border-radius: 2px;
		padding: 9px;
	}

	form input[type="submit"] {
		background-color: transparent;
		background-image: url("images/search_icon.png");
		background-repeat: no-repeat;
		width: 40px;
		height: 40px;
		border: none;
		cursor: pointer;
		text-indent: -9999px;
		vertical-align: middle;
		margin-left: 3px;
		margin-top: 10px;
	}
</style>

<script>
    function search() {
        var keyword = document.getElementById("searchbar").value;
        window.location.href = "Manager_SRpost.jsp?keyword=" + encodeURIComponent(keyword);
    }

    function onKeyPress(event) {
        if (event.keyCode === 13) { // ���Ͱ˻�
            search();
        }
    }
</script>
</head>
<body>
<%
		String myid = (String) session.getAttribute("sid");

		if (myid == null) {
			response.sendRedirect("Manager_Login.html");
		}

        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            String sql = "SELECT * FROM post ORDER BY PostNum DESC";
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();
%>
<div class="wrap">
	<header>
		<a href="Manager_Main.jsp" id="logo"><img src="images/logo.png" alt="�ΰ�"></a>
		<span>
			<font color="#0047A9"><b><%=myid%></b></font> �����ڴ� &nbsp; <a href="logout.jsp" id="logout">�α׾ƿ�</a>
		</span>
	</header>

	<nav>
		<table>
			<tr>
				<td><a href="Manager_Bmember.jsp">ȸ������</a></td>
				<td><a href="Manager_sns.jsp">Ŀ�´�Ƽ</a></td>
				<td><a href="Manager_post.jsp">����/����</a></td>
			</tr>
		</table>
	</nav>
	
	<div class="header_title">
		<span>���� ����</span>
	</div>

	<div class="header_nav">
		<table>
			<tr>
				<td id="choice"><a href="Manager_post.jsp"><h3>����</h3></a></td>
                <td><a href="Manager_resume.jsp"><h3>�̷¼�</h3></a></td>
            </tr>
        </table>

			<form method="get" action="Manager_SRpost.jsp">

				<select name="field" id="field">
					<option value="BId">�ۼ���</option>
					<option value="PostNum">���� ��ȣ</option>
					<option value="Title">����</option>
				</select>

				<input type="text" name="keyword" id="keyword" placeholder="��� ������ �˻��ϼ���." onkeypress="onKeyPress(event)">
				<input type="submit" value="�˻�">

			</form>
	</div>

	<div class="table_wrap">
		<table>
				<tr>
					<th>��ȣ</th>
					<th>�ۼ���</th>
					<th>����</th>
					<th>����</th>
				</tr>
				
<%
	while (rs.next()) {
		String PostNum = rs.getString("PostNum");
		String BId = rs.getString("BId");
		String Title = rs.getString("Title");
%>				
				<tr>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=PostNum%></a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=BId%></a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a></td>
					<td><a href="Manager_postdelete.jsp?PostNum=<%=PostNum%>"><button>����</button></a></td>
				</tr>
<%
	}
%>	
		</table>
	</div>
</div>
<%
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // ���ҽ� ����
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
 %>
</body>
</html>

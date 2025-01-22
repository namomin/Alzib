<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>�Խñ� ���� ������</title>
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

	.category{
		background-color: skyblue;
		width: 70%;
		
	}

	.category table{
		text-align: left;
		float: left;
	}

	.category td{
		padding: 10px;
		font-size: 18px;
	}

	.category td a{
		text-decoration: none;
		color: #0047A9;
		transition: color 0.3s, font-size 0.3s;
		transition: letter-spacing 0.3s ease;
	}

	.category td a:hover{
		cursor: pointer;
		padding: 10px;
		border: none;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		background-color: #689ADE;
		color: white;
		outline: none;
		letter-spacing: 3px;
	}

	#present_category{
		padding: 10px;
		border: none;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		background-color: #689ADE;
		color: white;
		outline: none;
	}
</style>

<script>
    function search() {
        var keyword = document.getElementById("searchbar").value;
        window.location.href = "Manager_SRsns.jsp?keyword=" + encodeURIComponent(keyword) + "&Category=" + encodeURIComponent(Category);
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

		   String Category = request.getParameter("Category");
           String sql = "SELECT * FROM sns WHERE Category = ? ORDER BY Sdate DESC";
            pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Category);

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
		<span>�Խñ� ����</span>
	</div>

	<div class="header_nav">
		<table>
			<tr>
				<td id="choice"><a href="Manager_sns.jsp"><h3>�Խñ�</h3></a></td>
                <td><a href="Manager_comment.jsp"><h3>���</h3></a></td>
            </tr>
        </table>

			<form method="get" action="Manager_SRsns.jsp">

				<input type="hidden" name="Category" value="<%= Category %>">

				<select name="field" id="field">
					<option value="SWId">�ۼ��� ���̵�</option>
					<option value="SId">�Խñ� ��ȣ</option>
					<option value="Title">����</option>
					<option value="Sdate">�ۼ���</option>
				</select>

				<input type="text" name="keyword" id="keyword" placeholder="��� ������ �˻��ϼ���." onkeypress="onKeyPress(event)">
				<input type="submit" value="�˻�">

			</form>
	</div>

	<div class="category">
		<table>
			<tr>
				<td><a href="Manager_sns.jsp">����</a></td>
				<td><a href="Manager_snsinformation.jsp?Category=information">�˹ٲ���</a></td>
				<td><a href="Manager_snsfree.jsp?Category=free">����</a></td>
				<td><a href="Manager_snscomplain.jsp?Category=complain">�ϼҿ�</a></td>
				<td id="present_category"><a href="Manager_snsq.jsp?Category=q"><font color="white">����</font></a></td>
				<td><a href="Manager_snsafter.jsp?Category=after">�ı�</a></td>
			</tr>
		</table>
	</div>

	<div class="table_wrap">
		<table>
			<tr>
					<th>��ȣ</th>
					<th>�ۼ���</th>
					<th>ī�װ�</th>
					<th>����</th>
					<th>�ۼ���</th>
					<th>����</th>
				</tr>
<%
	while (rs.next()) {
		String SId = rs.getString("SId");
		String SWId = rs.getString("SWId");
		String Title = rs.getString("Title");
		String Sdate = rs.getString("Sdate");

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
			<tr>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SWId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Category_name%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Title%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Sdate%></a></td>
					<td><a href="Manager_snsdelete.jsp?SId=<%=SId%>"><button>����</button></a></td>
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>��� �˻� ���</title>
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
      window.location.href = "Manager_SRcomment.jsp?keyword=" + encodeURIComponent(keyword);
    }

    function onKeyPress(event) {
      if (event.keyCode === 13) { //���Ͱ˻�
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

    String field = request.getParameter("field");
    String keyword = request.getParameter("keyword");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql = "SELECT * FROM comment WHERE " + field + " LIKE ? ORDER BY Cdate DESC";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + keyword + "%");

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
        <span>��� ����</span>
    </div>
    
    <div class="header_nav">
        <table>
            <tr>
				<td><a href="Manager_sns.jsp"><h3>�Խñ�</h3></a></td>
                <td id="choice"><a href="Manager_comment.jsp"><h3>���</h3></a></td>
            </tr>
        </table>

		<form method="get" action="Manager_SRcomment.jsp">

				<select name="field" id="field">
					<option value="CWId">�ۼ��� ���̵�</option>
					<option value="CId">��۹�ȣ</option>
					<option value="SId">�Խñ� ��ȣ</option>
					<option value="CText">���</option>
					<option value="Cdate">�ۼ���</option>
				</select>

				<input type="text" name="keyword" id="keyword" placeholder="���̵� �Ǵ� �̸��� �˻��ϼ���." onkeypress="onKeyPress(event)">
				<input type="submit" value="�˻�">

			</form>
	</div>
	
	<div style="width: 70%; padding-bottom: 10px;">
        "<font color="#0047A9"><b> <%=keyword%> </b></font>" �˻� ���
    </div>
<div class="table_wrap">
    <table>
			<tr>
				<th>��ȣ</th>
				<th>�ۼ���</th>
				<th>�Խñ� ��ȣ</th>
				<th>���</th>
				<th>�ۼ���</th>
				<th>����</th>
			</tr>

        <%
        if (rs.next()) {
            rs.beforeFirst();
            while (rs.next()) {
                String CId = rs.getString("CId");
				String CWId = rs.getString("CWId");
				String SId = rs.getString("SId");
				String CText = rs.getString("CText");
				String Cdate = rs.getString("Cdate");
        %>
        <tr>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=CId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=CWId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=CText%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Cdate%></a></td>
					<td><a href="Manager_comdelete.jsp?CId=<%=CId%>"><button>����</button></a></td>
				</tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">�˻������ �������� �ʽ��ϴ�.</td>
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

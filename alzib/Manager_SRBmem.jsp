<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>���� ȸ�� �˻� ���</title>
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
      window.location.href = "Manager_SRBmem.jsp?keyword=" + encodeURIComponent(keyword);
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

        String sql = "SELECT * FROM boss WHERE " + field + " LIKE ?";
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
        <span>���� ȸ�� ���� &nbsp;<button><a href="memberinsert_boss.html">�߰�</a></button></span>
    </div>
    
    <div class="header_nav">
        <table>
            <tr>
                <td id="choice"><a href="Manager_Bmember.jsp"><h3>�����</h3></a></td>
                <td><a href="Manager_Amember.jsp"><h3>�˹ٻ�</h3></a></td>
            </tr>
        </table>

		<form method="get" action="Manager_SRBmem.jsp">

				<select name="field" id="field">
					<option value="BId">���̵�</option>
					<option value="BName">�̸�</option>
					<option value="BPhone">��ȭ��ȣ</option>
					<option value="BEmail">�̸���</option>
					<option value="BBusiness">����ڵ�Ϲ�ȣ</option>
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
            <th>���̵�</th>
            <th>�̸�</th>
            <th>��ȭ��ȣ</th>
            <th>�̸���</th>
			<th>����ڵ�Ϲ�ȣ</th>
            <th>����</th>
        </tr>

        <%
        if (rs.next()) {
            rs.beforeFirst();
            while (rs.next()) {
                String BId = rs.getString("BId");
				String BName = rs.getString("BName");
				String BPhone = rs.getString("BPhone");
				String BEmail = rs.getString("BEmail");
				String BBusiness = rs.getString("BBusiness");
        %>
			<tr>
				<td><a href="#"><%=BId%></a></td>
				<td><%=BName%></td>
				<td><%=BPhone%></td>
				<td><%=BEmail%></td>
				<td><%=BBusiness%></td>
				<td><a href="Manager_Bmemdelete.jsp?BId=<%=BId%>"><button>����</button></a></td>
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

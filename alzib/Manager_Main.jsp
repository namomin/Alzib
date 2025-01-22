<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>������ ������</title>
<link href="Manager.css" rel="stylesheet" type="text/css">
<style>
  .list-container {
    position: relative;
    display: inline-block;
  }
	
  .list {
    display: none;
    position: absolute;
    background-color: #fff;
    border: 1px solid #ccc;
    list-style: none;
    margin: 0;
    z-index: 1;
	top: 100%;
	width: 120px;
  }

  .list a{
	text-decoration: none;
	color: black;
  }

  .list a:hover{
	color: #CADCF4;
	text-decoration: underline;
  }
	
  .list li {
    cursor: pointer;
	border-top: 1px solid #ccc;
	padding: 10px;
  }
</style>
</head>
<body>

<%
	try {
		String myid = (String) session.getAttribute("sid");
		if (myid == null) {
			response.sendRedirect("Manager_Login.html");
		}

		String DB_URL = "jdbc:mysql://localhost:3306/alzib";
		String DB_ID = "multi";
		String DB_PASSWORD = "abcd";

		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

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
	
	<div  class="main_title">
		<h2>ȸ��</h2>
	</div>
	
	<div class="member_wrap">
	<div class="table_wrap">
		<div class="table_header">
			<span>����� &nbsp;<button><a href="Manager_Bmember.jsp">��ü</a></button></span>
		</div>
		
		<div class="table_body">
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
            try {
				conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String QueryBoss = "SELECT * FROM Boss Limit 3";
                pstmt = conn.prepareStatement(QueryBoss);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String BId = rs.getString("BId");
					String BName = rs.getString("BName");
					String BPhone = rs.getString("BPhone");
					String BEmail = rs.getString("BEmail");
					String BBusiness = rs.getString("BBusiness");
		%>
				<tr>
                    <td><%=BId%></td>
                    <td><%=BName%></td>
					<td><%=BPhone%></td>
					<td><%=BEmail%></td>
					<td><%=BBusiness%></td>
                    <td><a href="Manager_Bmemdelete.jsp?BId=<%=BId%>"><button>����</button></a></td>
                </tr>
<!--����ȸ����������-->
                <ul class="list list-<%=BId%>" align="center">
                    <li><a href="Manager_SRpost.jsp?field=BId&keyword=<%=BId%>">����/�̷¼�</a></li>
                    <li><a href="Manager_SRsns.jsp?field=SWId&keyword=<%=BId%>">�Խñ�</a></li>
                    <li><a href="Manager_SRcomment.jsp?field=CWId&keyword=<%=BId%>">���</a></li>
                    <li class="close-list"><font color="#0047A9"><b>�ݱ�</b></font></style></li>
                </ul>

			<%
                }
            } catch (Exception e) {
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
			</table>
		</div>
	</div>
	
	
	<div class="table_wrap">
		<div class="table_header">
			<span>�˹ٻ� &nbsp;<button><a href="Manager_Amember.jsp">��ü</a></button></span>
		</div>
		
		<div class="table_body">
			<table>
				<tr>
					<th>���̵�</th>
					<th>�̸�</th>
					<th>��ȭ��ȣ</th>
					<th>�̸���</th>
					<th>����</th>
				</tr>
				
				<%
            try {
				conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String QueryAlba = "SELECT * FROM Alba Limit 3";
                pstmt = conn.prepareStatement(QueryAlba);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String AId = rs.getString("AId");
					String AName = rs.getString("AName");
					String APhone = rs.getString("APhone");
					String AEmail = rs.getString("AEmail");
		%>
				<tr>
					<td><%=AId%></td>
					<td><%=AName%></td>
					<td><%=APhone%></td>
					<td><%=AEmail%></td>
					<td><a href="Manager_Amemdelete.jsp?AId=<%=AId%>"><button>����</button></a></td>
				</tr>
<!--�˹�ȸ����������-->
				<ul class="alba-list list" align="center">
				<li><a href="Manager_SRresume.jsp?field=AId&keyword=<%=AId%>">�̷¼�</a></li>
				<li><a href="Manager_SRsns.jsp?field=SWId&keyword=<%=AId%>">�Խñ�</a></li>
				<li><a href="Manager_SRcomment.jsp?field=CWId&keyword=<%=AId%>">���</a></li>
				<li class="close-list"><font color="#0047A9"><b>�ݱ�</b></font></style></li>
			</ul>
				<%
                }
            } catch (Exception e) {
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
				
			</table>
		</div>
	</div>
	</div>
	
	<div  class="main_title">
		<h2>�ű� Ŀ�´�Ƽ ��</h2>
	</div>
	
	<div class="member_wrap">
	<div class="table_wrap">
		<div class="table_header">
			<span>�Խñ� &nbsp;<button><a href="Manager_sns.jsp">��ü</a></button></span>
		</div>
		<div class="table_body">
			<table>
				<tr>
					<th>��ȣ</th>
					<th>�ۼ���</th>
					<th>����</th>
					<th>�ۼ���</th>
					<th>����</th>
				</tr>
				
				<%
            try {
				conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String QueryBoss = "SELECT * FROM sns ORDER BY Sdate DESC Limit 3";
                pstmt = conn.prepareStatement(QueryBoss);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String SId = rs.getString("SId");
					String SWId = rs.getString("SWId");
					String Title = rs.getString("Title");
					String Sdate = rs.getString("Sdate");
		%>
				<tr>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=SWId%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Title%></a></td>
					<td><a href="sns_detailview.jsp?SId=<%=SId%>"><%=Sdate%></a></td>
					<td><a href="Manager_snsdelete.jsp?SId=<%=SId%>"><button>����</button></a></td>
				</tr>
				<%
                }
            } catch (Exception e) {
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
			</table>
		</div>
	</div>
	
	<div class="table_wrap">
		<div class="table_header">
			<span>��� &nbsp;&nbsp;&nbsp;&nbsp;<button><a href="Manager_comment.jsp">��ü</a></button></span>
		</div>
		<div class="table_body">
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
            try {
				conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String QueryBoss = "SELECT * FROM comment ORDER BY Cdate DESC Limit 3";
                pstmt = conn.prepareStatement(QueryBoss);
                rs = pstmt.executeQuery();

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
					<td><a href="Manager_snsdelete.jsp?CId=<%=CId%>"><button>����</button></a></td>
				</tr>
			<%
                }
            } catch (Exception e) {
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
			</table>
		</div>
	</div>
	</div>
	
	<div class="main_title">
		<h2>�ű� ����/�̷¼�</h2>
	</div>
	
	<div class="member_wrap">
	<div class="table_wrap">
		<div class="table_header">
			<span>���� &nbsp;&nbsp;&nbsp;&nbsp;<button><a href="Manager_post.jsp">��ü</a></button></span>
		</div>
		<div class="table_body">
			<table>
				<tr>
					<th>��ȣ</th>
					<th>�ۼ���</th>
					<th>���ΰ��� ����</th>
					<th>����</th>
				</tr>
				
				<%
            try {
				conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String Query = "SELECT * FROM post ORDER BY PostNum DESC Limit 3";
                pstmt = conn.prepareStatement(Query);
                rs = pstmt.executeQuery();

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
            } catch (Exception e) {
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
			</table>
		</div>
		
	</div>

	<div class="table_wrap">
		<div class="table_header">
			<span>�̷¼� &nbsp;<button><a href="Manager_resume.jsp">��ü</a></button></span>
		</div>
		<div class="table_body">
			<table>
				<tr>
					<th>��ȣ</th>
					<th>�ۼ���</th>
					<th>�̷¼� ����</th>
					<th>����</th>
				</tr>
				<%
            try {
				conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String Query = "SELECT * FROM resume ORDER BY RId DESC Limit 3";
                pstmt = conn.prepareStatement(Query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
					String RId = rs.getString("RId");
                    String AId = rs.getString("AId");
					String RTitle = rs.getString("RTitle");
		%>
				
				<tr>
					<td><a href="resumedetailview.jsp?RId=<%=RId%>"><%=RId%></a></td>
					<td><a href="resumedetailview.jsp?RId=<%=RId%>"><%=AId%></a></td>
					<td><a href="resumedetailview.jsp?RId=<%=RId%>"><%=RTitle%></a></td>
					<td><a href="Manager_resdelete.jsp?RId=<%=RId%>"><button>����</button></a></td>
				</tr>
				<%
                }
            } catch (Exception e) {
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
			</table>
		</div>
		
	</div>
	</div>

</div>

</body>
</html>

<%
    } catch (Exception e) {
        out.println(e);
}
%>
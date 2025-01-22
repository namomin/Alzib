<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>관리자 페이지</title>
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
		<a href="Manager_Main.jsp" id="logo"><img src="images/logo.png" alt="로고"></a>
		<span>
			<font color="#0047A9"><b><%=myid%></b></font> 관리자님 &nbsp; <a href="logout.jsp" id="logout">로그아웃</a>
		</span>
	</header>

	<nav>
		<table>
			<tr>
				<td><a href="Manager_Bmember.jsp">회원관리</a></td>
				<td><a href="Manager_sns.jsp">커뮤니티</a></td>
				<td><a href="Manager_post.jsp">구인/구직</a></td>
			</tr>
		</table>
	</nav>
	
	<div  class="main_title">
		<h2>회원</h2>
	</div>
	
	<div class="member_wrap">
	<div class="table_wrap">
		<div class="table_header">
			<span>사장님 &nbsp;<button><a href="Manager_Bmember.jsp">전체</a></button></span>
		</div>
		
		<div class="table_body">
			<table>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>사업자등록번호</th>
					<th>관리</th>
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
                    <td><a href="Manager_Bmemdelete.jsp?BId=<%=BId%>"><button>삭제</button></a></td>
                </tr>
<!--사장회원관리선택-->
                <ul class="list list-<%=BId%>" align="center">
                    <li><a href="Manager_SRpost.jsp?field=BId&keyword=<%=BId%>">공고/이력서</a></li>
                    <li><a href="Manager_SRsns.jsp?field=SWId&keyword=<%=BId%>">게시글</a></li>
                    <li><a href="Manager_SRcomment.jsp?field=CWId&keyword=<%=BId%>">댓글</a></li>
                    <li class="close-list"><font color="#0047A9"><b>닫기</b></font></style></li>
                </ul>

			<%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // 리소스 해제
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
			<span>알바생 &nbsp;<button><a href="Manager_Amember.jsp">전체</a></button></span>
		</div>
		
		<div class="table_body">
			<table>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>관리</th>
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
					<td><a href="Manager_Amemdelete.jsp?AId=<%=AId%>"><button>삭제</button></a></td>
				</tr>
<!--알바회원관리선택-->
				<ul class="alba-list list" align="center">
				<li><a href="Manager_SRresume.jsp?field=AId&keyword=<%=AId%>">이력서</a></li>
				<li><a href="Manager_SRsns.jsp?field=SWId&keyword=<%=AId%>">게시글</a></li>
				<li><a href="Manager_SRcomment.jsp?field=CWId&keyword=<%=AId%>">댓글</a></li>
				<li class="close-list"><font color="#0047A9"><b>닫기</b></font></style></li>
			</ul>
				<%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // 리소스 해제
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
		<h2>신규 커뮤니티 글</h2>
	</div>
	
	<div class="member_wrap">
	<div class="table_wrap">
		<div class="table_header">
			<span>게시글 &nbsp;<button><a href="Manager_sns.jsp">전체</a></button></span>
		</div>
		<div class="table_body">
			<table>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>작성일</th>
					<th>관리</th>
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
					<td><a href="Manager_snsdelete.jsp?SId=<%=SId%>"><button>삭제</button></a></td>
				</tr>
				<%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // 리소스 해제
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
			<span>댓글 &nbsp;&nbsp;&nbsp;&nbsp;<button><a href="Manager_comment.jsp">전체</a></button></span>
		</div>
		<div class="table_body">
			<table>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>게시글 번호</th>
					<th>댓글</th>
					<th>작성일</th>
					<th>관리</th>
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
					<td><a href="Manager_snsdelete.jsp?CId=<%=CId%>"><button>삭제</button></a></td>
				</tr>
			<%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // 리소스 해제
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
		<h2>신규 공고/이력서</h2>
	</div>
	
	<div class="member_wrap">
	<div class="table_wrap">
		<div class="table_header">
			<span>공고 &nbsp;&nbsp;&nbsp;&nbsp;<button><a href="Manager_post.jsp">전체</a></button></span>
		</div>
		<div class="table_body">
			<table>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>구인공고 제목</th>
					<th>관리</th>
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
					<td><a href="Manager_postdelete.jsp?PostNum=<%=PostNum%>"><button>삭제</button></a></td>
				</tr>
				<%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // 리소스 해제
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
			<span>이력서 &nbsp;<button><a href="Manager_resume.jsp">전체</a></button></span>
		</div>
		<div class="table_body">
			<table>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>이력서 제목</th>
					<th>관리</th>
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
					<td><a href="Manager_resdelete.jsp?RId=<%=RId%>"><button>삭제</button></a></td>
				</tr>
				<%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // 리소스 해제
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
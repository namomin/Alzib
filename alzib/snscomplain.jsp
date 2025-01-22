<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>sns</title>
<link href="snsmain.css" rel="stylesheet" type="text/css">
<style>
		.nav{
			text-align: left;
			margin-left: 15%;
			width: 20%;
			border-radius: 10px;
			border: 1px solid #689ADE;
			padding: 15px;
			color: #689ADE;
			margin-bottom: 15px;
		}

		a{
			color: #689ADE;
			text-decoration: none;
		}

		a:hover{
			color:#CADCF4;
		}
</style>
<script>
    function search(category) {
      var keyword = document.getElementById("search_bar").value;
      window.location.href = "sns_searchResult.jsp?keyword=" + encodeURIComponent(keyword) + "&Category=" + encodeURIComponent(category);
    }

    function onKeyPress(event) {
      if (event.keyCode === 13) { //엔터검색
        search();
      }
    }
</script>

</head>
<body>
<%
String myid = (String) session.getAttribute("sid");

if(myid == null) {
    myid = "비회원";
}

Connection con = null;
ResultSet rs = null;

try {
    String DB_URL="jdbc:mysql://localhost:3306/alzib";
    String DB_ID="multi";
    String DB_PASSWORD="abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    int list_index;

    String group_index = request.getParameter("group_index");

    if (group_index != null)
        list_index = Integer.parseInt(group_index);
    else
        list_index = 0; // 현재 페이지 수

    int pageSize = 5; // 페이지당 보여줄 게시글 수

    String Category = request.getParameter("Category");
    String jsqlCategory = "SELECT * FROM sns WHERE Category = ? ORDER BY Sdate DESC LIMIT ?, ?";

    PreparedStatement pstmt = con.prepareStatement(jsqlCategory);
	pstmt.setString(1, Category);
    pstmt.setInt(2, list_index * pageSize); // 시작 인덱스 계산
    pstmt.setInt(3, pageSize); // 페이지당 보여줄 게시글 수

    rs = pstmt.executeQuery();

    // 게시글 수 조회
     String countQuery = "SELECT COUNT(*) FROM sns WHERE Category = ?";
    PreparedStatement countStmt = con.prepareStatement(countQuery);
    countStmt.setString(1, Category);
    ResultSet countRs = countStmt.executeQuery();
    countRs.next();
    int totalPosts = countRs.getInt(1);
    int totalPage = (int) Math.ceil((double) totalPosts / pageSize); // 총 페이지 수
%>

<div class="wrap">
<div class="nav">
		<span><a href="main.jsp">홈</a> > <a href="snsmain.jsp">커뮤니티</a></span>
</div>
    <div class="popular_wrap1">
<div class="popular_wrap">
    <div class="popular_head">
        <span>오늘의 인기글 top3</span>
    </div>
    <div class="popular_body">
        <div class="popular">
            <%
                String popularSql = "SELECT sns.SId, sns.Title, sns.Content, sns.Sdate, sns.Viewcount, sns.Category, " +
                                    "COALESCE(COUNT(DISTINCT comment.CId), 0) AS CommentCount, " +
                                    "COALESCE(COUNT(DISTINCT scrap.SCId), 0) AS ScrapCount " +
                                    "FROM sns " +
                                    "LEFT JOIN comment ON sns.SId = comment.SId " +
                                    "LEFT JOIN scrap ON sns.SId = scrap.SId " +
                                    "WHERE DATE(sns.Sdate) = CURDATE() " +
                                    "GROUP BY sns.SId, sns.Title, sns.Content, sns.Sdate, sns.Viewcount, sns.Category " +
                                    "ORDER BY Viewcount DESC, CommentCount DESC " +
                                    "LIMIT 3";
                PreparedStatement popularStmt = con.prepareStatement(popularSql);
                ResultSet popularRs = popularStmt.executeQuery();
                while (popularRs.next()) {
                    int SId = popularRs.getInt("SId");
                    String Title = popularRs.getString("Title");
                    String Content = popularRs.getString("Content");
                    String Sdate = popularRs.getString("Sdate");
                    int Viewcount = popularRs.getInt("Viewcount");
                    int CommentCount = popularRs.getInt("CommentCount");
                    int ScrapCount = popularRs.getInt("ScrapCount");
                    String Category_name;

                    if (Category.equals("free"))
                        Category_name = "자유게시판";
                    else if (Category.equals("information"))
                        Category_name = "알바꿀팁게시판";
                    else if (Category.equals("complain"))
                        Category_name = "하소연게시판";
                    else if (Category.equals("q"))
                        Category_name = "질문게시판";
                    else
                        Category_name = "후기게시판";
            %>
            <a href="sns_detailview.jsp?SId=<%=SId%>">
                <table>
                    <tr>
                        <td><font color="gray" size="2"><%=Category_name%></font></td>
                    </tr>
                    <tr>
                        <td><font color="gray" size="2"></font></td>
                        <!--<td rowspan="4" class="im">이미지</td>-->
                    </tr>
                    <tr>
                        <td><h3><%= Title %></h3></td>
                    </tr>
                    <tr>
                        <td class="content"><%= Content %></td>
                    </tr>
                    <tr>
                        <td><font color="gray" size="2"><%= Sdate %> 조회수 <%= Viewcount %> 스크랩 <%= ScrapCount %></font></td>
                    </tr>
                </table>
            </a>
            <%
                }
                popularRs.close();
                popularStmt.close();
            %>
        </div>
    </div>
</div>
    </div>
    
    <div class="contents">
        <div class="left_wrap">
            <div class="category">
                <table>
                    <tr>
                        <td><a href="snsmain.jsp">모든글</a></td>
						<td><a href="snsinformation.jsp?Category=information">알바꿀팁</a></td>
                        <td><a href="snsfree.jsp?Category=free">자유</a></td>
                        <td id="present_category"><a href="snscomplain.jsp?Category=complain"><font color="white">하소연</font></a></td>
                        <td><a href="snsq.jsp?Category=q">질문</a></td>
                        <td><a href="snsafter.jsp?Category=after">후기</a></td>
                    </tr>
                </table>
            </div>

            <div class="content">

<%
    while(rs.next()){
        int SId =  rs.getInt("SId");
        String Title = rs.getString("Title");
        String Content = rs.getString("Content");
        String Sdate = rs.getString("Sdate");
        int Viewcount = rs.getInt("Viewcount");
        String Category_name;

        if (Category.equals("free"))
            Category_name = "자유게시판";
        else if (Category.equals("information"))
            Category_name = "정보게시판";
        else if (Category.equals("complain"))
            Category_name = "하소연게시판";
        else if (Category.equals("q"))
            Category_name = "질문게시판";
        else 
            Category_name = "후기게시판";
%>
                <a href="sns_detailview.jsp?SId=<%=SId%>">
                <table>
                    <tr>
                        <td><font color="gray" size="2"><%=Category_name%></font></td>
                        <!--<td rowspan="4" class="im">이미지</td>-->
                    </tr>
                    <tr>
                        <td><h3><%=Title%></h3></td>
                    </tr>
                    <tr>
                        <td class="content"><%=Content%></td>
                    </tr>
                    <tr>
                        <td><font color="gray" size="2"><%=Sdate%> &nbsp; 조회수 <%=Viewcount%> 스크랩
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
                        </font></td>
                    </tr>
                </table>
                </a>   
<%
    }  
%>
            </div>
            
	<div class="page">
		<%-- 처음 페이지로 이동 --%>
		<% if (list_index > 0) { %>
			<a href="snscomplain.jsp?group_index=<%=list_index - 1 %>">
				< &nbsp;
			</a>
		<% } %>

		<span id="pagenumber">
		<%-- 페이지 번호 출력 --%>
		<%
			for (int j = 1; j <= totalPage; j++) {
				if (j == list_index + 1) {
		%>
			<font color="#0047A9"><b><%= j %></b></font> &nbsp;
		<%
				} else {
		%>
			<a href="snscomplain.jsp?group_index=<%= j - 1 %>"><%= j %></a> &nbsp;
		<%
				}
			}
		%>
		</span>

		<%-- 마지막 페이지로 이동 --%>
		<% if (list_index < totalPage - 1) { %>
			<a href="snscomplain.jsp?group_index=<%=list_index + 1 %>">
				>
			</a>
		<% } %>
	</div>

        </div>
    
        <div class="right_wrap">
            <div class="search">
                <input type="text" id="search_bar" placeholder="검색어를 입력하세요" onkeypress="onKeyPress(event)"><input type="button" id="search_button" onclick="search('complain')">
            </div>
            <div class="write">
                <a href="sns_write.jsp"><input type="button" value="글 작성" id="write_button"></a>
            </div>
            
            <div class="my">
                <div class="member">
                    <h3><font color="#02377E"><%=myid%></font> 님의 활동</h3>
                </div>
                <div class="activity">
                    <ul>
                        <li align="left"><a href="sns_mywrite.jsp">내가 쓴 게시글</a></li>
                        <li align="left"><a href="sns_mycomment.jsp">내가 쓴 댓글</a></li>
                        <li align="left"><a href="sns_myscrap.jsp">스크랩한 게시글</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
</div>
<%
} catch (Exception e) {
    out.println(e);  
} finally {
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
</body>
</html>

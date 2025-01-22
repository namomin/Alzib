<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">

<title>sns 메인페이지</title>
<link href="sns_main.css" rel="stylesheet" type="text/css">

<script>
    function search(category) {
    var keyword = document.getElementById("searchbar").value;
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

 try {
          String DB_URL="jdbc:mysql://localhost:3306/alzib";
          String DB_ID="multi";
          String DB_PASSWORD="abcd";

          Class.forName("org.gjt.mm.mysql.Driver");
          Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
		
		String group_index;
    int list_index;

    group_index = request.getParameter("group_index");

    if (group_index != null)
        list_index = Integer.parseInt(group_index);
    else
        list_index = 0; // 현재 페이지 수

    int pageSize = 10; // 페이지당 보여줄 게시글 수

    String Category = request.getParameter("Category");
    String jsqlCategory = "SELECT * FROM sns WHERE Category = ? ORDER BY Sdate DESC LIMIT ?, ?";

    PreparedStatement pstmt = con.prepareStatement(jsqlCategory);
    pstmt.setString(1, Category);
    pstmt.setInt(2, list_index * pageSize); // 시작 인덱스 계산
    pstmt.setInt(3, pageSize); // 페이지당 보여줄 게시글 수

    ResultSet rs = pstmt.executeQuery();

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
	<div class="side_left">
		<div class="category_wrap">
			<ul>
				<li><a href="sns_free.jsp?Category=free">자유게시판</a></li>
				<li><a href="sns_information.jsp?Category=information">정보게시판</a></li>
				<li><a href="sns_complain.jsp?Category=complain">하소연게시판</a></li>
				<li><a href="sns_q.jsp?Category=q">질문게시판</a></li>
				<li><a href="sns_after.jsp?Category=after">후기게시판</a></li>
			</ul>
		</div>
	</div>	

	
  <div class="main">
		<div class="board_wrap">
			<div class="search_wrap">
				<table>
					<th id="th_logo">
					</th>
					<th id="th_search">
						<input type="text" name="keyword" id="searchbar" placeholder="검색어를 입력하세요" onkeypress="onKeyPress(event)"> &nbsp;
						<input type="button" id="button" value="search" onclick="search('complain')">
					</th>
				</table>
			</div>
			
			<div class="ad_wrap">
				<a href="#"><table><tr><td>광고이미지 크기</td></tr></table></a>
			</div>
			
			<div class="board_wrap">
				<div class="head">
					<h2>하소연게시판</h2>
				</div>

<%
	while(rs.next()){
		int SId =  rs.getInt("SId");
		String Title = rs.getString("Title");
		String Content = rs.getString("Content");
		String Sdate = rs.getString("Sdate");
		int Viewcount = rs.getInt("Viewcount");
		int heart = rs.getInt("heart");
 %>	

 <%
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

				<div class="content_wrap">
					<a href="sns_detailview.jsp?SId=<%=SId%>">
						<table>
							<tr>
								<td>
									<font color="gray" size="2"><%=Category_name%>
									</font>
								</td>
								<!--<td rowspan="4" class="image">
									본문 이미지
								</td>-->
							</tr>
							<tr>
								<td><h3><%=Title%></h3></td>
							</tr>
							<tr>
								<td><%=Content%></td>
							</tr>
							<tr>
								<td><font color="gray" size="2"><%=Sdate%> &nbsp; 조회수 <%=Viewcount%></font></td>
							</tr>
						</table>
					</a>
				</div>
<%
	}  
%>				<br>
            <div align="center">
                <table width="700" border="0" cellspacing="0" cellpadding="5">
                    <tr>&nbsp;</tr>
                    <tr>
                        <td colspan="5">
                            <div align="center">
                                <%-- 처음 페이지로 이동 --%>
                                <a href="sns_complain.jsp?Category=<%=Category%>&group_index=0">
                                    <img src="images/before_icon.png" alt="처음">
                                </a>
                                <span id="pagenumber">
                                <%-- 페이지 번호 출력 --%>
                                <% 
                                    for (int j = 0; j < totalPage; j++) {
                                        if (j == list_index) {
                                %>
                                            <span id="present"><%= j + 1 %></span>
                                <%
                                        } else {
                                %>
                                            <a href="sns_complain.jsp?Category=<%=Category%>&group_index=<%= j %>"><%= j + 1 %></a>
                                <%
                                        }
                                    }
                                %>
								</span>

                                &nbsp;&nbsp;&nbsp;
                                <%-- 마지막 페이지로 이동 --%>
                                <a href="sns_complain.jsp?Category=<%=Category%>&group_index=<%= totalPage - 1 %>">
                                    <img src="images/after_icon.png" alt="끝">
                                </a>
                            </div>
			</div>
		</div>
	</div>
	
	
	<div class="side_right">
		<div class="my_wrap">
			<a href="sns_write.jsp"><input type="button" value="게시글 작성" id="write_button"></a>
			<br><br><br><br>
			
			<div class="my">
			<span id="memberid"><%=myid%></span>
			<span id="text">님의 활동</span><br><br>
			
			<ul>
                <li align="left"><a href="sns_mywrite.jsp">내가 쓴 게시글</a></li>
                <li align="left"><a href="sns_mycomment.jsp">내가 쓴 댓글</a></li>
				<li align="left"><a href="sns_myscrap.jsp">스크랩한 게시글</a></li>
            </ul>
			</div>
		</div>
	</div>
</div>
<%
 }catch (Exception e) {
out.println(e);  
}
%>
</body>
</html>

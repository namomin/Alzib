<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>카테고리별 게시판</title>
    <link href="sns_category.css" rel="stylesheet" type="text/css">

    <script>
        function search() {
            var keyword = document.getElementById("searchbar").value;
            window.location.href = "sns_categorysearchResult.jsp?keyword=" + encodeURIComponent(keyword);
        }

        function onKeyPress(event) {
            if (event.keyCode === 13) {
                search();
            }
        }
    </script>
</head>
<body>
<div class="wrap">
    <div class="main_wrap">
<%
	String Category = request.getParameter("Category");
	String Category_name;

	if (Category != null) {
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
	}
	else {
		Category_name = "전체게시판";
	}
%>

        <div class="head_wrap">
            <table>
                <th align="left">
                    <a href="sns_main.jsp"><button>메인</button></a>
                    <h2><%= Category_name %></h2>
                    <% 
                    String keyword = request.getParameter("keyword");
                    if (keyword != null && !keyword.isEmpty()) {
                        out.println("'" + keyword + "' 검색 결과");
                    }
                    %>
                </th>
                <th align="right">
                    <input type="text" id="searchbar" name="keyword" placeholder="검색어를 입력하세요" onkeypress="onKeyPress(event)">
                    <input type="button" value="search" onclick="search()">
                </th>
            </table>
        </div>

        <div class="table_wrap">
            <table>
                <th><a href="sns_categoryview.jsp?Category=free">자유</a></th>
                <th><a href="sns_categoryview.jsp?Category=information">정보</a></th>
                <th><a href="sns_categoryview.jsp?Category=complain">하소연</a></th>
                <th><a href="sns_categoryview.jsp?Category=q">질문</a></th>
                <th><a href="sns_categoryview.jsp?Category=after">후기</a></th>
            </table>

<%
	String DB_URL = "jdbc:mysql://localhost:3306/alzib";
	String DB_ID = "multi";
	String DB_PASSWORD = "abcd";

	String word = request.getParameter("keyword");

	try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	String sql = "SELECT * FROM sns WHERE Title LIKE ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, "%" + word + "%");
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next()) {
		int SId =  rs.getInt("SId");
		String Title = rs.getString("Title");
		String Sdate = rs.getString("Sdate");
%>
                    
                    <div class="detailview">
                        <a href="sns_detailview.jsp?SId=<%=SId%>">
                            <table>
                                <tr>
                                    <td><h3><%=Title%></h3></td>
                                </tr>
                                <tr>
                                    <td id="si"><%=Sdate%> &nbsp; 조회수9999 &nbsp; 좋아요9999</td>
                                </tr>
                            </table>
                        </a>
                    </div>
<%
}

rs.close();
pstmt.close();
con.close();
} catch (Exception e) {
out.println(e);
}
%>
        </div>
    </div>
</div>
</body>
</html>

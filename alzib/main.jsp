<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>alzib</title>
<link href="main.css" rel="stylesheet" type="text/css">
<style>
        #frame{
            width: 100%;
            height: 645px;
            text-align: center;
            position: absolute;
        }
        iframe{
            width: 100%;
            height: 100%;
            border: none;
        }
</style>
</head>

<body>
<%
    request.setCharacterEncoding("UTF-8");
    String Id = (String) session.getAttribute("sid");
    
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int currentPage = 1; // 기본 페이지는 1
    int recordsPerPage = 10; // 페이지당 게시글 수
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    int totalPosts = 0;
    int totalPages = 0;

    try {
        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성: 총 게시글 수 조회
        String countQuery = "SELECT COUNT(*) AS count FROM Post";
        pstmt = con.prepareStatement(countQuery);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("count");
        }

        // 총 페이지 수 계산
        totalPages = (int) Math.ceil((double) totalPosts / recordsPerPage);

        // SQL 쿼리 작성: 현재 페이지에 표시될 게시글 목록 조회
        int start = (currentPage - 1) * recordsPerPage;
        String query = "SELECT * FROM Post ORDER BY PostNum DESC LIMIT ?, ?";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, start);
        pstmt.setInt(2, recordsPerPage);
        rs = pstmt.executeQuery();
%>

<div class="wrap">
<section class="key">
    <a href="main.jsp"><img src="images/main_1.png"></a>
</section>
<br>
<section class="brand">
    <ul>
        <h1 align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;업종별 공고 목록</h1>

        <a href="postlist_category.jsp?category=교육/강사" target="index">
        <li class="f">
            <img src="images/6.png">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;학원 강사, 과외 등등</p>
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;교육직 공고</h3>
            <p><font color="#ccc">&nbsp;&nbsp;&nbsp;&nbsp;전국 / 최신 공고 확인</font></p>
        </li>
        </a>
        
        <a href="postlist_category.jsp?category=서비스" target="index">
        <li class="b">
            <img src="images/2.png">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;콜센터 등등</p>
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;서비스직 공고</h3>
            <p><font color="#ccc">&nbsp;&nbsp;&nbsp;&nbsp;전국 / 최신 공고 확인</font></p>
        </li>

        <a href="postlist_category.jsp?category=사무직" target="index">
        <li class="c">
            <img src="images/3.png">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;출판사 등등</p>
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;사무직 공고</h3>
            <p><font color="#ccc">&nbsp;&nbsp;&nbsp;&nbsp;전국 / ₩ 공고 확인</font></p>
        </li>

        <a href="postlist_category.jsp?category=생산/건설" target="index">
        <li class="d">
            <img src="images/4.png">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;쿠팡, 대한통운 등등</p>
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;생산직 공고</h3>
            <p><font color="#ccc">&nbsp;&nbsp;&nbsp;&nbsp;전국 / 최신 공고 확인</font></p>
        </li>

        <a href="postlist_category.jsp?category=매장 관리/판매" target="index">
        <li class="e">
            <img src="images/5.png">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;CU, GS25 등등</p>
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;관리 / 판매직 공고</h3>
            <p><font color="#ccc">&nbsp;&nbsp;&nbsp;&nbsp;전국 / 최신 공고 확인</font></p>
        </li>

        <a href="postlist_category.jsp?category=외식/음료" target="index">
        <li class="a">
            <img src="images/1.png">
            <p>&nbsp;&nbsp;&nbsp;&nbsp;버거킹, 서브웨이 등등</p>
            <h3>&nbsp;&nbsp;&nbsp;&nbsp;외식 / 음료 공고</h3>
            <p><font color="#ccc">&nbsp;&nbsp;&nbsp;&nbsp;전국 / 최신 공고 확인</font></p>
        </li>       
    </ul>
</section>

<section class="banner1">
    <a href="snsmain.jsp"><img src="images/b_001.png" class="b_1" alt="Image 1"></a>
    <a href="recommend.jsp"><img src="images/b_002.png" class="b_2" alt="Image 2"></a>
</section>

<br><br>
<div class="table_wrap">
<div class="menubutton">
    <table id="list_header">
        <tr>
            <td id="list" align="left"><a href="post_list.jsp">최신 공고</a></td>
            <td id="button" align="right"><a href="fillterSearch.jsp"><img src="images/menu.png" alt="필터검색"></a></td>
        </tr>
    </table>
</div>
<div class="detailview">

    <table>
        <tr>
            <th width="200px">기업명</th>
            <th width="700px">공고 제목</th>
            <th width="200px">근무 시간</th>
            <th width="200px">급여</th>
        </tr>

<%
    while (rs.next()) {
        String PostNum = rs.getString("PostNum");
        String BStore =rs.getString("BStore");
        String Title = rs.getString("Title");
        String Day = rs.getString("Day");
        String Time = rs.getString("Time");
        String Pay = rs.getString("Pay");
%>
        <tr>
            <td>
            <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=BStore%></a>
            </td>
            <td>
                <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a>
            </td>
            <td>
                <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Day%> / <%=Time%></a>
            </td>
            <td align="right">
                <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Pay%></a>
            </td>
        </tr>
<%
    }    
%>

    </table>
    <div class="page">
    <%
        // 이전 페이지
        if (currentPage > 1) {
            int prevPage = currentPage - 1;
            out.println("<a href='?currentPage=" + prevPage + "'> < </a>" + "&nbsp;");
        }

        // 페이지 번호 표시
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
                out.println("<span class='active'>" + i + "</span>");
            } else {
                out.println("<a href='?currentPage=" + i + "'>" + i + "</a>");
            }
            out.println("&nbsp;");
        }

        // 다음 페이지
        if (currentPage < totalPages) {
            int nextPage = currentPage + 1;
            out.println("<a href='?currentPage=" + nextPage + "'> > </a>");
        }
    %>

    </div>
<br>
</div>        
</div>

</body>
</html>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

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
                // 엔터 검색
                search();
            }
        }
    </script>
</head>
<body>
<%
try {
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    request.setCharacterEncoding("euc-kr");

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
    <div class="main_wrap">
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

        <div class="head_wrap">
            <table>
                <th align="left">
                    <a href="sns_main.jsp"><button>메인</button></a>

                    <h2><%=Category_name%></h2></th>
                <th align="right">
                    <input type="text" id="searchbar" name="keyword" placeholder="제대로 동작안함"
                           onkeypress="onKeyPress(event)">
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
                while (rs.next()) {
                    int SId = rs.getInt("SId");
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
                } //  while문의 끝
            %>

            <div><font size=2 color=red>현재 페이지 / 총 페이지 &nbsp(<%= list_index + 1 %> / <%= totalPage %>)</font></div>

            <div align="center">
                <table width="700" border="0" cellspacing="0" cellpadding="5">
                    <tr>&nbsp;</tr>
                    <tr>
                        <td colspan="5">
                            <div align="center">
                                <%-- 처음 페이지로 이동 --%>
                                <a href="sns_categoryview.jsp?Category=<%=Category%>&group_index=0">
                                    <img src="images/before_icon.png" alt="처음">
                                </a>
                                
                                <%-- 페이지 번호 출력 --%>
                                <% 
                                    for (int j = 0; j < totalPage; j++) {
                                        if (j == list_index) {
                                %>
                                            <%= j + 1 %>
                                <%
                                        } else {
                                %>
                                            <a href="sns_categoryview.jsp?Category=<%=Category%>&group_index=<%= j %>"><%= j + 1 %></a>
                                <%
                                        }
                                    }
                                %>

                                &nbsp;&nbsp;&nbsp;
                                <%-- 마지막 페이지로 이동 --%>
                                <a href="sns_categoryview.jsp?Category=<%=Category%>&group_index=<%= totalPage - 1 %>">
                                    <img src="images/after_icon.png" alt="끝">
                                </a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        out.println(e);
    }
%>
</body>
</html>

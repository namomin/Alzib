<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>ī�װ��� �Խ���</title>
    <link href="sns_category.css" rel="stylesheet" type="text/css">
    <script>
        function search() {
            var keyword = document.getElementById("searchbar").value;
            window.location.href = "sns_categorysearchResult.jsp?keyword=" + encodeURIComponent(keyword);
        }

        function onKeyPress(event) {
            if (event.keyCode === 13) {
                // ���� �˻�
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
        list_index = 0; // ���� ������ ��

    int pageSize = 10; // �������� ������ �Խñ� ��

    String Category = request.getParameter("Category");
    String jsqlCategory = "SELECT * FROM sns WHERE Category = ? ORDER BY Sdate DESC LIMIT ?, ?";

    PreparedStatement pstmt = con.prepareStatement(jsqlCategory);
    pstmt.setString(1, Category);
    pstmt.setInt(2, list_index * pageSize); // ���� �ε��� ���
    pstmt.setInt(3, pageSize); // �������� ������ �Խñ� ��

    ResultSet rs = pstmt.executeQuery();

    // �Խñ� �� ��ȸ
    String countQuery = "SELECT COUNT(*) FROM sns WHERE Category = ?";
    PreparedStatement countStmt = con.prepareStatement(countQuery);
    countStmt.setString(1, Category);
    ResultSet countRs = countStmt.executeQuery();
    countRs.next();
    int totalPosts = countRs.getInt(1);
    int totalPage = (int) Math.ceil((double) totalPosts / pageSize); // �� ������ ��

%>
<div class="wrap">
    <div class="main_wrap">
        <%
            String Category_name;

            if (Category.equals("free"))
                Category_name = "�����Խ���";
            else if (Category.equals("information"))
                Category_name = "�����Խ���";
            else if (Category.equals("complain"))
                Category_name = "�ϼҿ��Խ���";
            else if (Category.equals("q"))
                Category_name = "�����Խ���";
            else
                Category_name = "�ı�Խ���";
        %>

        <div class="head_wrap">
            <table>
                <th align="left">
                    <a href="sns_main.jsp"><button>����</button></a>

                    <h2><%=Category_name%></h2></th>
                <th align="right">
                    <input type="text" id="searchbar" name="keyword" placeholder="����� ���۾���"
                           onkeypress="onKeyPress(event)">
                    <input type="button" value="search" onclick="search()">
                </th>
            </table>
        </div>

        <div class="table_wrap">
            <table>
                <th><a href="sns_categoryview.jsp?Category=free">����</a></th>
                <th><a href="sns_categoryview.jsp?Category=information">����</a></th>
                <th><a href="sns_categoryview.jsp?Category=complain">�ϼҿ�</a></th>
                <th><a href="sns_categoryview.jsp?Category=q">����</a></th>
                <th><a href="sns_categoryview.jsp?Category=after">�ı�</a></th>
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
                                    <td id="si"><%=Sdate%> &nbsp; ��ȸ��9999 &nbsp; ���ƿ�9999</td>
                                </tr>
                            </table>
                        </a>
                    </div>
            <%
                } //  while���� ��
            %>

            <div><font size=2 color=red>���� ������ / �� ������ &nbsp(<%= list_index + 1 %> / <%= totalPage %>)</font></div>

            <div align="center">
                <table width="700" border="0" cellspacing="0" cellpadding="5">
                    <tr>&nbsp;</tr>
                    <tr>
                        <td colspan="5">
                            <div align="center">
                                <%-- ó�� �������� �̵� --%>
                                <a href="sns_categoryview.jsp?Category=<%=Category%>&group_index=0">
                                    <img src="images/before_icon.png" alt="ó��">
                                </a>
                                
                                <%-- ������ ��ȣ ��� --%>
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
                                <%-- ������ �������� �̵� --%>
                                <a href="sns_categoryview.jsp?Category=<%=Category%>&group_index=<%= totalPage - 1 %>">
                                    <img src="images/after_icon.png" alt="��">
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

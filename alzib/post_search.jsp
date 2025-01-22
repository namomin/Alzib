<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    // PostNum ���� 
    String Id = (String) session.getAttribute("sid");
    String keyword = request.getParameter("keyword");
    
    // �����ͺ��̽� ���� ����
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // �����ͺ��̽� ���� ����
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // ���������̼��� ���� ����
    int currentPage = 1; // �⺻ �������� 1
    int recordsPerPage = 10; // �������� �Խñ� ��
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    // �� �Խñ� ��
    int totalPosts = 0;
    int totalPages = 0;

    try {
        // �����ͺ��̽� ����
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL ���� �ۼ�: �˻�� ���� �Խñ� ��� ��ȸ
        String countQuery = "SELECT COUNT(*) AS count FROM Post WHERE BStore LIKE ? OR Title LIKE ?";
        pstmt = con.prepareStatement(countQuery);
        pstmt.setString(1, "%" + keyword + "%");
        pstmt.setString(2, "%" + keyword + "%");
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("count");
        }

        // �� ������ �� ���
        totalPages = (int) Math.ceil((double) totalPosts / recordsPerPage);

        // SQL ���� �ۼ�: ���� �������� ǥ�õ� �Խñ� ��� ��ȸ
        int start = (currentPage - 1) * recordsPerPage;
        String query = "SELECT * FROM Post WHERE BStore LIKE ? OR Title LIKE ? ORDER BY PostNum DESC LIMIT ?, ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, "%" + keyword + "%");
        pstmt.setString(2, "%" + keyword + "%");
        pstmt.setInt(3, start);
        pstmt.setInt(4, recordsPerPage);
        rs = pstmt.executeQuery();
%>

<html>
<head>
    <title>�˻� ���</title>
    <link href="post_list.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
</head>
<body>
<div class="wrap">
    <div class="postlist">

    <div class="border_wrap">
    <div class="menubutton">
        <table id="list_header">
            <tr>
                <td id="list" align="left"> <font color="#689ADE">'<%=keyword%>'</font> �˻� ���</td>
                <td id="button" align="right"><a href="fillterSearch.jsp"><img src="images/menu.png" alt="���Ͱ˻�"></a></td>
            </tr>
        </table>
    </div>
        <table>
            <tr>
                <th>���/������</th>
                <th>��������</th>
                <th>�ٹ��ð�</th>
                <th>�޿�</th>
            </tr>
            <% if (totalPosts == 0) { %>
                <tr>
                    <td colspan="4">ã���ô� ������� �����ϴ�.</td>
                </tr>
<% } else { %>
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
                <td>
                    <a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Pay%></a>
                </td>
            </tr>
        
<%
    }
}
%>
        </table>
    </div>  
    
    <div class="page">
    <%
        // ���� ������
        if (currentPage > 1) {
            int prevPage = currentPage - 1;
            out.println("<a href='?keyword=" + keyword + "&currentPage=" + prevPage + "'> < </a>");
        }

        // ������ ��ȣ ǥ��
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
                out.println("<span class='active'>" + i + "</span>");
            } else {
                out.println("<a href='?keyword=" + keyword + "&currentPage=" + i + "'>" + i + "</a>");
            }
			out.println("&nbsp;");
        }

        // ���� ������
        if (currentPage < totalPages) {
            int nextPage = currentPage + 1;
            out.println("<a href='?keyword=" + keyword + "&currentPage=" + nextPage + "'> > </a>");
        }
    %>

    </div>

</div>

</div>

</div>
</body>
</html>

<%
    } catch (SQLException e) {
        // SQL ���� ó��
        e.printStackTrace();
    } finally {
        // ���� ����
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

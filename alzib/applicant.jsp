<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>�������� �̷¼�</title>
<link href="applicant.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="wrap">
<div class="board_wrap">
 
    <div class="head_wrap">
        <span></span>
    </div>
    <div class="body_wrap">
        <div class="resume_wrap">
            <div class="resume_title">
                <span>�������� �̷¼�</span>
            </div>
            <div class="resume_table">
                <table>
                    <tr>
						<th>������ �̸�</th>
                        <th>�̷¼� ����</th>
						<th>����</th>
                        <th>ä�� ����</th>
                    </tr>
                    <% 
                    try {
                        String postNum = request.getParameter("PostNum");
                        String BId = request.getParameter("BId");
						

                        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
                        String DB_ID = "multi";
                        String DB_PASSWORD = "abcd";
                        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                        // PostNum ���� �ش��ϴ� Title�� �������� ����
                        String titleQuery = "SELECT Title FROM post WHERE PostNum = ?";
                        PreparedStatement titlePstmt = con.prepareStatement(titleQuery);
                        titlePstmt.setString(1, postNum);
                        ResultSet titleRs = titlePstmt.executeQuery();
                        
                        String title = ""; // Title �ʱ�ȭ
                        if (titleRs.next()) {
                            title = titleRs.getString("Title"); // Title �� ����
                        }
                        titleRs.close();
                        titlePstmt.close();

                        String query = "SELECT a.applyId, r.RId, r.RTitle, a.state, a.AName FROM resume r INNER JOIN apply a ON r.RId = a.RId WHERE a.PostNum = ?";

                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, postNum);
                        ResultSet rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String RTitle = rs.getString("RTitle");
                            int RId = rs.getInt("RId");
                            int applyId = rs.getInt("applyId");
                            String state = rs.getString("state");
							String AName = rs.getString("AName");
                            if (state == null) {
                                state = "Ȯ����";
                            }
                    %>
                    <tr>
						<td><%=AName%></td>
                        <td>
                            <a href="applicant_resume.jsp?RId=<%=RId%>" target="_blank"><%=RTitle%></a>
                        </td>
                        <td>
                            <a href="apply_hire.jsp?applyId=<%=applyId%>&PostNum=<%=postNum%>&RId=<%=RId%>&BId=<%=BId%>"><input type="button" value="ä��"></a>
                            <a href="apply_fail.jsp?applyId=<%=applyId%>&PostNum=<%=postNum%>&RId=<%=RId%>&BId=<%=BId%>"><br><input type="button" value="��ä��"></a>
                        </td>
                        <td><%=state%></td>
                    </tr>
                    <% 
                        }
                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        out.println(e);
                    }
                    %>
                </table>
            </div>
        </div>
        
    </div>
</div>
</div>  
</body>
</html>

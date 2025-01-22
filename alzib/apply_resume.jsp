<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>apply_resume</title>
<link href="apply_resume.css" rel="stylesheet" type="text/css">
</head>

<body>
<% 
                    try {
						String Title = request.getParameter("Title");
                        String postNum = request.getParameter("PostNum");
                        String BId = request.getParameter("BId");
                        

                        String DB_URL = "jdbc:mysql://localhost:3306/alzib";
                        String DB_ID = "multi";
                        String DB_PASSWORD = "abcd";
                        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                        // PostNum 값에 해당하는 Title을 가져오는 쿼리
                        String titleQuery = "SELECT Title FROM post WHERE PostNum = ?";
                        PreparedStatement titlePstmt = con.prepareStatement(titleQuery);
                        titlePstmt.setString(1, postNum);
                        ResultSet titleRs = titlePstmt.executeQuery();
                        
                        String title = ""; // Title 초기화
                        if (titleRs.next()) {
                            title = titleRs.getString("Title"); // Title 값 설정
                        }
                        titleRs.close();
                        titlePstmt.close();

                        String query = "SELECT a.applyId, r.RId, r.RTitle, a.state, a.AName, r.AId, p.BStore " +
               "FROM resume r INNER JOIN apply a ON r.RId = a.RId " +
               "INNER JOIN post p ON a.PostNum = p.PostNum " +
               "WHERE a.PostNum = ?";


                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, postNum);
                        ResultSet rs = pstmt.executeQuery();
%>
<div class="wrap">
    <div class="head_wrap">
        <span id="title"><%=Title%></span><br>
        <span>지원받은 이력서 현황</span>
    </div>
    <div class="border_wrap">
        <table>
            <tr>
                <th>지원자 이름</th>
                <th>이력서 제목</th>
                <th>관리</th>
                <th>상태</th>
            </tr>
<%
                        while (rs.next()) {
                            String AId = rs.getString("AId");
							String BStore = rs.getString("BStore");
                            String RTitle = rs.getString("RTitle");
                            int RId = rs.getInt("RId");
                            int applyId = rs.getInt("applyId");
                            String state = rs.getString("state");
                            String AName = rs.getString("AName");
                            if (state == null) {
                                state = "확인중";
                            }
%>

            <tr>
                <td><%=AName%></td>
                <td>
					<%--state가 '불채용'이 아닌 경우에만 링크가 동작--%>
					<% if (state == null || !state.equals("불채용")) { %>
						<a href="applicant_resume.jsp?RId=<%=RId%>" target="_blank"><%= RTitle %></a>
					<% } else { %>
						<%= RTitle %>
					<% } %>
</td>

                <td>
					<a href="apply_interview.jsp?applyId=<%=applyId%>&PostNum=<%=postNum%>&RId=<%=RId%>&AId=<%=AId%>&BId=<%=BId%>&Title=<%=Title%>"><input type="button" value="면접" id="interview"></a>
					<br>
                    <a href="apply_hire.jsp?applyId=<%=applyId%>&PostNum=<%=postNum%>&RId=<%=RId%>&AId=<%=AId%>&BId=<%=BId%>&BStore=<%=BStore%>&Title=<%=Title%>"><input type="button" value="채용"></a>
					
                    <a href="apply_fail.jsp?applyId=<%=applyId%>&PostNum=<%=postNum%>&RId=<%=RId%>&BId=<%=BId%>&AName=<%=AName%>&Title=<%=Title%>"><input type="button" value="불채용"></a>
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

<script>
console.log("Title: " + Title);
</script>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*, java.nio.file.*, java.util.*, javax.servlet.http.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시글 작성</title>
</head>
<body>
    <h2>게시글 작성</h2>
    <form action="write_post_result.jsp" method="post">
        <label for="title">제목:</label><br>
        <input type="text" id="title" name="title" required><br><br>
        
        <label for="content">내용:</label><br>
        <textarea id="content" name="content" rows="4" cols="50" required></textarea><br><br>
        
        <!-- 이미지 파일 이름을 게시글 작성 페이지로 전달 -->
        <% 
            String imageFileName = (String) session.getAttribute("imageFileName");
            if (imageFileName != null) {
        %>
                <input type="hidden" name="imageFileName" value="<%=imageFileName%>">
        <% } %>

        <input type="submit" value="게시글 작성">
    </form>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>에러 페이지</title>
</head>
<body>
    <script>
        alert('<%= request.getAttribute("message") %>'); // 에러 메시지를 출력
        window.history.back(); // 이전 페이지로 이동
    </script>
</body>
</html>

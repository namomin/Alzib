<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성 결과</title>
</head>
<body>
    <%
		request.setCharacterEncoding("UTF-8");
		String BId = (String) session.getAttribute("sid");
        String BStore = request.getParameter("BStore");
        String BName = request.getParameter("BName");
        String BAddress = request.getParameter("BAddress");
        String BPhone = request.getParameter("BPhone");
        String BEmail = request.getParameter("BEmail");
        String Title = request.getParameter("Title");
        String Category = request.getParameter("Category");
        String Type = request.getParameter("Type");
        String Personnel = request.getParameter("Personnel");
        String Sex = request.getParameter("Sex");
        String Age = request.getParameter("Age");
        String Ability = request.getParameter("Ability");
        String Preferential = ""; // 선택된 우대조건을 저장할 변수
        String Period = request.getParameter("Period");
        String Day = ""; // 근무 요일을 저장할 변수
        String Time = request.getParameter("Time1") + "~" + request.getParameter("Time2");
        String Pay1 = request.getParameter("Pay1");
		String Pay2 = request.getParameter("Pay2");
		String Pay = Pay1 + "("+ Pay2 +")"; 
        String Welfare = ""; // 선택된 복리후생을 저장할 변수
        String Etc = request.getParameter("Etc");
		String x = request.getParameter("x");
		String y = request.getParameter("y");

        // 우대조건 값 처리
        String[] PreferentialOptions = {"preferential1", "preferential2", "preferential3"};
        for (String option : PreferentialOptions) {
            String CheckboxValue = request.getParameter(option);
            if (CheckboxValue != null) {
                Preferential += CheckboxValue + ",";
            }
        }
        if (!Preferential.isEmpty()) {
            Preferential = Preferential.substring(0, Preferential.length() - 1); // 마지막 쉼표 제거
        }


        // 근무 요일 값 처리
        String Selector = request.getParameter("Selector");
        if (Selector.equals("요일 지정")) {
            for (int i = 1; i <= 7; i++) {
                String DayCheckbox = request.getParameter("day" + i);
                if (DayCheckbox != null) {
                    Day += DayCheckbox + ",";
                }
            }
            if (!Day.isEmpty()) {
                Day = Day.substring(0, Day.length() - 1); // 마지막 점 제거
            }
        } else if (Selector.equals("요일 협의")) {
            Day = "요일 협의";
        }

        // 복리후생 값 처리
        String[] WelfareOptions = {"Welfare1", "Welfare2", "Welfare3", "Welfare4", "Welfare5", "Welfare6", "Welfare7"};
        for (String option : WelfareOptions) {
            String CheckboxValue = request.getParameter(option);
            if (CheckboxValue != null) {
                Welfare += CheckboxValue + ",";
            }
        }
        if (!Welfare.isEmpty()) {
            Welfare = Welfare.substring(0, Welfare.length() - 1); // 마지막 쉼표 제거
        }

    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // JDBC 드라이버 로드
		Class.forName("com.mysql.jdbc.Driver");
        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성
        String query = "INSERT INTO Post (BId, BStore, BName, BAddress, BPhone, BEmail, Title, Category, Type, Personnel, Sex, Age, Ability, Preferential, Period, Day, Time, Pay, Welfare, Etc, x, y) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // PreparedStatement 객체 생성
        pstmt = con.prepareStatement(query);

        // SQL 쿼리에 값 설정
        pstmt.setString(1, BId);
        pstmt.setString(2, BStore);
        pstmt.setString(3, BName);
        pstmt.setString(4, BAddress);
        pstmt.setString(5, BPhone);
        pstmt.setString(6, BEmail);
        pstmt.setString(7, Title);
        pstmt.setString(8, Category);
        pstmt.setString(9, Type);
        pstmt.setString(10, Personnel);
        pstmt.setString(11, Sex);
        pstmt.setString(12, Age);
        pstmt.setString(13, Ability);
        pstmt.setString(14, Preferential);
        pstmt.setString(15, Period);
        pstmt.setString(16, Day);
        pstmt.setString(17, Time);
        pstmt.setString(18, Pay);
        pstmt.setString(19, Welfare);
        pstmt.setString(20, Etc);
		pstmt.setString(21, x);
		pstmt.setString(22, y);

        // SQL 실행
        int RowsAffected = pstmt.executeUpdate();

        // 결과 확인
        if (RowsAffected > 0) {
            out.println("<p>공고 게시글이 저장되었습니다.</p>");
        } else {
            out.println("<p>공고 게시글 작성이 취소되었습니다.</p>");
        }

    } catch (SQLException e) {
        out.println("<p>데이터베이스 오류 발생: " + e.getMessage() + "</p>");
        e.printStackTrace(); // 예외 정보 출력
    } catch (Exception e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
        e.printStackTrace(); // 예외 정보 출력
    } finally {
        // 자원 해제
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p>데이터베이스 연결 해제 오류: " + e.getMessage() + "</p>");
        }
    }
    %>

</body>
</html>

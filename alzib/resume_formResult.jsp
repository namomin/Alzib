<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    // 세션에서 AId 값 가져오기
    String AId = (String) session.getAttribute("sid");

    String AName = request.getParameter("AName");
    String ABirth = request.getParameter("ABirth");
    String APhone = request.getParameter("APhone");
    String AEmail = request.getParameter("AEmail");
    String RTitle = request.getParameter("RTitle");
    String RAbility = request.getParameter("RAbility1") + "(" + request.getParameter("RAbility2") + ")";
    String RHigh = request.getParameter("RHigh");

    // RCollege 수정
    String RCollege1 = request.getParameter("RCollege1");
    String RCollege2 = request.getParameter("RCollege2");
    String RCollege;
    if (RCollege1 != null && RCollege2 != null) {
        RCollege = RCollege1 + "(" + RCollege2 + ")";
    } else {
        RCollege = null;
    }

    // RCareer 수정
    String RCareer = request.getParameter("RCareer0") + " " + "\n";
    if (request.getParameter("RCareer1") != null && request.getParameter("RCareer2") != null) {
        RCareer += request.getParameter("RCareer1") + ":" + request.getParameter("RCareer2") + "\n";
    }
    if (request.getParameter("RCareer3") != null && request.getParameter("RCareer4") != null) {
        RCareer += request.getParameter("RCareer3") + ":" + request.getParameter("RCareer4") + "\n";
    }
    if (request.getParameter("RCareer5") != null && request.getParameter("RCareer6") != null) {
        RCareer += request.getParameter("RCareer5") + ":" + request.getParameter("RCareer6") + "\n";
    }
    if (request.getParameter("RCareer7") != null && request.getParameter("RCareer8") != null) {
        RCareer += request.getParameter("RCareer7") + ":" + request.getParameter("RCareer8") + "\n";
    }
    if (request.getParameter("RCareer9") != null && request.getParameter("RCareer10") != null) {
        RCareer += request.getParameter("RCareer9") + ":" + request.getParameter("RCareer10");
    }

    // HArea 수정
    String HArea1 = request.getParameter("HArea1");
    String HArea2 = request.getParameter("HArea2");
    String HArea = HArea1;
    if (HArea2 != null) {
        HArea = HArea1 + "(" + HArea2 + ")";
    }

    // HType 수정
    String HType = "";
    for (int i = 1; i <= 11; i++) {
        String typeValue = request.getParameter("HType" + i);
        if (typeValue != null && !typeValue.isEmpty()) {
            HType += typeValue + ",";
        }
    }
    if (HType.endsWith(",")) {
        HType = HType.substring(0, HType.length() - 1); // 마지막 쉼표 제거
    }

    // HSalary 수정
    String HSalary1 = request.getParameter("HSalary1");
    String HSalary2 = request.getParameter("HSalary2");
    String HSalary = HSalary1;
    if (HSalary2 != null) {
        HSalary += "(" + HSalary2 + ")";
    }

    String HForm = request.getParameter("HForm");
    String HPeriod = request.getParameter("HPeriod");
    String HDay = request.getParameter("HDay");
    String HTime = request.getParameter("HTime");
    String RIntroduce = request.getParameter("RIntroduce");
    String REtc = request.getParameter("REtc");

    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;

    boolean success = false; // 이력서 등록 성공 여부를 저장할 변수

    try {
		Class.forName("com.mysql.jdbc.Driver");
        // 데이터베이스 연결
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // SQL 쿼리 작성
        String query = "INSERT INTO Resume (AId, AName, ABirth, APhone, AEmail, RTitle, RAbility, RHigh, RCollege, RCareer, HArea, HType, HForm, HPeriod, HDay, HTime, HSalary, RIntroduce, REtc) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // PreparedStatement 객체 생성
        pstmt = con.prepareStatement(query);

        // SQL 쿼리에 파라미터 값 설정
        pstmt.setString(1, AId);
        pstmt.setString(2, AName);
        pstmt.setString(3, ABirth);
        pstmt.setString(4, APhone);
        pstmt.setString(5, AEmail);
        pstmt.setString(6, RTitle);
        pstmt.setString(7, RAbility);
        pstmt.setString(8, RHigh);
        pstmt.setString(9, RCollege);
        pstmt.setString(10, RCareer);
        pstmt.setString(11, HArea);
        pstmt.setString(12, HType);
        pstmt.setString(13, HForm);
        pstmt.setString(14, HPeriod);
        pstmt.setString(15, HDay);
        pstmt.setString(16, HTime);
        pstmt.setString(17, HSalary);
        pstmt.setString(18, RIntroduce);
        pstmt.setString(19, REtc);

        // SQL 실행
        int rowsInserted = pstmt.executeUpdate();

        // 성공적으로 데이터가 삽입되었는지 확인
        if (rowsInserted > 0) {
            success = true;
        }

        // 이력서 등록 성공 여부에 따라 메시지 출력
        if (success) {
            out.println("<p>이력서가 성공적으로 등록되었습니다.</p>");
        } else {
            // 이력서 등록에 실패했을 때 변수들의 값을 화면에 출력
            out.println("<p>이력서 등록에 실패했습니다.</p>");
            out.println("<p>AId: " + AId + "</p>");
            out.println("<p>AName: " + AName + "</p>");
            out.println("<p>ABirth: " + ABirth + "</p>");
            out.println("<p>APhone: " + APhone + "</p>");
            out.println("<p>AEmail: " + AEmail + "</p>");
            out.println("<p>RTitle: " + RTitle + "</p>");
            out.println("<p>RAbility: " + RAbility + "</p>");
            out.println("<p>RHigh: " + RHigh + "</p>");
            out.println("<p>RCollege: " + RCollege + "</p>");
            out.println("<p>RCareer: " + RCareer + "</p>");
            out.println("<p>HArea: " + HArea + "</p>");
            out.println("<p>HType: " + HType + "</p>");
            out.println("<p>HForm: " + HForm + "</p>");
            out.println("<p>HPeriod: " + HPeriod + "</p>");
            out.println("<p>HDay: " + HDay + "</p>");
            out.println("<p>HTime: " + HTime + "</p>");
            out.println("<p>HSalary: " + HSalary + "</p>");
            out.println("<p>RIntroduce: " + RIntroduce + "</p>");
            out.println("<p>REtc: " + REtc + "</p>");
        }

	response.sendRedirect("mypageAlba.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>이력서 등록에 실패했습니다.</p>");
        out.println("<p>AId: " + AId + "</p>");
        out.println("<p>AName: " + AName + "</p>");
        out.println("<p>ABirth: " + ABirth + "</p>");
        out.println("<p>APhone: " + APhone + "</p>");
        out.println("<p>AEmail: " + AEmail + "</p>");
        out.println("<p>RTitle: " + RTitle + "</p>");
        out.println("<p>RAbility: " + RAbility + "</p>");
        out.println("<p>RHigh: " + RHigh + "</p>");
        out.println("<p>RCollege: " + RCollege + "</p>");
        out.println("<p>RCareer: " + RCareer + "</p>");
        out.println("<p>HArea: " + HArea + "</p>");
        out.println("<p>HType: " + HType + "</p>");
        out.println("<p>HForm: " + HForm + "</p>");
        out.println("<p>HPeriod: " + HPeriod + "</p>");
        out.println("<p>HDay: " + HDay + "</p>");
        out.println("<p>HTime: " + HTime + "</p>");
        out.println("<p>HSalary: " + HSalary + "</p>");
        out.println("<p>RIntroduce: " + RIntroduce + "</p>");
        out.println("<p>REtc: " + REtc + "</p>");
    } finally {
        // 자원 해제
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

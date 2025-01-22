<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    // PostNum 설정 
    String Id = (String) session.getAttribute("sid");
	String Search = request.getParameter("Search");
    
    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/alzib";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // 데이터베이스 연결 변수
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 페이지네이션을 위한 변수
    int currentPage = 1; // 기본 페이지는 1
    int recordsPerPage = 10; // 페이지당 게시글 수
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    // 총 게시글 수
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
        String query = "SELECT * FROM Post where Title like ? ORDER BY PostNum DESC LIMIT ?, ?";
        pstmt = con.prepareStatement(query);
		pstmt.setString(1, "%" + Search + "%");
        pstmt.setInt(2, start);
        pstmt.setInt(3, recordsPerPage);
        rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공고 목록</title>
    <link href="post_list.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="wrap">
    <div class="main_wrap">
                <div class="head_wrap">
            <table>
                <th align="right">
                    <input type="text" placeholder="검색어를 입력하세요">&nbsp;
                    <input type="button">&nbsp;&nbsp;&nbsp;
                    <button id="filter-btn">필터</button>
                </th>
            </table>
        </div>
        <div class="filter-container">
        <div class="filter-item">
            <label for="area">근무 지역 :</label>
            <select id="area">
                <option value="all">전국</option>
                <option value="seoul">서울</option>
                <option value="gyeonggi">경기</option>
                <option value="incheon">인천</option>
				<option value="gangwon">강원</option>
				<option value="daejeon">대전</option>
				<option value="sejong">세종</option>
				<option value="chungnam">충남</option>
				<option value="chungbuk">충북</option>
				<option value="busan">부산</option>
				<option value="ulsan">울산</option>
				<option value="gyeongnam">경남</option>
				<option value="gyeongbuk">경북</option>
				<option value="daegu">대구</option>
				<option value="gwangju">광주</option>
				<option value="jeonnam">전남</option>
				<option value="jeonbuk">전북</option>
				<option value="jeju">제주</option>
            </select>
        </div>
		
		 <div class="filter-item">
            <label for="type">업직종 :</label>
            <select id="type">
				<option value="stype">업직종</option>
                <option value="drink">외식/음료</option>
				<option value="sell">매장 관리/판매</option>
				<option value="ser">서비스</option>
				<option value="paper">사무직</option>
				<option value="talk">고객 상담/리서치/영업</option>
				<option value="it">IT/기술</option>
				<option value="design">디자인</option>
				<option value="media">미디어</option>
				<option value="deli">운전/배달</option>
				<option value="edu">교육/강사</option>
            </select>
        </div>
		
		<div class="filter-item">
            <label for="period ">근무 기간 :</label>
            <select id="period ">
				<option value="speriod">근무 기간</option>
                <option value="day">하루</option>
				<option value="week">1주일 이하</option>
				<option value="1mon">1주일~1개월</option>
				<option value="3mon">1개월~3개월</option>
				<option value="6mon">3개월~6개월</option>
				<option value="year">6개월~1년</option>
				<option value="myear">1년 이상</option>
				<option value="pep">협의 제외</option>
            </select>
        </div>
		
		<div class="filter-item">
            <label for="day">근무 요일 :</label>
            <select id="day">
				<option value="sday">근무 요일</option>
				<option value="m-s">월~일</option>
				<option value="m-s">월~토</option>
				<option value="m-f">월~금</option>
				<option value="weekend">주말 (토,일)</option>
				<option value="6d">주6일</option>
				<option value="5d">주5일</option>
				<option value="4d">주5일</option>
				<option value="3d">주3일</option>
				<option value="2d">주2일</option>
				<option value="1d">주1일</option>
				<option value="dep">협의 제외</option>
            </select>
        </div>
		
		<div class="filter-item">
            <label for="time">근무 시간 :</label>
            <select id="time">
				<option value="stime">근무 시간</option>
                <option value="am">오전 파트</option>
				<option value="pm">오후 파트</option>
				<option value="noon">저녁 파트</option>
				<option value="mid">새벽 파트</option>
				<option value="ampm">오전~오후 파트</option>
				<option value="afternoon">오후~저녁 파트</option>
				<option value="midnight">저녁~새벽 파트</option>
				<option value="morning">새벽~오전 파트</option>
				<option value="all">올타임 (8시간 이상)</option>
            </select>
        </div>
		
		<div class="filter-item">
            <label for="sex">성별 :</label>
            <select id="sex">
				<option value="ssex">성별</option>
                <option value="female">여자</option>
				<option value="male">남자</option>
				<option value="sep">무관 제외</option>
            </select>
        </div>
		
		<div class="filter-item">
            <label for="age">연령 :</label>
    		<select id="age"></select>
        </div>
		
		<div class="filter-item">
            <label for="htype">고용 형태 :</label>
            <select id="htype">
				<option value="shtype">고용 형태</option>
                <option value="part">알바</option>
				<option value="reg">정규직</option>
				<option value="cont">계약직</option>
				<option value="dis">파견직</option>
				<option value="intern">인턴</option>
				<option value="free">프리랜서</option>
				<option value="tra">연수생/교육생</option>
            </select>
        </div>
		
		<div class="filter-item">
            <label for="epkey">제외 키워드 :</label>
            <input type="epkey" placeholder="제외할 키워드를 입력해주세요">
        </div>
        <button onclick="applyFilters()" id="in">적용</button>
	</div>
  </div>
        
        <div class="table_wrap">
            <table>
                <th><h1>공고 목록</h1></th>
            </table>

            <div class="detailview">
                <%
                    while (rs.next()) {
                        // 각 게시글 정보 가져오기
                        String PostNum = rs.getString("PostNum");
                        String Title = rs.getString("Title");
                        String Pay = rs.getString("Pay");
                        String Day = rs.getString("Day");
                        String Time = rs.getString("Time");
                %>
                <a href="postmapdetail.jsp?PostNum=<%=PostNum%>">
                    <table>
                        <tr>
                            <td><h3><%=Title%></h3></td>
                        </tr>
                        <tr>
                            <td id="si"><%=Pay%>&nbsp; 근무 요일 : <%=Day%>&nbsp; 근무 시간 : <%=Time%></td>
                        </tr>
                    </table>
                </a>
                <%
                    }
                %>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <%
                    // 이전 페이지
                    int prevPage = currentPage > 1 ? currentPage - 1 : 1;
                    out.println("<a href='?currentPage=" + prevPage + "'>Previous</a>");

                    // 페이지 번호 표시
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                            out.println("<span class='active'>" + i + "</span>");
                        } else {
                            out.println("<a href='?currentPage=" + i + "'>" + i + "</a>");
                        }
                    }

                    // 다음 페이지
                    int nextPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                    out.println("<a href='?currentPage=" + nextPage + "'>Next</a>");
                %>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<%
    } catch (SQLException e) {
        // SQL 오류 처리
        e.printStackTrace();
    } finally {
        // 연결 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

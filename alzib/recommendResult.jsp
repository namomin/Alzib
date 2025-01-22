<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Comparator" %>


<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>알바 추천 결과</title>
<link href="recommend_result.css" rel="stylesheet" type="text/css">
</head>


<%
	request.setCharacterEncoding("UTF-8");
    String Id = (String) session.getAttribute("sid");
    String a1 = request.getParameter("a1");
	String a2 = request.getParameter("a2");
	String b1 = request.getParameter("b1");
	String b2 = request.getParameter("b2");
	String b3 = request.getParameter("b3");
	String c1 = request.getParameter("c1");
	String c2 = request.getParameter("c2");
	String c3 = request.getParameter("c3");
	String d1 = request.getParameter("d1");
	String d2 = request.getParameter("d2");
	String d3 = request.getParameter("d3");

	int suma = Integer.parseInt(a1) + Integer.parseInt(a2);
	// 합이 2 이상이면 "yes", 그렇지 않으면 "no"를 변수 a에 저장
	String a = (suma >= 2) ? "yes" : "no";

	int sumb = Integer.parseInt(b1) + Integer.parseInt(b2) + Integer.parseInt(b3);
	// 합이 2 이상이면 "yes", 그렇지 않으면 "no"를 변수 a에 저장
	String b = (sumb >= 2) ? "yes" : "no";

	String c22;
	if (c2 != null && c2.equals("1")) {
		c22 = "평일만";
	} else {
		c22 = "상관없음";
	}
	String Day1 = "%토%";
	String Day2 = "%일";

	String c11;
	if (c1 != null && c1.equals("1")) {
		c11 = "야간";
	} else {
		c11 = "상관없음";
	}
	String c33;
	if (c3 != null && c3.equals("1")) {
		c33 = "오전";
	} else {
		c33 = "상관없음";
	}

	String t1, t2, t3, t4;
	if (c11.equals("야간") && c33.equals("상관없음")) {
	    t1 = "22시~%";
	    t2 = "23시~%";
	    t3 = "00시~%";
	    t4 = "1시~%";
	} else if (c11.equals("상관없음") && c33.equals("오전")) {
	    t1 = "6시~%";
	    t2 = "7시~%";
	    t3 = "8시~%";
	    t4 = "9시~%";
	} else {
	    t1 = "%%";
	    t2 = "%%";
	    t3 = "%%";
	    t4 = "%%";
	}


	int sumd = Integer.parseInt(d1) + Integer.parseInt(d2) + Integer.parseInt(d3);
	String d;
	if (sumd == -1) {
	   d = "단기";
	} else if (sumd >= 1) {
	    d = "장기";
	} else {
	    d = "상관없음";
	}

	String p1, p2, p3, p4;
	if (d.equals("단기")) {
	    p1 = "하루";
	    p2 = "1주일 이하";
	    p3 = "1주일~1개월";
	    p4 = "1개월~3개월";
	} else if (d.equals("장기")) {
	    p1 = "3개월~6개월";
	    p2 = "6개월~1년";
	    p3 = "1년 이상";
	    p4 = "협의 가능";
	} else {
	    p1 = "%%";
	    p2 = "%%";
	    p3 = "%%";
	    p4 = "%%";
	}

	String cate13 = request.getParameter("cate13");
	String cate14 = request.getParameter("cate14");
	String cate15 = request.getParameter("cate15");
	String cate16 = request.getParameter("cate16");
	String cate17 = request.getParameter("cate17");
	String cate18 = request.getParameter("cate18");
	String cate19 = request.getParameter("cate19");
	String cate20 = request.getParameter("cate20");
	String cate21 = request.getParameter("cate21");
	String cate22 = request.getParameter("cate22");
	String cate23 = request.getParameter("cate23");
	String cate24 = request.getParameter("cate24");
	String cate25 = request.getParameter("cate25");
	String cate26 = request.getParameter("cate26");
	String cate27 = request.getParameter("cate27");
	String cate28 = request.getParameter("cate28");
	String cate29 = request.getParameter("cate29");
	String cate30 = request.getParameter("cate30");
	String cate31 = request.getParameter("cate31");
	String cate32 = request.getParameter("cate32");
	String cate33 = request.getParameter("cate33");
	String cate34 = request.getParameter("cate34");
	String cate35 = request.getParameter("cate35");
	String cate36 = request.getParameter("cate36");

	int sumcate13 = Integer.parseInt(cate13) + Integer.parseInt(cate14) + Integer.parseInt(cate15) + Integer.parseInt(cate16);
	int sumcate17 = Integer.parseInt(cate17) + Integer.parseInt(cate18) + Integer.parseInt(cate19) + Integer.parseInt(cate20);
	int sumcate21 = Integer.parseInt(cate21) + Integer.parseInt(cate22) + Integer.parseInt(cate23) + Integer.parseInt(cate24);
	int sumcate25 = Integer.parseInt(cate25) + Integer.parseInt(cate26) + Integer.parseInt(cate27) + Integer.parseInt(cate28);
	int sumcate29 = Integer.parseInt(cate29) + Integer.parseInt(cate30) + Integer.parseInt(cate31) + Integer.parseInt(cate32);
	int sumcate33 = Integer.parseInt(cate33) + Integer.parseInt(cate34) + Integer.parseInt(cate35) + Integer.parseInt(cate36);
	
	int maxSum = sumcate13;
	String cate = "외식/음료";
	if (sumcate17 > maxSum) {
	   maxSum = sumcate17;
	   cate = "서비스";
	}
	if (sumcate21 > maxSum) {
		maxSum = sumcate21;
	   cate = "사무직";
	}
	if (sumcate25 > maxSum) {
	    maxSum = sumcate25;
	   cate = "매장 관리/판매";
	}
	if (sumcate29 > maxSum) {
	   maxSum = sumcate29;
	   cate = "교육/강사";
	}
	if (sumcate33 > maxSum) {
	  maxSum = sumcate33;
	   cate = "생산/건설";
	}

	String Dong = request.getParameter("Dong");
	String[] coordinates = Dong.split(",");
	double xx = Double.parseDouble(coordinates[0]); // x 좌표
	double yy = Double.parseDouble(coordinates[1]); // y 좌표
 
 	String ty = "알바";

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
		// JDBC 드라이버 로드
		Class.forName("com.mysql.jdbc.Driver");
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
		String query;
		if (a.equals("yes") && b.equals("no")) {
		 if (c22.equals("평일만")) {
			   query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Day not like ? or Day not like ?)"
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY Wage DESC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, Day1);
			   pstmt.setString(4, Day2);
			   pstmt.setString(5, t1);
			   pstmt.setString(6, t2);
			   pstmt.setString(7, t3);
			   pstmt.setString(8, t4);
			   pstmt.setString(9, p1);
			   pstmt.setString(10, p2);
			   pstmt.setString(11, p3);
			   pstmt.setString(12, p4);
			   pstmt.setInt(13, start);
			   pstmt.setInt(14, recordsPerPage);
			} else {
			   query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY Wage DESC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, t1);
			   pstmt.setString(4, t2);
			   pstmt.setString(5, t3);
			   pstmt.setString(6, t4);
			   pstmt.setString(7, p1);
			   pstmt.setString(8, p2);
			   pstmt.setString(9, p3);
			   pstmt.setString(10, p4);
			   pstmt.setInt(11, start);
			   pstmt.setInt(12, recordsPerPage);
		   }
		} else if (a.equals("no") && b.equals("yes")) {
		 if (c22.equals("평일만")) {
		       query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Day not like ? or Day not like ?)"
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY ST_Distance_Sphere(point(y, x), point(?, ?)) ASC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, Day1);
			   pstmt.setString(4, Day2);
			   pstmt.setString(5, t1);
			   pstmt.setString(6, t2);
			   pstmt.setString(7, t3);
			   pstmt.setString(8, t4);
			   pstmt.setString(9, p1);
			   pstmt.setString(10, p2);
			   pstmt.setString(11, p3);
			   pstmt.setString(12, p4);
			   pstmt.setDouble(13, yy);
			   pstmt.setDouble(14, xx);
			   pstmt.setInt(15, start);
			   pstmt.setInt(16, recordsPerPage);
		   } else {
		       query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY ST_Distance_Sphere(point(y, x), point(?, ?)) ASC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, t1);
			   pstmt.setString(4, t2);
			   pstmt.setString(5, t3);
			   pstmt.setString(6, t4);
			   pstmt.setString(7, p1);
			   pstmt.setString(8, p2);
			   pstmt.setString(9, p3);
			   pstmt.setString(10, p4);
			   pstmt.setDouble(11, yy);
			   pstmt.setDouble(12, xx);
			   pstmt.setInt(13, start);
			   pstmt.setInt(14, recordsPerPage);
		    }
		} else if (a.equals("no") && b.equals("no")) {
		    if (c22.equals("평일만")) {
		        query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Day not like ? or Day not like ?)"
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY PostNum DESC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, Day1);
			   pstmt.setString(4, Day2);
			   pstmt.setString(5, t1);
			   pstmt.setString(6, t2);
			   pstmt.setString(7, t3);
			   pstmt.setString(8, t4);
			   pstmt.setString(9, p1);
			   pstmt.setString(10, p2);
			   pstmt.setString(11, p3);
			   pstmt.setString(12, p4);
			   pstmt.setInt(13, start);
			   pstmt.setInt(14, recordsPerPage);
		   } else {
		        query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY PostNum DESC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, t1);
			   pstmt.setString(4, t2);
			   pstmt.setString(5, t3);
			   pstmt.setString(6, t4);
			   pstmt.setString(7, p1);
			   pstmt.setString(8, p2);
			   pstmt.setString(9, p3);
			   pstmt.setString(10, p4);
			   pstmt.setInt(11, start);
			   pstmt.setInt(12, recordsPerPage);
		    }
		} else {
		    if (c22.equals("평일만")) {
		        query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Day not like ? or Day not like ?)"
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY PostNum DESC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, Day1);
			   pstmt.setString(4, Day2);
			   pstmt.setString(5, t1);
			   pstmt.setString(6, t2);
			   pstmt.setString(7, t3);
			   pstmt.setString(8, t4);
			   pstmt.setString(9, p1);
			   pstmt.setString(10, p2);
			   pstmt.setString(11, p3);
			   pstmt.setString(12, p4);
			   pstmt.setInt(13, start);
			   pstmt.setInt(14, recordsPerPage);
		   } else {
		        query = "SELECT * FROM Post WHERE category = ? AND type = ? "
			   		+ "and (Time like ? or Time like ? or Time like ? or Time like ?)" 
					+ "and (Period = ? or Period = ? or Period = ? or Period =?)"
					+ "ORDER BY PostNum DESC LIMIT ?, ?";
			   pstmt = con.prepareStatement(query);
			   pstmt.setString(1, cate);
			   pstmt.setString(2, ty);
			   pstmt.setString(3, t1);
			   pstmt.setString(4, t2);
			   pstmt.setString(5, t3);
			   pstmt.setString(6, t4);
			   pstmt.setString(7, p1);
			   pstmt.setString(8, p2);
			   pstmt.setString(9, p3);
			   pstmt.setString(10, p4);
			   pstmt.setInt(11, start);
			   pstmt.setInt(12, recordsPerPage);
		    }
	}

		    rs = pstmt.executeQuery();
%>


<body>
<div class="wrap">
	<div class="head_wrap">
		<div class="head_title">
			<span id="title">알바 추천 결과</span><br><br>
			<span id="result"><font color="white">추천하는 업직종은 <b><%=cate%></b></font></span><br>
			<span>검사 결과를 바탕으로 당신에게 꼭 맞는 알바를 가져왔어요!</span>
		</div>
	</div>	
	
	<div class="post_wrap">
		<div class="table_wrap">
			<table>
				<tr>
					<th>기업명</th>
					<th>제목</th>
					<th>근무시간</th>
					<th>급여</th>
				</tr>
				
				<%
                    while (rs.next()) {
                        // 각 게시글 정보 가져오기
                        String PostNum = rs.getString("PostNum");
                        String Title = rs.getString("Title");
                        String Pay = rs.getString("Pay");
                        String BStore = rs.getString("BStore");
                        String Time = rs.getString("Time");
                %>
				<tr>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=BStore%></a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Title%></a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Time%></a></td>
					<td><a href="postmapdetail.jsp?PostNum=<%=PostNum%>"><%=Pay%></a></td>
				</tr>
				<%
                    }
                %>
				
			</table>
		</div>
		<div class="page" align="center">
                <%
                    // 이전 페이지
                    int prevPage = currentPage > 1 ? currentPage - 1 : 1;
                    out.println("<a href='?currentPage=" + prevPage + "'> < </a>");

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
                    out.println("<a href='?currentPage=" + nextPage + "'> > </a>");
                %>
            </div>
	</div>
	
</div>
	
</body>
</html>

<%
    } catch (SQLException e) {
        // SQL 오류 처리
        out.println("<p>Error occurred while executing SQL query: " + e.getMessage() + "</p>");
		out.println("<p>xx: " + xx + "</p>");
		out.println("<p>yy: " + yy + "</p>");
    } catch (ClassNotFoundException e) {
        // JDBC 드라이버를 찾을 수 없는 경우 처리
        out.println("<p>JDBC driver not found: " + e.getMessage() + "</p>");
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
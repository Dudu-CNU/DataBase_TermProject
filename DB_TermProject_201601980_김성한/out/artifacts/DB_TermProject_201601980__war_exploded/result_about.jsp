<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.proxy.annotation.Pre" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<%@ include file="date.jsp" %>

<%
    String id = session.getAttribute("id").toString();
    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query = "SELECT P.ISBN, E.TITLE, COUNT(*) FROM PREVIOUS_RENTAL P, EBOOK E WHERE P.ISBN = E.ISBN GROUP BY P.ISBN,E.TITLE ORDER BY P.ISBN";
    PreparedStatement pstmt = conn.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();

    //통계 2장 5절 그룹함수 -> 결과 표시
    out.println("각 도서별 대출 건수");
    out.println("<table class=\"table\"><tr><th>ISBN</th><th>제목</th><th>대출건수</th></tr>");
    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getInt(1) + "</td>");
        out.println("<td>" + rs.getString(2) + "</td>");
        out.println("<td>" + rs.getInt(3) + "</td>");
        out.println("</tr>");
    }
    out.print("</table>");
    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query1 = "SELECT P.ISBN, P.DATERENTED ,E.TITLE FROM PREVIOUS_RENTAL P, EBOOK E WHERE P.ISBN = E.ISBN ORDER BY P.DATERENTED DESC";
    PreparedStatement pstmt1 = conn.prepareStatement(query1);
    ResultSet rs1 = pstmt1.executeQuery();

    //통계 1장 9절 조인 및 2장 1절 표준조인-> 결과 표시
    out.println("<br><br><br>최근 대출된 도서 목록");
    out.println("<table class=\"table\"><tr><th>ISBN</th><th>대출일자</th><th>제목</th></tr>");
    while (rs1.next()) {
        out.println("<tr>");
        out.println("<td>" + rs1.getInt(1) + "</td>");
        out.println("<td>" + rs1.getString(2).split(" ")[0] + "</td>");
        out.println("<td>" + rs1.getString(3) + "</td>");
        out.println("</tr>");
    }
    out.print("</table>");

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query2 = "SELECT P.ISBN,E.TITLE, P.DATERENTED, RANK() OVER (ORDER BY P.DATERENTED ) RANK FROM PREVIOUS_RENTAL P, EBOOK E WHERE P.ISBN = E.ISBN";
    PreparedStatement pstmt2 = conn.prepareStatement(query2);
    ResultSet rs2 = pstmt2.executeQuery();

    //통계 2장 6절 윈도우함수 -> 결과 표시
    out.println("<br><br><br>가장 오래전 대출된 도서 순위");
    out.println("<table class=\"table\"><tr><th>ISBN</th><th>제목</th><th>대출일자</th><th>순위</th></tr>");
    while (rs2.next()) {
        out.println("<tr>");
        out.println("<td>" + rs2.getInt(1) + "</td>");
        out.println("<td>" + rs2.getString(2) + "</td>");
        out.println("<td>" + rs2.getString(3).split(" ")[0] + "</td>");
        out.println("<td>" + rs2.getInt(4) + "</td>");
        out.println("</tr>");
    }
    out.print("</table>");

%>
<br><br>
<a href='logined.jsp'>나가기</a>
</body>
</html>

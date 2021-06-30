<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<%@ include file="date.jsp" %>
<table class="table">
    <tr>
        <th>회원번호</th>
        <th>회원명</th>
        <th>제목</th>
        <th>대출일자</th>
        <th>반납예정일</th>
        <th>연장횟수</th>
        <th>연장</th>
        <th>반납</th>
    </tr>
        <%
        //세션으로 부터 id가져오기.
    String id = session.getAttribute("id").toString();
     //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query = "SELECT * FROM CUSTOMER WHERE NAME = '" + id + "'";
    PreparedStatement pstmt = conn.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();
    rs.next();
    int cno = rs.getInt("CNO");
     //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query5 = "SELECT * FROM BORROW WHERE CNO = '" + cno + "'";
    PreparedStatement pstmt5 = conn.prepareStatement(query5);
    ResultSet rs5 = pstmt5.executeQuery();

    //query5 실행결과 봔환된 resultSet에서 정보를 추출하여 테이블 구성.
    while (rs5.next()) {
        String title = rs5.getString("TITLE");
        String date_rented = rs5.getString("DATE_RENTED");
        String date_due = rs5.getString("DATE_DUE");
        String ext = rs5.getString("EXT_TIMES");

        String query6 = "SELECT * FROM EBOOK WHERE TITLE = '" + title + "'";
        PreparedStatement pstmt6 = conn.prepareStatement(query6);
        ResultSet rs6 = pstmt6.executeQuery();
        rs6.next();
        int isbn = rs6.getInt("ISBN");

        out.println("<tr>");
        out.println("<td>" + cno + "</td>");
        out.println("<td>" + id + "</td>");
        out.println("<td>" + title + "</td>");
        out.println("<td>" + date_rented + "</td>");
        out.println("<td>" + date_due + "</td>");
        out.println("<td>" + ext + "</td>");
        out.println("<td><button id=" + isbn + " onClick='ext(this.id)'>연장</button></td>");
        out.println("<td><button id=" + isbn + " onClick='return_book(this.id)'>반납</button></td>");
        out.println("</tr>");
    }


%>

    <a href='logined.jsp'>나가기</a>
</body>
<script type="text/javascript" src="./info.js"></script>
</html>

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
<table class="table">
    <tr>
        <th>ISBN</th>
        <th>제목</th>
        <th>출판사</th>
        <th>예약취소</th>
    </tr>
        <%
            //세션으로부터 id값 가져오기.
            String id = session.getAttribute("id").toString();

             //쿼리문을 실행하는 코드 rs에 결과 반환. -> id값을 이용해 cno를 알아내기 위함.
            String query0 = "SELECT * FROM CUSTOMER WHERE NAME = '" + id + "'";
            PreparedStatement pstmt0 = conn.prepareStatement(query0);
            ResultSet rs0 = pstmt0.executeQuery();
            rs0.next();
            int cno = rs0.getInt("CNO");

             //쿼리문을 실행하는 코드 rs에 결과 반환.
            String query1 = "SELECT * FROM RESERVE WHERE CNO = '" + cno + "'";
            PreparedStatement pstmt1 = conn.prepareStatement(query1);
            ResultSet rs1 = pstmt1.executeQuery();

            //query1을 실행하여 얻은 resultSet에서 정보를 추출하여 회원의 예약정보를 테이블로 표현.
            while(rs1.next()){
                int isbn = rs1.getInt("ISBN");
                String date = rs1.getString("DATETIME");

                String query2 = "SELECT * FROM EBOOK WHERE ISBN = '"+isbn+"'";
                PreparedStatement pstmt2 = conn.prepareStatement(query2);
                ResultSet rs2 = pstmt2.executeQuery();
                rs2.next();
                String title = rs2.getString("TITLE");
                String publisher = rs2.getString("PUBLISHER");


                out.println("<tr>");
                out.println("<td>" + isbn + "</td>");
                out.println("<td>" + title + "</td>");
                out.println("<td>" + publisher + "</td>");
                out.println("<td><button id=" + isbn + " onClick='cancel(this.id)'>예약취소</button></td>");
                out.println("</tr>");
            }
        %>
    <a href='logined.jsp'>나가기</a>

</body>
<script type="text/javascript" src="./cancel_reserve.js"></script>
</html>

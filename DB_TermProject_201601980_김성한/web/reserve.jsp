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
    //세션으로 부터 id를 가져오고 , request를 통해 넘어온 인자를 저장.
    String id = session.getAttribute("id").toString();
    String isbn_str = request.getParameter("isbn");

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query = "SELECT * FROM CUSTOMER WHERE NAME = '" + id + "'";
    PreparedStatement pstmt = conn.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();
    rs.next();
    int cno = rs.getInt("CNO");


    int isbn = Integer.parseInt(isbn_str);
    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query2 = "SELECT * FROM RESERVE WHERE CNO = '" + cno + "'";
    PreparedStatement pstmt2 = conn.prepareStatement(query2);
    ResultSet rs2 = pstmt2.executeQuery();
    int count = 0;
    boolean flag = true;

    while (rs2.next()) {
        count++;
    }
    //예약건수가 3회 이상인경우
    if (count >= 3) {
        flag = false;
        out.println("현재 예약건수 초과로 인해 예약이 불가능합니다.(최대 3회)<br>");
        out.println(" <a href='logined.jsp'>검색페이지로 이동하기</a> ");
    }

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query1 = "SELECT * FROM EBOOK WHERE ISBN = '" + isbn + "'";
    PreparedStatement pstmt1 = conn.prepareStatement(query1);
    ResultSet rs1 = pstmt1.executeQuery();
    rs1.next();
    String title = rs1.getString("TITLE");
    String date_check1 = rs1.getString("DATERENTED");
    String date_check2 = rs1.getString("DATEDUE");

    //아직 대출되지 않은 도서에 대해 예약을 진행하는 경우
    if (date_check1 == null && date_check2 == null) {
        flag = false;
        out.println("미대출 도서에 대해서는 예약이 불가능합니다.<br>");
        out.println(" <a href='logined.jsp'>검색페이지로 이동하기</a> ");
    }

    //이미 대출한 도서에 대하여 예약을 진행하는 경우
    String query5 = "SELECT * FROM BORROW WHERE CNO = '" + cno + "'";
    PreparedStatement pstmt5 = conn.prepareStatement(query5);
    ResultSet rs5 = pstmt5.executeQuery();
    while(rs5.next()) {
        if (title.equals(rs5.getString("TITLE"))) {
            flag = false;
            out.println("이미 대출하신 도서입니다.<br>");
            out.println(" <a href='logined.jsp'>검색페이지로 이동하기</a> ");
        }
    }

    //이미 예약한 도서에 대하여 예약을 다시 진행하는 경우
    String query6 = "SELECT * FROM RESERVE WHERE ISBN = '" + isbn + "'";
    PreparedStatement pstmt6 = conn.prepareStatement(query6);
    ResultSet rs6 = pstmt6.executeQuery();
    while(rs6.next()) {
        if (cno == rs6.getInt("CNO")) {
            flag = false;
            out.println("이미 예약하신 도서입니다.<br>");
            out.println(" <a href='logined.jsp'>검색페이지로 이동하기</a> ");
        }
    }

    //모든 조건을 통과하고 예약이 성립되는 경우 -> 예약 진행
    if (flag) {
        String query3 = "INSERT INTO RESERVE (ISBN, CNO, DATETIME) VALUES (?, ?, ?)";
        PreparedStatement pstmt3 = conn.prepareStatement(query3);
        pstmt3.setInt(1, isbn);
        pstmt3.setInt(2, cno);
        pstmt3.setString(3, today);
        ResultSet rs3 = pstmt3.executeQuery();

        out.println("도서번호 : " + isbn + " 도서명 " + title + " 도서에 대한 예약이 완료되었습니다.");
        out.println("<a href='logined.jsp'>메인 페이지로 돌아가기</a>");
    }
%>
</body>
</html>

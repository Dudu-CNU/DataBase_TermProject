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
    //세션으로부터 id를 가져오고 인자로 넘어온 isbn을 저장.
    String id = session.getAttribute("id").toString();
    String isbn = request.getParameter("isbn");

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query = "SELECT * FROM BORROW WHERE NAME = '" + id + "'";
    PreparedStatement pstmt = conn.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();
    int count = 0;
    //flag선언 -> 이후 최종적으로 대출이 가능한지의 여부 판단
    boolean flag = true;
    while (rs.next()) {
        count++;
    }
    //대출중인 도서가 3권인경우
    if (count >= 3) {
        flag = false;
        out.println("현재 대출중인 도서가 3권이시기에 대출이 불가능합니다 반납 후 다시 시도하십시오.<br>");
        out.println(" <a href='logined.jsp'>검색페이지로 이동하기</a> ");
    }
    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query2 = "SELECT * FROM EBOOK WHERE ISBN = '" + isbn + "'";
    PreparedStatement pstmt2 = conn.prepareStatement(query2);
    ResultSet rs2 = pstmt2.executeQuery();
    rs2.next();
    String title = rs2.getString("TITLE");
    String date_check1 = rs2.getString("DATERENTED");
    String date_check2 = rs2.getString("DATEDUE");

    // 이미 대출중인 도서에 대해 대출을 진행하는 경우
    if (flag == true &&date_check1 != null && date_check2 != null) {
        flag = false;
        out.println("해당 도서는 대출중입니다. 다시 진행해 주십시오.<br>");
        out.println(" <a href='logined.jsp'>검색페이지로 이동하기</a> ");
    }
    // 모든 조건 성립 후 대출이 가능한 경우 -> 대출 진행.
    if (flag) {
        //쿼리문을 실행하는 코드 rs에 결과 반환.
        String query3 = "SELECT * FROM CUSTOMER WHERE NAME = '" + id + "'";
        PreparedStatement pstmt3 = conn.prepareStatement(query3);
        ResultSet rs3 = pstmt3.executeQuery();
        rs3.next();
        int cno = rs3.getInt("CNO");
        //쿼리문을 실행하는 코드 rs에 결과 반환.
        String query4 = "INSERT INTO BORROW (CNO, NAME, TITLE, DATE_RENTED, DATE_DUE, EXT_TIMES) VALUES (?, ?, ?, ?, ?, 0)";
        PreparedStatement pstmt4 = conn.prepareStatement(query4);
        pstmt4.setInt(1, cno);
        pstmt4.setString(2, id);
        pstmt4.setString(3, title);
        pstmt4.setString(4, today);
        pstmt4.setString(5, todayPlus10);
        ResultSet rs4 = pstmt4.executeQuery();
        //쿼리문을 실행하는 코드 rs에 결과 반환.
        String query5 = "UPDATE EBOOK SET CNO = '" + cno + "', EXTTIMES = '" + 0 + "', DATERENTED = '" + today + "', DATEDUE = '" + todayPlus10 + "' WHERE ISBN = '" + isbn + "'";
        PreparedStatement pstmt5 = conn.prepareStatement(query5);
        ResultSet rs5 = pstmt5.executeQuery();

        out.println("대출이 완료되었습니다.\n");
        out.println("<a href='logined.jsp'>검색페이지로 이동하기</a>");
    }
%>

</body>
</html>

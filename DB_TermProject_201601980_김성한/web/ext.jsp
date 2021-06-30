<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>


<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<%@ include file="date.jsp" %>

<%
    //세션으로 부터 id를 가져오고 , request를 통해 넘어온 인자인 isbn을 int로 변환.
    String id = session.getAttribute("id").toString();
    String isbn_str = request.getParameter("isbn");
    int isbn = Integer.parseInt(isbn_str);

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query1 = "SELECT * FROM EBOOK WHERE ISBN = '" + isbn + "'";
    PreparedStatement pstmt1 = conn.prepareStatement(query1);
    ResultSet rs1 = pstmt1.executeQuery();
    rs1.next();
    String title = rs1.getString("TITLE");

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query0 = "SELECT * FROM CUSTOMER WHERE NAME = '" + id + "'";
    PreparedStatement pstmt0 = conn.prepareStatement(query0);
    ResultSet rs0 = pstmt0.executeQuery();
    rs0.next();
    int cno = rs0.getInt("CNO");

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query = "SELECT * FROM BORROW WHERE CNO = '" + cno + "'";
    PreparedStatement pstmt = conn.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();
    rs.next();
    int ext = rs.getInt("EXT_TIMES");

    //ext값에 1을 더하면 2보다 커지는지 검사 (연장 최대 2번)
    if((ext+1) > 2) {
        out.println("연장은 2회를 초과할 수 없습니다.");
        out.println("<a href='info.jsp'>이용현황 페이지로 돌아가기</a>");
        out.println("<a href='logined.jsp'>검색 페이지로 돌아가기</a>");
    }
    else {
        //쿼리문을 실행하는 코드 rs에 결과 반환.
        String findReserveQuery = "SELECT * FROM RESERVE WHERE ISBN = '" + isbn +"'";
        PreparedStatement pstmt2 = conn.prepareStatement(findReserveQuery);
        ResultSet rs2 = pstmt2.executeQuery();

        //예약중인 도서에 대해 연장을 신청한 경우.
        if(rs2.next()) {
            out.println(rs2.getString("CNO"));
            out.println("이 도서는 현재 예약중인 도서입니다. 예약중인 도서는 대출 연장이 불가능합니다.");
            out.println("<a href='logined.jsp'>메인 페이지로 돌아가기</a>");
        }
        else {
            //연장 날짜 처리. calender 객체 이용.

            String tempDay = rs.getString("DATE_DUE");
            SimpleDateFormat fm = new SimpleDateFormat("yyyy/MM/dd");
            Date tempDate = fm.parse(tempDay);

            Calendar caltemp = Calendar.getInstance();
            caltemp.setTime(tempDate);
            caltemp.add(Calendar.DATE, 10);

            String updateDate = fm.format(caltemp.getTime());
            //쿼리문을 실행하는 코드 rs에 결과 반환.
            String query5 = "UPDATE BORROW SET DATE_DUE ='" + updateDate + "' , EXT_TIMES =" + (ext + 1) + "WHERE TITLE = '" + title + "' AND CNO = '" + cno + "'";
            PreparedStatement pstmt5 = conn.prepareStatement(query5);
            ResultSet rs5 = pstmt5.executeQuery();
            //쿼리문을 실행하는 코드 rs에 결과 반환.
            String query6 = "UPDATE EBOOK SET DATEDUE ='" + updateDate + "' , EXTTIMES =" + (ext + 1) + "WHERE TITLE = '" + title + "' AND CNO = '" + cno + "'";
            PreparedStatement pstmt6 = conn.prepareStatement(query6);
            ResultSet rs6 = pstmt6.executeQuery();

            out.println("연장이 완료되었습니다.");
            out.println("<a href='logined.jsp'>메인 페이지로 돌아가기</a>");
        }
    }
%>

</body>
</html>

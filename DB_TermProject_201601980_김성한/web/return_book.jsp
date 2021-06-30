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
    String query0 = "SELECT * FROM CUSTOMER WHERE NAME = '" + id + "'";
    PreparedStatement pstmt0 = conn.prepareStatement(query0);
    ResultSet rs0 = pstmt0.executeQuery();
    rs0.next();
    int cno = rs0.getInt("CNO");

    //쿼리문을 실행하는 코드 rs에 결과 반환.
    String query1 = "SELECT * FROM EBOOK WHERE ISBN = '" + isbn + "'";
    PreparedStatement pstmt1 = conn.prepareStatement(query1);
    ResultSet rs1 = pstmt1.executeQuery();
    rs1.next();
    String title = rs1.getString("TITLE");

    //쿼리문을 실행하는 코드 rs에 결과 반환. -> 반납날짜 설정(반납예정일자랑 다른경우를 위함.)
    String query4 = "SELECT * FROM BORROW WHERE TITLE = '" + title + "' AND CNO ='" + cno + "'";
    PreparedStatement pstmt4 = conn.prepareStatement(query4);
    ResultSet rs4 = pstmt4.executeQuery();
    rs4.next();
    String date_rented = rs4.getString("DATE_RENTED");
    Calendar now = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    String returned_date = sdf.format(now.getTime());

    //쿼리문을 실행하는 코드 rs에 결과 반환. -> 반납하게 되면 previous_rental테이블에 기록 저장.
    String query5 = "INSERT INTO PREVIOUS_RENTAL (ISBN,DATERENTED,DATERETURNED, CNO) VALUES (?, ?, ?, ?)";
    PreparedStatement pstmt5 = conn.prepareStatement(query5);
    pstmt5.setInt(1, isbn);
    pstmt5.setString(2, date_rented);
    pstmt5.setString(3, returned_date);
    pstmt5.setInt(4, cno);
    ResultSet rs5 = pstmt5.executeQuery();

    //쿼리문을 실행하는 코드 rs에 결과 반환. -> borrow 테이블에서 해당 행을 지움으로써 반납기능 수행
    String query2 = "DELETE FROM BORROW WHERE TITLE = '" + title + "' AND CNO ='" + cno + "'";
    PreparedStatement pstmt2 = conn.prepareStatement(query2);
    ResultSet rs2 = pstmt2.executeQuery();

    //쿼리문을 실행하는 코드 rs에 결과 반환. -> 반납한 뒤 ebook 테이블 update
    String query3 = "UPDATE EBOOK SET CNO = NULL,EXTTIMES = NULL,DATERENTED = NULL,DATEDUE = NULL WHERE ISBN = '" + isbn + "'";
    PreparedStatement pstmt3 = conn.prepareStatement(query3);
    ResultSet rs3 = pstmt3.executeQuery();

    out.println("도서번호 : " + isbn + " 도서명 " + title + " 도서 반납이 완료되었습니다.");
    out.println("<a href='logined.jsp'>메인 페이지로 돌아가기</a>");

%>

</body>
</html>

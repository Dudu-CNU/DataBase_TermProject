<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
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
    String query = "DELETE FROM RESERVE WHERE ISBN = '" + isbn + "' AND CNO ='" + cno + "'";
    PreparedStatement pstmt = conn.prepareStatement(query);
    ResultSet rs = pstmt.executeQuery();

    //예약을 취소하는 경우
    out.println(isbn + " 예약이 취소되었습니다.");
    out.println("<a href='logined.jsp'> 메인 페이지로 돌아가기</a>");
%>
</body>
</html>

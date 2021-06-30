<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<%
    ResultSet rs = null;
    Statement stmt = null;
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String email = request.getParameter("email");

    try {
        //쿼리문을 실행하는 코드 rs에 결과 반환.
        String sql = "SELECT CNO FROM CUSTOMER";
        stmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

        rs = stmt.executeQuery(sql);
        //String cno = null;
        int check = 0;
        rs.last();
        int cno = rs.getRow() + 1;
        rs.first();
        // 회원가입시 이미 회원번호가 존재하는지 판단.
        if (check == 1) {
            out.println("<p>해당 도서관에 회원번호가 이미 존재합니다.</p>");
            out.println(" <a href='index.html'>다시 회원가입 하기</a> ");

        } else {
            sql = "";
            sql = "INSERT INTO CUSTOMER VALUES ( ";
            sql = sql + "'" + cno + "'" + " , ";
            sql = sql + "'" + id + "'" + " , ";
            sql = sql + "'" + pw + "'" + " , ";
            sql = sql + "'" + email + "'" + " ) ";
            rs = stmt.executeQuery(sql);
            out.println("<p>회원가입을 성공하였습니다.</p>");
            out.println(" <a href='index.html'> 로그인 하러하기</a> ");
        }

    } catch (SQLException ex) {
        out.println("SQLException: " + ex.getMessage() + "<br>");
        out.println("회원 가입에 실패했습니다.<br>");
        out.println(" <a href='index.html'>다시 회원가입 하기</a> ");

    } finally {
        if (rs != null)
            rs.close();
        if (stmt != null)
            stmt.close();
        if (conn != null)
            conn.close();
    }
%>
</body>
</html>

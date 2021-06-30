<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title></title>
</head>
<body>
    <%@ include file = "dbconn.jsp" %>

    <%
        ResultSet rs = null;
        Statement stmt = null;
        request.setCharacterEncoding("utf-8");

        String id = request.getParameter("id");
        String pwd = request.getParameter("pw");

        try {
            //쿼리문을 실행하는 코드 rs에 결과 반환.
            String sql = "SELECT Name, PASSWD FROM CUSTOMER WHERE NAME LIKE ";
            sql = sql + "'" + id + "'";
            sql = sql + " AND PASSWD LIKE ";
            sql = sql + "'" + pwd + "'";
            stmt = conn.createStatement();

            rs = stmt.executeQuery(sql);
            String id_value = null;
            String pw_value = null;
            int check = 0;
            //아이디와 비밀번호가 맞는지 체크 후 check변수 설정.
            while (rs.next()) {
                id_value = rs.getString("NAME");
                pw_value = rs.getString("PASSWD");
                if (id.equals(id_value) && pwd.equals(pw_value)) {
                    check = 1;
                    break;
                }
            }
            //check가 1인경우 로그인 성공.
            if (check == 1) {
                out.println("<script>\n" +
                        "                alert(\"로그인에 성공하셨습니다.\");\n" +
                        "            </script>");
                request.getSession().setAttribute("id", id_value);

                response.sendRedirect("logined.jsp");
            }
          else {
                out.println("로그인에 실패했습니다.<br>");
                out.println(" <a href='index.html'>다시 로그인 하기</a> ");
            }


        } catch (SQLException ex) {
            out.println("SQLException: " + ex.getMessage() + "<br>");
            out.println("로그인에 실패했습니다.<br>");
            out.println(" <a href='index.html'>다시 로그인 하기</a> ");

        } finally {
            if (rs != null)
                rs.close();
            if (stmt != null)
                stmt.close();
            if (conn != null)
                conn.close();
        }
    %>
<!--<script src="select01.js"></script>-->
</body>
</html>

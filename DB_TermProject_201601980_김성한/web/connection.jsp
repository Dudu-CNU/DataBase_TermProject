<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>Database SQL</title>
</head>
<body>
	<%
		//ORACLE 데이터베이스의 연결을 위한 코드
		Connection conn=null;
		try{
			String url="jdbc:oracle:thin:@localhost:1521:XE";
			String user = "C##TERM_PROJECT_201601980";
			String password ="TJDGKS007";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			out.println("데이터베이스 연결이 성공했습니다.");
		} catch(SQLException ex){
			out.println("데이터베이스 연결이 실패했습니다.<br>");
			out.println("SQLException: " + ex.getMessage());
		} finally{
			if(conn != null)
				conn.close();
		}
	%>
</body>
</html>
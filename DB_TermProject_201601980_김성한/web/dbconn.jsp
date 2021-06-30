<%@ page import="java.sql.*"%>
<%
    //ORACLE DB 내의 텀프로젝트 계정 정보를 저장한 코드
    Connection conn = null;

    String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user = "C##TERM_PROJECT_201601980";
    String password ="TJDGKS007";
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, password);
%>
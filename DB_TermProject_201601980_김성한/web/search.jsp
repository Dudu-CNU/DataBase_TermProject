<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Search</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<table class="table">
    <tr>
        <th>ISBN</th>
        <th>제목</th>
        <th>저자</th>
        <th>출판사</th>
        <th>발행년도</th>
        <th>대출회원</th>
        <th>연장횟수</th>
        <th>대출일자</th>
        <th>반납예정일</th>
        <th>대출</th>
        <th>예약</th>
    </tr>
        <%
            //쿼리문을 실행하는 코드 rs에 결과 반환.
            String query = "SELECT * FROM EBOOK";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            //쿼리문을 실행하는 코드 rs에 결과 반환.
            String query2 = "SELECT * FROM AUTHORS";
            PreparedStatement pstmt2 = conn.prepareStatement(query2);
            ResultSet rs2 = pstmt2.executeQuery();

            //검색창으로부터 넘겨받은 정보를 변수에 할당. 및 예외처리.
             String input_title = request.getParameter("title");
             String input_author = request.getParameter("author");
             String input_publisher = request.getParameter("publisher");
             String check_start = request.getParameter("start_year");
             int start_year = 0;
             int end_year = 10000;
             if(check_start != ""){
                start_year = Integer.parseInt(check_start);
             }
             String check_end = request.getParameter("end_year");
             if(check_end != ""){
                end_year = Integer.parseInt(check_end);
             }
            while(rs.next() && rs2.next()) {
                //도서정보들을 저장.
                String isbn = rs.getString("ISBN");
                String title = rs.getString("TITLE");
                String publisher = rs.getString("PUBLISHER");
                String year_str = rs.getString("YEAR");
                String borrowing_customer = rs.getString("CNO");
                int exttimes = rs.getInt("EXTTIMES");
                String daterented = rs.getString("DATERENTED");
                String datedue = rs.getString("DATEDUE");
                boolean flag = true;

                String authors = rs2.getString("AUTHOR");
                String author[] = authors.split(", ");

                //연도 분리
                String date[] = year_str.split("-");
                year_str = date[0];
                int year = Integer.parseInt(year_str);

                //검색 부분(도서명, 저자, 출판사, 발행년도 범위를 이용)
                boolean check_condition[] = {true, true, true, true, true};

                //제목비교 후 같지 않다면 check_condition[0]를 false로 변환
                //저자, 출판사, 발행년도 범위도 같은 방식으로 진행.
                if(input_title != "" && !title.contains(input_title)){
                    check_condition[0] = false;
                }
                if(input_author != ""){
                    for(int i=0; i < author.length; i++){
                        if(author[i].contains(input_author)){
                            check_condition[1] = true;
                            break;
                        }else{
                            check_condition[1] = false;
                        }
                    }
                }
                if(input_publisher != ""){
                    if(!publisher.contains(input_publisher)){
                        check_condition[2] = false;
                    }
                }
                if(check_start != ""){
                    if(start_year > year){
                        check_condition[3] = false;
                    }
                }
                if(check_end != ""){
                    if(end_year < year){
                        check_condition[4] = false;
                    }
                }

                for(int i =0; i < check_condition.length; i++){
                    if(check_condition[i] == false){
                        flag = false;
                        break;
                    }
                }

                //검색도서가 아닌경우 continue
                if(!flag){
                    continue;
                }

                //시분초 제거
                String date_due = "없음";
                String date_rented = "없음";

                if(daterented != null){
                    String rentedtime[] = daterented.split(" ");
                    date_rented = rentedtime[0];
                }
                if(datedue != null){
                    String duetime[] = datedue.split(" ");
                    date_due = duetime[0];
                }

                //대출회원 없는경우
                if(borrowing_customer == null){
                    borrowing_customer = "없음";
                }

                //결과출력을 위한 테이블 생성.
                out.println("<tr>");
                out.println("<td>" + isbn + "</td>");
                out.println("<td>" + title + "</td>");
                out.println("<td>" + authors + "</td>");
                out.println("<td>" + publisher + "</td>");
                out.println("<td>" + year + "</td>");
                out.println("<td>" + borrowing_customer + "</td>");
                out.println("<td>" + exttimes + "</td>");
                out.println("<td>" + date_rented + "</td>");
                out.println("<td>" + date_due + "</td>");
                out.println("<td><button id=" + isbn + " onClick='borrow(this.id)'>대출</button></td>");
                out.println("<td><button id=" + isbn + " onClick='reserve(this.id)'>예약</button></td>");
                out.println("</tr>");
            }
        %>
    <a href='logined.jsp'>나가기</a>
</body>
<script type="text/javascript" src="./search.js"></script>
</html>

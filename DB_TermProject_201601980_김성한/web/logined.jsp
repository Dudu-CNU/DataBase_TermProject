<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: k0s0a
  Date: 2021-06-23
  Time: 오전 1:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="logined.css">
</head>
<body>
<img src="library1.jpg" width="500" height="500">


<!-- 로그인한 유저이름 표시-->
<span id="user">
    <h5 id="id_view">ID : <%= session.getAttribute("id") %></h5>
    <button type="button" onclick="location.href='index.html' ">로그아웃</button>
</span><br>


<button type="button" name="button" id="Search">도서검색</button>
<button type="button" name="button" id="Info">이용현황</button>

<!-- 검색 창 : 서명, 저자, 출판사, 발행년도 범위에 대한 검색 조건-->
<div id="Search_box">
    <form method="post" action="search.jsp">
        <fieldset>
            <h3>검색 창</h3>
            도서명 : <input type="text" name="title"><br>
            저자 : <input type="text" name="author"><br>
            출판사 : <input type="text" name="publisher"><br>
            발행년도 : <input type="text" name="start_year"> ~ <input type="text" name="end_year"><br>
            <input type="submit" value="검색">
            <input type="reset" value="초기화">
            <button type="button" name="button" id="cancel1">닫기</button>
        </fieldset>
    </form>
</div>


<!-- 이용현황 창 : 대출현황 확인, 예약 내역 확인, 각종 통계 확인 -->
<div id="Info_box">
        <fieldset>
            <h3>이용현황 창</h3>
            <button type="button" name="button" onclick="info()">대출현황확인</button><br>
            <button type="button" name="button" onclick="reserve()">예약내역확인</button><br>
            <button type="button" name="button" onclick="result_about()">각종통계확인</button><br>
            <button type="button" name="button" id="cancel2">닫기</button>
        </fieldset>
</div>

</body>
<script type="text/javascript" src="./logined.js"></script>
</html>

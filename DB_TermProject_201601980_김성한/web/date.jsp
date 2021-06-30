<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>

<%
	Date nowDate = new Date(); 
    SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
    
    // 오늘 날짜
    String today = format.format(nowDate).toString();

    // 오늘로부터 10일 뒤
    Calendar cal = Calendar.getInstance();
    cal.setTime(nowDate);
    cal.add(Calendar.DATE, 10);

    String todayPlus10 = format.format(cal.getTime()).toString();
%>
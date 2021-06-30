//window : 각각에 맞는 jsp로 연결.
function ext(e) {
    window.location.href = "ext.jsp?isbn=" + e;
}
function return_book(e) {
    window.location.href = "return_book.jsp?isbn=" + e;
}

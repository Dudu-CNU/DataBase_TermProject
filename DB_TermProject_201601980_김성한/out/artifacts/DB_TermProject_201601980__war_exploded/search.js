//window : 버튼클릭시 그에 맞는 jsp로 연결
function borrow(e) {
    window.location.href = "borrow.jsp?isbn=" + e;
}

function reserve(e) {
    window.location.href = "reserve.jsp?isbn=" + e;
}
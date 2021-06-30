//window : 예약 취소시 cancel_reserve.jsp로 연결 이때 isbn 전달
function cancel(e) {
    window.location.href = "cancel_reserve.jsp?isbn=" + e;
}

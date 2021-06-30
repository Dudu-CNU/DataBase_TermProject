let cancel1 = document.getElementById("cancel1");
let Search = document.getElementById("Search");
let search_box = document.getElementById("Search_box");
let cancel2 = document.getElementById("cancel2");
let Info = document.getElementById("Info")
let info_box = document.getElementById("Info_box");

search_box.style.display = "none";
info_box.style.display = "none";


//close 함수 로그인 박스와 회원가입 박스를 닫는 역할
function close1() {
    search_box.style.display = "none";
}

cancel1.addEventListener('click', close1);

function close2() {
    info_box.style.display = "none";
}

cancel2.addEventListener('click', close2);

//show 함수 로그인 박스와 회원가입 박스를 열고 닫는 역할
function Search_show() {
    if (search_box.style.display == "none") {
        search_box.style.display = "";
    } else {
        search_box.style.display = "none";
    }
}

Search.addEventListener('click', Search_show);

function Info_show() {
    if (info_box.style.display == "none") {
        info_box.style.display = "";
    } else {
        info_box.style.display = "none";
    }
}

Info.addEventListener('click', Info_show);

//window : 버튼클릭시 그에 맞는 jsp로 연결
function info() {
    window.location.href = "info.jsp";
}

function reserve() {
    window.location.href = "reserve_result.jsp";
}

function result_about() {
    window.location.href = "result_about.jsp";
}
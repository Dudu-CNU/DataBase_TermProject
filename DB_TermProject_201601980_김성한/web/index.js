let cancel1 = document.getElementById("cancel1");
let cancel2 = document.getElementById("cancel2");
let Login = document.getElementById("Login");
let SignUp = document.getElementById("SignUp");
let login_box = document.getElementById("login_box");
let signup_box = document.getElementById("signup_box");
login_box.style.display = "none";
signup_box.style.display = "none";

//close 함수 로그인 박스와 회원가입 박스를 닫는 역할
function close1() {
    login_box.style.display = "none";
}
cancel1.addEventListener('click', close1);

function close2() {
    signup_box.style.display = "none";
}

cancel2.addEventListener('click', close2);


//show 함수 로그인 박스와 회원가입 박스를 열고 닫는 역할
function Login_show() {
    if (login_box.style.display == "none") {
        login_box.style.display = "";
    }else{
        login_box.style.display = "none";
    }
}

Login.addEventListener('click', Login_show);

function SignUp_show() {
    if (signup_box.style.display == "none") {
        signup_box.style.display = "";
    }else{
        signup_box.style.display = "none";
    }
}
SignUp.addEventListener('click', SignUp_show);
$(function() {

    var form = $("#loginForm");

    // 로그인 버튼 클릭
    $("#btnLogin").click(function() {

        var mem_id = $("#mem_id");
        var mem_pw = $("#mem_pw");

        if (mem_id.val() == null || mem_id.val() == "") {
            alert("아이디를 입력해주세요.");
            mem_id.focus();

        } else if (mem_pw.val() == null || mem_pw.val() == "") {
            alert("비밀번호를 입력해주세요.");
            mem_pw.focus();

        } else {
            form.submit();
        }
    });
});
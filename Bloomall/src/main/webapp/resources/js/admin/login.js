$(function() {

    var form = $("#AdminLoginForm");

    // 로그인 버튼 클릭
    $("#btnLogin").click(function() {

        var ad_id = $("#ad_id");
        var ad_pw = $("#ad_pw");

        if (ad_id.val() == null || ad_id.val() == "") {
            alert("아이디를 입력해주세요.");
            ad_id.focus();

        } else if (ad_pw.val() == null || ad_pw.val() == "") {
            alert("비밀번호를 입력해주세요.");
            ad_pw.focus();

        } else {
            form.submit();
        }
    });
});
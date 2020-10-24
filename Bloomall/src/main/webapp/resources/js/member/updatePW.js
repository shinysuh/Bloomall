var isOK = true;

$(function() {
    var form = $("#updatePwFrm");

    var mem_pw = $("#mem_pw");

    // 확인 버튼 클릭(btnOK)
    $("#btnOK").click(function() {

        checkIt();

        if (isOK == true) {

            // 현재 비밀번호 일치 여부 확인
            var pw_val = mem_pw.val();

            $.ajax({
                type	: 'post',
                url		: '/member/checkPW_Ajax',
                dataType: 'text',
                data	: { mem_pw: pw_val },
                success	: function(data) {
                    if (data == 'SUCCESS') {
                        form.submit();
                    } else {
                        alert("현재 비밀번호를 다시 확인해주세요.");
                        mem_pw.val('');
                        mem_pw.focus();
                    }
                }
            });
        }
    });
})


// 유효성 검사
function checkIt() {

    isOK = true;
    var mem_pw = $("#mem_pw");
    var mem_pw_updated = $("#mem_pw_updated");
    var mem_pw_chk = $("#mem_pw_chk");

    if (!(mem_pw.val())) {
        alert("현재 비밀번호를 입력해주세요.")
        mem_pw.focus();
        isOK = false;
        return false;

    } else if (!(mem_pw_updated.val())) {
        alert("새 비밀번호를 입력해주세요.")
        mem_pw_updated.focus();
        isOK = false;
        return false;

    } else if (!(mem_pw_chk.val())) {
        alert("새 비밀번호 확인란을 입력해주세요.")
        mem_pw_chk.focus();
        isOK = false;
        return false;

    } else if (mem_pw_updated.val() != mem_pw_chk.val()) {
        alert("새 비밀번호가 일치하지 않습니다.");

        mem_pw_updated.val('');
        mem_pw_chk.val('');
        mem_pw_updated.focus();
        isOK = false;
        return false;
    }
}
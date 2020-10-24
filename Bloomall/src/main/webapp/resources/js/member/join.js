$(function() {
    var form = $("#joinFrm");
    // 아이디 중복체크 여부
    var isIdChecked = false;
    // 이메일 인증 여부
    var isEmailConfirmed = false;

    // 아이디 중복확인 클릭
    $("#btnConfirmId").on("click", function() {
        var mem_id = $("#mem_id");
        var avail = $("#id_availability");

        if (mem_id.val() == null || mem_id.val() == "") {
            avail.html("사용할 아이디를 입력해주세요.");
            return;
        }

        var id_val = mem_id.val();

        $.ajax({
            type	: 'post',
            url		: '/member/confirmId',
            dataType: 'text',
            data	: { mem_id: id_val },
            success	: function(data) {
                if (data == 'SUCCESS') { // 아이디 사용 가능
                    avail.css("color", "blue");
                    avail.html("사용 가능한 아이디 입니다.");
                    isIdChecked = true;

                } else { // 아이디 사용 불가능
                    avail.css("color", "red");
                    avail.html("이미 존재하는 아이디 입니다.");
                    mem_id.focus();
                }
            }
        });
    });

    /* 아이디 중복 확인 후 아이디 변경 시 중복확인 활성화 */
    $("#mem_id").on("change", function() {
        isIdChecked = false;
    });


    // 인증코드 요청 클릭(이메일)
    $("#btnRequestCode").click(function() {
        var recipient = $("#mem_email").val();
        var auth_stat = $("#authcode_status");

        if (recipient == null || recipient == "") {
            auth_stat.html("이메일 주소를 입력해주세요.");
            return;
        }

        // 인증코드 전송 작업 진행중
        auth_stat.css("color", "grey");
        auth_stat.html("인증코드 메일을 전송중입니다. 잠시만 기다려주세요.");

        // 인증코드 전송 완료 작업
        $.ajax({
            type: 'post',
            url: '/email/send', // EmailController.java
            dataType: 'text',
            data: { recipient_email: recipient },
            success: function(data) {
                $("#email_authcode").show();
                auth_stat.css("color", "grey");
                auth_stat.html("메일이 전송되었습니다. 인증코드 확인 후 입력해주세요");
            }
        });
    });


    // 이메일 인증하기 클릭
    $("#btnConfirmCode").click(function() {
        var code = $("#mem_authcode").val();
        var auth_stat = $("#authcode_status");

        $.ajax({
            type	: 'post',
            url		: '/member/emailAuthConfirm',
            dataType: 'text',
            data	: { code: code },
            success	: function(data) {
                if (data == "SUCCESS") {
                    $("#email_authcode").hide();
                    auth_stat.css("color", "blue");
                    auth_stat.html("이메일 인증에 성공했습니다.");
                    isEmailConfirmed = true;
                    return;
                } else {
                    $("#email_authcode").hide();
                    auth_stat.css("color", "red");
                    auth_stat.html("이메일 인증 실패. 다시 시도해 주세요.");
                    return;
                }
            }
        });
    });


    // 회원가입 버튼 클릭
    $("#btnRegister").click(function() {

        var mem_id = $("#mem_id");
        var mem_pw = $("#mem_pw");
        var mem_pw_chk = $("#mem_pw_chk");
        var mem_name = $("#mem_name");
        var mem_nick = $("#mem_nick");
        var mem_email = $("#mem_email");
        var mem_authcode = $("#mem_authcode");
        var mem_tel = $("#mem_tel");
        var mem_zip = $("input[name='mem_zip']");
        var mem_addr = $("input[name='mem_addr']");
        var mem_addr_d = $("input[name='mem_addr_d']");

        // 유효성 검사
        if (mem_id.val() == null || mem_id.val() == "") {
            alert("아이디를 입력해 주세요.");
            mem_id.focus();

        } else if (isIdChecked == false) {
            alert("아이디 중복확인을 해주세요.")
            $("#btnConfirmId").focus();

        } else if (mem_pw.val() == null || mem_pw.val() == "") {
            alert("비밀번호를 입력해 주세요.");
            mem_pw.focus();

        } else if (mem_pw_chk.val() == null || mem_pw_chk.val() == "") {
            alert("비밀번호 확인란을 입력해 주세요.");
            mem_pw_chk.focus();

        } else if (mem_pw_chk.val() != mem_pw.val()) {
            alert("비밀번호가 일치하지 않습니다.");
            mem_pw_chk.focus();

        } else if (mem_name.val() == null || mem_name.val() == "") {
            alert("이름을 입력해 주세요.");
            mem_name.focus();

        } else if (mem_nick.val() == null || mem_nick.val() == "") {
            alert("사용할 닉네임을 입력해 주세요.");
            mem_nick.focus();

        } else if (mem_email.val() == null || mem_email.val() == "") {
            alert("이메일을 입력해 주세요.");
            mem_email.focus();

        } else if (mem_authcode.val() == null || mem_authcode.val() == "") {
            alert("이메일 인증코드를 입력해 주세요.");
            mem_authcode.focus();

        } else if (isEmailConfirmed == false) {
            alert("이메일 인증을 해주세요.");
            $("#btnRequestCode").focus();

        } else if (mem_tel.val() == null || mem_tel.val() == "") {
            alert("휴대폰 번호를 입력해 주세요.");
            mem_tel.focus();

        } else if (mem_zip.val() == null || mem_zip.val() == "") {
            alert("우편번호를 입력해 주세요.");
            $("#btn_postCode").focus();

        } else if (mem_addr.val() == null || mem_addr.val() == "") {
            alert("주소를 입력해 주세요.");
            $("#btn_postCode").focus();

        } else if (mem_addr_d.val() == null || mem_addr_d.val() == "") {
            alert("상세주소를 입력해 주세요.");
            mem_addr_d.focus();

        } else {
            form.submit();
        }
    });

    // 가입취소 버튼 클릭
    $("#btnCancel").click(function() {
        if (confirm("가입을 취소하시겠습니까?")) {
            location.href = "/";
        } else {}
    });
});
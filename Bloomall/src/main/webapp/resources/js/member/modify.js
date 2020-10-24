$(function() {
    var form = $("#modifyFrm");

    // 이메일 인증 확인 플래그
    var isEmailConfirmed = true;

    // 이메일 변경 시, 인증버튼 활성화
    $("#mem_email").on("change", function() {
        $("#btnRequestCode").show();
        isEmailConfirmed = false;
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
            type	: 'post',
            url		: '/email/send', // EmailController.java
            dataType: 'text',
            data	: { recipient_email: recipient },
            success	: function(data) {
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


    // 확인 버튼 클릭
    $("#btnModify").click(function() {

        var mem_pw = $("#mem_pw");
        var mem_name = $("#mem_name");
        var mem_nick = $("#mem_nick");
        var mem_email = $("#mem_email");
        var mem_tel = $("#mem_tel");
        var mem_zip = $("input[name='mem_zip']");
        var mem_addr = $("input[name='mem_addr']");
        var mem_addr_d = $("input[name='mem_addr_d']");


        if (mem_pw.val() == null || mem_pw.val() == "") {
            alert("현재 비밀번호를 입력해 주세요.");
            mem_pw.focus();
            return;

        } else if (mem_name.val() == null || mem_name.val() == "") {
            alert("이름을 입력해 주세요.");
            mem_name.focus();
            return;

        } else if (mem_nick.val() == null || mem_nick.val() == "") {
            alert("변경할 닉네임을 입력해 주세요.");
            mem_nick.focus();
            return;

        } else if (mem_email.val() == null || mem_email.val() == "") {
            alert("이메일을 입력해 주세요.");
            mem_email.focus();
            return;

        } else if (isEmailConfirmed == false) {
            alert("이메일 인증을 해주세요.");
            $("#btnRequestCode").focus();
            return;

        } else if (mem_tel.val() == null || mem_tel.val() == "") {
            alert("휴대폰 번호를 입력해 주세요.");
            mem_tel.focus();
            return;

        } else if (mem_zip.val() == null || mem_zip.val() == "") {
            alert("우편번호를 입력해 주세요.");
            $("#btn_postCode").focus();
            return;

        } else if (mem_addr.val() == null || mem_addr.val() == "") {
            alert("주소를 입력해 주세요.");
            $("#btn_postCode").focus();
            return;

        } else if (mem_addr_d.val() == null || mem_addr_d.val() == "") {
            alert("상세주소를 입력해 주세요.");
            mem_addr_d.focus();
            return;
        }


        // 현재 비밀번호 확인
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
        
    });

    // 취소 버튼 클릭
    $("#btnCancel").click(function() {
        if (confirm("회원정보 수정을 취소하시겠습니까?")) {
            location.href = "/";
        } else {}
    });
});
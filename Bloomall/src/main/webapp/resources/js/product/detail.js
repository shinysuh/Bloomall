$(function() {

    var replyPage = 1;

    // [장바구니] 버튼 ([바로구매]는 submit으로 전송됨)
    $("#btn_addCart").click(function() {

        var prd_idx = $("#prd_idx").val();   // 상품코드
        var ord_amount = $("#ord_amount").val(); // 구매수량

        // ajax로 장바구니에 전송









    });

    // 핸들바 날짜 형식 tidyDate
    Handlebars.registerHelper("tidyDate", function(timeVal) {

        var dateObj = new Date(timeVal);
        var year = dateObj.getFullYear();
        var month = dateObj.getMonth() + 1;
        var date = dateObj.getDate();

        return year + "/" + month + "/" + date;
    });

    // 파라미터로 받은 후기 평점을 별표로 출력 checkRating
    Handlebars.registerHelper("checkRating", function(rating) {

        var stars = "";

        switch (rating) {
            case 1:
                stars = "★☆☆☆☆";
                break;
            case 2:
                stars = "★★☆☆☆";
                break;
            case 3:
                stars = "★★★☆☆";
                break;
            case 4:
                stars = "★★★★☆";
                break;
            case 5:
                stars = "★★★★★";
                break;
            default:
                stars = "☆☆☆☆☆";
        }
        return stars;
    });


    // 별점 클릭 시, 색상 변경
    $("#star_score a").click(function() {
        // 별점 on 클래스 전부 제거(style 설정)
        $(this).parent().children("a").removeClass("on");
        // 선택된 별과 그 앞 별들 다 on 클래스 다시 생성
        $(this).addClass("on").prevAll("a").addClass("on");

        return false;
    });

    // 별점 리뷰 리스트
    getStars("/review/" + $("#prd_idx").val() + "/" + replyPage);

    // [리뷰 작성] 버튼
    $("#btn_writeRvw").click(function() {

        var rvw_rating = 0;
        var rvw_content = $("#reviewContent").val();
        var prd_idx = $("#prd_idx").val();

        // 입력된 별점의 개수 가져옴
        $("#star_score a").each(function(i, e) {
            if ($(this).attr("class") == "on") {
                rvw_rating += 1;
            }
        });

        // 유효성 검사
        if (rvw_rating == 0) {
            alert("별점을 선택해주세요.");
            return;
        } else if (rvw_content == "" || rvw_content == null) {
            alert("리뷰 내용을 입력해주세요.")
            return;
        }

        // DB 연동
        $.ajax({
            type: "post",
            url: "/review/write/",
            dataType: "text",
            data: JSON.stringify({
                rvw_rating: rvw_rating,
                rvw_content: rvw_content,
                prd_idx: prd_idx
            }),
            success: function(data) {
                alert("리뷰가 등록되었습니다.");
                
                replyPage = 1;

                getPage("/review/" + prd_idx + "/" + replyPage);
                
                // 별점/상품 후기 비우기
                $("#star_score a").parent().children("a").removeClass("on");
                $("#rvw_content").val("");
            }
        });
    });


    // [리뷰 보기] 클릭 - 리뷰리스트 열기 / 접기 : 리뷰 리스트 열려있으면 버튼 값 [리뷰 접기]로 바꾸기
    $("#repliesDiv").click(function() {

        var prd_idx = $("#prd_idx").val();

        // 버튼 이름 바꾸기
        $(".timeline li span span").html("리뷰 접기");

        // 리뷰리스트 열려 있으면 닫기
        if ($(".timeline li").length > 2) {
            // 버튼 이름 바꾸기
            $(".timeline li span span").html("리뷰 보기");

            $(".openList").remove();
            $(".noReview").hide();
            $("#pagination li").remove();

            return;
        }

        // 닫혀 있으면 열기, 목록 보여주기
        getPage("/review/" + prd_idx + "/" + replyPage);
    });


    // 페이징 버튼 클릭 시
    $("#pagination").on("click", "li a", function(event) {

        var prd_idx = $("#prd_idx").val();

        event.preventDefault();

        replyPage = $(this).attr("href");
        getPage("/review/" + prd_idx + "/" + replyPage);
    });










/* 상품 후기 수정 begin */
    // 상품후기 [수정] 버튼 이벤트
    $("button[name='btn_rvwEdit']").click(function(){

        $(".editFormat").show();
        // $(".editFormat").prevAll().hide();

        var rvw_rating_hb = 0;
        var rvw_rating_hb = $(this).find(".rvw_rating").text();
        var r_content_hb = $("#r_content_hb").val();



        // 입력된 별점의 개수 가져옴
        $("#star_score a").each(function(i, e) {
            if ($(this).attr("class") == "on") {
                rvw_rating_hb += 1;
            }
        });

        // 유효성 검사
        if (rvw_rating_hb == 0) {
            alert("별점을 선택해주세요.");
            return;
        } else if (r_content_hb == "" || r_content_hb == null) {
            alert("리뷰 내용을 입력해주세요.")
            return;
        }



    });
    

    // 리뷰 수정 - 별점 클릭 시, 색상 변경
    $("#star_score_hb a").click(function() {
        // 별점 on 클래스 전부 제거(style 설정)
        $(this).parent().children("a").removeClass("on");
        // 선택된 별과 그 앞 별들 다 on 클래스 다시 생성
        $(this).addClass("on").prevAll("a").addClass("on");

        return false;
    });







/* 상품 후기 수정 end */




    // // 상품후기 [삭제] 버튼
    // $(".btn_rvwDelete").click(function() {

    //     var rvw_idx = $(this).prev().prev().prev().prev().val();

    //     if (confirm("상품 후기를 삭제하시겠습니까?")) {
    //         $.ajax({
    //             type: "post",
    //             url: "/review/delete/" + rvw_idx,
    //             dataType: "text",
    //             data: JSON.stringify({ rvw_idx: rvw_idx }),
    //             success: function(data) {
    //                 alert("상품 후기가 삭제되었습니다.");
    //                 $("#repliesDiv").empty();
    //                 var prd_idx = $("#prd_idx").val();
    //                 getPage("/review/" + prd_idx + "/" + replyPage);
    //             }
    //         });
    //     } else {}
    // });



   


    // 회색 칸에서 [회원리뷰 *건] 과 [리뷰 자세히 보기 >>] - 클릭시 리뷰 앵커 / 펼쳐짐 기능
    $(".toRvw").click(function() {

        var prd_idx = $("#prd_idx").val();

        // 앵커
        $(this).attr("href", "#repliesDiv");

        // 버튼 이름 바꾸기
        $(".timeline li span span").html("리뷰 접기");

        // 닫혀 있으면 열기, 목록 보여주기
        getPage("/review/" + prd_idx + "/" + replyPage);

    });

});


// 핸들바 템플릿에 후기 적용 함수
function getPage(pageInfo) {

    $.getJSON(pageInfo, function(data) {

        // 상품 후기 존재
        if (data.rvwList.length > 0) {

            printData(data.rvwList, $("#repliesDiv"), $("#rvwTemplate"));
            printPage(data.pageMaker, $("#pagination"));

        } else { // 후기 존재 X
            printNoData();
        }
    });
}

// 별점 핸들바 템플릿에 별점후기 적용 함수
function getStars(starInfo) {
    $.getJSON(starInfo, function(data) {
        // 별점 후기 존재
        if (data.rvwList.length > 0) {
            printData(data.rvwList, $("#starRvwList"), $("#starTemplate"));
        } else { // 별점 후기 존재 X
            $("#starRvwList").remove();
            $(".noStarRvw").show();
            $("#more_rvw").remove();
        }
    });
}

// 핸들바 함수 : 후기 있을 경우
function printData(reviewList, target, templateObj) {

    var template = Handlebars.compile(templateObj.html());

    var html = template(reviewList);
    $(".openList").remove();
    $("noReview").hide();
    target.after(html);
}

// 핸들바 함수 : 후기가 없을 경우
function printNoData() {
    $(".openList").remove();
    $(".noReview").show();
}


// 후기 하단 페이징
function printPage(pageMaker, target) {

    var str = "";

    // [이전] 버튼
    if (pageMaker.prev) {
        str += "<li class='paging'><a href='" + (pageMaker.startPage - 1) + "'> [이전] </a></li>";
    }

    // 페이지 넘버s
    for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
        var strClass = pageMaker.cri.page == i ? 'class=active' : '';
        str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
    }

    // [다음] 버튼
    if (pageMaker.next) {
        str += "<li class='paging'><a href='" + (pageMaker.endPage + 1) + "'> [다음] </a></li>";
    }
    
    // 확인용
    //alert("startPage="+pageMaker.startPage +"/ endPage="+pageMaker.endPage +" / page="+pageMaker.cri.page);

    target.html(str);
}



 // 상품후기 [삭제] 버튼 함수
function deleteRvw(rvw_idx){
    if (confirm("상품 후기를 삭제하시겠습니까?")) {
        $.ajax({
            type: "post",
            url: "/review/" + rvw_idx,
            dataType: "text",
            success: function(data) {
                if(data=='SUCCESS'){
                    alert("상품 후기가 삭제되었습니다.");
                }
                $("#repliesDiv").empty();
                var prd_idx = $("#prd_idx").val();
                getPage("/review/" + prd_idx + "/" + replyPage);
            }
        });
    } else {}
}

// 상품후기 [수정] 버튼 함수
function editRvw(rvw_idx){
    
    if($(".editFormat").hide()){
        $(".editFormat").show();

        var rvw_rating_hb = 0;
        var rvw_rating_hb = $(this).find(".rvw_rating").text();
        
    
        // 입력된 별점의 개수 가져옴
        $("#star_score a").each(function(i, e) {
            if ($(this).attr("class") == "on") {
                rvw_rating_hb += 1;
            }
        });
    }else{
        $(".editFormat").hide();
    }


    var r_content_hb = $("#r_content_hb").val();

    // 유효성 검사
    if (rvw_rating_hb == 0) {
        alert("별점을 선택해주세요.");
        return;
    } else if (r_content_hb == "" || r_content_hb == null) {
        alert("리뷰 내용을 입력해주세요.")
        return;
    }
}

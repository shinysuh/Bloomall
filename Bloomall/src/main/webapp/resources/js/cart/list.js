$(function(){
	
	// 처음에 전체상품 대상 "총 상품금액"/"예상 적립 포인트"/"최종 결제금액" 로드
    bringTotals();
    

    /* 전체선택 버튼 기능 */
	    // 전체 선택 체크 시,  다른 체크박스 전부 체크
    $("#checkAll").click(function(){
        $(".check").prop("checked", this.checked);
        bringTotals();
    });
    
        // 체크박스 중 하나라도 미체크 시, 전체선택 버튼 해제
    $(".check").click(function(){
        $("#checkAll").prop("checked", false);
        bringTotals();
    });


    
    /* 주문 기능 */
    // 개별 상품 구매  $("button[name='btnOrder']")




	// 선택 상품 구매  $("#btn_buy_chk")
	
    
    

	
	// 전체 상품 구매   $("#orderAll")  -  submit 타입
	
	
	





	/* 카트 기능 */
    // 수량 변경
    $(".btnUpdate").click(function(){
        var cart_idx = $(this).val();
        var cart_amount = $("input[name='cart_amount_"+ cart_idx + "']").val();

        $.ajax({
            type: 'post',
            url : '/cart/update/',
            dataType: 'text',
            data : {cart_idx:cart_idx, cart_amount:cart_amount},
            success: function(data){
                location.href="/cart/list";
            }
        });
    });

	
	// 상품 삭제 - 개별 상품
	$("button[name='btnDelete']").click(function(){
        
        var cart_idx = $(this).val();

        if(confirm("상품을 삭제하시겠습니까?")){

            $.ajax({
                type: 'post',
                url : '/cart/delete/',
                dataType: 'text',
                data : {cart_idx:cart_idx},
                success: function(data){
                    alert("상품이 삭제되었습니다.");
                    location.href = "/cart/list";
                }
                
            });
        }
    });
	
	
	
	// 선택 상품 삭제
	$("#btn_delete_chk").click(function(){
        // 체크박스 유효성 검사
        if($("input[name='check']:checked").length == 0){
            alert("삭제할 상품을 선택해주세요.");
            return;
        }

        // 체크 상품 존재 시
        if(confirm("선택한 상품을 삭제하시겠습니까?")){

         var chkArr = [];

         $("input[name='check']:checked").each(function(i){
            var cart_idx = $(this).val();
            chkArr.push(cart_idx);
        });

        $.ajax({
            type: 'post',
            url : '/cart/deleteChk/',
            dataType: 'text',
            data : {chkArr:chkArr},
            success: function(data){
                alert("선택 상품이 삭제되었습니다.");
                location.href = "/cart/list";
            }
            
        });
            
        }
    });


	
});

// "총 상품금액"/"예상 적립 포인트"/"최종 결제금액" 업데이트
function bringTotals(){

    var total_price = 0;
    var total_dc_price = 0;
    var total_point = 0;
    var total_discount = 0;
    
    // 선택된 상품들 각각의 수량에 따라 총합 도출
    $("input[name='check']:checked").each(function(i){
        var cart_idx = $(this).val();
        var amount = $(this).next().next().val();
        var price = $("input[name='price_"+ cart_idx +"']").val();
        var dc_price = $("input[name='dc_price_"+ cart_idx +"']").val();
        var point = $("input[name='point_"+ cart_idx +"']").val();

        total_price += parseInt(price) * amount;
        total_dc_price += parseInt(dc_price) * amount;
        total_point += parseInt(point) * amount;
    });

    total_discount = total_price - total_dc_price;

    // 각각의 태그에 총 합계금액 각각 출력
    $("#total_price").html(numberFormat(total_price) + "원");
    $("#total_dc_price").html(numberFormat(total_dc_price) + "원");
    $("#total_point").html("(" + numberFormat(total_point) + "원)");
    $("#total_discount").html(numberFormat(total_discount) + "원");
}

// 최종 금액 출력 형식(###,###,###)
function numberFormat(number){
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
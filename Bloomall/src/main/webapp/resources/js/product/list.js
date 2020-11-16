$(function(){
	
	// 상품별 별점 출력
	$(".tr").each(function(i){
		
		var prd_idx = $(this).find("input[name='prd_idx']").val();
		
		var avg = $(this).find("input[name='avg_rating']").val();
		
		var star1 = $("#star1_" + prd_idx);
		var star2 = $("#star2_" + prd_idx);
		var star3 = $("#star3_" + prd_idx);
		var star4 = $("#star4_" + prd_idx);
		var star5 = $("#star5_" + prd_idx);
		
		star1.attr("class", "fa fa-star text-default");
	    star2.attr("class", "fa fa-star text-default");
	    star3.attr("class", "fa fa-star text-default");
	    star4.attr("class", "fa fa-star text-default");
	    star5.attr("class", "fa fa-star text-default");
	
	    if(avg >= 0 && avg < 1){
	
	    }else if(avg >= 1 && avg < 3){
	        star1.attr("class", "fa fa-star text-primary");
	    }else if(avg >= 3 && avg < 5){
	        star1.attr("class", "fa fa-star text-primary");
	        star2.attr("class", "fa fa-star text-primary");
	    }else if(avg >= 5 && avg < 7){
	        star1.attr("class", "fa fa-star text-primary");
	        star2.attr("class", "fa fa-star text-primary");
	        star3.attr("class", "fa fa-star text-primary");
	    }else if(avg >= 7 && avg < 9){
	        star1.attr("class", "fa fa-star text-primary");
	        star2.attr("class", "fa fa-star text-primary");
	        star3.attr("class", "fa fa-star text-primary");
	        star4.attr("class", "fa fa-star text-primary");
	    }else if(avg >= 9){
	        star1.attr("class", "fa fa-star text-primary");
	        star2.attr("class", "fa fa-star text-primary");
	        star3.attr("class", "fa fa-star text-primary");
	        star4.attr("class", "fa fa-star text-primary");
	        star5.attr("class", "fa fa-star text-primary");
	    }
		
	});		

		
	// 바로구매  btn_purchaseOne
	$(".btn_purchaseOne").click(function(){
		var prd_idx = $(this).val();
		var ord_amount = $("#count_"+prd_idx).val();
		
		location.href = "/order/one?prd_idx=" + prd_idx + "&ord_amount=" + ord_amount;
	});
	
	// 장바구니  btn_addToCart
	$(".btn_addToCart").click(function(){
		
		var prd_idx = $(this).val();
		var cart_amount = $(this).prev().find("input[name='ord_amount']").val();
		
		$.ajax({
			type	: 'post',
			url		: '/cart/add/',
			dataType: 'text',
			data	: {prd_idx:prd_idx, cart_amount:cart_amount},
			success	: function(data){
				if(confirm("상품이 장바구니에 추가되었습니다. \n장바구니로 이동 하시겠습니까?")){
					location.href = "/cart/list";
				}else{}
			}
		});
	});
	
	// 체크 상품 장바구니	btn_cartChk
	$("#btn_cartChk").click(function(){
		
		var checked = $("input[name='check']:checked");
		
		// 체크박스 유효성 검사
		if(checked.length == 0){
			alert("장바구니에 추가할 상품을 선택해주세요.");
			return;
		}
		
		var chkArr = [];
		var amtArr =[];
		
		checked.each(function(i){
			var prd_idx = $(this).val();
			var cart_amount = $(this).next().next().val();
			
			chkArr.push(prd_idx);
			amtArr.push(cart_amount);
		});
		
		$.ajax({
			type	: 'post',
			url		: '/cart/addchk/',
			dataType: 'text',
			data	: {chkArr : chkArr, amtArr :amtArr},
			success	: function(data){
				if(confirm("선택 상품이 장바구니에 담겼습니다. \n장바구니로 이동 하시겠습니까?")){
					location.href = "/cart/list";
				}else{}
			}
		});
	});
	
});

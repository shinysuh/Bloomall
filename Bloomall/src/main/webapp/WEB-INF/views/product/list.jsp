<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<%@include file="/WEB-INF/views/include/listCSS.jsp" %>

<script type="text/javascript">
$(function(){
	 
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



</script>

</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<%@include file="/WEB-INF/views/include/main_header.jsp" %>
		<%@include file="/WEB-INF/views/include/left_sidebar.jsp" %>
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<section class="content-header">
				<!-- "/product/list?ctgr_cd=all" => '모든 상품' 출력 -->
				<c:if test="${ctgr_cd == 'all'}">
					<h1>
						Product List <small>${ctgr_name }</small>
					</h1>
					<ol class="breadcrumb">
						<li>
							<a href="#"><i class="fa fa-dashboard"></i> Product</a>
						</li>
						<li>All</li>
					</ol>
				</c:if>
				<!-- "/product/list?ctgr_cd=${ctgr_cd}" => ${prt_name } 출력 -->
				<c:if test="${ctgr_cd ne 'all'}">
					<c:if test="${empty prt_name}">
						<h1>
							Product List <small>${ctgr_name }</small>
						</h1>
							<ol class="breadcrumb">
							<li>
								<a href="/product/list?ctgr_cd=${ctgr_cd }"><i class="fa fa-dashboard"></i> Product</a>
							</li>
							<li>${ctgr_name }</li>
						</ol>
					</c:if>
					<c:if test="${!empty prt_name}">
						<h1>
							Product List <small>${prt_name }</small>
						</h1>
							<ol class="breadcrumb">
							<li>
								<a href="/product/list?ctgr_cd=${ctgr_cd }"><i class="fa fa-dashboard"></i> Product</a>
							</li>
							<li>${prt_name }</li>
						</ol>
					</c:if>
				</c:if>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<!-- 상품목록 -->
				<div class="col-md-9">
				<form id="productForm" method="post" action="/order/productChk">
					<div>
					<h5><i class="fa fa-book"></i> ${ctgr_name }</h5>
						<div style="display: inline-block; float: right; margin-right:10%;">
							<span>선택한 상품 &nbsp;</span>
							<button type="button" id="btn_cartChk" class="btn btn-default">&#9745;장바구니</button>					
							<button type="submit" id="btn_buyChk" class="btn btn-default">&#9745;바로구매</button>					
						</div>
					<br><hr class="dotted_hr"><br>
					</div>
				
				<!-- 상품 리스트 테이블 시작 -->
					<div class="productList productList_list">
					    <table width="90%">					
					        <colgroup>
							    <col width="95"/>
							    <col/>
							    <col width="82"/>
						    </colgroup>
						    
						    
						    <%-- 등록된 상품이 없는 경우 --%>
							<c:if test="${empty productList}">
							<tr>
								<p style="padding:50px 0px; text-align: center;border-collapse: collapse;">등록된 상품이 존재하지 않습니다.</p>
							</tr>
							</c:if>
							<%-- 등록된 상품이 존재하는 경우 --%>
					        <!-- 상품 목록 시작-->
					        <%--<c:set var="i" value="${fn:length(productList)}" ></c:set> <!-- productList : 컬렉션 형태 -->--%>
					        <c:forEach items="${productList}" var="prdList">	    
					        <tr>
					      		<td class="product_img" style="width:13%;height:140%">
					            	<div class="ico_wrap"></div>
				            		<%-- 책 이미지 링크 begin --%>
					            	<c:if test="${ctgr_cd == 'all' || !empty prt_name}">
					            		<!-- 모든상품/2차카테고리 -->
						            	<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&ctgr_cd=${ctgr_cd}">
						                <img src="/product/fileDisplay?fileName=${prdList.prd_img }" alt="${prdList.prd_title}"></a>
					            	</c:if>
									<c:if test="${empty prt_name && ctgr_cd != 'all'}">
										<!-- 1차카테고리 -->
						            	<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&prime_ctgr_cd=${prime_ctgr_cd}">
						                <img src="/product/fileDisplay?fileName=${prdList.prd_img }" alt="${prdList.prd_title}"></a>
									</c:if>
					            	<%-- 책 이미지 링크 end --%>
								</td>
								<td class="product_info" style="line-height:170%;">
									<div>&nbsp;</div>
									<%-- 책제목 링크 begin --%>
									<c:if test="${ctgr_cd == 'all' || !empty prt_name}">
					            		<!-- 모든상품/2차카테고리 -->
										<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&ctgr_cd=${ctgr_cd}">
										<strong style="color:black;font-size:16px;">${prdList.prd_title}</strong>
										</a>
										<c:if test="${prdList.ctgr_prt_cd == '300' }">
										<span class="print_eBook">&nbsp;[eBook]</span>
										</c:if>
					            	</c:if>
									<c:if test="${empty prt_name && ctgr_cd != 'all'}">
										<!-- 1차카테고리 -->
										<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&prime_ctgr_cd=${prime_ctgr_cd}">
										<strong style="color:black;font-size:17px;">${prdList.prd_title}</strong>
										</a>
										<c:if test="${prime_ctgr_cd == '300' }">
										<span class="print_eBook">&nbsp;[eBook]</span>
										</c:if>
									</c:if>
									<%-- 책제목 링크 end --%>
									<div class="info">
										${prdList.prd_author} 저 <span class='dim_txt002'>|</span>${prdList.prd_company}
									</div>
									<div class="price">
										판매가: <span class="dc_price"><fmt:formatNumber value="${prdList.prd_dc_price}" pattern="###,###,###" /></span>원 
										<br>
										<span class="org_price">정가: <fmt:formatNumber value="${prdList.prd_price}" pattern="###,###,###" />원 </span> <em class="divi">|</em>
										<span class="point_benefit">포인트 적립: <fmt:formatNumber value="${prdList.prd_price * 0.03}" pattern="###,###,###" /></span>
									</div>
									<div class="rating_info">
										<span class="rvwCount">
											판매지수 <span style="color:red;"> (판매count 넣기)</span><em class="divi">|</em>
											회원리뷰 <a href="#">${rvwCount}</a>건
										</span><br>
										<span class="rating">평점: </span>
										<span class="stars">
									        <label for="stars-rating-5"><i class="fa fa-star text-primary"></i></label>
								    	    <label for="stars-rating-4"><i class="fa fa-star text-primary"></i></label>
								        	<label for="stars-rating-3"><i class="fa fa-star text-primary"></i></label>
								        	<label for="stars-rating-2"><i class="fa fa-star text-primary"></i></label>
								         	<label for="stars-rating-1"><i class="fa fa-star text-default"></i></label>
								         	<b style="color:red;">9.3 (평점 EL 문법으로 표시)</b>
										</span>
									</div>
									<br>
								</td>
								<td class="buttons">
									<span class="prd_count_edit">
										<!-- 상품번호 hidden -->
						            	<input type="hidden" name="prd_idx" value="${prdList.prd_idx}" />
									<%--<c:set value="${0 }" var="i"> 체크박스 value 바꾸면 다른 기능도 손보기--%>
										
										<input type="checkbox" name="check" class="check" value="${prdList.prd_idx }" />
										<span class="count">수량</span>
										<input type="text" class="count_input" value="1" id="count_${prdList.prd_idx }" name="ord_amount" style="width:70%;margin-bottom:3px;" />
									</span>
									<button type="button" class="btn_addToCart btn btn-primary" style="width:100%;margin-bottom:3px;" value="${prdList.prd_idx }">장바구니</button>
									<button type="button" class="btn_purchaseOne btn btn-default" style="width:100%;" value="${prdList.prd_idx }">바로구매</button>
								</td>
							</tr>     
							<%-- <c:set var="i" value="${i-1}" ></c:set> --%>
							</c:forEach>            
						</table>
						<!-- 상품 리스트 테이블 끝 -->
					</div>
					</form>
					<%-- 페이징 --%>
					<div class="paging">
						<div class="text-center">
						
							<c:if test="${ctgr_cd == 'all' || !empty prt_name}">
								<!-- 모든상품/2차카테고리 -->
								<ul class="pagination">
									<!-- [이전] 표시 -->
									<c:if test="${pageMaker.prev }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.cri.page - 1)}&ctgr_cd=${ctgr_cd}">[이전]</a>
										</li>
									</c:if>
									<!-- 페이지 번호 표시 -->
									<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
										<li <c:out value="${pageMaker.cri.page == idx?'class=active':''}" />>
											<a 
											 href="/product/list${pageMaker.makeQuery(idx) }&ctgr_cd=${ctgr_cd}">${idx}</a>
										</li>
									</c:forEach>
								
									<!-- [다음] 표시 -->
									<c:if test="${pageMaker.next }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.cri.page + 1)}&ctgr_cd=${ctgr_cd}">[다음]</a>
										</li>
									</c:if>
								</ul>
							</c:if>
							<c:if test="${empty prt_name && ctgr_cd != 'all'}">
								<!-- 1차 카테고리 -->
								<ul class="pagination">
									<!-- [이전] 표시 -->
									<c:if test="${pageMaker.prev }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.startPage - 1)}&prime_ctgr_cd=${prime_ctgr_cd}">[이전]</a>
										</li>
									</c:if>
									<!-- 페이지 번호 표시 -->
									<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
										<li <c:out value="${pageMaker.cri.page == idx?'class=active':'' }" />>
											<a 
											 href="/product/list${pageMaker.makeQuery(idx) }&prime_ctgr_cd=${prime_ctgr_cd}">${idx }</a>
										</li>
									</c:forEach>
								
									<!-- [다음] 표시 -->
									<c:if test="${pageMaker.next }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.endPage + 1 )}&prime_ctgr_cd=${prime_ctgr_cd}">[다음]</a>
										</li>
									</c:if>
								</ul>
							</c:if>
						</div>
					</div>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/views/include/footer.jsp" %>

		<!-- Control Sidebar -->
		<%@include file="/WEB-INF/views/include/control_sidebar.jsp" %>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

</body>
</html>
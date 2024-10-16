<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<%@include file="/WEB-INF/views/include/listCSS.jsp" %>

<script type="text/javascript" src="/js/product/list.js"></script>

</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<%@include file="/WEB-INF/views/include/main_header.jsp" %>
		<%@include file="/WEB-INF/views/include/left_sidebar.jsp" %>
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<section class="content-header">
			<!-- 검색목록 리스트 헤더 -->
					<h1>
						Product List <small>검색 결과</small>
					</h1>
					<ol class="breadcrumb">
						<li>
							<a href="#"><i class="fa fa-dashboard"></i> Product</a>
						</li>
						<li>Search</li>
					</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<!-- 상품목록 -->
				<div class="col-md-9">
					<form id="productForm" method="post" action="/order/productChk">
					<div>
					<h5><i class="fa fa-book"></i> 검색 결과 > "${scri.keyword }"</h5>
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
						    
						    
						    <%-- 검색 조건에 일치하는 상품이 없는 경우 --%>
							<c:if test="${empty productList}">
							<tr>
								<p style="padding:50px 0px; text-align: center;border-collapse: collapse;">검색 조건에 해당하는 상품이 존재하지 않습니다.</p>
							</tr>
							</c:if>
							
							<%-- 검색 조건에 일치하는 상품이 존재하는 경우 --%>
					        <!-- 상품 목록 시작-->
					        <c:forEach items="${productList}" var="prdList" varStatus="i">	    
					        <tr class="tr">
					      		<td class="product_img" style="width:13%;height:140%">
					            	<div class="ico_wrap"></div>
					            	<a href="/product/detailSearch${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}">
					                <img src="/product/fileDisplay?fileName=${prdList.prd_img }" alt="${prdList.prd_title}"></a>
								</td>
								<td class="product_info" style="line-height:170%;">
									<div>&nbsp;</div>
									<a href="/product/detailSearch${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}">
										<strong style="color:black;font-size:16px;">${prdList.prd_title}</strong>
									</a>
									<c:if test="${prdList.ctgr_prt_cd == '300' }">
										<span class="print_eBook">&nbsp;[eBook]</span>
										</c:if>
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
											판매지수 <span style="font-size:14px;font-weight:bold"> ${prdList.ord_amount }</span><em class="divi">|</em>
											회원리뷰 <a href="/product/detailSearch${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}#repliesDiv"><span style="color:blue;font-size:14px;font-weight:bold">${prdList.rvw_count}</span></a>건
										</span><br>
										<span class="rating">평점: </span>
										<span class="stars">
									       	<label><i id="star1_${prdList.prd_idx}"></i></label>
								        	<label><i id="star2_${prdList.prd_idx}"></i></label>
								        	<label><i id="star3_${prdList.prd_idx}"></i></label>
								    	    <label><i id="star4_${prdList.prd_idx}"></i></label>
									        <label><i id="star5_${prdList.prd_idx}"></i></label>
								         	<input type="hidden" name="avg_rating" value="${rvwAverage[i.index]}" />
								         	<!-- 상품번호 hidden -->
								         	<input type="hidden" name="prd_idx" value="${prdList.prd_idx}" />
											<b style="color:black; font-size:22px" ><fmt:formatNumber value="${rvwAverage[i.index]}" pattern="#.##" /></b>
										</span>
									</div>
									<br>
								</td>
								<td class="buttons">
									<span class="prd_count_edit">
										<input type="checkbox" name="check" class="check" value="${prdList.prd_idx }" />
										<span class="count">수량</span>
										<input type="text" class="count_input" value="1" id="count_${prdList.prd_idx }" name="ord_amount" style="width:70%;margin-bottom:3px;" />
									</span>
									<button type="button" class="btn_addToCart btn btn-primary" style="width:100%;margin-bottom:3px;" value="${prdList.prd_idx }">장바구니</button>
									<button type="button" class="btn_purchaseOne btn btn-default" style="width:100%;" value="${prdList.prd_idx }">바로구매</button>
								</td>
							</tr>     
							</c:forEach>           
						</table>
						<!-- 상품 리스트 테이블 끝 -->
					</div>
					
					<%-- 페이징 --%>
					<div class="paging">
						<div class="text-center">
							<ul class="pagination">
									<%-- [이전] 표시 --%>
									<c:if test="${pageMaker.prev }">
										<li>
											<a href="/product/listSearch${pageMaker.makeSearch(pageMaker.startPage - 1)}">[이전]</a>
										</li>
									</c:if>
									<%-- 페이지 번호 표시 --%>
									<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
										<li <c:out value="${pageMaker.cri.page == idx?'class=active':'' }" />>
											<a 
											 href="/product/listSearch${pageMaker.makeSearch(idx) }">${idx }</a>
										</li>
									</c:forEach>
								
									<%-- [다음] 표시 --%>
									<c:if test="${pageMaker.next }">
										<li>
											<a href="/product/listSearch${pageMaker.makeSearch(pageMaker.endPage + 1)}">[다음]</a>
										</li>
									</c:if>
								</ul>
						</div>
					</div>
					</form>
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
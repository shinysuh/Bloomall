<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<script type="text/javascript" src="/js/admin/login.js"></script>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="/WEB-INF/views/include/main_header_ad.jsp" %>
		<%@include file="/WEB-INF/views/include/left_sidebar_ad.jsp" %>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Order Management <small>주문관리</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/menu"><i class="fa fa-dashboard"></i> Admin</a>
					</li>
					<li>
						Order
					</li>
					<li>
						Management
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				
				주문번호(주문상품) / 주문자 / 수령자 / 결제(수단) / 금액 / [처리상태(주문접수(1) / 배송준비중(2) / 배송중(3) / 배송완료(4) / 취소/반품(5)])]
				<div class="box" style="border: none;">
					<div class="box-body">
						<!-- 페이징 정보 저장 -->
						<div id="pagingInfo">
							<input type="hidden" name="page" value="${cri.page }" />
							<input type="hidden" name="perPageNum" value="${cri.perPageNum }" />
							<input type="hidden" name="searchType" value="${cri.searchType }" />
							<input type="hidden" name="keyword" value="${cri.keyword }" />
						</div>
						<!-- 상품 리스트 테이블 -->
						<div>
							<h5>주문번호 : ${orderDetail.ord_idx }</h5>
						</div>
						<table class="table table-striped text-center">
							<tr>
								<th>선택</th>
								<th>번호</th>
								<th>상품명</th>
								<th>수량</th>
								<th>상품가격</th>
								<th>판매가격</th>
								<th>소계</th>
								<th>처리상태</th>
							</tr>
						  
							<!--
								(수정가능) 항목들은 input으로 => 맨아래 수정버튼으로 수정 제출
								
								[1번 테이블(상품정보)]
								선택 / 번호 / 상품명 / 수량(수정가능) / 정가 / 판매가격(수정가능) / 소계(가격*수량) / 처리상태 (readonly)(아래에 수정 dropdown)
								
								
								[div]
								주문상태 -> 변경		//		(버튼) 이 주문 삭제하기
								
								
								[2번 테이블(결제정보)]
								총 주문금액
								총 할인금액
								결제금액 - 쿠폰이나 포인트 사용에 따라 달라질 수 있는 항목
								결제수단 
								
								
								[3번 테이블(주문자 정보)]	 	/		[4번 테이블(수령자 정보)]
								이름/ID							수령자 이름(수정가능)
								이메일							연락처(ord_recp_tel)(수정가능)
								연락처(user.mem_tel)(수정가능)		주소/우편번호(수정가능)
								주문날짜							상세주소(수정가능)
								
								
								
								
										[수정] / [목록]
															
							 -->
















						</table>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<script type="text/javascript" src="/js/admin/login.js"></script>
<head>
<script type="text/javascript">
$(function(){
	
	// 검색 버튼
	$("#btnSearch").click(function(){
		self.location = "orderList" + "${pageMaker.makeQuery(1)}"
					  + "&searchType=" + $("#search").val()
					  + "&keyword=" + $("#keyword").val();
	});
	
	
	// chkAll 클릭 시 전체 선택
	$("#chkAll").click(function(){
		$(".check").prop("checked", this.checked);
	});
	
	// 체크박스 하나라도 미체크 시, chkAll 박스 해제
	$(".check").click(function(){
		$("#chkAll").prop("checked", false);
	});

	
	// 주문상태 변경 버튼(개별)
	$("button[name='btnUpdate']").click(function(){
		var ord_idx = $(this).val();
		var ord_state = $("select[name='ord_state_" + ord_idx + "']").val();
		
		$.ajax({
			type	: 'post',
			url		: '/admin/order/updateState',
			dataType: 'text',
			data	: {ord_idx : ord_idx, ord_state : ord_state},
			success	: function(data){
				alert("주문상태가 변경되었습니다.");
				location.href = "/admin/order/orderList${pageMaker.makeSearch(pageMaker.cri.page)}";
			}
		});
	});
	
	// 주문상태 변경 버튼(선택)
	$("#btnUpdateChk").click(function(){
		// 체크버튼 유효성 검사
		if($("input[name='check']:checked").length == 0){
			alert("변경할 상품을 선택해주세요");
			return;
		}
		
		if($("#updateChk").val() == 99){
			
			var chkArr =[];
			var stateArr = [];
			
			$("input[name='check']:checked").each(function(i){
				var ord_idx = $(this).val();
				var ord_state = $("select[name='ord_state_" + ord_idx + "']").val();
				
				chkArr.push(ord_idx);
				stateArr.push(ord_state);
			});
			
			$.ajax({
				type	: 'post',
				url		: '/admin/order/updateStateChk',
				dataType: 'text',
				data	: {chkArr:chkArr, stateArr:stateArr},
				success	: function(data){
					alert("선택 상품의 주문상태 정보가 변경되었습니다.");
					location.href = "/admin/order/orderList${pageMaker.makeSearch(pageMaker.cri.page)}";
				}
			});
			
		}else{
			
			var chkArr = [];
			var ord_state = $("#updateChk").val();

			$("input[name='check']:checked").each(function(i){
				var ord_idx = $(this).val();
				chkArr.push(ord_idx);
			});
			
			$.ajax({
				type	: 'post',
				url		: '/admin/order/chk_all',
				dataType: 'text',
				data	: {chkArr:chkArr, ord_state:ord_state},
				success	: function(data){
					alert("선택 상품의 주문상태 정보가 변경되었습니다.");
					location.href = "/admin/order/orderList${pageMaker.makeSearch(pageMaker.cri.page)}";
				}
			});
		}
	});
});
</script>
</head>
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
				<div class="col-md-12">
					<div style="display: inline-block; float: left; margin-left:15px;">
						<select name="searchType" id="search" style="width:150px; height:26px;">
							<option value="null" <c:out value="${cri.searchType == null?'selected':''}" />>
								[검색 구분]</option>
							<option value="orderNum" <c:out value="${cri.searchType eq 'orderNum'?'selected':''}" />>
								주문번호</option>
							<option value="memName" <c:out value="${cri.searchType eq 'memName'?'selected':''}" />>
								주문자명</option>
							<option value="memId" <c:out value="${cri.searchType eq 'memId'?'selected':''}" />>
								아이디</option>
							<option value="state" <c:out value="${cri.searchType eq 'state'?'selected':''}" />>
								주문처리상태</option>
							<option value="company" <c:out value="${cri.searchType eq 'company'?'selected':''}" />>
								출판사</option>
						</select>				
						<input type="text" name="keyword" id="keyword" value="${cri.keyword }" style="width:180px; padding-left:5px;"  />
						<button type="button" id="btnSearch" class="btn btn-default">검색</button>
					</div>				
					<div style="display: inline-block; float: right; margin-right:15px;">
						선택주문건 &nbsp;
						<select class="form-control" id="updateChk" name="edit_state" style="width: 200px; display: inline-block;">
							<option value="99" selected="selected" >[주문상태 변경]</option>
							<option value="1">주문접수</option>
							<option value="2">배송준비중</option>
							<option value="3">배송중</option>
							<option value="4">배송완료</option>
						</select>				
						<button type="button" id="btnUpdateChk" class="btn btn-primary">변경</button>
					</div>
				</div>
				<br><br><br>
				<div class="box" style="border: none;">
					<div class="box-body">
						<!-- 상품 리스트 테이블 -->
						<table class="table table-striped text-center">
							<tr>
								<th><input type="checkbox" id="chkAll" /></th>
								<th>번호</th>
								<th>주문날짜</th>
								<th>주문번호</th>
								<th>주문상품</th>
								<th>주문자아이디</th>
								<th>주문자명</th>
								<th>결제수단</th>
								<th>결제금액</th>
								<th>처리상태</th>
							</tr>
						  <c:if test="${empty orderList}">
							<tr>
								<td colspan="10">
									<p style="padding:50px 0px; text-align: center;">주문정보가 존재하지 않습니다.</p>
								</td>
							</tr>
						  </c:if>


						  <c:set var="count" value="1"></c:set>	  <!-- rowspan 적용 변수 -->

						  <c:forEach items="${orderList }" var="orderList" varStatus="i" >
						  
							<%--
							<c:if test="${i.index == 0 || orderList.ord_idx != idx}">
							 --%>
						  	  <tr>
								<td ><input type="checkbox" name="check" class="check" value="${orderList.ord_idx }" /></td>
								<td><c:out value="${count }"/></td>
								<td class="col-md-1"><fmt:formatDate value="${orderList.ord_date }" pattern="yyyy-MM-dd HH:mm"/></td>
								<td  class="col-md-1" style="font-weight:bold;">
									<input type="hidden" name="ord_idx" value="${orderList.ord_idx }">
									<a href="/admin/order/orderDetail${pageMaker.makeSearch(pageMaker.cri.page)}&ord_idx=${orderList.ord_idx}" style="color:black;">
									${orderList.ord_idx }</a></td>
								<td class="col-md-2">
									<a href="/admin/order/orderDetail${pageMaker.makeSearch(pageMaker.cri.page)}&ord_idx=${orderList.ord_idx}" style="color:black;">
									<c:if test="${productCount[i.index] > 1 }">
										${orderList.prd_title } 외 ${productCount[i.index] - 1}건
									</c:if>
									<c:if test="${productCount[i.index] <= 1 }">
										${orderList.prd_title }
									</c:if>
									</a>
								</td>
								<td class="col-md-1">${orderList.mem_id }</td>
								<td class="col-md-1">${orderList.mem_name }</td>
								<td class="col-md-1">결제수단</td>
								<td class="col-md-1" style="font-weight:bold;">
									<fmt:formatNumber value="${orderList.ord_tot_price }" pattern="###,###,###"/>원
								</td>
								<td class="col-md-3">
									<select class="form-control" name="ord_state_${orderList.ord_idx }" style="width: 130px; display: inline-block;">
										<option value="99" <c:out value="${orderList.ord_state == null ? 'selected':''}" />>[주문상태]</option>
										<option value="1" <c:out value="${orderList.ord_state == 1 ? 'selected':''}" />>주문접수</option>
										<option value="2" <c:out value="${orderList.ord_state == 2 ? 'selected':''}" />>배송준비중</option>
										<option value="3" <c:out value="${orderList.ord_state == 3 ? 'selected':''}" />>배송중</option>
										<option value="4" <c:out value="${orderList.ord_state == 4 ? 'selected':''}" />>배송완료</option>
									</select>				
									<button type="button" name="btnUpdate" value="${orderList.ord_idx }" class="btn btn-primary">변경</button>
								</td>
							</tr>
						  	<c:set var="count" value="${count+1 }"></c:set>
						  	<%--
						  </c:if>
							 --%>
						  <c:if test="${pageMaker.cri.page != 1}">
						  	<c:set	var="count" value="${count + (page -1) * cri.perPageNum }"	/>
						  </c:if>
							<%--
						  <c:set var="idx" value="${orderList.ord_idx}" />
							 --%>
						  </c:forEach>
						</table>
					</div>
					
					<!-- 페이징 기능 -->
					<div class="box-footer">

						<div class="text-center">
							<ul class="pagination">
								<!-- [이전] 표시 -->
								<c:if test="${pageMaker.prev }">
									<li>
										<a href="${pageMaker.makeSearch(pageMaker.cri.page - 1)}">[이전]</a>
									</li>
								</c:if>
								<!-- 페이지 번호 표시 -->
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
									<li <c:out value="${pageMaker.cri.page == idx	?'class=active':'' }" />>
										<a 
										 href="/admin/order/orderList${pageMaker.makeSearch(idx) }">${idx }</a>
									</li>
								</c:forEach>
							
								<!-- [다음] 표시 -->
								<c:if test="${pageMaker.next }">
									<li>
										<a href="${pageMaker.makeSearch(pageMaker.cri.page + 1 )}">[다음]</a>
									</li>
								</c:if>
							</ul>
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
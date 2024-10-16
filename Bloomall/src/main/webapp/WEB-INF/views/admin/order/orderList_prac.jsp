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
	stateToString();
	// 검색 버튼
	$("#btnSearch").click(function(){
		// 검색구분 주문처리상태 => 문자열 입력 숫자로 바꿔서 보내기
		if($("#search").val() == "state12"){
			if($("#keyword").val() == "주문접수"){
				$("#keyword").val("1");
			}else if($("#keyword").val() == "배송준비중"){
				$("#keyword").val("2");
			}else if($("#keyword").val() == "배송중"){
				$("#keyword").val("3");
			}else if($("#keyword").val() == "배송완료"){
				$("#keyword").val("4");
			}
			
		}
		
		
		
		self.location = "orderList_prac${pageMaker.makeQuery(1)}&searchType="
			+ $("#search").val() + "&keyword=" + $("#keyword").val();
		 
	});
	
});
function stateToString(){
	
	var keyword = $("#keyword");
	
	if($("#search").val() == "state12"){
		
		if(keyword.val() == 1){
			keyword.val("주문접수");
		}else if(keyword.val() == 2){
			keyword.val("배송준비중");
		}else if(keyword.val() == 3){
			keyword.val("배송중");
		}else if(keyword.val() == 4){
			keyword.val("배송완료");
		}
		/*	
		switch(keyword.val()){		// 왜 안되지?
		case 1:
			keyword.val("주문접수");
			break;
		case 2:
			keyword.val("배송준비중");
			break;
		case 3:
			keyword.val("배송중");
			break;
		case 4:
			keyword.val("배송완료");
			
		}*/
		alert(keyword.val());
	}
}

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
							<option value="recipient" <c:out value="${cri.searchType eq 'recipient'?'selected':''}" />>
								수령자</option>
							<option value="memId" <c:out value="${cri.searchType eq 'memId'?'selected':''}" />>
								아이디</option>
							<option value="state12" id="search_state" <c:out value="${cri.searchType eq 'state12'?'selected':''}" />>
								주문처리상태</option>
						</select>				
						<input type="text" name="keyword" id="keyword" value="${cri.keyword }" style="width:180px; padding-left:5px;"  />
						
						<button type="button" id="btnSearch" class="btn btn-warning">검색</button>
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
								<th>주문자</th>
								<th>수령자</th>
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

						  <c:set	var="count" value="${((cri.page -1) * cri.perPageNum) + 1 }"	/>	  <!-- rowspan 적용 변수 -->

						  <c:forEach items="${orderList }" var="orderList" varStatus="i" >
						  
							<%--
							<c:if test="${i.index == 0 || orderList.ord_idx != idx}">
							 --%>
						  	  <tr>
								<td ><input type="checkbox" name="check" class="check" value="${orderList.ord_idx }" /></td>
								<td><c:out value="${count }"/></td>
								<td class="col-md-1"><fmt:formatDate value="${orderList.ord_date }" pattern="yyyy-MM-dd"/></td>
								<td  class="col-md-1" style="font-weight:bold;">
									<input type="hidden" name="ord_idx" value="${orderList.ord_idx }">
									<a href="/admin/order/orderDetail${pageMaker.makeSearch(pageMaker.cri.page)}&ord_idx=${orderList.ord_idx}" style="color:black;">
									${orderList.ord_idx }</a></td>
								<td class="col-md-2">
									<a href="/admin/order/orderDetail${pageMaker.makeSearch(pageMaker.cri.page)}&ord_idx=${orderList.ord_idx}" style="color:black;">
									<c:if test="${orderList.ord_count > 1 }">
										${orderList.prd_title } 외 ${orderList.ord_count - 1}건
									</c:if>
									<c:if test="${orderList.ord_count == 1 }">
										${orderList.prd_title }
									</c:if>
									</a>
								</td>
								<td class="col-md-1">${orderList.mem_id }</td>
								<td class="col-md-1">${orderList.mem_name }</td>
								<td class="col-md-1">${orderList.ord_recp_name }</td>
								<td class="col-md-1">결제수단</td>
								<td class="col-md-1" style="font-weight:bold;">
									<fmt:formatNumber value="${orderList.ord_tot_price }" pattern="###,###,###"/>원
								</td>
								<td class="col-md-2">
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
										 href="/admin/order/orderList_prac${pageMaker.makeSearch(idx) }">${idx }</a>
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
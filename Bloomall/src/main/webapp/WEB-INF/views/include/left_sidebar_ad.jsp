<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">

		<!-- Sidebar user panel (optional) -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="/dist/img/anonymous_user.png" class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info" style="padding:8%;">
				<p>관리자</p>
			</div>
		</div>

		<!-- search form (Optional) -->
		<form action="#" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="form-control" placeholder="Search...">
				<span class="input-group-btn">
					<button type="submit" name="search" id="search-btn" class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button>
				</span>
			</div>
		</form>
		<!-- /.search form -->

		<!-- Sidebar Menu -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">Admin Menu</li>
			<!-- Optionally, you can add icons to the links -->
			<!-- 
			<li class="active">
				<a href="#"><i class="fa fa-link"></i> <span>Link</span></a>
			</li>
			<li>
				<a href="#"><i class="fa fa-link"></i> <span>Another Link</span></a>
			</li>
			 -->
			 <%-- 관리자 로그인 전 --%>
			 <c:if test="${empty sessionScope.admin }">
				 <li style="color:whitesmoke; padding: 9%; font-size:16px;">
						로그인 후 이용 가능합니다.				 
				 </li>
			 </c:if>
			 
			 <%-- 관리자 로그인 후 --%>
			 <c:if test="${!empty sessionScope.admin }">
			 <li class="treeview">
				<a href="#"><i class="fa fa-book"></i> <span>상품관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="/admin/product/register"><i class="fa fa-bookmark"></i>상품등록</a>
					</li>
					<li>
						<a href="/admin/product/list"><i class="fa fa-bookmark"></i>상품리스트</a>
					</li>
				</ul>
			</li>
			<li class="treeview">
				<a href="#"><i class="fa fa-book"></i> <span>주문관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="/admin/order/orderList"><i class="fa fa-bookmark"></i>주문목록</a>
					</li>
					<li>
						<a href="#"><i class="fa fa-bookmark"></i>주문통계</a>
					</li>
				</ul>
			</li>
			<li class="treeview">
				<a href="#"><i class="fa fa-book"></i> <span>회원관리</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="#"><i class="fa fa-bookmark"></i>회원관리</a>
					</li>
					<li>
						<a href="#"><i class="fa fa-bookmark"></i>회원통계</a>
					</li>
				</ul>
			</li>
			<li class="treeview">
				<a href="#"><i class="fa fa-book"></i> <span>커뮤니티</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
					</span> </a>
				<ul class="treeview-menu">
					<li>
						<a href="#"><i class="fa fa-bookmark"></i>공지사항</a>
					</li>
					<li>
						<a href="#"><i class="fa fa-bookmark"></i>게시판</a>
					</li>
					<li>
						<a href="#"><i class="fa fa-bookmark"></i>QnA</a>
					</li>
				</ul>
			</li>
			</c:if>
			
		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>
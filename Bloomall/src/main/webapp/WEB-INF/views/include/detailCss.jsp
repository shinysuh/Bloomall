<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.prd_title{
	color:black;
	font-weight:bold;
	font-size: 24px;
}
.rvwCount, .noStarRvw{
	color: grey;
	font-size: 12px;
}
.prd_info, .org_price, .point_benefit, .basic_notice{
	color: grey;
	font-size: 14px;
}
.basic_notice{
	line-height: 220%;
}
.stars{
	font-size: 28px;
}
hr{
	border-top: 1px solid rgb(167, 167, 167);
}
#recent_r{
	font-weight:bold;
	font-size:14px;
}
#on_sale{
	font-weight:bold;
	font-size:16px;
}
#btn_addCart, #btn_purchaseNow {
	width:40%;
	height:40px;
	font-weight:bold;
	font-size:16px;
	margin-right:5px;
}
#star_score a{
 	font-size:22px;
    text-decoration: none;
    color: lightgray;
}
#star_score a.on{
    color:#4e789c;
}

.popup {
	position: absolute;
}
.back { 
	background-color: gray; 
	opacity:0.5; 
	width: 100%; 
	height: 300%; 
	overflow:hidden;  
	z-index:1101;
}
.front { 
	z-index:1110; 
	opacity:1; 
	border:1px; 
	margin: auto; 
}
.star_title{
	font-size:10px;
	color:grey;
}
.stars_right{
	color:#4e789c;
	line-height:80%;
}
.starUl{
	list-style-type: none;
	margin: 0;
	padding: 0;
}
#star_score_modal a.on{
	color:black;
}
</style>
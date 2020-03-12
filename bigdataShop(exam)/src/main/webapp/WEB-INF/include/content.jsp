<%@page import="kr.multi.bigdataShop.product.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.carousel-inner>.item>img, .carousel-inner>.item>a>img {
	width: 70%;
	margin: auto;
}
</style>
</head>
<body>
	<% ArrayList<ProductDTO> hitList = (ArrayList<ProductDTO>)request.getAttribute("hitList");
		ArrayList<ProductDTO> newList = (ArrayList<ProductDTO>)request.getAttribute("newList");%>

	<br>
	<div class="row">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
			</ol>
	
			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<% for(int i=0;i<4;i++) { 
					ProductDTO product = hitList.get(i);
					if(i == 0) {%>
					<div class="item active" style="height: 250px">
					<% } else {%>
					<div class="item" style="height: 250px">
					<% } %>
					
						<img src="/bigdataShop/images/product/<%= product.getImg_org_file_nm() %>" alt="Chania" width="460" height="345">
					</div>
				<% } %>
			</div>
	
			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
				aria-hidden="true"></span> <span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>
	<br />
	<br />
	<div class="row">
		<% for(int i=0;i<3;i++) { 
			ProductDTO product = newList.get(i);%>
			<div class="col-sm-4">
				<div class="panel panel-primary">
					<div class="panel-heading"><%= product.getPrd_nm() %></div>
					<div class="panel-body">
						<a href="#"><img
							src="/bigdataShop/images/product/<%= product.getImg_org_file_nm() %>"
							class="img-responsive" style="width: 70%; height: 70%" alt="Image"></a>
					</div>
					<div class="panel-footer">판매금액:<%= product.getSell_prc_unit() %></div>
				</div>
			</div>
		<% } %>
	</div>
</body>
</html>
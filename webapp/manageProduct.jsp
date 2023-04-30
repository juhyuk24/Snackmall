<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		Cookie ck[] =request.getCookies();
		String id = null;
		String type = "";
		if(ck.length>=2){
			if(ck[1].getName().equals("ID")){
				id = (String) ck[1].getValue();
				type = (String) ck[2].getValue();
			}
		}
		String zero = "0";
        if(id == null || !type.equals(zero)) {
        	%>
        	<script>
	        	alert("어드민외 접속금지");
				location.href="index.jsp";
        	</script>
        	<%
%>
	<%@include file="top.jsp" %>
<% 
        } else if(type.equals(zero)) {
%>
	<%@include file="adminLoggedinTop.jsp" %>
<%
        } else {
%>    	
 	<%@include file="userLoggedinTop.jsp" %>
<%
        }
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	
	
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>상품관리</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        
        <script>
        	function checkValue(){
        		inputForm = eval("document.addProductInfo");
            	if(!inputForm.productName.value) {
                	alert("상품명을 입력하세요");    
                	inputForm.productName.focus();
                	return false;
            	}
            	if(!inputForm.productPrice.value) {
                	alert("단가를 입력하세요");    
                	inputForm.productPrice.focus();
                	return false;
            	}
            	if(!inputForm.productCount.value) {
                	alert("재고량을 입력하세요");    
                	inputForm.productCount.focus();
                	return false;
            	}
        	}
        	
        	function submit2(frm){
        		frm.action="itmeListPro.jsp";
        		frm.submit();
        		return true;
        	}
        	
        	
        </script>
</head>
<body>
	<!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">상품관리</h1>
                </div>
            </div>
        </header>
        <!-- Section-->
        <form name="addProductInfo" method="post" action="addProductPro.jsp" onsubmit="return checkValue()" enctype="multipart/form-data">
        <section class="py-5">
            <article class="container">
            	
            	<div class="col-md-6 col-md-offset-3" style="width:70%; margin-left:15%; margin-right:15%;">
           			<div class="form-group" style="margin:10px; text-align: center;" >
           				<h3>상품 추가</h3><br>
              			상품명 : <input type="text"  name ="productName" placeholder="상품명"><br><br>
              			단가 : <input type="text"  name ="productPrice" placeholder="단가"><br><br>
              			재고량 : <input type="text"  name ="productCount" placeholder="재고량"><br><br>
              			사진 첨부 : <input type="file" name = "productFile"><br><br>
           			</div>
           			<div class="form-group text-center">
              			<button type="submit" onsubmit="return submit2(this.form)" class="btn btn-info" style="margin:10px;">상품 추가<i class="fa fa-check spaceLeft"></i></button>
					</div>
           		</div>
           		<br>
           		<hr>	
            	<br>
            	<div class="col-md-6 col-md-offset-3" style="width:70%; margin-left:15%; margin-right:15%;">
           			<div class="form-group" style="margin:10px; text-align: center;" >
            			<div class="form-group text-center"><h3>상품 목록</h3></div>
            			<br>
            			<input type="button" onClick="window.location.reload()" value="목록 새로고침">
            			<br>
            			<br>
            			<div class="form-group text-center"><%@include file="itemListPro2.jsp" %></div>
        					
        			</div>
        		</div>
      		</article>
        </section>
        </form>
        
        
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
</body>
</html>
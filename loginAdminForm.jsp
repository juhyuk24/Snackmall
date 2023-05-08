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
        if(id == null) {       	
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
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>판매자 로그인</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <script>
        	function checkValue() {
            	inputForm = eval("document.loginInfo");
            	if(!inputForm.ID.value) {
                	alert("아이디를 입력하세요");    
                	inputForm.ID.focus();
                	return false;
            	}
            	if(!inputForm.PWD.value) {
                	alert("비밀번호를 입력하세요");    
                	inputForm.PWD.focus();
                	return false;
            	}
        	} 
        </script>
    </head>
    <body>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">판매자 로그인</h1>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <article class="container">
        			<div class="col-md-6 col-md-offset-3" style="position:relative; left:25%;">
        			<form name="loginInfo" method="post" onsubmit="return checkValue()" action="loginAdminPro.jsp">
            			<div class="form-group" style="margin:10px;">
              				<label for="InputId">아이디</label>
              				<input type="text" name="ID" class="form-control" id="Id" placeholder="아이디"> 
            			</div>
            			<div class="form-group" style="margin:10px;">
              				<label for="InputPassword1">비밀번호</label>
              				<input type="password" name="PWD" class="form-control" id="Password" placeholder="비밀번호">
            			</div>
            			<div class="form-group text-center" style="margin:10px;">
              				<button type="submit" class="btn btn-outline-dark">확인<i class="fa fa-check spaceLeft"></i></button>
           				</div>
           				<input type="hidden" name="TYPE" value="0">
           			</form>
        			</div>
        		</article>
        	</div>
		</section>
    
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

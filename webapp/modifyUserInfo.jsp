<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		Cookie ck[] =request.getCookies();
		String id = null;
		String type = "";
		if(ck !=null){
			if(ck.length>=2){
				if(ck[1].getName().equals("ID")){
					id = (String) ck[1].getValue();
					type = (String) ck[2].getValue();
				}
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

<%

	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
		
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		String type1 = "0";
		conn = DriverManager.getConnection(url, userName, password);
		
		String sql = "select * from 고객 where 고객아이디=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		
		rs = pstmt.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>회원가입</title>
	
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Shop Homepage - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        
        <script>
        	var reg = /\s/g;
        	function checkValue() {
            	inputForm = eval("document.modifyInfo");
            	
            	if(!inputForm.PWD.value) {
                	alert("비밀번호를 입력하세요");    
                	inputForm.PWD.focus();
                	return false;
            	}
            	if(!inputForm.NAME.value) {
                	alert("이름을 입력하세요");    
                	inputForm.NAME.focus();
                	return false;
            	}
            	if(!inputForm.ADDR.value) {
                	alert("주소를 입력하세요");    
                	inputForm.ADDR.focus();
                	return false;
            	}
            	if(!inputForm.PHONE.value) {
                	alert("전화번호를 입력하세요");    
                	inputForm.PHONE.focus();
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
                    <h1 class="display-4 fw-bolder">회원 정보 수정</h1>
                </div>
            </div>
        </header>
        <!-- Section-->
        <%while(rs.next()) {%>
        <form name="modifyInfo" method="post" action="modifyUserInfoPro.jsp" onsubmit="return checkValue()">
        <section class="py-5">
            <article class="container">
        		<div class="col-md-6 col-md-offset-3" style="position:relative; left: 25%;">
					<div>* 표시 필수 입력</div>
            		<div class="form-group" style="margin:10px;">
              			<label for="InputPassword1">비밀번호 *</label>
              			<input type="password" class="form-control" name="cusPw" id="passwd" placeholder="<%=rs.getString(2)%>">
            		</div>
            		<div class="form-group" style="margin:10px;">
              			<label for="username">이름 *</label>
              			<input type="text" class="form-control" name="cusName" id="name" placeholder="<%=rs.getString(3)%>">
            		</div>

            		<div class="form-group" style="margin:10px;">
              			<label for="InputEmail">주소 *</label>
              			<input type="text" class="form-control" name="cusAddr" id="addr" placeholder="<%=rs.getString(4)%>">
            		</div>
            		<div class="form-group" style="margin:10px;">
              			<label for="InputEmail">전화번호 *</label>
              			<input type="text" class="form-control" name="cusPhone" id="phone" placeholder="<%=rs.getString(5)%>">
            		</div>
            		<div class="form-group text-center">
              			<button type="submit" class="btn btn-info" style="margin:10px;">수정<i class="fa fa-check spaceLeft"></i></button>
              			<button type="button" class="btn btn-warning" style="margin:10px;" onClick="history.go(-1);">취소<i class="fa fa-times spaceLeft"></i></button>
            		</div>
        		</div>
      		</article>
        </section>
        </form>
        <%} %>
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

<%		
	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	}
%>
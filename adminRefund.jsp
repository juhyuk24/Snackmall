<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8"); 
%>	
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

<%
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		
		String sql = "SELECT LPAD(주문.주문번호,8,0), 고객.고객아이디, 주문.주문수량, 주문.상품명, DATE_FORMAT(주문.주문일자,'%Y-%m-%d'),주문.가격 * 주문.주문수량 합계, 주문.환불사유 FROM 주문, 고객 WHERE 고객.고객아이디=주문.고객아이디 AND 주문.환불상태 = 1";
		String sql2 ="SELECT LPAD(주문.주문번호,8,0), 고객.고객아이디, 주문.주문수량, 주문.상품명, DATE_FORMAT(주문.주문일자,'%Y-%m-%d'),주문.가격 * 주문.주문수량 합계, 주문.주문확인, 주문.환불상태  FROM 주문, 고객 WHERE 주문.상품번호 = 주문.상품번호 AND 고객.고객아이디=주문.고객아이디";

		
		pstmt1 = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		pstmt1.executeQuery();
		
		pstmt2 = conn.prepareStatement(sql2,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		pstmt2.executeQuery();
		
		rs = pstmt1.executeQuery();
		rs2 = pstmt2.executeQuery();
		
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>주문</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/track.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
      	
    </head>
    <body>
        
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">주문/환불관리</h1>
                </div>
            </div>
        </header>
        <div class="container px-4 px-lg-5">
            <div class="common-data-box p-5">
            	<h5 class="title-sub5depth">환불 관리</h5>
                <div class="common-hrTable-1">
                    <table>
                      <colgroup>
                            <col style="width:15%;">
                            <col style="width:10%;">
                            <col style="width:15%;">
                            <col style="width:8%;">
                            <col style="width:15%;">
                            <col style="width:10%;">
                            <col style="width:17%;">
                            <col style="width:10%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" class="number">주문일자<br />[주문번호]</th>
                                <th scope="col" class="thumb">이미지</th>
                                <th scope="col" class="product">상품정보</th>
                                <th scope="col" class="quantity">수량</th>
                                <th scope="col" class="price">상품구매금액</th>
                                <th scope="col" class="state">고객아이디</th>
                                <th scope="col" class="state">환불사유</th>
                                <th scope="col" class="service">환불확인</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        if(rs.next()){
                        rs.last();
                        do{ %>
                            <tr>
                                <td class="text-alignCenter">
                                    <%=rs.getString(5) %>
                                    <p>[<%=rs.getString(1) %>]</p>
                                </td>
                                <td class="text-alignCenter"><img src="snackImgs/<%=rs.getString(4) %>.PNG" onerror="this.src='http://img.echosting.cafe24.com/thumb/img_product_small.gif';" alt="" width=120px /></td>
                                <td class="text-alignCenter"><strong><%=rs.getString(4) %></strong>
                                </td>
                                <td class="text-alignCenter"><%=rs.getString(3) %>개</td>
                                <td class="text-alignCenter"><strong><script>document.writeln((<%=rs.getInt(6)%>).toLocaleString()+"원"); </script></strong>
                                <td class="text-alignCenter"><%=rs.getString(2) %></td>
                                <%if(rs.getString(7)==null){ %>
                                <td class="text-alignCenter">-</td>
                                <%} else{ %>
                                <td class="text-alignCenter"><%=rs.getString(7)%></td>
                                <%} %>
                                <td class="text-alignCenter">
                                <a href="adminRefundPro.jsp?주문번호=<%=rs.getString(1)%>" class="button"><img src="image/cancel2.gif" alt="환불요청"/></a>
                                </td>
                            </tr>
                            <%}while(rs.previous());} %>
                        </tbody>         
                    </table>
                </div>
            </div>
        </div>
        
        <div class="container px-4 px-lg-5">
            <div class="common-data-box p-5">
            	<h5 class="title-sub5depth">주문 관리</h5>
                <div class="common-hrTable-1">
                    <table>
                      <colgroup>
                            <col style="width:15%;">
                            <col style="width:10%;">
                            <col style="width:15%;">
                            <col style="width:10%;">
                            <col style="width:15%;">
                            <col style="width:15%;">
                            <col style="width:10%;">
                            <col style="width:10%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" class="number">주문일자<br />[주문번호]</th>
                                <th scope="col" class="thumb">이미지</th>
                                <th scope="col" class="product">상품정보</th>
                                <th scope="col" class="quantity">수량</th>
                                <th scope="col" class="price">상품구매금액</th>
                                <th scope="col" class="state">고객아이디</th>
                                <th scope="col" class="service">환불 확인</th>
                                <th scope="col" class="service">주문 확인</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        if(rs2.next()){
                        rs2.last();
                        do{ %>
                            <tr>
                                <td class="text-alignCenter">
                                    <%=rs2.getString(5) %>
                                    <p>[<%=rs2.getString(1) %>]</p>
                                </td>
                                <td class="text-alignCenter"><img src="snackImgs/<%=rs2.getString(4) %>.PNG" onerror="this.src='http://img.echosting.cafe24.com/thumb/img_product_small.gif';" alt="" width=120px /></td>
                                <td class="text-alignCenter"><strong><%=rs2.getString(4) %></strong>
                                </td>
                                <td class="text-alignCenter"><%=rs2.getString(3) %>개</td>
                                <td class="text-alignCenter"><strong><script>document.writeln((<%=rs2.getInt(6)%>).toLocaleString()+"원"); </script></strong>
                                <td class="text-alignCenter"><%=rs2.getString(2) %></td>
                                <%if(rs2.getInt(7) == 0 ){    // 주문 확인전 %>
                                <td class="text-alignCenter">-</td>
                            	<td class="text-alignCenter">
                            	<a href="orderOk.jsp?주문번호=<%=rs2.getString(1)%>" class="button"><img src="image/orderok.gif" alt="주문확인"/></a>
                            	</td>
                                <%} else{ %>
                                <%if(rs2.getInt(8) == 0){ %>
                                <td class="text-alignCenter">-</td>
                            	<td class="text-alignCenter">확인완료</td>
                            	<%}else if(rs2.getInt(8) == 1){ %>
                            	<td class="text-alignCenter">환불요청대기중</td>
                            	<td class="text-alignCenter">확인완료</td>
                            	<%}else {%>
                            	<td class="text-alignCenter">환불완료</td>
                            	<td class="text-alignCenter">확인완료</td>
                            	<%} %>
                            	<%} %>
                            </tr>
                            <%}while(rs2.previous());} %>
                        </tbody>         
                    </table>
                </div>
            </div>
        </div>
        
        <div style="margin-bottom: 246px !important;"></div>
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
    </body>
</html>

<%		
	rs.close();
	rs2.close();
	pstmt2.close();
	pstmt1.close();     // Statement 종료
	conn.close();

	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} finally {
		
		 	// Connection 종료
	}
	
%>
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
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		
		String sql = "SELECT LPAD(주문.주문번호,8,0),주문.고객아이디, 주문.주문수량, DATE_FORMAT(주문.주문일자,'%Y-%m-%d'), 주문.상품번호,주문.환불상태, 주문.상품명, 주문.가격, 주문.주문수량 * 주문.가격 합계, TIMESTAMPDIFF(SECOND,주문.주문일자,주문.주문확인일자) 주문확인시간,TIMESTAMPDIFF(SECOND,주문.주문일자,current_timestamp) 현재까지흐른시간 , 주문.주문확인 FROM 주문 WHERE 주문.고객아이디 = ?";
				
		
		
		pstmt1 = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		pstmt1.setString(1,id);
		
		pstmt1.executeQuery();
		
		rs = pstmt1.executeQuery();

		
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
                    <h1 class="display-4 fw-bolder">주문목록</h1>
                </div>
            </div>
        </header>
        <div class="container px-4 px-lg-5">
            <div class="common-data-box p-5">
            	<h5 class="title-sub5depth">주문 목록</h5>
                <div class="common-hrTable-1">
                    <table>
                      <colgroup>
                            <col style="width:15%;">
                            <col style="width:10%;">
                            <col style="width:20%;">
                            <col style="width:10%;">
                            <col style="width:15%;">
                            <col style="width:15%;">
                            <col style="width:15%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" class="number">주문일자<br />[주문번호]</th>
                                <th scope="col" class="thumb">이미지</th>
                                <th scope="col" class="product">상품정보</th>
                                <th scope="col" class="quantity">수량</th>
                                <th scope="col" class="price">상품구매금액</th>
                                <th scope="col" class="state">주문처리상태</th>
                                <th scope="col" class="service">환불신청상태</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        if(rs.next()){
                        rs.last();
                        do{ %>
                            <tr>
                                <td class="text-alignCenter">
                                    <%=rs.getString(4) %>
                                    <p>[<%=rs.getString(1) %>]</p>
                                    <%if(rs.getInt(12)==0){%>
                                		<a href="orderCancel.jsp?주문번호=<%=rs.getString(1)%>" class="button"><img src="image/cancel3.gif" alt="주문취소" /></a>
                                	<%}else if(rs.getInt(6) == 1 ||rs.getInt(6) == 2) { %>
                                	<%}else { %>
                                	<a href="#j" onClick="window.open('refundRequest.jsp?주문번호=<%=rs.getString(1)%>', '환불요청', 'width=400, height=300, top=350, left=800 ')" class="button"><img src="image/cancel.gif" alt="환불요청"/></a>
                                	<a href="track.jsp?주문번호=<%=rs.getString(1)%>" class="button"><img src="image/tracking.gif" alt="배송조회" /></a>	
                                	<%}%>
                                </td>
                                <td class="text-alignCenter"><img src="snackImgs/<%=rs.getString(7) %>.PNG" onerror="this.src='http://img.echosting.cafe24.com/thumb/img_product_small.gif';" alt="" width=120px /></td>
                                <td class="text-alignCenter"><strong><%=rs.getString(7) %></strong>
                                </td>
                                <td class="text-alignCenter"><%=rs.getString(3) %>개</td>
                                <td class="text-alignCenter"><strong><script>document.writeln((<%=rs.getInt(9)%>).toLocaleString()+"원"); </script></strong>
                                <% if(rs.getString(6).equals("0")) {
                                	if(rs.getInt(11)<rs.getInt(10)+60 || rs.getInt(12)==0){
                                	if(rs.getInt(12)==0){%>
                                <td class="text-alignCenter">-</td>
                                <td class="text-alignCenter">-</td>
                                <%}else{%>
                                <td class="text-alignCenter">주문확인</td>
                                <td class="text-alignCenter">-</td>
                                <%}%>
                                <%} else if(rs.getInt(11)>=rs.getInt(10)+60 && rs.getInt(11)<rs.getInt(10)+120){ %>
                                <td class="text-alignCenter">상품인수</td>
                                <td class="text-alignCenter">-</td>
                                <%} else if(rs.getInt(11)>=rs.getInt(10)+120 && rs.getInt(11)<rs.getInt(10)+180){ %>
                                <td class="text-alignCenter">배송출발</td>
                                <td class="text-alignCenter">-</td>
                                <%} else if(rs.getInt(11)>=rs.getInt(10)+180){ %>
                                <td class="text-alignCenter">배달완료</td>
                                <td class="text-alignCenter">-</td>
                                <% }
                                }
                                else if (rs.getString(6).equals("1")) {%>
                                <td class="text-alignCenter">-</td>
                                <td class="text-alignCenter">환불대기중</td>
                                <% } else {%>
                                <td class="text-alignCenter">-</td>
                                <td class="text-alignCenter">환불완료</td>
                                <% }%>
                            </tr>
                            <%}while(rs.previous());
                        } %>
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
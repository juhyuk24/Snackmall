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
<%
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	String number = request.getParameter("주문번호"); 
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		
		String sql = "SELECT LPAD(주문.주문번호,8,0), LEFT(고객.이름,1), 주문.주문수량, 주문.환불상태, 주문.상품명, TIMESTAMPDIFF(SECOND,주문.주문일자,주문.주문확인일자) 주문확인시간,TIMESTAMPDIFF(SECOND,주문.주문일자,current_timestamp) 현재까지흐른시간, DATE_ADD(주문.주문일자, INTERVAL TIMESTAMPDIFF(SECOND,주문.주문일자,주문.주문확인일자)+54 SECOND), DATE_ADD(주문.주문일자, INTERVAL TIMESTAMPDIFF(SECOND,주문.주문일자,주문.주문확인일자)+118 SECOND), DATE_ADD(주문.주문일자, INTERVAL TIMESTAMPDIFF(SECOND,주문.주문일자,주문.주문확인일자)+175 SECOND) FROM 주문, 고객 WHERE 고객.고객아이디=주문.고객아이디 AND 주문.고객아이디 = ? AND LPAD(주문.주문번호,8,0) = ?";
				
		
		
		pstmt1 = conn.prepareStatement(sql);
		pstmt1.setString(1,id);
		pstmt1.setString(2, number);
		
		pstmt1.executeQuery();
		
		rs = pstmt1.executeQuery();

		rs.next();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
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
        <link href="css/track.css" rel="stylesheet"/>

    </head>
    <body>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">배송조회</h1>
                </div>
            </div>
        </header>
        <section>

        </section>
        <div class="container px-4 px-lg-5">
            <div class="common-data-box p-5">
                <h5 class="title-sub5depth">조회 결과</h5>
                <div class="common-hrTable-1">
                    <table>
                        <caption>조회 결과 테이블이며 운송장 번호, 보내는 분, 받는 분, 상품 정보, 수량 등의 정보로 구성되어 있음.</caption>
                        <colgroup>
                            <col style="width:20%;">
                            <col style="width:20%;">
                            <col style="width:20%;">
                            <col style="width:20%;">
                            <col style="width:20%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">주문 번호</th>
                                <th scope="col">보내는 분</th>
                                <th scope="col">받는 분</th>
                                <th scope="col">상품 정보</th>
                                <th scope="col">수량</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="text-alignCenter" ><%=rs.getString(1) %></td>
                                <td class="text-alignCenter" >스낵몰</td>
                                <td class="text-alignCenter" ><%=rs.getString(2) %>*</td>
                                <td class="text-alignCenter" ><%=rs.getString(5) %></td>
                                <td class="text-alignCenter" ><%=rs.getString(3) %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <h5 class="title-sub5depth" style="padding:52px 0 23px 0;">상품 상태 확인</h5>
                <div class="common-hrTable-1">
                    <table>
                    	<%if(rs.getInt(4)==0) {%> 
                        <caption>상품 상태 확인 테이블이며 단계, 처리, 상품상태, 담당 점소 등의 정보로 구성되어 있음.</caption>
                        <colgroup>
                            <col style="width: 14%;">
                            <col style="width: 21%;">
                            <col style="width:*;"> <!-- 44%-->
                            <!-- <col style="width:*;"> -->
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">단계</th>
                                <th scope="col">처리</th>
                                <th scope="col">상품상태</th>
                                <!-- <th scope="col">담당 점소</th> -->
                            </tr>
                        </thead>
                        <%if(rs.getInt(7) >=rs.getInt(6)+54) {%>
                        <tbody id="statusDetail">
                            <td class="text-alignCenter" >상품인수</td>
                            <td class="text-alignCenter" ><%=rs.getString(8)%></td>
                            <td class="text-alignCenter" >보내시는 고객님으로부터 상품을 인수받았습니다</td>
                        </tbody>
                        <%}if(rs.getInt(7) >=rs.getInt(6)+118) {%>
                        <tbody id="statusDetail">
                            <td class="text-alignCenter" >배송출발</td>
                            <td class="text-alignCenter" ><%=rs.getString(9)%></td>
                            <td class="text-alignCenter" >고객님의 상품을 배송할 예정입니다.</td>
                        </tbody>
                        <%}if(rs.getInt(7) >=rs.getInt(6)+175) {%>
                        <tbody id="statusDetail">
                            <td class="text-alignCenter" >배달완료</td>
                            <td class="text-alignCenter" ><%=rs.getString(10)%></td>
                            <td class="text-alignCenter" >고객님의 상품이 배송완료 되었습니다.</td>
                        </tbody>
                        <%}%>
                        <%} else if(rs.getInt(4)==1){ %>
                        <colgroup>
                            <col style="width: 100%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">ㅤ</th>
                        </thead>
                        <tbody id="statusDetail">
                            <td class="text-alignCenter" >환불 대기중입니다.</td>
                        </tbody>
                        <%} else if(rs.getInt(4)==2) {%>
                        <colgroup>
                            <col style="width: 100%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">ㅤ</th>
                        </thead>
                        <tbody id="statusDetail">
                            <td class="text-alignCenter" >환불 되었습니다.</td>
                        </tbody>
                        <%}%>
                    </table>
                </div>
            </div>
        </div>
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
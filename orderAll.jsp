<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import="java.time.LocalDateTime" import="java.time.format.DateTimeFormatter"%>
<%
	request.setCharacterEncoding("UTF-8"); 
%>

<%

	Cookie ck[] =request.getCookies();
	String cId = null;
	if(ck.length>=2 && ck[1].getName().equals("ID")){
		cId = (String) ck[1].getValue();
	}

	
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;
	PreparedStatement pstmt4 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		
		String sql1 = "select 상품번호, 수량 from 장바구니 where 고객아이디=?";
		int result = 0;
		pstmt1 = conn.prepareStatement(sql1, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		pstmt1.setString(1,cId);
		
		rs = pstmt1.executeQuery();
		String sql2 = "insert into 주문(주문수량,고객아이디,상품번호,상품명,가격) values(?,?,?,?,?)";
		pstmt2 = conn.prepareStatement(sql2);
		
		String sql3 = "select 재고량, 상품명, 가격 from 상품 where 상품.상품번호 = ?";
		pstmt3 = conn.prepareStatement(sql3);
		
		String sql4 = "UPDATE 상품 SET 재고량=재고량-? where 상품.상품번호 = ?";
		pstmt4 = conn.prepareStatement(sql4);
		
		boolean cheak = true;
		
		while(rs.next()){
			pstmt3.setInt(1,rs.getInt(1));
			rs2 = pstmt3.executeQuery();
			rs2.next();
			if(rs.getInt(2)>rs2.getInt(1)){
					%>
					<script>
						alert("주문 하려는 상품 <%=rs2.getString(2)%>의 재고량이 <%=rs2.getString(1)%>개 입니다.\n더 적게 구매해 주세요.");
						location.href="basket.jsp";
					</script>
				 <%
				 cheak = false;
				 
			}
		}
		rs.beforeFirst();
		if(cheak){
			while(rs.next()){
				pstmt3.setInt(1,rs.getInt(1));
				rs2 = pstmt3.executeQuery();
				rs2.next();
				
				pstmt2.setInt(1, rs.getInt(2));
				pstmt2.setString(2, cId);
				pstmt2.setInt(3, rs.getInt(1));
				pstmt2.setString(4,rs2.getString(2));
				pstmt2.setInt(5,rs2.getInt(3));
				
				
				pstmt4.setInt(2, rs.getInt(1));
				pstmt4.setInt(1, rs.getInt(2));
				pstmt4.executeUpdate();
				
				result =pstmt2.executeUpdate();
			}
			
			if(result == 1){
				%>
				<script>
					alert("주문을 완료했습니다.");
					location.href="deleteBasketAll.jsp";
				</script>
				<%
			}else {
				%>
					<script>
						alert("주문 실패");
					</script>
				<%
			}
		}
		pstmt1.close();
		pstmt2.close();
		pstmt3.close();
		pstmt4.close();
		conn.close();
		rs.close();
		rs2.close();
	} catch (ClassNotFoundException e){
		out.print(e);
	} catch (SQLException e){
		out.print(e);
	}
		
%>
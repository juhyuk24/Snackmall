<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import="java.io.File"%>
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>

<html>
<head>
<link href="css/styles.css" rel="stylesheet" />
<style>
  table {
    width: 70%;
    margin-left:15%;
    margin-right:15%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
</style>
</head>

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
		
		String sql = "select 상품번호, 상품명, 가격, 재고량 from 상품";
		
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		ResultSetMetaData rsmd = rs.getMetaData();
		int count = rsmd.getColumnCount();
		
%>
		
<body>
	<table>

<tr>

<td>상품번호</td>

<td>상품명</td>

<td>가격</td>

<td>재고량</td>



<TD>비고 </TD>



</tr>

<%

    while(rs.next()) {

%><tr>

<td><%= rs.getString(1) %></td>

<td><%=rs.getString(2)%></td>

<td><script>document.writeln((<%=rs.getInt(3)%>).toLocaleString()); </script></td>

<td><%=rs.getString(4)%></td>



<TD>

<INPUT type="button" value="삭제"
	onClick="location.href='deleteItemOnList.jsp?상품번호=<%=rs.getString(1)%>'"> <!-- delete-do.jsp링크를 이용하여 해당 테이블의 데이터들을 삭제합니다. -->
	
<INPUT type="button" value="수정"
	onClick="window.open('modify.jsp?상품번호=<%=rs.getString(1)%>', '상품 수정', 'width=500, height=300')"> <!-- modify.jsp로 이동하여 해당 테이블의 데이터값들을 수정하도록 합니다. -->

</TD>



</tr>

<%

    } // end while

%></table>
</body>
		
<%

	
	
	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} finally {
		rs.close();     // ResultSet 종료
		pstmt.close();     // Statement 종료
		conn.close(); 	// Connection 종료
	}
%>
</html>
	

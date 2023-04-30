<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%	

	String filePath = "C:/Users/KIM/eclipse-workspace/SnackMallProject/src/main/webapp/snackImgs/";
	MultipartRequest multi = new MultipartRequest(request,filePath, 1024*1024*10, "utf-8");
	
	
	String productName = multi.getParameter("productName");
	String productPrice = multi.getParameter("productPrice");
	String productCount = multi.getParameter("productCount");
	
	String fileName =  multi.getFilesystemName("productFile");
    String realFileName = productName + ".PNG";
    File oldFile = new File(filePath + fileName);
    File newFile = new File(filePath + realFileName);
    oldFile.renameTo(newFile);
    
	ResultSet rs = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String url = "jdbc:mysql://localhost:3306/newdb";
		String user = "root";
		String password = "pjypjypjy";
	
		Connection conn = DriverManager.getConnection(url,user,password);
		
		
		String sql = "insert into 상품 values(?,?,?,?,?)";
		
		String id = null;
		Cookie ck[] =request.getCookies();
		if(ck.length>=2 && ck[1].getName().equals("ID")){
			id = (String) ck[1].getValue();
		}
		
		pstmt1 = conn.prepareStatement("select max(상품번호) from 상품");
		pstmt2 = conn.prepareStatement(sql);
		
		int pnum = 0;
		
		rs = pstmt1.executeQuery();
		if(rs.next()){
			pnum= rs.getInt(1);
		}
		
		pstmt2.setInt(1, pnum+1);
		pstmt2.setString(2, id);
		pstmt2.setString(3, productName);
		pstmt2.setString(4, productCount);
		pstmt2.setString(5, productPrice);
		
		
		int result = pstmt2.executeUpdate();
		
		if(result == 1){ // 성공
			%>
			<script>
				alert("상품추가 성공");
				location.href="manageProduct.jsp";
			</script>
			<% 
			
		} else{ // 실패
			%>
			<script>
				alert("상품추가 실패");
				location.href="manageProduct.jsp";
			</script>
			<% 
		}
		pstmt1.close();
		pstmt2.close();
		conn.close();
		
	}catch(ClassNotFoundException e) {
		out.println(e);
	}
	catch(SQLException e) {
		out.println(e);
	}
%>
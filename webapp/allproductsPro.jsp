<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="org.json.simple.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
<pre>
<%
	try {
		
		Connection con = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";   //************************************************************* 다른 서버에서 사용시 변경 필요 
		
		con = DriverManager.getConnection(DB_URL, userName, password);
		Statement st = con.createStatement();
		//id에 해당하는 passwd 가져오기
		String sql = "SELECT *  FROM 상품";
		rs = st.executeQuery(sql);
		
		JSONArray arr = new JSONArray();
		while(rs.next()){
			int n1 = rs.getInt("상품번호");
			String s = rs.getString("상품명");
			int n2 = rs.getInt("재고량");
			int n3 = rs.getInt("가격");
			JSONObject obj = new JSONObject();
			obj.put("상품번호", Integer.toString(n1));
			obj.put("상품명", s);
			obj.put("재고량", Integer.toString(n2));
			obj.put("가격", Integer.toString(n3));
			if(obj != null){
				arr.add(obj);
			}
		}
		out.print(arr);

		con.close();
		st.close();
	}
 
	catch(ClassNotFoundException e) {
		out.println(e);
	}
	catch(SQLException e) {
		out.println(e);
	}
%>
</pre>
</body>
</html>

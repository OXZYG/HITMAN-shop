<%--注册检查页面--%>
<%@ page contentType="text/html; charset=utf-8" language="java"%> 
<%@ page import="java.sql.*"%>
<html>
	<body>
		<%
      String username=request.getParameter("username");
			String password=request.getParameter("password");
      String email=request.getParameter("email");
			//out.println(username+password);
		%>
		<%
		  try{
			//装载驱动程序
			Class.forName("com.mysql.cj.jdbc.Driver");
			//连接字符串
			String url ="jdbc:mysql://localhost:3306/test?useSSL=true&serverTimezone=GMT"; 
			//建立连接
			Connection conn= DriverManager.getConnection(url,"root","123456"); 
			//使用PreparedStatement
			//创建一个PreparedStatement对象来将参数化的SQL语句发送到数据库
			PreparedStatement pstmt=conn.prepareStatement("insert into userinfo values(?,?,?)");
			//插入注册的数据
			pstmt.setString(1,username);
			pstmt.setString(2,password);
			pstmt.setString(3,email);
			pstmt.execute();
			out.println("注册成功...<br>3秒后返回登录界面,或者点击前往");
		%>
			<a href="loginpage.jsp">登录</a>
		<%
			response.setHeader("Refresh","3;URL=loginpage.jsp");
			//关闭连接、释放资源
			pstmt.close();
			conn.close();
		  }catch(ClassNotFoundException cnfe){
			  out.print(cnfe);
		  }catch(SQLException sqle){
				//注册的用户已存在。primary key冲突
			  //out.print(sqle);
				out.print("用户名"+username+"已被注册，请重新注册，3秒后跳转");
				response.setHeader("Refresh","3;URL=registerpage.jsp");
		  }catch(Exception e){
			  out.print(e);
		  }
		%>
		
	</body>
</html>

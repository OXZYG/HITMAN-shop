<%-- 执行修改信息 --%>
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>

<html>
	<body>
  <%
	//获取新的用户名、密码、邮箱
    String username=request.getParameter("newname");
    String password=request.getParameter("newpassword");
    String email=request.getParameter("newemail");
    //out.print("123123:"+username);
  %>
	<%
	  try{
		//装载驱动程序
		Class.forName("com.mysql.cj.jdbc.Driver");
		//连接字符串
		String url ="jdbc:mysql://localhost:3306/test?useSSL=true&serverTimezone=GMT"; 
		//建立连接
		Connection conn= DriverManager.getConnection(url,"root","123456"); 
		Statement stmt=conn.createStatement();
		//更新数据库
		String sql="update userinfo set password="+password+",email='"+email+"' where username='"+username+"'";
		stmt.executeUpdate(sql);
		stmt.close();
		conn.close();
		response.sendRedirect("userinfo.jsp");
	  }catch(ClassNotFoundException cnfe){
		out.print(cnfe);
	  }catch(SQLException sqle){
		out.print(sqle);
	  }catch(Exception e){
		out.print(e);
	  }
	%>
	</body>
</html>
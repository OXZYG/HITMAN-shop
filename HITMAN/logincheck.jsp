<%-- 登录检查 --%>
<%-- 1、读取登录信息，用户名密码不能为空
     2、用登录的信息去匹配数据库中的数据
     3、先检查是否已存在该用户。再检查密码配对 --%>
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>用户身份验证</title>
	</head>

	<body>
		<%
			String username=request.getParameter("username").trim();
			String password=request.getParameter("password").trim();//去掉空格
			session.setAttribute("username",username);
      //out.println(username+"<br>"+password);
			if(username.equals("XZY")&&password.equals("123456"))
				response.setHeader("Refresh","0;URL=adminpage.jsp?action=0");
			else{

      //从数据库中查找是否有该用户
      try{	
				//装载驱动程序
				Class.forName("com.mysql.cj.jdbc.Driver");
				//连接字符串
				String url ="jdbc:mysql://localhost:3306/test?useSSL=true&serverTimezone=GMT"; 
				//建立连接 
        Connection conn= DriverManager.getConnection(url,"root","123456"); 
				//建立Statement
				Statement stmt=conn.createStatement();
				//执行查询建立ResultSet
				//1、先查找是否存在该用户名
				ResultSet rs=stmt.executeQuery("select * from userinfo where username ='"+username+"'");
				/*另一种方式
				PreparedStatement sql =conn.prepareStatement("select * from student where username=? and password=?");
				sql.setString(1,username);
				sql.setString(2,password);
				rs=sql.executeQuery();
				*/
				//2、若存在该用户，则是已经注册，再继续查看密码是否正确
				if(rs!=null && rs.next()){
				  /*匹配用户名成功
					out.print("用户名匹配成功<br>"+rs.getString("username")+"<br>"+rs.getString("password")+"<br>"+rs.getString("email"));
					*/
					ResultSet ps=stmt.executeQuery("select * from userinfo where username ='"+username+"'and password ='"+password+"'");
          if(ps!=null && ps.next()){
						/*匹配密码成功
						out.print("密码匹配成功<br>"+ps.getString("username")+"<br>"+ps.getString("password")+"<br>"+ps.getString("email"));
            */
						/*用户名密码都匹配成功
						out.println("登录成功，3秒后跳转回登录界面，或者点击");
							%>
							<a href="index.jsp">此处</a>跳转
							<%
							response.setHeader("Refresh","3;URL=index.jsp");
							*/
							//直接跳到首页
							response.sendRedirect("index.jsp");  
						}
            else{//3、用户名存在，但是密码匹配失败
							out.println("<b>密码错误</b>，3秒后跳转回登录界面，或者点击"); %> <a href="loginpage.jsp">登录</a>
						<% response.setHeader("Refresh","3;URL=loginpage.jsp");
						}
				}
				//4、用户名匹配失败，即该用户不存在
        else{ out.print("用户不存在 请前往");%>	<a href="registered.jsp">注册</a>
				<% out.print("或者重新登录 ");%><a href="loginpage.jsp">登录</a>
				<%
				}
				//关闭连接、释放资源
				rs.close();
				stmt.close();
				conn.close();
			  }catch(ClassNotFoundException cnfe){
				out.print(cnfe);
			  }catch(SQLException sqle){
				out.print(sqle);
			  }catch(Exception e){
				out.print(e);
			  }
			}
		%>
	</body>
</html>
<%-- 修改个人信息界面 --%>
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>

<style>
  *{
    margin:0;
    padding:0;
  }

  .usinfbox
  {
    /* background-color:cadetblue; */
    width:500px;
    height:240px;
    margin:50px auto;
    padding:15px;
    text-align:center;
  }
  
  table{
    width:400px;
    margin:20px auto;
    margin-top:40px;
  }
</style>

<html>
	<body>
  <%
  //获取用户名来提取数据库中的数据
    String username=(String)session.getAttribute("username");
    //out.print(username);
  %>
  <div class="usinfbox">
    <h1>修改用户信息</h1><br><hr>
    <%-- 表单提交到infochangeing.jsp文件,执行修改操作 --%>
    <form method="post" action=infochanging.jsp>
      <table border=1 cellspacing=3 >
    <%
    try{
    	//装载驱动程序
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	//连接字符串
    	String url ="jdbc:mysql://localhost:3306/test?useSSL=true&serverTimezone=GMT"; 
    	//建立连接
    	Connection conn= DriverManager.getConnection(url,"root","123456"); 
    	Statement stmt=conn.createStatement();
    	ResultSet rs=stmt.executeQuery("select * from userinfo where username='"+username+"'");
      if(rs.next() && rs!=null)
      {
          out.print("<tr><td>用户名/账号</td><td><input type=\"text\" size=\"37\" name=\"newname\" value=\""+rs.getString("username")+"\" readonly=\"true\"></td></tr>");
          out.print("<tr><td>密码</td><td><input type=\"text\" size=\"37\" name=\"newpassword\" value=\""+rs.getString("password")+"\"></td></tr>");
          out.print("<tr><td>邮箱</td><td><input type=\"text\" size=\"37\" name=\"newemail\" value=\""+rs.getString("email")+"\"></td></tr>");
      }
    %>
      </table>
      <div>
        <input type="submit" value="确认修改">
        <input type="button" value="返回首页" onclick="window.location.href = 'index.jsp'">
      </div>    
    </form>

  </div>	
  <%
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
  %>
  
	</body>
</html>
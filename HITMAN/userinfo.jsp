<%-- 用户个人信息查看界面 --%>
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
    //获取用户名来查找数据库中的数据
      String username=(String)session.getAttribute("username");
    %>
    <div class="usinfbox">
      <h1>用户信息</h1><br><hr>
        <table border=1 cellspacing=3 >
          <%-- <tr><td>账号</td><td>密码</td><td>邮箱</td></tr> --%>
          <%
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
            ResultSet rs=stmt.executeQuery("select * from userinfo where username='"+username+"'");
            //输出查询结果
            while(rs!=null && rs.next()){
              out.print("<tr><td>用户名/账号</td><td>"+rs.getString("username")+"</td></tr>");
              out.print("<tr><td>密码</td><td>"+rs.getString("password")+"</td></tr>");
              out.print("<tr><td>邮箱</td><td>"+rs.getString("email")+"</td></tr>");
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
          %>
        </table>  
    <div>
      <input type="button" value="修改" onclick="window.location.href = 'changeinfo.jsp'">
      <%-- 返回首页 --%>
      <input type="button" value="返回" onclick="window.location.href = 'index.jsp'">
    </div>  
    </div>  
	</body>
</html>
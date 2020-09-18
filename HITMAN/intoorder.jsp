<%-- 
        PreparedStatement pstm=conn.prepareStatement("update shopcar set status = ? where username = ?");
				pstm.setString(1,"1");
        pstm.setString(2,username); 
        pstm.executeUpdate();    
         --%>

<%-- 网站购物车界面 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>彭格列基地</title>

</head>

<body>
	<%
	//判断是否已经有用户登录，有则1，显示【用户名】；无则0，显示【登录】
		int nameflag=1;
		String username=(String)session.getAttribute("username");
		if ((username!=null) && (username!="")) nameflag=1;
		else { nameflag=0;}
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
				//建立Statement
				Statement stmt=conn.createStatement();
				//执行查询建立ResultSet
        
				PreparedStatement pstmt=conn.prepareStatement("update shopcar set status = 1 where username = ? and status = 0");
				pstmt.setString(1,username);
        pstmt.executeUpdate();
        response.setHeader("Refresh","0;URL=order.jsp");
				//关闭连接、释放资源
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

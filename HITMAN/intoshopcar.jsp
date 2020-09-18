<%-- 执行添加进购物车的动作并返回到原来的商品详情页 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加进购物车</title>	
</head>

<body>
	<%
	//判断是否已经有用户登录，有则1，显示【用户名】；无则0，显示【登录】
		int nameflag=1;
		String username=(String)session.getAttribute("username");
		if ((username!=null) && (username!="")) nameflag=1;
		else { nameflag=0;}
		
		//获取传过来的商品ID和购买数量
    String shopid = (String)request.getParameter("shopid");
		int buynum = Integer.parseInt(request.getParameter("buynum"));
		
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
	//先根据id把该商品的数据查找出来，name和price
	PreparedStatement pstmt=conn.prepareStatement("select * from shopinfo where shopid = ?");
	{
		pstmt.setString(1,shopid);
		ResultSet rs=pstmt.executeQuery();
	 	if(rs!=null && rs.next()){
			PreparedStatement pstmtt=conn.prepareStatement("insert into shopcar values(?,?,?,?,?)");
			//out.print(rs.getString("shopname"));
			//将该用户信息及其购买的商品信息添加进该用户的订单
			while(buynum>0){
				pstmtt.setString(1,username);
				pstmtt.setString(2,shopid);
				pstmtt.setString(3,rs.getString("shopname"));
				pstmtt.setString(4,rs.getString("shopprice"));
				pstmtt.setString(5,"0");
				pstmtt.execute();
				buynum=buynum-1;
				}	
		 }
		 //购物车添加完毕，跳回原本的商品详情页面
		 response.setHeader("Refresh","0;URL=shopinfo.jsp?shopid="+shopid);
	}//关闭连接、释放资源

	pstmt.close();
  conn.close();
  }catch(ClassNotFoundException cnfe){
    out.print(cnfe);
  }catch(SQLException sqle){
		out.print("请先<a href=loginpage.jsp>登录</a>，3秒后跳转");
		response.setHeader("Refresh","3;URL=loginpage.jsp");
  }catch(Exception e){
    out.print(e);
  }
%>

</body>
</html>

<%-- 管理员的管理页面 
			用action来判断执行的操作
			0，进到管理首页
			1，查看用户信息
			2，查看订单信息
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>彭格列总控室</title>
	<style type="text/css">
		*{
			margin:0;
			padding:0;
			height:100%;
			width:100%;
			font-family:"微软雅黑";
		}
		
		body{
			background-image:url(image/20140722225553_QzQhd.thumb.1400_0.jpeg);/*总背景*/
			background-attachment:fixed;/*固定背景*/
			background-position:center;/*居中*/
			}
		/*顶部*/	
		.top{
			top:0;
			position:fixed;
			/*固定在顶部*/
			height:32px;
			width:100%;
			background-color:#066;
			/* 显示在最上层，才不会被挡住 */
			z-index: 999;
		}
		
		/*导航栏*/
		.top ul{
			width:auto;
			list-style-type:none;
			white-space:nowrap;/*文本不换行*/
			margin-left:20px;
			padding:0;
			}			
		.top li{
			height:auto;
			width:80px;
			float:left;/*横向排列*/
			margin-left:10px;
			/* padding:4px; */
			}			
		.top li a{
			display: block;
			color:#FFF;
			font-size:18px;
			font-family:"YouYuan";
			text-align:center;
			text-decoration:none;
			padding:6px;
			overflow:hidden;
		}
		/*鼠标放在导航栏时*/
		.top li a:hover{
			background-color:#6CC;
			color:#000;
			border-radius:4px;
			}
			
		/* 设置二级菜单*/ 	
		.top ul li ul{
    	position: relative;
    	display: none; /* 默认隐藏二级菜单的内容 */
		}
		/* 二级菜单li内容的显示*/
		.top ul li ul li{ 
    	float:none;
    	text-align: center;
		  margin-left:-25px;
		}
		/* 鼠标选中二级菜单内容时 */
		.top ul li:hover ul{
			display: block;
			
		}
		
		/*整体 的 中间部分*/	
		.main{
			height:auto;
			width:100%;
			margin:100px auto;
			background-size:cover;
			position:relative;
			/* background-color:white; */
		}		
		/*中间框架的顶部*/
		.main .header
		{
			height:auto;
			/* width:100%; */
			width:1200px;
			margin:80px auto 40px;
			/* background-color:#FF6; */
			position:relative;
			border-style:solid;
			border-radius: 5px;
			border-color:#298;
			border-width:2px;
			text-align:center;
			opacity:1;
		}
		.main .header h3{
			display:block;
			text-align:center;
			background-color:#289;
    	line-height: 1.5em;
			/* padding-top:30px; */
			font-family:"华文琥珀";
			font-size:36px;		
			opacity:0.8;
		}
		/*整体 的 中间 的 中间 背景盒子*/
		.main .backbox{
			width:1200px;
			/* background-color:#298; */
			/* background-color:white; */
			background: rgba(255,255,255,0.8);
			position:relative;
			margin:auto auto;
			opacity:1;
			display:flex;
			flex-wrap: wrap;
			justify-content:flex-start;
			box-sizing:border-box;
			border-style:solid;
			}
		/*商品盒子*/	
		/* 浮动元素的重叠问题
		1浮动元素不会覆盖文字内容
		2浮动元素不会覆盖图片内容
		(因为图片本身也属于文本，可以图片看做是一个特殊的文字)
		3浮动元素不会覆盖表单元素
		(输入框、单选按钮、复选框、按钮、下拉选择框等) */
    .main .backbox>h1{
      text-align:center;
    }
    .main .backbox>table{
      table-layout:fixed;
      text-align:center;
    }
    .main .backbox>table>tbody>tr>td{
      height:40px;  
    }
		.main .backbox>table>tbody>tr>td>a{
       text-decoration:none;
       color:black;
    }
		.main .backbox>table>tbody>tr>td>a:hover{
       font-size:20px;
    }    
		/*整体 底部*/
		.foot{
			position:fixed;
			bottom:0;
			/*固定在底部*/
			height:4%;
			width:100%;
			background-color:#066;
			text-align:center;
			}

	</style>
  <script>
			window.onload = function(){
      function $(id){
				return document.getElementById(id);
			}
			//对订单里的商品支付状态显示进行优化
      var oTable = $("order");//获取table
      var oTbody = oTable.tBodies[0];//获取tbody，记得加[]
			//初始化i=1,因为第一行是th，cell[3]，表单价格在第四列
			for (var i = 1; i < oTbody.rows.length; i++ ){
				if(oTbody.rows[i].cells[3].innerHTML=="0"){
					oTbody.rows[i].cells[3].innerHTML="<span style=color:red>未支付</span>";
				}
				else{
					oTbody.rows[i].cells[3].innerHTML="已支付";
				}
			}
  	}
	</script>
</head>

<body>
	<%
	//判断是否已经有用户登录，有则1，显示【用户名】；无则0，显示【登录】
		int nameflag=1;
		String username=(String)session.getAttribute("username");
		if ((username!=null) && (username!="")) nameflag=1;
		else {nameflag=0;}
	%>

	<div>
  	<!--顶部-->
  	<div class="top">
  		<!--导航栏-->
      <ul>

        <li style="float:left">
          <a href="adminpage.jsp?action=0">返回</a>
        </li>

      	<li style="float:right;">
					<%	if(nameflag==1){ %>
					<a href=""><% out.print(username);%></a>
          <ul>
						<li><a href="logoff.jsp">注销</a></li>
          </ul>							
				</li>
				<%	}
				else{ %>
					<a href="loginpage.jsp"><% out.print("登录");%></a>
				</li>
				<% } %>
				
      </ul>
    </div>
      <!--中间-->
    <div class="main">
      <div class="header">
				<img src="image/biaotilan.png">
				<h3>彭  格  列  管  理</h3>
      </div>
			<div class="backbox">
				<%
        //获取action的值，来判断下列的输出内容
				//	0，进到管理首页
				//	1，查看用户信息
				//	2，查看订单信息
        String action = request.getParameter("action");
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
        if(action.equals("1")){
				ResultSet rs=stmt.executeQuery("select * from userinfo order by username");
				//输出查询结果
        out.print("<h1>用户信息</h1><br><hr>");
        out.print("<table border=1 cellspacing=3>");
        out.print("<tr><th>用户名/账号</th><th>密码</th><th>邮箱</th></tr>");      
        while(rs!=null && rs.next()){
          out.print("<tr><td>"+rs.getString("username")+"</td>");
          out.print("<td>"+rs.getString("password")+"</td>");
          out.print("<td>"+rs.getString("email")+"</td></tr>"); 
        }
        out.print("</table>");
        rs.close();
        }

        else if(action.equals("2")){
        ResultSet rs=stmt.executeQuery("select * from shopcar order by username");
				//输出查询结果
        out.print("<h1>订单信息</h1><br><hr>");
        out.print("<table id=order border=1 cellspacing=3>");
        out.print("<tr><th>用户名/账号</th><th>商品id</th><th>商品名</th><th>状态</th></tr>");      
        while(rs!=null && rs.next()){
          out.print("<tr><td>"+rs.getString("username")+"</td>");
          out.print("<td>"+rs.getString("shopid")+"</td>");
          out.print("<td>"+rs.getString("shopname")+"</td>");
          out.print("<td>"+rs.getString("status")+"</td></tr>"); 
        }
        out.print("</table>");
        rs.close();
        }

        else{
          out.print("<table border=1 cellspacing=30>");
          out.print("<tr><td><a href=adminpage.jsp?action=1>用户管理</a></td>");
          out.print("<td><a href=adminpage.jsp?action=2>订单管理</a></td></tr></table>");
        }
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
      </div>
    </div>
    <!--底部-->
    <div class="foot">OXZYG @ HITMAN REBORN!</div>
  </div>
</body>
</html>

<%-- 商品详情界面 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>彭格列基地</title>
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
		.top li a
		{
			display: block;
			color:#FFF;
			font-size:18px;
			font-family:"YouYuan";
			text-align:center;
			text-decoration:none;
			padding:6px;
			overflow:hidden;}
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
		
		/*搜索框*/	
		.top .searchbox	{
			width:300px;
			height:26px;
			background-color:#FFF;
			margin-left:100px;
			margin-top:3px;}
		/*搜索按钮*/
		.top .sbtn
		{
			width:40px;
			height:24px;
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
			width:1200px;
			margin:120px auto 12px;
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
			background: rgba(0,0,0,0.8);
			position:relative;
			margin:auto auto;
			box-sizing:border-box;
			border-style:solid;
			overflow:hidden;
			}
		/*商品盒子*/	
		/* 浮动元素的重叠问题
		1浮动元素不会覆盖文字内容
		2浮动元素不会覆盖图片内容
		(因为图片本身也属于文本，可以图片看做是一个特殊的文字)
		3浮动元素不会覆盖表单元素
		(输入框、单选按钮、复选框、按钮、下拉选择框等) */
		.main .leftbox{
			width: 30%;
			min-width:30%;
			max-width:30%:
			/* 加上min max ，width才生效 */
			height:240px;
			background: rgba(255,250,255,0.5);
			margin:20px;
			float:left;
			}

		.main .leftbox>img{
			display:block;
		}
		
		.main .leftbox>h4{
			line-height:40px;
			text-align:center;
			font-family:"YouYuan";
		}

		.main .buybox{
			width:60%;
			float:right;
			height:auto;
			margin:20px;
			/* background-color:white; */
			background:rgba(255,255,255,0.75);
		}
		.main .buybox>table{
			table-layout: fixed;/*首行统一宽度*/
		}
		.main .buybox>table>tbody>tr>td{
			line-height:50px;
			text-align:center;
		}


		.main .buybox>button{
			width:30px;
			float:right;
		}
		.main .buybox>input{
			width:30px;
			margin:10px;
			height:30px;
			float:right;
			text-align:center;
		}
		.main .buybox .intocar{
			width:100px;
		}

		.main .introbox{
			width:96%;
			float:left;
			height:auto;
			margin:20px;
		}
		.main .introbox>p{
			color:white;
			text-indent:2em;
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
			//增加减少购买件数按钮
			var buynum = $("buynum");
			var addbtn = $("add");
			var subbtn = $("subtract");
			addbtn.onclick=function(){
				buynum.value++;
			};
			subbtn.onclick=function(){
				if(buynum.value>1)//禁止买0件
				buynum.value--;
			};
			//添加购物车按钮
			//获取从主页传到详情页的商品id
			var shopid='<%=(String)request.getParameter("shopid")%>';
			//获取加入购物车按钮
			var intocar=$("intocar");
			//加入购物车按钮点击事件
			intocar.onclick = function(){
				//一个jsp页面中的input框向另一个jsp页面的input框传值
				window.location.href='intoshopcar.jsp?shopid='+shopid+'&buynum='+buynum.value;
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
		else { nameflag=0;}
	%>

	<div>
  	<!--顶部-->
  	<div class="top">
  		<!--导航栏-->
      <ul>
      	<li><a href="index.jsp">首页</a></li>
          <li><a href="">分类</a>
          	<ul>
              <li><a href="">1</a></li>
              <li><a href="">2</a></li>
            </ul>
          </li>
          <li><a href="">收藏夹</a>
          	<ul>
              <li><a href="">1</a></li>
              <li><a href="">2</a></li>
              <li><a href="">3</a></li>
            </ul>                
          </li>
          <li><a href="">联系客服</a>
          	<ul>
              <li><a href="mailto:1922140676@qq.com">mailto:</a></li>
            </ul>
          </li>
          <!--搜索-->	
					<li>
						<form> 
							<input type="search" class="searchbox"  placeholder="泽田纲吉"/>
							<input type="submit" class="sbtn" value="搜索" />
						</form>
					</li>

      		<li style="float:right;">
					<%	if(nameflag==1){ %>
					<a href="userinfo.jsp"><% out.print(username);%></a>
          <ul>
						<li><a href="logoff.jsp">注销</a></li>
          </ul>							
				</li>
				<%	}
				else{ %>
					<a href="loginpage.jsp"><% out.print("登录");%></a>
				</li>
				<% } %>
				<%	if(nameflag==1){ %>
					<li style="float:right;">
						<a href="shopcar.jsp">购物车</a>
            <ul>
              <li><a href="order.jsp">订单</a></li>
            </ul>
					</li>
				<% } %>				
      </ul>
    </div>
      <!--中间-->
    <div class="main">
      <div class="header">
        <img src="image/biaotilan.png">
				<h3>彭格列商城</h3>
      </div>
			<div class="backbox">
				<%
				//获取从主页传到详情页面的shopid
				String shop_id =(String)request.getParameter("shopid");
				
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
				ResultSet rs=stmt.executeQuery("select * from shopinfo where shopid = '"+shop_id+"'");
				//输出查询结果
				while(rs!=null && rs.next()){
				  out.print("<div class="+"leftbox"+">");
					out.print("<img src="+"image/"+rs.getString("shoppng")+">"+"</div>");
					out.print("<div class="+"buybox"+">");
					//商品信息表格
					out.print("<table>");
					out.print("<tr><td>商品ID:</td><td>"+rs.getString("shopid")+"</td></tr>");
					out.print("<tr><td>商品名:</td><td>"+rs.getString("shopname")+"</td></tr>");
					out.print("<tr><td>价格:</td><td>"+"¥"+rs.getString("shopprice")+"</td></tr>");
					out.print("<tr><td>库存:</td><td>"+rs.getString("inventory")+"</td></tr></table>");
					//按钮。加入购物车时，把当前商品的ID传过去
					out.print("<input type=submit id=intocar class=intocar value=加入购物车>");
					out.print("<input type=button id=add value=+>");
					out.print("<input type=text id=buynum value=1>");
					out.print("<input type=button id=subtract value=->");
					
					out.print("</div>");
					out.print("<div class="+"introbox"+"><p>介绍："+rs.getString("introduction")+"</p></div>");
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
      </div>
    </div>
    <!--底部-->
    <div class="foot">OXZYG @ HITMAN REBORN!</div>
  </div>
</body>
</html>

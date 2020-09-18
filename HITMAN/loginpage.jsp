<%-- 登录界面 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
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
			background-image:url(image/20140722225553_QzQhd.thumb.1400_0.jpeg);
			background-attachment:fixed;
			background-position:center;
			}
			
		.top{
			top:0;
			position:fixed;
			/*固定在顶部*/
			height:42px;
			width:100%;
			background-color:#066;
		}

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
			padding:4px;
			}	
			
		.top li a
		{
			display: block;
			color:#FFF;
			font-size:18px;
			text-align:center;
			text-decoration:none;
			padding:6px;
			overflow:hidden;}
		
		.top li a:hover{
			background-color:#6CC;
			color:#000;}
			
			
		.top ul li ul{
    	/* 设置二级菜单 */
    	position: relative;
    	display: none; /* 默认隐藏二级菜单的内容 */
		}
		.top ul li ul li{
    	/* 二级菜单li内容的显示 */
    	float:none;
    	text-align: center;
		margin-left:-25px;
		}
		.top ul li:hover ul{
    	/* 鼠标选中二级菜单内容时 */
    	display: block;
		}
			
		.top .searchbox	{
			width:300px;
			height:36px;
			background-color:#FFF;
			margin-left:100px;
			margin-top:3px;}
		.top .sbtn
		{
			width:40px;
			height:36px;
		}			
		.main{
			height:600px;
			width:100%;
			margin:auto;
			background-size:cover;
		}
		
		.foot{
			position:fixed;
			bottom:0;
			/*固定在底部*/
			height:4%;
			width:100%;
			background-color:#066;
			text-align:center;
			}
			
		.box
		{
			width: 414px;
			height: 312px;
			border: solid 4px;
			background-color:#99C;
			padding:auto;
			margin:auto;
			margin-top:100px;
			opacity:0.88;	
		}
		
		.box h2
		{   
			width:414px;
			height:60px;
     		padding:0;
			margin-top:30px;
    	 	color:#000;
     		text-align:center;
		}
		
		.box .login{
			height:30px;
			width:210px;
			position:relative;
			margin:auto;
			padding:auto;

		}
		
		.box .btn{
			width:66px;
			height:30px;
			margin-left:26px;
			margin-top:20px;
			}
		
	</style>
	<%-- 对用户填写的登录进行提示 --%>
  <script>
	function isValid(form)  
	{  
	if (form.username.value=="")  
	{  
 		alert("请输入用户名");  
 		return false;  
	}  
	else  if (form.password.value=="")  
	{  
		alert("请输入密码！");  
		return false;  
	}   
	else return true;  
	}  
	</script> 	
</head>

<body>
	<div>
    	<div class="top">
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
                	
                <input type="search" class="searchbox"  placeholder="泽田纲吉"/>
                <input type="submit" class="sbtn" value="搜索" />
            	<li style="float:right"><a href="loginpage.jsp">登录</a></li>
            </ul>
         </div>
        
        <div class="main">
        	<div class="box">
            <h2>LOGIN</h2>
						<form method="post" class="login" action="logincheck.jsp" onSubmit="return isValid(this)">
							账号：<input type="text" name="username" placeholder="输入账号">
							<!--<label>请输入账号</label> -->
							密码:<input type="password" name="password" placeholder="输入密码">
							<!--<label>请输入密码</label> -->
							<input type="submit" value="登录" class="btn">
							<input type="reset" value="重置" class="btn">
							<br><p style="margin-top:20px;margin-left:48px;">没有账号？<a href="registerpage.jsp">注册</a></p> 
							 <!-- <input type="button" value="注册" class="btn"  onclick="javascript:window.location.href='registered.jsp'"> --%> -->
						</form>
          </div>
      	</div>
        <div class="foot">OXZYG @ HITMAN REBORN!</div>
    </div>
</body>
</html>

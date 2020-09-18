<%-- 注销用户 --%>
<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.io.*"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>注销</title>
	</head>

	<body>
		<%
			  String username=(String)session.getAttribute("username");
			  session.invalidate();//注销会话。
			  if(username!=null){
			    out.println(username+"再见 ! 欢迎再来 ! <br><br>3秒后跳转回");
		%>			 
				<a href="index.jsp">首页</a>
		<%	response.setHeader("Refresh","3;index.jsp");
			  }
		%>
		</p>
	</body>
</html>
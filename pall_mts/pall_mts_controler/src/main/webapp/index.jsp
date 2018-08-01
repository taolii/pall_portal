<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String basePath = request.getContextPath();
%>
<html>
	<head>
    <base href="<%=basePath%>">
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
<body>
      <script  type="text/javascript">  
      	window.location.href='<%=basePath%>/login';
      </script >  
</body>
</html>

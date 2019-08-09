<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="easyui.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
String msg = (String)request.getAttribute("msg");         // 获取错误属性
if(msg != null) {
%>
<script type="text/javascript" language="javascript">
alert("<%=msg%>");
this.window.opener = null;  
window.close(); 
</script> 
<%
}
%>
<body>
	<form action="user.s?op=changePerson" method="post" id="form">
		请输入您的签名:
		<textarea name="person" rows="8" cols="26"></textarea>
		<div class="botton1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="easyui-linkbutton" onclick="form.submit()">确定</a>
        <a class="easyui-linkbutton" href="javascript:window.opener=null;window.close();">取消</a></div>
	</form>
</body>
</html>
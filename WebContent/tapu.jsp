<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="easyui.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
	<form action="user.s?op=tapu" method="post" id="form">
	<input type="hidden" id="uid" name="uid" value="${param.uid}"> 
	<span>请选择禁言时间:</span>
		<select id="day" name="day">
			<option value="1">一小时</option>
			<option value="12">12小时</option>
			<option value="24">一天</option>
			<option value="168">一周</option>
			<option value="720">一个月</option>
			<option value="8760">一年</option>
		</select><br><br><br><br>
		<div class="botton1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="easyui-linkbutton" onclick="form.submit()">确定</a>
        <a class="easyui-linkbutton" href="javascript:window.opener=null;window.close();">取消</a></div>
	</form>
</body>
</html>
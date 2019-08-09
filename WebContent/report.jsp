<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type = "text/javascript" src="<%=request.getContextPath()%>/js/ckeditor/ckeditor.js"></script>
	<!--      导航        -->
<%@ include file="easyui.jsp" %>
<%
String title = "";
String content = "";
if(request.getParameter("title") != null){
	 title= new String(request.getParameter("title").getBytes("iso-8859-1"), "utf-8");
	 content= new String(request.getParameter("content").getBytes("iso-8859-1"), "utf-8");
}
%>
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
<link rel="stylesheet" type="text/css" href="css/MyCss.css">
</head>
<body>
<form action="user.s?op=report" method="post" id="form">
	<input type="hidden" id="uid" name="uid" value="${param.uid}"> 
	<br/>举报原因 &nbsp;<input class="input"  tabIndex="1"  type="text"  maxLength="20" size="35" name="title" value="<%=title%>">
	<br/>详细内容 &nbsp;<textarea tabIndex="2"  id="content"   name="content" ><%=content %></textarea>
	<script>
           CKEDITOR.replace( 'content' );
    </script>
    <div class="botton1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="easyui-linkbutton" onclick="form.submit()">确定</a>
    <a class="easyui-linkbutton" href="javascript:window.opener=null;window.close();">取消</a></div>
</form>
</body>
</html>
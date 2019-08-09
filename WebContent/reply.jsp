<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp"%>
<% request.setCharacterEncoding("utf-8"); %>
<script type="text/javascript">
	function changeImage(){
		document.getElementById("image01").src="image.jsp?" + new Date();
	}
</script>
<%
String title = "";
String content = "";
if(request.getParameter("title") != null){
	 title= new String(request.getParameter("title"));
	 content= new String(request.getParameter("content"));
}
%>
<script type = "text/javascript" src="<%=request.getContextPath()%>/js/ckeditor/ckeditor.js"></script>
	<!--      导航        -->
<%@ include file="nav.jsp" %>
<!--      用户登录表单        -->
<!--  显示错误信息 -->
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>
	<div class="msg">
		<font  color="red">${msg}</font>
	</div>
	<DIV class="t" style="MARGIN-TOP: 15px" align="center">
	<FORM name="postForm" action="topic?op=reply&topicid=${param.topicid }" method="post">
		<input  type="hidden" name="userid"  value="${user.uid}">
		<br/>标题 &nbsp;<input class="input" tabIndex="1"  type="text"  maxLength="20" size="35" name="title" value="<%=title%>">
		<br/>内容 &nbsp;<textarea tabIndex="2"  id="content"   name="content" ><%=content %></textarea>
		<script>
                 CKEDITOR.replace( 'content' );
           </script>
		<br/>
		<INPUT class="btn"  tabIndex="6"  type="submit" value="回 复">
	</FORM>
</DIV>
<%@ include file="bottom.jsp"%>
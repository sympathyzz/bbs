<%@ include file="header.jsp"%>
<script type="text/javascript">
	function changeImage(){
		document.getElementById("image01").src="image.jsp?" + new Date();
	}
</script>
<script type = "text/javascript" src="<%=request.getContextPath()%>/js/ckeditor/ckeditor.js"></script>
	<!--      导航        -->
<%@ include file="nav.jsp" %>
<!--      用户登录表单        -->
<!--  显示错误信息 -->
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>
<%
String title = "";
String content = "";
if(request.getParameter("title") != null){
	 title= new String(request.getParameter("title"));
	 content= new String(request.getParameter("content"));
	
}
%>
	<div class="msg">
		<font  color="red">${msg}</font>
	</div>
	<DIV class="t" style="MARGIN-TOP: 15px" align="center">
	<FORM name="postForm" action="topic?op=post" method="post">
		<input  type="hidden" name="boardid" value="<%=request.getParameter("boardid")%>">
		<input  type="hidden" name="userid"  value="${user.uid}">
		<br/>标题 &nbsp;<input class="input" tabIndex="1"  type="text"  maxLength="20" size="35" name="title" value="<%=title%>">
		<br/>内容 &nbsp;<textarea tabIndex="2"  id="content"   name="content" ><%=content %></textarea>
		<script>
                CKEDITOR.replace( 'content' );
            </script>
		<br/>
		<INPUT class="btn"  tabIndex="6"  type="submit" value="发 布">
	</FORM>
</DIV>
<%@ include file="bottom.jsp"%>
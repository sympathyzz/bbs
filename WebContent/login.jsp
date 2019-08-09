<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    
<%@ include file="header.jsp"%>
<script type="text/javascript">
	function changeImage(){
		document.getElementById("image01").src="image.jsp?" + new Date();
	}
</script>
	<!--      导航        -->
<%@ include file="nav.jsp" %>
	<div class="msg">
		<font  color="red">${msg}</font>
	</div>
<!--      用户登录表单        -->
<!--  显示错误信息 -->
	<DIV class="t" style="MARGIN-TOP: 15px" align="center">
	<FORM name="loginForm" action="user.s?op=login" method="post" id="form">
		<input type="hidden" name="op" value="login"/>
		<br/>用户名 &nbsp;<input class="easyui-textbox" tabIndex="1"  type="text"      maxLength="20" size="35" name="uname">
		<br/>密　码 &nbsp;<input class="easyui-textbox" tabIndex="2"  type="password"  maxLength="20" size="40" name="upass">
		<br/>验证码 &nbsp;<input class="easyui-textbox" type="text"  name="val_code" />
<!-- 		<img id="image01" src="image.jsp"/> -->
		<a href="javascript:void(0)"  onclick="changeImage()">看不清</a>
		<br/>
		<!-- <INPUT class="btn"  tabIndex="6"  type="submit" value="登 录"> -->
		<a href="#" class="easyui-linkbutton" style="width:120px" onclick="form.submit()">登录</a>
	</FORM>
</DIV>
<%@ include file="bottom.jsp"%>
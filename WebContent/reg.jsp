<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<TITLE>论坛--注册</TITLE>

<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<Link rel="stylesheet" type="text/css" href="style/style.css" />
</HEAD>
<BODY>
	<!--      用户信息、登录、注册        -->

	<%@ include file="header.jsp"%>
	<div class="msg">
		<%-- 		<font  color="red">${msg}</font> --%>
	</div>
	<BR />
	<!--      导航        -->
	<%@ include file="nav.jsp"%>
	<!--      用户注册表单        -->
	<DIV class="t" style="MARGIN-TOP: 15px" align="center">
		<FORM name="regForm" action="user.s?op=reg" method="post"  onsubmit="return checksubmit()">
		<input type="hidden" id = "hcode" />

			<br />手&nbsp;机&nbsp;号 &nbsp; 
			<input class="input" maxLength="18" size="35" name="phone" id="phone" onkeyup="checkPhone()" /> 
			<span id="checkPhone">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>

			<br />QQ邮箱 &nbsp; 
			<input class="input" maxLength="18" size="35" name="mail" id="mail" onkeyup="checkEmail()" /> 
			
			<span id="checkEmail">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>

			<br />用&nbsp;户&nbsp;名 &nbsp; 
			<input class="input" maxLength="18" size="35" name="uName" id="uName" onkeyup="check()" /> 
			<span id="checkResult">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span> 
			
			
			<br />密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码
			&nbsp; <INPUT class="input" type="password" maxLength="18" size="35" name="uPass" id = "uPass" onkeyup="checkP()" /> 
			<span id="checkP">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>
				
				
			<br />
			重复密码  <INPUT class="input" type="password" maxLength="18"	size="35" name="uPass1" id = "uPass1" onkeyup="checkP1()" />
			
			<span id="checkP1">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span>
				
			<br/>邮箱验证 
			<INPUT class="input" type="text" maxLength="18" size="20" id="code" name = "code" >&emsp;
			<button id="bt" type="button" style="height:33px" >获取验证码</button>
			<span id="checkm">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</span> 
			
			
			
			<br />性别 &nbsp; 女<input type="radio"
				name="gender" value="1"> 男<input type="radio" name="gender"
				value="2" checked="checked" /> <br />请选择头像 <br /> <img
				src="image/head/1.gif" /><input type="radio" name="head"
				value="1.gif" checked="checked"> <img src="image/head/2.gif" /><input
				type="radio" name="head" value="2.gif"> <img
				src="image/head/3.gif" /><input type="radio" name="head"
				value="3.gif"> <img src="image/head/4.gif" /><input
				type="radio" name="head" value="4.gif"> <img
				src="image/head/5.gif" /><input type="radio" name="head"
				value="5.gif"> <BR /> <img src="image/head/6.gif" /><input
				type="radio" name="head" value="6.gif"> <img
				src="image/head/7.gif" /><input type="radio" name="head"
				value="7.gif"> <img src="image/head/8.gif" /><input
				type="radio" name="head" value="8.gif"> <img
				src="image/head/9.gif" /><input type="radio" name="head"
				value="9.gif"> <img src="image/head/10.gif" /><input
				type="radio" name="head" value="10.gif"> <br /> <img
				src="image/head/11.gif" /><input type="radio" name="head"
				value="11.gif"> <img src="image/head/12.gif" /><input
				type="radio" name="head" value="12.gif"> <img
				src="image/head/13.gif" /><input type="radio" name="head"
				value="13.gif"> <img src="image/head/14.gif" /><input
				type="radio" name="head" value="14.gif"> <img
				src="image/head/15.gif" /><input type="radio" name="head"
				value="15.gif"> <br /> <INPUT class="btn" tabIndex="4"
				type="submit"  value="注 册">
		</FORM>
	</DIV>
	
	
	
	
	
	
	<script>
	
			//原生ajax
			var xmlhttp;
			function check(){
			var name = document.getElementById("uName").value;
			var url = "<%=request.getContextPath()%>/ajax.s?op=check&name=" + name;

			xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = checkResult;//
			xmlhttp.open("GET", url, true);//
			xmlhttp.send(null);

				function checkResult() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
						document.getElementById('checkResult').innerHTML = xmlhttp.responseText;
				}
			}
			
			
			
			//判断邮箱格式
			function checkEmail() {	
				var re = new RegExp(/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);/*邮箱不区分大小写*/
				
				if (re.test($("#mail").val())) {
					$("#checkEmail").html("<font color='green'>可以使用&emsp;&emsp;&emsp;&emsp;</font>");
					//格式正确再判断是否有用户注册过
					return 0;
				} else {
					$("#checkEmail").html("<font color='red'>邮箱格式错误&emsp;&emsp;</font>");
					return -1;
				}
			}
			
			
			//判断手机号格式
			function checkPhone() {	
				var re = new RegExp(/^1[34578]\d{9}$/);
				if (re.test($("#phone").val())) {
					$("#checkPhone").html("<font color='green'>可以使用&emsp;&emsp;&emsp;&emsp;</font>");
					//格式正确再判断是否有用户注册过
					return 0;
				} else {
					$("#checkPhone").html("<font color='red'>请输入正确手机号</font>");
					return -1;
				}
			}
			
			
			//判断密码1
			function checkP() {	
				if($("#uPass").val().length<6){
					$("#checkP").html("<font color='red'>密码长度小于6位</font>");
				}else{
					$("#checkP").html("<font color='green'>可以使用&emsp;&emsp;&emsp;&emsp;</font>");
				}
			}
			
			
			//判断密码2
			function checkP1() {	
				var p1 = $("#uPass").val();
				var p2 = $("#uPass1").val();
				if(p1 == p2){
					if($("#uPass").val().length<6){
						$("#checkP1").html("<font color='red'>密码长度小于6位</font>");
					}else{
						$("#checkP1").html("<font color='green'>可以使用&emsp;&emsp;&emsp;&emsp;</font>");
					}
				}else{
					$("#checkP1").html("<font color='red'>两次密码不一致&emsp;</font>");
				}
			}
			
			
			function checksubmit(){
				var code = $("#hcode").val();
				
				if($("#code").val()==code){
					alert("注册成功");
					return true;
				}else{
					alert("验证码错误！");
					return false;
				}
			}
			
	$(function() {
		//点击获取验证码
		$("#bt").click(function() {
			//格式正确，发送
			if(checkEmail() == 0){
				
				//ajax请求发送邮箱
				$.get("ajax.s?op=sendMail", {
					"email" : $("#mail").val()
				}, function(data) {
					if (data!=-1) {
						alert("发送成功，请查收验证码");
						$("#bt").attr("disabled","disabled");
						$("#bt").html("已发送");
						window.open("https://mail.qq.com/");
						$("#hcode").val(data);
					} else {
						alert("邮件发送失败，请重新发送");
					}
				});
			}else{
				$("#checkEmail").html("<font color = 'red'><b>邮箱格式错误</b>&emsp;&emsp;</font>");
			}
		});
	});
</script>


	<%@ include file="bottom.jsp"%>
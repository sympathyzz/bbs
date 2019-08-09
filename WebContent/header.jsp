<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype jsp>
<html>
<head>
<meta charset="utf-8">
<TITLE>编程论坛</TITLE>
<Link rel="stylesheet" type="text/css" href="style/style.css"/>
<%@ include file="easyui.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
</HEAD>
<BODY>
<style type="text/css">
.img1 {
	position: absolute;
	left: 210px;
	top: 0px;
}

.img2 {
	position: absolute;
	left: 550px;
	top: 0px;
}

/* .img3 {
	position: fixed;
	right: 0px;
	bottom: 0px;
	z-index: 999999;
} */

</style>

<script>
$(function(){
	
	setInterval(message,1000);
		function message(){
			
		var uid = "${user.uid}";
		
			if(uid != null&&uid!=""){
				$.ajax({url:"socket?op=getChat&uid="+uid,success:function(result){
					if(result == "yes"){
						$("#message").text("您有新消息");
						clearInterval(message);
					}
				  }});
				//setInterval('refreshOnTime', 1000);
			}
		}	
		
})
</script>

<body>

	<DIV>
		<IMG src="image/logo.gif" height="78" width="200">
	</DIV>
<a id="dd" href="http://www.hyycinfo.com/Examination2.0/" target="_blank" >
<IMG class="img1" src="image/花千骨.jpg" height="78" width="319" id="d2" >
		</a>
	
	<IMG class="img2" src="image/head/${ad.img }" height="78" width="319"
		onclick='window.open("${ad.href}")'>
	<!-- <IMG class="img3" src="${ad.img }"> -->
	<script type="text/javascript">
		var i = 0;
		var imagesName = [ "image/北大青鸟.jpg","image/手表.jpg", "image/花千骨.jpg" ];
		function changeimg() {
			tid = setInterval(function() {
				d2.src = imagesName[i];
				i++;
				if (i == 3) {
					i = 0;
				}
			}, 2000);
		}

		changeimg();

		var set = document.getElementById('d2');
		var set1 = document.getElementById('dd');
		set.onmouseover = function() {
			if(i ==0){
				set1.href="http://hqg.skymoons.com/";
			}
			if(i==1){
				set1.href="http://www.bdqnvip.wang/zt/zt_95.html?xbd&a-bdqn&2230#01";
			}	
			if(i==2){
				set1.href="https://www.wbiao.cn/";
			}	
			clearInterval(tid);

		}
		set.onmouseout = function() {
			changeimg();
		}
		
	</script>
<!--      用户信息、登录、注册        -->
	<c:if test="${user != null}">
	<DIV class="h">
		欢迎:${user.uname}
		&nbsp;| &nbsp; <A href="user.s?op=logOut">退出</A> 
		&nbsp;| &nbsp; <A href="chatroom.jsp?uid=${user.uid}" >在线聊天室</A> 
		&nbsp;|&nbsp;<A href="user.s?op=getUser&uid=${user.uid}" >个人资料</A>
		&nbsp;|&nbsp;<A href="home.jsp?op=1" >修改密码</A>
		&nbsp;|&nbsp;<A href="chet.jsp" id="message" style="color: red"></A>
		
		<c:if test= "${user.type == 1}">
			&nbsp;|&nbsp;<A href="manage/manage.jsp" >管理员界面</A>
		</c:if>
	</DIV>
	</c:if>
	
	<c:if test="${user == null }">
	<DIV class="h">
		您尚未　<a href="home.jsp">登录</a>
		&nbsp;| &nbsp; <A href="reg0.jsp" >注册</A> |
	</DIV>
	</c:if>

	<div hidden="true" class="aid">${ad.aid}</div>

<script type="text/javascript">

$(function() {
	var aid=$(".aid").text()
 if(aid!=""){
	 $(".img2").click(function(){
			
			
		 $.ajax({ //json格式（键值对的形式）
				url:"ad.s", //服务器地址
				method:"post", //请求方式
				async:true, //是否采用异步请求
				data:{"aid":aid}, //请求参数
				dataType:"text", //服务器响应数据的类型
				 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
				if(data.trim() == "yes"){ //判断数据是否为空
				alert("该广告已过期，自动换广告")
				window.location.reload()
				}else{
					
				}
				}, 			
				error:function(){ //请求失败的回调函数
				alert("服务器异常...");
				}
				}); 
	});
 }else{
	
		$(".img2").attr("src","image/广告位招租.jpg")
		$(".img2").attr("onclick","window.open('https://www.baidu.com')")
 }
	
	
})
</script>
<BR/>






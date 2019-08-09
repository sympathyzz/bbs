<%@page import="com.yc.utils.MyUtils"%>
<%@page import="com.yc.bean.User"%>
<%@page import="com.yc.biz.impl.UserImpl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="easyui.jsp" %>
<%
UserImpl ui = new UserImpl();
//根据exp经验值判断等级
User u =  (User)request.getSession().getAttribute("user");
int lv = MyUtils.getLevel(u.getExp());
%>
<link rel="stylesheet" type="text/css" href="css/Usercss.css">
<link rel="stylesheet" type="text/css" href="css/Img.css">
<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">
function tapu(type){
	var uid = "${data[0].uid}";
	if( type == 0){
		alert("只有管理员账户才能设置将他人禁言哦");
	}else{
		var openUrl = "tapu.jsp?uid="+uid;//弹出窗口的url
		var iWidth=500; //弹出窗口的宽度;
		var iHeight=300; //弹出窗口的高度;
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		window.open(openUrl,"","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft);
	}
}
	
	function report(){
			var uid = "${data[0].uid}";
			var openUrl = "report.jsp?uid="+uid;//弹出窗口的url
			var iWidth=500; //弹出窗口的宽度;
			var iHeight=500; //弹出窗口的高度;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
			var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
			window.open(openUrl,"","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft);
	}
	
	$(document).ready(function(){
		  $("#add").click(function(){
			  var uid = "${data[0].uid}";
			  var i = $("#add").attr("value");
			  if(i == "关注"){
				  $.ajax({url:"user.s?op=follow&uid="+uid,success:function(){
						 $("#add").text("已关注");
						 $("#add").attr("value","已关注");
						 window.location.reload()
					  }});
			  }else{
				  $.ajax({url:"user.s?op=cencel&uid="+uid,success:function(result){
						 $("#add").text("关注");
						 $("#add").attr("value","关注");
						 window.location.reload()
					  }});
			  }
		  });
		});	
	
	$(function(){
		var uid = "${data[0].uid}";
		$.ajax({url:"user.s?op=beFollow&uid="+uid,success:function(data){
			$("#followHis").nextAll().remove();
			$.each($.parseJSON(data),function(k,v){
				$("#followHis").after("<a href='user.s?op=getUser&uid="+v.uid+"'><img class='img_show' src='image/head/"+v.head+"'></a><br>");
			})
		  }});
	})
	
	$(function(){
		var uid = "${data[0].uid}";
		$.ajax({url:"user.s?op=getFollow&uid="+uid,success:function(data){
			$("#hisFollow").nextAll().remove();
			$.each($.parseJSON(data),function(k,v){
				$("#hisFollow").after("<a href='user.s?op=getUser&uid="+v.uid+"'><img class='img_show' src='image/head/"+v.head+"'></a><br>");
			})
		  }});
	})
	/**
	*关注按钮的判断
	*/
	$(function(){
		  var uid = "${data[0].uid}";
		  var i = $("#add").attr("value");
		  $.ajax({url:"user.s?op=isfollow&uid="+uid,success:function(result){
			  var obj = JSON.parse(result);
			  if(obj.cnt != null && obj.cnt != "0"){
					$("#add").text("已关注");
					$("#add").attr("value","已关注");
				}
			  }});
		  
	})

	
</script>
<body background="image/background/背景03.jpg"
style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;"
>	<div id="back">
		<img id="img01" src="image/background/背景01.jpg">
	</div>
	<div id="div1">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<img src="image/head/${data[0].head }" class="head_img" id="head">
					<a href="#" value="关注" class="easyui-linkbutton" data-options="iconCls:'icon-add'" id="add" >关注</a>
					<a href="chet.jsp?toname=${data[0].uid }" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" id="chet">私信</a>
					<hr>
				</div>
				<hr>
				<div id="div4">
					<div id="div3">
						<span >昵称:${data[0].uname}</span>&nbsp;&nbsp;|&nbsp;&nbsp;
						<span >等级:<%=lv %></span>&nbsp;&nbsp;|&nbsp;&nbsp;
						<span >发帖:${data[0].cnt }</span>|<br>
						<span >个性签名:${data[0].person }</span><br>
					</div>
					<div>历史发文</div>
					<div id="eor">
						<a href="#" onclick='tapu("${user.type}")'>禁言</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" onclick='report()'>举报</a>
					</div>
					<hr>
					<c:if test="${data[0].topicid != null }">
						<c:forEach items="${data}" var="i">
						<div id="div5">
							<span>标题:<a href="topic?op=detail&topicid=${i.topicid }&boardid=${i.boardid}&pageNum=1">${i.title }</a></span><br>
							<span>发布时间:${i.publishtime }</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>热度:</span>
						</div>
						<br>
					</c:forEach>
					</c:if>
					<c:if test="${data[0].topicid == null }">
						<div id="div5">该用户暂未发布任何帖子</div>
					</c:if>
					<div id="div9">
						<div id="div6" class="box">
							<div id="hisFollow">他关注的人</div>
						</div>
						<div id="div7" class="box">
							<div id="followHis">关注他的人</div>
						</div>
					
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
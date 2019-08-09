<%@page import="com.yc.dao.UserDao"%>
<%@page import="com.yc.utils.MyUtils"%>
<%@page import="com.yc.bean.User"%>
<%@page import="com.yc.biz.impl.UserImpl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="css/MyCss.css">
<%@ include file="easyui.jsp" %>
<link rel="stylesheet" type="text/css" href="css/MyCss.css">
<link rel="stylesheet" type="text/css" href="css/Img.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<script type="text/javascript" src="js/bootstrap.js">
<!--

//-->
</script>
<%
// 	int year = 0;
//     Timestamp time1 = new Timestamp(System.currentTimeMillis());
// 	List<Map<String,Object>> list = (List<Map<String,Object>>)request.getAttribute("data");
// 	for(Map<String,Object> map:list){
// 		Timestamp time2 = (Timestamp)map.get("regtime");
// 		year = time1.getYear()-time2.getYear();
// 		if(year == 0){
// 			year = 1;
// 		}
// 		break;
// 	}
	UserImpl ui = new UserImpl();
	//根据exp经验值判断等级
	User u =  (User)request.getSession().getAttribute("user");
	//这里拿的是session中的user他的经验值并不会动态变化，要从数据库中拿
	UserDao ud = new UserDao();
	
	int exp = ud.getExp(u.getUid());
	int lv = MyUtils.getLevel(exp);
	int h = MyUtils.getLimit(exp);
%>

<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">
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
	$(function(){
		$("#pen").click(function(){
			var openUrl = "changePerson.jsp";//弹出窗口的url
			var iWidth=500; //弹出窗口的宽度;
			var iHeight=300; //弹出窗口的高度;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
			var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
			window.open(openUrl,"","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft);
		})
	})
	
	$(function(){
		$("#alterHeadImg").click(function(){
			var openUrl = "alterHead.jsp";//弹出窗口的url
			var iWidth=500; //弹出窗口的宽度;
			var iHeight=300; //弹出窗口的高度;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
			var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
			window.open(openUrl,"","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft);
		})
	})
	
	function myfb(){
		$("#fb").attr("class","active");
		$("#sc").attr("class","");
		document.getElementById("mysc").style.display="none";
		document.getElementById("myfb").style.display="";
	}
	function mysc(){
		$("#div11").empty();
		var uid = "${user.uid}";
		$("#fb").attr("class","");
		$("#sc").attr("class","active");
		document.getElementById("myfb").style.display="none";
		document.getElementById("mysc").style.display="";
		$.ajax({url:"ZSc.s?op=getMyCollect&uid="+uid,success:function(data){
			if(data == -1){
				$("#div11").append("<div>暂无收藏</div>")
			}else{
				$.each($.parseJSON(data),function(k,v){
					$("#div11").append("<span>标题:<a href='topic?op=detail&topicid="+v.topicid+"&boardid="+v.boardid+"&pageNum=1'>"+v.title+"</a></span><br>")
					var time = gettime(v.publishtime);
					$("#div11").append("<span>发布时间:"+time+"</span>");
					$("#div11").append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
					$("#div11").append("<span>热度:"+v.count+"</span>");
				})
			}
		}})
	}
	
	function gettime(value,row,index){
		var date = new Date(value);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
	}
</script>
<body background="<%=request.getContextPath()%>/image/background/背景03.jpg"
style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;"
>	
	<div id="back">
		<img id="img01" src="<%=request.getContextPath()%>/image/background/背景01.jpg">
	</div>
	<div id="div1">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-sm-12">
					<img src="<%=request.getContextPath()%>/image/head/${data[0].head }" class="head_img">
					
					<div id="div3">
						<span >昵称:${data[0].uname}</span>&nbsp;&nbsp;|&nbsp;&nbsp;
						<span >发帖:${data[0].cnt ==null?0:data[0].cnt}</span> &nbsp;| &nbsp;
						<span >等级:lv<%=lv%>&nbsp;<font size="2">(<%=exp%>/<%=h%>)</font></span>&nbsp;&nbsp;<br>
						<span >个性签名:<c:if test="${data[0].person != null }">${data[0].person}</c:if></span>
						<span><img src="<%=request.getContextPath()%>/image/util/pen.PNG" id="pen" onclick="changePerson()"></span>
						<br>
					</div>
				</div>
				<span id="alterHead"><img id="alterHeadImg" src="<%=request.getContextPath()%>/image/util/alterHead.jpg"/></span>
				<div id="div4">
					<div id = "div10" class="container">
						<div class="row clearfix">
							<div class="col-md-12 column">
								<ul class="nav nav-tabs">
									<li id="fb" class="active" onclick="myfb()">
										 <a href="#">我的发布</a>
									</li>
									<li id="sc" class="" onclick="mysc()">
										 <a href="#">我的收藏</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div  id="myfb" style="display: ">
						<c:if test="${data[0].topicid != null }">
						<c:forEach items="${data}" var="i">
						<div id="div5">
							<span>标题:<a href="topic?op=detail&topicid=${i.topicid }&boardid=${i.boardid}&pageNum=1">${i.title }</a></span><br>
							<span>发布时间:${i.publishtime }</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>热度:${i.count}</span>
						</div>
						<br>
						</c:forEach>
						</c:if>
						<c:if test="${data[0].topicid == null }">
						<div id="div5">该用户暂未发布任何帖子</div>
						</c:if>
					</div>
					<div  id="mysc" style="display: none">
						<div id="div11">
							
						</div>
					</div>
					<div id="div9">
						<div id="div6" class="box">
							<div id="hisFollow">我关注的人</div>
						</div>
						<div id="div7" class="box">
							<div id="followHis">关注我的人</div>
						</div>
					
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
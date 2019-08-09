<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@ include file="header.jsp"%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<TITLE>论坛--登录</TITLE>
<Link rel="stylesheet" type="text/css" href="style/style.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
<%@ include file="easyui.jsp" %>


<style type="text/css">

#main {
	
	height: 100%;
	width: 100%;
}
#left {
	float:left;
	height: 100%;
	width: 80%;
}
#right {
	float:right;
	height: 100%;
	width: 20%;
}

</style>
<Link rel="stylesheet" type="text/css" href="style/style.css" />


<script type="text/javascript">

		//js轮询，检测当前用户在线状态
		var xmlhttp;
		var myVar = setInterval(function(){checkUser()},1500);
		
		function checkUser(){
			
		var url = "<%=request.getContextPath()%>/ajax.s?op=checkU";
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = checkResult;//
		xmlhttp.open("GET", url, true);//
		xmlhttp.send(null);

		function checkResult() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var rep = xmlhttp.responseText;
					if(rep=="0"){
						
					}else if(rep=="1"){
 				
					}else{
						clearInterval(myVar);
						alert("登陆信息异常：你的账号或在其它设备登陆，请重新登陆!");
						$.ajax({url:"user.s?op=logOut",success:function(result){
							window.location.href="home.jsp";
						}});
	
					}
			}
		}
	}

</script>


</HEAD>

<BODY style="height:100%;width:100%;position: absolute;">

	
	
	<div>
			<%
        				Object obj=application.getAttribute("count");
        				Integer count=1;
        				if(obj==null){
        					application.setAttribute("count", 1);
        				}else{
        					count=(Integer)obj;
        					application.setAttribute("count", ++count);
        				}
        				out.print("当前页面被浏览次数为："+count);
        		%>
	</div>
	<span> 在线人数为：${onlineUsers.size() }人 </span>
	<!--      主体        -->
	<DIV class="t" id="main" style="position: absolute;">
	<div  class="t" id="left" style="position: absolute;">
	
		
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
		<TR class="tr2" align="center">
			<TD colSpan="2">论坛</TD>
			<TD style="WIDTH: 10%;">总贴数</TD>
			<TD style="WIDTH: 30%">最后发表</TD>
		</TR>
		<!--       主版块       -->
		<!-- 记录当前板块 -->
		<%
			String currentBoard = null;
		%>
		<!--       子版块       -->
		<c:forEach items="${data}" var="i">
			<%
				/*获取当前主版块名  */
					Map<String, Object> i = (Map<String, Object>) pageContext.getAttribute("i");
					String pname = (String) i.get("pname");
					String cname = (String) i.get("cname");
					if(cname == null){
						cname = "";
					}
					
			%>
			<%
				//对比当前主版块与显示主版块名
					if (pname.equals(currentBoard) == false) {
						currentBoard = pname;
				
			%>
			<TR class="tr3">
				<TD colspan="4"><%=currentBoard%></TD>
			</TR>
			<%
				}
			%> 
			<TR class="tr3">
				<TD width="5%">&nbsp;</TD>
				<TH align="left"><IMG src="image/board.gif"> <A
					href="topic?op=list&boardid=${i.boardid}&boardname=${i.cname}&pageNum=${param.pageNum}"><%=cname%> </A>
				</TH>
				<c:if test="${i.cnt != NULL }">
					<TD align="center">${i.cnt}</TD>
					<TH><SPAN> <A
							href="topic?op=detail&topicid=${i.topicid }&pageNum=${param.pageNum}">${i.title }</A>
					</SPAN> <BR /> <SPAN>${i.uname }</SPAN> <SPAN class="gray">[
							${i.publishtime }]</SPAN></TH>
				</c:if>
				<c:if test="${i.cnt == null }">
					<TD align="center">0</TD>
					<TH><SPAN>暂无帖子</SPAN></TH>
				</c:if>
			</TR>
		</c:forEach>
	</TABLE>
		
		
		
		
		
	</div>
		
		
		
		
<!-- 		右侧界面 -->
		<div id="right" >
		<div  >
		<TABLE cellSpacing="0" cellPadding="0" style="width: 80%">
			<TR class="tr2" align="center" style="width: 100%">
				<TD >&nbsp;</TD>
				<TD style="WIDTH: 90%;" align="center">热帖TOP5</TD>
				<!-- <TD style="WIDTH: 30%">作者</TD> -->
			</TR>
		<c:forEach items="${data1 }" var="i">
			<TR class="tr3">
				<TD><IMG src="image/topic.gif" border=0></TD>
				<TD style="FONT-SIZE: 15px">
					<A href="topic?op=detail&topicid=${i.topicid }&boardid=${i.boardid }&pageNum=1">${i.title }</A>
					&nbsp;&nbsp;&nbsp;<b style="FONT-SIZE: 7px ;color: gray;align:right">${i.num}回复</b>
				</TD>
				
			</TR>
			<!-- 实现点赞功能 -->
					

				</c:forEach>
				</TABLE>
		</div>
		<div  >
		<TABLE cellSpacing="0" cellPadding="0" style="width: 80%">
			<TR class="tr2" align="center">
				
				<TD colspan="2">风云人物TOP3</TD>
				<!-- <TD style="WIDTH: 30%">作者</TD> -->
			</TR>
		<c:forEach items="${data2}" var="i">
			<TR class="tr3" align="center">
			
			<TD><a href="user.s?op=getUser&uid=${i.uid}"><IMG style="width:50px;height:50px" src="image/head/${i.head }"></a></TD>
				<TD style="FONT-SIZE: 15px">
					<A href="user.s?op=getUser&uid=${i.uid}">${i.uname }</A>
					&nbsp;&nbsp;&nbsp;<b style="FONT-SIZE: 7px ;color: gray;align:right">${i.num}贴</b>
				</TD>
			</TR>
			<!-- 实现点赞功能 -->
					
				</c:forEach>
				</TABLE>
		</div >
		</div>
		
		
	</DIV>
	<CENTER class="gray">源辰信息</CENTER>
	<%@ include file="ad.jsp"%>

	<BR />
	
	
</BODY>
</HTML>

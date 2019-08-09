<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<head>
<meta charset="utf-8">
<TITLE>论坛--帖子列表</TITLE>

<Link rel="stylesheet" type="text/css" href="style/style.css" />
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
</HEAD>





<BODY>

	<style>
		#suc{
			width:300px;
			height:80px;
			background: red;
			position:absolute;
			top:50%;
			left:42%;
			display:none;
		}
	</style>

	<script type="text/javascript" >
	var ff = 0;
	$(function(){
		
		function post(){
			<%String flag = (String)request.getSession().getAttribute("suc");%>
			var flag = <%=flag%>;
				if(flag == "1"){
					$('#suc').attr('src', 'image/post.png');
					$("#suc").fadeIn(1500).fadeOut(1500);
					<%request.getSession().setAttribute("suc", null);%>
				}
		}
		
		if(ff == 0){
			post();
			ff = 1;
		}
		
	});
	</script>

	<img id="suc" src ="" />




<%@ include file="header.jsp" %>


<!--      主体        -->
<DIV>
<!--      导航        -->

<br/>
<%@ include file="nav.jsp" %>
	<div class="msg">
		<font  color="red">${msg}</font>
	</div>
<br/>
<!--      新帖        -->
	<DIV>
		<a href="post.jsp?boardid=${param.boardid }"><IMG src="image/post.gif" name="td_post" border="0" id=td_post></a>
	</DIV>
<!--         翻 页         -->
	<DIV>
		<a href="page?op=listLast&boardid=${param.boardid}&boardname=${param.boardname}&pageNum=${param.pageNum}">上一页</a>
		<a href="page?op=listNext&boardid=${param.boardid}&boardname=${param.boardname}&pageNum=${param.pageNum}">下一页</a>
	</DIV>

	<DIV class="t">
		<TABLE cellSpacing="0" cellPadding="0" width="100%">		
			<TR>
				<TH class="h" style="WIDTH: 100%" colSpan="4"><SPAN>&nbsp;</SPAN></TH>
			</TR>
<!--       表 头           -->
			<TR class="tr2">
				<TD>&nbsp;</TD>
				<TD style="WIDTH: 80%" align="center">文章</TD>
				<TD style="WIDTH: 10%" align="center">作者</TD>
				<TD style="WIDTH: 10%" align="center">回复</TD>
			</TR>
<!--         主 题 列 表        -->
			<c:forEach items="${data}" var="i">
				<TR class="tr3">
					<TD><IMG src="image/topic.gif" border=0></TD>
					<TD style="FONT-SIZE: 15px">
						<A href="topic?op=detail&topicid=${i.topicid }&boardid=${i.boardid}&pageNum=1">${i.title}</A>
					</TD>
					<TD align="center">${i.uname}</TD>
					<TD align="center"> ${i.replycnt} </TD>
				</TR>
			</c:forEach>
		</TABLE>
	</DIV>
<!--            翻 页          -->
	<DIV>
		<a href="page?op=listLast&boardid=${param.boardid}&boardname=${param.boardname}&pageNum=${param.pageNum}">上一页</a>
		<a href="page?op=listNext&boardid=${param.boardid}&boardname=${param.boardname}&pageNum=${param.pageNum}">下一页</a>
	</DIV>
</DIV>
<!--             声 明          -->
<%@ include file="bottom.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<TITLE>论坛--看贴</TITLE>
<Link rel="stylesheet" type="text/css" href="style/style.css" />
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<style type="text/css">
.like {
	font-size: 20px;
	color: #ccc;
	cursor: pointer;
}

.cs {
	color: #f00;
	font-size: 20px;
	cursor: pointer;
}
</style>
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
				function reply(){
					<%String flag = (String)request.getSession().getAttribute("suc");%>
					var flag = <%=flag%>;
					if(flag == "1"&&ff==0){
						$('#suc').attr('src', 'image/reply.png');
						$("#suc").fadeIn(1500).fadeOut(1500);
						<%request.getSession().setAttribute("suc", null);%>
						ff = 1;
					}
				}
				reply();
			});
	</script>

	<img id="suc" src ="" />


	<%@ include file="header.jsp"%>

	<!--      主体        -->
	<DIV>
		<br />
		<!--      导航        -->
		<%@include file="nav.jsp"%>
		<br />
		<!--      回复、新帖        -->
		<DIV>
			<A href="reply.jsp?topicid=${data[0].topicid }"><IMG
				src="image/reply.gif" border="0" id=td_post></A> <A
				href="post.jsp?boardid=${boardid }"><IMG src="image/post.gif"
				name="td_post" border="0" id=td_post></A>&nbsp;&nbsp;&nbsp;<input class="sc" type="button" value="收藏" >
		</DIV>
		<!--         翻 页         -->
		<DIV>
		<a href="page?op=detailLast&topicid=${param.topicid }&pageNum=${param.pageNum}">上一页</a>
		<a href="page?op=detailNext&topicid=${param.topicid }&pageNum=${param.pageNum}">下一页</a>
		</DIV>
		<!--      本页主题的标题        -->
		<DIV>
			<TABLE cellSpacing="0" cellPadding="0" width="100%">
				<TR>
					<TH class="h">本页主题: 灌水</TH>
				</TR>
				<TR class="tr2">
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
		</DIV>

		<!--      主题  +  回复      -->
		<c:forEach items="${data }" var="t">
			<DIV class="t">
				<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed"
					cellSpacing="0" cellPadding="0" width="100%">
					<TR class="tr1">
						<TH style="WIDTH: 20%"><B>${t.uname }</B><BR /> <a href="user.s?op=getUser&uid=${t.uid}"><image
								src="image/head/${t.head }" style="width:100px;height:100px" /></a><BR /><font color="gray">${t.person}</font><BR /></TH>
						<TH>
							<H4 id="title">${t.title }</H4>
							<DIV>${t.content }</DIV>
							<DIV class="tipad gray">
								发表：
								<fmt:formatDate value="${t.publishtime }"
									pattern="yyyy-MM-dd HH:mm" />
								&nbsp; 最后修改:
								<fmt:formatDate value="${t.modifytime }"
									pattern="yyyy-MM-dd HH:mm" />
								<div><p class="like" style="width: 27.2px">&#10084;</p><p class="msg"><b id="count" >${t.count }</b><b>人觉得很赞</b><b id="title" hidden="true">${t.title}</b><b id="uname" hidden="true">${user.uname }</b></p></div>
							</DIV>
						</TH>

					</TR>
				</TABLE>
			</DIV>

		</c:forEach>
		
		<script type="text/javascript">		
		
			$(function() {
				$(".like").each(function() {
					//$(this).removeClass("like")
					var a=0
					var title=$(this).next().children("#title").text()
					var uname=$(this).next().children("#uname").text()
					$.ajax({ //json格式（键值对的形式）
						url:"ZSc.s?op=zan", //服务器地址
						method:"post", //请求方式
						async:false, //是否采用异步请求
						data:{"title":title,"uname":uname}, //请求参数
						dataType:"text", //服务器响应数据的类型
						 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
							 
							
						if(data.trim() == "yes"){ //判断数据是否为空
							a=1
						}else{
							
						}
						}, 
						
						error:function(){ //请求失败的回调函数
						alert("服务器异常...111");
						}
						});
					if(a==1){
						$(this).attr("class","")
						$(this).attr("class","cs")
					}
					
				}); 
				
				$("body").on("click",".like",function(){
					var count =$(this).next().children("#count").text()
					//var title="asd"
					var title=$(this).next().children("#title").text()
					var uname=$(this).next().children("#uname").text()
					
					$(this).removeClass("like")
							$(this).addClass("cs")
							
					//$(this).toggleClass('cs');
						
						 $.ajax({ //json格式（键值对的形式）
							url:"ZSc.s?op=zan", //服务器地址
							method:"post", //请求方式
							async:true, //是否采用异步请求
							data:{"title":title,"count":count,"uname":uname}, //请求参数
							dataType:"text", //服务器响应数据的类型
							 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
							if(data.trim() == "yes"){ //判断数据是否为空
								
							}else if(data.trim() == "login"){
								//count= parseInt(count)-1
								//$(this).next().children("#count").text(count)
								location.href="login.jsp"
								alert("请先登录")
								
								}
							}, 
							
							error:function(){ //请求失败的回调函数
							alert("服务器异常...");
							}
							}); 
						 count= parseInt(count)+1
							$(this).next().children("#count").text(count)
					
				});
				
				
				
				
				$("body").on("click",".cs",function(){
					var count =$(this).next().children("#count").text()
					//var title="asd"
					var title=$(this).next().children("#title").text()
					var uname=$(this).next().children("#uname").text()
					
					$(this).removeClass("cs")
							$(this).addClass("like")
							
					//$(this).toggleClass('cs');
						
						 $.ajax({ //json格式（键值对的形式）
							url:"ZSc.s?op=zan", //服务器地址
							method:"post", //请求方式
							async:true, //是否采用异步请求
							data:{"title":title,"count":count,"uname":uname}, //请求参数
							dataType:"text", //服务器响应数据的类型
							 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
							if(data.trim() == "yes"){ //判断数据是否为空
								
								
							}else{
								//count= parseInt(count)-1
								//$(this).next().children("#count").text(count)
							}
							}, 
							
							error:function(){ //请求失败的回调函数
							alert("服务器异常...");
							}
							}); 
						 count= parseInt(count)-1
							$(this).next().children("#count").text(count)
					
				});
				
				
			
				$(".sc").each(function() {
				//$(this).removeClass("like")
				var a=0
				var title=$(".msg").first().children("#title").text()
				var uname=$(".msg").first().children("#uname").text()
				
				$.ajax({ //json格式（键值对的形式）
					url:"ZSc.s?op=collect", //服务器地址
					method:"post", //请求方式
					async:false, //是否采用异步请求
					data:{"title":title,"uname":uname}, //请求参数
					dataType:"text", //服务器响应数据的类型
					 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
					if(data.trim() == "yes"){ //判断数据是否为空
						a=1
						
						
					}else{
						
					}
					}, 
					
					error:function(){ //请求失败的回调函数
					alert("服务器异常...22");
					}
					});
				if(a==1){
					$(this).attr("class","")
					$(this).attr("class","sc1")
					$(this).val("已收藏")
				}
				
			}); 
			
			})
			
			$("body").on("click",".sc",function(){
					var title=$(".msg").first().children("#title").text()
					var uname=$(".msg").first().children("#uname").text()
					var count =$(".msg").first().children("#count").text()
					$(this).attr("class","")
				$(this).attr("class","sc1")
					$(this).val("已收藏")
				
							
						
						 $.ajax({ //json格式（键值对的形式）
							url:"ZSc.s?op=collect", //服务器地址
							method:"post", //请求方式
							async:true, //是否采用异步请求
							data:{"title":title,"count":count,"uname":uname}, //请求参数
							dataType:"text", //服务器响应数据的类型
							 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
							if(data.trim() == "yes"){ //判断数据是否为空
								
							}else if(data.trim() == "login"){
								//count= parseInt(count)-1
								//$(this).next().children("#count").text(count)
								location.href="login.jsp"
								alert("请先登录")
								
							}
							}, 
							
							error:function(){ //请求失败的回调函数
							alert("服务器异常...");
							}
							}); 
						
					
				});
				$("body").on("click",".sc1",function(){
					var title=$(".msg").first().children("#title").text()
					var uname=$(".msg").first().children("#uname").text()
					var count =$(".msg").first().children("#count").text()
					
				$(this).attr("class","")
				$(this).attr("class","sc")
				$(this).val("收藏")
							
					//$(this).toggleClass('cs');
						
						 $.ajax({ //json格式（键值对的形式）
							url:"ZSc.s?op=collect", //服务器地址
							method:"post", //请求方式
							async:true, //是否采用异步请求
							data:{"title":title,"count":count,"uname":uname}, //请求参数
							dataType:"text", //服务器响应数据的类型
							 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
							if(data.trim() == "yes"){ //判断数据是否为空
								
								
							}else{
								//count= parseInt(count)-1
								//$(this).next().children("#count").text(count)
							}
							}, 
							
							error:function(){ //请求失败的回调函数
							alert("服务器异常...");
							}
							}); 
						
				}); 
			
			</script>
		
		
		<%@ include file="bottom.jsp"%>
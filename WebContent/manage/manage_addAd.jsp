<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="easyui.jsp" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		广告名 &nbsp;<input class="easyui-textbox"  type="text"      maxLength="20" id="adname" >
		<br/>广告图 &nbsp;<input class="easyui-textbox" readonly="readonly" type="text"    id="img">
		
		<a href="#"  id="alterHead" ><input type="button" id="alterHeadImg" value="修改图片" /></a>
		<br/>网&nbsp;址 &nbsp;<input class="easyui-textbox" type="text"  id="href" />
		<br/>点击数 &nbsp;<input class="easyui-textbox" type="text"  id="acount" />
		<br/><input type="button" style="height: 24px;" value="添加广告" onclick="addAd()">
		<script type="text/javascript">
		
		
		
		$(function(){
			$("#alterHead").click(function(){
				var openUrl = "<%=request.getContextPath()%>/alterHead2.jsp";//弹出窗口的url
				var iWidth=500; //弹出窗口的宽度;
				var iHeight=300; //弹出窗口的高度;
				var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
				var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
				window.open(openUrl,"","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft);
			})
		})
		var flag = true;
		function addAd(){
			$("#msg").remove();
			var adname = $("#adname").val();
			var img = $("#img").val();
			var href = $("#href").val();
			var acount = $("#acount").val();
			$("#show").empty(); 
			
			/* $.ajax({url:"manage?op=manageAddAd&adname="+adname+"&img="+img+"&href="+href+"&count=0&acount="+acount,success:function(data){
				if(data.trim() != "yes"){
					$("body").append("<div id='msg' style='color:red;'>添加失败，请确认输入是否正确</div>");
				}else{
					$("body").append("<div id='msg' style='color:;'>添加成功</div>");
				}
				
			  }}); */
			 $.ajax({ //json格式（键值对的形式）
					url:"<%=request.getContextPath()%>/manage?op=manageAddAd", //服务器地址
					method:"post", //请求方式
					async:true, //是否采用异步请求
					data:{"adname":adname,"img":img,"href":href,"acount":acount}, //请求参数
					dataType:"text", //服务器响应数据的类型
					 success:function(data){ //请求成功的回调函数，参数data就是服务器响应的数据
							if(data.trim() != "yes"){
								$("body").append("<div id='msg' style='color:red;'>添加失败，请正确填写并填写完整</div>");
							}else{
								$("body").append("<div id='msg' style='color:;'>添加成功</div>");
							}
					}, 
					
					error:function(){ //请求失败的回调函数
					alert("服务器异常...");
					}
					}); 
		}
		</script>
</body>
</html>
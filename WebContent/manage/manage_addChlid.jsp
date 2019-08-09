<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	response.setContentType("text/javascript;charset=utf-8");
	response.setCharacterEncoding("utf-8");
%>
	<script type="text/javascript">
	
		var flag = true;
		function test(){
			$("#msg").remove();
			if(flag){
				$("#content").val("test");
			}
		}
		
		$(function(){
			$("#msg").remove();
			$.ajax({url:"<%=request.getContextPath()%>/manage?op=getFather",success:function(data){
				if(data != 0){
					var num = $.parseJSON(data);
					$("#combox").combobox("loadData", num);
				}
			}})
		})
		
		function addChild(){
			$("#msg").remove();
			var index = $("#combox").val();
			var content = $("#content").val();
			if(index != "" && content != "请输入添加的板块名"){
				$.ajax({url:"<%=request.getContextPath()%>/manage?op=addChild&index="+index+"&content="+content,success:function(data){
					if(data == 0){
						$("body").append("<div id='msg' style='color:red;'>板块已存在</div>");
					}else if(data == -1){
						$("body").append("<div id='msg' style='color:red;'>添加失败</div>");
					}else{
						$("body").append("<div id='msg' style='color:red;'>添加成功</div>");
						window.location.reload();

					}
					flag = true;
				}})	
			}
		}
	</script>
	<div>请选择要加入的父板块:</div><br>
	<input class="easyui-combobox" id="combox" name="rwlb" style="width:300px" data-options="valueField:'boardid', textField:'boardname', panelHeight:'auto'" >
	<br><br><input type='text' style="color: #CCCCCC;width: 300px;"id='content' onfocus="test()" value='请输入添加的板块名' onclick="input()">
	<input type="button" style="height: 24px;" value="添加" onclick="addChild()">
</body>
</html>
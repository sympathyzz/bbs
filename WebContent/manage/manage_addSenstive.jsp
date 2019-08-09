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
	request.setCharacterEncoding("utf-8");
%>
	
	<script type="text/javascript">
	var flag = true;
	function test(){
		$("#msg").remove();
		if(flag){
			$("#content").val(" ");
		}
	}
	function addSenstive(){
		$("#msg").remove();
		var content = $("#content").val();
		if(content != "" && content != null){
			$.ajax({url:"<%=request.getContextPath()%>/manage?op=addSenstive&content="+content,success:function(data){
				if(data == 0){
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
	<input type='text' style="color: #CCCCCC;width: 300px;"id='content' onfocus="test()" value='请输入需添加的敏感词' onclick="input()">
	<input type="button" style="height: 24px;" value="添加" onclick="addSenstive()"><hr>
</body>
</html>
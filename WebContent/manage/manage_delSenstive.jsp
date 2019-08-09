<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
	var flag = true;
	function test(){
		$("#msg").remove();
		if(flag){
			$("#content").val(" ");
		}
	}
	function delSenstive(){
		$("#msg").remove();
		var content = $("#content").val();
		if(content != "" && content != null){
			$.ajax({url:"<%=request.getContextPath()%>/manage?op=delSenstive&content="+content,success:function(data){
				if(data == 0){
					$("body").append("<div id='msg' style='color:red;'>删除失败</div>");
				}else{
					$("body").append("<div id='msg' style='color:red;'>删除成功</div>");
				}
				flag = true;
			}})	
		}
	}
	</script>
	<input type='text' style="color: #CCCCCC;width: 300px;"id='content' onfocus="test()" value='请输入需添加的敏感词' onclick="input()">
	<input type="button" style="height: 24px;" value="删除" onclick="delSenstive()"><hr>
</body>
</html>
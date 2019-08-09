<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="easyui.jsp" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<script type="text/javascript">
	var flag = true;
	function find(){
		$("#msg").remove();
		var id = $("#content").val();
		$("#show").empty(); 
		$("#msg").remove();
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=manageGetUser&id="+id,success:function(data){
			if(data == -1){
				$("body").append("<div id='msg' style='color:red;'>查询失败，请确认用户名或id输入正确</div>");
			}else{
				$.each($.parseJSON(data),function(k,v){
					var date = new Date(v.regtime);
					var time=  date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()+" ";
					$("#show").append("<img style='width:100px;heigt:80px;' src='image/head/"+v.head+"'/><hr>");
					$("#show").append("用户名:<input  readonly='readonly' value='"+v.uname+"'/><br>");
					$("#show").append("个性签名:<input  readonly='readonly' value='"+v.person+"'/><br>");
					$("#show").append("注册日期:<input  readonly='readonly' value='"+time+"'/><br>");
					if(v.type=='1'){
						$("#show").append('<input type="button" style="height: 24px;" value="取消其管理" onclick="delManage('+v.uid+')">');
					}else{
						$("#show").append('<input type="button" style="height: 24px;" value="添加为管理" onclick="addManage('+v.uid+')">');
					}
					$("#show").append('&nbsp;&nbsp;&nbsp;<input type="button" style="height: 24px;" value="取消" onclick="cance()">');
					flag = true;
				})
			}
			
		  }});
	}
	
	function test(){
		$("#msg").remove();
		if(flag){
			$("#content").val(" ");
		}
	}
	
	function addManage(uid){
		$("#msg").remove();
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=addManage&uid="+uid,success:function(data){
			if(data > 0){
				$("body").append("<div id='msg' style='color:red;'>添加成功</div>");
				$("#show").empty();
			}else{
				$("body").append("<div id='msg' style='color:red;'>添加失败</div>");
			}
			flag = true;
		}
		})
	}
	
	function delManage(uid){
		$("#msg").remove();
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=cencelManage&uid="+uid,success:function(data){
			if(data > 0){
				$("body").append("<div id='msg' style='color:red;'>取消成功</div>");
				$("#show").empty();
			}else{
				$("body").append("<div id='msg' style='color:red;'>取消失败</div>");
			}
			}
		})
	}
	
	function cance(){
		$("#show").empty(); 
	}
</script>
	<input type='text' style="color: #CCCCCC;width: 300px;"id='content' onfocus="test()" value='请输入用户或id查找用户' onclick="input()">
	<input type="button" style="height: 24px;" value="查找" onclick="find()">
	<hr>
	<div id="show" align="center" style="border: 1px double #CCCCCC; height: 300px; width: 600px; margin: 0px auto; text-align: center; line-height: 60px;"></div>
</body>
</html>
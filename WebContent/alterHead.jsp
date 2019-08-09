<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="easyui.jsp" %>
<!DOCTYPE html>

<body>
	<form action="image?op=service" enctype="multipart/form-data" method="post">
		<input type="file" name="img" id="filename">
		<button type="submit" >上传</button>
	</form>
	<script type="text/javascript">
	$(function(){
		var i = "${param.msg}";
		var filename=$("#filename").text()
		var str;
		$('#filename').change(function(){//<input name="" type="file" id="fil"/>
		str=$(this).val();
		 var arr=str.split('\\');//注split可以用字符或字符串分割,\为转义符
			var my=arr[arr.length-1]; 
			window.opener.document.getElementById("img").value = my;
		})
		

		if( i != null && i != ''){
			if(i == 1&&filename!=null){
				
				alert("头像修改成功");
				opener.location.reload();
				window.close();
			}else{
				alert("头像修改失败");
			}
		}
	})
</script>

</body>

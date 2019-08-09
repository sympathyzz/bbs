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
		
		<br/><input type="button" style="height: 24px;" value="删除广告" onclick="delAd()">
		<script type="text/javascript">
		var flag = true;
		function delAd(){
			$("#msg").remove();
			var adname = $("#adname").val();
			
			$("#show").empty(); 
			$("#msg").remove();
			$.ajax({url:"<%=request.getContextPath()%>/manage?op=manageDelAd&adname="+adname,success:function(data){
				if(data.trim() != "yes"){
					$("body").append("<div id='msg' style='color:red;'>删除失败，没有此条广告</div>");
				}else{
					$("body").append("<div id='msg' style='color:;'>删除成功</div>");
				}
				
			  }});
		}
		</script>
</body>
</html>
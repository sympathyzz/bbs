<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<script type="text/javascript">
$(function(){
	$.ajax({url:"<%=request.getContextPath()%>/manage?op=getFather",success:function(data){
		if(data != 0){
			var num = $.parseJSON(data);
			$("#combox_delFather").combobox("loadData", num);
		}
	}})
})

function delFather(){
	$("#msg").remove();
	var index = $("#combox_delFather").val();
	if(index != ""){
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=delFather&id="+index,success:function(data){
			if(data == 1){
				$("body").append("<div id='msg' style='color:red;'>删除成功</div>");
			}else{
				$("body").append("<div id='msg' style='color:red;'>删除失败</div>");
			}
		}})
	}
}
</script>
<div>请选择要删除的父板块:</div><br>
	<input class="easyui-combobox" id="combox_delFather" name="rwlb" style="width:300px" data-options="valueField:'boardid', textField:'boardname', panelHeight:'auto'" >
	<a href="#" onclick="delFather()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="easyui.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">

 

$(function(){
	$("#msg").remove();
	$.ajax({url:"<%=request.getContextPath()%>/manage?op=getFather",success:function(data){
		if(data != 0){
			var num = $.parseJSON(data);
			$("#Fathercombox").combobox("loadData", num);
		}
	}})
})

$(function () {
            $("#Fathercombox").combobox({
                onChange: function (nvalue, ovalue) {
                	
                	$.ajax({url:"<%=request.getContextPath()%>/manage?op=getChild&index="+nvalue,success:function(data){
                		if(data != 0){
                			var num = $.parseJSON(data);
                			$("#Childcombox").combobox("loadData", num);
                		}
                	}})
                }
            });
        })
function delChild(){
	var index = $("#Childcombox").val();
	if(index != ""){
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=delChild&boardid="+index,success:function(data){
			if(data == 1){
				$("body").append("<div id='msg' style='color:red;'>删除成功</div>");
			}else{
				$("body").append("<div id='msg' style='color:red;'>删除失败</div>");
			}
		}})
	}
}

</script>
<div>请选择所属的父板块:</div><br>
	<input class="easyui-combobox"  id="Fathercombox" name="rwlb" style="width:300px" data-options="valueField:'boardid', textField:'boardname', panelHeight:'auto'" >
	<input class="easyui-combobox"  id="Childcombox" name="rwlb" style="width:300px" data-options="valueField:'boardid', textField:'boardname', panelHeight:'auto'" >
	<a href="#" onclick="delChild()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
</body>
</html>
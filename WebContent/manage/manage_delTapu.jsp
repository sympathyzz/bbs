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
var flag = true;
function test(){
	$("#msg").remove();
	if(flag){
		$("#content").val("");
	}
}

function find(){
	var id = $("#content").val();
	if(id != ''){
		$("#show").empty(); 
		$("#msg").remove();
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=manageTapu&id="+id,success:function(data){
			if(data == -1){
				$("body").append("<div id='msg' style='color:red;'>查询失败，请确认用户名或id输入正确</div>");
			}else{
				$.each($.parseJSON(data),function(k,v){
					 $("#Tapuhead").attr("src","<%=request.getContextPath()%>/image/head/"+v.head);
		        	 $("#tapuuname").attr("value",v.uname);
		        	 $("#tapuid").attr("value",v.uid);
		        	 var time1 = gettime(v.taptime);
		        	 var time2 = gettime(v.contime);
		        	 $("#taputaputime").attr("value",time1);
		        	 $("#tapucontime").attr("value",time2);
		        	 $('#delTapu').window('open');
					flag = true;
				})
			}
		  }});
	}
	
}
	function delTapu(){
		var tapUId = $("#tapuid").val();
		alert(tapUId);
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=cencelTapu&uid="+tapUId,success:function(data){
			if(data > 0){
				$("body").append("<div id='msg' style='color:red;'>解禁成功</div>");
				$('#tapu_table').datagrid('reload');
				$('#delTapu').window('close');
			}else{
				$("body").append("<div id='msg' style='color:red;'>解禁失败</div>");
			}
			}
		})
	} 
	
	$(function () {
	     $("#tapu_table").datagrid({
	         onDblClickRow: function (index, row) {
	        	 $("#Tapuhead").attr("src","<%=request.getContextPath()%>/image/head/"+row.head);
	        	 $("#tapuuname").attr("value",row.uname);
	        	 $("#tapuid").attr("value",row.uid);
	        	 var time1 = gettime(row.taptime);
	        	 var time2 = gettime(row.contime);
	        	 $("#taputaputime").attr("value",time1);
	        	 $("#tapucontime").attr("value",time2);
	        	 $('#delTapu').window('open');
	         }
	     });
	    
	 })
	
	function cance(){
		$('#delTapu').window('close');
	}
	
	
	function gettime(value,row,index){
		var date = new Date(value);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
	}
	
	
</script>
	<input type='text' style="color: #CCCCCC;width: 300px;"id='content' onfocus="test()" value='请输入用户或id查找用户' onclick="input()">
	<input type="button" style="height: 24px;" value="查找" onclick="find()">
	<hr>
		<table id="tapu_table" class="easyui-datagrid" style="width:100%;height:100%"  
        data-options="rownumbers:true,fitColumns:true,singleSelect:true,pagination:true,url: '<%=request.getContextPath()%>/manage?op=getTapu',method:'get'">  
   			 <thead>  
       			 <tr>  
		            <th data-options="field:'tapuid',width:20">编号</th>  
		            <th data-options="field:'uname',width:100">被执行人</th>  
		            <th data-options="field:'taptime',width:100,formatter:gettime">禁言时间</th>  
		            <th data-options="field:'contime',width:100,formatter:gettime">禁言期至</th>
		            <th data-options="field:'head',width:100" hidden="true">头像</th>
		            <th data-options="field:'uid',width:100" hidden="true">用户id</th>
       			 </tr>  
    		</thead>  
    	</table>
    	<div id="delTapu" class="easyui-window" closed="true" title="解除禁言" data-options="iconCls:'icon-save',minimizable:false,tools:'#tt'" style="width:400px;height:300px;padding:10px">
			<input type="hidden" id="tapuid" value="">
			<img id="Tapuhead" style='width:100px;heigt:80px;' src=''><hr>
			用户名  :<input id="tapuuname"  readonly='readonly' value=''/><br>
			禁言时间:<input id="taputaputime" readonly='readonly' value=''/><br>
			禁言期至:<input id="tapucontime" readonly='readonly' value=''/><br>
			<input type="button" id="" style="height: 24px;" value="解除禁言" onclick="delTapu()"/>
			&nbsp;&nbsp;&nbsp;<input type="button" style="height: 24px;" value="取消" onclick="cance()"/>
		</div>
</body>
</html>
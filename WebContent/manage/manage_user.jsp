<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/manage.css">
<body id="cc" class="easyui-layout" style="width:100%;height=:100%">
	<script type="text/javascript">
	function getGender(value,row,index){
		if (value==1){
			return "女";
		} else {
			return "男";
		}
	}
	
	function getHead(value,row,index){
		return '<IMG style="height: 60px;" class="userHead" src="<%=request.getContextPath()%>/image/head/'+value+'">';
	}
	
	function getRegtime(value,row,index){
		var date = new Date(value);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()+" ";
	}
	</script>
	<div id="t3" data-options="region:'center',title:'主面板'" 
	style="padding:5px;background: #eee;height: 100%">
		<table class="easyui-datagrid" style="width:100%;height:100%"  
        data-options="url:'<%=request.getContextPath()%>/manage?op=query',fitColumns:true,singleSelect:true,rownumbers:true,pagination:true">  
   			 <thead>  
       			 <tr>  
		            <th data-options="field:'uid',width:20">编号</th>  
		            <th data-options="field:'head',width:100,formatter:getHead">头像</th>  
		            <th data-options="field:'uname',width:100,align:'right'">姓名</th> 
		            <th data-options="field:'regtime',width:100,formatter:getRegtime">注册时间</th> 
		            <th data-options="field:'gender',width:20,formatter:getGender">性别</th>  
       			 </tr>  
    		</thead>  
		</table>  
	</div>	
</body>
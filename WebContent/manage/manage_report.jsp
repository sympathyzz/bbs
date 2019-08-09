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
	$(function () {
	     $("#t2").datagrid({
	         onDblClickRow: function (index, row) {
	        	 $("#reportHead").attr("src","<%=request.getContextPath()%>/image/head/"+row.head);
	        	 $("#reportuname").attr("value",row.uname);
	        	 $("#reportreson").attr("value",row.title);
	        	 $("#reportid").attr("value",row.reportid);
	        	 $("#reportcontent").val(row.content);
	        	 $("#tapuuid").attr("value",row.defenid);
	        	 $('#delReport').window('open');
	         }
	     });
	 })
	
	$(function(){
		var pager = $('#t2').datagrid().datagrid('getPager');
		pager.pagination({
			buttons:[{
				iconCls:'icon-search',
				handler:function(){
					alert('search');
				}
			},{
				iconCls:'icon-add',
				handler:function(){
					alert('add');
				}
			},{
				iconCls:'icon-edit',
				handler:function(){
					alert('edit');
				}
			}]
		});			
	})
	
	function delreport(){
		$("#msg").remove();
		var reportid =  $("#reportid").val();
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=delReport&reportid="+reportid,success:function(data){
				if(data == 1){
					$('#delReport').window('close');
					$("body").append("<div id='msg' style='color:rad'>删除举报信息成功</div>");
				}else{
					$("body").append("<div id='msg' style='color:rad'>删除举报信息失败</div>");
				}
			
			}
		})
	}
	
	function dotapu(){
		 $('#dotapu').window('open');
	}
	
	function gotapu(){
		$("#msg").remove();
		var uid = $("#tapuuid").attr("value");
		var day = $("#day").val();
		var reportid = $("#reportid").attr("value");
		$.ajax({url:"<%=request.getContextPath()%>/manage?op=tapu&uid="+uid+"&day="+day+"&reportid="+reportid,success:function(data){
			if(data == 1){
				$('#dotapu').window('close');
				$('#delReport').window('close');
				$("body").append("<div id='msg' style='color:rad'>禁言成功</div>");
				$('#t2').datagrid('reload');
			}else if(data == '-1'){
				$('#dotapu').window('close');
				$('#delReport').window('close');
				$("body").append("<div id='msg' style='color:rad'>用户已在禁言状态，无需禁言</div>");
			}else{
				$("body").append("<div id='msg' style='color:rad'>禁言失败</div>");
			}
		
		} 
	})
	}
	</script>
	
	<div  data-options="region:'center',title:'主面板'" 
	style="padding:5px;background: #eee;height: 100%">
		<table id="t2" class="easyui-datagrid" style="width:100%;height:100%"  
        data-options="rownumbers:true,fitColumns:true,singleSelect:true,pagination:true,url: '<%=request.getContextPath()%>/manage?op=getReport',method:'get'">  
   			 <thead>  
       			 <tr> 
		            <th data-options="field:'reportid',width:20">编号</th>  
		            <th data-options="field:'uname',width:100">被投诉人</th>  
		            <th data-options="field:'title',width:100">理由</th>  
		            <th data-options="field:'content',width:100" hidden="true">投诉详情</th>
		            <th data-options="field:'head',width:100" hidden="true"></th>
		            <th data-options="field:'defenid',width:100" hidden="true"></th>
		            <th data-options="field:'reportid',width:100" hidden="true"></th>
       			 </tr>  
    		</thead>  
    	</table> 
	</div> 
		<div id="delReport" class="easyui-window" closed="true" title="用户投诉" data-options="iconCls:'icon-save',minimizable:false,tools:'#tt'" style="width:400px;height:300px;padding:10px">
			<input type="hidden" id="reportid" value="">
			<input type="hidden" id="tapuuid" value="">
			<img id="reportHead" style='width:100px;heigt:80px;' src=''><hr>
			用户名  :<input id="reportuname"  readonly='readonly' value=''/><br>
			投诉理由:<input id="reportreson" readonly='readonly' value=''/><br>
			<textarea id="reportcontent" style="width: 300px;height: 200px;" readonly="readonly"></textarea><br>
			<input type="button" id="" style="height: 24px;" value="恶意投诉" onclick="delreport()"/>
			&nbsp;&nbsp;&nbsp;<input type="button" style="height: 24px;" value="用户禁言" onclick="dotapu()"/>
		</div>
		
		<div id="dotapu" class="easyui-window" closed="true" title="解除禁言" data-options="iconCls:'icon-save',minimizable:false,tools:'#tt'" style="width:400px;height:300px;padding:10px">
			<span>请选择禁言时间:</span>
			<select id="day" name="day">
			<option value="1">一小时</option>
			<option value="12">12小时</option>
			<option value="24">一天</option>
			<option value="168">一周</option>
			<option value="720">一个月</option>
			<option value="8760">一年</option>
			</select><br>
			<input type="button" value="确定" onclick="gotapu()">
			<input type="button" value="取消" onclick="cenceltapu()" >
		</div>
<div style="color: red"></div>
</body>
</html>
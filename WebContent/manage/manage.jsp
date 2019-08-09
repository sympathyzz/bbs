<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="easyui.jsp" %>
<script type="text/javascript">
	function getUser_1(){
		var tab = $('#main').tabs("getTab","查看用户");
		if(tab == null){
			$('#main').tabs('add',{
				title:'查看用户',
				selected:true,
				href:'manage_user.jsp',
				closable:true
			});
		}else{
			$('#main').tabs('select','查看用户');
		}
	}

function setManage_1(){
	var tab = $('#main').tabs("getTab","添加管理");
	if(tab == null){
		$('#main').tabs('add',{
			title:'添加管理',
			selected:true,
			href:'manage_addManage.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','添加管理');
	}
}

function report_1(){
	var tab = $('#main').tabs("getTab","用户投诉");
	if(tab == null){
		$('#main').tabs('add',{
			title:'用户投诉',
			selected:true,
			href:'manage_report.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','用户投诉');
	}
}

function tapu_1(){
	var tab = $('#main').tabs("getTab","解除禁言");
	if(tab == null){
		$('#main').tabs('add',{
			title:'解除禁言',
			selected:true,
			href:'manage_delTapu.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','解除禁言');
	}
}

function addFather_1(){
	var tab = $('#main').tabs("getTab","添加父板块");
	if(tab == null){
		$('#main').tabs('add',{
			title:'添加父板块',
			selected:true,
			href:'manage_addFather.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','添加父板块');
	}
}

function addChlid_1(){
	var tab = $('#main').tabs("getTab","添加子板块");
	if(tab == null){
		$('#main').tabs('add',{
			title:'添加子板块',
			selected:true,
			href:'manage_addChlid.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','添加子板块');
	}
}

function delFather_1(){
	var tab = $('#main').tabs("getTab","删除父板块");
	if(tab == null){
		$('#main').tabs('add',{
			title:'删除父板块',
			selected:true,
			href:'manage_delFather.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','删除父板块');
	}
}

function delChlid_1(){
	var tab = $('#main').tabs("getTab","删除子板块");
	if(tab == null){
		$('#main').tabs('add',{
			title:'删除子板块',
			selected:true,
			href:'manage_delChild.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','删除子板块');
	}
}

function addSenstive_1(){
	var tab = $('#main').tabs("getTab","添加敏感词");
	if(tab == null){
		$('#main').tabs('add',{
			title:'添加敏感词',
			selected:true,
			href:'manage_addSenstive.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','添加敏感词');
	}
}


function delSenstive_1(){
	var tab = $('#main').tabs("getTab","删除敏感词");
	if(tab == null){
		$('#main').tabs('add',{
			title:'删除敏感词',
			selected:true,
			href:'manage_delSenstive.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','删除敏感词');
	}
}
function addAd1(){
	var tab = $('#main').tabs("getTab","添加广告");
	if(tab == null){
		$('#main').tabs('add',{
			title:'添加广告',
			selected:true,
			href:'manage_addAd.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','添加广告');
	}
}

function delAd1(){
	var tab = $('#main').tabs("getTab","删除广告");
	if(tab == null){
		$('#main').tabs('add',{
			title:'删除广告',
			selected:true,
			href:'manage_delAd.jsp',
			closable:true
		});
	}else{
		$('#main').tabs('select','删除广告');
	}
}

function SetChildren(children)
{
 $("#_easyui_textbox_input2").val(children);
 $("#img").val(children)
}



	
</script>

<body>

	<div style="margin:20px 0;"></div>
	<div class="easyui-layout" style="width:100%;height:70%;">
		<div data-options="region:'south',split:true" style="height:50px;"></div>
		<div data-options="region:'east',split:true" title="其他" style="width:180px;"></div>
		<div data-options="region:'west',split:true" title="管理界面" style="width:120px;">
			<div class="easyui-accordion"  data-options="fit:true,border:false">
				<div title="用户管理" style="padding:10px;">
					<a href="#" class="easyui-linkbutton" onclick="getUser_1()">查看用户</a><br>
					<a href="#" class="easyui-linkbutton" onclick="setManage_1()">管理员设置</a><br>
					<a href="#" class="easyui-linkbutton" onclick="report_1()">用户投诉</a><br>
					<a href="#" class="easyui-linkbutton" onclick="tapu_1()">解除禁言</a><br>
				</div>
				<div title="板块管理" style="padding:10px;">
					<a href="#" class="easyui-linkbutton" onclick="addFather_1()">添加父板块</a><br>
					<a href="#" class="easyui-linkbutton" onclick="addChlid_1()">添加子板块</a><br>
					<a href="#" class="easyui-linkbutton" onclick="delFather_1()">删除父板块</a><br>
					<a href="#" class="easyui-linkbutton" onclick="delChlid_1()">删除子板块</a><br>
				</div>
				<div title="帖子管理" style="padding:10px;">
					<a href="#" class="easyui-linkbutton" onclick="addSenstive_1()">添加敏感词</a><br>
					<a href="#" class="easyui-linkbutton" onclick="delSenstive_1()">删除敏感词</a><br>
				</div>
				<div title="广告管理" style="padding:10px;">
						<a href="#" class="easyui-linkbutton" onclick="addAd1()">添加广告</a><br>
					    <a href="#" class="easyui-linkbutton" onclick="delAd1()">删除广告</a><br>
				</div>
			</div>
				
		</div>
		<div id="main" class="easyui-tabs" data-options="region:'center',title:'主界面'" style="padding:5px;background:#eee;">
		
		</div>  
	</div>
</body>  

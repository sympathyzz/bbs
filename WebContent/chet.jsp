<%@page import="java.util.TreeSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="com.yc.utils.NumberUtil"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.yc.bean.User"%>
<%@page import="com.yc.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	UserDao ud = new UserDao();
	String toHead = "";
	Map map = ud.getHead(((User)request.getSession().getAttribute("user")).getUid());
	String myHead = (String)map.get("head");
	if(request.getParameter("toname") != null){
		map = ud.getHead(Integer.parseInt(request.getParameter("toname")));
		toHead = (String)map.get("head");
	}
	
%>
<%
List<Map<String,Object>> list = (List<Map<String,Object>>)request.getSession().getAttribute("chatData");
int size;
int[] arr;
Set<Integer> set = new TreeSet();;
if(list != null){
	size = list.size();
	 arr= new int[size];
	for(int i = 0; i < size; i++){
		Map<String,Object> newmap = list.get(i);
		arr[i]=(int)newmap.get("forname");
	}
	 set= NumberUtil.get(arr);
}

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<%@ include file="easyui.jsp" %>
<link rel="stylesheet" type="text/css" href="css/MyCss.css">
<script>
	var forname = "${sessionScope.user.uid}";
	var websocket = null; 
	var toname = "${param.toname}";
	$(function(){
		if ('WebSocket' in window) { 
		    websocket = new WebSocket("ws://47.102.146.182:80/bbs3/websocket/"+forname);  
		} else {  
		    alert('当前浏览器 Not support websocket')  
		}  
		//接收到消息的回调方法  
		websocket.onmessage = function(event) {
			var tohead = "<%=toHead%>";
			$.each($.parseJSON(event.data),function(k,v){
			      if(k=="messgeText"){
			    	  if( tohead == ""){
			    		  tohead = $("#tohead").attr("src");
			    		  $("#content").append("<img class='line'  id='chat' src='"+tohead+"'>"+v+"</img><br>"); 
			    	  }else{
			    		  $("#content").append("<img class='line'  id='chat' src='image/head/"+tohead+"'>"+v+"</img><br>"); 
			    	  }
			      }
			  });
		    
		}
	})
	
	function send(){
		var json = {};
		if(toname==""){
			toname=$("#toIndex").attr("val");
		}
		json .forname = forname;
		json.toname = toname;
        json.msg=msg = $("#msg").val();
        $("#content").append("<div class='line' id='Chat' style='text-align:right'>"+msg+"</div>");
        $(".line").last().append("<img id='chat' src='image/head/<%=myHead%>'></img>");
        var a = JSON.stringify(json);
		websocket.send(a);
		msg = $("#msg").val("")
	}
	
	
	function getMessage(index){
		$("#content").empty();
		var toname = "${sessionScope.user.uid}";
		 $.ajax({url:"socket?op=getRealMessage&forname="+index+"&toname="+toname,success:function(data){
			 $.each($.parseJSON(data),function(k,v){
				 $("#content").append("<img class='line' val='"+index+"' id='toIndex' src='image/head/"+v.head+"'>"+v.messgetext+"</img><br>"); 
			 
			 })
		 }});
		 toname=index;
	}
</script>
<title></title>
<body>
	<div style="margin:20px 0 10px 0;">
		
	</div>
	<div id="p" class="easyui-panel" data-options="footer:'#ft'" title="Basic Panel" style="width:700px;height:300px;padding:10px;">
			<div id="content" style="border: 1px solid red;height: 300px;width:500px;" >
		
			</div>
			
			
			<div  id="userList" >
			<%
		    List<Integer> l = new ArrayList<Integer>(set);
			if(set.size() > 0){
				UserDao u = new UserDao();
				for(int i = 0; i<set.size(); i++){
					int index = l.get(i);
					String src = (String)u.getHead(index).get("head");
					%>
						<a href="#" id="<%=index %>" onclick="getMessage(<%=index%>)"><img id="tohead" src="image/head/<%=src%>"></a>
					<%
				}
			}
			%>
			</div>
			
			<div id="ft" style="padding:5px;">
       	 		<div  style="clear: both;" >
					<textarea id="msg" cols="90" style="width: 500px;border: 1px double #00FFFF;">
					</textarea><br>
					<button id="tun"  onclick="send();"  >发送</button>
				</div>
    		</div>
	</div>
</body>

</html>

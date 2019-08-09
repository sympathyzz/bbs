<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>chat UI</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="author" content="https://blog.csdn.net/q475254344">
    <link href="<%=request.getContextPath()%>/css/mycss0.css" rel="stylesheet">
    <script type = "text/javascript" src="<%=request.getContextPath()%>/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
</head>

<script type="text/javascript">
var websocket = null;
var isOut = 0;

//判断当前浏览器是否支持WebSocket
if ('WebSocket' in window) {
    websocket = new WebSocket("ws://47.102.146.182:80/bbs3/ws/bs");

    //连接成功建立的回调方法
    websocket.onopen = function () {
        websocket.send("客户端链接成功");
        
        //在线人数+1
        //先把自己添加到所有客户端列表里
        
      	login();
        
        //再把除自己外已经上线的用户添加到当前客户端的已上线列表
      	setTimeout("login1()",100);
        
    }

    //接收到消息的回调方法（通过这个方法修改html页面的内容）
    websocket.onmessage = function (event) {
    	
       var data0 = event.data;
       var data = $.parseJSON(data0);
       
       if(data.op == "login"){
    	  	var head = data.user.head;
    	  	var uname = data.user.uname;
    	  	var id = data.user.uid;
    	   
    	  	//更改在线人数
    	 	$("#ou").html(data.cnt);
    	 	
    	 	//用户登陆，添加左侧头像
    	 	$("#userlist").append(
    	 	'<li id = "'+id+'"><a href="user.s?op=getUser&uid='+id+'" target="_blank"><img style="height:70px;width:70px; border-radius: 20px; vertical-align: middle;" src="image/head/'+head+'"></a>'+
    	 	'<span style="margin-left: 10px;"><font color ="blue">'+uname+'</font></span></li>');
    	 	
    	 	 $("#chatField").append('<li class="msgleft" style="color:gray; text-align:center">'+
           			
           			 ' <p class="msgcard" style="color:grap">用户 '+uname+' 进入了聊天室</p>'+
           			 ' </li>');
    	 	
    	 	
    	  //给所有客户端发送消息
       }else if(data.op == "send"){
    		var head = data.user.head;
    	  	var uname = data.user.uname;
    	  	var uid1 = data.user.uid;
    	  	var uid2 = <%=request.getParameter("uid")%>;
    	  	
    	  	//如果是当前客户端，头像在右侧显示
    	  	if(uid1 == uid2){
        	    $("#chatField").append('<li class="msgleft" style="text-align:right">'+
           			 ' <p class="msgcard">'+data.msg+'</p>'+
           			 ' <img style="height:70px; width:70px; border-radius: 20px; vertical-align: top;" src="image/head/'+head+'">'+
           			 ' </li>');
    	  	}else{
    	  		 $("#chatField").append('<li class="msgleft">'+
    	  				 ' <img style=" height:70px; width:70px; border-radius: 20px; vertical-align: top;" src="image/head/'+head+'">'+
               			 ' <p class="msgcard">'+data.msg+'</p>'+
               			 ' </li>');
    	  	}
    	  	
    	  	
    	  	
    	 
       	var div = document.getElementById("panel");
       	div.scrollTop = div.scrollHeight;  
       	
       }else if(data.op == "logout"){
    	   var id = data.user.uid;
    	   var uname = data.user.uname;
    	   $("#chatField").append('<li class="msgleft" style="color:gray; text-align:center">'+
    	   			 ' <p class="msgcard">用户 '+uname+' 退出了聊天室</p>'+
    	   			 ' </li>');
   	  	  
   	  	//更改在线人数
   	 	$("#ou").html(data.cnt);
   	  	$("#"+id+"").remove();
   	  	
       }
    }
     
    //连接发生错误的回调方法
    websocket.onerror = function () {
        //alert("WebSocket连接发生错误");
    };

   //连接关闭的回调方法
    websocket.onclose = function () {
	   if(isOut == 0){
		   logout();
	   }
       
        //关闭后下线，左侧头像消失，在线人线更新
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
    	closeWebSocket();
    	if(isOut == 0){
 		   logout();
 	   }
    }
     
}
else {
    alert('当前浏览器 Not support websocket')
}

//将消息显示在网页上
function setMessageInnerHTML(innerHTML) {
    var bitcoin = eval("("+innerHTML+")");
//     document.getElementById('price').innerHTML = bitcoin.price;
//     document.getElementById('total').innerHTML = bitcoin.total;
}

//关闭WebSocket连接
function closeWebSocket() {
    websocket.close();
    logOut();
}


//点击发送消息给服务器
function send(){
	//发送框里面的内容
	var msg = CKEDITOR.instances.content.document.getBody().getText(); 
	
	var id = <%=request.getParameter("uid")%>;
	
	$.get("<%=request.getContextPath()%>/BitCoinDataCenter?op=send" , {"msg":msg,"uid":id}, 
	function(data){
		CKEDITOR.instances.content.setData("");//发送消息后清空文本
	});
	
	//发送完消息，获得焦点
	var editor = CKEDITOR.instances.content;
	editor.focus();
	
}



//用户上线
function login(){
	var uid = <%=request.getParameter("uid")%>;
	$.get("<%=request.getContextPath()%>/BitCoinDataCenter?op=login" , {"uid":uid},  
		function(data){
		});
}

//用户下线
function logout(){
		var uid = <%=request.getParameter("uid")%>;
		$.get("<%=request.getContextPath()%>/BitCoinDataCenter?op=logout" , {"uid":uid},  
			function(data){
			window.location.href="<%=request.getContextPath()%>/index?op=getIndex";
			isOut = 1;
			});
		
}



function login1(){
	var uid = <%=request.getParameter("uid")%>;
	$.get("<%=request.getContextPath()%>/BitCoinDataCenter?op=login1" , {"uid":uid},  
		function(data0){
				if(data0){
					
					var data = $.parseJSON(data0);
					
					if(data.ous.length>0){
						var ous = data.ous;
						var i = 0;
						for(i = 0;i<ous.length;i++){
							var head = ous[i].head;
							var uname = ous[i].uname;
							var id  = ous[i].uid;
							//由于网络延迟等原因，头像可能会重复加载。这里要先判断，当前头像是否已经加载
							//用户登陆，添加左侧头像
				    	 	$("#userlist").append(
				    	 			'<li id = "'+id+'"><a href="user.s?op=getUser&uid='+id+'" target="_blank"><img style=" height:70px; width:70px; border-radius: 20px; vertical-align: middle;" src="image/head/'+head+'"></a>'+
				    	 	'<span style="margin-left: 10px;">'+uname+'</span></li>');
						}
					}					
				}
		});
}

function exit(){
	logout();
}

function cc()
{
var e = event.srcElement;
var r =e.createTextRange();
r.moveStart('character',e.value.length);
r.collapse(true);
r.select();
}

document.getElementsByTagName('body').height=window.innerHeight;


  
    
</script>
<body class="box">

    <div class="container">
      
            <div class="chatleft">
                <div class="top">
                    <i class="fas fa-bars" style="font-size: 1.4em">在线人数 : &nbsp; <span id = "ou" style="color:blue">1</span></i>
                    
                </div>
                <div class="center" >
                    <ul id = "userlist">
                       
                    </ul>
                </div>
            </div>
            <div class="chatright" style="float:left">
                <div class="top" >
                    <img style="border-radius: 20px; vertical-align: middle;" src=" ">
                    <span style="margin-left: 20px;">多人聊天室</span>
                    <i class="fas fa-ellipsis-v" style="font-size: 1.4em; position: absolute; right: 20px; color: gray;"></i>
                    <div style="height:20px width:100px"></div>
                      <div class="top">
                    <i class="fas fa-bars" style="font-size: 1.4em"></i>
                    <input type="text" placeholder="search" style="width: 140px; height: 36px; margin-left: 25px;">
                    <button class="searchbtn"><i class="fas fa-search">find</i></button>
             		<button class="searchbtn" type="button" onclick="exit()" >exit</i></button>
                </div>
                    
                </div>
                
                <div class="center" style='height:500px;overflow:auto' id="panel" style="float:right">
               
                    <ul id="chatField">
                        
                    </ul>
                  
                </div>
                <div class="footer" style="position:relative">
                	<div id="e" style="height:200px">
                    <textarea id = "content" maxlength="500"  placeholder="请在此输入要发送的内容..."></textarea>
                    </div>
                    <button class="sendbtn" onclick = "send()" type="button" style="position:absolute; bottom:-10px;right:1px; ">发送</button>
                    <script>
               		  	CKEDITOR.replace( 'content',{ height: '100px', width: '100%' });
          			 </script>
                </div>
            </div>
        </div>
</body>
</html>

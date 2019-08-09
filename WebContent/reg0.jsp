<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>注册</title>
<link href="css/log2/css/bootstrap.min.css" rel="stylesheet">
<link href="css/log2/css/gloab.css" rel="stylesheet">
<link href="css/log2/css/index.css" rel="stylesheet">
<script src="js/jquery-1.9.1.js"></script>
<script src="css/log2/js/register.js"></script>
</head>
<body class="bgf4">
<div class="login-box f-mt10 f-pb50">
	<div class="main bgf">    
    	<div class="reg-box-pan display-inline">  
        	<div class="step">        	
                <ul>
                    <li class="col-xs-4 on">
                        <span class="num"><em class="f-r5"></em><i>1</i></span>                	
                        <span class="line_bg lbg-r"></span>
                        <p class="lbg-txt">填写账户信息</p>
                    </li>
                    <li class="col-xs-4">
                        <span class="num"><em class="f-r5"></em><i>2</i></span>
                        <span class="line_bg lbg-l"></span>
                        <span class="line_bg lbg-r"></span>
                        <p class="lbg-txt">验证账户信息</p>
                    </li>
                    <li class="col-xs-4">
                        <span class="num"><em class="f-r5"></em><i>3</i></span>
                        <span class="line_bg lbg-l"></span>
                        <p class="lbg-txt">注册成功</p>
                    </li>
                </ul>
            </div>
        	<div class="reg-box" id="verifyCheck" style="margin-top:20px;">
            	<div class="part1">                	
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>用户名：</span>    
                        <div class="f-fl item-ifo">
                            <input type="text" maxlength="20" class="txt03 f-r3 required" tabindex="1" data-valid="isNonEmpty" data-error="用户名不能为空" id="adminNo" onkeyup="checkUname()"/>                            <span class="ie8 icon-close close hide"></span>
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus" ><span id="check">请输入用户名</span></label>
                            <label class="focus valid"></label>
                    </div>
                    
                    <script>
                    	function checkUname(){
                    		var name = $("#adminNo").val();
                    		$.get("ajax.s?op=check",{"uname":name},function(data){
                    			if(data.trim()==0){
                    				$("#check").html("<font color = 'green'>可以使用</font>");
                    			
                    			}else{
                    				$("#check").html("<font color = 'red'>该用户名已被注册</font>");
                    			}
                    		},"text");
                    	}
                    	
                   
                    </script>
                        
                        
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>手机号：</span>    
                        <div class="f-fl item-ifo">
                            <input type="text" class="txt03 f-r3 required" keycodes="tel" tabindex="2" data-valid="isNonEmpty||isPhone" data-error="手机号码不能为空||手机号码格式不正确" maxlength="15" id="phone" />
                             
                            <span class="ie8 icon-close close hide"></span>                           
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">请填写11位有效的手机号码</label>
                            <label class="focus valid"></label>
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>密码：</span>    
                        <div class="f-fl item-ifo">
                            <input type="password" id="password" maxlength="20" class="txt03 f-r3 required" tabindex="3" style="ime-mode:disabled;" onpaste="return  false" autocomplete="off" data-valid="isNonEmpty||between:6-20" data-error="密码不能为空||密码长度6-20位||" /> 
                            <span class="ie8 icon-close close hide" style="right:55px"></span>
                            <span class="showpwd" data-eye="password"></span>                        
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">6-20位英文（区分大小写）、数字、字符的组合</label>
                            <label class="focus valid"></label>
                            <span class="clearfix"></span>
                            <label class="strength">
                            	<span class="f-fl f-size12">安全程度：</span>
                            	<b><i>弱</i><i>中</i><i>强</i></b>
                            </label>    
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>确认密码：</span>    
                        <div class="f-fl item-ifo">
                            <input type="password" maxlength="20" class="txt03 f-r3 required" tabindex="4" style="ime-mode:disabled;" onpaste="return  false" autocomplete="off" data-valid="isNonEmpty||between:6-16||isRepeat:password" data-error="密码不能为空||密码长度6-16位||两次密码输入不一致" id="rePassword" />
                            <span class="ie8 icon-close close hide" style="right:55px"></span>
                            <span class="showpwd" data-eye="rePassword"></span>
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">请再输入一遍上面的密码</label> 
                            <label class="focus valid"></label>                          
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>验证码：</span>    
                        <div class="f-fl item-ifo">
                            <input type="text" maxlength="4" class="txt03 f-r3 f-fl required" tabindex="4" style="width:167px" id="randcode" data-valid="isNonEmpty" data-error="验证码不能为空" /> 
                             <img id="image01" src="image.jsp" style="height:25px;width:100px" />
							<a href="javascript:void(0)"  onclick="changeImage()"><font color = 'blue'>看不清，换一张</font></a>                   
                        </div>
                    </div>
                    
 <script type="text/javascript">
	function changeImage(){
		document.getElementById("image01").src="image.jsp?" + new Date();
	}
</script>
                    <div class="item col-xs-12" style="height:auto">
                        <span class="intelligent-label f-fl">&nbsp;</span>  
                        <p class="f-size14 required"  data-valid="isChecked" data-error="请先同意条款"> 
                        	<input type="checkbox" checked /><a href="javascript:showoutc();" class="f-ml5">我已阅读并同意条款</a>
                        </p>                       
                        <label class="focus valid"></label> 
                    </div> 
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl">&nbsp;</span>    
                        <div class="f-fl item-ifo">
                           <a href="javascript:;" class="btn btn-blue f-r3" id="btn_part1">下一步</a>                         
                        </div>
                    </div> 
                </div>
                <div class="part2" style="display:none">
                	<div class="alert alert-info" style="width:700px">短信已发送至您手机，请输入短信中的验证码，确保您的手机号真实有效。</div>                    
                    <div class="item col-xs-12 f-mb10" style="height:auto">
                        <span class="intelligent-label f-fl">手机号：</span>    
                        <div class="f-fl item-ifo c-blue">
                           <span id = "p"></span>
                        </div>
                    </div>
                    <div class="item col-xs-12">
                       		<span class="intelligent-label f-fl"><b class="ftx04">*</b>验证码：</span>    
                       
                            <input type="text" maxlength="6" id="code2" tabindex="4" style="width:167px" /> 
                         
                            <button  id="s" style="width:97px;" type="button" >发送验证码</button>
                 			<span id="ccode"></span>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl">&nbsp;</span>    
                        <div class="f-fl item-ifo">
                           <a href="javascript:;" class="btn btn-blue f-r3" id="btn_part2">注册</a>                         
                        </div>
                    </div> 
                </div>
                <div class="part3" style="display:none">
                	<div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>个人说明：</span>    
                        <div class="f-fl item-ifo">
                            <input type="text" maxlength="10" class="txt03 f-r3 required" tabindex="1" data-valid="isNonEmpty||between:2-10" data-error="不能为空||长度2-10位" id="person" />   
                            <span class="ie8 icon-close close hide"></span>                         
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus">确定信息的真实性</label>
                            <label class="focus valid"></label>
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl"><b class="ftx04">*</b>QQ邮箱：</span>    
                        <div class="f-fl item-ifo">
                            <input type="text" class="txt03 f-r3 required" tabindex="2" onkeyup="isEmail()" maxlength="18" id="mail" />    
                                                
                            <label class="icon-sucessfill blank hide"></label>
                            <label class="focus" id="ck">请填写有效的邮箱号码</label>
                            <label class="focus valid"></label>
                        </div>
                    </div>
                    <div class="item col-xs-12">
                        <span class="intelligent-label f-fl">&nbsp;</span>    
                        <div class="f-fl item-ifo">
                           <a href="javascript:;" class="btn btn-blue f-r3" id="btn_part3">下一步</a>                         
                        </div>
                    </div>
                    <span id="msg"><font color = 'red'>${msg}</font></span>
                </div>  
                <div class="part4 text-center" style="display:none">
                	<h3>恭喜您，您已注册成功，现在开始畅游科技论坛吧！</h3>
                    <p class="c-666 f-mt30 f-mb50">页面将在 <strong id="times" class="f-size18">5</strong> 秒钟后，跳转到 <a href="home.jsp" class="c-blue">登陆界面</a></p>
                </div>          
            </div>
        </div>
    </div>
</div>
<div class="m-sPopBg" style="z-index:998;"></div>
<div class="m-sPopCon regcon">
	<div class="m-sPopTitle"><strong>服务协议条款</strong><b id="sPopClose" class="m-sPopClose" onClick="closeClause()">×</b></div>
    <div class="apply_up_content">
    	<pre class="f-r0">
		<strong>同意以下服务条款，提交注册信息</strong>
        </pre>
    </div>
    <input type="hidden" id = "code1"  value="" />
    <center><a class="btn btn-blue btn-lg f-size12 b-b0 b-l0 b-t0 b-r0 f-pl50 f-pr50 f-r3" href="javascript:closeClause();">已阅读并同意此条款</a></center>
</div>
<script>

function isEmail(){
	var re = new RegExp(/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);/*邮箱不区分大小写*/
	if (re.test($("#mail").val())) {
		$("#ck").html("<font color ='green' >可以使用</font>");
	} else {
		$("#ck").html("<font color='red'>邮箱格式不正确</font>");
	}
}

function vcode(){
	
	return true;
}

function pcheck(){
 	var vcode1 = $("#code1").val();
	var vcode2 = $("#code2").val();
	if(vcode1==vcode2){
		$("#ccode").html("<font color ='green' >正确</font>");
		return true;
	}else{
		$("#ccode").html("<font color='red'>验证码错误</font>");
		return false;
	}
}



$(function(){	
	
	$("#s").click(function(){
		var p = $("#p").html();
	
		$.get("ajax.s?op=sendPhoneCode",{"phoneNumber":p},function(data){
			$("#s").attr("disabled", true);
			$("#s").html("已发送");
			$("#code1").val(data.trim());
			
		},"text");
	})
	//第一页的确定按钮
	$("#btn_part1").click(function(){						
		if(!verifyCheck._click()) return;
		//if(!vcode())return;//验证码错误不跳到下一面
		
			var p = $("#phone").val();
            $("#p").html(p);
		$(".part1").hide();
		$(".part2").show();
		$(".step li").eq(1).addClass("on");
	});
	//第二页的确定按钮
	$("#btn_part2").click(function(){			
		if(!verifyCheck._click()) return;
		if(!pcheck())return;
		$(".part2").hide();
		$(".part3").show();	
	});	
	//第三页的确定按钮
	$("#btn_part3").click(function(){
		//最终提交，把数据交给后台处理，成功进入到下一页
		
		var uname = $("#adminNo").val();
		var person = $("#person").val();
		var uno = $("#phone").val();
		var upass = $("#password").val();
		var upass1 = $("#rePassword").val();
		var umail = $("#mail").val();
		
		
		
		$.post("<%=request.getContextPath()%>/user.s?op=newReg",{"uname":uname,"phone":uno,"password":upass,"password1":upass1,"mail":umail,"person":person},function(data){
			if(data.trim()=="0"){

				$(".part3").hide();
				$(".part4").show();
				$(".step li").eq(2).addClass("on");
				
				countdown({
					maxTime:5,
					ing:function(c){
						$("#times").text(c);
					},
					after:function(){
						window.location.href="home.jsp";		
					}
				});	
			}else{
				alert("注册失败");
			}
		},"text");
		
		
	});	
});
function showoutc(){$(".m-sPopBg,.m-sPopCon").show();}
function closeClause(){
	$(".m-sPopBg,.m-sPopCon").hide();		
}
</script>
<div style="text-align:center;">
</div>
</body>
</html>

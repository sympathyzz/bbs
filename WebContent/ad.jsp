<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<style type="text/css">
.img1 {
	position: absolute;
	left: 210px;
	top: 0px;
}

.img2 {
	position: absolute;
	left: 550px;
	top: 0px;
}

/* .img3 {
	position: fixed;
	right: 0px;
	bottom: 0px;
	z-index: 999999;
} */
.float_layer {
	width: 300px;
	border: 1px solid #aaaaaa;
	display: none;
	background: #fff;
}

.float_layer h2 {
	height: 25px;
	line-height: 25px;
	padding-left: 10px;
	font-size: 14px;
	color: #333;
	background: url(image/title_bg.gif) repeat-x;
	border-bottom: 1px solid #aaaaaa;
	position: relative;
}

.float_layer .min {
	width: 21px;
	height: 20px;
	background: url(image/min.gif) no-repeat 0 bottom;
	position: absolute;
	top: 2px;
	right: 25px;
}

.float_layer .min:hover {
	background: url(image/min.gif) no-repeat 0 0;
}

.float_layer .max {
	width: 21px;
	height: 20px;
	background: url(image/max.gif) no-repeat 0 bottom;
	position: absolute;
	top: 2px;
	right: 25px;
}

.float_layer .max:hover {
	background: url(image/max.gif) no-repeat 0 0;
}

.float_layer .close {
	width: 21px;
	height: 20px;
	background: url(image/close.gif) no-repeat 0 bottom;
	position: absolute;
	top: 2px;
	right: 3px;
}

.float_layer .close:hover {
	background: url(image/close.gif) no-repeat 0 0;
}

.float_layer .content {
	height: 160px;
	overflow: hidden;
	font-size: 14px;
	line-height: 18px;
	color: #666;
	text-indent: 28px;
}

.float_layer .wrap {
	padding: 10px;
}
</style>

<script type="text/javascript">
	function miaovAddEvent(oEle, sEventName, fnHandler) {
		if (oEle.attachEvent) {
			oEle.attachEvent('on' + sEventName, fnHandler);
		} else {
			oEle.addEventListener(sEventName, fnHandler, false);
		}
	}
	window.onload = function() {
		var oDiv = document.getElementById('miaov_float_layer');
		var oBtnMin = document.getElementById('btn_min');
		var oBtnClose = document.getElementById('btn_close');
		var oDivContent = oDiv.getElementsByTagName('div')[0];
		var iMaxHeight = 0;
		var isIE6 = window.navigator.userAgent.match(/MSIE 6/ig)
				&& !window.navigator.userAgent.match(/MSIE 7|8/ig);
		oDiv.style.display = 'block';
		iMaxHeight = oDivContent.offsetHeight;
		if (isIE6) {
			oDiv.style.position = 'absolute';
			repositionAbsolute();
			miaovAddEvent(window, 'scroll', repositionAbsolute);
			miaovAddEvent(window, 'resize', repositionAbsolute);
		} else {
			oDiv.style.position = 'fixed';
			repositionFixed();
			miaovAddEvent(window, 'resize', repositionFixed);
		}
		oBtnMin.timer = null;
		oBtnMin.isMax = true;
		oBtnMin.onclick = function() {
			startMove(oDivContent, (this.isMax = !this.isMax) ? iMaxHeight : 0,
					function() {
						oBtnMin.className = oBtnMin.className == 'min' ? 'max'
								: 'min';
					});
		};
		oBtnClose.onclick = function() {
			oDiv.style.display = 'none';
		};
	};
	function startMove(obj, iTarget, fnCallBackEnd) {
		if (obj.timer) {
			clearInterval(obj.timer);
		}
		obj.timer = setInterval(function() {
			doMove(obj, iTarget, fnCallBackEnd);
		}, 30);
	}
	function doMove(obj, iTarget, fnCallBackEnd) {
		var iSpeed = (iTarget - obj.offsetHeight) / 8;
		if (obj.offsetHeight == iTarget) {
			clearInterval(obj.timer);
			obj.timer = null;
			if (fnCallBackEnd) {
				fnCallBackEnd();
			}
		} else {
			iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
			obj.style.height = obj.offsetHeight + iSpeed + 'px';
			((window.navigator.userAgent.match(/MSIE 6/ig) && window.navigator.userAgent
					.match(/MSIE 6/ig).length == 2) ? repositionAbsolute
					: repositionFixed)()
		}
	}
	function repositionAbsolute() {
		var oDiv = document.getElementById('miaov_float_layer');
		/* var left=document.body.scrollLeft||document.documentElement.scrollLeft;
		var top=document.body.scrollTop||document.documentElement.scrollTop;
		var width=document.documentElement.clientWidth;
		var height=document.documentElement.clientHeight; */
		oDiv.style.right = 0 + 'px';
		oDiv.style.bottom = 0 + 'px';
	}
	function repositionFixed() {
		var oDiv = document.getElementById('miaov_float_layer');
		/* var width=document.documentElement.clientWidth;
		var height=document.documentElement.clientHeight; */
		oDiv.style.right = 0 + 'px';
		oDiv.style.bottom = 0 + 'px';
	}
</script>



	<%-- <DIV>
		<IMG src="image/logo.gif" height="78" width="200">
	</DIV>
<a id="dd" href="http://www.hyycinfo.com/Examination2.0/" target="_blank" >
<IMG class="img1" src="image/花千骨.jpg" height="78" width="319" id="d2" >
		</a>
	
	<IMG class="img2" src="image/贪玩蓝月.gif" height="78" width="319"
		onclick='window.open("https://d.mytanwan.com/h/19902.html?cplaceid=84541669.3062116780.79575640352")'>
	<!-- <IMG class="img3" src="image/花千骨.jpg"> -->
	<script type="text/javascript">
		var i = 0;
		var imagesName = [ "image/北大青鸟.jpg","image/手表.jpg", "image/花千骨.jpg" ];
		function changeimg() {
			tid = setInterval(function() {
				d2.src = imagesName[i];
				i++;
				if (i == 3) {
					i = 0;
				}
			}, 2000);
		}

		changeimg();

		var set = document.getElementById('d2');
		var set1 = document.getElementById('dd');
		set.onmouseover = function() {
			if(i ==0){
				set1.href="http://hqg.skymoons.com/";
			}
			if(i==1){
				set1.href="http://www.bdqnvip.wang/zt/zt_95.html?xbd&a-bdqn&2230#01";
			}	
			if(i==2){
				set1.href="https://www.wbiao.cn/";
			}	
			clearInterval(tid);

		}
		set.onmouseout = function() {
			changeimg();
		}
		
	</script>
	<!--      用户信息、登录、注册        -->

	<DIV class="h">
		<c:if test="${user==null }">
					您尚未登录&nbsp;<a href="login.jsp">登录</a>
		</c:if>
		<c:if test="${user!=null }">
					欢迎${user.uname }&nbsp;&nbsp;&nbsp;
	<a href="loginout.jsp">注销</a>
		</c:if>
		&nbsp;|&nbsp;<A href="reg.jsp">注册</A>
	</DIV> --%>



	<div class="float_layer" id="miaov_float_layer" style="z-index: 99999; ">
		<h2>
			<strong>脚本之家</strong> <a id="btn_min" href="javascript:;" class="min"></a>
			<a id="btn_close" href="javascript:;" class="close"></a>
		</h2>
		<div class="content">
			<div class="wrap">
				<strong>脚本之家是国内专业的网站建设资源、脚本编程学习类网站，提供asp、php、asp.net、javascript、jquery、vbscript、dos批处理、网页制作、网络编程、网站建设等编程资料</strong>脚本特效下载地址：
				<!-- <address>//www.jb51.net/jiaoben/</address> -->
				<a href="http://www.jb51.net/jiaoben/" target="_blank">//www.jb51.net/jiaoben/</a>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
	<script>
		$(function(){
			$("#miaov_float_layer").slideDown(1000,function(){
				$("#miaov_float_layer").fadeOut(1000,function(){
					$("#miaov_float_layer").fadeIn(1000);
				});
			});
		});
	</script>
	
	
	
	
	
	
	


	<div id="codefans_net" style="z-index: 9999; position: absolute" >
		<!--链接地址-->
		<div style=" position: absolute;top: 0px;right: 0px " >
		<img src="image/关闭.PNG" border="0" height="20px" width="20px" id="aclose"></div>
		<a href="http://www.hyycinfo.com/Examination2.0/" target="_blank"> <!--图片地址--> <img src="image/logo.gif"
			border="0">
		</a>
	</div>
	<script>
		var x = 50, y = 60
		var xin = true, yin = true
		var step = 1
		var delay = 10
		var obj = document.getElementById("codefans_net")
		var close = document.getElementById("aclose")
		var ddiv = document.getElementById("ddiv")
		function float() {
			var L = T = 0
			var R = document.body.clientWidth - obj.offsetWidth
			var B = document.body.clientHeight - obj.offsetHeight
			obj.style.left = x + document.body.scrollLeft + "px"
			obj.style.top = y + document.body.scrollTop + "px"
			x = x + step * (xin ? 1 : -1)
			if (x < L) {
				xin = true;
				x = L
			}
			if (x > R) {
				xin = false;
				x = R
			}
			y = y + step * (yin ? 1 : -1)
			if (y < T) {
				yin = true;
				y = T
			}
			if (y > B) {
				yin = false;
				y = B
			}
		}
		var itl = setInterval("float()", delay)
		obj.onmouseover = function() {
			clearInterval(itl)
		}
		obj.onmouseout = function() {
			itl = setInterval("float()", delay)
		}
		close.onclick = function() {
			obj.style.display = 'none';
		}
	</script>

	<BR />
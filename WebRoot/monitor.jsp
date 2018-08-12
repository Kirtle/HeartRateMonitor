<%@ page language="java" import="java.util.*" import="cn.jaeblog.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
	<title>Monitor</title>
	<link rel="stylesheet" type="text/css" href="css/htmleaf-demo.css">
	<script src="js/jquery-1.11.1.js"></script>
	<!--<link rel="stylesheet" href="css/bootstrap.css">-->
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/mui.min.css">
	<link rel="stylesheet" href="css/progress.css">
	<link rel="stylesheet" href="css/kontext.css">
	<link rel="stylesheet" href="css/demo.css">
	<link rel="stylesheet" href="css/iconfont.css">
	<link rel="stylesheet" href="css/sm.min.css">
	<link rel="stylesheet" href="css/sm-extend.min.css">
	<script src="js/echarts.min.js"></script>

	<!--[if IE]>
		<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
	<![endif]-->
	<style type="text/css">
		.pie_progress {
			width: 130px;
			margin: 10px auto;
		}
		@media all and (max-width: 768px) {
			.pie_progress {
				width: 65%;
				max-width: 300px;
			}
		}
		.mui-input-group label {
			width: 22%;
		}
		.mui-input-row label~input,
		.mui-input-row label~select,
		.mui-input-row label~textarea {
			width: 78%;
		}
		.mui-checkbox input[type=checkbox],
		.mui-radio input[type=radio] {
			top: 6px;
		}
		.monitor{
			width: 100%;
			position: absolute;
			top: 50%;
			left: 0;
			-webkit-transform: translateY(-50%);
			-ms-transform: translateY(-50%);
			-o-transform: translateY(-50%);
			transform: translateY(-50%);
			font-size: 42px;
		}
		.btn-info {
			color: #fff;
			background-color: #5bc0de;
			border-color: #46b8da;
		}
		.text-primary {
			color: #337ab7;
		}
		a{
			text-decoration:none;
		}
		.cont_principal2 a:hover {color:gray;}
		.cont_principal2 a:visited {color:gray;}
		.cont_principal2 a:link {color:#5bc0de;}
		.cont_principal2 a:active  {color:#5bc0de;}
	</style>
	<style>

		.mui-input-group label {
			width: 22%;
		}
		.mui-input-row label~input,
		.mui-input-row label~select,
		.mui-input-row label~textarea {
			width: 78%;
		}
		.mui-checkbox input[type=checkbox],
		.mui-radio input[type=radio] {
			top: 6px;
		}
		.layer p {
			position: relative;
			top: 0;
			margin: 0;
		}
	</style>
	<style>
		 .table-view:first-child {
			margin-top: 15px;
		}
		 .table-view:last-child {
			margin-bottom: 30px;
		}
		.table-view {
			margin-top: 20px;
			background-color: whitesmoke;
			opacity: 0.7;
		}
	</style>
</head>
<body>
<article class="kontext">
	<div class="layer one show">
		<div class="htmleaf-container">
			<div class="bgstyle"></div>
			<div class="cont_principal2">
				<a href="" style="float: left;margin: 2%"><span class="mui-icon iconfont icon-lishi"></span></a> <a href="" style="float: right;margin: 2%"><span class="mui-icon mui-icon-person"></span></a>
				<div style="height: 15%">

				</div>
				<h4 class="text-primary text-center" style="color:#49D1EC">请将检测器放在手指上；点击开始进行监测！</h4>
				<br>
				<div class="pie_progress" role="progressbar" data-goal="100" aria-valuemin="0" aria-valuemax="100">
					<span class="monitor text-primary" id="userRates">000<sub>bpm</sub></span>
				</div>
				<br>
				<br>
				<div  class="text-center">
					<button id="button_start" class="btn-info" style="margin-right: 5%" onclick="getRate(),saveRates();">开始</button>
					<button id="button_reset" class="btn-info" onclick="clear()">复原</button>
				</div>
			</div>
		</div>
	</div>
	<div class="layer two">
		<div class="htmleaf-container">
			<div class="bgstyle"></div>
			<div class="cont_principal2 ">
				<a href="" style="float: left;margin: 2%"><span class="mui-icon mui-icon-home"></span></a> <a href="" style="float: right;margin: 2%"><span class="mui-icon iconfont icon-lishi"></span></a>
				我
				<ul class=" table-view" style="">
					<li class="mui-table-view-cell">
						<p style="float: left;color:#1a1a1a;font-size:110%;margin-top: 6%;">头像</p>
						<a class="mui-pull-right head"  style="color: #3d4145">
								<img class="head-img mui-action-preview" id="head-img1" src="img/heart.png"/>
						</a>
					</li>
					<li class="mui-table-view-cell">
						<p style="float: left;color:#1a1a1a;font-size:110%">账号</p><a class="mui-pull-right">${user.uname}</a>
					</li>
					<li class="mui-table-view-cell">
						<p style="float: left;color:#1a1a1a;font-size:110%">手机</p><a class="mui-pull-right" >${user.uphone}</a>
					</li>
				</ul>
				<ul class="table-view">
					<li class="mui-table-view-cell" style="text-align: center;">
						<a onclick="logout()">退出登录</a>
					</li>
				</ul>
			</div>
		</div>


	</div>
	<div class="layer three">
		<div class="htmleaf-container">
			<div class="bgstyle"></div>
			<div class="cont_principal2">
				<a href="" style="float: left;margin: 2%"><span class="mui-icon mui-icon-person"></span></a> <a href="" style="float: right;margin: 2%"><span class="mui-icon mui-icon-home"></span></a>
				<span style="margin-left: -17%" >历史记录</span>
				<span  style="float: left;margin-top: 7%;">单位:bpm</span>
				<div id="chart" style="width:100% ;height:50%;">
				</div>
				<p style="margin-top: -7%;color:#474749">最近10次数据显示</p>
				<!-- <h4 class="" style="float: right;">平均<span style="color: #0a8ddf;font-size: 35px;font-family: 微软雅黑;">89</span></h4> -->

			<c:choose>
				<c:when test="${hrms!=null && fn:length(hrms)>0 }">
					<c:forEach items="${hrms}" var="hrms">
						<div style="background-color: white;width:100%;height: 12%;opacity:0.7;margin-top:14%;">
							<img src="img/heart.png" alt="" style="float:left;padding-left: 5%;padding-right: 5%; padding-top: 5.5%;height:80%">
							<h4  style="padding-left: 3%; padding-top: 3%;height:50%;color: #3398DB;margin-left: 13%;
			   width: 35%;">静息心率</h4>
							<h5 class="" style="padding-left: 3%; padding-bottom: 3%;height:50%;margin-left: 13%;
			   width: 44%;">2017年6月6日14:20</h5>
							<h3 class="" style="float:right; margin-top: -18%;color: #F46739">${hrms.heartrate}</h3>
						    <input type="hidden" class="hearts" value="${hrms.heartrate}">
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
				</c:otherwise>
				
			</c:choose>
				
				<script type="text/javascript">
					 var hearts=$(".hearts");
					/*  var mValue='[';
					 for(var i=0;i<hearts.length;i++){
						 if(i!=0){
							 mValue=mValue+',';
						 }
						mValue=mValue+$(hearts[i]).val();
					 }
					 mValue=mValue+']';
					 console.log(mValue); */
					 var mValue=new Array();
					 for(var i=0;i<hearts.length;i++){
						 
						mValue[i]=$(hearts[i]).val();
					 }
					 
					 console.log(mValue);
				 var myChart = echarts.init(document.getElementById('chart'));
                    option = {
                        title: {
                            // text: '',
                           // subtext: '单位:bpm'
                        },
                        tooltip: {
                            trigger: 'axis'
                        },
                        legend: {
                            data:['bpm']
                        },
                        toolbox: {
                            show: true,
                            feature: {
                                /*dataZoom: {
                                    yAxisIndex: 'none'
                                },*/
                               /* dataView: {readOnly: true},*/
                                magicType: {type: ['line', 'bar']},
                                restore: {},
                                saveAsImage: {}
                            }
                        },
                        xAxis:  {
                            type: 'category',
                            boundaryGap: false,
                            data: ['', '', '', '', '', '', '','','','']
                        },
                        yAxis: {
                            type: 'value',
                            axisLabel: {
                                formatter: '{value}'
                            }
                        },
                        series: [
                            {
                                name:'心率值',
                                type:'line',
                               data: mValue,
                              // data:[70, 78, 80, 77, 75, 79, 86,75,83,78],
                                markPoint: {
                                    data: [
                                        {type: 'max', name: '最大值'},
                                        {type: 'min', name: '最小值'}
                                    ]
                                },
                                markLine: {
                                    data: [
                                        {type: 'average', name: '平均值'}
                                    ]
                                }
                            },

                        ]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    //option.series.data=mValue;
                    myChart.setOption(option);
				</script>
			</div>
		</div>
	</div>
			</div>
		</div>
	</div>
</article>
<ul class="bullets" style="display: none">
</ul>

<script src="js/kontext.js"></script>
		<script type="text/javascript" src="js/rainbow.min.js"></script>
		<script type="text/javascript" src="js/jquery-asPieProgress.js"></script>

		<script type="text/javascript">
            jQuery(document).ready(function($) {

                $('.pie_progress').asPieProgress({
                    namespace: 'pie_progress',
                    goal: 1000,
                    min: 0,
                    size:120,
                    max: 1000,
                    speed: 800,
                    easing: 'linear'
                });
                $('#button_start').on('click', function () {
                    $('.pie_progress').asPieProgress('start');
                });

                $('#button_reset').on('click', function () {
                    $('.pie_progress').asPieProgress('reset');
                });
            });
		</script>

		<script type="text/javascript">
            var k = kontext( document.querySelector( '.kontext' ) );
            var bulletsContainer = document.body.querySelector( '.bullets' );
            for( var i = 0, len = k.getTotal(); i < len; i++ ) {
                var bullet = document.createElement( 'li' );
                bullet.className = i === 0 ? 'active' : '';
                bullet.setAttribute( 'index', i );
                bullet.onclick = function( event ) { k.show( event.target.getAttribute( 'index' ) ) };
                bullet.ontouchstart = function( event ) { k.show( event.target.getAttribute( 'index' ) ) };
                bulletsContainer.appendChild( bullet );
            }

            // Update the bullets when the layer changes
            k.changed.add( function( layer, index ) {
                var bullets = document.body.querySelectorAll( '.bullets li' );
                for( var i = 0, len = bullets.length; i < len; i++ ) {
                    bullets[i].className = i === index ? 'active' : '';
                }
            } );

            document.addEventListener( 'keyup', function( event ) {
                if( event.keyCode === 37 ) k.prev();
                if( event.keyCode === 39 ) k.next();
            }, false );

            var touchX = 0;
            var touchConsumed = false;

            document.addEventListener( 'touchstart', function( event ) {
                touchConsumed = false;
                lastX = event.touches[0].clientX;
            }, false );

            document.addEventListener( 'touchmove', function( event ) {
            	clearTimeout(timer);
            	findRate2();
                event.preventDefault();

                if( !touchConsumed ) {
                    if( event.touches[0].clientX > lastX + 10 ) {
                        k.prev();
                        touchConsumed = true;
                    }
                    else if( event.touches[0].clientX < lastX - 10 ) {
                        k.next();
                        touchConsumed = true;
                    }
                }
            }, false );
		</script>
		<script type="text/javascript">
		var timer;//同步数据，定时器对象
	    function getRate(){
	     //bpm=$("h2#userRate").val();//心率值BPM;
	     		//console.log(but);
	    		var url='<%=request.getContextPath()%>'+"/user/monitor.getRate";
	    		 $.ajax({
	                 async:true,
	                 data:"{}",
	                 url:url,
	                 type:"post",
	                 dataType:"json",
	                 error:function(){
	                	 clearTimeout(timer);
	                	 //alert("网络异常");
	                 },
	                 success:function (data){
	                	// for(var i=0;i<data.length;i++)
	                	// bpm=data.(userRate+i);
	                	 //alert("心率字符串="+data.monitorRate+"|"+bpm);
	                       console.log("心率值="+data.userRate);
	                       var rate =  document.getElementById("userRates");
	                       rate.innerHTML=data.userRate+"<sub>bpm</sub>";
	                       //alert(rate.innerHTML);//2017年6月11日00:26:32
	                       //alert(rate.value);
	                       //but.parent().siblings("#qwe").children().children("#userRates").val('1');
	                        // $("#userRates").val('');
	                         //$("#rateNum").attr("value",'');
	                         //$("#rateNum").attr("value",'test');
	                       $("#userRates").val(data.userRate);
	                 }
	             });
	    		timer = setTimeout("getRate()",1000);
	    	}
	    function saveRates(){
			var url='<%=request.getContextPath()%>'+"/user/monitor.saveRate";
			 $.ajax({
	             async:true,
	             data:"{}",
	             url:url,
	             type:"post",
	             dataType:"json",
	             error:function(){
	            	 //alert("网络异常");
	             },
	             success:function (data){
	             }
	         });
		}
	    function clear(){
	    	 clearTimeout(timer);
	    }
	    function logout() {
	        $.ajax({
	            url:"user/logout.do",
	            method:"post",
	            success:function () {
	                location.href="http://localhost:8010/HeartRateMonitor/index.jsp"
	                alert("退出成功");
	            },
	            error:function () {
	                location.reload();
	                alert("退出失败");
	            }
	        })
	    }
	    
	    function findRate2(){
	    	$.ajax({
	    		url:'<%=request.getContextPath()%>'+"/user/findRate",
	    		method:"post",		
	    		success: function(){
	    console.log("success");			
	    		},
	    		error:function(){
	    			console.log("error");	
	    		}
	    	})
	    	return false;
	    }
	    
	    jQuery(document).ready(function($) {
	    /* $('#button_start').click(getRate());
	    $('#button_start').click(saveRates()); */
	    /* $('#button_reset').click(clear()); */
	    });
	   
		</script>
</body>
</html>
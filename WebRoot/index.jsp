<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<title>login</title>
	<link rel="stylesheet" type="text/css" href="css/htmleaf-demo.css">
	<link rel='stylesheet prefetch' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/styles2.css">
	<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
	<!--[if IE]>
		<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
	<![endif]-->
	<style>
		.login-html .tab {
			font-size: 16px;
			padding: 0 5px 0 0;
			margin: 0 15px 10px 0px;
			display: inline-block;
			border-bottom: 2px solid transparent;
		}
		label.tab.label1 {
			padding-right: 0;
			margin-right: 0;
		}
		.pstyle{
			font-size: 20px;
		}
	</style>
</head>
<body>

	<div class="htmleaf-container">
		<div class="cont_principal">
			<header class="htmleaf-header">
			</header>
		  <div class="cont_join  ">
		    <div class="cont_letras">
		      <p class="pstyle">LISTEN</p>
		      <p class="pstyle">TO</p>
		      <p class="pstyle">HEARTBEAT</p>
		    </div>
			  <div class="login-wrap cont_form_join">
				  <h3>JOIN</h3>
				  <div class="login-html">
					  <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Login</label>
					  <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab label1">Register</label>
					  <div class="login-form">
						  <div class="sign-in-htm">
							  <div class="group">
								  <p style="float: left;margin-left:-25%;margin-top:6%;">账号</p>
								  <input name="uname" id="account"  type="text" class="input_text" />
							  </div>
							  <div class="group">
								  <p style="float: left;margin-left:-25%;margin-top:6%;">密码</p>
								  <input name="upwd" id="password" type="password" class="input_text" />
							  </div>

							  <div class="group">
								  <input type="submit" class="button" value="Login"  onclick='dologin();'>
							  </div>
						  </div>
						  <div class="sign-up-htm"><!-- -----------------注册页面 -->
							  <form   id="registerForm" method="post">
							  	<div class="group">
								  <p style="float: left;margin-left:-25%;margin-top:6%;">账号</p>
								  <input id="uname" name="uname" type="text" class="input_text" />
							  </div>
							  <div class="group">
								  <p style="float: left;margin-left:-25%;margin-top:6%;">密码</p>
								  <input id='upwd' name="upwd" type="password" class="input_text" />
							  </div>
							  <div class="group">
								  <p style="float: left;margin-left:-25%;margin-top:6%;">确认</p>
								  <input  id='password_confirm' type="password" class="input_text" />
							  </div>
							  <div class="group">
								  <p style="float: left;margin-left:-25%;margin-top:6%;">手机</p>
								  <input id='uphone' name="uphone" type="text" class="input_text" />
							  </div>
							  <div class="group">
								  <input type="submit" class="button " value="Register" onclick="doReg()">
							  </div>
							  </form>
							  <div class="hr"></div>
						  </div>
					  </div>
				  </div>
			  </div>

		    <div class="cont_join_form_finish">
		      <h2>Finish <i class="material-icons">&#xE5CA;</i></h2>  
		    </div>

		    <div class="cont_btn_join">
		      <a href="#" onclick='join_1()'>JOIN</a>
		    </div>
		  </div>
		</div>
	</div>
<script type="text/javascript">
    var t = 0;
    function join_1(){
        if(t == 0){  document.querySelectorAll('.cont_letras > p')[0].style.left = '200px';
            document.querySelectorAll('.cont_letras > p')[1].style.left = '-320px';
            document.querySelectorAll('.cont_letras > p')[2].style.left = '200px';
            document.querySelector('.cont_btn_join').style.display = 'none';
            setTimeout(function(){
                document.querySelector('.cont_join').className = 'cont_join cont_join_form_act';
            },500);
            t++;
        }else{
            t++;
            document.querySelector('.cont_form_join').style.bottom = '-430px';
            setTimeout(function(){
                    document.querySelector('.cont_join').className = 'cont_join cont_join_form_act cont_join_finish';
                }
                ,500);
        }
    }
	//ajax 验证
    function dologin(){
    	var user_name=$("#account").val();
    	var user_pwd=$("#password").val();
    	if(user_name==""||user_pwd==""){
    		alert("请输入用户名或密码");
    	}else{
    		var url='<%=request.getContextPath()%>'+"/user/login.do";
    		 $.ajax({
                 async:true,
                 data:{"uname":user_name,"upwd":user_pwd},
                 url:url,
                 type:"post",
                 dataType:"json",
                 error:function(){
                	 alert("网络异常");
                 },
                 success:function(data){
                	 alert(data.message);
                	 if(data.message=="登录成功")
                	 location.href='<%=request.getContextPath()%>'+"/monitor.jsp";
                	// $(".mui-content-padded").hide();
                 }
             });
    	}
    }
	
    function doReg(){
		var user_name=$("#uname").val();
		var user_pwd=$("#upwd").val();
		var user_confpwd=$("#password_confirm").val();
		var user_tel=$("#uphone").val();	
		//alert("user_name:"+user_name+" p1:"+user_pwd+" p2:"+user_confpwd+"phone:"+user_tel);				
		if(user_name==""||user_pwd==""||user_confpwd==""||user_tel==""){
			alert("注册表单不能为空！");
		}else if(user_confpwd!=user_pwd){
			alert("两次输入的密码不相同！");				
		}
		else{
		
			 $.ajax({
			 		url:"user/register.do",
			        method:"post",
			        data:$("#registerForm").serialize(), //{"uname":user_name,"upwd":user_pwd,"uphone":user_tel},					     
			        error:function () {
			            alert("注册失败");
			        },
	           		success:function(){
	            	 alert("注册成功");
			                //clearInputs();
	            	 location.href='<%=request.getContextPath()%>'+"/index.jsp";
	            	// $(".mui-content-padded").hide();
	            	
	             }	           
	             
	         });
		}
	}

    function logout() {
        $.ajax({
            url:"user/logout.do",
            method:"post",
            success:function () {
                location.reload();
                alert("退出成功");
            },
            error:function () {
                location.reload();
                alert("退出失败");
            }
        })
    }


</script>

</body>
</html>
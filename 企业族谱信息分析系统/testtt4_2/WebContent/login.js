//设置登录页面弹出效果
function Login(){
    var username=$.trim($("#uname").val());//获取用户名trim是去掉空格
    var password=$.trim($("#upwd").val());//获取密码
    if(username==""||password==""){
        alert("用户名或者密码不能为空!",{
        });
    }
    else if(username=="1"&&password=="123"){
          alert("登录成功！"); 
          document.getElementById('chao').innerText='退出登录';
          document.getElementById("chao").style.color="black";
          sessionStorage.setItem('state', '退出登录');
          $('.login-form-mask').fadeOut(50);
          $('.login-form').slideUp(100);
    }
    else{
    	alert("密码输入错误！");
    }
}
jQuery(document).ready(function($) {
	var data = sessionStorage.getItem('state');
	if (data == "退出登录") {
		document.getElementById('chao').innerText = '退出登录';
	}
	$('.nav-login').click(function() {
		var data = sessionStorage.getItem('state');
		if (data == "退出登录") {
			sessionStorage.removeItem('state');
			document.getElementById('chao').innerText = '登录';
			document.getElementById("chao").style.color = "blue";
		} else {
			$('.login-form-mask').fadeIn(50);

			$('.login-form').slideDown(100);

		}
	})

	$('.login-close').click(function() {

		$('.login-form-mask').fadeOut(50);

		$('.login-form').slideUp(100);

	})

})

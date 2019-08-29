/*basicForm.js*/
function check() {
	var correct_phone = /^^1[0-9]{6}$/;
	var correct_mobile = /^1[0-9]{10}$/;// 手机号码为11位，且以1开头。
	var correct_mail = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;//邮箱
	if (document.getElementById("platform_level").checked==false) {
		alert("平台级别不能为空");
		document.getElementById("platform_level").focus();
		return false;
	} else if (document.getElementById("shi").value.length == 0) {
		alert("所在市不能为空");
		document.getElementById("shi").focus();
		return false;
	
	}else if (document.getElementById("selBig").value.length ==0) {
		alert("服务的主要国民经济行业不能为空");
		document.getElementById("selBig").focus();
		return false;
	} else if (document.getElementById("selMiddle").value.length == 0) {
		alert("服务的主要国民经济行业不能为空");
		document.getElementById("selMiddle").focus();
		return false;
	} else if (document.getElementById("selSmall").value.length == 0) {
		alert("服务的主要国民经济行业不能为空");
		document.getElementById("selSmall").focus();
		return false;
	} else if (document.getElementById("Big_subject").value.length == 0) {
		alert("所属的主要学科不能为空");
		document.getElementById("Big_subject").focus();
		return false;
	} else if (document.getElementById("Middle_subject").value.length == 0) {
		alert("所属的主要学科不能为空");
		document.getElementById("Middle_subject").focus();
		return false;
	} else if (document.getElementById("Small_subject").value.length == 0) {
		alert("所属的主要学科不能为空");
		document.getElementById("Small_subject").focus();
		return false;
	} else if (document.getElementById("support_name").value.length == 0) {
		alert("依托单位名称不能为空");
		document.getElementById("support_name").focus();
		return false;
	}else if (document.getElementById("support_number").value.length == 0) {
		alert("依托单位组织机构代码(社会信用代码)不能为空");
		document.getElementById("support_number").focus();
		return false;
	} else if (document.getElementById("legalperson_name").value.length == 0) {
		alert("依托单位法人代表姓名不能为空");
		document.getElementById("legalperson_name").focus();
		return false;
	}else if (document.getElementById("support_phone").value.length == 0) {
		alert("依托单位办公电话不能为空");
		document.getElementById("support_phone").focus();
		return false;
	}  else if (document.getElementById("user_unit[0]").value.length==0) {
		alert("共建单位不能为空");
		document.getElementById("platform_Texture_3").focus();
		return false;
	} else if (document.getElementById("director_name").value.length ==0) {
		alert("平台主任姓名不能为空");
		document.getElementById("director_name").focus();
		return false;
	} else if (document.getElementById("director_birthday").value.length == 0) {
		alert("平台主任出生年月不能为空");
		document.getElementById("director_birthday").focus();
		return false;
	
	} else if (document.getElementById("job_title").value.length == 0) {
		alert("平台主任职称不能为空");
		document.getElementById("job_title").focus();
		return false;
	} else if (document.getElementById("director_professional").value.length == 0) {
		alert("平台主任所学专业不能为空");
		document.getElementById("director_professional").focus();
		return false;
	} else if (document.getElementById("education_background").value.length == 0) {
		alert("平台主任学历不能为空");
		document.getElementById("education_background").focus();
		return false;
	} else if (document.getElementById("degree").value.length == 0) {
		alert("平台主任学位不能为空");
		document.getElementById("degree").focus();
		return false;
	} else if (document.getElementById("office_phone").value.length == 0) {
		alert("平台主任办公电话不能为空");
		document.getElementById("office_phone").focus();
		return false;
	}else if (!correct_phone.test(document.getElementById("office_phone").value)) {
		alert("联系电话请输入7位数字");
		document.getElementById("office_phone").focus();
		return false;
	} else if (document.getElementById("director_phone").value.length == 0) {
		alert("平台主任手机不能为空");
		document.getElementById("director_phone").focus();
		return false;
	}else if (!correct_mobile.test(document.getElementById("director_phone").value)) {
		alert("请输入正确的手机号码");
		document.getElementById("director_phone").focus();
		return false;
	}  else if (document.getElementById("director_Email").value.length == 0) {
		alert("平台主任E-mail不能为空");
		document.getElementById("director_Email").focus();
		return false;
	} else if (!correct_mail.test(document.getElementById("director_Email").value)) {
		alert("请输入正确的邮箱地址");
		document.getElementById("director_Email").focus();
		return false;
	} else if (document.getElementById("platform_webname").value.length == 0) {
		alert("平台网站名称不能为空");
		document.getElementById("platform_webname").focus();
		return false;
	} else if (document.getElementById("platform_weburl").value.length == 0) {
		alert("网址不能为空");
		document.getElementById("platform_weburl").focus();
		return false;
	}else if (document.getElementById("platform_address").value.length == 0) {
		alert("平台通讯地址不能为空");
		document.getElementById("contactAddress").focus();
		return false;
	} else if (document.getElementById("contactAddress").value.length == 0) {
		alert("邮编不能为空");
		document.getElementById("platform_postcode").focus();
		return false;
	} else if (document.getElementById("authorize_date").value.length == 0) {
		alert("批准日期不能为空");
		document.getElementById("authorize_date").focus();
		return false;
	} else if (document.getElementById("technology_field").value.length == 0) {
		alert("技术领域不能为空");
		document.getElementById("technology_field").focus();
		return false;
	}
    else {
		return true;
		alter("注册成功！");
	}
}
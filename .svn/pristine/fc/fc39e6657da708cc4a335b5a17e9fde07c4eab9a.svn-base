<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type = "text/javascript" src="/js/common/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/js/member/memberApp.js"></script>
<script type="text/javascript" src="/js/member/memberController.js"></script>
<title>Insert title here</title>

<script>

//비밀번호 중복 확인
function checkPW(){
	
	var origPW = $("[name=password]")
	var chkPW = $("[name=password2]")
	
	if(origPW.val() != chkPW.val()){
		
		alert("비밀번호가 일치하지 않습니다.");
		origPW.val("");
		chkPW.val("");
		origPW.focus();
	}	
}
// 취소시 인덱스로 이동
function moveTo(){
	location.replace("/index.do");
}

// selectbox 에서 직접입력 선택시 text창 활성화
function changTxt(){
	if($("[name=email3]").val() == "기타"){
		$("[name=email3]").val("");
		$("[name=email2]").removeAttr('disabled');

	}
}

//중복체크 - id,email

var tmp = "";

function dupCheck(i){
	
	// 중복확인할 id, email 이 공백일시
	if(i.length <= 0){
		alert("정보를 입력하세요");
		return;
	}
	
	tmp = tmp + i;
	var memberId = $("[name=memberId]").val();
	var email1 = $("[name=email]").val();
	var email2 = $("[name=email2]").val();
	
	if($("[name=email3]").val().length > 0){
		email2 =  $("[name=email3]").val();
	}	

	$("[name=email2]").val(email2);
	
	
	var email = email1 + "@" + email2;

	//ajax 시작
	var params = {};
		// id중복체크 클릭
	if(i == 'a'){
		var url = "/member/idDuplCheckAjax.do"
		params.memberId = memberId;
	}	//email 중복체크 클릭
		else {
		// url 수정
		var url = "/member/emailDupleCheckAjax.do"
			params.email = email;
	}
		
	$.ajax({
		type:"POST"
		,url:url
		,data:params
		,success:function(data){
			 console.log(data);
			 
		if(data.result=='ok'){
			console.log(data);
			alert(data.resultMsg);
			
			}else{
				alert(data.resultMsg);
			}
		},error:function(e){
			console.log(e);
		
		}
	})//ajax 끝
	
}


function insertTo(){
	
	if(tmp.indexOf('ab') >= 0){
		
		$("[name=email2]").removeAttr("disabled");
		$("[name=memberInsertForm]").attr('action','/member/insertJoinProc.do').submit();
	}
	else if(tmp.indexOf('a') < 0){
		alert("아이디 중복체크를 하세요");
	}else{
		alert("이메일 중복체크를 하세요");
	}
	
}

// 정규식-------------------------------
function regExp_chk(i){
	
	var tmp = "";
	
	if(i == "name"){
		
	// 이름은 한글, 알파벳만 입력
	var KorEngOnly = new RegExp(/^[ㄱ-ㅎ|가-힣|a-z|A-Z|\*]+$/);
	var name = $("[name=name]").val();
	var namearr = name.split("");

		for(var i = 0 ; i < namearr.length ; i++){
			
			if( KorEngOnly.test(namearr[i])  == false){
				alert("한글, 영어만 입력가능");	
				namearr[i]="";
			}
				tmp = tmp + namearr[i];
		} 		
			$("[name=name]").val(tmp);
	}
	
	else if((i == "tel")){
		
		// 전화번호는 숫자만 입력
		
		var numOnly = new RegExp(/^[0-9]*$/);
		var tel = $("[name=tel]").val();
		var telarr = tel.split("");
	
		for(var i = 0 ; i < telarr.length ; i++){
			
			if(numOnly.test(telarr[i]) == false){
				alert("숫자만 입력하세요");
				telarr[i] = "";
			}
			
			tmp = tmp + telarr[i];
		}	
			$("[name=tel]").val(tmp);
	} 
	
}	
	

	


</script>

<header>
		<div class="head">
			<c:choose>
				<c:when test="${sessionScope.loginBean.memberId == 'admin'}">
					<h1 class="logo">
						<a href="/admin/adminIndex.do"><img src="/images/logo.jpg"
							alt="로고" /></a>
					</h1>
				</c:when>
				<c:otherwise>
					<h1 class="logo">
						<a href="/index.do"><img src="/images/logo.jpg" alt="로고" /></a>
					</h1>
				</c:otherwise>
			</c:choose>


		</div>

	</header>

</head>
<body>
	<div align='center'>
		<h2>
			「회원가입」<br>
		</h2>
		<h4 style="color: gray">회원이 되어 다양한 혜택을 누려보세요</h4>
	</div>

	<table align="center">

		<form name="memberInsertForm">
			<tr>
				<td>ID :</td>
				<td><input type="text" name="memberId">
					<input type="button" value="중복확인" onClick="dupCheck('a')"></td>
			<tr>
				<td>PW :</td>
				<td><input type="password" name="password">
					<input type="password" name="password2" placeholder="PW 재입력"></td>
			<tr>
				<td>이름 :</td>
				<td><input type="text" name="name" onKeyup="checkPW();regExp_chk('name')"></td>
			<tr>
				<td>이메일 :</td>
				
				<td><input type="text" name="email">
					<input type="text" name="email2" disabled></td>
		
				<td>
					<select name="email3" onChange="changTxt()">
						<option value="">-선택-</option>
				 		<option value="naver.com">naver.com</option>
						<option value="hanmail.co.kr">hanmail.co.kr</option>
						<option value="gmail.com">gmail.com</option>
						<option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="기타">직접입력</option>
					</select>
			 
				<input type="button" value="중복확인" onClick="dupCheck('b')"></td>
				<td>

			<tr>
				<td>전화번호 :</td>
				<td><input type="text" name="tel" onKeyup="regExp_chk('tel')"></td>
			</tr>
			<tr align="center">
				<td colspan="2" align="center"> <input type = "button" value = "등록" onclick="insertTo()">&nbsp;
								<input type = "button" value = "취소" onclick="moveTo()"></td>

		</form>
	</table>
</body>
</html>
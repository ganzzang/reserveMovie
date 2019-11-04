<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/member/updateMemberForm.do" method="POST">
		
		아이디: ${memberBean.memberId}</br>
		이름: 		<input type="text"  name="name" value="${memberBean.name}" placeholder="이름을 입력해주세요"/> 
		이메일: 	<input type="text" name="email" value="${memberBean.email}" placeholder="이메일을 입력해주세요"/> 
		전화번호: 	<input type="text" name="tel" value="${memberBean.tel}" placeholder="전화번호를 입력하세요"/> 
		
					<input type="hidden" name="memberId" value="${memberBean.memberId}"/>
					<input type="hidden" name="password" value="${memberBean.password}"/>
			
		<input type="submit" value="확인">
	</form>
</body>
</html>
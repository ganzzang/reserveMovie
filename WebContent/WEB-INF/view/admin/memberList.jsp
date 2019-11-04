<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align='center'><h2>「회원 목록」<br></h2>
	<h4 style="color:gray">회원의 정보를 관리할 수 있습니다</h4></div><br>
	<table border="1" cellspacing="0" cellpadding="0" width=70% align='center'>
		<tr>
			<th>번호</th>
			<th>ID</th>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>등록일</th>
			<th>변경</th>
		</tr>

		<c:forEach var="member" items="${memberList}" varStatus="status">
			<tr align="center">
				<td>${status.count}</td>
				<td>${member.memberId}</td>
				<td>${member.name}</td>
				<td>${member.email}</td>
				<td>${member.tel}</td>
				<td>${member.regDate}</td>
				<td>

				<a href="/member/updateMember.do?memberId=${member.memberId}" style=color:blue>수정</a>
				<a href="/member/delete.do?memberId=${member.memberId}"style=color:red>삭제</a>

		</c:forEach>
	</table>
</body>
</html>


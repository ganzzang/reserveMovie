<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="/js/common/jquery-3.2.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>Insert title here</title>

<script type="text/javascript">
		var pagingBean;
		
		//리스트 출력
		function showList(pageNo) {
			
			var url = "/movie/selectMovieList.do";
			var params = {};
			
			params.pageNo = pageNo;
			if(pageNo == null || pageNo == '') {
				params.pageNo = 1;
			}
			
			$.ajax({      
		        type: "POST",  
		        url: url,      
		        data: params,
		        success: function(data){   
		           console.log(data);
		           		           
		           if(data.result == 'ok') {
					
		        	   $("#movieInfoList").empty();
		        	   $("#pageList").empty();
		        	   
		        	   pagingBean = data.pagingBean;
		        	   
		        	   for(var i=0; i<data.movieList.length; i++) {
		        		   
		        		   var bean = data.movieList[i];
		        		   
		        		   var str =
			        	    '<tr>'
			        	    	+ '<td align="center"> <input type="checkbox" class="delete" id="update" value="'+bean.code+'"> </td>	' 
					   			+ '<td align="center"style="cursor:pointer" onclick="selectMovie(\'' + bean.code + '\')">' + '<img src=' + bean.path + ' width=200px height=300px>' + '</td>'
					   			+ '<td align="center"style="cursor:pointer" onclick="selectMovie(\'' + bean.code + '\')">' + bean.titleKor + '</td>'
					   			+ '<td align="center"style="cursor:pointer" onclick="selectMovie(\'' + bean.code + '\')">' + bean.hall + '</td>'
					   			+ '<td align="center"style="cursor:pointer" onclick="selectMovie(\'' + bean.code + '\')">'  + (bean.totSeat-bean.revSeat) + '</td>'
					   			+ '<td align="center"style="cursor:pointer" onclick="selectMovie(\'' + bean.code + '\')">' 
					   			+ bean.opTimeYear + '년 ' + bean.opTimeMonth + '월 ' + bean.opTimeDay + '일 ' 
			   					+ bean.opTimeHh + '시 ' + bean.opTimeMi + '분 ' +  '</td>'
			   				+ '</tr>';
			   				
			   				$("#movieInfoList").append( str );
			   				
		        	   }//end for
		        	   
		        	   
		        	   //페이징 출력
		        	   var pBean = data.pagingBean;
		        	   var str = "";
		        	   
		        	   //그룹번호 달아주기
	        		   if(pBean.groupNo > 1 ) {
	        			   str += " [<span onclick='showList(" 
	        				   + (pBean.pageStartNo-1) + ")' style='cursor:pointer'>이전</span>] ";   
	        		   }
		        	   
		        	   for(var i=pBean.pageStartNo; i<=pBean.pageEndNo; i++) {
		        		   if(i == pBean.pageNo) {
		        			   str += "[<span>" + i + "</span>] &nbsp;";   
		        		   } else {
		        			   str += '[<span onclick="showList(' 
		        				   	+ i + ')" style="cursor:pointer; color:blue;">' + i + '</span>] &nbsp;';   
		        		   }
		        	   }
		        	   
		        	   //그룹번호 달아주기
	        		   if(pBean.groupNo < pBean.totalGroupCount ) {
	        			   str += " [<span onclick='showList(" 
	        				   + (pBean.pageEndNo+1) + ")' style='cursor:pointer'>다음</span>] ";   
	        		   }
	        		   
		        	   
		        	   $("#pageList").append(str);

		           }//end if
		        
		        },   
		        error:function(e){  
		        	console.log(e);  
		        }  
		   	});
			
		}
		
		$(function() {
			showList('${param.pageNo}');
		});
		
		
		function moveTo(i){
			// admin 아이디로 회원가입시 전체목록 출력	
			if(i == 'add'){				location.replace("/admin/insertMovie.do");			}
				else if(i == 'upd'){
					if ($('#update:checked').length == 0 ){
						alert('수정할 영화를 클릭하세요');
					} else	{location.href = "/admin/updateMovie.do?code=" + $('#update:checked').val();}
	
			} 
			
			 else if(i == 'del'){
			 	if(confirm("정말 삭제하시겠습니까??") == true){

					 // 체크박스에 체크된 영화의 코드를 찾아 
					 // 배열에 넣은다음 컨트롤러 클래스의 deleteHall로 넘겨준다.
					 // 코드 찾을때 jQuery를 사용해야 할듯함. 
					 // deleteHall에서는 넘겨받은 code 배열을 반복문 돌려서 
					 // 하나씩 지워줘야함
					 // 지우는 작업이 끝나면 redirect
					 
					 // 이것이 모든 것을 멸종시킬 코드의 시작이었다
					 //alert( $('.deleteMovie:checked').length );
					 //alert( $('.deleteMovie:checked').val());
					if( $('.delete:checked').length == 0 ){
						alert('1개 이상 영화를 체크해주세요');
					}else if( $('.delete:checked').length == 1){
						location.href = "/admin/delete.do?code=" + $('.delete:checked').val();
					}else{
						var send_array = new Array();
						var send_cnt = 0;
						var chkbox = $(".delete");
						var str = "";
						
						for( var i=0 ; i<$(".delete").length; i++){
							if (chkbox[i].checked == true){
						        send_array[send_cnt] = chkbox[i].value;
						        
						        if( i+1 != $(".delete:checked").length ){
	
							        str += send_array[send_cnt] + ",";
						        }else{
							        str += send_array[send_cnt];
						        }
								alert(str);
								// div 버그가있는듯.. 인식 불가하게 되는 경우 가 있다
						    }
							send_cnt++;
						}
						location.href = "/admin/delete.do?code="+str;
					}
			 	}
			} 
			 else if(i == 'sel'){
				location.replace("/member/selectMemberList.do");
			} 
			 else if(i == 'out'){
				 location.replace("/member/logout.do");
			}
		}

		
		function selectMovie(code){
			location.replace("/movie/selectMovie.do?code=" + code);
		}
	</script>

</head>


<body>

	<c:if test="${sessionScope.loginBean.memberId != 'admin'}">
		<script>location.href = "/index.do";</script>
	</c:if>

	<div align='center'>
		<h2>
			「현재 상영작」<br>
		</h2>
		<h4 style="color: gray">영화의 수정 및 삭제가 가능합니다.</h4>
	</div>
	<br>
	<br>
	<!--  
	<table>
		<tr>
			<td>
				<table align="center" cellspacing="0" cellpadding="0" width="180px">
					<tr>
						<td>
							<c:choose>
								<c:when test="${sessionScope.loginBean.memberId != null}">>
									${sessionScope.loginBean.name}님 환영합니다.!!!
									<br><input type=button value="추가" onclick="moveTo('add')">
										<input type=button value="수정" onclick="moveTo('upd')">
										<input type=button value="삭제" onclick="moveTo('del')">
										<input type=button value="회원목록" onclick="moveTo('sel')">
										<input type=button value="로그아웃" onclick="moveTo('out')">	
								</c:when>
								<c:otherwise>
									<form action="/member/loginProc.do" method="POST">
										ID : <input type="text" name="memberId"> 
										PW : <input type="password" name="password"> 
										<input type="submit" value="로그인">
										<input type="button" value="회원가입" onclick="moveTo('join')">
									</form>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</td>
			<td>			-->


	<table border="1" align="center" cellspacing="0" cellpadding="0"
		width="800px">
		<tr>
			<th>선택</th>
			<th>이미지</th>
			<th>제목</th>
			<th>상영관</th>
			<th>잔여좌석</th>
			<th>상영시간</th>
		</tr>
		<tbody id="movieInfoList"></tbody>
	</table>



</body>
</html>

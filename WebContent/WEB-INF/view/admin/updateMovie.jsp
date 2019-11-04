<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="/js/common/jquery-3.2.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$(function() {
		
		$("[name^='op']").change(function() {
			$("[name=edMonth]").val($("[name=opMonth]").val());
			$("[name=edDay]").val($("[name=opDay]").val());
		});
		$("[name=opMonth]").change(function() {
			dateCheck();
		});
	})
	
	function dateCheck(){
		var date = new Date();
		var reg_year = date.getFullYear();
		var reg_month = $("[name=opMonth]").val();
		var reg_day = $("[name=opDay]").val();
		if(reg_month!=""){
			var lastDay = new Date(reg_year, parseInt(reg_month,10),0).getDate();
			if(reg_day>lastDay){
				$("[name=opDay]").val(01);
				$("[name=edDay]").empty();
			}
			$("[name=opDay]").append("<option value=''>");
			for(var i=1; i<=31; i++){
				if(i<10){
					$("[name=opDay]").append("<option value='0"+i+"'>0"+i);
					$("[name=edDay]").append("<option value='0"+i+"'>0"+i);
				}else{
					$("[name=opDay]").append("<option value='"+i+"'>"+i);
					$("[name=edDay]").append("<option value='"+i+"'>"+i);
				}
			}
			$("[name=opDay] [value="+lastDay+"]").nextAll().remove();
			$("[name=edDay] [value="+lastDay+"]").nextAll().remove();
		}
	}

	function validChk() {
		var flag = false;
		var date = new Date();
		var reg_year = date.getFullYear();
		var opMonth = $("select[name=opMonth]").val();
		var opDay = $("select[name=opDay]").val();
		var opHour = $("select[name=opHour]").val();
		var opMin = $("select[name=opMin]").val();
		var edMonth = $("select[name=edMonth]").val();
		var edDay = $("select[name=edDay]").val();
		var edHour = $("select[name=edHour]").val();
		var edMin = $("select[name=edMin]").val();
		var opDate = new Date(reg_year,opMonth,opDay,opHour,opMin);
		var edDate = new Date(reg_year,edMonth,edDay,edHour,edMin);
		if(edDate-opDate<=0){
			alert("상영 종료시간은 시작시간보다 늦어야 합니다.")
			flag = false;
			return flag;
		}
		flag = true;
		return flag
		
	}
	function makeOptime(){
		var opMonth = $("select[name=opMonth]").val();
		var opDay = $("select[name=opDay]").val();
		var opHour = $("select[name=opHour]").val();
		var opMin = $("select[name=opMin]").val();
		var opTime = opMonth+"-"+opDay+" "+opHour+":"+opMin;
		return opTime;
	}
	
	function makeEdtime(){
		var edMonth = $("select[name=edMonth]").val();
		var edDay = $("select[name=edDay]").val();
		var edHour = $("select[name=edHour]").val();
		var edMin = $("select[name=edMin]").val();
		var edTime = edMonth+"-"+edDay+" "+edHour+":"+edMin;
		return edTime;
	}
	function updateProc(){
		
		var titleKor = $(".titleKor").val();
		var titleEng = $(".titleEng").val();
		var hall = $(".hall").val();
		var code = $(".code").val();
		
		var opTime = makeOptime();
		var edTime = makeEdtime();
		var flag = validChk();
	
		if(flag==false){
			alert("전송실패");
			return;
		}
		var url = "/admin/updateMovieProc.do";
		var fileUrl = "/admin/insertMovieFileProc.do";
		var params = {};
		params.titleKor = titleKor;
		params.titleEng = titleEng;
		params.hall = hall;
		params.opTime = opTime;
		params.edTime = edTime;
		params.code = code;
		
		var fileData = new FormData();
        $.each($('#attachFile')[0].files, function(i, file) {
        	fileData.append('file-' + i, file);
        });
		
        $.ajax({
            type: "POST",
            url: fileUrl,
            data: fileData,
            async: false,
            //cache: false,
            processData: false,
            contentType: false,
            success: function(data) {
                params.path = data;
            }, error: function(xhr, status, error) {
            	alert(xhr);
            	alert(status);
            	alert(error);
            }
        });
        
		$.ajax({      
	        type: "POST",  
	        url: url,      
	        data: params,
	        async: false,
	        success: function(data){   
	           console.log(data);
	           
	           alert(data.resultMsg);
	           
	           if(data.result == 'ok') {
					location.replace('/admin/adminIndex.do');	
	           } 
	        
	        },   
	        error:function(e){  
	        	console.log(e);  
	        }  
	   	});
	}
	
	function moveTo() {
		location.href = "/admin/adminIndex.do";
	}
</script>
</head>
<body>
	<div align='center'>
		<h2>
			「영화 수정」<br>
		</h2>
		<h4 style="color: gray">영화의 상영 시간을 수정할 수 있습니다.</h4>
	</div>
	<table>
		<form>

			<tr>
				<td>한글제목</td>
				<td>${movieBean.titleKor}
				<input type="hidden" class="titleKor" value="${movieBean.titleKor}">
				<input type="hidden" class="code" value="${movieBean.code}"></td>
			</tr>
			<tr>
				<td>영어제목</td>
				<td>${movieBean.titleEng}
				<input type="hidden" class="titleEng" value="${movieBean.titleEng}">
				<input type="hidden" class="hall" value="${movieBean.hall}">
				</td>
			</tr>
			<tr>
				<td>상영관</td>
				<td>${movieBean.hall}</td>
			</tr>
			<tr>
				<td>시작시간</td>
				<td>
				<select name = "opMonth">
					<script type="text/javascript">
					for(i=1;i<=12;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
					</script>
				</select>월
				
				<select name = "opDay">
					<script type="text/javascript">
					for(i=1;i<=31;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
				</script>
				</select>일
				
				<select name = "opHour">
				<script type="text/javascript">
					for(i=0;i<24;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
				</script>
				</select>시
				<select name = "opMin">
				<script type="text/javascript">
					for(i=0;i<60;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
				</script>
				</select>분
				</td>
			</tr>
			<tr>
				<td>종료시간</td>
				<td>
				<select name = "edMonth">
					<script type="text/javascript">
					for(i=1;i<=12;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
				</script>
				</select>월
				
				<select name = "edDay">
					<script type="text/javascript">
					for(i=1;i<=31;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
				</script>
				</select>일
				
				<select name = "edHour">
				<script type="text/javascript">
					for(i=0;i<24;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
				</script>
				</select>시
				
				<select name = "edMin">
				<script type="text/javascript">
					for(i=0;i<60;i++){
						if(i<10){i = "0"+i}
						document.write('<option value="'+i+'">'+i);
					}
				</script>
				</select>분
				
				</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<form id="submitForm" enctype="multipart/form-data">
						<input name="attachFile" id="attachFile" type="file">
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="등록" onclick="updateProc();">
				<input type="button" value="취소" onclick="moveTo()"></td>
			</tr>

		</form>
	</table>
</body>
</html>
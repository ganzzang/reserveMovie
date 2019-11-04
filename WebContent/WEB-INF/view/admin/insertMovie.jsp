<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 추가</title>
	<script type="text/javascript">
	
	$(function(){
		$("[name^='op']").change(function(){
			$("[name=edMonth]").val($("[name=opMonth]").val());
			$("[name=edDay]").val($("[name=opDay]").val());
		});
		$("[name=opMonth]").change(function(){
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
	
	function makeCode(){
		var code = "";
		var titleEng = $(".titleEng").val();
		var hall = $("select[name=hall]").val();
		var opMonth = $("select[name=opMonth]").val();
		var opDay = $("select[name=opDay]").val();
		var onDate = opMonth+opDay;
		var opHour = $("select[name=opHour]").val();
		var opMin = $("select[name=opMin]").val();
		var edHour = $("select[name=edHour]").val();
		var edMin = $("select[name=edMin]").val();
		var onTime = opHour+opMin+"_"+edHour+edMin;
		code = titleEng+"_"+hall+"_"+onDate+"_"+onTime;
		return code;
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
	
	function validChk(){
		//제목 기입체크
		var flag = false;
		
		var titleKor = $(".titleKor").val();
		var titleEng = $(".titleEng").val();
		if(titleKor==""){
			alert("한글 제목을 입력하세요")
			flag = false;
			return flag;
		}
		if(titleEng==""){
			alert("영어 제목을 입력하세요")
			flag = false;
			return flag;
		}
		//영어제목 정규식
		var pattern = new RegExp(/^[a-z0-9_]+$/);
		if(pattern.test(titleEng)==false){
			alert("영어 제목은 영어,숫자,_만 가능합니다.")
			flag = false;
			return flag;
		}
		
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
		return flag;
	}
	
	function insertProc(){
		var code = makeCode();
		var opTime = makeOptime();
		var edTime = makeEdtime();
		var flag = validChk();
		if(flag==false){
			alert("전송실패");
			return;
		}
		
		//SEAT테이블에 좌석 만들어주는 코드
		insertHallSeat();
		
		var url = "/admin/insertMovieProc.do";
		var fileUrl = "/admin/insertMovieFileProc.do";
		var params = {};
		params.titleKor = $(".titleKor").val();
		params.titleEng = $(".titleEng").val();
		params.hall = $("select[name=hall]").val();
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
	
	function insertHallSeat(){
		var code = makeCode();
		
		var url = "/admin/insertHallSeat.do";
		var params = {};
		params.hall = $("select[name=hall]").val();
		params.code = code;
		
		$.ajax({      
	        type: "POST",  
	        url: url,      
	        data: params,
	        success: function(data){   
	           console.log(data);
	           
	           if(data.result == 'ok') {
					alert("등록 성공");
	           } 
	        
	        },   
	        error:function(e){  
	        	console.log(e);  
	        }  
	   	});
	}
	
	function back(){	
		replace.location("/admin/adminIndex.do");
	}
	</script>
</head>
<body>
	<div align='center'><h2>「영화 추가」<br></h2>
	<h4 style="color:gray">새로운 영화를 추가할 수 있습니다.</h4></div>

	<table align='center'>
		<form>
			<tr>
				<td>한글제목</td>
				
				<td><input type="text" class="titleKor"></td>
			</tr>
			<tr>
				<td>영어제목</td>
				<td><input type="text" class="titleEng"></td>
			</tr>
			<tr>
				<td>상영관</td>
				<td><select name = "hall">
				<option value="A">A</option>
				<option value="B">B</option>
				<option value="C">C</option>
				</td>
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
			<tr align='center'>
				<td colspan="2"><input type="button" value="등록" onclick="insertProc();">
				<input type="button" value="취소" onclick="back();"></td>
			</tr>
		</form>
	</table>
</body>
</html>
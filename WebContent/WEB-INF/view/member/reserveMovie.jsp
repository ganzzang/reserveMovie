<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="/js/member/memberApp.js"></script>
<script type="text/javascript" src="/js/member/memberController.js"></script>

<script type="text/javascript">
		// 값 입력
		var a =${sessionScope.movieBean.seatCntX};
		var b =${sessionScope.movieBean.seatCntY};
		var code = "${sessionScope.movieBean.code}";

	function showSeat(a,b){
		
		$('.seatDiv').append( "<table align='center' border='1' cellspacing='0' cellpadding='0' class='seatTable'>" );
		var str = "";
		var arr = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];

		// 임의의 숫자형 변수
		var next = "0";
		// 문자를 숫자로 변환 시킬 값
		var num = new Number();
		
		var seatValue = "";
	
		for ( var i=0; i<a; i++ )
		{
				$('.seatTable').append( "<tr class=seatTr"+i+">" );
				for ( var j=1; j<=b; j++ )
				{
					//seatValue = data.seatList[num].seatValue;
					str = arr[i] + j;
					num = Number(next) + Number(j);
					$('.seatTr'+i).append( "<td name='"+str+"' id='"+num+"' class='No' onClick='showSeatValue( $(\" "+'[id='+num+']'+"\").attr(\"id\")) ' style='cursor:pointer'>" + str + "</td>" );

					//alert 주석
					//'alert(\"show number =\" "+'+'+" $(\""+'[id='+num+']'+"\").text() "+'+'+" \" & \" "+'+'+" \"seat number =\" "+'+'+" $(\""+'[id='+num+']'+"\").attr(\"id\"))' style='cursor:pointer'>" + str + "</span></td>" );					
					// 구현체
				};
				$('.seatTable').append( "</tr>" );
			// 값 이동
			next = num;
		};
		$('.seatDiv').append( "</table>" );
	}
	
	//클릭시 좌석예약 가능여부 체크해주기
	function showSeatValue(id){

		var url = "/member/selectSeatAjax.do"
		var params={};
		params.seatNo=id;
		
		$.ajax({
			type:"GET"
			,url:url
			,data:params
			,success:function(data){
				 console.log(data);
		           
				if(data.result=='ok'){
					console.log(data);
					var seatValue = $('#'+id).attr("class");
					if(seatValue=='No'){
						$('#'+id).attr("class","Yes");
						$('#'+id).attr("bgcolor","green");
					}else if(seatValue=='Yes'){
						$('#'+id).attr("class","No");
						$('[id='+id+']').removeAttr("bgcolor");
					}
					// alert(data.resultMsg);
				}else if(data.result=='fail'){
					alert(data.resultMsg);
					location.replace("/member/reserveMovie.do");
				}

			},error:function(e){
				console.log(data);
				alert("서버와 통신에 실패하였습니다.");
			}
	
		})//Ajax 끝
	}
	
	//예약버튼 눌렀을 때
	function reserveSeat(){

		var seatHidden = "";
		var seatShow="";
		
		for (var i=1; i<=a*b; i++){
			var val = $('[id='+i+']').attr("class");
			if(val=='Yes'){
				//i=i+'';
				seatHidden=seatHidden+i+','
				seatShow=seatShow+','+$('[id='+i+']').attr("name");
				if(seatShow.charAt(0)==","){
					seatShow=seatShow.substring(1);
				}
			}
		}
		seatHidden = seatHidden.substring(0,seatHidden.length-1);
			
			var url = "/member/reserveMovieAjax.do"
			var params={};
			params.revRequestSeat = seatHidden;
			params.revRequestShowSeat = seatShow;
			
			$.ajax({
				type:"POST"
				,url:url
				,data:params
				,success:function(data){
					 console.log(data);
			           
					if(data.result=='ok'){
						console.log(data);

						alert(data.resultMsg);
						location.replace("/member/selectMember.do");
	
					}else{
						alert(data.resultMsg);
						location.replace("/member/reserveMovie.do");
					}

				},error:function(e){
					console.log(data);
					alert("서버와 통신에 실패하였습니다.");
				}
			})//Ajax 끝	
	}
	
	// 예약 취소
	function cancleSeat(){

		var url = "/member/selectSeatAjax.do"
		var params={};
		
		$.ajax({
			type:"GET"
			,url:url
			,data:params
			,success:function(data){
				 console.log(data);
				 
				var seatValue = $("[class='Yes']").length;
		           
				if(seatValue==0){
					alert("좌석을 선택 후 취소가 가능합니다.");
				}else if(data.result=='fail'){
					alert("예약 취소에 성공하였습니다.");
					location.replace("/member/reserveMovie.do");
				}
				
			},error:function(e){
				console.log(data);
				alert("서버와 통신에 실패하였습니다.");
			}
	
		})//Ajax 끝
	}
	
	//class="YES" 일때 색을 변하게 해주는 효과 // y, n에 따라 색상 바뀌게 해주는 것
/*	funtion changeColor{
		
		for(var i=1; i<a*b; i++){
			var seatClass = '';
			seatClass = $('[class=Yes]').attr("color=green");
	 		seatValInjsp = seatValInjsp.charAt(0);
	 		if(seatValue!=seatValInjsp){
	 			$('#'+i).attr("class","Yes");
	 		}		
	 	}
		
	}*/

				
	$(document).ready(function(){
		
		showSeat(a,b);
	
		var url = "/member/selectSeatAjax.do"
		var params={};
		params.code=code;		
		$.ajax({
			type:"GET"
			,url:url
			,data:params
			,success:function(data){
				 console.log(data);
		           
				if(data.result=='ok'){
					console.log(data);
					// var tmp = data.seatList[1].seatValue; 아래에서 쓸 것 

						// 선택여부 체크해준다. 활성화 비활성화 문제 고민해보기

					 	for(var i=1; i<=a*b; i++){
					 		var seatValue=data.seatList[i-1].seatValue;
					 		var seatNo = data.seatList[i-1].seatNo;
					 		
					 		seatValInjsp= $('[id='+i+']').attr("class");
					 		seatValInjsp = seatValInjsp.charAt(0);
					 		var seatNoInjsp = $('[id='+seatNo+']').attr("id");
					
					 		if(seatNoInjsp== seatNo && seatValue!=seatValInjsp){
					 			$('#'+seatNo).attr("class","never");
								$('.never').attr("bgcolor","gray");//색 바꿔주기
								$('.never').removeAttr("onclick");//함수 작동 안하게 하기
					 		}		
					 	}
					 	alert("예약 가능한 좌석을 선택해주세요.");
					 	
						/*
						// 테이블 생성
						document.write( "<table align='center' border='1' cellspacing='0' cellpadding='0'>" );
						var str = " ";
						var arr = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
						// 값 입력
						var a = prompt("몇 행", "");
						var b = prompt("몇 열", "");
						// 임의의 숫자형 변수
						var next = "0";
						// 문자를 숫자로 변환 시킬 값
						var num = new Number();
						
						var seatValue = "";
						
						for ( var i=0; i<a; i++ )
						{
							document.write( "<tr>" );
								for ( var j=1; j<=b; j++ )
								{

										seatValue = data.seatList[num].seatValue;
										
										if( seatValue == "N"){
											
												str = arr[i] + j;
												num = Number(next) + Number(j);
												document.write( "<td name='"+str+"' id='"+num+"' class='yes'><span onClick='showSeatValue( $(\" "+'[id='+num+']'+"\").attr(\"id\")) ' style='cursor:pointer'>" + str + "</span></td>" );

												//alert 주석
												//'alert(\"show number =\" "+'+'+" $(\""+'[id='+num+']'+"\").text() "+'+'+" \" & \" "+'+'+" \"seat number =\" "+'+'+" $(\""+'[id='+num+']'+"\").attr(\"id\"))' style='cursor:pointer'>" + str + "</span></td>" );
												
												
												// 구현체
											
										} else {
											
											str = arr[i] + j;
											num = Number(next) + Number(j);
											document.write( "<td name='"+str+"' id='"+num+"'>" + str + "</td>" );
										}
												
										
								};
							document.write( "</tr>" );
							// 값 이동
							next = num;
						};
						
						
						document.write( "</table>" );*/
					

				}
					
					
					
					
					
				
			},error:function(e){
				console.log(e);
			}
			
		});//Ajax끝

	
})



	

</script>



</head>



<body>



	
	
	<div align='center'><h2>「${sessionScope.movieBean.titleKor}」<br></h2>
	<h4 style="color:gray">예약가능 좌석현황</h4><br>
		<input type="button" class="button-2" value="예약" onCLick="reserveSeat()">
		<input type="button" class="button-2" value="취소" onClick="cancleSeat()">
	</div>

	<br>
	<!-- seat table 들어갈 div -->
		<div class="seatDiv" align="center"></div><br><br>
		<!-- button 들어갈 div -->
		<div class="revButton" align="center">
		

		<br>

		</div>
	</div>
	<br>



</body>
</html>

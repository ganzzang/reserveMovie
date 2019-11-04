'use strict';

var memberApp = angular.module("memberApp", []);

//팩토리 정의
memberApp.factory("MemberService", function($http){
	
	var service = {};
	
	service.selectMemberList = selectMemberListAjax;
	service.insertMember = insertMemberAjax;
	
	return service;
	
	/** 회원목록 조회 */
	
	function selectMemberListAjax(jsonParam){
		
		var sendParam = json2PostParams(jsonParam);
		
		//통신시작
		return $http(
				{
					url : "/member/selectMemberListAjax.do",
					method : 'POST',
					data : sendParam,
					headers : {'Content-Type' : 'application/x-www-form-urlencoded'}
				}
	
		)
		.then(handleSuccess, handleError);
		
	}; //end function
	

	
	function insertMemberAjax(JsonParam){
		var sendParam = json2PostParams(jsonParam);
		//통신시작
		return $http(
				{
					url : "/member/insertMemberListAjax.do",
					method : 'POST',
					data : sendParam,
					headers : {'Content-Type' : 'application/x-www-form-urlencoded'}
				}
	
		)
		.then(handleSuccess, handleError);
	}
	
	//private function
	function handleSuccess(res){
		return res.data;
	}
	function handleError(error){
		return function(){
			return { success: false, message: error};
		}
	}
	
	
	
	
});

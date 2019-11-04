'use strict';

memberApp.controller('memberController', memberController);

memberController.$inject = ['$rootScope', '$scope', 'MemberService'];

function memberController($rootScope, $scope, MemberService){
	
	$scope.showList = function(pageNo){
	
		var param = { 	
				pageNo : pageNo
		};
		
		//회원목록 조회
		MemberService.selectMemberList(param).then(function(data){
			
			console.log(data);
			
			$scope.memberList = data.memberList;
			$scope.pagingBean = data.pagingBean;
			
		});
	};
	
	//주어진 숫자를 배열로 변경해주는 함수
	$scope.getNumOfArr = function(pageStartNo, pageEndNo){
		return getNumOfArr(pageStartNo, pageEndNo);
	};
	
}
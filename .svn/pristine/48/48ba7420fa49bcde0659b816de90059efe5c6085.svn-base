'use strict';

//JSon 형태의 key:value 형태를 key=value 값으로 반환

function json2PostParams(data) {
	var requestStr;
	if (data) {
		for (var key in data) {
			if (requestStr) {
				requestStr += "&" + key + "=" + encodeURIComponent(data[key]);
			} else {
				requestStr = key + "=" + encodeURIComponent(data[key]);
			}
		}
	}
	return requestStr;
};

function getNumOfArr(pageStartNo, pageEndNo){
	//console.log(pageStartNo + "." + pageEndNo)

	var arr = [];

	for(var i=pageStartNo; i<=pageEndNo; i++){
		arr.push(i);
	}

	return arr;

};
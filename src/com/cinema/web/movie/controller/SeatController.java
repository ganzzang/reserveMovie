package com.cinema.web.movie.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cinema.web.common.constant.CommonConst;
import com.cinema.web.member.bean.MemberBean;
import com.cinema.web.movie.bean.MovieBean;
import com.cinema.web.movie.bean.SeatBean;
import com.cinema.web.movie.service.MovieService;


@Controller
public class SeatController {
	
	//서비스 메소드 사용을 위한 객체생성
	@Autowired
	private MovieService movieService;


	//영화 좌석페이지(로딩시 ajax통신용)
	@RequestMapping("/member/selectSeatAjax")
	@ResponseBody
	public Map<String,Object> selectSeatAjax(MovieBean movieBean,SeatBean seatBean,HttpSession session) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		
		String result = "fail";
		String resultMsg = "이미 선택 된 좌석입니다.";
		//movieBean의 데이터는 항상 사용해야 하므로
		
		
		//전체좌석조회
		if(movieBean.getCode()!=null){
			try{

				//전체 좌석정보 조회
				List<SeatBean> list = movieService.selectSeat(movieBean);
				result = "ok";
				map.put("seatList", list);
	
			
			}
			catch(Exception e){
				e.printStackTrace();
			}
		
		//클릭시 좌석 예약 가능 여부 조회
		}else if(movieBean.getCode()==null){
			
			try{
				
				//현재 좌석정보 조회
				SeatBean sBean = movieService.selectSeatValue(seatBean,session);
				if(sBean.getSeatValue().equals("N")){
					result = "ok";
					resultMsg="선택 가능한 좌석입니다.";
				}
				map.put("seatList", sBean);			
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
			
		}
		
		map.put("result", result);
		map.put("resultMsg", resultMsg);
		return map;
				
	}
	
	@RequestMapping("/member/reserveMovieAjax")
	@ResponseBody
	public Map<String,Object> reserveMovieAjax(SeatBean seatBean,HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();
		String result = CommonConst.RESULT_FAIL;
		String resultMsg = "영화 예약에 실패하였습니다.";
		
		int totSeat=0;
		/*
		 * 좌석 seat에서 예약좌석을 합쳐서 string으로 보내고, 
		"," 기준 split으로 배열에 넣어서 이동시키는 로직(seatShow, seathidden 모두 해당 **/
		//seatHidden 작업
		String[] revRequestSeatArr;
		String revRequeestSeat = seatBean.getRevRequestSeat();
		
		revRequestSeatArr = revRequeestSeat.split(",");
		totSeat = revRequestSeatArr.length;
		seatBean.setRevRequestSeatArr(revRequestSeatArr);
		
		// seatShow 작업
		String[] revRequestShowSeatArr;
		String revRequeestShowSeat = seatBean.getRevRequestShowSeat();
		
		revRequestShowSeatArr = revRequeestShowSeat.split(",");
		seatBean.setRevRequestShowSeatArr(revRequestShowSeatArr);

		//DB연동, 예외발생시 실패작업. 실패 분류는 시간되면 나중에 나누기...
		try{
			int totSeatDB = movieService.reserveMovie(seatBean,session);
			if(totSeat==totSeatDB){
				result=CommonConst.RESULT_OK;
				resultMsg = "예약성공";
			}
		}catch(DataIntegrityViolationException e){
			e.printStackTrace();
			map.put(CommonConst.RESULT, result);
			map.put(CommonConst.RESULT_MSG, resultMsg);
			return map;
		}

		
		map.put(CommonConst.RESULT, result);
		map.put(CommonConst.RESULT_MSG, resultMsg);
		return map;	
	}
	
	
}

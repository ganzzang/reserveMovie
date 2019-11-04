package com.cinema.web.movie.service;

import java.sql.SQLException;
import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.dao.DataIntegrityViolationException;

import com.cinema.web.common.bean.PagingBean;
import com.cinema.web.movie.bean.MovieBean;
import com.cinema.web.movie.bean.ReserveBean;
import com.cinema.web.movie.bean.SeatBean;


public interface MovieService {
	
	//현재 좌석정보 조회
	public List<SeatBean> selectSeat(MovieBean movieBean);

	// 예매된 좌석 숫자
	public int selectRevSeatCount(MovieBean movieBean);
	
	// 전 좌석 숫자
	public int selectTotalSeatCount(MovieBean movieBean);
	
	//현재 좌석정보 조회 (seatBean으로)
	public SeatBean selectSeatValue(SeatBean seatBean,HttpSession session);
	
	//영화좌석 예매
	public int reserveMovie(SeatBean seatBean,HttpSession session)throws DataIntegrityViolationException;

	// insertMovie : 영화등록
	public int insertMovie(MovieBean movieBean) throws Exception;
	
	// insertHallSeat : 영화관 좌석 등록
	public int insertHallSeat(SeatBean seatBean) throws Exception;
	
	// updateMovie : 영화수정
	public int updateMovie(MovieBean movieBean) throws Exception;

	/* version 68
	// insertSeat : 시트 등록
	public int insertSeat(SeatBean seatBean);
	
	}	
	// 영화 삭제
	public int deleteMovie(MovieBean movieBean);
	// 영화와 연결된 시트들 삭제
	public int deleteSeat(SeatBean seatBean);
	*/

	
	// selectMovie : 영화리스트
	public List<MovieBean> selectMovieList(PagingBean pagingBean);

	// 영화 리스트 숫자 
	public int selectListTotCount(PagingBean pagingBean);
	
	public MovieBean selectMovie(MovieBean movieBean);
	
	// addHall : 영화관추가 
	
	// deleteMovie : 영화삭제
	public int deleteMovie(MovieBean bean);	
	
	// deleteHall : 영화관 삭제
	public int deleteHall(SeatBean bean);
	
}
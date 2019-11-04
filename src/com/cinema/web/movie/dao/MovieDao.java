package com.cinema.web.movie.dao;

import java.util.List;

import com.cinema.web.common.bean.PagingBean;
import com.cinema.web.member.bean.MemberBean;
import com.cinema.web.movie.bean.MovieBean;
import com.cinema.web.movie.bean.ReserveBean;
import com.cinema.web.movie.bean.SeatBean;

public interface MovieDao {
	
	//좌석페이지 로딩시, 현재 좌석정보 조회
	public List<SeatBean> selectSeat(SeatBean seatBean);
	
	//현재 좌석정보 조회 (seatBean으로)
	public SeatBean selectSeatValue(SeatBean seatBean);
	
	//영화좌석 예매
	public int reserveMovie(SeatBean seatBean);

	// 현재 예매된 좌석 수
	public int selectRevSeatCount(SeatBean seatBean);
	
	// 전체 좌석 수 
	public int selectTotalSeatCount(SeatBean seatBean);

	// insertMovie : 영화등록
	public int insertMovie(MovieBean movieBean);
	
// insertHallSeat : 영화관 좌석 등록
	// public int insertSeat(SeatBean seatBean);	
	public int insertHallSeat(SeatBean seatBean);
	
	public int updateMovie(MovieBean movieBean);
	
	public int deleteMovie(MovieBean movieBean);

	public int deleteHall(SeatBean bean);
	
	public List<MovieBean> selectMovieList(PagingBean pagingBean);

	public MovieBean selectMovie(MovieBean movieBean);
		
	public int selectListTotCount(PagingBean pagingBean);
	
	//예약테이블
	public int insertRev(ReserveBean reserveBean);
	
}
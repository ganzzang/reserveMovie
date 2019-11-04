package com.cinema.web.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cinema.web.member.bean.MemberBean;
import com.cinema.web.movie.bean.MovieBean;
import com.cinema.web.movie.bean.SeatBean;
import com.cinema.web.movie.service.MovieService;


@Controller
public class CommonController {
	
	//서비스 메소드 사용을 위한 객체생성
	@Autowired
	private MovieService movieService;
	

	//test
	@RequestMapping("/test/helloWorld")
	public String helloWorld() {
		return "/test/helloWorld";
	}

	//index
	@RequestMapping("/index")
	public String index() {
		return "/index";
	}
	
	//관리자 메인페이지
	@RequestMapping("/admin/adminIndex")
	public String adminIndex() {
		return "/admin/adminIndex";
	}
	
	//영화 업로드
	@RequestMapping("/admin/insertMovie")
	public String insertMovie() {
		return "/admin/insertMovie";
	}
	
	//관리자 관리페이지
	@RequestMapping("/admin/adminForm")
	public String adminForm() {
		return "/admin/adminForm";
	}
	
	//memberList
	@RequestMapping("/admin/memberList")
	public String memberList() {
		return "/admin/memberList";
	}
	
	//회원가입
	@RequestMapping("/member/joinMember")
	public String joinMember() {
		return "/member/joinMember";
	}
		
	@RequestMapping("/member/memberInfo")
	public String memberInfo() {
		return "/member/memberInfo";
	}
	//영화 좌석페이지(페이지 이동용)
	@RequestMapping("/member/reserveMovie")
	public String reserveMovie(MovieBean movieBean) {
		return "/member/reserveMovie";
	}
	
	// 관리자 영화 삭제
	@RequestMapping("/admin/delete")
	public String delete(MovieBean movieBean, SeatBean seatBean, HttpSession session, MemberBean memberBean){

		// 요개 여러개를 넘겨 줄때는 하나만 받으니까 배열로 받는거당....
		String tmpCode = movieBean.getCode();
		if( tmpCode.indexOf(",") < 0){
			movieService.deleteMovie(movieBean);
			movieService.deleteHall(seatBean);
		}else{
			String[] tmpArray = tmpCode.split(",");
			// split return 값은 배열로 준다
			for( int i=0; i<tmpArray.length;i++){
				movieBean.setCode(tmpArray[i]);
				movieService.deleteMovie(movieBean);
				seatBean.setCode(tmpArray[i]);
				movieService.deleteHall(seatBean);
			}
		}
		session.setAttribute("memberBean", memberBean);
		
		return "redirect:/admin/adminIndex.do";
		// 왜일까 리다이렉트는 안 먹히는데 ... 이건 먹힐까??.. 그러기 전에 데이터 복구시키자
		// url 주소에 이상한거 남아있는데 뭐냐 거추장 스럽다 요걸 리다이렉트로 하는거다
	}
	

}
	
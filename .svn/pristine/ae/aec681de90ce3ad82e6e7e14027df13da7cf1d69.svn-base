package com.cinema.web.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinema.web.member.bean.MemberBean;
import com.cinema.web.member.dao.MemberDao;
import com.cinema.web.movie.bean.ReserveBean;
import com.cinema.web.movie.bean.SeatBean;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	
	@Override
	// joinMember : 회원가입
	public int insertMember(MemberBean bean) throws Exception {
		
		//중복된 회원가입을 방지하기 위해서 회원을 조회한다.
		MemberBean mBean = memberDao.selectMember(bean);
		
		if(mBean == null) {
			
			String remail = bean.getEmail() + "@" + bean.getEmail2();
			bean.setEmail(remail);
			
			int intVal = memberDao.insertMember(bean);
			
			return intVal;
			
		}
		
		throw new Exception("회원가입에러");
	}
	

	
	// 로그인
	public boolean selectLoginMember(MemberBean bean) {
		
		int resVal = memberDao.selectLoginMember(bean);
		
		if(resVal == 1) {
			return true;
		}
		
		return false;
	}
	
	public MemberBean selectMember(MemberBean bean) {
		return memberDao.selectMember(bean);
	}
	
	public MemberBean emailcheck(MemberBean bean) {
		return memberDao.emailcheck(bean);
	}
	
	public List<MemberBean>  selectMemberList(MemberBean bean){
			return memberDao.selectMemberList(bean);
		}
	
	// updateMember : 회원정보수정
	public int updateMember(MemberBean bean) {
		return memberDao.updateMember(bean);
	}
	// deleteMember : 회원탈퇴
	public int deleteMember(MemberBean bean){
		return memberDao.deleteMember(bean);
	}
	
	// 본인 예약정보 출력
	public List<ReserveBean> selectReserve(ReserveBean reserveBean){
		return memberDao.selectReserve(reserveBean);
	}
	
	// 회원 정보 삭제시 좌석 삭제
	public int deleteSeat(ReserveBean bean){
		return memberDao.deleteSeat(bean);
	}
	public int deleteReserve(ReserveBean bean){
		return memberDao.deleteReserve(bean);
	}
	
	// 회원 정보 삭제시 좌석 'N' 변경
	public int updateSeat(ReserveBean bean){
		return memberDao.updateSeat(bean);
	}

}

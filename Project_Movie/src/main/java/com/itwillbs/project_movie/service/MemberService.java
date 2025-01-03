package com.itwillbs.project_movie.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_movie.mapper.MemberMapper;
import com.itwillbs.project_movie.vo.EmailAuthVO; //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
import com.itwillbs.project_movie.vo.MemberVO;
//민기

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;

	// 회원 등록 요청
	public int registMember(MemberVO member) {
		// MemberMapper - insertMember()
		return mapper.insertMember(member);
	}

	// 회원 로그인을 위한 아이디, 패스워드 판별 요청
	public String loginMember(MemberVO member) {
		// MemberMapper - selectMemberIdForLogin()
		return mapper.selectMemberIdForLogin(member);
	}

	// 회원 상세정보 조회 요청
	public MemberVO getMember(String id) {
		// MemberMapper - selectMember()
		return mapper.selectMember(id);
	}

	// 회원 정보 수정 요청 
	public int modifyMember(Map<String, String> map) {
		// MemberMapper - updateMember()
		return mapper.updateMember(map);
	}

	// 회원 정보 중 패스워드만 조회 요청
	public String getMemberPasswd(String id) {
		// MemberMapper - selectMemberPasswd()
		return mapper.selectMemberPasswd(id);
	}

	public int withdrawMember(String id) {
		// MemberMapper - updateMemberStatus()
		return mapper.updateMemberStatus(id, 3);
	}

	// =========================================================
	// 이메일 인증정보 등록 요청
	public void registMailAuthInfo(EmailAuthVO mailAuthInfo) { 
		//***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
		EmailAuthVO dbMailAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
		
		if(dbMailAuthInfo == null) {
			mapper.insertMailAuthInfo(mailAuthInfo);
		} else {
			mapper.updateMailAuthInfo(mailAuthInfo);
		}
	}

	// 메일 인증 처리 요청
	@Transactional
	public boolean requestEmailAuth(EmailAuthVO mailAuthInfo) { //***** 수정전: MailAuthInfo ----> 수정후: EmailAuthVO *****
		boolean isAuthSuccess = false;
		
		EmailAuthVO dbMailAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
		
		if(dbMailAuthInfo != null) {
			if(mailAuthInfo.getMail_auth_code().equals(dbMailAuthInfo.getMail_auth_code())) { //***** 수정전: auth_code ----> 수정후: mail_auth_code *****
				mapper.updateMailAuthStatus(mailAuthInfo);
				mapper.deleteMailAuthInfo(mailAuthInfo);
				isAuthSuccess = true;
			}
		}
		
		return isAuthSuccess;
	}
}

package com.itwillbs.project_movie.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.CustomerServiceMapper;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;

@Service
public class CustomerServiceService {
	@Autowired
	private CustomerServiceMapper mapper;
	// 공지사항 목록 조회
	public int getNoticeListCount(String searchType, String searchKeyword) {
		// TODO Auto-generated method stub
//		System.out.println( "servicegetcount " + searchKeyword);
		return mapper.selectNoticeListCount(searchType,searchKeyword);
	}
	// 공지사항 
	public List<NoticeBoardVO> getNoticeList(int startRow, int listLimit, String searchType, String searchKeyword) {
		// TODO Auto-generated method stub
//		System.out.println( "servicegetlist " + searchKeyword);
		return mapper.selectNoticeList(startRow, listLimit, searchType,searchKeyword);
	}
	// 공지사항 글 조회 및 조회수 
	public NoticeBoardVO getNotice(int notice_code, boolean isIncreaseReadcount) {
		NoticeBoardVO notice = mapper.selectNotice(notice_code);
		if(notice != null && isIncreaseReadcount) {
			mapper.updateNoticeReadCount(notice);
		}
		return notice;
				
	}
	//자주하는 문의 목록 조회
	public int getFaqListCount() {
		// TODO Auto-generated method stub
		return mapper.selectFaqListCount();
	}
	//자주하는 문의
	public List<FaqBoardVO> getFaqList(@Param("startRow") int startRow, @Param("listLimit") int listLimit) {
		System.out.println(startRow + ", " + listLimit);
		return mapper.selectFaqList(startRow, listLimit);
	}
	// 자주하는 문의 글 조회 및 조회수
	public FaqBoardVO getFaq(int faq_code, boolean isIncreaseReadcount) {
		FaqBoardVO faq = mapper.selectFaq(faq_code);
		if(faq != null && isIncreaseReadcount) {
			mapper.updateFaqReadCount(faq);
		}
		return faq;		
	}
	public int removeNotice(NoticeBoardVO notice) {
		// TODO Auto-generated method stub
		return mapper.deleteNotice(notice);
	}
	
	// 이전글 다음글
	public int getPrevNextCode(int notice_code) {
		// TODO Auto-generated method stub
		return mapper.selectCode(notice_code);
	}



}//cutomerservice

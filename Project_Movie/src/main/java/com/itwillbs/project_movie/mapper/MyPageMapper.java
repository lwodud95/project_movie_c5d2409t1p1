package com.itwillbs.project_movie.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.ReservationCancelVO;
import com.itwillbs.project_movie.vo.ReservationDetailVO;
import com.itwillbs.project_movie.vo.WatchedMovieVO;

public interface MyPageMapper {
	
	// 예매내역 글 전체 가져오기
	int selectReservationDetailCount();
	// 예매내역 시작번호 끝번호 
	List<ReservationDetailVO> selectReservationDetail(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 예매내역 상세 정보 조회
	ReservationDetailVO selectReservationInfo(String r_code);
	// 취소내역 글 전체 가져오기
	int selectReservationCancelCount();
	//취소내역 시작번호, 끝번호 어쩌고
	List<ReservationCancelVO> selectReservationCancel(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 내가 본 영화 글 전체 가져오기
	int selectWathedMovieCount();
	//내가 본 영화 시작번호 끝번호
	List<WatchedMovieVO> selectWatchedMovie(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	//내가 본 영화 - 리뷰 창 띄우기 
	WatchedMovieVO selectWatchedmovieReview(String r_code);
	// 1:1문의 글 전체 가져오기
	int selectInquiryListCount();
	// 1:1문의 시작번호, 끝번호 어쩌고
	List<InquiryVO> selectInquiryList(@Param("startRow")int startRow, @Param("listLimit")int listLimit);
	// 1:1문의 글 선택하면 글 불러오기
	InquiryVO selectInquiry(int inquiry_code);
	
	//1:1문의 글 작성
	int insertInquiry(InquiryVO inquiry);
	
	//1:1문의 글 수정 
	InquiryVO updateInquiry(InquiryVO inquiry);
	//1:1문의 글 삭제 
	int deleteInquiry(InquiryVO inquiry);
	


}

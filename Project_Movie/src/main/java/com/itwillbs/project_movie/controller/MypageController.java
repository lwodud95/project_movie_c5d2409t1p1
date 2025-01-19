package com.itwillbs.project_movie.controller;

import java.net.http.HttpRequest;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.handler.AdminMenuAccessHandler;
import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.service.MovieService;
import com.itwillbs.project_movie.service.MypageService;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.FaqBoardVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;
import com.itwillbs.project_movie.vo.PageInfo;

import kotlin.reflect.jvm.internal.impl.types.model.TypeSystemInferenceExtensionContext;
import retrofit2.http.GET;
import retrofit2.http.POST;

@Controller
public class MypageController {
	@Autowired
	private MypageService service;
	@Autowired
	private AdminManageService adminService;
	
	//1.결제내역 - 예매 내역
	@GetMapping("ReservationDetail")
	public String reservationDetail(@RequestParam (defaultValue="1") int pageNum, Model model) {
		int listCount = service.getReservationListCount();
		int listLimit = 5; 
		int startRow = (pageNum - 1) * listLimit; 
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "ReservationDetail?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageInfo);
		
		List<Map<String, Object>> reservationList = service.getReservationList(startRow, listLimit);
		model.addAttribute("reservationList", reservationList);
		 
		return "mypage/reservation/mypage_reservation_detail";
	}
	//1.1 결제내역 - 상세정보 창
	@ResponseBody
	@PostMapping("ReservationDetail")
	public Map<String, Object> reservationDetail(String payment_code) {
		Map<String, Object> reservationDetail = service.searchdetail(payment_code);
//		reservationDetail.setR_dateToString(reservationDetail.getR_date().toString().replace(".0", ""));
//		System.out.println(reservationDetail.getR_dateToString());
		return reservationDetail;
	}
	//1.2 결제내역 - 예매 취소창
	
	//2. 결제내역 - 예매 취소내역 
	@GetMapping("ReservationCancel")
	public String reservationCancel(@RequestParam (defaultValue="1") int pageNum, Model model) {
		int listCount = service.getReservationCancelCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1: 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "ReservationCancel?pageNum=1");
			return "result/fail";
		}
		PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageinfo);
		
		List<Map<String, Object>> reservationCancel = service.getReservationCancel(startRow, listLimit);
		model.addAttribute("reservationCancel", reservationCancel);
		return "mypage/reservation/mypage_reservation_cancel";
	}
	//3. 무비로그 - 내가 본 영화
	@GetMapping("WatchedMovie")
	public String watchedMovie(@RequestParam(defaultValue="1") int pageNum, Model model) {
		String id = "benddlx";
		int listCount = service.getWatchedMovieCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1: 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "WatchedMovie?pageNum=1");
			return "result/fail";
		}
		PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageinfo);
		
		List<Map<String, Object>> watchedMovie = service.getWatchedMovie(startRow, listLimit);
		for(Map<String, Object> movie : watchedMovie) {
			Map<String, Object> review = service.isRegistReview(id, movie.get("movie_code").toString());
			if(review == null) {
				movie.put("isRegist", 0);
			} else {
				movie.put("isRegist", 1);
			}
		}
		model.addAttribute("watchedMovie", watchedMovie);
		
		return "mypage/movie_log/mypage_watched_movie";
	}
	//3-1. 리뷰 등록창 
	@ResponseBody
	@PostMapping("reviewRegister")
	public Map<String, Object> reviewRegister(String review_code) {
		Map<String, Object> watchedMovie = service.searchWatchedmovieReview(review_code);
//		watchedMovie.setR_dateToString(watchedMovie.getR_date().toString().replace(".0", ""));
		return watchedMovie;
	}
	
	//4. 무비로그 - 관람평 
	@GetMapping("Review")
	public String review(Model model, HttpSession session,@RequestParam(defaultValue="1") int pageNum ) {
		int listCount = service.getReviewListCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1: 0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "Review?pageNum=1");
			return "result/fail";
		}
		PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageinfo);
		
		List<Map<String, Object>> reviewList = service.getReviewList(startRow, listLimit);
		model.addAttribute("reviewList", reviewList);
		
		return "mypage/movie_log/mypage_review";
	}
	// 4-1 watched movie에서 리뷰 등록한걸 넘기기 
	@PostMapping("Review")
	public String review() {
		return "";
	}
	
	//4-2. 리뷰 수정 버튼
	@GetMapping("reviewModify")
	public String reviewModify() {
		return "mypage/movie_log/review_modify";
	}
	//5. 쿠폰 - 쿠폰 보기
	@GetMapping("CouponList")
	public String couponList( Model model, @RequestParam(defaultValue="1") int pageNum) {
		int listCount = service.getCouponListCount();
		int listLimit = 7;
		int startRow = (pageNum - 1) * listLimit; 
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "CouponList?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageInfo);
		
		List<Map<String, String>> couponList = service.getCouponList(startRow, listLimit);
		model.addAttribute("couponList", couponList);
		return "mypage/mycoupon/mycoupon_registration";
	}
	
	//6. 포인트
	@GetMapping("MypointReward")
	public String mypointReward(@RequestParam(defaultValue = "1") int pageNum, Model model ) {
		int listCount = service.getPointListCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit; 
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "MypointReward?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageInfo);
		
		List<Map<String, String>> pointList = service.getPointList(startRow, listLimit);
		model.addAttribute("pointList", pointList);
		
		return "mypage/mypoint/mypoint_reward";
	}
	//7. 1:1 문의 - 글 목록
	@GetMapping("InquiryList")
	public String inquiryList(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		int listCount = service.getInquiryListCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit; 
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "InquiryList?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageInfo);
		
		List<InquiryVO> inquiryList = service.getInquiryList(startRow, listLimit);
		model.addAttribute("inquiryList", inquiryList);
		return "mypage/inquiry/inquiry_list";
	}
	//7-1. 1:1문의 - 글 보기
	@GetMapping("InquiryPost")
	public String inquiryPost(Model model, int inquiry_code, InquiryVO inquiry) {
		inquiry = service.getInquiry(inquiry_code);
		if(inquiry == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다.");
			return "result/fail";
		}
		model.addAttribute("inquiry", inquiry);
		return "mypage/inquiry/inquiry_post";
	}
	//7-2. 1:1문의 - 글 작성 폼
	@GetMapping("InquiryWrite")
	public String inquiryWrite(HttpSession session, Model model) {
		String id = (String)session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			return "result/fail";
		}
		return "mypage/inquiry/inquiryWrite";
	}
	
	//7-3. 1:1문의 - 글 작성 post폼 
	@PostMapping("InquiryWrite")
	public String inquiryWrite(InquiryVO inquiry, HttpServletRequest request, HttpSession session, Model model) {
		System.out.println(inquiry);
		//게시물 작성자의 ip 주소정보를 가져와 vo객체에 저장
		inquiry.setInquiry_writer_ip(getClientIp(request));
		int insertCount = service.registInquiry(inquiry);
		if(insertCount > 0) {
			model.addAttribute("msg", "1:1문의 등록 완료되었습니다");
			return "result/success";
		}else {
			model.addAttribute("msg", "문의 글 작성을 실패하셨습니다.");
			return "result/fail";
		}
	}
	//* 1:1문의 - 글 작성 post폼 유틸리티
	private String getClientIp(HttpServletRequest request) {
		String ipAddress = request.getRemoteAddr();
		System.out.println("작성자 ip 주소 = " + ipAddress);
		if(ipAddress.equals("0:0:0:0:0:0:0:1")) {
			ipAddress = "127.0.0.1";
		}
		return "ipAddress";
	}
	//7-4. 1:1문의 - 글 수정 폼
	@GetMapping("InquiryModify")
	public String inquiryModify(HttpSession session ,Model model, int inquiry_code) {
		//아이디 가져와서 로그인 여부 판별
		//null이면 접근권한이 없습니다
		String id = (String) session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			return "result/fail";
		}
		InquiryVO inquiry = service.getInquiry(inquiry_code);
//		if(inquiry == null || !id.equals("admin") && !equals(inquiry.getInquiry_writer())) {
//			model.addAttribute("msg", "잘못된 접근입니다!");
//			return "result/fail";
//		}
		model.addAttribute("inquiry", inquiry);
		// mypageservice에서 getInquiry메서드 재사용해서 게시물 1개 정보 조회
		//조회결과가 없거나 관리자가 아니거나 작성자가 아닌경우 잘못된접근입니다. 후 fail 페이지로 리턴
		//조회 결과 페이지 정보 저장
//		InquiryVO inquiry = service.getInquiry(inquiry);
		return "mypage/inquiry/inquiryModify";
	}
	//7-4-1 1:1문의 - 글 수정 폼 post
	@PostMapping("InquiryModify")
	public String inquiryModify2(InquiryVO inquiry, Model model, @RequestParam(defaultValue="1") int pageNum) {
		int inquiryUpdateCount = service.getInquiryModify(inquiry);
		if(inquiryUpdateCount > 0) {
			return "redirect:/InquiryPost?inquiry_code=" + inquiry.getInquiry_code() + "&pageNum=" + pageNum;
		}else {
			model.addAttribute("msg", "글 수정에 실패하셨습니다.");
			return "result/fail";
		}
	}
	//7-5. 1:1문의 - 글 삭제 
	@GetMapping("InquiryDelete")
	public String inquiryDelete(HttpSession session ,Model model,@RequestParam(defaultValue="1") int pageNum,
			InquiryVO inquiry , int inquiry_code) {
		String id = (String) session.getAttribute("sMemberId");
		if(id == null) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			return "result/fail";
		}
		//Inquiryvo에서 getInquiry() 호출해서 게시글 상세정보 조회 요청(파라미터 = vo에서 inquiry_code 가져오기)
		//만약 조회 결과가 없거나 관리자 or 작성자가 아닌 경우 경고메시지 출력 후 fail로 리턴
		// service에서 removeCount() 호출해서 int deleteCount로 리턴
		// deleteCount가 양수면 InquriyList의pageNum으로 리다이렉트
		//아니면 글 삭제 실패 띄운 뒤 fail 페이지 리턴 
		inquiry = service.getInquiry(inquiry_code);
		if(inquiry == null) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			return "result/fail";
		}
		int deleteCount = service.removeInquiry(inquiry);
		if(deleteCount > 0) {
			return "redirect:/InquiryList";
		}else {
			model.addAttribute("msg", "글 삭제하는데 실패했습니다");
			return "result/fail";
		}
	}
	
	// 관리자 페이지 - 고객지원 관리 - 공지사항 관리
	@GetMapping("AdminNotice")
	public String adminNotice(@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue ="") String searchKeyword,
			@RequestParam(defaultValue="1") int pageNum, Model model, HttpSession session) {
		// 관리자 로그인 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		int listCount = service.getNoticeListCount(searchType, searchKeyword);
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 :0);
		if(maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit -1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "AdminNotice?pagenum=1");
			return "result/fail";
		}
		
		PageInfo pageinfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageinfo);
		List<NoticeBoardVO> noticeList = service.getNoticeList(startRow, listLimit, searchType, searchKeyword);
		model.addAttribute("noticeList", noticeList);
		return "adminpage/customer_service/notice_board_manage";
	}
	// 관리자페이지 - 공지사항 자세히보기
	@GetMapping("AdminNoticePost")
	public String adminNoticePost(NoticeBoardVO notice, Model model, int notice_code) {
		notice = service.getNotice(notice_code, true);
		if(notice == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다.");
			return "result/fail";
		}
		model.addAttribute("notice", notice);
		
		return "adminpage/customer_service/notice_post";
	}
	//관리자 페이지 - 고객지원 관리 - faq문의 관리
	@GetMapping("AdminFaq")
	public String adminFaq(@RequestParam(defaultValue="1") int pageNum, Model model, HttpSession session) {
		// 관리자 로그인 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		int listLimit = 5; // 한 페이지 당 표시할 게시물 수
		int startRow = (pageNum - 1) * listLimit; // 조회할 게시물의 DB 행 번호
		int listCount = service.getFaqListCount();
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0); // 최대 페이지
		if (maxPage == 0) {
			maxPage = 1;
		}
		//현재 페이지에서 보여줄 시작 페이지 번호 (하단의 번호임)
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; 
		//현재 페이지에서 보여줄 끝 페이지 번호 (하단의 번호) 
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}		
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다");
			model.addAttribute("targetURL", "AdminFaq?pageNum=1");
			return "result/fail";
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);
		List<FaqBoardVO> faqList = service.getFaqList(startRow, listLimit);
		model.addAttribute("faqList", faqList);
		return "adminpage/customer_service/faq_board_manage";
	}
	// 관리자 페이지 - 고객지원 관리 - Faq 글 보기 
	@GetMapping("AdminFaqPost")
	public String adminFaqPost(FaqBoardVO faq , int faq_code, Model model) {
		faq = service.getFaq(faq_code, false);
		if(faq == null) {
			model.addAttribute("msg", "존재하지 않는 게시물입니다.");
			return "result/fail";
		}
		model.addAttribute("faq", faq);
		return "adminpage/customer_service/faq_board_post";
	}
//	 관리자 페이지 - 고객지원 관리 -faq 글 수정 
	@GetMapping("AdminFaqModify")
	public String adminFaqModify(Model model, int faq_code, FaqBoardVO faq) {
		faq = service.getFaq(faq_code, false);
		System.out.println("faq modify " + faq);
		System.out.println(faq_code);
		if(faq == null) {
			model.addAttribute("msg", "해당 게시물은 존재하지 않습니다.");
			return "result/fail";
		}
		model.addAttribute("faq", faq);
		return "adminpage/customer_service/faq_board_modify";
	}	
//	 관리자 페이지 - 고객지원 관리 -faq 글 수정 post
	@PostMapping("AdminFaqModify")
	public String adminFaqModify2(@RequestParam(defaultValue="1") int pageNum, Model model, FaqBoardVO faq) {
		int updateCount = service.getFaqModify(faq);
		
		if(updateCount > 0 ) {
			return "redirect:/AdminFaqPost?faq_code=" + faq.getFaq_code() + "&pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "글 수정을 실패했습니다.");
			return "return/fail";
		}
	}
	//관리자 페이지 - 고객지원 관리 -faq 글 삭제
	@GetMapping("AdminFaqDelete")
	public String adminFaqDelete(FaqBoardVO faq, Model model, int faq_code, int pageNum) {
		faq = service.getFaq(faq_code, false);
		if(faq == null) {
			model.addAttribute("msg", "해당 글은 존재하지 않습니다.");
			return "result/fail";
		}
		int faqDeleteCount = service.getFaqDelete(faq);
		if(faqDeleteCount > 0) {
			return "redirect:/AdminFaq?pageNum=" + pageNum;
		}else {
			model.addAttribute("msg", "글 삭제를 실패했습니다.");
			return "result/fail";
		}
	}
	//관리자 페이지 - 고객지원 관리 - 1:1문의 관리
	@GetMapping("AdminInquiry")
	public String adminInquiry(@RequestParam(defaultValue="1") int pageNum, Model model, HttpSession session) {
		// 관리자 로그인 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("member_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		int listCount = service.getInquiryListCount();
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit; 
		int pageListLimit = 3;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0? 1 : 0);
		if (maxPage == 0) {
			maxPage = 1;
		}
		int startPage = (pageNum -1) / pageListLimit * pageListLimit +1;
		int endPage = startPage + pageListLimit -1;
		if (endPage > maxPage) {
			endPage = maxPage; 
		}
		
		if(pageNum < 1 || pageNum > maxPage) {
			model.addAttribute("msg", "해당 페이지는 존재하지 않습니다.");
			model.addAttribute("targetURL", "AdminInquiry?pageNum=1");
			return "result/fail";
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum );
		model.addAttribute("pageInfo", pageInfo);
		
		List<InquiryVO> inquiryList = service.getInquiryList(startRow, listLimit);
		model.addAttribute("inquiryList", inquiryList);
		return "adminpage/customer_service/inquiry_board_manage";
	}
	//1:1문의 - 글보기 
	@GetMapping("AdminInquiryPost")
	public String adminInquiryPost(Model model, @RequestParam(defaultValue= "1") int pageNum, InquiryVO inquiry, int inquiry_code) {
		inquiry = service.getInquiry(inquiry_code);
		model.addAttribute("inquiry", inquiry);
		return "adminpage/customer_service/inquiry_board_post";
	}
	//1:1문의 - 글 수정 
	@GetMapping("AdmininquiryModify")
	public String admininquiryModify(InquiryVO inquiry, Model model, @RequestParam(defaultValue= "1") int pageNum, int inquiry_code) {
		inquiry = service.getInquiry(inquiry_code);
		model.addAttribute("inquiry", inquiry); 
		return "adminpage/customer_service/inquiry_board_modify";
	}
	//1:1문의 - 글 수정 post
	@PostMapping("AdmininquiryModify")
	public String admininquiryModify(int inquiry_code, InquiryVO inquiry, @RequestParam(defaultValue= "1")int pageNum, Model model) {
		int updateCount = service.getInquiryModify(inquiry_code);
		if(updateCount > 0) {
			return "redirect:/AdminInquiry?inquiry_code=" +inquiry.getInquiry_code() + "&pageNum=" + pageNum;
		}else {
			model.addAttribute("msg", "글을 수정하는데 실패하셨습니다.");
			return "result/fail";
		}
	}
	//1:1문의 - 글 삭제 
	@GetMapping("AdminInquiryDelete")
	public String adminInquiryDelete(int inquiry_code, Model model, InquiryVO inquiry, @RequestParam(defaultValue= "1")int pageNum) {
		int inquiryDeleteCount = service.getInquiryDelete(inquiry_code);
		if(inquiryDeleteCount > 0) {
			return "redirect:/AdminInquiry&pageNum=" + pageNum;
		}else {
			model.addAttribute("msg", "글을 삭제하는데 실패하셨습니다.");
			return "result/fail";
		}
	}
	//top에 있는 마이페이지 연결
	@GetMapping("MypageMain")
	public String MypageMain() {
		return"mypage/mypage_main";
	}
	
	
}

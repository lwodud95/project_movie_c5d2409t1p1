package com.itwillbs.project_movie.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project_movie.handler.AdminMenuAccessHandler;
import com.itwillbs.project_movie.handler.PagingHandler;
import com.itwillbs.project_movie.service.AdminManageService;
import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.GetGiveCouponInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.PageInfo;
import com.itwillbs.project_movie.vo.PageInfo2;
import com.itwillbs.project_movie.vo.PointVO;

@Controller
public class AdminEventManageController {
	@Autowired
	private AdminManageService adminService;
	
	@Autowired
	private PagingHandler pagingHandler;
		
	@GetMapping("EventBoardManage") // 이벤트 게시판 관리 + 리스트 출력
	public String eventBoardManagement(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
										@RequestParam(defaultValue = "") String searchKeyword,
										@RequestParam(defaultValue = "") String searchContent) {
		// 로그인 유무 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "eventBoardList", searchKeyword, searchContent);
		List<EventBoardVO> eventList = adminService.eventBoardList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("eventVo", eventList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/event_manage/event_board_manage";
	}
	
	@GetMapping("EventBoardRegis") // 이벤트 게시글 등록폼
	public String eventBoardRegisForm() {
		return "adminpage/event_manage/event_board_regis";
	}
	
	@GetMapping("EventBoardRegisSubmit") // 이벤트 게시글 등록폼 제출
	public String eventBoardRegistration(EventBoardVO eventVo, HttpSession session) {
		String admin_sId = (String) session.getAttribute("admin_sId");
//		String sId = "admin";
		eventVo.setEvent_writer(admin_sId);
		System.out.println(eventVo);
		adminService.regisEventBoard(eventVo);
		
		return "redirect:/EventBoardManage";
	}
	
	@GetMapping("StartEvent") // 선택한 이벤트 시작 상태로 변경
	public String startEvent(@RequestParam("event_code") int[] event_codes) {
		for(int code : event_codes) {
			System.out.println("시작할 이벤트 코드 : " + code);
		}
		adminService.setEventStart(event_codes);
		
		return "redirect:/EventBoardManage";
	}
	
	@GetMapping("EndEvent") // 선택한 이벤트 종료 상태로 변경
	public String endEvent(@RequestParam("event_code") int[] event_code) {
		for(int code : event_code) {
			System.out.println("종료할 이벤트 코드 : " + code);
		}
		adminService.setEventEnd(event_code);
		
		return "redirect:/EventBoardManage";
	}

	@GetMapping("updateEventBoard") // 이벤트 게시글 수정폼 이동
	public String updateEventBoard(int event_code, EventBoardVO eventVo, Model model) {
		eventVo = adminService.updateEventBoard(event_code);
		model.addAttribute("eventVo", eventVo);
		
		return "adminpage/event_manage/event_board_modify";
	}
	
	@PostMapping("updateEventBoard") // 이벤트 게시글 수정폼 제출
	public String eventBoardModify(EventBoardVO eventVo) {
		
		return "";
	}
	
	@PostMapping("checkEventStatus") // 이벤트 종료 여부 ajax 응답
	@ResponseBody
	public Boolean checkEventStatus(int event_code) {
		EventBoardVO statusResult = adminService.selectWinner(event_code);
		Boolean checkSetWinnerStatus = statusResult.getSet_winner_status();
		int checkEventStatus = statusResult.getEvent_status();
		
		System.out.println("이벤트 코드 : " + event_code);
		System.out.println("이벤트 상태 : " + checkEventStatus);
		System.out.println("당첨 상태 : " + checkSetWinnerStatus);
		
		if(checkEventStatus == 2 && checkSetWinnerStatus == false) {
			return true;
		} else {
			return false;
		}
	}
	
	@PostMapping("checkStatusBeforeStart")
	@ResponseBody
	public Boolean checkEventStatusBeforeStart(int event_code) {
		EventBoardVO statusResult = adminService.selectWinner(event_code);
		int checkEventStatus = statusResult.getEvent_status();
		
		if(checkEventStatus == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@PostMapping("checkStatusBeforeEnd")
	@ResponseBody
	public Boolean checkEventStatusBeforeEnd(int event_code) {
		EventBoardVO statusResult = adminService.selectWinner(event_code);
		int checkEventStatus = statusResult.getEvent_status();
		
		if(checkEventStatus == 1) {
			return true;
		} else {
			return false;
		}
	}
	
	@GetMapping("ChooseEventWinner") // 이벤트 당첨자 추첨 폼 이동
	public String chooseEventWinner(int event_code, Model model) {
		System.out.println("이벤트 당첨 컨트롤러 이동");
		EventBoardVO eventVo = adminService.selectWinner(event_code);
		List<MemberVO> memberVo = adminService.getMemberList();

		model.addAttribute("eventVo", eventVo);
		model.addAttribute("memberVo", memberVo);
		
		return "adminpage/event_manage/choose_event_winner";
	}
	
	@GetMapping("GiveCoupon") // 이벤트 당첨자 선택 후 쿠폰 지급 화면 이동
	public String giveCoupon(@RequestParam("member_id") List<String> member_id, int event_code, Model model) {
		for(String id : member_id) {
			System.out.println("쿠폰 증정 대상자 : " + id);
		}
		model.addAttribute("member_id", member_id);
		model.addAttribute("event_code", event_code);
		
		return "adminpage/coupon_manage/coupon_regis";
	}
	
	@PostMapping("GiveCoupon")
	public String giveCouponToWinner(GetGiveCouponInfoVO vo) {
		adminService.insertCoupon(vo);
		return "redirect:/CouponWinnerManage";
	}
	
	@GetMapping("GivePoint") // 이벤트 당첨자 선택 후 포인트 지급 화면 이동
	public String givePoint(@RequestParam("member_id") List<String> member_id, int event_code, Model model) {
		model.addAttribute("member_id", member_id);
		model.addAttribute("event_code", event_code);
		
		return "adminpage/point_manage/point_regis";
	}
	
	@PostMapping("GivePoint")
	public String givePointToWinner(@RequestParam("member_id") List<String> member_id, int point_amount, int event_code) {
		System.out.println("지급 대상자 : " + member_id);
		System.out.println("이벤트 코드 : " + event_code);
		System.out.println("지급할 포인트 : " + point_amount);
		adminService.GivePointToWinner(member_id, event_code, point_amount);
		
		return "redirect:/PointWinnerManage";
	}
	
	@GetMapping("CouponWinnerManage") // 이벤트 당첨자 표시 페이지
	public String couponWinnerPage(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
									@RequestParam(defaultValue = "") String searchKeyword,
									@RequestParam(defaultValue = "") String searchContent) {
		// 로그인 유무 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "couponWinnerList", searchKeyword, searchContent);
		List<EventWinnerVO> coupon_winner = adminService.getEventWinnerList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("coupon_winner", coupon_winner);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/coupon_manage/coupon_winner_manage";
	}

	@GetMapping("PointWinnerManage") // 이벤트 당첨자 표시 페이지
	public String pointWinnerPage(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
									@RequestParam(defaultValue = "") String searchKeyword,
									@RequestParam(defaultValue = "") String searchContent) {
		// 로그인 유무 판별
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "pointWinnerList", searchKeyword, searchContent);
		List<EventWinnerVO> point_winner = adminService.getPointWinnerList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		
		model.addAttribute("point_winner", point_winner);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/point_manage/point_winner_manage";
	}
	
	@GetMapping("CouponBoardManage") // 쿠폰 관리 페이지
	public String couponBoardManagement(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
										@RequestParam(defaultValue = "") String searchKeyword,
										@RequestParam(defaultValue = "") String searchContent) {
		System.out.println("컨트롤러 pageNum : " + pageNum);
		
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "couponList", searchKeyword, searchContent);
		System.out.println("pageInfo 값 : " + pageInfo);
		List<CouponVO> couponVo = adminService.getCouponList(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		model.addAttribute("couponVo", couponVo);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/coupon_manage/coupon_board_manage";
	}
	
	@GetMapping("PointBoardManage") // 포인트 관리 페이지
	public String pointBoardManagement(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session,
										@RequestParam(defaultValue = "") String searchKeyword,
										@RequestParam(defaultValue = "") String searchContent) {
		if(!AdminMenuAccessHandler.adminLoginCheck(session)) {
			model.addAttribute("msg", "로그인 후 이용가능");
			model.addAttribute("targetURL", "AdminLogin");
			return "result/process";
		}
		
		// 관리자 메뉴 접근권한 판별
		if(!AdminMenuAccessHandler.adminMenuAccessCheck("vote_manage", session, adminService)) {
			model.addAttribute("msg", "접근 권한이 없습니다.");
			model.addAttribute("targetURL", "AdminpageMain");
			return "result/process";
		}
		
		PageInfo2 pageInfo = pagingHandler.pagingProcess(pageNum, "pointList", searchKeyword, searchContent);
		
		List<PointVO> pointVo = adminService.getPointRecord(pageInfo.getStartRow(), pageInfo.getListLimit(), searchKeyword, searchContent);
		
		model.addAttribute("pointVo", pointVo);
		model.addAttribute("pageInfo", pageInfo);
		
		return "adminpage/point_manage/point_board_manage";
	}

}


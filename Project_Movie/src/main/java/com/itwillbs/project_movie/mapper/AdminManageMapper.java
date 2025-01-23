package com.itwillbs.project_movie.mapper;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.AdminRegisVO;
import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.EventBoardVO;
import com.itwillbs.project_movie.vo.EventWinnerVO;
import com.itwillbs.project_movie.vo.InquiryVO;
import com.itwillbs.project_movie.vo.MemberAllInfoVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.NoticeBoardVO;
import com.itwillbs.project_movie.vo.PaymentVO;
import com.itwillbs.project_movie.vo.PointVO;

@Mapper
public interface AdminManageMapper {

	int insertAccount(AdminRegisVO adminVo);

	int deleteAdminAccount(@Param("id") String id);

	void insertEventBoard(EventBoardVO eventVo);

	List<EventBoardVO> selectEventBoardList();

	void updateEventStatusStart(@Param("event_code") int event_code);

	void updateEventStatusEnd(@Param("event_code") int event_code);

	EventBoardVO getEventBoardList(@Param("event_code") int event_code);

	String checkAdminId(@Param("id") String id);

	int getBoardListCount();

	AdminRegisVO selectAdminAccountInfo(@Param("admin_id") String admin_id);

	void adminAccountModify(AdminRegisVO modifyVo);

	AdminRegisVO adminLogin(AdminRegisVO adminLoginInfo);

	List<AdminRegisVO> getEndEventList();

	List<MemberVO> selectMemberInfoForEvent();

	int insertCoupon(CouponVO coupon);

	List<EventWinnerVO> selectAllEventWinner(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent); // 쿠폰 당첨자 리스트
	
	List<EventWinnerVO> getPointWinnerList(@Param("startRow") int startRow, 
										   @Param("listLimit") int listLimit, 
										   @Param("searchKeyword") String searchKeyword, 
										   @Param("searchContent") String searchContent); // 포인트 당첨자 리스트

	EventBoardVO checkEventStatus(@Param("event_code") int event_code);

	int creditPoint(@Param("id") String id, 
					 @Param("point_amount") int point_amount);

	int insertPointInfo(@Param("id") String id, 
			 			 @Param("event_code") int event_code, 
			 			 @Param("point_amount") int point_amount);

	List<PointVO> getPointRecord(@Param("startRow") int startRow, 
								@Param("listLimit") int listLimit, 
								@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);

	List<CouponVO> getCouponList(@Param("startRow") int startRow, 
								@Param("listLimit") int listLimit, 
								@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);

	List<Map<String, String>> getCouponInfo();

	void updateEventWinnerSetStatus(@Param("event_code") int event_code);

	List<MemberAllInfoVO> getMemberAllInfo();

	List<AdminRegisVO> selectAdminPagingListPaging(@Param("startRow") int startRow, 
												   @Param("listLimit") int listLimit);
	
	List<MemberAllInfoVO> selectMemberListPaging(@Param("startRow") int startRow, 
												 @Param("listLimit") int listLimit, 
												 @Param("searchKeyword") String searchKeyword, 
												 @Param("searchContent") String searchContent);
	
	int getAdminListCount();
	
	int getMemberListCount(@Param("searchKeyword") String searchKeyword, 
						   @Param("searchContent") String searchContent);
	
	int getEventBoardListCount(@Param("searchKeyword") String searchKeyword, 
							   @Param("searchContent") String searchContent);
	
	int getCouponWinnerListCount(@Param("searchKeyword") String searchKeyword, 
								 @Param("searchContent") String searchContent);

	int getPointWinnerListCount(@Param("searchKeyword") String searchKeyword, 
								@Param("searchContent") String searchContent);

	int getCouponListCount(@Param("searchKeyword") String searchKeyword, 
							@Param("searchContent") String searchContent);

	int getPointListCount(@Param("searchKeyword") String searchKeyword, 
						@Param("searchContent") String searchContent);

	List<MemberVO> searchMemberList(@Param("searchKeyword") String searchKeyword, 
									@Param("searchContent") String searchContent);

	List<EventBoardVO> selectEventBoardList(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent);
	
	// 2, 3번 차트 월 가입자 수 조회
	int getMonthlyTotalNewMember(@Param("year")int year,
								@Param("month")int month);

	List<EventWinnerVO> getAllEventWinnerList(@Param("startRow") int startRow, 
											@Param("listLimit") int listLimit, 
											@Param("searchKeyword") String searchKeyword, 
											@Param("searchContent") String searchContent);

	int modifyEventBoard(EventBoardVO eventVo);

	int deleteEventBoard(@Param("event_code") int event_code);

	int checkEventStatusForDelete(@Param("event_code") int event_code);

	int getMemberCount(@Param("searchKeyword") String searchKeyword, @Param("searchContent") String searchContent);

	String getTotalPeriodMemberJoin(@Param("year") String year);
	
	// 회원 계정 대량 생성 매크로
	void createMembers(MemberVO member); 

	int getAllEventWinnerCount(@Param("searchKeyword") String searchKeyword, 
							  @Param("searchContent") String searchContent);

	List<EventWinnerVO> getWinnerList(@Param("event_code") int event_code);

	int getSingleEventWinnerCount(@Param("event_code") int event_code);

	List<NoticeBoardVO> getNoticeBoardList();

	List<InquiryVO> getInquiryBoardList();

	MemberVO getMyInfo(@Param("sMemberId") String sMemberId);

	String getDbPasswd(@Param("member_id") String member_id);

	int updateMyInfo(MemberVO member);
	
	// 매출 데이터 대량 생성 매크로
	void createSalesRecord(PaymentVO payment); // 매출 생성 메크로
	
	// 월 매출액 조회
	int getMonthlySales(@Param("year") int year, @Param("month") int month);
	
	// 월 총환불액 조회
	int getMonthlyRefund(@Param("year") int year, @Param("month") int month);
	
	// 전체 기간(연 단위) 매출액 출력을 위한 연 단위 매출액 조회
	int getAnnualSales(@Param("year") int year);
	
	// 연 단위 환불액 조회
	int getAnnualRefund(@Param("year") int year);
	
	// 스케줄러로 매일 09시 20분에 쿠폰 기한 만료 시 '사용불가' 처리
	void handlingExpiredCoupon(@Param("date") LocalDate date);
	
	// 이벤트 당첨자 목록 조회
	List<String> getBookingEventWinnerList(@Param("event_start_date") Date event_start_date, @Param("event_end_date") Date event_end_date);
	
	// 매출 데이터 생성에 필요한 멤버 아이디 조회 
	List<String> getMemberIdList();
	
	// 일일 매출 데이터 조회
	List<Map<String, Object>> getDailySales(@Param("firstDay") LocalDate firstDay, @Param("lastDay")LocalDate lastDay);
	
	// 관리자가 직접 포인트 지급
	void addPointInfo(@Param("id") String id, @Param("point_amount") int point_amount);
	
	// 관리자가 직접 쿠폰 지급
	int createCoupon(@Param("expiredDate") Date expiredDate, @Param("couponType") String couponType, 
					@Param("discountRate") int discountRate, @Param("discountAmount")int discountAmount, @Param("id")String id);

//	int getMonthlyNewMember(@Param("year")int year, @Param("month")int month);

}

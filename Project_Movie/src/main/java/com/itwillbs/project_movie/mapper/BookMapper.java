package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.CouponVO;
import com.itwillbs.project_movie.vo.MemberVO;
import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.PaymentVO;
import com.itwillbs.project_movie.vo.ScheduleVO;
import com.itwillbs.project_movie.vo.SeatVO;
import com.itwillbs.project_movie.vo.TicketVO;


@Mapper
public interface BookMapper {

	List<MovieVO> selectMovieList();

	List<Map<String, Object>> selectSchWithMovie(Map<String, String> conditionMap);

	List<SeatVO> selectSeat();

	Map<String, String> getSelectMovie(String movie_code);

	List<TicketVO> selectTicketType();
	
	List<MovieVO> selectMovieList2(Map<String, String> conditionMap);

	List<ScheduleVO> selectScheduleList(Map<String, String> conditionMap);

	Map<String, Object> selectScheduleInfoByScheduleCode(String schedule_code);

	void insertPaymentTable(Map<String, String> map);

	int insertBookingTable(@Param("insertBookingList") List<Map<String, String>> insertBookingList);

	int selectMyPoint(String id);

	List<Map<String, Object>> selectMyCouponList(String id);

	CouponVO selectMyCoupon(String coupon_code);

	MemberVO selectMemberWhoPayTicket(String id);

	PaymentVO selectPaymentInfo(String payment_code);

	int updateBookingTicket(Map<String, String> map);

	void insertPointDebited(@Param("map") Map<String, String> map, @Param("id") String id);

	void updateCouponStatus(Map<String, String> map);

	List<Map<String, Object>> selectDisabledSeat(String schedule_code);

	int selectTotalDiscount(Map<String, Object> map);

	void insertRefundInfo(Map<String, Object> map);

	int updateRefundPayment(Map<String, Object> map);

	void insertRefundPoint(Map<String, Object> map);

	int selectPaymentListCount(@Param("howSearch") String howSearch, @Param("searchKeyword") String searchKeyword);

	List<Map<String, Object>> selectPaymentList(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
			@Param("howSearch") String howSearch, @Param("searchKeyword") String searchKeyword);

	int selectRefundCount(@Param("howSearch") String howSearch, @Param("searchKeyword") String searchKeyword);

	List<Map<String, Object>> selectRefundList(@Param("startRow") int startRow, @Param("listLimit") int listLimit,
			@Param("howSearch") String howSearch, @Param("searchKeyword") String searchKeyword);

	List<SeatVO> selectSeatByTheater(String theater_code);

	int updateSeatAvail(@Param("theater_code") String theater_code, @Param("seatCodeArr") String[] seatCodeArr, @Param("seat_avail") String seat_avail);












}

package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.MovieVO;
import com.itwillbs.project_movie.vo.ReviewVO;

@Mapper
public interface MovieMapper {
	
	// 영화 등록 메서드
	int insertMovie(MovieVO movieVO);
	
	// 영화코드로 영화 조회 메서드
	MovieVO SelectMovieByCode(String movie_code);
	
	// 총 영화목록 수 조회 메서드
	int selectMovieListCount(@Param("movie_status") String movie_status, @Param("howSearch") String howSearch, @Param("searchKeyword") String searchKeyword);
	
	// 영화목록 조회
	List<MovieVO> selectMovieList(@Param("movie_status") String movie_status, @Param("startRow") int startRow, @Param("listLimit") int listLimit,
			@Param("howSearch") String howSearch, @Param("searchKeyword") String searchKeyword);
	
	// 조건에 따른 영화목록 조회 메서드
	List<MovieVO> selectMovieListCheck(Map<String, String> map);
	
	// 영화상태 업데이트 메서드
	int updateMovieStatus(Map<String, String> map);
	
	// 컬럼명, 데이터를 파라미터로 전달받아 해당하는 영화의 수 조회 메서드
	int selectMovieCount(Map<String, String> conditionMap);
	
	// 영화 정보 삭제
	int deleteMovie(String movie_code);
	
	// 상영시작일, 상영종료일 업데이트
	int updateScreeningPeriod(MovieVO movieVO);
	
	// 영화상태 대기 변경(복수)
	int updateMovieStatusToStandBy(@Param("movie_status") String movie_status, @Param("movieCodeArr") String[] movieCodeArr);
	
	// 영화가격 조회
	int selectTicketPrice();
	
	// 영화상태 상영예정작, 영화타입 시즌 으로 변경(복수)
	void updateMovieStatusToSeasonUpcoming(@Param("movie_status") String movie_status, @Param("movie_type") String movie_type,
			@Param("winnerCodeList") List<String> winnerCodeList);
	
	// 해당영화의 리뷰 조회
	List<ReviewVO> selectReviewListOfMovie(String movie_code);

	
}

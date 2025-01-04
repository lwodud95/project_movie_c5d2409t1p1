package com.itwillbs.project_movie.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.MovieVO;

@Mapper
public interface MovieMapper {
	
	// 영화 등록 메서드
	int insertMovie(MovieVO movieVO);
	
	// 영화 조회 메서드
	MovieVO SelectMovie(String movie_code);
	
	// 총 영화목록 수 조회 메서드
	int selectMovieListCount();
	
	// 영화목록 조회
	List<MovieVO> selectMovieList(@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// WHERE 조건에 따른 검색 메서드
	List<MovieVO> selectSearchMovie(Map<String, String> map);
	
	// 영화상태 업데이트 메서드
	int updateMovieStatus(Map<String, String> map);
	
	// 컬럼명, 데이터를 파라미터로 전달받아 해당하는 영화의 수 조회 메서드
	int selectMovieCount(Map<String, String> map);
	
}

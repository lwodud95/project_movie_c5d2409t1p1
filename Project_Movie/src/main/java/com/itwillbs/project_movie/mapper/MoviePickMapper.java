package com.itwillbs.project_movie.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_movie.vo.MemberVO;

@Mapper
public interface MoviePickMapper {
	
	// 투표 정보 등록
	int insertVoteInfo(Map<String, String> map);
	
	// 투표 정보 조회
	Map<String, Object> selectVoteInfo();
	
	// 투표 상태 업데이트
	int updateVoteStatus(@Param("vote_code") String vote_code, @Param("vote_status") int vote_status);


}

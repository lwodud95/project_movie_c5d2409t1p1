$(function() {
	
	// 날짜 선택 시 ajax로 해당 날짜 시간표 출력
	$(".date_item").click(function() {
		$(".sec01").css("display", "flex");
		isDateSelected = true;
		selectedDate = $(this).data("date");
	    console.log("선택된 날짜 : " + selectedDate);
		
		// 스케줄 조회 메서드
		loadSchedule(selectedDate, selectedMovie);
	});
	
//	$(".mv_sel select").change(function(){
//		$(this).val();
//		location.href="BookTickets?howOrder=" + $(this).val();
//		console.log($(this).val());
//	});
	
	
	
	// 예매 날짜 영화 선택시 스케줄 표시 메서드
	function loadSchedule(selectedDate, selectedMovie) {
		
		// 날짜 및 영화 선택시 조건에 해당하는 영화만 연령등급 영화명 표시
		$.ajax({
			type : "GET",
			url : "GetMovieListScheduleToBooking",
			data : {
				start_time : selectedDate,
				movie_code : selectedMovie
			}
		}).done(function(movieList) {
			$(".movie_schedule_info").empty();
			$(".movie_schedule_info").css("display", "none");
			
			for(let movie of movieList) {
				let ageLimit = movie.age_limit;
				let img = "";
				if(ageLimit == "12세이상관람가") {
					img = `<img src="${contextPath}/resources/images/mv_age(12).png">`;
				} else if(ageLimit == "15세이상관람가") {
					img = `<img src="${contextPath}/resources/images/mv_age(15).png">`;
				} else if(ageLimit == "청소년관람불가") {
					img = `<img src="${contextPath}/resources/images/mv_age(19).png">`;
				} else {
					img = `<img src="${contextPath}/resources/images/mv_age(all).png">`;
				}
				
				$(".movie_schedule_info").append(`
					<section class="sec01" id='${movie.movie_name}'">
					    <div class="movie_container">
					        <div class="mv_age">
						       ${img}
							</div>
					        <div class="mv_title">${movie.movie_name}</div>
					    </div>
					    <div class="time_seat_container" id="${movie.movie_code}">
					    </div>
					</section>
				`);
			}
				
			
			// 날짜 및 영화 선택시 조건에 해당하는 스케줄 해당영화 섹션에 표시
			$.ajax({
				type : "GET",
				url : "GetScheduleListToBooking",
				data : {
					start_time : selectedDate,
					movie_code : selectedMovie
				}
			}).done(function(scheduleList) {
				console.log(scheduleList.length);
				if(scheduleList.length != 0) {
					
					for(let schedule of scheduleList) {
						let hallName = schedule.theater_code;
						if(hallName == "T1") {
							hallName = "1관";
						} else if(hallName == "T2") {
							hallName = "2관";
						} else {
							hallName = "3관";
						}
						
						// 시간 버튼 출력
						$("#" + schedule.movie_code).append(`
						    <a class="time_seat_btn">
						        <input type="hidden" value="${schedule.schedule_code}">
						        <span class="mv_time">${schedule.str_start_time}</span>
						        <span class="details">
						            <span class="seat">70/${schedule.avail_seat}</span>
						            <span class="hall">${hallName}</span>
						        </span>
						    </a>
						`);
					}
					
				} else if(true) {
					$(".movie_schedule_info").empty();
					$(".movie_schedule_info").append(`
						<h4>해당 영화의 스케줄이 존재하지 않습니다.</h4>
					`);
				}
				
				$(".movie_schedule_info").css("display", "block");
				
				$(".time_seat_btn").click(function() {
					schCode = $(this).find("input[type='hidden']").val();
					console.log(schCode);
					
					if(confirm("좌석선택 페이지로 이동하시겠습니까?")) {
						location.href = "BookSeat?schedule_code=" + schCode;
					}
				});
				
			}).fail(function() {
				alert("스케줄 조회에 실패하였습니다.")
			});

		}).fail(function() {
			alert("영화 정보 조회에 실패하였습니다.")
		});
	}
	
	
	
	

});








$(function() {
	let selectedDate = "";
	let selectedMovie = "";
	
	// 현재시간과 상영시간 비교해 차이가 20분 이하면 얼럿
	let currentTime = "";
	let startTime = "";
	let timeDifference = "";
	
	// 날짜 선택 시 ajax로 해당 날짜 시간표 출력
	$(".date_item").click(function() {
		$(".sec01").css("display", "flex");
		selectedDate = $(this).data("date");
	    console.log("선택된 날짜 : " + selectedDate);
		
		// 스케줄 조회 메서드
		loadSchedule(selectedDate, selectedMovie);
	});
	
	// 예매 날짜 영화 선택시 스케줄 표시 메서드
	function loadSchedule(selectedDate, selectedMovie) {
		
		// 날짜 선택시 조건에 해당하는 영화만 연령등급 영화명 표시
		$.ajax({
			type : "GET",
			url : "GetMovieListScheduleToBooking",
			data : {
				start_time : selectedDate,
				movie_code : selectedMovie
			}
		}).done(function(movieList) {
			$(".movie_schedule_info").empty();
//			$(".movie_schedule_info").css("display", "none");
			
			for(let movie of movieList) {
				let ageLimit = movie.age_limit;
				let img = "";
				if(ageLimit == "12세이상관람가") {
					img = `<img src="resources/images/mv_age(12).png">`;
				} else if(ageLimit == "15세이상관람가") {
					img = `<img src="resources/images/mv_age(15).png">`;
				} else if(ageLimit == "청소년관람불가") {
					img = `<img src="resources/images/mv_age(19).png">`;
				} else {
					img = `<img src="resources/images/mv_age(all).png">`;
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
				
			
			// 날짜 선택시 조건에 해당하는 스케줄 해당영화 섹션에 표시
			$.ajax({
				type : "GET",
				url : "GetScheduleListToBooking",
				data : {
					start_time : selectedDate,
					movie_code : selectedMovie
				}
			}).done(function(scheduleList) {
				if(scheduleList.length != 0) {
					
					for(let schedule of scheduleList) {
						// 현재시간과 상영시간의 차이 비교
						currentTime = new Date();
						startTime = new Date(schedule.start_time);
						timeDifference = (startTime - currentTime) / (1000 * 60);

						let hallName = schedule.theater_code;
						if(hallName == "T1") {
							hallName = "1관";
						} else if(hallName == "T2") {
							hallName = "2관";
						} else {
							hallName = "3관";
						}
						
						// 조조, 심야영화 아이콘
						let timeIcon = "";
						if(schedule.showtime_type == '조조') {
							timeIcon = `<img src="resources/images/jojo.png">`;
						} else if(schedule.showtime_type == '심야') {
							timeIcon = `<img src="resources/images/night.png">`;
						}
						
						// 시간 버튼 출력
						$("#" + schedule.movie_code).append(`
						    <a class="time_seat_btn" id="${schedule.schedule_code}" data-time-difference="${timeDifference}">
						        <input type="hidden" value="${schedule.schedule_code}">
						        <input type="hidden" class="isBookingAvail" value="${schedule.booking_avail}">
						        <span class="mv_time">${schedule.str_start_time}</span>
						        <span class="details">
						            <span class="hall">${hallName}</span>
						        </span>
								<div class="end_time">종료 ${schedule.str_end_time}</div>
								<div class="icon">${timeIcon}</div>
						    </a>
						`);
						
						// 예매 불가능한 스케줄 버튼 어둡게
						if(schedule.booking_avail == 0) {
							$("#" + schedule.schedule_code).css({
							    "background": "#ddd",
							    "color": "#999",
							    "border": "1px solid #ccc",
							    "cursor": "default",
								"box-shadow": "inset 0px 0px 5px rgba(0, 0, 0, 0.2)"
							});

						}
						
						// 시간 버튼에 남은 좌석 출력
						$.ajax({
							type : "GET",
							url : "GetAvailSeatFromSchedule",
							data : {
								schedule_code : schedule.schedule_code
							}
						}).done(function(disabledSeatList) {
							$("#" + schedule.schedule_code).find(".details").prepend(`<span class="seat">${schedule.avail_seat - disabledSeatList.length}/${schedule.avail_seat}</span>`);
						});
					}
					
				} else if(true) {
					$(".movie_schedule_info").empty();
					$(".movie_schedule_info").append(`
						<h4>해당 날짜의 스케줄이 존재하지 않습니다.</h4>
					`);
				}
				
				$(".movie_schedule_info").css("display", "block");
				
				// 시간 버튼 클릭 시 스케줄 코드 가지고 좌석 선택 페이지로 이동
				$(".time_seat_btn").click(function() {
					if($(this).find(".isBookingAvail").val() == 1) {
						schCode = $(this).find("input[type='hidden']").val();
						timeDifference = $(this).data("time-difference");
						console.log(schCode);
						
						// 현재시간과 상영시간의 차가 20분 이하인지 판별해서 각각 다른 얼럿
						if(timeDifference > 20) {
							if(confirm("좌석선택 페이지로 이동하시겠습니까?")) {
								location.href = "BookSeat?schedule_code=" + schCode;
							}
						} else {
							if(confirm("예매 취소는 상영시간 20분 전까지만 가능합니다.\n좌석선택 페이지로 이동하시겠습니까?")) {
								location.href = "BookSeat?schedule_code=" + schCode;
							}
						}
					} else {
						alert("예매종료된 스케줄입니다.")
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








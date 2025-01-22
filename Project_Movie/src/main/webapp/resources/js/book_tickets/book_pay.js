$(function() {
	// 쿠폰 버튼
	$(".checkCouponRadio").click(function() {
		let coupon_code = $(this).val();
		$.ajax({
			type : "GET",
			url : "GetMyCouponDetailInfo",
			data : {
				coupon_code
			}
		}).done(function(coupon) {
			if(coupon.coupon_type == 0) {
				let calAmount = $(".div01 .price").text() - coupon.discount_amount;
				if(calAmount < 0) {
					if(confirm("할인 금액이 결제 금액보다 큽니다.\n사용하시겠습니까?")) {
						calAmount = 0;
					} else {
						location.reload();
					}
				}
				$(".div02 .price").text(coupon.discount_amount);
				$(".div03 .price").text(calAmount);
				$("input[name='total_discount']").val($(".div02 .price").text());
			} else {
				let discountAmount = $(".div01 .price").text() * coupon.discount_rate / 100;
				$(".div02 .price").text(discountAmount);
				$(".div03 .price").text($(".div01 .price").text() - discountAmount);
				$("input[name='total_discount']").val($(".div02 .price").text());
			}
		}).fail(function() {
			alert("쿠폰 적용에 실패하였습니다");
		});
		
		
	});
	
	// 포인트 칸
	$(".point_form").keyup(function() {
		let myPoint = parseInt($(".point02").text().replace(" p", ""));
		
		if($(this).val() > 5000) { // 입력값이 5000보다 클 때
			alert("최대 5000p 사용 가능합니다.")
			$(".div02 .price").text(0);
			$(".div03 .price").text($(".div01 .price").text());
			$(this).val("");
		} else {
			if(myPoint < $(this).val()) {
				alert("보유 포인트를 초과하여 사용하실 수 없습니다");
				$(".div02 .price").text(0);
				$(".div03 .price").text($(".div01 .price").text());
				$(this).val("");
			} else {
				$(".div02 .price").text($(this).val());
				$(".div03 .price").text($(".div01 .price").text() - $(this).val());
				$("input[name='total_discount']").val($(".div02 .price").text());
			}
		}
		
	});

	
	// 결제 버튼 클릭 시 선택되어 있는 결제수단으로 결제
	$(".payment_btn").click(function() {
		if($(".pay:checked").length == 0) {
			alert("결제수단을 선택해주세요");
			return false;
		} else if($(".pay").eq(0).is(':checked')) {
			// 신용카드
			KGmobilians();
		} else if($(".pay").eq(1).is(':checked')) {
			// 카카오페이
			kakaopay();
		} else if($(".pay").eq(2).is(':checked')) {
			// 토스페이
			tosspay();
		}
	});
	
	function sessionExpired() {
	    alert('결제 시간이 만료되었습니다. 처음부터 다시 시도해 주세요.');
		location.href="BookTickets";
	}
	
	// 10분 후에 sessionExpired 메서드를 호출합니다.
	setTimeout(sessionExpired, 600 * 1000);


});























$(function () {
    let payment_code = "";
    let movie_name = "";
    let start_time = "";
    let total_payment = "";

    // 마이페이지 예매내역 정보
    $("table").on("click", "tr", function () {
        $(this).find("input[type='radio']").prop("checked", true);
        payment_code = $(this).find("td:eq(1)").text().trim();
        movie_name = $(this).find("td:eq(2)").text().trim();
        start_time = $(this).find("td:eq(6)").text().trim();
        total_payment = parseInt($(this).find("td:eq(7)").text().trim());
    });

    // 관리자페이지 예매내역 정보
    $("#sec02 table").on("click", "tr", function () {
        $(this).find("input[type='radio']").prop("checked", true);
        payment_code = $(this).find("td:eq(1)").text().trim();
        movie_name = $(this).find("td:eq(3)").text().trim();
        start_time = $(this).find("td:eq(4)").text().trim();
        total_payment = parseInt($(this).find("td:eq(7)").text().trim());
    });

    $("#detail").click(function () {
        if (payment_code === "") {
            alert("영화를 선택해주세요.");
            return;
        }

        $("#reservation_detail_modal").css("display", "block");
        console.log("payment_code: " + payment_code);

        $.ajax({
            type: "POST",
            url: "ReservationDetail",
            data: { payment_code: payment_code }
        }).done(function (result) {
            $("input[name='payment_code']").val(result.payment_code);
            $("input[name='movie_name']").val(result.movie_name);
            $("input[name='ticket_count']").val(result.ticket_count);
            $("input[name='total_seat_code']").val(result.total_seat_code);
            $("input[name='theater_code']").val(result.theater_code);
            $("input[name='total_amount']").val(result.total_amount);
        }).fail(function () {
            alert("상세 정보를 가져오는 데 실패하였습니다.");
        });
    });

    $(".close_modal").click(function () {
        location.reload();
    });
	

    $("#cancel").on("click", function () {
        const radioButtons = document.getElementsByName("reservationRadio");
        let selectedRadio = null;

        for (const radio of radioButtons) {
            if (radio.checked) {
                selectedRadio = radio.value;
                break;
            }
        }

        if (!selectedRadio) {
            alert("영화를 선택해주세요.");
            return;
        }

        const confirmMessage = "예매를 취소하시겠습니까?\n\n" +
            "취소 마감시간은 상영 시작 시간 20분 전입니다.\n\n" +
            "▶ 관람일 전일 오후 5시 이후 (일요일은 오전 11시) 또는 관람일 당일 예매하신 건에 대해서는\n" +
            "   예매 후 취소∙변경∙환불이 불가합니다.\n\n" +
            "▶ 토요일이 공휴일인 경우, 토요일 오전 11시 기준으로 적용됩니다.";

        if (!confirm(confirmMessage)) return;

        $.ajax({
            type: "POST",
            url: "ReservationCancel",
            data: {
                payment_code: payment_code,
                start_time: start_time,
                total_payment: total_payment
            },
            dataType: "JSON"
        }).done(function (response) {
            alert(response.msg);
            location.reload();
        }).fail(function () {
            alert("예매가 취소되지 않았습니다.\n다시 시도해주시기 바랍니다");
            location.reload();
        });
    });
});
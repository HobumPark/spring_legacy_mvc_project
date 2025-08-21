<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NASA 이미지 보기</title>
<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/static/css/fun-contents/nasa-api-page.css" type="text/css" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script>
$(document).ready(function() {
    initDateSelectors();
    fetchTodayImage();

    $('#fetchImageBtn').on('click', function() {
        const y = $('#year').val();
        const m = $('#month').val().padStart(2, '0');
        const d = $('#day').val().padStart(2, '0');
        const selectedDate = `${y}-${m}-${d}`;
        $('#nasa-contents').html('<p>불러오는 중...</p>');
        getNasaData(selectedDate);
    });
});

function initDateSelectors() {
    const yesterday = moment().subtract(1, 'days'); // ✅ 하루 전 날짜
    const $year = $('#year');
    const $month = $('#month');
    const $day = $('#day');

    const startYear = 1995; // NASA APOD 시작년도
    const currentYear = moment().year();

 	// 연도 셀렉트
    for (let y = currentYear; y >= startYear; y--) {
        $year.append('<option value="' + y + '">' + y + '</option>');
    }

    // 월 셀렉트
    for (let m = 1; m <= 12; m++) {
        const mm = m.toString().padStart(2, '0');
        $month.append('<option value="' + mm + '">' + mm + '</option>');
    }

    // 일 셀렉트
    for (let d = 1; d <= 31; d++) {
        const dd = d.toString().padStart(2, '0');
        $day.append('<option value="' + dd + '">' + dd + '</option>');
    }

    // ✅ 하루 전 날짜로 설정
    $year.val(yesterday.format('YYYY'));
    $month.val(yesterday.format('MM'));
    $day.val(yesterday.format('DD'));
}


function fetchTodayImage() {
    const yesterday = moment().subtract(1, 'days').format('YYYY-MM-DD'); // ✅ 하루 전
    $('#nasa-contents').html('<p>이미지를 불러오는 중...</p>');
    getNasaData(yesterday);
}

function getNasaData(date) {
    const apiKey = 'MWdJPzVSb1wrUknY6DNToQZGzj5Fjq6p703R2rg5';
    const url = "https://api.nasa.gov/planetary/apod?api_key=" + apiKey + "&date=" + date;

    $.ajax({
        type: 'get',
        url: url,
        async: true,
        dataType: 'json',
        success: function(result) {
            console.log(result);
            let html = '<div class="nasa-item">';
            html += '<h3>' + result.title + '</h3>';
            if (result.media_type === 'image') {
                html += '<img src="' + result.url + '" alt="NASA 이미지" style="max-width:100%;">';
            } else if (result.media_type === 'video') {
                html += '<iframe width="100%" height="400" src="' + result.url + '" frameborder="0" allowfullscreen></iframe>';
            }
            html += '<p>' + result.explanation + '</p>';
            html += '</div>';
            $('#nasa-contents').html(html);
        },
        error: function(xhr, status, error) {
            $('#nasa-contents').html('<p style="color:red;">이미지를 불러오지 못했습니다.</p>');
            console.log('에러:', error);
        }
    });
}
</script>
</head>
<body>
<div id="nasa-wrap">
    <h2>NASA Astronomy Picture of the Day</h2>
    
    <div id="nasa-selector">
        <label>연:
            <select id="year"></select>
        </label>
        <label>월:
            <select id="month"></select>
        </label>
        <label>일:
            <select id="day"></select>
        </label>
        <button id="fetchImageBtn">이미지 가져오기</button>
    </div>

    <div id="nasa-contents"></div>
</div>

</body>
</html>

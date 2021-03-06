<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/jsp/include/common_plugin.jsp" %>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<script type="text/javascript">


    function resetPageCnt() {
        const dspPage = document.getElementById("dspPage");
        dspPage.value = '';
    }

    // datepicker 초기화
    $(function() {

        document.addEventListener('keydown', function(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
            }
        }, true);

        //input을 datepicker로 선언
        $("#startdate").datepicker({
            dateFormat: 'yy-mm-dd' //달력 날짜 형태
            , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            , showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
            , changeYear: true //option값 년 선택 가능
            , changeMonth: true //option값  월 선택 가능
            , showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
            , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            , buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
            , buttonText: "선택" //버튼 호버 텍스트
            , yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
            , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
            , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
            , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
            , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
            , minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            , maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
            , onSelect: function (d) {
                resetPageCnt();
                var start = new Date($("#startdate").datepicker("getDate"));
                var end = new Date($("#enddate").datepicker("getDate"));
                if (end - start < 0) {
                    alert("시작일이 종료일보다 미래날짜는 설정할 수 없습니다.");
                    $('#startdate').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
                }
            }
        })
        $("#enddate").datepicker({
            dateFormat: 'yy-mm-dd' //달력 날짜 형태
            , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            , showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
            , changeYear: true //option값 년 선택 가능
            , changeMonth: true //option값  월 선택 가능
            , showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
            , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            , buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
            , buttonText: "선택" //버튼 호버 텍스트
            , yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
            , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
            , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
            , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
            , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
            , minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            , maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
            , onSelect: function (d) {
                resetPageCnt();
                var start = new Date($("#startdate").datepicker("getDate"));
                var end = new Date($("#enddate").datepicker("getDate"));
                if (end - start < 0) {
                    alert("종료일이 시작일보다 과거 날짜는 설정할 수 없습니다.");
                    $('#enddate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
                }

                const target = document.getElementById('searchType');
                const searchType = target.options[target.selectedIndex].value;

                const today = new Date();

                if (searchType === 'regDay') {
                    if (today < end) {
                        alert("등록일의 종료일은 미래날짜로 설정할 수 없습니다.");
                        $('#enddate').datepicker('setDate', 'today');
                    }
                }
            }
        });

        //초기값을 오늘 날짜로 설정해줘야 합니다.
        $('#startdate').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        $('#enddate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        $("img.ui-datepicker-trigger").css({'cursor': 'pointer', 'margin-left': '5px'});
    })

    // page 초기화 함수
    function resetPage(){
        $('#startdate').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        $('#enddate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        $(':radio[name="dspYn"]').removeAttr('checked');
        $(':radio[name="dspYn"]').filter("[value=all]").prop("checked",true);
        $('#qzNm').val('');
        $('select').prop('selectedIndex',0);
    }


    var glb_pagination;
    var glb_quizList;
    var glb_range = 1;
    var glb_checkCnt = 0;


    function changeCheckCnt(input) {

        const checkCnt = document.getElementById("checkCnt");

        if (input.checked) {glb_checkCnt += 1;}
        else {glb_checkCnt -= 1;}

        checkCnt.innerText = glb_checkCnt;
    }


    function sendData() {
        const target = document.getElementById('searchType');
        const searchType = target.options[target.selectedIndex].value;

        const dspStDt = document.getElementById('startdate').value;
        const dspEndDt = document.getElementById('enddate').value;
        const dspYn = $(':radio[name="dspYn"]:checked').val();
        const qzNm = document.getElementById('qzNm').value;

        const dspCnt = document.getElementById('dspCnt');
        const listSize = dspCnt.options[dspCnt.selectedIndex].value;
        var page = document.getElementById('dspPage').value;

        if (isNaN(page)) {
            alert("페이지 번호가 숫자가 아닙니다.");
            return false;
        }

        const lastPageText = document.getElementById('maxPage').innerText;
        const lastPage = parseInt(lastPageText.split('/ ')[1]);

        if (parseInt(page) > lastPage) {
            alert("최종 페이지를 초과했습니다.");
            return false;
        }

        if (parseInt(page) < 1) {
            alert("입력 범위를 초과했습니다.");
            return false;
        }

        var range = glb_range;

        const params = {
            "searchType": searchType,
            "stDt": dspStDt,
            "endDt": dspEndDt,
            "dspYn": dspYn,
            "qzNm": qzNm,
            "listSize": listSize,
            "page": page,
            "range": range
        }

        $.ajax({
           url: "/quiz/search",
           method: "post",
           data: params,
           sync: false,
            success: function (data) {
                const quizs = data["qzList"];
                const pagination = data["pagination"];

                glb_pagination = pagination;
                glb_quizList = quizs;
                glb_checkCnt = 0;

                document.getElementById("checkCnt").innerText = glb_checkCnt;
                document.getElementById("dspPage").value = pagination["page"];
                const searchCnt = document.getElementById("searchCnt");
                searchCnt.innerText = String(pagination["listCnt"]);

                var maxPage = document.getElementById("maxPage");
                if (maxPage.hasChildNodes()) {
                    maxPage.removeChild(maxPage.firstChild);
                }

                var span = document.createElement("span");
                span.innerText = "/ " + pagination["pageCnt"];
                maxPage.appendChild(span);

                var maxPageStr = document.getElementById('maxPage').innerText;
                var maxPageNum = maxPageStr.substr(2, maxPageStr.length);
                if (maxPageNum === '0') {
                    document.getElementById('dspPage').value = "";
                }

                const qzList = document.getElementById('qzList');
                while (qzList.hasChildNodes()) {
                    qzList.removeChild(qzList.firstChild);
                }
                document.getElementById('checkAll').checked = false;

                for (var q in quizs) {
                    const tr = document.createElement('tr');
                    tr.style.textAlign = 'center';
                    tr.style.height = '40px';
                    const td1 = document.createElement('td');
                    const checkBox = document.createElement('input');
                    checkBox.type = 'checkbox';
                    checkBox.name = 'checkbox';
                    checkBox.value = String(parseInt(q)+1);
                    checkBox.addEventListener('click', function () {changeCheckCnt(this)})
                    td1.appendChild(checkBox);
                    tr.appendChild(td1);

                    const td2 = document.createElement('td');
                    const index = (parseInt(pagination["page"])-1) * parseInt(pagination["listSize"]) + parseInt(q) + 1;
                    td2.innerText = String(index);
                    tr.appendChild(td2);


                    const td3 = document.createElement('td');
                    const td3_a = document.createElement('a');
                    td3_a.href = '/quiz/update/' + quizs[q]["qzSeq"];
                    td3_a.innerText = quizs[q]["qzNm"];
                    td3_a.style.textDecoration = 'none';
                    td3.appendChild(td3_a);
                    tr.appendChild(td3);

                    const td4 = document.createElement('td');
                    td4.innerText = "퀴즈";

                    tr.appendChild(td4);

                    const td5 = document.createElement('td');
                    td5.innerText = quizs[q]["qzSeq"];
                    tr.appendChild(td5);

                    const td6 = document.createElement('td');
                    td6.innerText = quizs[q]["stDt"].substr(0, 16) + ' ~ ' + quizs[q]["endDt"].substr(0, 16);
                    tr.appendChild(td6);

                    const td7 = document.createElement('td');
                    if (quizs[q]["dspYn"] === "Y") {
                        td7.innerText = "전시";
                    } else {
                        td7.innerText = "미전시";
                    }

                    tr.appendChild(td7);

                    const td8 = document.createElement('td');
                    td8.innerText = quizs[q]["regDt"].substr(0, 10);
                    tr.appendChild(td8)

                    qzList.appendChild(tr);
                }

                const navigation = document.getElementById("navigation");
                if (navigation.hasChildNodes()) {
                    navigation.removeChild(navigation.firstChild);
                }

                const nav = navigation.appendChild(document.createElement("nav"));
                nav.setAttribute("aria-label", "Page navigation example");
                const ul = nav.appendChild(document.createElement("ul"));
                ul.classList.add("pagination", "justify-content-center");

                // <<버튼
                const dp_li = document.createElement("li");
                dp_li.classList.add("page-item");
                const dp_a = dp_li.appendChild(document.createElement("a"));
                dp_a.classList.add("page-link");
                dp_a.href = "#";
                var pageStr = String(pagination["page"]);
                var rangeStr = String(pagination["range"]);
                var rangeSizeStr = String(pagination["rangeSize"]);
                dp_a.addEventListener('click', function () {fn_first()});
                dp_a.innerText = "<<";
                ul.appendChild(dp_li);

                // <버튼
                const sp_li = document.createElement("li");
                sp_li.classList.add("page-item", "disabled");
                if (pagination["prev"]) {
                    sp_li.classList.remove("disabled");
                }

                const sp_a = sp_li.appendChild(document.createElement('a'));
                sp_a.classList.add("page-link");
                sp_a.href = "#";
                var pageStr = String(pagination["page"]);
                var rangeStr = String(pagination["range"]);
                var rangeSizeStr = String(pagination["rangeSize"]);
                sp_a.addEventListener('click', function () {fn_prev(pageStr, rangeStr, rangeSizeStr)});
                sp_a.innerText = "<";
                ul.appendChild(sp_li);

                // 숫자버튼
                for (let i = pagination["startPage"]; i <= pagination["endPage"]; i++) {
                    const num_li = document.createElement("li");
                    num_li.classList.add("page-item")
                    if (pagination["page"] === i) {
                        num_li.classList.add("page-item", "active");
                    }
                    const num_a = num_li.appendChild(document.createElement("a"));
                    num_a.classList.add("page-link");
                    num_a.href = "#";
                    var pageStr = String(pagination["page"]);
                    var rangeStr = String(pagination["range"]);
                    var rangeSizeStr = String(pagination["rangeSize"]);
                    num_a.addEventListener('click', function () {
                        document.getElementById('dspPage').value = i;
                        sendData();
                    })
                    num_a.innerText = i;
                    ul.appendChild(num_li);
                }

                // > 버튼
                const sn_li = document.createElement("li");
                sn_li.classList.add("page-item", "disabled");
                if (pagination["next"]) {
                    sn_li.classList.remove("disabled");
                }

                const sn_a = sn_li.appendChild(document.createElement("a"));
                sn_a.classList.add("page-link");
                sn_a.href = "#";
                sn_a.addEventListener('click', function () {fn_next(pageStr, rangeStr, rangeSizeStr)});
                sn_a.innerText = ">";
                ul.appendChild(sn_li);


                // >> 버튼
                const dn_li = document.createElement("li");
                dn_li.classList.add("page-item");
                const dn_a = dn_li.appendChild(document.createElement("a"));
                dn_a.classList.add("page-link");
                dn_a.href = "#";
                var pageStr = String(pagination["page"]);
                var rangeStr = String(pagination["range"]);
                var rangeSizeStr = String(pagination["rangeSize"]);
                dn_a.addEventListener('click', function () {fn_last()});
                dn_a.innerText = ">>";
                ul.appendChild(dn_li);

                const chart = document.getElementById('chart');
                chart.style.display = '';

                const navi = document.getElementById('navigation');
                navi.style.display = '';

            }
        });
    }

    // << 버튼
    function fn_first() {
        document.getElementById("dspPage").value = "1";
        glb_range = 1;
        sendData();
    }

    // < 버튼
    function fn_prev(page, range, rangeSize) {
        document.getElementById("dspPage").value = String(((range - 2) * rangeSize) + 1);
        glb_range = range-1;
        sendData();
    }

    // >> 버튼
    function fn_last() {
        glb_range = Math.floor(parseInt(glb_pagination["pageCnt"])/parseInt(glb_pagination["rangeSize"]))+1;
        document.getElementById("dspPage").value = glb_pagination["pageCnt"];
        sendData();
    }

    // > 버튼
    function fn_next(page, range, rangeSize) {
        document.getElementById("dspPage").setAttribute("value",String((range * rangeSize) + 1));
        glb_range = range+1;
        sendData();
    }

    // function pageCheck(pageNum) {
    //     if (isNaN(pageNum)) {
    //         alert("숫자가 아닙니다.");
    //         return false;
    //     }
    //
    //     if (parseInt(pageNum) > glb_pagination["pageCnt"]) {
    //         alert("최종 페이지를 초과했습니다.");
    //         return false;
    //     }
    //
    //     if (parseInt(pageNum) < 1) {
    //         alert("입력 범위를 초과했습니다.");
    //         return false;
    //     }
    //
    //     sendData();
    // }


    function checkAll(input) {
        const checkBoxes = document.getElementsByName('checkbox');
        checkBoxes.forEach((checkBox) => {
            checkBox.checked = input.checked;
        })
    }

    function changeAllCheckCnt(input) {
        const checkBoxes = document.getElementsByName('checkbox');
        const allCnt = checkBoxes.length;

        if (input.checked) {
            glb_checkCnt = allCnt;
        } else {
            glb_checkCnt = 0;
        }

        const checkCnt = document.getElementById("checkCnt");
        checkCnt.innerText = glb_checkCnt;
    }

    function displayConfig() {
        const checkBoxes = document.getElementsByName('checkbox');
        var count = 0;
        for (let checkBox of checkBoxes) {
            if (checkBox.checked) {
                count += 1;
            }
        }

        if (count === 0) {
            alert("퀴즈를 선택해주세요.");
        } else {
            $('#testModal').modal("show");
        }
    }

    function changeDspConfig() {
        const checkBoxes = document.getElementsByName("changeDspYn");
        var count = 0;
        for (let checkBox of checkBoxes) {
            if (checkBox.checked) {
                count += 1
            }
        }

        if (count === 0) {
            alert("전시상태를 선택 후 저장하시기 바랍니다.");
            return false;
        }

        var items = $('input:checkbox[name=checkbox]:checked').map(function () {
            return this.value;
        }).get();



        if ($("input:radio[name=changeDspYn]:checked").val() === 'Y' || $("input:radio[name=changeDspYn]:checked").val() === 'N') {
            for (let seq of items) {
                const dspStDt = new Date(glb_quizList[seq-1]["stDt"]);
                const dspEndDt = new Date(glb_quizList[seq-1]["endDt"]);
                const today = new Date();

                if (today <= dspStDt) {
                    alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                    return false;
                }

                if (today >= dspEndDt) {
                    alert("전시 종료일이 지난 콘텐츠는 전시설정을 할 수 가 없습니다.");
                    return false;
                }
            }
        }

        var params = [];

        if ($("input:radio[name=changeDspYn]:checked").val() === 'Y') {
            for (let seq of items) {
                var obj = {
                    "qzSeq": glb_quizList[seq-1]["qzSeq"],
                    "dspYn": 'Y'
                }
                params.push(obj);
            }
            var jsonData = JSON.stringify(params);
            $.ajax({
                url: "/quiz/change-dspstate",
                method: "post",
                dataType: "json",
                traditional: true,
                data: {"jsonData": jsonData},
                sync: false,
                success: function () {
                    alert("전시 설정이 저장되었습니다.");
                    $('#testModal').modal("hide");
                }
            });
        } else {
            for (let seq of items) {
                var obj = {
                    "qzSeq": glb_quizList[seq-1]["qzSeq"],
                    "dspYn": 'N'
                }
                params.push(obj);
            }
            var jsonData = JSON.stringify(params);
            $.ajax({
                url: "/quiz/change-dspstate",
                method: "post",
                dataType: "json",
                traditional: true,
                data: {"jsonData": jsonData},
                sync: false,
                success: function () {
                    alert("전시 설정이 저장되었습니다.");
                    $('#testModal').modal("hide");
                }
            });
        }
    }


</script>

<body>
<!-- Top(header) 영역// -->
<%@ include file="/WEB-INF/jsp/include/common_hearder.jsp" %>
<!-- //Top(header) 영역 -->
<!-- Content Wrapper// -->
<div class="container-fluid">
    <div class="row">
        <!-- Left(Sidebar) 영역// -->
        <%@ include file="/WEB-INF/jsp/include/common_left.jsp" %>
        <!-- //Left(Sidebar) 영역 -->
        <!-- Content Body 영역 // -->

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="no_border_head">
                <span class="tab_span flSpan">퀴즈조회</span>
                <div class="d-flex justify-content-end flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary" onClick="location.href='/quiz/register'">등록</button>
                        </div>
                    </div>
                </div>
            </div>
            <form action="/quiz/excel/download" style="display: inline" method="post" id="excelDownLoadForm">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap pt-3">
                    <table class="table table-sm seaerch-table" >
                        <tbody>
                        <colgroup>
                            <col width="130px">
                            <col width="38%">
                            <col width="130px">
                            <col width="*">
                        </colgroup>
                        <tr style="height: 80px;">
                            <th style="text-align: center;">기간</th>
                            <td>
                                <select name="searchType" id="searchType" style="height: 40px;" onchange="resetPageCnt()">
                                    <option value="period">진행기간</option>
                                    <option value="regDay">등록일</option>
                                </select>
                                <label for="startdate"></label><input type="text" class="datepicker" name="dspStDt" id="startdate" style="margin-left:6px; width:110px; height:40px;">
                                ~
                                <label for="enddate"></label><input type="text" class="datepicker" name="dspEndDt" id="enddate" style="margin-left:6px; width:110px; height:40px;">
                            </td>
                            <th style="text-align: center;">전시상태</th>
                            <td>
                                <div>
                                    <input class="form-check-input" type="radio" name="dspYn" value="all" id="flexRadio1" checked style="margin-left:6px; margin-right:6px;" onchange="resetPageCnt()">
                                    <label class="display-state-label" for="flexRadio1">
                                        전체
                                    </label>
                                    <input class="form-check-input" type="radio" name="dspYn" value="Y" id="flexRadio2" style="margin-left:6px; margin-right:6px;" onchange="resetPageCnt()">
                                    <label class="display-state-label" for="flexRadio2">
                                        전시
                                    </label>
                                    <input class="form-check-input" type="radio" name="dspYn" value="N" id="flexRadio3" style="margin-left:6px; margin-right:6px;" onchange="resetPageCnt()">
                                    <label class="display-state-label" for="flexRadio3">
                                        전시안함
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr style="height: 80px;">
                            <th style="text-align: center;">퀴즈</th>
                            <td>
                                <input type="text" name="qzNm" class="form-control" id="qzNm" style="width:570px;height:40px; margin-right:3px; display: inline-block;" onchange="resetPageCnt();" onkeyup="resetPageCnt();" onpaste="resetPageCnt()" oninput="resetPageCnt()">
                            </td>
                            <th></th>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </form>
                <!-- Button Set (middle 정렬) // -->
                <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar mb-2">
                        <div class="btn-group">
                            <button type="button" class="btn btn-outline-secondary" style="margin-right:6px; width:80px; height:40px " id="btn_reset" onclick="resetPage();">초기화</button>
                            <button type="button" class="btn btn-primary" style="margin-right:6px; width:80px; height:40px " id="btn_submit" onclick="return sendData();">검색</button>
                        </div>
                    </div>
                </div>
                <div class="frameLine mb-3"></div>

                <!-- 팝업 될 레이어 -->
                <div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="width: 600px; height: 400px; margin-top: 200px;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">전시설정</h5>
                                <button type="button" class="btn btn-light" onclick="$('#testModal').modal('hide');">X</button>
                            </div>
                            <div class="modal-body">
                                <table class="table table-sm seaerch-table">
                                    <tbody>
                                    <tr style="height: 50px">
                                        <th style="width: 100px">전시상태</th>
                                        <td>
                                            <div>
                                                <input class="form-check-input" type="radio" name="changeDspYn" value="Y" id="dspChangeRadioY" style="margin-left:6px; margin-right:6px;">
                                                <label class="display-state-label" for="flexRadio2">
                                                    전시
                                                </label>
                                                <input class="form-check-input" type="radio" name="changeDspYn" value="N" id="dspChangeRadioN" style="margin-left:6px; margin-right:6px;">
                                                <label class="display-state-label" for="flexRadio3">
                                                    전시안함
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table><br>
                                <div style="text-align: center;">선택하신 항목에 일괄 적용합니다</div>
                            </div>
                            <div style="margin:auto" class="modal-footer">
                                <button type="button" class="btn btn-outline-secondary" style="margin-right:6px; width:70px; height:40px " id="btn_dsp_reset" onclick="$('#testModal').modal('hide');">취소</button>
                                <button type="button" class="btn btn-primary" style="margin-right:6px; width:70px; height:40px " id="btn_dsp_submit" onclick="changeDspConfig()">저장</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!--검색결과 리스트 -->
                <div id="chart" class="table-responsive" style="display: none">
                    <div style="margin-bottom: 8px;"><span>조회결과 </span><span id="searchCnt" style="color:#0064FF">10</span><span>건 | </span><span>선택 </span><span id="checkCnt" style="color:#0064FF">0</span><span>건</span></div>
                    <table class="table table-striped table-sm">
                        <thead>
                        <tr style="background-color: #e6efff">
                            <td colspan="9">
                                <div style="float: left;">
                                    <button type="submit" class="btn btn-outline-secondary" form="excelDownLoadForm" style="background-color: #ecedee; color: black; font-size: 15px">엑셀 다운로드</button>
                                    <button type="button" class="btn btn-outline-secondary" onclick="displayConfig()" style="background-color: #ecedee; color: black; font-size: 15px">전시 설정</button>
                                </div>
                                <div id="theadRight" style="float: right;">
                                    <label>
                                        <select name="dspCnt" class="form-select w100" id="dspCnt" onchange="resetPageCnt()" style="margin-left:6px; margin-right:3px; display: inline-block;">
                                            <option value="20" selected>20개</option>
                                            <option value="50">50개</option>
                                            <option value="100">100개</option>
                                        </select>
                                    </label>
                                    <input type="text" name="dspPage" class="form-control" id="dspPage" value="${pagination.page}" style="width:50px;height:40px;margin-right:3px;display:inline-block;">
                                    <span id="maxPage" style="font-size: 15px;">${pagination.endPage}</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align: center; width:40px; height: 40px" scope="col">
                                <input type="checkbox" name="checkAll" id="checkAll" onchange="checkAll(this);" onclick="changeAllCheckCnt(this)">
                            </th>
                            <th style="text-align: center; width:40px;" scope="col">번호</th>
                            <th style="text-align: center; width:150px;" scope="col">퀴즈명</th>
                            <th style="text-align: center; width:60px;" scope="col">유형</th>
                            <th style="text-align: center; width:60px;" scope="col">퀴즈번호</th>
                            <th style="text-align: center; width:150px;" scope="col">진행기간</th>
                            <th style="text-align: center; width:60px;" scope="col">전시상태</th>
                            <th style="text-align: center; width:100px;" scope="col">등록일</th>
                        </tr>
                        </thead>
                        <tbody id="qzList">
                        </tbody>
                    </table>
                </div>
                <div id = navigation style="display:none">
                </div>
<%--            </form>--%>
        </main>
    </div>
</div>
</html>

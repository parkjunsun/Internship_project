<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/jsp/include/common_plugin.jsp" %>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<script type="text/javascript">

    // datepicker 초기화
    $(function() {
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
                var start = new Date($("#startdate").datepicker("getDate"));
                var end = new Date($("#enddate").datepicker("getDate"));
                if (end - start < 0) {
                    alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
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
                var start = new Date($("#startdate").datepicker("getDate"));
                var end = new Date($("#enddate").datepicker("getDate"));
                if (end - start < 0) {
                    alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                    $('#enddate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
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
    var glb_range = 1;

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
                const qzList = document.getElementById('qzList');


                while (qzList.hasChildNodes()) {
                    qzList.removeChild(qzList.firstChild);
                }

                var seq = 1;
                for (var q in quizs) {
                    const tr = document.createElement('tr');
                    tr.style.textAlign = 'center';
                    const td1 = document.createElement('td');
                    const checkBox = document.createElement('input');
                    checkBox.type = 'checkbox';
                    td1.appendChild(checkBox);
                    tr.appendChild(td1);

                    const td2 = document.createElement('td');
                    td2.innerText = seq;
                    seq += 1;
                    tr.appendChild(td2);


                    const td3 = document.createElement('td');
                    td3.innerText = quizs[q]["qzNm"];
                    tr.appendChild(td3);

                    const td4 = document.createElement('td');
                    td4.innerText = "퀴즈";

                    tr.appendChild(td4);

                    const td5 = document.createElement('td');
                    td5.innerText = quizs[q]["qzSeq"];
                    tr.appendChild(td5);

                    const td6 = document.createElement('td');
                    td6.innerText = quizs[q]["stDt"] + '~' + quizs[q]["endDt"];
                    tr.appendChild(td6);

                    const td7 = document.createElement('td');
                    if (quizs[q]["dspYn"] === "Y") {
                        td7.innerText = "전시";
                    } else {
                        td7.innerText = "미전시";
                    }

                    tr.appendChild(td7);

                    const td8 = document.createElement('td');
                    td8.innerText = quizs[q]["regDt"];
                    tr.appendChild(td8)

                    qzList.appendChild(tr);
                }

                const chart = document.getElementById('chart');
                chart.style.display = '';
            }
        });
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
                            <button type="button" class="btn btn-primary" onClick="location.href='./register'">등록</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Form Table 영역 // -->

            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap pt-3">
                <%--                            <form action="/content/search" method="post" id="searchForm">--%>
                <table class="table table-sm seaerch-table" >
                    <tbody>
                    <colgroup>
                        <col width="130px">
                        <col width="38%">
                        <col width="130px">
                        <col width="*">
                    </colgroup>
                    <tr height="50">
                        <th>기간</th>
                        <td>
                            <select name="searchType" id="searchType">
                                <option value="period">진행기간</option>
                                <option value="regDay">등록일</option>
                            </select>
                            <label for="startdate"></label><input type="text" class="datepicker" name="dspStDt" id="startdate" style="margin-left:6px; width:110px; height:40px;">
                            ~
                            <label for="enddate"></label><input type="text" class="datepicker" name="dspEndDt" id="enddate" style="margin-left:6px; width:110px; height:40px;">
                        </td>
                        <th>전시상태</th>
                        <td>
                            <div>
                                <input class="form-check-input" type="radio" name="dspYn" value="all" id="flexRadio1" checked style="margin-left:6px; margin-right:6px;">
                                <label class="display-state-label" for="flexRadio1">
                                    전체
                                </label>
                                <input class="form-check-input" type="radio" name="dspYn" value="Y" id="flexRadio2" style="margin-left:6px; margin-right:6px;">
                                <label class="display-state-label" for="flexRadio2">
                                    전시
                                </label>
                                <input class="form-check-input" type="radio" name="dspYn" value="N" id="flexRadio3" style="margin-left:6px; margin-right:6px;">
                                <label class="display-state-label" for="flexRadio3">
                                    전시안함
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr  height="50">
                        <th>퀴즈</th>
                        <td>
                            <input type="text" name="qzNm" class="form-control" id="qzNm" style="width:400px;height:40px; margin-right:3px; display: inline-block;">
                        </td>
                        <th></th>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
                <%--                            </form>--%>
            </div>
            <!-- Button Set (middle 정렬) // -->
            <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                <div class="btn-toolbar mb-2">
                    <div class="btn-group">
                        <button type="button" class="btn btn-outline-secondary" style="margin-right:6px; width:80px; height:40px " id="btn_reset" onclick="resetPage();">초기화</button>
                        <button type="button" class="btn btn-primary" style="margin-right:6px; width:80px; height:40px " id="btn_submit" onclick="sendData();">검색</button>
                    </div>
                </div>
            </div>
            <div class="frameLine mb-3"></div>

            <div id="chart" class="table-responsive" style="display: none">
                <table class="table table-striped table-sm">
                    <thead>
                    <tr>
                        <td colspan="9">
                            <div style="float: left;">
                                <button type="button" class="btn btn-outline-secondary">엑셀 다운로드</button>
                                <button type="button" class="btn btn-outline-secondary">전시 설정</button>
                            </div>
                            <div id="theadRight" style="float: right;">
                                <label>
                                    <select name="dspCnt" class="form-select w100" id="dspCnt" style="margin-left:6px; margin-right:3px; display: inline-block;">
                                        <option value="20" selected>20개</option>
                                        <option value="30">30개</option>
                                        <option value="40">40개</option>
                                        <option value="50">50개</option>
                                    </select>
                                </label>
                                <input type="text" name="dspPage" class="form-control" id="dspPage" onchange="pageCheck($('#dspPage').val())" value="${pagination.page}" style="width:50px;height:40px;margin-right:3px;display:inline-block;">
                                <span id="maxPage" value="${pagination.endPage}">
                                        / ${pagination.endPage}
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th style="text-align: center; width:40px; height: 40px" scope="col">
                            <input type="checkbox" name="xxx" value="yyy">
                        </th>
                        <th style="text-align: center; width:40px;" scope="col">번호</th>
                        <th style="text-align: center; width:300px;" scope="col">퀴즈명</th>
                        <th style="text-align: center; width:60px;" scope="col">유형</th>
                        <th style="text-align: center; width:60px;" scope="col">퀴즈번호</th>
                        <th style="text-align: center; width:60px;" scope="col">진행기간</th>
                        <th style="text-align: center; width:60px;" scope="col">전시상태</th>
                        <th style="text-align: center; width:300px;" scope="col">등록일</th>
                    </tr>
                    </thead>
                    <tbody id="qzList">
                    </tbody>
                </table>
            </div>

            <!-- pagination{s} -->

            <%--                <div id="paginationBox">--%>
            <%--                    <ul class="pagination">--%>
            <%--                        <c:if test="${pagination.prev}">--%>
            <%--                            <li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Previous</a></li>--%>
            <%--                        </c:if>--%>
            <%--                        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">--%>
            <%--                            <li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></li>--%>
            <%--                        </c:forEach>--%>
            <%--                        <c:if test="${pagination.next}">--%>
            <%--                            <li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" >Next</a></li>--%>
            <%--                        </c:if>--%>
            <%--                    </ul>--%>
            <%--                </div>--%>

            <!-- pagination{e} -->

            <div id = navigation style="display:none">
                <%--                    <nav aria-label="Page navigation example">--%>
                <%--                        <ul class="pagination justify-content-center">--%>
                <%--                            <li class="page-item disabled">--%>
                <%--                                <a class="page-link" href="#" tabindex="-1"> << </a>--%>
                <%--                            </li>--%>
                <%--                            <li class="page-item disabled">--%>
                <%--                                <a class="page-link" id="prev" href="#" tabindex="-1"> < </a>--%>
                <%--                            </li>--%>
                <%--                            <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
                <%--                            <li class="page-item">--%>
                <%--                                <a class="page-link" id="next" href="#"> > </a>--%>
                <%--                            </li>--%>
                <%--                            <li class="page-item">--%>
                <%--                                <a class="page-link" href="#"> >> </a>--%>
                <%--                            </li>--%>
                <%--                        </ul>--%>
                <%--                    </nav>--%>
            </div>
        </main>
    </div>
</div>
</html>

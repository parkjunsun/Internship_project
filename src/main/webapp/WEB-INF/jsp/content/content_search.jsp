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

    var params ='<c:out value="${result}"/>';

    var glb_pagination;
    var glb_contentList;

    var glb_range=1;

    $(document).ready(function() {
        $.initPage();
    });

    ;(function($){
        $.initPage = function() {
            console.log(params);
        };
    })(jQuery);

    // AJAX 데이터 전송
    function sendData() {
        var dspStDt = $('#startdate').val();
        var dspEndDt = $('#enddate').val();
        var dspYn = $(':radio[name="dspYn"]:checked').val();
        var ctnNm = $('#ctnNm').val();
        var srcCd = $('#srcCd').val();
        var tplCd = $(':radio[name="tplCd"]:checked').val();
        var ctnDiv = $(':radio[name="ctnDiv"]:checked').val();
        var orderBy = $('#orderBy').val();
        var listSize = $('#dspCnt').val();
        var page = $('#dspPage').val();
        var range = glb_range;
        var params = "dspStDt=" + dspStDt
            + "&dspEndDt=" + dspEndDt
            + "&dspYn=" + dspYn
            + "&ctnNm=" + ctnNm
            + "&srcCd=" + srcCd
            + "&tplCd=" + tplCd
            + "&orderBy=" + orderBy
            + "&ctnDiv=" + ctnDiv
            + "&page=" + page
            + "&range=" + range
            + "&listSize=" + listSize;
        $.ajax({
            url: "/content/search"
            , method: "post"
            , data: params
            , sync: false
            , success: function (data) {
                console.log(data);
                var content = data["contentExcelList"];
                var pagination = data["pagination"];
                glb_contentList = content;
                glb_pagination = pagination;
                document.getElementById("dspPage").setAttribute("value", pagination["page"]);
                maxPage = document.getElementById("maxPage");
                if (maxPage.hasChildNodes()) {
                    maxPage.removeChild(maxPage.firstChild);
                }
                var span = document.createElement('span');
                span.innerText = "/ " + pagination["pageCnt"];
                maxPage.appendChild(span);
                const conList = document.getElementById("ctnList");
                while (conList.hasChildNodes()) {
                    conList.removeChild(conList.firstChild);
                }
                for (var c in content) {
                    var tr = document.createElement('tr');
                    tr.setAttribute('style', 'text-align: center');
                    var checkbox = document.createElement('td');
                    var input = document.createElement('input');
                    input.setAttribute('type', 'checkbox');
                    checkbox.appendChild(input);
                    tr.appendChild(checkbox);

                    var index = document.createElement('td');
                    index.innerText = Number(c) + 1;
                    tr.appendChild(index);

                    var ctnNm = document.createElement('td');
                    ctnNm.innerText = content[c]['ctnNm'];
                    tr.appendChild(ctnNm);

                    var ctnCd = document.createElement('td');
                    ctnCd.innerText = content[c]['ctnSeq'];
                    tr.appendChild(ctnCd);

                    var ctnDiv = document.createElement('td');
                    var ctnDivNm = '';
                    if (content[c]["ctnDiv"] == "IN") {
                        ctnDivNm = '내부';
                    } else {
                        ctnDivNm = '외부';
                    }
                    ctnDiv.innerText = ctnDivNm;
                    tr.appendChild(ctnDiv);

                    var tplNm = document.createElement('td');
                    tplNm.innerText = content[c]['tplNm'];
                    tr.appendChild(tplNm);

                    var dspYnNm = '';
                    if (content[c]["dspYn"] == "Y") {
                        dspYnNm = '전시';
                    } else {
                        dspYnNm = '미전시';
                    }

                    var dspYn = document.createElement('td');
                    dspYn.innerText = dspYnNm;
                    tr.appendChild(dspYn);

                    var dspDt = document.createElement('td');
                    dspDt.innerText = content[c]['dspStDt'].split(' ')[0]
                        + " "
                        + content[c]['dspStDt'].split(' ')[1].split('.')[0]
                        + "    ~    "
                        + content[c]['dspEndDt'].split(' ')[0]
                        + " "
                        + content[c]['dspEndDt'].split(' ')[1].split('.')[0];
                    tr.appendChild(dspDt);


                    var srcNm = document.createElement('td');
                    srcNm.innerText = content[c]["srcNm"];
                    tr.appendChild(srcNm);


                    conList.appendChild(tr);

                }

                var navigation = document.getElementById("navigation");
                if (navigation.hasChildNodes()) {
                    navigation.removeChild(navigation.firstChild);
                }


                var nav = navigation.appendChild(document.createElement("nav"));
                nav.setAttribute("aria-label", "Page navigation example");
                var ul = nav.appendChild(document.createElement("ul"));
                ul.setAttribute("class", "pagination justify-content-center");

                // < 버튼
                var li = document.createElement("li");
                li.setAttribute("class", "page-item disabled");
                if (pagination["prev"]) {
                    li.setAttribute("class", "page-item");
                }
                var a = li.appendChild(document.createElement("a"));
                a.setAttribute("class", "page-link");
                a.setAttribute("href", "#");
                var pageStr = String(pagination["page"]);
                var rangeStr = String(pagination["range"]);
                var rangeSizeStr = String(pagination["rangeSize"]);
                a.setAttribute("onClick", "fn_prev(" + pageStr + "," + rangeStr + "," + rangeSizeStr + ")");
                a.innerText = "<";
                ul.appendChild(li);

                for (var i = pagination["startPage"]; i <= pagination["endPage"]; i++) {
                    var li = document.createElement("li");
                    li.setAttribute("class", "page-item");
                    if (pagination["page"] == i) {
                        li.setAttribute("class", "page-item active");
                    }
                    var a = li.appendChild(document.createElement("a"));
                    a.setAttribute("class", "page-link");
                    a.setAttribute("href", "#");
                    var pageStr = String(pagination["page"]);
                    var rangeStr = String(pagination["range"]);
                    var rangeSizeStr = String(pagination["rangeSize"]);
                    a.setAttribute("onClick", "document.getElementById('dspPage').setAttribute('value'," + i + "); sendData();");
                    a.innerText = i;
                    ul.appendChild(li);
                }

                // > 버튼
                var li = document.createElement("li");
                li.setAttribute("class", "page-item disabled");
                if (pagination["next"]) {
                    li.setAttribute("class", "page-item");
                }
                var a = li.appendChild(document.createElement("a"));
                a.setAttribute("class", "page-link");
                a.setAttribute("href", "#");
                a.setAttribute("onClick", "fn_next(+" + pageStr + "," + rangeStr + "," + rangeSizeStr + "+)");
                a.innerText = ">";
                ul.appendChild(li);


                $('#chart').show();
                $('#navigation').show();
            }
        })
    }

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
        $('#ctnNm').val('');
        $('#srcNm').val('');
        $(':radio[name="tplCd"]').removeAttr('checked');
        $(':radio[name="tplCd"]').filter("[value=all]").prop("checked",true);
        $(':radio[name="ctnDiv"]').removeAttr('checked');
        $(':radio[name="ctnDiv"]').filter("[value=all]").prop("checked",true);
        $(':radio[name="ctnDiv"]').removeAttr('checked');
        $(':radio[name="ctnDiv"]').filter("[value=all]").prop("checked",true);
        $('select').prop('selectedIndex',0);
    }

    // 검색 버튼
    $(function(){
        $('#btn_submit').on('click',sendData);
    })

    // 초기화 버튼
    $(function(){
        $('#btn_reset').on('click',resetPage);
    })

    // 이동 페이지 입력 검사 함수
    function pageCheck(page){
        if(isNaN(page)){
            alert("숫자를 입력해 주세요");
            var newInput = document.createElement("input");
            newInput.setAttribute("type", "text");
            newInput.setAttribute("name", "dspPage");
            newInput.setAttribute("class", "form-control");
            newInput.setAttribute("id", "dspPage");
            newInput.setAttribute("onchange", "pageCheck($('#dspPage').val())");
            newInput.setAttribute("value", glb_pagination["page"]);
            newInput.setAttribute("style", "width:50px;height:40px;margin-right:3px;display:inline-block;");

            var theadRight = document.getElementById("theadRight");
            var oldInput = document.getElementById("dspPage");
            theadRight.replaceChild(newInput,oldInput);
        }
        else if(parseInt(page)>glb_pagination["pageCnt"]){
            alert("최종 페이지를 초과했습니다");
            var newInput = document.createElement("input");
            newInput.setAttribute("type", "text");
            newInput.setAttribute("name", "dspPage");
            newInput.setAttribute("class", "form-control");
            newInput.setAttribute("id", "dspPage");
            newInput.setAttribute("onchange", "pageCheck($('#dspPage').val())");
            newInput.setAttribute("value", glb_pagination["page"]);
            newInput.setAttribute("style", "width:50px;height:40px;margin-right:3px;display:inline-block;");

            var theadRight = document.getElementById("theadRight");
            var oldInput = document.getElementById("dspPage");
            theadRight.replaceChild(newInput,oldInput);
        }
        else if(parseInt(page)<1){
            alert("입력 범위를 초했습니다");
            var newInput = document.createElement("input");
            newInput.setAttribute("type", "text");
            newInput.setAttribute("name", "dspPage");
            newInput.setAttribute("class", "form-control");
            newInput.setAttribute("id", "dspPage");
            newInput.setAttribute("onchange", "pageCheck($('#dspPage').val())");
            newInput.setAttribute("value", glb_pagination["page"]);
            newInput.setAttribute("style", "width:50px;height:40px;margin-right:3px;display:inline-block;");

            var theadRight = document.getElementById("theadRight");
            var oldInput = document.getElementById("dspPage");
            theadRight.replaceChild(newInput,oldInput);
        }
    }

    // // 이전 버튼 이벤트
    // $(function(){
    //     $('#prev').on('click',fn_prev());
    // })
    //
    // // 다음 버튼 이벤트
    // $(function(){
    //     $('#next').on('click',fn_next());
    // })


    // $('#dspPage').on("change keyup paste", function() {
    //     var currentVal = this.val();
    //     alert(currentVal);
    //     if(currentVal > $('#maxPage').val()){
    //         alert("최종 페이지를 초과했습니다");
    //         $('#dspPage').val(glb_pagination['page']);
    //     }
    // });

    // $(function(){
    //     $('#dspPage').change(pageCheck($('#dspPage').val()));
    // })
    // });

    function fn_prev(page, range, rangeSize) {
        document.getElementById("dspPage").setAttribute("value",String(((range - 2) * rangeSize) + 1));
        glb_range = range-1;
        sendData();
    }

    function fn_next(page, range, rangeSize) {
        document.getElementById("dspPage").setAttribute("value",String((range * rangeSize) + 1));
        glb_range = range+1;
        sendData();
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
                    <span class="tab_span flSpan">콘텐츠조회</span>
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
                                    <th>전시기간</th>
                                    <td>
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
                                                미전시
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                                <tr  height="50">
                                    <th>검색</th>
                                    <td>
                                        <label>
                                            <select name="searchType" class="form-select w130" style="margin-left:6px; margin-right:3px; display: inline-block;">
                                                <option value="all" selected>전체</option>
                                                <option value="ctnNm">콘텐츠명</option>
                                                <option value="content">본문내용</option>
                                            </select>
                                        </label>
                                        <input type="text" name="ctnNm" class="form-control" id="ctnNm" style="width:400px;height:40px; margin-right:3px; display: inline-block;">
                                    </td>
                                    <th>출처</th>
                                    <td>
                                        <label for="srcCd"></label><select class="form-select w130" style="margin-left:3px; margin-right:3px; display: inline-block;" name="srcCd" id="srcCd">
                                            <option value="all" selected>전체</option>
                                            <c:forEach var="item" items="${srcList}">
                                                <option value="${item.cd}">${item.cd_nm}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr height="50">
                                    <th>템플릿유형</th>
                                    <td>
                                        <div>
                                            <input class="form-check-input" type="radio" name="tplCd" value="all" id="flexRadio4" checked style="margin-left:6px; margin-right:6px;">
                                            <label class="form-check-label" for="flexRadio4"> 전체 </label>
                                            <c:forEach var="temp" items="${tempList}">
                                                <input class="form-check-input" type="radio" name="tplCd" value="${temp.cd}" id="flexRadio5" style="margin-left:6px; margin-right:6px;">
                                                <label class="form-check-label" for="flexRadio5">${temp.cd_nm}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <th>콘텐츠 구분</th>
                                    <td>
                                        <div>
                                            <input class="form-check-input" type="radio" name="ctnDiv" value="all" id="flexRadio6" checked style="margin-left:6px; margin-right:6px;">
                                            <label class="form-check-label" for="flexRadio6">
                                                전체
                                            </label>
                                            <input class="form-check-input" type="radio" name="ctnDiv" value="IN" id="flexRadio7" style="margin-left:6px; margin-right:6px;">
                                            <label class="form-check-label" for="flexRadio7">
                                                내부
                                            </label>
                                            <input class="form-check-input" type="radio" name="ctnDiv" value="OUT" id="flexRadio8" style="margin-left:6px; margin-right:6px;">
                                            <label class="form-check-label" for="flexRadio8">
                                                외부
                                            </label>
                                        </div>
                                    </td>
                                </tbody>
                            </table>
<%--                            </form>--%>
                        </div>

                        <!-- Button Set (middle 정렬) // -->
                        <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                            <div class="btn-toolbar mb-2">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-secondary" style="margin-right:6px; width:80px; height:40px " id="btn_reset">초기화</button>
                                    <button type="button" class="btn btn-primary" style="margin-right:6px; width:80px; height:40px " id="btn_submit" >검색</button>
                                </div>
                            </div>
                        </div>
                        <div class="frameLine mb-3"></div>
                        <!-- // Button Set (middle 정렬) -->

                <div id="chart" style="display:none"  class="table-responsive" >
                    <table class="table table-striped table-sm">
                        <thead>
                        <tr>
                            <td colspan="9">
                                <div style="float: left;">
                                    <button type="button" class="btn btn-outline-secondary">엑셀 다운로드</button>
                                    <button type="button" class="btn btn-outline-secondary">전시 설정</button>
                                </div>
                                <div id="theadRight" style="float: right;">
                                    정렬 순서
                                    <label>
                                        <select name="searchType" class="form-select w120" id="orderBy" style="margin-left:6px; margin-right:3px; display: inline-block;">
                                            <option value="all" selected>전체</option>
                                            <option value="ctn_nm">콘텐츠명</option>
                                            <option value="dsp_st_dt">전시기간</option>
                                        </select>
                                    </label>
                                    <label>
                                        <select name="searchType" class="form-select w100" id="dspCnt" style="margin-left:6px; margin-right:3px; display: inline-block;">
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
                            <th style="text-align: center; width:300px;" scope="col">콘텐츠명</th>
                            <th style="text-align: center; width:60px;" scope="col">화면코드</th>
                            <th style="text-align: center; width:60px;" scope="col">콘텐츠형태</th>
                            <th style="text-align: center; width:60px;" scope="col">템플릿유형</th>
                            <th style="text-align: center; width:60px;" scope="col">전시여부</th>
                            <th style="text-align: center; width:300px;" scope="col">전시기간</th>
                            <th style="text-align: center; width:60px;" scope="col">출처</th>
                        </tr>
                        </thead>
                        <tbody id="ctnList">
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
        <!-- //Content Body 영역 -->
    </div>
</div>
<!-- //Content Wrapper -->
</body>
</html>
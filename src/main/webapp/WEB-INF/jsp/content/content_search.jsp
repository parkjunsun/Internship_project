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
    <script type="text/javascript">
        var params ='<c:out value="${result}"/>';

        $(document).ready(function() {
            $.initPage();
        });

        ;(function($){
            $.initPage = function() {
                console.log(params);
            };
        })(jQuery);

        $(function() {
            //input을 datepicker로 선언
            $("#startdate").datepicker({
                dateFormat: 'yy-mm-dd' //달력 날짜 형태
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
                ,changeYear: true //option값 년 선택 가능
                ,changeMonth: true //option값  월 선택 가능
                ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
                ,buttonText: "선택" //버튼 호버 텍스트
                ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
                ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
                ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
                ,onSelect:function(d){
                    var start = new Date($("#startdate").datepicker("getDate"));
                    var end = new Date($("#enddate").datepicker("getDate"));
                    if (end - start < 0){
                        alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                        $('#startdate').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
                    }

                }
            })

            $("#enddate").datepicker({
                dateFormat: 'yy-mm-dd' //달력 날짜 형태
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
                ,changeYear: true //option값 년 선택 가능
                ,changeMonth: true //option값  월 선택 가능
                ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
                ,buttonText: "선택" //버튼 호버 텍스트
                ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
                ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
                ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
                ,onSelect:function(d){
                    var start = new Date($("#startdate").datepicker("getDate"));
                    var end = new Date($("#enddate").datepicker("getDate"));
                    if (end - start < 0){
                        alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                        $('#enddate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
                    }
                }
            });

            //초기값을 오늘 날짜로 설정해줘야 합니다.
            $('#startdate').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
            $('#enddate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
            $("img.ui-datepicker-trigger").css({'cursor':'pointer', 'margin-left':'5px'});

        });

    </script>
</head>
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
                            <input type="text" class="datepicker" id="startdate" style="margin-left:6px; width:110px; height:40px;">
                            ~
                            <input type="text" class="datepicker" id="enddate" style="margin-left:6px; width:110px; height:40px;">
                        </td>
                        <th>전시상태</th>
                        <td>
                            <div>
                                <input class="form-check-input" type="radio" name="displayStateRadio" id="flexRadio1" checked style="margin-left:6px; margin-right:6px;">
                                <label class="display-state-label" for="flexRadio1">
                                    전체
                                </label>
                                <input class="form-check-input" type="radio" name="displayStateRadio" id="flexRadio2" style="margin-left:6px; margin-right:6px;">
                                <label class="display-state-label" for="flexRadio2">
                                    전시
                                </label>
                                <input class="form-check-input" type="radio" name="displayStateRadio" id="flexRadio3" style="margin-left:6px; margin-right:6px;">
                                <label class="display-state-label" for="flexRadio3">
                                    미전시
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr  height="50">
                        <th>검색</th>
                        <td>
                            <select class="form-select w130" style="margin-left:6px; margin-right:3px; display: inline-block;">
                                <option selected>전체</option>
                                <option value="1">콘텐츠명</option>
                                <option value="2">본문내용</option>
                            </select>
                            <input type="text" class="form-control" id="searchBox"; style="width:400px;height:40px; margin-right:3px; display: inline-block;">
                        </td>
                        <th>출처</th>
                        <td>
                            <select class="form-select w130" style="margin-left:3px; margin-right:3px; display: inline-block;" name="srcCd" id="srcCd">
                                <option selected>전체</option>
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
                                <input class="form-check-input" type="radio" name="templateTypeRadio" id="flexRadio4" checked style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio4"> 전체 </label>
                                <c:forEach var="temp" items="${tempList}">
                                    <input class="form-check-input" type="radio" name="templateTypeRadio" id="flexRadio5" style="margin-left:6px; margin-right:6px;">
                                    <label class="form-check-label" for="flexRadio5">${temp.cd_nm}</label>
                                </c:forEach>
                            </div>
                        </td>
                        <th>콘텐츠 구분</th>
                        <td>
                            <div>
                                <input class="form-check-input" type="radio" name="contentsDivRadio" id="flexRadio6" checked style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio6">
                                    전체
                                </label>
                                <input class="form-check-input" type="radio" name="contentsDivRadio" id="flexRadio7" style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio7">
                                    내부
                                </label>
                                <input class="form-check-input" type="radio" name="contentsDivRadio" id="flexRadio8" style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio8">
                                    외부
                                </label>
                            </div>
                        </td>
                    </tbody>
                </table>
            </div>

            <!-- Button Set (middle 정렬) // -->
            <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                <div class="btn-toolbar mb-2">
                    <div class="btn-group">
                        <button type="button" class="btn btn-outline-secondary" style="margin-right:6px; width:80px; height:40px ">초기화</button>
                        <button type="button" class="btn btn-primary" style="margin-right:6px; width:80px; height:40px ">검색</button>
                    </div>
                </div>
            </div>
            <div class="frameLine mb-3"></div>
            <!-- // Button Set (middle 정렬) -->

        </main>
        <!-- //Content Body 영역 -->
    </div>
</div>
<!-- //Content Wrapper -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/jsp/include/common_plugin.jsp" %>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/free-jqgrid/4.8.0/css/ui.jqgrid.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/free-jqgrid/4.8.0/js/i18n/grid.locale-de.js"></script>
    <script src="https://cdn.jsdelivr.net/free-jqgrid/4.8.0/js/jquery.jqgrid.min.js"></script>
    <script type="text/javascript">
        var params ='<c:out value="${result}"/>';

        $(document).ready(function() {
            $.initPage();
            $("table").after('<div id="nav"></div>');
            var rowPerPage = 4;
            var tr = $("table tbody tr");
            var rowsTotal = tr.length;
            var pagesTotal = Math.ceil(rowsTotal/rowPerPage);
            for (i = 0; i < pagesTotal; i++){
                $("<a href=\"#\"></a>").attr("id", i).text(i + 1).appendTo("#nav");
                // $("#nav").append($("<a href=\"#\"></a>").attr("id", i).text(i + 1));
            }

            tr
                .addClass("overflowHidden")
                //.slice(0, rowPerPage)
                .removeClass("overflowHidden");

            $("#nav a").click(function(){
                $("#nav a").removeClass("active");
                $(this).addClass("active");

                var currPage = $(this).attr("id");
                var startItem = currPage * rowPerPage;
                var endItem = startItem + rowPerPage;
                tr
                    .css("opacity","0")
                    .addClass("overflowHidden")
                    .slice(startItem, endItem)
                    .removeClass("overflowHidden")
                    .animate({opacity:1}, 300);
                return false();
            });
            $("#nav a:first").addClass("active");
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
            });
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


            // $(function(){
            //
            //     // 변수 선언
            //
            //     var i, max, myData, grid = $("#list4");
            //
            //
            //
            //     // grid 설정
            //
            //     grid.jqGrid({
            //
            //         datatype: "local",
            //
            //         height: 'auto',
            //
            //         colNames:['Inv No','Date', 'Client', 'Amount','Tax','Total','Notes'],
            //
            //         colModel:[
            //
            //             {name:'id',index:'id', width:60, sorttype:"int"},
            //
            //             {name:'invdate',index:'invdate', width:90, sorttype:"date"},
            //
            //             {name:'name',index:'name', width:100},
            //
            //             {name:'amount',index:'amount', width:80, align:"right",sorttype:"float"},
            //
            //             {name:'tax',index:'tax', width:80, align:"right",sorttype:"float"},
            //
            //             {name:'total',index:'total', width:80,align:"right",sorttype:"float"},
            //
            //             {name:'note',index:'note', width:150, sortable:false}
            //
            //         ],
            //
            //         multiselect: true,
            //
            //         caption: "Manipulating Array Data"
            //
            //     });
            //
            //
            //
            //     // 로컬 데이터
            //
            //     myData = [
            //
            //         {id:"1",invdate:"2007-10-01",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
            //
            //         {id:"2",invdate:"2007-10-02",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
            //
            //         {id:"3",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
            //
            //         {id:"4",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
            //
            //         {id:"5",invdate:"2007-10-05",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
            //
            //         {id:"6",invdate:"2007-09-06",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"},
            //
            //         {id:"7",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"},
            //
            //         {id:"8",invdate:"2007-10-03",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"},
            //
            //         {id:"9",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"}
            //
            //     ];
            //
            //
            //
            //     // 데이터 추가
            //
            //     for( i=0, max = myData.length ; i<=max ; i++ ){
            //
            //         grid.jqGrid('addRowData', i+1, myData[i]);
            //
            //     }

            });
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
        <!-- Left(Sidebar) 영역// -->록
        <%@ include file="/WEB-INF/jsp/include/common_left.jsp" %>
        <!-- //Left(Sidebar) 영역 -->
        <!-- Content Body 영역 // -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="no_border_head">
                <span class="tab_span flSpan">콘텐츠조회</span>
                <div class="d-flex justify-content-end flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary" onClick="location.href='/temp/detail'">등</button>
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
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                            <input type="text" class="form-control" id="searchBox"; style="width:400px;height:40px; margin-right:3px; display: inline-block;">
                        </td>
                        <th>출처</th>
                        <td>
                            <select class="form-select w130" style="margin-left:6px; display: inline-block;">
                                <option selected>전체</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </td>
                    </tr>
                    <tr height="50">
                        <th>템플릿유형</th>
                        <td>
                            <div>
                                <input class="form-check-input" type="radio" name="templateTypeRadio" id="flexRadio4" checked style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio4">
                                    전체형
                                </label>
                                <input class="form-check-input" type="radio" name="templateTypeRadio" id="flexRadio5" style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio5">
                                    블로그형
                                </label>
                                <input class="form-check-input" type="radio" name="templateTypeRadio" id="flexRadio6" style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio6">
                                    카드
                                </label>
                            </div>
                        </td>
                        <th>콘텐츠 구분</th>
                        <td>
                            <div>
                                <input class="form-check-input" type="radio" name="contentsDivRadio" id="flexRadio7" checked style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio7">
                                    전체
                                </label>
                                <input class="form-check-input" type="radio" name="contentsDivRadio" id="flexRadio8" style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio8">
                                    내부
                                </label>
                                <input class="form-check-input" type="radio" name="contentsDivRadio" id="flexRadio9" style="margin-left:6px; margin-right:6px;">
                                <label class="form-check-label" for="flexRadio9">
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

            <table id="products" summary="창수가 사고 싶은 물건들을 번호, 카테고리, 제품, 가격별로 제공한 표">
                <caption>창수가 사고 싶은 물건 목록</caption>
                <thead>
                <tr>
                    <th scope="col">No.</th>
                    <th scope="col">Category</th>
                    <th scope="col">Product</th>
                    <th scope="col">Price</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Clothing</td>
                    <td>North Face Jacket</td>
                    <td>$189.99</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Shoes</td>
                    <td>Nike</td>
                    <td>$59.99</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Electronics</td>
                    <td>LED TV</td>
                    <td>$589.99</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Sporting Goods</td>
                    <td>Ping Golf Clubs</td>
                    <td>$159.99</td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>Clothing</td>
                    <td>Sweater</td>
                    <td>$19.99</td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>Clothing</td>
                    <td>North Face Jacket</td>
                    <td>$189.99</td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>Shoes</td>
                    <td>Nike</td>
                    <td>$59.99</td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>Electronics</td>
                    <td>LED TV</td>
                    <td>$589.99</td>
                </tr>
                <tr>
                    <td>9</td>
                    <td>Sporting Goods</td>
                    <td>Ping Golf Clubs</td>
                    <td>$159.99</td>
                </tr>
                <tr>
                    <td>10</td>
                    <td>Shoes</td>
                    <td>Nike</td>
                    <td>$59.99</td>
                </tr>
                <tr>
                    <td>11</td>
                    <td>Electronics</td>
                    <td>LED TV</td>
                    <td>$589.99</td>
                </tr>
                <tr>
                    <td>12</td>
                    <td>Sporting Goods</td>
                    <td>Ping Golf Clubs</td>
                    <td>$159.99</td>
                </tr>
                </tbody>
            </table>

            <!-- grid Semple 영역 // -->
            <span class="tab_span">Grid title</span>
            <div class="table-responsive">
                <table class="table table-striped table-sm">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Header</th>
                        <th scope="col">Header</th>
                        <th scope="col">Header</th>
                        <th scope="col">Header</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="ctr_td">
                            <i class="bi hoverBtn bi-file-arrow-up disabled"></i>
                            <i class="bi hoverBtn bi-file-arrow-down"></i>
                        </td>
                        <td>random</td>
                        <td>data</td>
                        <td>placeholder</td>
                        <td>text</td>
                    </tr>
                    <tr>
                        <td class="ctr_td">
                            <i class="bi hoverBtn bi-file-arrow-up"></i>
                            <i class="bi hoverBtn bi-file-arrow-down"></i>
                        </td>
                        <td>placeholder</td>
                        <td>irrelevant</td>
                        <td>visual</td>
                        <td>layout</td>
                    </tr>
                    <tr>
                        <td class="ctr_td">
                            <i class="bi hoverBtn bi-file-arrow-up"></i>
                            <i class="bi hoverBtn bi-file-arrow-down"></i>
                        </td>
                        <td>data</td>
                        <td>rich</td>
                        <td>dashboard</td>
                        <td>tabular</td>
                    </tr>
                    <tr>
                        <td class="ctr_td">
                            <i class="bi hoverBtn bi-file-arrow-up"></i>
                            <i class="bi hoverBtn bi-file-arrow-down"></i>
                        </td>
                        <td>information</td>
                        <td>placeholder</td>
                        <td>illustrative</td>
                        <td>data</td>
                    </tr>
                    <tr>
                        <td class="ctr_td">
                            <i class="bi hoverBtn bi-file-arrow-up"></i>
                            <i class="bi hoverBtn bi-file-arrow-down"></i>
                        </td>
                        <td>text</td>
                        <td>random</td>
                        <td>layout</td>
                        <td>dashboard</td>
                    </tr>
                    <tr>
                        <td class="ctr_td">
                            <i class="bi hoverBtn bi-file-arrow-up"></i>
                            <i class="bi hoverBtn bi-file-arrow-down disabled"></i>
                        </td>
                        <td>dashboard</td>
                        <td>irrelevant</td>
                        <td>text</td>
                        <td>placeholder</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <table id="products" border="1">
                <caption>product list
                    <form action="" id="setRows">
                        <p>
                            showing
                            <input type="text" name="rowPerPage" value="3">
                            item per page
                        </p>
                    </form>

                </caption>

                <thead>
                <tr>
                    <th>No</th>
                    <th>Category</th>
                    <th>Product</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Clothing</td>
                    <td>Jacket</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>life</td>
                    <td>dish</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>Clothing</td>
                    <td>shocks</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>Clothing</td>
                    <td>sports</td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>shoes</td>
                    <td>nike</td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>shoes</td>
                    <td>addidas</td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>Bags</td>
                    <td>backpack</td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>Clothing</td>
                    <td>Jacket</td>
                </tr>
                <tr>
                    <td>9</td>
                    <td>shoes</td>
                    <td>bonie</td>
                </tr>
                <tr>
                    <td>10</td>
                    <td>Clothing</td>
                    <td>Jacket</td>
                </tr>
                </tbody>

            </table>
            <!-- // grid Semple 영역 -->
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1"> << </a>
                    </li>
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1"> < </a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#"> > </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#"> >> </a>
                    </li>
                </ul>
            </nav>
        </main>
        <!-- //Content Body 영역 -->
    </div>
</div>
<!-- //Content Wrapper -->
</body>
</html>
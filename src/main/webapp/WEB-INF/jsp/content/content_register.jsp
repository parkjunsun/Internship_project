<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <%@ include file="/WEB-INF/jsp/include/common_plugin.jsp" %>
<%--    <script type="text/javascript">--%>
<%--        var params ='<c:out value="${result}"/>';--%>

<%--        $(document).ready(function() {--%>
<%--            $.initPage();--%>
<%--        });--%>

<%--        ;(function($){--%>
<%--            $.initPage = function() {--%>
<%--                console.log(params);--%>
<%--            };--%>
<%--        })(jQuery);--%>
<%--    </script>--%>
    <script>
        function loadFile(input) {
            var file = input.files[0];	//선택된 파일 가져오기

            //미리 만들어 놓은 div에 text(파일 이름) 추가
            var name = document.getElementById('fileName');
            name.textContent = file.name;

            //새로운 이미지 div 추가
            var newImage = document.createElement("img");
            newImage.setAttribute("class", 'img');

            //이미지 source 가져오기
            newImage.src = URL.createObjectURL(file);

            newImage.style.width = "30%";
            newImage.style.height = "30%";
            newImage.style.visibility = "visible";
            newImage.style.objectFit = "contain";

            var container = document.getElementById('image-show');
            container.appendChild(newImage);
        }

        $(function() {
            //input을 datepicker로 선언
            $("#datepicker1,#datepicker2").datepicker({
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
            });

            //초기값을 오늘 날짜로 설정해줘야 합니다.
            $('#datepicker1').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
            $('#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
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
                <span class="tab_span flSpan">콘텐츠 등록</span>
                <div class="d-flex justify-content-end flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary" onClick="location.href='/temp/detail'">DetailPage</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Form Table 영역 // -->
            <form action="/content/register" method="post" id="registerForm" enctype="multipart/form-data">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap pt-3">
                    <table class="table table-sm seaerch-table">
                        <tbody>
                        <colgroup>
                            <col width="130px">
                            <col width="38%">
                            <col width="130px">
                            <col width="*">
                        </colgroup>
                        <tr>
                            <th>콘텐츠명</th>
                            <td>
                                <input type="text" class="form-control" name="ctnNm" id="ctnNm">
                            </td>
                            <th>콘텐츠 구분</th>
                            <td colspan="2">
                                <div>
                                    <input class="form-check-input" type="radio" name="ctnDiv" id="inside" value="in" checked>
                                    <label class="form-check-label" for="inside">
                                        내부
                                    </label>
                                    <input class="form-check-input" type="radio" name="ctnDiv" id="outside" value="out">
                                    <label class="form-check-label" for="outside">
                                        외부
                                    </label>
                                </div>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <th>템플릿 유형</th>
                            <td>
                                <div>
                                    <c:forEach var="item" items="${tplList}">
                                        <input class="form-check-input" type="radio" name="tplCd" id="tplCd" value=${item.cd_nm} checked>
                                        <label class="form-check-label" for="tplCd">
                                            ${item.cd_nm}
                                        </label>
                                    </c:forEach>
                                </div>
                            </td>
                        <tr>
                            <th>전시 기간</th>
                            <td>
                                <input type="text" class="datepicker" name="dspStDt" id="dspStDt">
                                ~
                                <input type="text" class="datepicker" name="dspEndDt" id="dspEndDt">
                            </td>
                            <th>전시 상태</th>
                            <td>
                                <div>
                                    <input class="form-check-input" type="radio" name="dspYn" id="display" value="y" checked>
                                    <label class="form-check-label" for="display">
                                        전시
                                    </label>
                                    <input class="form-check-input" type="radio" name="dspYn" id="not_display" value="n">
                                    <label class="form-check-label" for="not_display">
                                        전시안함
                                    </label>
                                </div>
                            </td>
                            <th>댓글가능 여부</th>
                            <td>
                                <div>
                                    <input class="form-check-input" type="radio" name="cmtYn" id="yes" value="y" checked>
                                    <label class="form-check-label" for="yes">
                                        가능
                                    </label>
                                    <input class="form-check-input" type="radio" name="cmtYn" id="no" value="n">
                                    <label class="form-check-label" for="no">
                                        불가능
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td></td>
                            <th>콘텐츠 출처</th>
                            <td colspan="2">
                                <select class="form-select w130" style="margin-left:3px; margin-right:3px; display: inline-block;" name="srcCd" id="srcCd">
                                    <option selected>전체</option>
                                    <c:forEach var="item" items="${srcList}">
                                        <option value="${item.cd}">${item.cd_nm}</option>
                                    </c:forEach>
<%--                                    <option value="S0009">서울경제</option>--%>
<%--                                    <option value="S0014">디미토리</option>--%>
                                </select>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <th rowspan="2">대표이미지</th>
                            <td rowspan="2">
                                <div class="fileContainer">
                                    <div class="fileInput">
                                        <div class="image-show" id="image-show"></div>
                                        <p id="fileName"></p>
                                    </div>
                                </div>
                                <div>
                                    <input type="file" name="repr_img" id="repr_img" accept="image/png, image/jpeg"  onchange="loadFile(this)">
                                </div>
                            </td>
                            <th>상담하기</th>
                            <td colspan="2">
                                <div>
                                    <input class="form-check-input" type="radio" name="cstYn" id="not_use" value="y" checked>
                                    <label class="form-check-label" for="not_use">
                                        미사용
                                    </label>
                                    <input class="form-check-input" type="radio" name="cstYn" id="use" value="n">
                                    <label class="form-check-label" for="use">
                                        사용
                                    </label>
                                </div>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <th>팝업문구</th>
                            <td colspan="2">
                                <input type="text" class="form-control" name="popMsg" id="popMsg" placeholder="25자 이내로 작성해 주세요">
                            </td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </form>
            <button class="btn btn-lg btn-primary btn-block" onclick="location.href='/' ">취소</button><br><br><br>
            <button type="submit" class="btn btn-lg btn-primary btn-block" id="btn_submit" form="registerForm">저장</button><br>
        </main>
    </div>
</div>
</body>
</html>
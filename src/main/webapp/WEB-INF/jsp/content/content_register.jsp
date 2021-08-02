<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
    <%@ include file="/WEB-INF/jsp/include/common_plugin.jsp" %>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>

        .bottom_td {
            text-align: center;
            height: 100px;
        }

        .file-input {
            padding: 6px 25px;
            background-color: black;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }

    </style>
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

        window.onload = function(){
            document.getElementById('tplCd0').checked = true;
        };

        $(function() {
            //input을 datepicker로 선언
            $("#dspStDt").datepicker({
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
                    var start = new Date($("#dspStDt").datepicker("getDate"));
                    var end = new Date($("#dspEndDt").datepicker("getDate"));
                    if (end - start < 0){
                        alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                        $('#dspStDt').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
                    }

                }
            });
            $("#dspEndDt").datepicker({
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
                    var start = new Date($("#dspStDt").datepicker("getDate"));
                    var end = new Date($("#dspEndDt").datepicker("getDate"));
                    if (end - start < 0){
                        alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                        $('#dspEndDt').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
                    }
                }
            });


            //초기값을 오늘 날짜로 설정해줘야 합니다.
            $('#dspStDt').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
            $('#dspEndDt').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
            $("img.ui-datepicker-trigger").css({'cursor':'pointer', 'margin-left':'5px'});

        });

        function loadFile(input) {
            const file = input.files[0];	//선택된 파일 가져오기

            //미리 만들어 놓은 div에 text(파일 이름) 추가
            const name = document.getElementById('fileName');
            name.textContent = file.name;

            //새로운 이미지 div 추가
            const newImage = document.createElement("img");
            newImage.setAttribute("class", 'img');

            //이미지 source 가져오기
            newImage.src = URL.createObjectURL(file);

            newImage.style.width = "750px;";
            newImage.style.height = "1500px;";
            newImage.style.visibility = "visible";
            newImage.style.objectFit = "contain";

            const container = document.getElementById('image-show');
            if (container.querySelector('.img') != null) {
                const oldImage = container.querySelector('.img');
                container.removeChild(oldImage);
            }
            container.appendChild(newImage);
        }

        function ctn_loadFile(input) {
            const cur = input.id[input.id.length-1];

            var file = input.files[0];
            // var name = document.getElementById('ctn_fileName' + cur);
            // name.textContent = file.name;

            var newImage = document.createElement("img");
            newImage.setAttribute("class", "img");

            newImage.src = URL.createObjectURL(file);

            newImage.style.width = "150px";
            newImage.style.height = "150px";
            newImage.style.visibility = "visible";
            newImage.style.objectFit = "contain";

            var container = document.getElementById('ctn_image-show' + cur);
            if (container.querySelector('.img') != null) {
                const oldImage = container.querySelector('.img');
                container.removeChild(oldImage);
            }
            container.appendChild(newImage);
        }



        function checkArrowAble() {

            if (ctn_index === 1) {
                document.getElementById('up_arrow1').classList.add('disabled');
                document.getElementById('up_arrow1').style.cursor = 'default';
                document.getElementById('down_arrow1').classList.add('disabled');
                document.getElementById('down_arrow1').style.cursor = 'default';
            } else if (ctn_index === 2) {
                document.getElementById('up_arrow1').classList.add('disabled');
                document.getElementById('up_arrow1').style.cursor = 'default';
                document.getElementById('down_arrow1').classList.remove('disabled');
                document.getElementById('down_arrow1').style.cursor = 'pointer';
                document.getElementById('up_arrow2').classList.remove('disabled');
                document.getElementById('up_arrow2').style.cursor = 'pointer';
                document.getElementById('down_arrow2').classList.add('disabled');
                document.getElementById('down_arrow2').style.cursor = 'default';
            } else {
                for (var i = 2; i < ctn_index; i++) {
                    document.getElementById('down_arrow' + String(i)).classList.remove('disabled');
                    document.getElementById('down_arrow' + String(i)).style.cursor = 'pointer';
                    document.getElementById('up_arrow' + String(i)).classList.remove('disabled');
                    document.getElementById('up_arrow' + String(i)).style.cursor = 'pointer';
                }

                document.getElementById('up_arrow1').classList.add('disabled');
                document.getElementById('up_arrow1').style.cursor = 'default';
                document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
                document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'pointer';
            }
        }

        var idx_list = [];

        function removeRow(e) {
            const cur = Number(e.id[e.id.length-1]);
            const table = document.getElementById('extraContent');
            table.deleteRow(cur);
            idx_list.pop();
            for (var i = cur+1 ; i <= 5; i++){
                if (i > ctn_index) {
                    break;
                }
                var findTr = document.getElementById('tr' + String(i));
                findTr.id = 'tr' + String(i - 1);

                var seqBlock = document.getElementById('seq' + String(i));
                seqBlock.id = 'seq' + String(i - 1);
                seqBlock.innerText = i - 1;

                var i_up = document.getElementById('up_arrow' + String(i));
                i_up.id = 'up_arrow' + String(i - 1);
                if (i - 1 === 1) {
                    i_up.classList.add('disabled');
                    i_up.style.cursor = 'default';
                }

                var i_down = document.getElementById('down_arrow' + String(i));
                i_down.id = 'down_arrow' + String(i - 1);

                var img_show = document.getElementById('ctn_image-show' + String(i));
                img_show.id = 'ctn_image-show' + String(i - 1);

                var fNm = document.getElementById('ctn_fileName' + String(i));
                fNm.id = 'ctn_fileName' + String(i - 1);

                var inputFile = document.getElementById('ctn_img' + String(i));
                inputFile.id = 'ctn_img' + String(i - 1);
                inputFile.name = 'ctn_img' + String(i - 1);

                var removeBtn = document.getElementById('remove_btn' + String(i));
                removeBtn.id = 'remove_btn' + String(i - 1)
            }

            ctn_index -= 1;

            document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
            document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'default';

            // if (idx_list.length === 1) {
            //     document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
            //     document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'default';
            // }
        }

        function moveUpTr(node) {
            const table = document.getElementById('tbody');

            const curTr = node.parentElement.parentElement;
            const preTr = curTr.previousElementSibling;

            const curIdx = curTr.id[curTr.id.length-1];
            const preIdx = preTr.id[preTr.id.length-1];
            curTr.id = 'tr' + preIdx;
            preTr.id = 'tr' + curIdx;

            const curSeqBlock = document.getElementById('seq' + curIdx);
            const preSeqBlock = document.getElementById('seq' + preIdx);
            curSeqBlock.id = 'seq' + preIdx;
            curSeqBlock.innerText = preIdx;
            preSeqBlock.id = 'seq' + curIdx;
            preSeqBlock.innerText = curIdx;

            const curUpArrowBlock = document.getElementById('up_arrow' + curIdx);
            const preUpArrowBlock = document.getElementById('up_arrow' + preIdx);
            curUpArrowBlock.id = 'up_arrow' + preIdx;
            preUpArrowBlock.id = 'up_arrow' + curIdx;
            const curDownArrowBlock = document.getElementById('down_arrow' + curIdx);
            const preDownArrowBlock = document.getElementById('down_arrow' + preIdx);
            curDownArrowBlock.id = 'down_arrow' + preIdx;
            preDownArrowBlock.id = 'down_arrow' + curIdx;

            const curCtnImgShowBlock = document.getElementById('ctn_image-show' + curIdx);
            const preCtnImgShowBlock = document.getElementById('ctn_image-show' + preIdx);
            curCtnImgShowBlock.id = 'ctn_image-show' + preIdx;
            preCtnImgShowBlock.id = 'ctn_image-show' + curIdx;

            const curCtnFeNmBlock = document.getElementById('ctn_fileName' + curIdx);
            const preCtnFeNmBlock = document.getElementById('ctn_fileName' + preIdx);
            curCtnFeNmBlock.id = 'ctn_fileName' + preIdx;
            preCtnFeNmBlock.id = 'ctn_fileName' + curIdx;

            const curInputFileBlock = document.getElementById('ctn_img' + curIdx);
            const preInputFileBlock = document.getElementById('ctn_img' + preIdx);
            curInputFileBlock.id = 'ctn_img' + preIdx;
            preInputFileBlock.id = 'ctn_img' + curIdx;
            curInputFileBlock.name = 'ctn_img' + preIdx;
            preInputFileBlock.name = 'ctn_img' + curIdx;

            const curRmBtnBlock = document.getElementById('remove_btn' + curIdx);
            const preRmBtnBlock = document.getElementById('remove_btn'+ preIdx);
            curRmBtnBlock.id = 'remove_btn' + preIdx;
            preRmBtnBlock.id = 'remove_btn' + curIdx;

            table.insertBefore(curTr, preTr);

            checkArrowAble();

        }

        function moveDownTr(node) {
            const table = document.getElementById('tbody');

            const currentTr = node.parentElement.parentElement;
            const nextTr = currentTr.nextElementSibling;

            const currentIdx = currentTr.id[currentTr.id.length-1];
            const nextIdx = nextTr.id[nextTr.id.length-1];
            currentTr.id = 'tr' + String(nextIdx);
            nextTr.id = 'tr' + String(currentIdx);

            const currentSeqBlock = document.getElementById('seq' + String(currentIdx));
            const nextSeqBlock = document.getElementById('seq' + String(nextIdx));
            currentSeqBlock.id = 'seq' + String(nextIdx);
            currentSeqBlock.innerText = nextIdx;
            nextSeqBlock.id = 'seq' + String(currentIdx);
            nextSeqBlock.innerText = currentIdx;

            const currentUpArrowBlock = document.getElementById('up_arrow' + String(currentIdx));
            const nextUpArrowBlock = document.getElementById('up_arrow' + String(nextIdx));
            currentUpArrowBlock.id = 'up_arrow' + String(nextIdx);
            nextUpArrowBlock.id = 'up_arrow' + String(currentIdx);
            const currentDownArrowBlock = document.getElementById('down_arrow' + String(currentIdx));
            const nextDownArrowBlock = document.getElementById('down_arrow' + String(nextIdx));
            currentDownArrowBlock.id = 'down_arrow' + String(nextIdx);
            nextDownArrowBlock.id = 'down_arrow' + String(currentIdx);

            const currentCtnImgShowBlock = document.getElementById('ctn_image-show' + String(currentIdx));
            const nextCtnImgShowBlock = document.getElementById('ctn_image-show' + String(nextIdx));
            currentCtnImgShowBlock.id = 'ctn_image-show' + String(nextIdx);
            nextCtnImgShowBlock.id = 'ctn_image-show' + String(currentIdx);

            const currentCtnFeNmBlock = document.getElementById('ctn_fileName' + String(currentIdx));
            const nextCtnFeNmBlock = document.getElementById('ctn_fileName' + String(nextIdx));
            currentCtnFeNmBlock.id = 'ctn_fileName' + String(nextIdx);
            nextCtnFeNmBlock.id = 'ctn_fileName' + String(currentIdx);

            const currentInputFileBlock = document.getElementById('ctn_img' + String(currentIdx));
            const nextInputFileBlock = document.getElementById('ctn_img' + String(nextIdx));
            currentInputFileBlock.id = 'ctn_img' + String(nextIdx);
            nextInputFileBlock.id = 'ctn_img' + String(currentIdx);
            currentInputFileBlock.name = 'ctn_img' + String(nextIdx);
            nextInputFileBlock.name = 'ctn_img' + String(currentIdx);

            const currentRmBtnBlock = document.getElementById('remove_btn' + String(currentIdx));
            const nextRmBtnBlock = document.getElementById('remove_btn' + String(nextIdx));
            currentRmBtnBlock.id = 'remove_btn' + String(nextIdx);
            nextRmBtnBlock.id = 'remove_btn' + String(currentIdx);


            table.insertBefore(nextTr, currentTr);

            checkArrowAble();

        }


        var ctn_index = 0;

        function addRow() {
            ctn_index += 1;
            idx_list.push(ctn_index)
            var my_index = ctn_index;

            if (ctn_index === 6) {
                alert("콘텐츠 본문내용은 최대 5개 까지 등록할 수 있습니다.");
                ctn_index -= 1;
                return;
            }

            const table = document.getElementById('tbody');

            const newRow = table.insertRow();
            newRow.id = 'tr' + String(my_index);

            const newCell1 = newRow.insertCell(0);
            const newCell2 = newRow.insertCell(1);
            const newCell3 = newRow.insertCell(2);
            const newCell4 = newRow.insertCell(3);

            newCell1.innerText = ctn_index;
            newCell1.classList.add("bottom_td");
            newCell1.id = 'seq' + String(my_index);

            newCell2.classList.add("bottom_td", "ctr_td");

            const i_up = document.createElement('i');
            i_up.classList.add('bi', 'hoverBtn', 'bi-file-arrow-up');
            i_up.id = 'up_arrow' + String(my_index);
            i_up.style.cursor = 'pointer';
            i_up.addEventListener('click', function () {moveUpTr(this)});


            const i_down = document.createElement('i');
            i_down.classList.add('bi', 'hoverBtn', 'bi-file-arrow-down');
            i_down.id = 'down_arrow' + String(my_index);
            i_down.style.cursor = 'pointer';
            i_down.addEventListener('click', function () {moveDownTr(this)});

            if (my_index === 1) {
                i_up.classList.add('disabled');
                i_up.style.cursor = 'default';
                i_down.classList.add('disabled');
                i_down.style.cursor = 'default';
            } else {
                if (ctn_index === my_index) {
                    i_down.classList.add('disabled');
                    i_down.style.cursor = 'default';
                    document.getElementById('down_arrow' + String(my_index - 1)).classList.remove('disabled');
                    document.getElementById('down_arrow' + String(my_index - 1)).style.cursor = 'pointer';
                }
            }

            newCell2.append(i_up, i_down);

            // newCell3.classList.add('bottom_td');
            const feDiv = document.createElement('div');
            feDiv.classList.add('fileInput');

            const imgDiv = document.createElement('div');
            imgDiv.id = 'ctn_image-show' + String(my_index);

            // const feNmP = document.createElement('p');
            // feNmP.id = 'ctn_fileName' + String(my_index);
            // feNmP.style.float = 'left';

            feDiv.append(imgDiv);

            const div = document.createElement('div');

            const label = document.createElement('label');
            label.classList.add('file-input');
            label.for = 'ctn_img' + String(my_index);
            label.innerText = "찾기";

            const inputFile = document.createElement('input');
            inputFile.style.display = 'none';
            inputFile.setAttribute('type', 'file');
            inputFile.setAttribute('name', 'ctn_img' + String(my_index));
            inputFile.setAttribute('id', 'ctn_img' + String(my_index));
            inputFile.setAttribute('accept', 'image/png, image/jpeg');
            inputFile.addEventListener('change', function () {ctn_loadFile(this)});

            label.append(inputFile)
            div.append(label);
            newCell3.append(feDiv, div);

            newCell4.classList.add("bottom_td");
            const remove_btn = document.createElement('button')
            remove_btn.innerText = "삭제"
            remove_btn.classList.add("remove_btn");
            remove_btn.id = 'remove_btn' + String(my_index);
            remove_btn.setAttribute('type', 'button');
            remove_btn.addEventListener('click', function () {removeRow(this)});
            newCell4.append(remove_btn)
        }


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
            <form action="/content/register" method="post" id="registerForm" enctype="multipart/form-data" style="display: inline">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap pt-3">
                    <table class="table table-sm search-table">
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
                                    <c:forEach var="item" items="${tplList}" varStatus="status">
                                        <input class="form-check-input" type="radio" name="tplCd" id="tplCd${status.index}" value=${item.cd}>
                                        <label class="form-check-label" for="tplCd${status.index}">
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
                                <div class="fileInput">
                                    <div class="image-show" id="image-show"></div>
                                    <p id="fileName"></p>
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
                </div><br><br><br>
                <div class="table-responsive">
                    <div style="border: 1px solid black; height: 30px;">
                        <span style="float:left;">콘텐츠 본문내용</span>
                        <button type="button" style="float: right" id="add_btn" onclick="addRow()">콘텐츠 추가</button>
                    </div>
                    <table class="table table-striped table-sm" id="extraContent">
                        <thead>
                        <tr>
                            <th scope="col" style="text-align: center;">본문</th>
                            <th scope="col" style="text-align: center;">전시순서</th>
                            <th scope="col" style="text-align: center">본문 이미지</th>
                            <th scope="col" style="text-align: center;">영역 삭제</th>
                        </tr>
                        </thead>
                    <tbody id="tbody">
                    <colgroup>
                        <col width="150px">
                        <col width="150px">
                        <col width="*">
                        <col width="150px">
                    </colgroup>
<%--                    <tr id="tr1" style="display: none">--%>
<%--                        <td class="bottom_td" id="seq1">--%>
<%--                            1--%>
<%--                        </td>--%>
<%--                        <td class="ctr_td bottom_td">--%>
<%--                            <i class="bi hoverBtn bi-file-arrow-up disabled" id="up_arrow1"></i>--%>
<%--                            <i class="bi hoverBtn bi-file-arrow-down disabled" id="down_arrow1"></i>--%>
<%--                        </td>--%>
<%--                        <td class="bottom_td">--%>
<%--                            <div class="fileInput">--%>
<%--                                <div name="ctn_image-show" id="ctn_image-show1"></div>--%>
<%--                                <p id="ctn_fileName1"></p>--%>
<%--                            </div>--%>
<%--                            <div>--%>
<%--                                <input type="file" name="ctn_img1" id="ctn_img1" accept="image/png, image/jpeg"  onchange="ctn_loadFile(this, '1')">--%>
<%--                            </div>--%>
<%--                        </td>--%>
<%--                        <td class="bottom_td">--%>
<%--                            <button type="button" class="remove_btn" id="remove_btn1" onclick="removeRow(this)">삭제</button>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
                    </tbody>
                </table>
                </div>
            </form>
            <br><br><br><br>
            <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                <div class="btn-toolbar mb-2">
                    <div class="btn-group">
                        <button type="button" class="btn btn-secondary" onclick="location.href='/' " style="margin-right: 20px;">취소</button>
                        <button type="submit" class="btn btn-primary" id="btn_submit" form="registerForm" style="margin-right: 100px;">저장</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
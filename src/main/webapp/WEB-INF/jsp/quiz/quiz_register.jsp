<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
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

        var quizCnt = 0;

        var quizTypes = new Array();
        <c:forEach items="${types}" var="type">
            var obj = {
                "quizNm" : "${type.quizNm}",
                "quizCd" : "${type.quizCd}"
            };
            quizTypes.push(obj);
        </c:forEach>


        <%--console.log(quizTypes);--%>

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

        // function loadFile(input) {
        //     const file = input.files[0];	//선택된 파일 가져오기
        //
        //     const fileName = file.name;
        //     const extension = fileName.substring(fileName.indexOf('.') + 1, fileName.length);
        //
        //     const fileSize = input.size;
        //     const MAX_SIZE = 315000;
        //
        //     if (fileSize >= MAX_SIZE) {
        //         alert("이미지 포맷이 맞지 않습니다.");
        //         return false;
        //     }
        //
        //     if (extension === "gif" || extension === "jpg" || extension === "png") {
        //         const newImage = document.createElement("img");
        //         newImage.setAttribute("class", 'reprImg');
        //
        //         //이미지 source 가져오기
        //         newImage.src = URL.createObjectURL(file);
        //
        //         newImage.style.width = "150px;";
        //         newImage.style.height = "150px;";
        //         newImage.style.visibility = "visible";
        //         newImage.style.objectFit = "contain";
        //
        //         const container = document.getElementById('image-show');
        //         if (container.querySelector('.img') != null) {
        //             const oldImage = container.querySelector('.img');
        //             container.removeChild(oldImage);
        //         }
        //         container.appendChild(newImage);
        //     } else {
        //         alert("이미지 포맷이 맞지 않습니다.");
        //         return false;
        //     }
        // }
        //
        // function ctn_loadFile(input) {
        //     const cur = input.id[input.id.length-1];
        //
        //     var file = input.files[0];
        //     const fileName = file.name;
        //     const extension = fileName.substring(fileName.indexOf('.') + 1, fileName.length)
        //
        //     const fileSize = input.size;
        //     const MAX_SIZE = 1125000
        //
        //     if (fileSize >= MAX_SIZE) {
        //         alert("이미지 포맷이 맞지 않습니다.");
        //         return false;
        //     }
        //
        //     if (extension === "gif" || extension === "jpg" || extension === "png") {
        //         var newImage = document.createElement("img");
        //         newImage.setAttribute("class", "ctnDetImg");
        //
        //         newImage.src = URL.createObjectURL(file);
        //
        //         newImage.style.width = "150px";
        //         newImage.style.height = "150px";
        //         newImage.style.visibility = "visible";
        //         newImage.style.objectFit = "contain";
        //
        //         var container = document.getElementById('ctn_image-show' + cur);
        //         if (container.querySelector('.img') != null) {
        //             const oldImage = container.querySelector('.img');
        //             container.removeChild(oldImage);
        //         }
        //         container.appendChild(newImage);
        //     } else {
        //         alert("이미지 포맷이 맞지 않습니다.");
        //         return false;
        //     }
        //
        //
        //     // var name = document.getElementById('ctn_fileName' + cur);
        //     // name.textContent = file.name;
        //
        // }
        //
        //
        // function checkArrowAble() {
        //
        //     if (ctn_index === 1) {
        //         document.getElementById('up_arrow1').classList.add('disabled');
        //         document.getElementById('up_arrow1').style.cursor = 'default';
        //         document.getElementById('down_arrow1').classList.add('disabled');
        //         document.getElementById('down_arrow1').style.cursor = 'default';
        //     } else if (ctn_index === 2) {
        //         document.getElementById('up_arrow1').classList.add('disabled');
        //         document.getElementById('up_arrow1').style.cursor = 'default';
        //         document.getElementById('down_arrow1').classList.remove('disabled');
        //         document.getElementById('down_arrow1').style.cursor = 'pointer';
        //         document.getElementById('up_arrow2').classList.remove('disabled');
        //         document.getElementById('up_arrow2').style.cursor = 'pointer';
        //         document.getElementById('down_arrow2').classList.add('disabled');
        //         document.getElementById('down_arrow2').style.cursor = 'default';
        //     } else {
        //         for (var i = 2; i < ctn_index; i++) {
        //             document.getElementById('down_arrow' + String(i)).classList.remove('disabled');
        //             document.getElementById('down_arrow' + String(i)).style.cursor = 'pointer';
        //             document.getElementById('up_arrow' + String(i)).classList.remove('disabled');
        //             document.getElementById('up_arrow' + String(i)).style.cursor = 'pointer';
        //         }
        //
        //         document.getElementById('up_arrow1').classList.add('disabled');
        //         document.getElementById('up_arrow1').style.cursor = 'default';
        //         document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
        //         document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'pointer';
        //     }
        // }
        //
        // var idx_list = [];
        //
        // function removeRow(e) {
        //     const cur = Number(e.id[e.id.length-1]);
        //     const table = document.getElementById('extraContent');
        //     table.deleteRow(cur);
        //     idx_list.pop();
        //     for (var i = cur+1 ; i <= 5; i++){
        //         if (i > ctn_index) {
        //             break;
        //         }
        //         var findTr = document.getElementById('tr' + String(i));
        //         findTr.id = 'tr' + String(i - 1);
        //
        //         var seqBlock = document.getElementById('seq' + String(i));
        //         seqBlock.id = 'seq' + String(i - 1);
        //         seqBlock.innerText = i - 1;
        //
        //         var i_up = document.getElementById('up_arrow' + String(i));
        //         i_up.id = 'up_arrow' + String(i - 1);
        //         if (i - 1 === 1) {
        //             i_up.classList.add('disabled');
        //             i_up.style.cursor = 'default';
        //         }
        //
        //         var i_down = document.getElementById('down_arrow' + String(i));
        //         i_down.id = 'down_arrow' + String(i - 1);
        //
        //         var img_show = document.getElementById('ctn_image-show' + String(i));
        //         img_show.id = 'ctn_image-show' + String(i - 1);
        //
        //         // var fNm = document.getElementById('ctn_fileName' + String(i));
        //         // fNm.id = 'ctn_fileName' + String(i - 1);
        //
        //         var inputFile = document.getElementById('ctn_img' + String(i));
        //         inputFile.id = 'ctn_img' + String(i - 1);
        //         // inputFile.name = 'ctn_img' + String(i - 1);
        //
        //         var removeBtn = document.getElementById('remove_btn' + String(i));
        //         removeBtn.id = 'remove_btn' + String(i - 1)
        //     }
        //
        //     ctn_index -= 1;
        //
        //     document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
        //     document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'default';
        //
        //     // if (idx_list.length === 1) {
        //     //     document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
        //     //     document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'default';
        //     // }
        // }
        //
        // function moveUpTr(node) {
        //     const table = document.getElementById('tbody');
        //
        //     const curTr = node.parentElement.parentElement;
        //     const preTr = curTr.previousElementSibling;
        //
        //     const curIdx = curTr.id[curTr.id.length-1];
        //     const preIdx = preTr.id[preTr.id.length-1];
        //     curTr.id = 'tr' + preIdx;
        //     preTr.id = 'tr' + curIdx;
        //
        //     const curSeqBlock = document.getElementById('seq' + curIdx);
        //     const preSeqBlock = document.getElementById('seq' + preIdx);
        //     curSeqBlock.id = 'seq' + preIdx;
        //     curSeqBlock.innerText = preIdx;
        //     preSeqBlock.id = 'seq' + curIdx;
        //     preSeqBlock.innerText = curIdx;
        //
        //     const curUpArrowBlock = document.getElementById('up_arrow' + curIdx);
        //     const preUpArrowBlock = document.getElementById('up_arrow' + preIdx);
        //     curUpArrowBlock.id = 'up_arrow' + preIdx;
        //     preUpArrowBlock.id = 'up_arrow' + curIdx;
        //     const curDownArrowBlock = document.getElementById('down_arrow' + curIdx);
        //     const preDownArrowBlock = document.getElementById('down_arrow' + preIdx);
        //     curDownArrowBlock.id = 'down_arrow' + preIdx;
        //     preDownArrowBlock.id = 'down_arrow' + curIdx;
        //
        //     const curCtnImgShowBlock = document.getElementById('ctn_image-show' + curIdx);
        //     const preCtnImgShowBlock = document.getElementById('ctn_image-show' + preIdx);
        //     curCtnImgShowBlock.id = 'ctn_image-show' + preIdx;
        //     preCtnImgShowBlock.id = 'ctn_image-show' + curIdx;
        //
        //     // const curCtnFeNmBlock = document.getElementById('ctn_fileName' + curIdx);
        //     // const preCtnFeNmBlock = document.getElementById('ctn_fileName' + preIdx);
        //     // curCtnFeNmBlock.id = 'ctn_fileName' + preIdx;
        //     // preCtnFeNmBlock.id = 'ctn_fileName' + curIdx;
        //
        //     const curInputFileBlock = document.getElementById('ctn_img' + curIdx);
        //     const preInputFileBlock = document.getElementById('ctn_img' + preIdx);
        //     curInputFileBlock.id = 'ctn_img' + preIdx;
        //     preInputFileBlock.id = 'ctn_img' + curIdx;
        //     // curInputFileBlock.name = 'ctn_img' + preIdx;
        //     // preInputFileBlock.name = 'ctn_img' + curIdx;
        //
        //     const curRmBtnBlock = document.getElementById('remove_btn' + curIdx);
        //     const preRmBtnBlock = document.getElementById('remove_btn'+ preIdx);
        //     curRmBtnBlock.id = 'remove_btn' + preIdx;
        //     preRmBtnBlock.id = 'remove_btn' + curIdx;
        //
        //     table.insertBefore(curTr, preTr);
        //
        //     checkArrowAble();
        //
        // }
        //
        // function moveDownTr(node) {
        //     const table = document.getElementById('tbody');
        //
        //     const currentTr = node.parentElement.parentElement;
        //     const nextTr = currentTr.nextElementSibling;
        //
        //     const currentIdx = currentTr.id[currentTr.id.length-1];
        //     const nextIdx = nextTr.id[nextTr.id.length-1];
        //     currentTr.id = 'tr' + String(nextIdx);
        //     nextTr.id = 'tr' + String(currentIdx);
        //
        //     const currentSeqBlock = document.getElementById('seq' + String(currentIdx));
        //     const nextSeqBlock = document.getElementById('seq' + String(nextIdx));
        //     currentSeqBlock.id = 'seq' + String(nextIdx);
        //     currentSeqBlock.innerText = nextIdx;
        //     nextSeqBlock.id = 'seq' + String(currentIdx);
        //     nextSeqBlock.innerText = currentIdx;
        //
        //
        //     const currentUpArrowBlock = document.getElementById('up_arrow' + String(currentIdx));
        //     const nextUpArrowBlock = document.getElementById('up_arrow' + String(nextIdx));
        //     currentUpArrowBlock.id = 'up_arrow' + String(nextIdx);
        //     nextUpArrowBlock.id = 'up_arrow' + String(currentIdx);
        //     const currentDownArrowBlock = document.getElementById('down_arrow' + String(currentIdx));
        //     const nextDownArrowBlock = document.getElementById('down_arrow' + String(nextIdx));
        //     currentDownArrowBlock.id = 'down_arrow' + String(nextIdx);
        //     nextDownArrowBlock.id = 'down_arrow' + String(currentIdx);
        //
        //
        //     const currentCtnImgShowBlock = document.getElementById('ctn_image-show' + String(currentIdx));
        //     const nextCtnImgShowBlock = document.getElementById('ctn_image-show' + String(nextIdx));
        //     currentCtnImgShowBlock.id = 'ctn_image-show' + String(nextIdx);
        //     nextCtnImgShowBlock.id = 'ctn_image-show' + String(currentIdx);
        //
        //
        //     // const currentCtnFeNmBlock = document.getElementById('ctn_fileName' + String(currentIdx));
        //     // const nextCtnFeNmBlock = document.getElementById('ctn_fileName' + String(nextIdx));
        //     // currentCtnFeNmBlock.id = 'ctn_fileName' + String(nextIdx);
        //     // nextCtnFeNmBlock.id = 'ctn_fileName' + String(currentIdx);
        //
        //
        //     const currentInputFileBlock = document.getElementById('ctn_img' + String(currentIdx));
        //     const nextInputFileBlock = document.getElementById('ctn_img' + String(nextIdx));
        //     currentInputFileBlock.id = 'ctn_img' + String(nextIdx);
        //     nextInputFileBlock.id = 'ctn_img' + String(currentIdx);
        //     // currentInputFileBlock.name = 'ctn_img' + String(nextIdx);
        //     // nextInputFileBlock.name = 'ctn_img' + String(currentIdx);
        //
        //     const currentRmBtnBlock = document.getElementById('remove_btn' + String(currentIdx));
        //     const nextRmBtnBlock = document.getElementById('remove_btn' + String(nextIdx));
        //     currentRmBtnBlock.id = 'remove_btn' + String(nextIdx);
        //     nextRmBtnBlock.id = 'remove_btn' + String(currentIdx);
        //
        //
        //     table.insertBefore(nextTr, currentTr);
        //
        //     checkArrowAble();
        //
        // }
        //
        //
        // var ctn_index = 0;
        //
        // function addRow() {
        //     ctn_index += 1;
        //     idx_list.push(ctn_index)
        //     var my_index = ctn_index;
        //
        //     if (ctn_index === 6) {
        //         alert("콘텐츠 본문내용은 최대 5개 까지 등록할 수 있습니다.");
        //         ctn_index -= 1;
        //         return;
        //     }
        //
        //     const table = document.getElementById('tbody');
        //
        //     const newRow = table.insertRow();
        //     newRow.id = 'tr' + String(my_index);
        //
        //     const newCell1 = newRow.insertCell(0);
        //     const newCell2 = newRow.insertCell(1);
        //     const newCell3 = newRow.insertCell(2);
        //     const newCell4 = newRow.insertCell(3);
        //
        //     newCell1.innerText = ctn_index;
        //     newCell1.classList.add("bottom_td");
        //     newCell1.id = 'seq' + String(my_index);
        //
        //     newCell2.classList.add("bottom_td", "ctr_td");
        //
        //     const i_up = document.createElement('i');
        //     i_up.classList.add('bi', 'hoverBtn', 'bi-file-arrow-up');
        //     i_up.id = 'up_arrow' + String(my_index);
        //     i_up.style.cursor = 'pointer';
        //     i_up.addEventListener('click', function () {moveUpTr(this)});
        //
        //
        //     const i_down = document.createElement('i');
        //     i_down.classList.add('bi', 'hoverBtn', 'bi-file-arrow-down');
        //     i_down.id = 'down_arrow' + String(my_index);
        //     i_down.style.cursor = 'pointer';
        //     i_down.addEventListener('click', function () {moveDownTr(this)});
        //
        //     if (my_index === 1) {
        //         i_up.classList.add('disabled');
        //         i_up.style.cursor = 'default';
        //         i_down.classList.add('disabled');
        //         i_down.style.cursor = 'default';
        //     } else {
        //         if (ctn_index === my_index) {
        //             i_down.classList.add('disabled');
        //             i_down.style.cursor = 'default';
        //             document.getElementById('down_arrow' + String(my_index - 1)).classList.remove('disabled');
        //             document.getElementById('down_arrow' + String(my_index - 1)).style.cursor = 'pointer';
        //         }
        //     }
        //
        //     newCell2.append(i_up, i_down);
        //
        //     // newCell3.classList.add('bottom_td');
        //     const feDiv = document.createElement('div');
        //     feDiv.classList.add('fileInput');
        //
        //     const imgDiv = document.createElement('div');
        //     imgDiv.id = 'ctn_image-show' + String(my_index);
        //
        //     // const feNmP = document.createElement('p');
        //     // feNmP.id = 'ctn_fileName' + String(my_index);
        //     // feNmP.style.float = 'left';
        //
        //     feDiv.append(imgDiv);
        //
        //     const div = document.createElement('div');
        //
        //     const label = document.createElement('label');
        //     label.classList.add('file-input');
        //     label.for = 'ctn_img' + String(my_index);
        //     label.innerText = "찾기";
        //
        //     const inputFile = document.createElement('input');
        //     inputFile.style.display = 'none';
        //     inputFile.setAttribute('type', 'file');
        //     inputFile.setAttribute('name', 'ctn_img');
        //     inputFile.setAttribute('id', 'ctn_img' + String(my_index));
        //     inputFile.setAttribute('accept', 'image/png, image/jpeg, image/gif');
        //     inputFile.addEventListener('change', function () {ctn_loadFile(this)});
        //
        //     label.append(inputFile)
        //     div.append(label);
        //     newCell3.append(feDiv, div);
        //
        //     newCell4.classList.add("bottom_td");
        //     const remove_btn = document.createElement('button')
        //     remove_btn.innerText = "삭제"
        //     remove_btn.classList.add("remove_btn");
        //     remove_btn.id = 'remove_btn' + String(my_index);
        //     remove_btn.setAttribute('type', 'button');
        //     remove_btn.addEventListener('click', function () {removeRow(this)});
        //     newCell4.append(remove_btn)
        // }
        //
        //
        //  function changeMenu(e) {
        //     const cardDiv = document.getElementById('cardDiv');
        //     const urlDiv = document.getElementById('urlDiv');
        //     if (e.id === "tplCd1") {
        //         cardDiv.style.display = 'none';
        //         urlDiv.style.display = '';
        //     } else {
        //         cardDiv.style.display = '';
        //         urlDiv.style.display = 'none';
        //     }
        //  }
        //
        //  function checkSave() {
        //     const contentName = document.getElementById("ctnNm");
        //     const reprImgLength = document.getElementsByClassName("reprImg").length;
        //     const ctnDetImgLength = document.getElementsByClassName("ctnDetImg").length;
        //     const inputUrl = document.getElementsByName("inputUrl")[0];
        //     const targetOption = document.getElementById("srcCd");
        //
        //     if (contentName.value === "") {
        //         alert("콘텐츠명을 작성해주세요.");
        //         return false;
        //     }
        //
        //
        //     if (targetOption.options[targetOption.selectedIndex].text === "전체") {
        //         alert("콘텐츠 출처가 선택되지 않았습니다.");
        //         return false;
        //     }
        //
        //     if (reprImgLength === 0) {
        //         alert("대표 이미지가 등록 되어있지 않습니다.");
        //         return false;
        //     }
        //
        //     if (document.getElementById('tplCd0').checked === true && document.getElementById('tr1') === null) {
        //         alert("콘텐츠 본문내용이 존재하지 않습니다.");
        //         return false;
        //     }
        //
        //      if (document.getElementById('tplCd0').checked === true && ctnDetImgLength === 0) {
        //          alert("콘텐츠 본문내용의 이미지가 등록 되어있지 않습니다.");
        //          return false;
        //      }
        //
        //
        //      if (document.getElementById('tplCd1').checked === true && inputUrl.value === ''){
        //          alert("콘텐츠 본문내용이 존재하지 않습니다.");
        //          return false;
        //      }
        //
        //
        //      if (document.getElementById('tplCd1').checked === true && inputUrl.value !== '') {
        //          if (inputUrl.value.substring(0, 7) !== 'http://' && inputUrl.value.substring(0, 8) !== 'https://') {
        //              alert("URL 주소 형식은 http:// 또는 https://로 시작되야합니다");
        //              return false;
        //          }
        //      }
        //
        //      if (!confirm("저장하시겠습니까?")) {
        //          return false;
        //      }
        //  }
        //
        //
        //  function checkCancel() {
        //     if (!confirm("등록을 취소하시겠습니까?")) {
        //         return false;
        //     } else {
        //         location.href = '/';
        //     }
        //  }

        function createOX(){
             var quizList = document.getElementById("quizList");
             var tmpQuiz = document.getElementById("tmpQuiz");
            if (document.getElementsByName("quizRow").length>=10){
                return;
            }

             var quizRow = document.createElement("tr");

             quizRow.setAttribute("id",String(quizCnt++));
             quizRow.setAttribute("name","quizRow");
             var quizContents = document.createElement("td");

             var udButton = document.createElement("div");
             var up = document.createElement("button");
             up.setAttribute("type", "button");
             up.setAttribute("class", "btn btn-outline-secondary");
             up.setAttribute("style", "background-color: #ecedee; color: black; font-size: 15px; margin-left: 6px");
             up.setAttribute("onclick","up(this)");
             up.innerHTML="▲";
             var down = document.createElement("button");
             down.setAttribute("type", "button");
             down.setAttribute("class", "btn btn-outline-secondary");
             down.setAttribute("style", "background-color: #ecedee; color: black; font-size: 15px; margin-right: 6px");
             down.setAttribute("onclick","down(this)");
             down.innerHTML="▼";
             udButton.appendChild(up);
             udButton.appendChild(down);
             udButton.setAttribute("style", "float: left");
             udButton.setAttribute("name", "updown");

             var delDiv = document.createElement("div");
             delDiv.setAttribute("style", "float: right");
             var del = document.createElement("button");
             del.setAttribute("type", "button");
             del.setAttribute("class", "btn btn-outline-secondary");
             del.setAttribute("style", "margin-bottom: 6px; background-color: #ecedee; color: black; font-size: 15px");
             del.setAttribute("onclick","delRow(this)");
             del.innerHTML="삭제";
             delDiv.appendChild(del);


             var oxUpperTable = document.createElement("table");
             oxUpperTable.setAttribute("class", "table table-sm search-table");
             var style = document.createElement("style");
             style.innerText = "input{margin-left:6px; margin-right:6px;}"
             oxUpperTable.appendChild(style);
             var tbody = document.createElement("tbody");
             var tr = document.createElement("tr");
             var th = document.createElement("th");
             th.setAttribute("style","height: 50px; width:100px");
             th.innerText = "퀴즈유형";
             var td = document.createElement("td");
             td.setAttribute("style","width: 500px")
             var select = document.createElement("select");
             select.setAttribute("name", "searchType_" + String(quizCnt - 1));
             select.setAttribute("class", "form-select w130");
             select.setAttribute("onchange", "changeType(this)");
             select.setAttribute("style", "marin-left:6px; margin-right:3px; display: inline-block;");

             quizTypes.forEach(function(element){
                 if(element.quizNm=="OX형"){
                     var option = document.createElement("option");
                     option.setAttribute("value", element.quizCd);
                     option.innerText = element.quizNm;
                     select.appendChild(option);
                 }
                 else{
                     return false;
                 }
             });

            quizTypes.forEach(function(element){
                if(element.quizNm!="OX형"){
                    var option = document.createElement("option");
                    option.setAttribute("value", element.quizCd);
                    option.innerText = element.quizNm;
                    select.appendChild(option);
                }
            });
             td.appendChild(select);
             tr.appendChild(th);
             tr.appendChild(td);

             th = document.createElement("th");
             th.innerText = "퀴즈질문";
             td = document.createElement("td");
             var input = document.createElement("input");
             input.setAttribute("type", "text");
             input.setAttribute("name", "quizQuestion_"+String(quizCnt - 1));
             input.setAttribute("size", "50");
             input.setAttribute("onchange", "checkText(this)");
             input.setAttribute("maxlength", "40");
             td.appendChild(input);
             tr.appendChild(th);
             tr.appendChild(td);
             tbody.appendChild(tr);

             tr = document.createElement("tr");
             th = document.createElement("th");
             th.innerText = "질문이미지";
             td = document.createElement("td");
             td.setAttribute("colspan", "3");
             var div = document.createElement("div");
             var img = document.createElement("img");
             img.setAttribute("style", "margin:6px");
             img.setAttribute("src", "data:image/png;base64,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");
             img.setAttribute("id","preview_"+String(quizCnt-1))
             var label = document.createElement("label");
             label.setAttribute("for", "image_"+String(quizCnt-1));
             label.setAttribute("class", "btn btn-dark");
             label.innerText = "찾기";
             var input = document.createElement("input");
             input.setAttribute("type", "file");
             input.setAttribute("name", "quizMainImage");
             input.setAttribute("id", "image_" + String(quizCnt - 1));
             input.setAttribute("class", "btn btn-outline-dark");
             input.setAttribute("style", "margin-right: 100px; display: none");
             input.setAttribute("accept", ".png, .jpg");
             input.setAttribute("onchange","readImage(this)");
             div.appendChild(img);
             div.appendChild(label);
             div.appendChild(input);
             td.appendChild(div);
             div = document.createElement("div");
             div.setAttribute("style","margin-left: 12px; color:#dc3545");
             div.innerText="가로: 670px, 세로: 380px";
             td.appendChild(div);
             tr.appendChild(th);
             tr.appendChild(td);
             tbody.appendChild(tr);

             tr = document.createElement("tr");
             th = document.createElement("th");
             th.innerText = "정답 사용 여부 및 지급 클로버";
             td = document.createElement("td");
             td.setAttribute("colspan", "3");
             input = document.createElement("input");
             input.setAttribute("class", "form-check-input");
             input.setAttribute("onclick","oxAnswerYnConfig(this)");
             input.setAttribute("type", "radio");
             input.setAttribute("name", "ansYn_"+String(quizCnt-1));
             input.setAttribute("id", "ansY_"+String(quizCnt-1));
             input.setAttribute("value", "Y");
             label = document.createElement("label");
             label.setAttribute("class", "form-check-label");
             label.setAttribute("for", "ansY_" + String(quizCnt - 1));
             var span_1 = document.createElement("span");
             span_1.innerText="사용 (정답 : ";
             var span_2 = document.createElement("span");
             var ansInput = document.createElement("input");
             ansInput.setAttribute("type", "text");
             ansInput.setAttribute("size", "12");
             ansInput.setAttribute("maxlength", "15");
             ansInput.setAttribute("onchange", "checkInt(this)");
             ansInput.setAttribute("name", "ansClov_"+String(quizCnt - 1));
             ansInput.setAttribute("disabled", "disabled");
             ansInput.setAttribute("id", "ansY_corY_clov_" + String(quizCnt - 1));
             span_2.appendChild(ansInput);
             var span_3 = document.createElement("span");
             span_3.innerText="C,   오답 : ";
             var wrngInput = document.createElement("input");
             wrngInput.setAttribute("type", "text");
             wrngInput.setAttribute("size", "12");
             wrngInput.setAttribute("maxlength", "15");
             wrngInput.setAttribute("onchange", "checkInt(this)");
             wrngInput.setAttribute("name", "wngClov_"+String(quizCnt - 1));
             wrngInput.setAttribute("disabled", "disabled");
             wrngInput.setAttribute("id", "ansY_corN_clov_" + String(quizCnt - 1));
             var span_4 = document.createElement("span");
             span_4.appendChild(wrngInput);
             var span_5 = document.createElement("span");
             span_5.innerText = "C)";
             label.appendChild(span_1);
             label.appendChild(span_2);
             label.appendChild(span_3);
             label.appendChild(span_4);
             label.appendChild(span_5);

             td.appendChild(input);
             td.appendChild(label);

             input = document.createElement("input");
             input.setAttribute("class", "form-check-input");
             input.setAttribute("type", "radio");
             input.setAttribute("onclick","oxAnswerYnConfig(this)");
             input.setAttribute("name", "ansYn_"+String(quizCnt-1));
             input.setAttribute("id", "ansN_"+String(quizCnt-1));
             input.setAttribute("value", "N");
             input.setAttribute("checked", "checked");
             input.setAttribute("style", "margin-left: 30px");

             label = document.createElement("label");
             label.setAttribute("class", "form-check-label");
             label.setAttribute("for", "ansN_" + String(quizCnt - 1));
             span_1 = document.createElement("span");
             span_1.innerText="미사용 (";
             span_2 = document.createElement("span");
             ansInput = document.createElement("input");
             ansInput.setAttribute("type", "text");
             ansInput.setAttribute("size", "12");
             ansInput.setAttribute("maxlength", "15");
             ansInput.setAttribute("name", "ansN_clov_"+String(quizCnt - 1));
             ansInput.setAttribute("id", "ansN_clov_"+(String(quizCnt-1)));
             span_2.appendChild(ansInput);
             span_3 = document.createElement("span");
             span_3.innerText = "C)";
             label.appendChild(span_1);
             label.appendChild(span_2);
             label.appendChild(span_3);

             td.appendChild(input);
             td.appendChild(label);

             tr.appendChild(th);
             tr.appendChild(td);
             tbody.appendChild(tr);




             tr = document.createElement("tr");
             th = document.createElement("th");
             th.innerText = "해설 사용 여부";
             td = document.createElement("td");
             td.setAttribute("colspan", "3");
             td.setAttribute("id", "comTd_"+String(quizCnt-1));
             input = document.createElement("input");
             input.setAttribute("class", "form-check-input");
             input.setAttribute("onclick","commentYnConfig(this)");
             input.setAttribute("type", "radio");
             input.setAttribute("name", "comYn_"+String(quizCnt-1));
             input.setAttribute("id", "comY_"+String(quizCnt-1));
             input.setAttribute("value", "Y");
             input.setAttribute("disabled", "disabled");
             td.appendChild(input);
             label = document.createElement("label");
             label.setAttribute("class", "form-check-label");
             label.setAttribute("for", "comY_" + String(quizCnt - 1));
             label.innerText="사용"
             td.appendChild(label);

             input = document.createElement("input");
             input.setAttribute("class", "form-check-input");
             input.setAttribute("onclick","commentYnConfig(this)");
             input.setAttribute("type", "radio");
             input.setAttribute("name", "comYn_"+String(quizCnt-1));
             input.setAttribute("id", "comN_"+String(quizCnt-1));
             input.setAttribute("value", "N");
             input.setAttribute("disabled", "disabled");
             td.appendChild(input);
             label = document.createElement("label");
             label.setAttribute("class", "form-check-label");
             label.setAttribute("for", "comN_" + String(quizCnt - 1));
             label.innerText="미사용"
             td.appendChild(label);

             input = document.createElement("input");
             input.setAttribute("type", "text");
             input.setAttribute("onchange", "checkText(this)");
             input.setAttribute("size", "100");
             input.setAttribute("name", "comment_"+String(quizCnt - 1));
             input.setAttribute("disabled", "disabled");
             input.setAttribute("id", "comment_"+(String(quizCnt-1)));
             td.appendChild(input);

             tr.appendChild(th);
             tr.appendChild(td);
             tbody.appendChild(tr);

             oxUpperTable.appendChild(tbody);

             var rowHeadLine = document.createElement("div");
             rowHeadLine.appendChild(udButton);
             rowHeadLine.appendChild(delDiv);

             quizContents.appendChild(rowHeadLine);
             quizContents.appendChild(oxUpperTable);

             var oxLowerTable = document.createElement("table");
             oxLowerTable.setAttribute("class", "table table-sm search-table");
             var style = document.createElement("style");
             style.innerText = "input{margin-left:6px; margin-right:6px;}"
             oxLowerTable.appendChild(style);
             var tbody = document.createElement("tbody");
             var tr = document.createElement("tr");
             var th = document.createElement("th");
             th.setAttribute("style","height: 50px; width:50%; text-align: center");
             th.innerText = "선택지";
             tr.appendChild(th);
             th = document.createElement("th");
             th.setAttribute("style","height: 50px; width:50%; text-align: center");
             th.innerText = "정답";
             tr.appendChild(th);
             tbody.appendChild(tr);

             tr = document.createElement("tr");
             tr.setAttribute("style","text-align: center");
             td = document.createElement("td");
             td.innerText = "O";
             tr.appendChild(td);
             td = document.createElement("td");
             td.setAttribute("style","background-color: #ecedee");
             input = document.createElement("input");
             input.setAttribute("class", "form-check-input");
             input.setAttribute("type", "radio");
             input.setAttribute("name", "corOX_"+String(quizCnt-1));
             input.setAttribute("id", "corO_"+String(quizCnt-1));
             input.setAttribute("value", "0");
             input.setAttribute("disabled", "disabled");
             td.appendChild(input);
             tr.appendChild(td);
             tbody.appendChild(tr);

             tr = document.createElement("tr");
             tr.setAttribute("style","text-align: center");
             td = document.createElement("td");
             td.innerText = "X";
             tr.appendChild(td);
             td = document.createElement("td");
             td.setAttribute("style","background-color: #ecedee");
             input = document.createElement("input");
             input.setAttribute("class", "form-check-input");
             input.setAttribute("type", "radio");
             input.setAttribute("name", "corOX_"+String(quizCnt-1));
             input.setAttribute("id", "corX_"+String(quizCnt-1));
             input.setAttribute("value", "1");
             input.setAttribute("disabled", "disabled");
             td.appendChild(input);
             tr.appendChild(td);
             tbody.appendChild(tr);




             oxLowerTable.appendChild(tbody);
             quizContents.appendChild(oxLowerTable);

             quizRow.appendChild(quizContents);
             if (tmpQuiz!=null){
                 quizList.replaceChild(quizRow, tmpQuiz);
             }
             else{
                 quizList.appendChild(quizRow);
             }
             checkTD();
         }

        function createAB(){
            var quizList = document.getElementById("quizList");
            var tmpQuiz = document.getElementById("tmpQuiz");
            if (document.getElementsByName("quizRow").length>=10){
                return;
            }
            var quizRow = document.createElement("tr");
            quizRow.setAttribute("id",String(quizCnt++));
            quizRow.setAttribute("name","quizRow");
            var quizContents = document.createElement("td");

            var udButton = document.createElement("div");
            var up = document.createElement("button");
            up.setAttribute("type", "button");
            up.setAttribute("class", "btn btn-outline-secondary");
            up.setAttribute("style", "background-color: #ecedee; color: black; font-size: 15px; margin-left: 6px");
            up.setAttribute("onclick","up(this)");
            up.innerHTML="▲";
            var down = document.createElement("button");
            down.setAttribute("type", "button");
            down.setAttribute("class", "btn btn-outline-secondary");
            down.setAttribute("style", "background-color: #ecedee; color: black; font-size: 15px; margin-right: 6px");
            down.setAttribute("onclick","down(this)");
            down.innerHTML="▼";
            udButton.appendChild(up);
            udButton.appendChild(down);
            udButton.setAttribute("style", "float: left");
            udButton.setAttribute("name", "updown");

            var delDiv = document.createElement("div");
            delDiv.setAttribute("style", "float: right");
            var del = document.createElement("button");
            del.setAttribute("type", "button");
            del.setAttribute("class", "btn btn-outline-secondary");
            del.setAttribute("style", "margin-bottom: 6px; background-color: #ecedee; color: black; font-size: 15px");
            del.setAttribute("onclick","delRow(this)");
            del.innerHTML="삭제";
            delDiv.appendChild(del);


            var abUpperTable = document.createElement("table");
            abUpperTable.setAttribute("class", "table table-sm search-table");
            var style = document.createElement("style");
            style.innerText = "input{margin-left:6px; margin-right:6px;}"
            abUpperTable.appendChild(style);
            var tbody = document.createElement("tbody");
            var tr = document.createElement("tr");
            var th = document.createElement("th");
            th.setAttribute("style","height: 50px; width:100px");
            th.innerText = "퀴즈유형";
            var td = document.createElement("td");
            td.setAttribute("style","width: 500px")
            var select = document.createElement("select");
            select.setAttribute("name", "searchType_"+String(quizCnt - 1));
            select.setAttribute("class", "form-select w130");
            select.setAttribute("onchange", "changeType(this)");
            select.setAttribute("style", "marin-left:6px; margin-right:3px; display: inline-block;");
            quizTypes.forEach(function(element){
                if(element.quizNm=="AB형"){
                    var option = document.createElement("option");
                    option.setAttribute("value", element.quizCd);
                    option.innerText = element.quizNm;
                    select.appendChild(option);
                }
                else{
                    return false;
                }
            });

            quizTypes.forEach(function(element){
                if(element.quizNm!="AB형"){
                    var option = document.createElement("option");
                    option.setAttribute("value", element.quizCd);
                    option.innerText = element.quizNm;
                    select.appendChild(option);
                }
            });
            td.appendChild(select);
            tr.appendChild(th);
            tr.appendChild(td);
            th = document.createElement("th");
            th.innerText = "퀴즈질문";
            td = document.createElement("td");
            var input = document.createElement("input");
            input.setAttribute("type", "text");
            input.setAttribute("size", "50");
            input.setAttribute("onchange", "checkText(this)");
            input.setAttribute("name", "quizQuestion_"+String(quizCnt - 1));
            input.setAttribute("maxlength", "40");
            td.appendChild(input);
            tr.appendChild(th);
            tr.appendChild(td);
            tbody.appendChild(tr);

            tr = document.createElement("tr");
            th = document.createElement("th");
            th.innerText = "질문이미지";
            td = document.createElement("td");
            td.setAttribute("colspan", "3");
            var div = document.createElement("div");
            var img = document.createElement("img");
            img.setAttribute("style", "margin:6px");
            img.setAttribute("src", "data:image/png;base64,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");
            img.setAttribute("id","preview_"+String(quizCnt-1))
            var label = document.createElement("label");
            label.setAttribute("for", "image_"+String(quizCnt-1));
            label.setAttribute("class", "btn btn-dark");
            label.innerText = "찾기";
            var input = document.createElement("input");
            input.setAttribute("type", "file");
            input.setAttribute("name", "quizMainImage");
            input.setAttribute("id", "image_" + String(quizCnt - 1));
            input.setAttribute("class", "btn btn-outline-dark");
            input.setAttribute("style", "margin-right: 100px; display: none");
            input.setAttribute("accept", ".png, .jpg");
            input.setAttribute("onchange","readImage(this)");
            div.appendChild(img);
            div.appendChild(label);
            div.appendChild(input);
            td.appendChild(div);
            div = document.createElement("div");
            div.setAttribute("style","margin-left: 12px; color:#dc3545");
            div.innerText="가로: 670px, 세로: 380px";
            td.appendChild(div);
            tr.appendChild(th);
            tr.appendChild(td);
            tbody.appendChild(tr);

            tr = document.createElement("tr");
            th = document.createElement("th");
            th.innerText = "정답 사용 여부 및 지급 클로버";
            td = document.createElement("td");
            td.setAttribute("colspan", "3");
            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("onclick","abAnswerYnConfig(this)");
            input.setAttribute("type", "radio");
            input.setAttribute("name", "ansYn_"+String(quizCnt-1));
            input.setAttribute("id", "ansY_"+String(quizCnt-1));
            input.setAttribute("value", "Y");
            label = document.createElement("label");
            label.setAttribute("class", "form-check-label");
            label.setAttribute("for", "ansY_" + String(quizCnt - 1));
            var span_1 = document.createElement("span");
            span_1.innerText="사용 (정답 : ";
            var span_2 = document.createElement("span");
            var ansInput = document.createElement("input");
            ansInput.setAttribute("type", "text");
            ansInput.setAttribute("size", "12");
            ansInput.setAttribute("maxlength", "15");
            ansInput.setAttribute("onchange", "checkInt(this)");
            ansInput.setAttribute("name", "ansClov_"+String(quizCnt - 1));
            ansInput.setAttribute("disabled", "disabled");
            ansInput.setAttribute("id", "ansY_corY_clov_" + String(quizCnt - 1));
            span_2.appendChild(ansInput);
            var span_3 = document.createElement("span");
            span_3.innerText="C,   오답 : ";
            var wrngInput = document.createElement("input");
            wrngInput.setAttribute("type", "text");
            wrngInput.setAttribute("size", "12");
            wrngInput.setAttribute("maxlength", "15");
            wrngInput.setAttribute("onchange", "checkInt(this)");
            wrngInput.setAttribute("name", "wngClov_"+String(quizCnt - 1));
            wrngInput.setAttribute("disabled", "disabled");
            wrngInput.setAttribute("id", "ansY_corN_clov_" + String(quizCnt - 1));
            var span_4 = document.createElement("span");
            span_4.appendChild(wrngInput);
            var span_5 = document.createElement("span");
            span_5.innerText = "C)";
            label.appendChild(span_1);
            label.appendChild(span_2);
            label.appendChild(span_3);
            label.appendChild(span_4);
            label.appendChild(span_5);

            td.appendChild(input);
            td.appendChild(label);

            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("type", "radio");
            input.setAttribute("onclick","abAnswerYnConfig(this)");
            input.setAttribute("name", "ansYn_"+String(quizCnt-1));
            input.setAttribute("id", "ansN_"+String(quizCnt-1));
            input.setAttribute("value", "N");
            input.setAttribute("checked", "checked");
            input.setAttribute("style", "margin-left: 30px");

            label = document.createElement("label");
            label.setAttribute("class", "form-check-label");
            label.setAttribute("for", "ansN_" + String(quizCnt - 1));
            span_1 = document.createElement("span");
            span_1.innerText="미사용 (";
            span_2 = document.createElement("span");
            ansInput = document.createElement("input");
            ansInput.setAttribute("type", "text");
            ansInput.setAttribute("size", "12");
            ansInput.setAttribute("maxlength", "15");
            ansInput.setAttribute("onchange", "checkInt(this)");
            ansInput.setAttribute("name", "ansN_clov_"+String(quizCnt - 1));
            ansInput.setAttribute("id", "ansN_clov_"+(String(quizCnt-1)));
            span_2.appendChild(ansInput);
            span_3 = document.createElement("span");
            span_3.innerText = "C)";
            label.appendChild(span_1);
            label.appendChild(span_2);
            label.appendChild(span_3);

            td.appendChild(input);
            td.appendChild(label);

            tr.appendChild(th);
            tr.appendChild(td);
            tbody.appendChild(tr);

            tr = document.createElement("tr");
            th = document.createElement("th");
            th.innerText = "선택지 이미지 사용 여부";
            td = document.createElement("td");
            td.setAttribute("colspan", "3");
            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("type", "radio");
            input.setAttribute("name", "imgYn_"+String(quizCnt-1));
            input.setAttribute("id", "imgY_"+String(quizCnt-1));
            input.setAttribute("value", "Y");
            input.setAttribute("onclick", "imageYnConfig(this)");
            td.appendChild(input);
            label = document.createElement("label");
            label.setAttribute("class", "form-check-label");
            label.setAttribute("for", "imgY_" + String(quizCnt - 1));
            label.innerText="사용"
            td.appendChild(label);

            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("type", "radio");
            input.setAttribute("name", "imgYn_"+String(quizCnt-1));
            input.setAttribute("id", "imgN_"+String(quizCnt-1));
            input.setAttribute("value", "N");
            input.setAttribute("onclick", "imageYnConfig(this)");
            input.setAttribute("checked", "checked");
            td.appendChild(input);
            label = document.createElement("label");
            label.setAttribute("class", "form-check-label");
            label.setAttribute("for", "imgN_" + String(quizCnt - 1));
            label.innerText="미사용"
            td.appendChild(label);

            tr.appendChild(th);
            tr.appendChild(td);
            tbody.appendChild(tr);


            tr = document.createElement("tr");
            th = document.createElement("th");
            th.innerText = "해설 사용 여부";
            td = document.createElement("td");
            td.setAttribute("colspan", "3");
            td.setAttribute("style","background-color: #ecedee");
            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("onclick","commentYnConfig(this)");
            input.setAttribute("type", "radio");
            input.setAttribute("name", "comYn_"+String(quizCnt-1));
            input.setAttribute("id", "comY_"+String(quizCnt-1));
            input.setAttribute("value", "Y");
            input.setAttribute("disabled", "disabled");
            td.appendChild(input);
            label = document.createElement("label");
            label.setAttribute("class", "form-check-label");
            label.setAttribute("for", "comY_" + String(quizCnt - 1));
            label.innerText="사용"
            td.appendChild(label);

            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("onclick","commentYnConfig(this)");
            input.setAttribute("type", "radio");
            input.setAttribute("name", "comYn_"+String(quizCnt-1));
            input.setAttribute("id", "comN_"+String(quizCnt-1));
            input.setAttribute("value", "N");
            input.setAttribute("disabled", "disabled");
            td.appendChild(input);
            label = document.createElement("label");
            label.setAttribute("class", "form-check-label");
            label.setAttribute("for", "comN_" + String(quizCnt - 1));
            label.innerText="미사용"
            td.appendChild(label);

            input = document.createElement("input");
            input.setAttribute("type", "text");
            input.setAttribute("size", "100");
            input.setAttribute("onchange", "checkText(this)");
            input.setAttribute("name", "comment_"+(String(quizCnt-1)));
            input.setAttribute("disabled", "disabled");
            input.setAttribute("id", "comment_"+(String(quizCnt-1)));
            td.appendChild(input);

            tr.appendChild(th);
            tr.appendChild(td);
            tbody.appendChild(tr);

            abUpperTable.appendChild(tbody);

            var rowHeadLine = document.createElement("div");
            rowHeadLine.appendChild(udButton);
            rowHeadLine.appendChild(delDiv);

            quizContents.appendChild(rowHeadLine);
            quizContents.appendChild(abUpperTable);

            var abLowerTable = document.createElement("table");
            abLowerTable.setAttribute("class", "table table-sm search-table");
            var style = document.createElement("style");
            style.innerText = "input{margin-left:6px; margin-right:6px;}"
            abLowerTable.appendChild(style);
            var tbody = document.createElement("tbody");
            var tr = document.createElement("tr");
            var th = document.createElement("th");
            th.setAttribute("style","height: 50px; width:50%; text-align: center");
            th.innerText = "선택지";
            tr.appendChild(th);
            th = document.createElement("th");
            th.setAttribute("style","height: 50px; width:25%; text-align: center");
            div = document.createElement("div");
            div.innerText = "이미지";
            th.appendChild(div);
            div = document.createElement("div");
            div.setAttribute("style", "margin-left: 12px; color:#dc3545; font-weight: normal");
            div.innerText = "가로: 324px, 세로: 324px";
            th.appendChild(div);

            tr.appendChild(th);
            th = document.createElement("th");
            th.setAttribute("style","height: 50px; width:25%; text-align: center");
            th.innerText = "정답";
            tr.appendChild(th);
            tbody.appendChild(tr);

            tr = document.createElement("tr");
            tr.setAttribute("style","text-align: center");

            td = document.createElement("td");
            input = document.createElement("input");
            input.setAttribute("type", "text");
            input.setAttribute("onchange", "checkText(this)");
            input.setAttribute("name", "A_"+String(quizCnt-1));
            input.setAttribute("size", "80");
            input.setAttribute("maxlength", "80");
            td.appendChild(input);
            tr.appendChild(td);

            td = document.createElement("td");
            td.setAttribute("style","background-color: #ecedee");
            var div = document.createElement("div");
            var img = document.createElement("img");
            img.setAttribute("style", "margin:6px");
            img.setAttribute("src", "data:image/png;base64,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");
            img.setAttribute("id","preview_A_"+String(quizCnt-1))
            var label = document.createElement("label");
            // label.setAttribute("for", "image_A_"+String(quizCnt-1));
            label.setAttribute("class", "btn btn-dark");
            label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
            label.innerText = "찾기";
            var input = document.createElement("input");
            input.setAttribute("type", "file");
            input.setAttribute("name", "quizABImage");
            input.setAttribute("id", "image_A_" + String(quizCnt - 1));
            input.setAttribute("class", "btn btn-outline-dark");
            input.setAttribute("style", "margin-right: 100px; display: none");
            input.setAttribute("accept", ".png, .jpg");
            input.setAttribute("onchange","readImageAB(this)");
            div.appendChild(img);
            div.appendChild(label);
            div.appendChild(input);
            td.appendChild(div);
            tr.appendChild(td);

            td = document.createElement("td");
            td.setAttribute("style","background-color: #ecedee");
            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("type", "radio");
            input.setAttribute("name", "corAB_"+String(quizCnt-1));
            input.setAttribute("id", "corA_"+String(quizCnt-1));
            input.setAttribute("value", "0");
            input.setAttribute("disabled", "disabled");
            td.appendChild(input);
            tr.appendChild(td);
            tbody.appendChild(tr);

            tr = document.createElement("tr");
            tr.setAttribute("style","text-align: center");

            td = document.createElement("td");
            input = document.createElement("input");
            input.setAttribute("type", "text");
            input.setAttribute("size", "80");
            input.setAttribute("onchange", "checkText(this)");
            input.setAttribute("name", "B_"+String(quizCnt-1));
            input.setAttribute("maxlength", "80");
            td.appendChild(input);
            tr.appendChild(td);

            td = document.createElement("td");
            td.setAttribute("style","background-color: #ecedee");
            var div = document.createElement("div");
            var img = document.createElement("img");
            img.setAttribute("style", "margin:6px");
            img.setAttribute("src", "data:image/png;base64,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");
            img.setAttribute("id","preview_B_"+String(quizCnt-1))
            var label = document.createElement("label");
            // label.setAttribute("for", "image_B_"+String(quizCnt-1));
            label.setAttribute("class", "btn btn-dark");
            label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
            label.innerText = "찾기";
            var input = document.createElement("input");
            input.setAttribute("type", "file");
            input.setAttribute("name", "quizABImage");
            input.setAttribute("id", "image_B_" + String(quizCnt - 1));
            input.setAttribute("class", "btn btn-outline-dark");
            input.setAttribute("style", "margin-right: 100px; display: none");
            input.setAttribute("accept", ".png, .jpg");
            input.setAttribute("onchange","readImageAB(this)");
            div.appendChild(img);
            div.appendChild(label);
            div.appendChild(input);
            td.appendChild(div);
            tr.appendChild(td);

            td = document.createElement("td");
            td.setAttribute("style","background-color: #ecedee");
            input = document.createElement("input");
            input.setAttribute("class", "form-check-input");
            input.setAttribute("type", "radio");
            input.setAttribute("name", "corAB_"+String(quizCnt-1));
            input.setAttribute("id", "corB_"+String(quizCnt-1));
            input.setAttribute("value", "1");
            input.setAttribute("disabled", "disabled");
            td.appendChild(input);
            tr.appendChild(td);
            tbody.appendChild(tr);

            abLowerTable.appendChild(tbody);
            quizContents.appendChild(abLowerTable);
            quizRow.appendChild(quizContents);
            if (tmpQuiz!=null){
                quizList.replaceChild(quizRow, tmpQuiz);
            }
            else{
                quizList.appendChild(quizRow);
            }

            checkTD();
        }

        function changeType(input){
            var type = input.value;
            var upperTable = input.parentNode.parentNode.parentNode.parentNode;
            var lowerTable = upperTable.nextSibling;
            var quizRow = upperTable.parentNode;
            // OX형
            if(type == "Q0001"){
                var oxUpperTable = document.createElement("table");
                oxUpperTable.setAttribute("class", "table table-sm search-table");
                var style = document.createElement("style");
                style.innerText = "input{margin-left:6px; margin-right:6px;}"
                oxUpperTable.appendChild(style);
                var tbody = document.createElement("tbody");
                var tr = document.createElement("tr");
                var th = document.createElement("th");
                th.setAttribute("style","height: 50px; width:100px");
                th.innerText = "퀴즈유형";
                var td = document.createElement("td");
                td.setAttribute("style","width: 500px")
                var select = document.createElement("select");
                select.setAttribute("name", "searchType_" + String(quizCnt - 1));
                select.setAttribute("class", "form-select w130");
                select.setAttribute("onchange", "changeType(this)");
                select.setAttribute("style", "marin-left:6px; margin-right:3px; display: inline-block;");

                quizTypes.forEach(function(element){
                    if(element.quizNm=="OX형"){
                        var option = document.createElement("option");
                        option.setAttribute("value", element.quizCd);
                        option.innerText = element.quizNm;
                        select.appendChild(option);
                    }
                    else{
                        return false;
                    }
                });

                quizTypes.forEach(function(element){
                    if(element.quizNm!="OX형"){
                        var option = document.createElement("option");
                        option.setAttribute("value", element.quizCd);
                        option.innerText = element.quizNm;
                        select.appendChild(option);
                    }
                });
                td.appendChild(select);
                tr.appendChild(th);
                tr.appendChild(td);

                th = document.createElement("th");
                th.innerText = "퀴즈질문";
                td = document.createElement("td");
                var input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("name", "quizQuestion_"+String(quizCnt - 1));
                input.setAttribute("size", "50");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("maxlength", "40");
                td.appendChild(input);
                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                th = document.createElement("th");
                th.innerText = "질문이미지";
                td = document.createElement("td");
                td.setAttribute("colspan", "3");
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id","preview_"+String(quizCnt-1))
                var label = document.createElement("label");
                label.setAttribute("for", "image_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizMainImage");
                input.setAttribute("id", "image_" + String(quizCnt - 1));
                input.setAttribute("class", "btn btn-outline-dark");
                input.setAttribute("style", "margin-right: 100px; display: none");
                input.setAttribute("accept", ".png, .jpg");
                input.setAttribute("onchange","readImage(this)");
                div.appendChild(img);
                div.appendChild(label);
                div.appendChild(input);
                td.appendChild(div);
                div = document.createElement("div");
                div.setAttribute("style","margin-left: 12px; color:#dc3545");
                div.innerText="가로: 670px, 세로: 380px";
                td.appendChild(div);
                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                th = document.createElement("th");
                th.innerText = "정답 사용 여부 및 지급 클로버";
                td = document.createElement("td");
                td.setAttribute("colspan", "3");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","oxAnswerYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "ansYn_"+String(quizCnt-1));
                input.setAttribute("id", "ansY_"+String(quizCnt-1));
                input.setAttribute("value", "Y");
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansY_" + String(quizCnt - 1));
                var span_1 = document.createElement("span");
                span_1.innerText="사용 (정답 : ";
                var span_2 = document.createElement("span");
                var ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("onchange", "checkInt(this)");
                ansInput.setAttribute("name", "ansClov_"+String(quizCnt - 1));
                ansInput.setAttribute("disabled", "disabled");
                ansInput.setAttribute("id", "ansY_corY_clov_" + String(quizCnt - 1));
                span_2.appendChild(ansInput);
                var span_3 = document.createElement("span");
                span_3.innerText="C,   오답 : ";
                var wrngInput = document.createElement("input");
                wrngInput.setAttribute("type", "text");
                wrngInput.setAttribute("size", "12");
                wrngInput.setAttribute("maxlength", "15");
                wrngInput.setAttribute("onchange", "checkInt(this)");
                wrngInput.setAttribute("name", "wngClov_"+String(quizCnt - 1));
                wrngInput.setAttribute("disabled", "disabled");
                wrngInput.setAttribute("id", "ansY_corN_clov_" + String(quizCnt - 1));
                var span_4 = document.createElement("span");
                span_4.appendChild(wrngInput);
                var span_5 = document.createElement("span");
                span_5.innerText = "C)";
                label.appendChild(span_1);
                label.appendChild(span_2);
                label.appendChild(span_3);
                label.appendChild(span_4);
                label.appendChild(span_5);

                td.appendChild(input);
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("onclick","oxAnswerYnConfig(this)");
                input.setAttribute("name", "ansYn_"+String(quizCnt-1));
                input.setAttribute("id", "ansN_"+String(quizCnt-1));
                input.setAttribute("value", "N");
                input.setAttribute("checked", "checked");
                input.setAttribute("style", "margin-left: 30px");

                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansN_" + String(quizCnt - 1));
                span_1 = document.createElement("span");
                span_1.innerText="미사용 (";
                span_2 = document.createElement("span");
                ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("name", "ansNclov_"+String(quizCnt - 1));
                ansInput.setAttribute("id", "ansN_clov_"+(String(quizCnt-1)));
                span_2.appendChild(ansInput);
                span_3 = document.createElement("span");
                span_3.innerText = "C)";
                label.appendChild(span_1);
                label.appendChild(span_2);
                label.appendChild(span_3);

                td.appendChild(input);
                td.appendChild(label);

                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);




                tr = document.createElement("tr");
                th = document.createElement("th");
                th.innerText = "해설 사용 여부";
                td = document.createElement("td");
                td.setAttribute("colspan", "3");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+String(quizCnt-1));
                input.setAttribute("id", "comY_"+String(quizCnt-1));
                input.setAttribute("value", "Y");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comY_" + String(quizCnt - 1));
                label.innerText="사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+String(quizCnt-1));
                input.setAttribute("id", "comN_"+String(quizCnt-1));
                input.setAttribute("value", "N");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comN_" + String(quizCnt - 1));
                label.innerText="미사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("size", "100");
                input.setAttribute("name", "comment_"+String(quizCnt - 1));
                input.setAttribute("disabled", "disabled");
                input.setAttribute("id", "comment_"+(String(quizCnt-1)));
                td.appendChild(input);

                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                oxUpperTable.appendChild(tbody);

                var oxLowerTable = document.createElement("table");
                oxLowerTable.setAttribute("class", "table table-sm search-table");
                var style = document.createElement("style");
                style.innerText = "input{margin-left:6px; margin-right:6px;}"
                oxLowerTable.appendChild(style);
                var tbody = document.createElement("tbody");
                var tr = document.createElement("tr");
                var th = document.createElement("th");
                th.setAttribute("style","height: 50px; width:50%; text-align: center");
                th.innerText = "선택지";
                tr.appendChild(th);
                th = document.createElement("th");
                th.setAttribute("style","height: 50px; width:50%; text-align: center");
                th.innerText = "정답";
                tr.appendChild(th);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                tr.setAttribute("style","text-align: center");
                td = document.createElement("td");
                td.innerText = "O";
                tr.appendChild(td);
                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "corOX_"+String(quizCnt-1));
                input.setAttribute("id", "corO_"+String(quizCnt-1));
                input.setAttribute("value", "0");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                tr.appendChild(td);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                tr.setAttribute("style","text-align: center");
                td = document.createElement("td");
                td.innerText = "X";
                tr.appendChild(td);
                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "corOX_"+String(quizCnt-1));
                input.setAttribute("id", "corX_"+String(quizCnt-1));
                input.setAttribute("value", "1");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                tr.appendChild(td);
                tbody.appendChild(tr);

                oxLowerTable.appendChild(tbody);

                quizRow.replaceChild(oxUpperTable, upperTable);
                quizRow.replaceChild(oxLowerTable, lowerTable);
            }
            // AB형
            else{
                var abUpperTable = document.createElement("table");
                abUpperTable.setAttribute("class", "table table-sm search-table");
                var style = document.createElement("style");
                style.innerText = "input{margin-left:6px; margin-right:6px;}"
                abUpperTable.appendChild(style);
                var tbody = document.createElement("tbody");
                var tr = document.createElement("tr");
                var th = document.createElement("th");
                th.setAttribute("style","height: 50px; width:100px");
                th.innerText = "퀴즈유형";
                var td = document.createElement("td");
                td.setAttribute("style","width: 500px")
                var select = document.createElement("select");
                select.setAttribute("name", "searchType_"+String(quizCnt - 1));
                select.setAttribute("class", "form-select w130");
                select.setAttribute("onchange", "changeType(this)");
                select.setAttribute("style", "marin-left:6px; margin-right:3px; display: inline-block;");
                quizTypes.forEach(function(element){
                    if(element.quizNm=="AB형"){
                        var option = document.createElement("option");
                        option.setAttribute("value", element.quizCd);
                        option.innerText = element.quizNm;
                        select.appendChild(option);
                    }
                    else{
                        return false;
                    }
                });

                quizTypes.forEach(function(element){
                    if(element.quizNm!="AB형"){
                        var option = document.createElement("option");
                        option.setAttribute("value", element.quizCd);
                        option.innerText = element.quizNm;
                        select.appendChild(option);
                    }
                });
                td.appendChild(select);
                tr.appendChild(th);
                tr.appendChild(td);
                th = document.createElement("th");
                th.innerText = "퀴즈질문";
                td = document.createElement("td");
                var input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("size", "50");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("name", "quizQuestion_"+String(quizCnt - 1));
                input.setAttribute("maxlength", "40");
                td.appendChild(input);
                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                th = document.createElement("th");
                th.innerText = "질문이미지";
                td = document.createElement("td");
                td.setAttribute("colspan", "3");
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id","preview_"+String(quizCnt-1))
                var label = document.createElement("label");
                label.setAttribute("for", "image_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizMainImage");
                input.setAttribute("id", "image_" + String(quizCnt - 1));
                input.setAttribute("class", "btn btn-outline-dark");
                input.setAttribute("style", "margin-right: 100px; display: none");
                input.setAttribute("accept", ".png, .jpg");
                input.setAttribute("onchange","readImage(this)");
                div.appendChild(img);
                div.appendChild(label);
                div.appendChild(input);
                td.appendChild(div);
                div = document.createElement("div");
                div.setAttribute("style","margin-left: 12px; color:#dc3545");
                div.innerText="가로: 670px, 세로: 380px";
                td.appendChild(div);
                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                th = document.createElement("th");
                th.innerText = "정답 사용 여부 및 지급 클로버";
                td = document.createElement("td");
                td.setAttribute("colspan", "3");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","abAnswerYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "ansYn_"+String(quizCnt-1));
                input.setAttribute("id", "ansY_"+String(quizCnt-1));
                input.setAttribute("value", "Y");
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansY_" + String(quizCnt - 1));
                var span_1 = document.createElement("span");
                span_1.innerText="사용 (정답 : ";
                var span_2 = document.createElement("span");
                var ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("onchange", "checkInt(this)");
                ansInput.setAttribute("name", "ansClov_"+String(quizCnt - 1));
                ansInput.setAttribute("disabled", "disabled");
                ansInput.setAttribute("id", "ansY_corY_clov_" + String(quizCnt - 1));
                span_2.appendChild(ansInput);
                var span_3 = document.createElement("span");
                span_3.innerText="C,   오답 : ";
                var wrngInput = document.createElement("input");
                wrngInput.setAttribute("type", "text");
                wrngInput.setAttribute("size", "12");
                wrngInput.setAttribute("maxlength", "15");
                wrngInput.setAttribute("onchange", "checkInt(this)");
                wrngInput.setAttribute("name", "wngClov_"+String(quizCnt - 1));
                wrngInput.setAttribute("disabled", "disabled");
                wrngInput.setAttribute("id", "ansY_corN_clov_" + String(quizCnt - 1));
                var span_4 = document.createElement("span");
                span_4.appendChild(wrngInput);
                var span_5 = document.createElement("span");
                span_5.innerText = "C)";
                label.appendChild(span_1);
                label.appendChild(span_2);
                label.appendChild(span_3);
                label.appendChild(span_4);
                label.appendChild(span_5);

                td.appendChild(input);
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("onclick","abAnswerYnConfig(this)");
                input.setAttribute("name", "ansYn_"+String(quizCnt-1));
                input.setAttribute("id", "ansN_"+String(quizCnt-1));
                input.setAttribute("value", "N");
                input.setAttribute("checked", "checked");
                input.setAttribute("style", "margin-left: 30px");

                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansN_" + String(quizCnt - 1));
                span_1 = document.createElement("span");
                span_1.innerText="미사용 (";
                span_2 = document.createElement("span");
                ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("onchange", "checkInt(this)");
                ansInput.setAttribute("name", "ansNclov_"+String(quizCnt - 1));
                ansInput.setAttribute("id", "ansNclov_"+(String(quizCnt-1)));
                span_2.appendChild(ansInput);
                span_3 = document.createElement("span");
                span_3.innerText = "C)";
                label.appendChild(span_1);
                label.appendChild(span_2);
                label.appendChild(span_3);

                td.appendChild(input);
                td.appendChild(label);

                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                th = document.createElement("th");
                th.innerText = "선택지 이미지 사용 여부";
                td = document.createElement("td");
                td.setAttribute("colspan", "3");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "imgYn_"+String(quizCnt-1));
                input.setAttribute("id", "imgY_"+String(quizCnt-1));
                input.setAttribute("value", "Y");
                input.setAttribute("onclick", "imageYnConfig(this)");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "imgY_" + String(quizCnt - 1));
                label.innerText="사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "imgYn_"+String(quizCnt-1));
                input.setAttribute("id", "imgN_"+String(quizCnt-1));
                input.setAttribute("value", "N");
                input.setAttribute("onclick", "imageYnConfig(this)");
                input.setAttribute("checked", "checked");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "imgN_" + String(quizCnt - 1));
                label.innerText="미사용"
                td.appendChild(label);

                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);


                tr = document.createElement("tr");
                th = document.createElement("th");
                th.innerText = "해설 사용 여부";
                td = document.createElement("td");
                td.setAttribute("colspan", "3");
                td.setAttribute("style","background-color: #ecedee");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+String(quizCnt-1));
                input.setAttribute("id", "comY_"+String(quizCnt-1));
                input.setAttribute("value", "Y");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comY_" + String(quizCnt - 1));
                label.innerText="사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+String(quizCnt-1));
                input.setAttribute("id", "comN_"+String(quizCnt-1));
                input.setAttribute("value", "N");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comN_" + String(quizCnt - 1));
                label.innerText="미사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("size", "100");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("name", "comment");
                input.setAttribute("disabled", "disabled");
                input.setAttribute("id", "comment_"+(String(quizCnt-1)));
                td.appendChild(input);

                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                abUpperTable.appendChild(tbody);

                var abLowerTable = document.createElement("table");
                abLowerTable.setAttribute("class", "table table-sm search-table");
                var style = document.createElement("style");
                style.innerText = "input{margin-left:6px; margin-right:6px;}"
                abLowerTable.appendChild(style);
                var tbody = document.createElement("tbody");
                var tr = document.createElement("tr");
                var th = document.createElement("th");
                th.setAttribute("style","height: 50px; width:50%; text-align: center");
                th.innerText = "선택지";
                tr.appendChild(th);
                th = document.createElement("th");
                th.setAttribute("style","height: 50px; width:25%; text-align: center");
                div = document.createElement("div");
                div.innerText = "이미지";
                th.appendChild(div);
                div = document.createElement("div");
                div.setAttribute("style", "margin-left: 12px; color:#dc3545; font-weight: normal");
                div.innerText = "가로: 324px, 세로: 324px";
                th.appendChild(div);

                tr.appendChild(th);
                th = document.createElement("th");
                th.setAttribute("style","height: 50px; width:25%; text-align: center");
                th.innerText = "정답";
                tr.appendChild(th);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                tr.setAttribute("style","text-align: center");

                td = document.createElement("td");
                input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("name", "A_"+String(quizCnt-1));
                input.setAttribute("size", "80");
                input.setAttribute("maxlength", "80");
                td.appendChild(input);
                tr.appendChild(td);

                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id","preview_A_"+String(quizCnt-1))
                var label = document.createElement("label");
                // label.setAttribute("for", "image_A_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizABImage");
                input.setAttribute("id", "image_A_" + String(quizCnt - 1));
                input.setAttribute("class", "btn btn-outline-dark");
                input.setAttribute("style", "margin-right: 100px; display: none");
                input.setAttribute("accept", ".png, .jpg");
                input.setAttribute("onchange","readImageAB(this)");
                div.appendChild(img);
                div.appendChild(label);
                div.appendChild(input);
                td.appendChild(div);
                tr.appendChild(td);

                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "corAB_"+String(quizCnt-1));
                input.setAttribute("id", "corA_"+String(quizCnt-1));
                input.setAttribute("value", "0");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                tr.appendChild(td);
                tbody.appendChild(tr);

                tr = document.createElement("tr");
                tr.setAttribute("style","text-align: center");

                td = document.createElement("td");
                input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("size", "80");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("name", "B_"+String(quizCnt-1));
                input.setAttribute("maxlength", "80");
                td.appendChild(input);
                tr.appendChild(td);

                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id","preview_B_"+String(quizCnt-1))
                var label = document.createElement("label");
                // label.setAttribute("for", "image_B_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizABImage");
                input.setAttribute("id", "image_B_" + String(quizCnt - 1));
                input.setAttribute("class", "btn btn-outline-dark");
                input.setAttribute("style", "margin-right: 100px; display: none");
                input.setAttribute("accept", ".png, .jpg");
                input.setAttribute("onchange","readImageAB(this)");
                div.appendChild(img);
                div.appendChild(label);
                div.appendChild(input);
                td.appendChild(div);
                tr.appendChild(td);

                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "corAB_"+String(quizCnt-1));
                input.setAttribute("id", "corB_"+String(quizCnt-1));
                input.setAttribute("value", "1");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                tr.appendChild(td);
                tbody.appendChild(tr);

                abLowerTable.appendChild(tbody);

                quizRow.replaceChild(abUpperTable, upperTable);
                quizRow.replaceChild(abLowerTable, lowerTable);
            }
        }

        function delRow(row){
            var con = confirm('<spring:message code="confirm1.1"/>');
            if (con) {
                row.parentNode.parentNode.parentNode.parentNode.remove();
                checkTD();
            }
        }

        function checkTD(){
             var udList = document.getElementsByName("updown");
             for (var i=0; i<udList.length; i++){
                 console.log(i);
                 var up = udList[i].firstChild;
                 var down = udList[i].lastChild;
                 if (i==0){
                     if (!up.hasAttribute("disabled")){
                         up.setAttribute("disabled","disabled");
                     }
                     if (down.hasAttribute("disabled")){
                         down.removeAttribute("disabled");
                     }
                     if (i == udList.length-1) {
                         if (!down.hasAttribute("disabled")){
                             down.setAttribute("disabled","disabled");
                         }
                     }
                 }
                 else if (i == udList.length-1) {
                     if (up.hasAttribute("disabled")){
                         up.removeAttribute("disabled");
                     }
                     if (!down.hasAttribute("disabled")){
                         down.setAttribute("disabled","disabled");
                     }
                 }
                 else{
                     if (up.hasAttribute("disabled")){
                         up.removeAttribute("disabled");
                     }
                     if (down.hasAttribute("disabled")){
                         down.removeAttribute("disabled");
                     }
                 }
             }

         }

        function readImageMain(input) {
            // 인풋 태그에 파일이 있는 경우
            if(input.files && input.files[0]) {
                if( $("#image_0").val() != "" ){
                    var ext = $('#mainImage').val().split('.').pop().toLowerCase();
                    if($.inArray(ext, ['png','jpg']) == -1) {
                        alert('<spring:message code="error3.2" arguments="260,260"/>');
                        return;
                    }
                }
                // FileReader 인스턴스 생성
                const reader = new FileReader();
                // 이미지가 로드가 된 경우
                reader.onload = e => {
                    var img = new Image();
                    img.src = e.target.result;
                    img.onload = function(){
                        var w = this.width;
                        var h = this.height;
                        if (w != 260 || h != 260) {
                            alert('<spring:message code="error3.1" arguments="260,260"/>');
                            input.value = '';
                        }
                        else{
                            const previewImage = document.getElementById("previewMain");
                            previewImage.src = e.target.result;
                        }
                    }


                }
                // reader가 이미지 읽도록 하기
                reader.readAsDataURL(input.files[0]);
            }
        }

        function readImage(input) {
            // 인풋 태그에 파일이 있는 경우
            if(input.files && input.files[0]) {
                if( input.value != "" ){
                    var ext = input.value.split('.').pop().toLowerCase();
                    if($.inArray(ext, ['png','jpg']) == -1) {
                        alert('<spring:message code="error3.2" arguments="670,380"/>');
                        return;
                    }
                }
                // FileReader 인스턴스 생성
                const reader = new FileReader();
                // 이미지가 로드가 된 경우
                reader.onload = e => {
                    var img = new Image();
                    img.src = e.target.result;
                    img.onload = function(){
                        var w = this.width;
                        var h = this.height;
                        if (w != 670 || h != 380) {
                            alert('<spring:message code="error3.1" arguments="670,380"/>');
                            input.value = '';
                        }
                        else{
                            const previewImage = document.getElementById("preview_"+input.id.split("_")[1]);
                            previewImage.src = e.target.result;
                        }
                    }


                }
                // reader가 이미지 읽도록 하기
                reader.readAsDataURL(input.files[0]);
            }
        }

        function readImageAB(input) {
            // 인풋 태그에 파일이 있는 경우
            if(input.files && input.files[0]) {
                if( input.value != "" ){
                    var ext = input.value.split('.').pop().toLowerCase();
                    if($.inArray(ext, ['png','jpg']) == -1) {
                        alert('<spring:message code="error3.2" arguments="324,324"/>');
                        return;
                    }
                }
                // FileReader 인스턴스 생성
                const reader = new FileReader();
                // 이미지가 로드가 된 경우
                reader.onload = e => {
                    var img = new Image();
                    img.src = e.target.result;
                    img.onload = function(){
                        var w = this.width;
                        var h = this.height;
                        if (w != 324 || h != 324) {
                            alert('<spring:message code="error3.1" arguments="324,324"/>');
                            input.value = '';
                        }
                        else{
                            const previewImage = document.getElementById("preview_"+input.id.split("_")[1]+"_"+input.id.split("_")[2]);
                            previewImage.src = e.target.result;
                        }
                    }


                }
                // reader가 이미지 읽도록 하기
                reader.readAsDataURL(input.files[0]);
            }
        }

        function up(row){
            var curRow = row.parentNode.parentNode.parentNode.parentNode;
            var prevRow = curRow.previousSibling;
            console.log(curRow);
            console.log(prevRow);
            curRow.parentNode.insertBefore(curRow, prevRow);
            checkTD();
        }

        function down(row){
            var curRow = row.parentNode.parentNode.parentNode.parentNode;
            var nextRow = curRow.nextSibling;
            console.log(curRow);
            console.log(nextRow);
            curRow.parentNode.insertBefore(nextRow, curRow);
            checkTD();
        }

        function abAnswerYnConfig(input){
            var ansYcorY = input.parentNode.childNodes[1].childNodes[1].firstChild;
            var ansYcorN = input.parentNode.childNodes[1].childNodes[3].firstChild;
            var ansN = input.parentNode.childNodes[3].childNodes[1].firstChild;
            var comTd = input.parentNode.parentNode.nextSibling.nextSibling.childNodes[1];
            var comY = input.parentNode.parentNode.nextSibling.nextSibling.childNodes[1].childNodes[0];
            var comN = input.parentNode.parentNode.nextSibling.nextSibling.childNodes[1].childNodes[2];
            var comment = input.parentNode.parentNode.nextSibling.nextSibling.childNodes[1].childNodes[4];
            var corA = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[1].childNodes[2].childNodes[0];
            var corB = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[2].childNodes[2].childNodes[0];
            var corAtd = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[1].childNodes[2];
            var corBtd = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[2].childNodes[2];
            var YN = input.value;
            console.log(YN);

            if(YN=="Y"){
                ansYcorY.removeAttribute("disabled");
                ansYcorN.removeAttribute("disabled");
                comY.removeAttribute("disabled");
                comY.checked=true;
                comN.removeAttribute("disabled");
                comment.removeAttribute("disabled");
                ansN.setAttribute("disabled", "disabled");
                ansN.removeAttribute("value");
                corA.removeAttribute("disabled");
                corB.removeAttribute("disabled");
                corA.checked=false;
                corB.checked=false;
                comTd.removeAttribute("style");
                corAtd.removeAttribute("style");
                corBtd.removeAttribute("style");
            }
            else{
                ansYcorY.setAttribute("disabled", "disabled");
                ansYcorN.setAttribute("disabled", "disabled");
                comY.checked=false;
                comN.checked=false;
                corA.setAttribute("disabled","disabled");
                corB.setAttribute("disabled","disabled");
                corA.checked=false;
                corB.checked=false;
                comY.setAttribute("disabled", "disabled");
                comN.setAttribute("disabled", "disabled");
                ansN.removeAttribute("disabled");
                comment.setAttribute("disabled", "disabled");
                comTd.setAttribute("style","background-color: #ecedee");
                corAtd.setAttribute("style","background-color: #ecedee");
                corBtd.setAttribute("style","background-color: #ecedee");
            }
        }

        function oxAnswerYnConfig(input){
            var ansYcorY = input.parentNode.childNodes[1].childNodes[1].firstChild;
            var ansYcorN = input.parentNode.childNodes[1].childNodes[3].firstChild;
            var ansN = input.parentNode.childNodes[3].childNodes[1].firstChild;
            var comTd = input.parentNode.parentNode.nextSibling.childNodes[1];
            var comY = input.parentNode.parentNode.nextSibling.childNodes[1].childNodes[0];
            var comN = input.parentNode.parentNode.nextSibling.childNodes[1].childNodes[2];
            var comment = input.parentNode.parentNode.nextSibling.childNodes[1].childNodes[4];
            var corO = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[1].childNodes[1].childNodes[0];
            var corOtd = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[1].childNodes[1];
            var corX = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[2].childNodes[1].childNodes[0];
            var corXtd = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[2].childNodes[1];
            var YN = input.value;
            console.log(YN);

            if(YN=="Y"){
                ansYcorY.removeAttribute("disabled");
                ansYcorN.removeAttribute("disabled");
                comY.removeAttribute("disabled");
                comY.checked=true;
                comN.removeAttribute("disabled");
                comment.removeAttribute("disabled");
                ansN.setAttribute("disabled", "disabled");
                corO.removeAttribute("disabled");
                corX.removeAttribute("disabled");
                corO.checked=false;
                corX.checked=false;
                comTd.removeAttribute("style");
                corOtd.removeAttribute("style");
                corXtd.removeAttribute("style");
            }
            else{
                ansYcorY.setAttribute("disabled", "disabled");
                ansYcorN.setAttribute("disabled", "disabled");
                comY.checked=false;
                comN.checked=false;
                corO.setAttribute("disabled","disabled");
                corX.setAttribute("disabled","disabled");
                corO.checked=false;
                corX.checked=false;
                comY.setAttribute("disabled", "disabled");
                comN.setAttribute("disabled", "disabled");
                ansN.removeAttribute("disabled");
                comment.setAttribute("disabled", "disabled");
                comTd.setAttribute("style","background-color: #ecedee");
                corOtd.setAttribute("style","background-color: #ecedee");
                corXtd.setAttribute("style","background-color: #ecedee");
            }
        }

        function commentYnConfig(input){
            var textInput = input.parentNode.childNodes[4];
            if (input.value=="Y"){
                textInput.removeAttribute("disabled");
                console.log(textInput);

            }
            else{
                textInput.setAttribute("disabled", "disabled");
                console.log(textInput);

            }
        }

        function imageYnConfig(input){
            var imageAtd = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[1].childNodes[1];
            var imageBtd = input.parentNode.parentNode.parentNode.parentNode.nextSibling.childNodes[1].childNodes[2].childNodes[1];
            var labelA = imageAtd.childNodes[0].childNodes[1];
            var labelB = imageBtd.childNodes[0].childNodes[1];
            var inputA = labelA.nextSibling;
            var inputB = labelB.nextSibling;
            var idA = inputA.getAttribute("id");
            var idB = inputB.getAttribute("id");

            var YN = input.value;
            if (YN == "Y") {
                imageAtd.removeAttribute("style");
                imageBtd.removeAttribute("style");
                labelA.setAttribute("for", "image_A_"+idA.split("_")[2]);
                labelA.removeAttribute("style");
                labelB.setAttribute("for", "image_B_"+idB.split("_")[2]);
                labelB.removeAttribute("style");

            }
            else{
                var td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id", "preview_A_" + idA.split("_")[2]);
                var label = document.createElement("label");
                // label.setAttribute("for", "image_A_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("id", "image_A_" + idA.split("_")[2]);
                input.setAttribute("class", "btn btn-outline-dark");
                input.setAttribute("style", "margin-right: 100px; display: none");
                input.setAttribute("accept", ".png, .jpg");
                input.setAttribute("onchange","readImageAB(this)");
                div.appendChild(img);
                div.appendChild(label);
                div.appendChild(input);
                td.appendChild(div);

                imageAtd.parentNode.replaceChild(td, imageAtd);

                var td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id","preview_B_"+idB.split("_")[2])
                var label = document.createElement("label");
                // label.setAttribute("for", "image_B_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("id", "image_B_" + idB.split("_")[2]);
                input.setAttribute("class", "btn btn-outline-dark");
                input.setAttribute("style", "margin-right: 100px; display: none");
                input.setAttribute("accept", ".png, .jpg");
                input.setAttribute("onchange","readImageAB(this)");
                div.appendChild(img);
                div.appendChild(label);
                div.appendChild(input);
                td.appendChild(div);

                imageBtd.parentNode.replaceChild(td, imageBtd);


            }
        }

        function checkText(input){
            const regEx = new RegExp(/[가-힣a-zA-Z0-9\[\]\{\}\!]+$/);
            if(input.value!=""){
                if(!regEx.test(input.value)){
                    alert('<spring:message code="error11.4"/>');
                    input.value="";
                }
            }
        }

        function checkInt(input){
            const regEx = new RegExp(/^[0-9]*$/);
            if(input.value!=""){
                if(!regEx.test(input.value)){
                    alert('<spring:message code="error11.2"/>');
                    input.value="";
                }
            }
        }

        function checkForm() {
            var quizNm = document.getElementById("quizNm");
            if (quizNm.value == "") {
                alert('<spring:message code="error12.1"/>');
                return false;
            }

            var mainImage = document.getElementById("mainImage");
            if (mainImage.value == "") {
                alert('<spring:message code="error12.3" arguments="대표이미지"/>');
                return false;
            }

            var maxPrt = document.getElementById("maxPrt");
            if (maxPrt.value == "") {
                alert('<spring:message code="error12.3" arguments="일 최대 참여자수"/>');
                return false;
            }

            var quizRowList = document.getElementsByName("quizRow");
            if(quizRowList.length == 0){
                alert('<spring:message code="error12.2"/>');
                return false;
            }
            var error = false;
            quizRowList.forEach(function(row){
                if(!error){
                    var inputList = row.getElementsByTagName("input");
                    for (var i=0; i<inputList.length; i++) {
                        if(inputList[i].name.split('_')[0] == "quizQuestion" && inputList[i].value==""){
                            alert('<spring:message code="error12.3" arguments="퀴즈질문"/>');
                            error = true;
                            return false;
                        }
                        else if(inputList[i].name == "quizMainImage" && inputList[i].value==""){
                            alert('<spring:message code="error12.3" arguments="질문이미지"/>');
                            error = true;
                            return false;
                        }
                        else if(inputList[i].name.split('_')[0] == "ansYn"){
                            var index = inputList[i].name.split('_')[1];
                            var ansYcorY = document.getElementById("ansY_corY_clov_" + index);
                            var ansYcorN = document.getElementById("ansY_corN_clov_" + index);
                            var ansN = document.getElementById("ansN_clov_" + index);
                            var comment = document.getElementById("comment_" + index);
                            var comY = document.getElementById("comY_" + index);
                            var corO = document.getElementById("corO_" + index);
                            var corX = document.getElementById("corX_" + index);
                            if(inputList[i].value == 'Y' && inputList[i].checked){
                                if(ansYcorY.value==""){
                                    alert('<spring:message code="error12.3" arguments="정답클로버"/>');
                                    error = true;
                                    return false;
                                }
                                if(ansYcorN.value==""){
                                    alert('<spring:message code="error12.3" arguments="오답클로버"/>');
                                    error = true;
                                    return false;
                                }
                                if(comY.checked){
                                    if(comment.value==""){
                                        alert('<spring:message code="error12.3" arguments="해설"/>');
                                        error = true;
                                        return false;
                                    }
                                }
                                if(corO != null && corX !=null){
                                    if(!corO.checked && !corX.checked){
                                        alert('<spring:message code="error12.3" arguments="정답"/>');
                                        error = true;
                                        return false;
                                    }
                                }
                             }
                            else if(inputList[i].value == 'N' && inputList[i].checked){
                                if(ansN.value==""){
                                    alert('<spring:message code="error12.3" arguments="미사용클로버"/>');
                                    error = true;
                                    return false;
                                }

                            }
                        }
                        else if(inputList[i].name.split('_')[0] == "imgYn"){
                            var index = inputList[i].name.split('_')[1];
                            var imgY = document.getElementById("imgY_" + index);
                            var imgA = document.getElementById("image_A_" + index);
                            var imgB = document.getElementById("image_B_" + index);
                            if(imgY.checked){
                                if(imgA.value == "" || imgB.value == ""){
                                    alert('<spring:message code="error12.3" arguments="선택지 이미지"/>');
                                    error = true;
                                    return false;
                                }
                            }
                        }
                        else if(inputList[i].name.split('_')[0] == "A" || inputList[i].name.split('_')[0] == "B"){
                            if(inputList[i].value == ""){
                                alert('<spring:message code="error12.3" arguments="선택지"/>');
                                error = true;
                                return false;
                            }
                        }
                    }
                }
            });
            if(error){
                return false;
            }
            else{
                var quizOrder = document.getElementById("quizOrder");
                var quizList = document.getElementsByName("quizRow");
                var quizOrderStr = "";
                quizList.forEach(function(quiz){
                    quizOrderStr += (quiz.id + "_");
                })
                quizOrder.setAttribute("value", quizOrderStr);
                return true;
            }
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

            <!-- 헤드라인 영역// -->
            <div class="no_border_head">
                <span class="tab_span flSpan">퀴즈 등록</span>
                <br>
                <br>
            </div>
            <!-- //헤드라인 영역 -->

            <!-- 입력창 영역 // -->
            <form action="/quiz/register" method="post" id="registerForm" enctype="multipart/form-data" style="display: inline" onsubmit="return checkForm();">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap pt-3">
                    <table class="table table-sm search-table">
                        <style>
                            input{margin-left:6px; margin-right:6px;}
                        </style>
                        <tbody>
                        <tr>
                            <td style="height: 50px; font-size: medium; font-weight: bold" colspan="6">등록정보</td>
                        </tr>
                        <tr>
                            <th style="height: 50px; width:100px">시작일</th>
                            <td style="width: 360px">
                                <input type="text" class="datepicker" name="dspStDt" id="dspStDt">
                            </td>
                            <th style="height: 50px; width:100px">종료일</th>
                            <td style="width: 360px">
                                <input type="text" class="datepicker" name="dspEndDt" id="dspEndDt">
                            </td>
                            <th style="height: 50px; width:100px">일괄 푸시 발송</th>
                            <td style="width: 360px">
                                <input class="form-check-input" type="radio" name="pushYn" id="pushY" value="Y">
                                <label class="form-check-label" for="pushY">
                                    발송
                                </label>
                                <input class="form-check-input" type="radio" name="pushYn" id="pushN" value="N" checked>
                                <label class="form-check-label" for="pushN">
                                    미발송
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th style="height:50px">전시상태</th>
                            <td colspan="6">
                                <div>
                                    <input class="form-check-input" type="radio" name="dspYn" id="dspY" value="Y">
                                    <label class="form-check-label" for="dspY">
                                        전시
                                    </label>
                                    <input class="form-check-input" type="radio" name="dspYn" id="dspN" value="N" checked>
                                    <label class="form-check-label" for="dspN">
                                        전시안함
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="height: 50px">퀴즈명</th>
                            <td colspan="6">
                                <div>
                                    <input type="text" name="quizNm" id="quizNm" size="150" maxlength="24" onchange="checkText(this)">
                                </div>
                            </td>
                        </tr>
                        <tr style="height: 160px">
                            <th >대표이미지</th>
                            <td colspan="6">
                                <div>
                                    <img style="margin: 6px" id="previewMain" src="data:image/png;base64,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">
                                    <label for="mainImage" class="btn btn-dark">찾기</label>
                                    <input type="file" name="mainImage" id="mainImage" class="btn btn-outline-dark" style="margin-right: 100px; display: none" accept=".png, .jpg" onchange="readImageMain(this)">
                                </div>
                                <div style="margin-left: 12px; color:#dc3545">
                                    가로: 260px, 세로: 260px
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><br><br>

                <table class="table table-sm search-table">
                    <tbody>
                    <tr style="height: 50px; font-size: medium; font-weight: bold">
                        <td  colspan="2">리워드 지급설정</td>
                    </tr>
                    <tr>
                        <th style="height: 50px; width: 110px">일 최대 참여자수</th>
                        <td>
                            <input type="text" name="maxPrt" id="maxPrt" size="11" maxlength="10" onchange="checkInt(this)"> 명
                        </td>
                    </tr>
                    </tbody>
                </table>

                <br>
                <table class="table table-sm search-table">
                    <tbody id="quizList">
                        <tr style="height: 50px; font-size: medium; font-weight: bold; vertical-align: center">
                            <td colspan="2">
                                    <span>
                                        퀴즈
                                    </span>
                                    <span style="float: right">
                                        <button type="button" class="btn btn-outline-secondary" style="background-color: #ecedee; color: black; font-size: 15px" onclick="createOX()">OX형</button>
                                        <button type="button" class="btn btn-outline-secondary btn-example" style="background-color: #ecedee; color: black;  font-size: 15px" onclick="createAB()">AB형</button>
                                    </span>
                            </td>
                        </tr>
                        <tr id="tmpQuiz">
                            <td style="height: 50px"></td>
                        </tr>
                    </tbody>
                </table>


                <!-- 초기화, 검색버튼// -->
                <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar mb-2">
                        <div class="btn-group">
                            <button type="button" class="btn btn-outline-secondary" style="margin-right:6px; width:80px; height:40px " id="btn_reset">취소</button>
                            <button type="submit"  class="btn btn-primary" style="margin-right:6px; width:80px; height:40px " id="btn_submit" >저장</button>
                        </div>
                    </div>
                </div>
                <!-- //초기화, 검색버튼 -->

<%--                hidden data field                --%>
                <input type="hidden" name="quizOrder" id="quizOrder">

            </form>
        </main>
    </div>
</div>
</body>
</html>


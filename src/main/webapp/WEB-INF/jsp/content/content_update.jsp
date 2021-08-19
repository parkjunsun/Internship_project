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
    <script type="text/javascript" src="/js/build/jquery.datetimepicker.full.min.js"></script>
    <link rel="stylesheet" href="/css/jquery.datetimepicker.min.css">
    <script type="text/javascript" src="/js/moment.js"></script>
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

        .label-disabled {
            pointer-events: none;
            background-color: #eee;
            color: #555;
            opacity: 1;
            cursor: default;
            padding: 6px 25px;
            border-radius: 4px;
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



        var Detection = false;

        function checkDetection() {
            Detection = true;
        }


        function getCurrentDate()
        {
            var date = new Date();
            var year = date.getFullYear().toString();

            var month = date.getMonth() + 1;
            month = month < 10 ? '0' + month.toString() : month.toString();

            var day = date.getDate();
            day = day < 10 ? '0' + day.toString() : day.toString();

            var hour = date.getHours();
            hour = hour < 10 ? '0' + hour.toString() : hour.toString();

            var minutes = date.getMinutes();
            var remain = minutes % 10;
            minutes = minutes - remain;
            minutes = minutes < 10 ? '0' + minutes.toString() : minutes.toString();

            // return year + month + day + hour + minutes + seconds;
            return year + '-' + month + '-' + day + ' ' + hour + ':' + minutes
        }


        function addUrlRow() {
            const rootDiv = document.createElement('div');
            rootDiv.classList.add('table-responsive');
            rootDiv.id = 'urlDiv'

            const div = document.createElement('div');
            div.style.border = '1px solid black';
            div.style.lineHeight = '45px';
            div.style.height = '45px';

            const span = document.createElement('span');
            span.style.float = 'left';
            span.style.marginLeft = '10px';
            span.innerText = '콘텐츠 본문내용';

            div.appendChild(span);

            const table = document.createElement('table');
            table.classList.add('table', 'table-striped' , 'table-sm');
            const colgroup = document.createElement('colgroup')
            const col1 = document.createElement('col');
            const col2 = document.createElement('col');
            col1.style.width = '150px';
            col2.style.width = '*';

            colgroup.appendChild(col1);
            colgroup.appendChild(col2);

            const tbody = document.createElement('tbody');
            const tr = document.createElement('tr');
            const th = document.createElement('th');
            th.innerText = 'URL 주소';
            th.style.textAlign = 'center';
            const td = document.createElement('td');
            const input = document.createElement('input');
            input.type = 'text';
            input.classList.add("form-control");
            input.id = 'inputUrl';
            input.name = 'inputUrl';
            input.value = "${urlAddr}";

            td.appendChild(input);

            tr.appendChild(th);
            tr.appendChild(td);

            tbody.appendChild(tr);

            table.appendChild(colgroup);
            table.appendChild(tbody);

            rootDiv.appendChild(div);
            rootDiv.appendChild(table);

            const form = document.getElementById('updateForm');
            form.appendChild(rootDiv);
        }

        function addCardHead() {
            const rootDiv = document.createElement('div');
            rootDiv.classList.add('table-responsive');
            rootDiv.id = 'cardDiv';

            const div = document.createElement('div');
            div.style.border = '1px solid black';
            div.style.height = '45px';

            const span = document.createElement('span');
            span.style.float = 'left';
            span.style.marginTop = '11px';
            span.style.marginLeft = '10px';
            span.innerText = '콘텐츠 본문내용';

            const btn = document.createElement('button');
            btn.type = 'button';
            btn.style.float = 'right';
            btn.style.height = '30px';
            btn.style.marginTop = '6px';
            btn.style.marginRight = '10px';
            btn.id = 'add_btn';
            btn.addEventListener('click', function () {addRow()});
            btn.addEventListener('click', function () {checkDetection()});
            btn.innerText = '콘텐츠 추가';

            div.appendChild(span);
            div.appendChild(btn);

            const table = document.createElement('table');
            table.classList.add('table', 'table-striped', 'table-sm');
            table.id = 'extraContent';

            const colgroup = document.createElement('colgroup');
            colgroup.id = 'colgroup';
            const col1 = document.createElement('col');
            const col2 = document.createElement('col');
            const col3 = document.createElement('col');
            const col4 = document.createElement('col');

            col1.style.width = '150px';
            col2.style.width = '150px';
            col3.style.width = '*';
            col4.style.width = '150px';

            colgroup.appendChild(col1);
            colgroup.appendChild(col2);
            colgroup.appendChild(col3);
            colgroup.appendChild(col4);

            const thead = document.createElement('thead');
            thead.id = 'thead';
            const tr = document.createElement('tr');
            tr.style.height = '45px';

            const th1 = document.createElement('th');
            th1.scope = 'col';
            th1.style.textAlign = 'center';
            th1.innerText = '본문';
            const th2 = document.createElement('th');
            th2.scope = 'col';
            th2.style.textAlign = 'center';
            th2.innerText = '전시순서';
            const th3 = document.createElement('th');
            th3.scope = 'col';
            th3.style.textAlign = 'center';
            th3.innerText = '본문 이미지';
            const th4 = document.createElement('th');
            th4.scope = 'col';
            th4.style.textAlign = 'center';
            th4.innerText = '영역 삭제';

            tr.appendChild(th1);
            tr.appendChild(th2);
            tr.appendChild(th3);
            tr.appendChild(th4);

            thead.appendChild(tr);

            const tbody = document.createElement('tbody');
            tbody.id = 'tbody';

            table.appendChild(colgroup);
            table.appendChild(thead);
            table.appendChild(tbody);

            rootDiv.appendChild(div);
            rootDiv.appendChild(table);

            const form = document.getElementById('updateForm');
            form.appendChild(rootDiv);
        }


        var ctnDetImages = [];

        window.onload = function(){

            if ("${tplCd}" === "T0001") {
                if (document.getElementById('urlDiv') != null) {
                    urlDiv.remove();
                }
                addCardHead();
                <c:forEach items="${ctnDetImages}" var="item">
                var obj = {
                    "imgSeq" : "${item.imgSeq}",
                    "imgGrpId": "${item.imgGrpId}",
                    "imgTyCd": "${item.imgTyCd}",
                    "path": "${item.path}",
                    "feNm": "${item.feNm}",
                    "encFeNm": "${item.encFeNm}",
                    "feExt": "${item.feExt}",
                    "feSz": "${item.feSz}",
                    "regDt": "${item.regDt}",
                    "modDt": "${item.modDt}",
                    "useYn": "${item.useYn}",
                    "imgOdr": "${item.imgOdr}"
                };
                ctnDetImages.push(obj);
                </c:forEach>

                var cur = 1;
                for (let i=0; i<ctnDetImages.length; i++) {
                    addRow();
                    var newImage = document.createElement("img");
                    newImage.setAttribute("class", "ctnDetImg");

                    newImage.src = "/image/" + ctnDetImages[i]["encFeNm"] + '.' + ctnDetImages[i]["feExt"];

                    newImage.style.width = "150px";
                    newImage.style.height = "150px";
                    newImage.style.visibility = "visible";
                    newImage.style.objectFit = "contain";

                    var inputHidden = document.createElement("input");
                    inputHidden.type = 'hidden';
                    inputHidden.name = 'imgSeq';
                    inputHidden.value = ctnDetImages[i]["imgSeq"];

                    if (document.getElementById('defaultImg' + cur) != null) {
                        document.getElementById('defaultImg' + cur).remove();
                    }

                    var container = document.getElementById('ctn_image-show' + cur);
                    if (container.querySelector('.ctnDetImg') != null) {
                        const oldImage = container.querySelector('.ctnDetImg');
                        container.removeChild(oldImage);
                    }
                    container.appendChild(newImage);
                    container.appendChild(inputHidden);
                    cur += 1;
                }
                ctn_index = cur - 1;
            } else if ("${tplCd}" === "T0002") {
                if (document.getElementById('cardDiv') != null) {
                    cardDiv.remove();
                }
                addUrlRow();
                ctn_index = 0;
            }


            const today = getCurrentDate().substr(0, 10);
            const dspStDt = document.getElementById("dspStDt").value.substr(0, 10);
            const dspEndDt = document.getElementById("dspEndDt").value.substr(0, 10);


            if (today >= dspStDt && today < dspEndDt) {
                const dspStDtInput = document.getElementById("dspStDt");
                dspStDtInput.setAttribute("readonly", "readonly");
                dspStDtInput.setAttribute("disabled", "disabled");

                const dspStToggle = document.getElementById("stToggle");
                dspStToggle.style.display = "inline-block";
                dspStToggle.style.backgroundColor = "transparent";
                dspStToggle.style.border = 0;
                dspStToggle.style.backgroundImage = "url('http://jqueryui.com/resources/demos/datepicker/images/calendar.gif')";
                dspStToggle.style.backgroundRepeat = "no-repeat";
                dspStToggle.style.backgroundSize = "23px 25px";
                dspStToggle.style.width = "23px";
                dspStToggle.style.height = "25px";

                dspStToggle.style.filter = "grayscale(100%)";
                dspStToggle.style.cursor = "default";
                dspStToggle.setAttribute("disabled", "disabled");
            }

            if (today >= dspEndDt) {
                const ctnNm = document.getElementById("ctnNm");
                ctnNm.setAttribute("readonly", "readonly");

                const ctnDivs = document.getElementsByName("ctnDiv");
                for (let ctnDiv of ctnDivs) {
                    ctnDiv.setAttribute("disabled", "disabled");
                }

                const dspStDtInput = document.getElementById("dspStDt");
                dspStDtInput.setAttribute("readonly", "readonly");
                dspStDtInput.setAttribute("disabled", "disabled");

                const dspStToggle = document.getElementById("stToggle");
                dspStToggle.style.display = "inline-block";
                dspStToggle.style.backgroundColor = "transparent";
                dspStToggle.style.border = 0;
                dspStToggle.style.backgroundImage = "url('http://jqueryui.com/resources/demos/datepicker/images/calendar.gif')";
                dspStToggle.style.backgroundRepeat = "no-repeat";
                dspStToggle.style.backgroundSize = "23px 25px";
                dspStToggle.style.width = "23px";
                dspStToggle.style.height = "25px";

                dspStToggle.style.filter = "grayscale(100%)";
                dspStToggle.style.cursor = "default";
                dspStToggle.setAttribute("disabled", "disabled");

                const dspEndDtInput = document.getElementById("dspEndDt");
                dspEndDtInput.setAttribute("readonly", "readonly");
                dspEndDtInput.setAttribute("disabled", "disabeld");

                const dspEndToggle = document.getElementById("endToggle");
                dspEndToggle.style.display = "inline-block";
                dspEndToggle.style.backgroundColor = "transparent";
                dspEndToggle.style.border = 0;
                dspEndToggle.style.backgroundImage = "url('http://jqueryui.com/resources/demos/datepicker/images/calendar.gif')";
                dspEndToggle.style.backgroundRepeat = "no-repeat";
                dspEndToggle.style.backgroundSize = "23px 25px";
                dspEndToggle.style.width = "23px";
                dspEndToggle.style.height = "25px";

                dspEndToggle.style.filter = "grayscale(100%)";
                dspEndToggle.style.cursor = "default";
                dspEndToggle.setAttribute("disabled", "disabled");

                const dspYns = document.getElementsByName("dspYn");
                for (let dspYn of dspYns) {
                    dspYn.setAttribute("disabled", "disabled");
                }

                const cmtYns = document.getElementsByName("cmtYn");
                for (let cmtYn of cmtYns) {
                    cmtYn.setAttribute("disabled", "disabled");
                }

                const srcSelect = document.getElementById("srcCd");
                srcSelect.setAttribute("disabled", "disabled");

                const reprImgBtn = document.getElementById("repr_img");
                reprImgBtn.setAttribute("disabled", "disabled");

                const cstYns = document.getElementsByName("cstYn");
                for (let cstYn of cstYns) {
                    cstYn.setAttribute("disabled", "disabled");
                }

                const popMsg = document.getElementById("popMsg");
                popMsg.setAttribute("readonly", "readonly");

                if ("${tplCd}" === "T0001") {
                    const addBtn = document.getElementById("add_btn");
                    addBtn.setAttribute("disabled", "disabled");

                    const upArrows = document.getElementsByName("up_arrow");
                    for (let upArrow of upArrows) {
                        upArrow.classList.add("disabled");
                        upArrow.style.cursor = "default";
                        upArrow.style.pointerEvents = "none";
                    }

                    const downArrows = document.getElementsByName("down_arrow");
                    for (let downArrow of downArrows) {
                        downArrow.classList.add("disabled");
                        downArrow.style.cursor = "default";
                        downArrow.style.pointerEvents = "none";
                    }


                    const imgFindBtns = document.getElementsByName("ctn_img");
                    for (let findBtn of imgFindBtns) {
                        findBtn.setAttribute("disabled", "disabled");
                    }

                    const imgRemoveBtns = document.getElementsByName("remove_btn");
                    for (let RemoveBtn of imgRemoveBtns) {
                        RemoveBtn.setAttribute("disabled", "disabled");
                    }

                    const labels = document.getElementsByClassName("file-input");
                    for (let label of labels) {
                        label.style.display = "none";
                    }
                } else if ("${tplCd}" === "T0002") {
                    const inputUrl = document.getElementById("inputUrl");
                    inputUrl.setAttribute("readonly", "readonly");
                }

                const btnSubmit = document.getElementById("btn_submit");
                btnSubmit.style.display = "none";
            }

        };

        <%--$(function() {--%>
        <%--    //input을 datepicker로 선언--%>
        <%--    $("#dspStDt").datepicker({--%>
        <%--        dateFormat: 'yy-mm-dd' //달력 날짜 형태--%>
        <%--        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시--%>
        <%--        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서--%>
        <%--        ,changeYear: true //option값 년 선택 가능--%>
        <%--        ,changeMonth: true //option값  월 선택 가능--%>
        <%--        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시--%>
        <%--        ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로--%>
        <%--        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함--%>
        <%--        ,buttonText: "선택" //버튼 호버 텍스트--%>
        <%--        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트--%>
        <%--        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트--%>
        <%--        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip--%>
        <%--        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트--%>
        <%--        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip--%>
        <%--        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)--%>
        <%--        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)--%>
        <%--        ,onSelect:function(d){--%>
        <%--            var start = new Date($("#dspStDt").datepicker("getDate"));--%>
        <%--            var end = new Date($("#dspEndDt").datepicker("getDate"));--%>
        <%--            if (end - start < 0){--%>
        <%--                alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");--%>
        <%--                $('#dspStDt').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)--%>
        <%--            }--%>

        <%--        }--%>
        <%--    });--%>
        <%--    $("#dspEndDt").datepicker({--%>
        <%--        dateFormat: 'yy-mm-dd' //달력 날짜 형태--%>
        <%--        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시--%>
        <%--        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서--%>
        <%--        ,changeYear: true //option값 년 선택 가능--%>
        <%--        ,changeMonth: true //option값  월 선택 가능--%>
        <%--        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시--%>
        <%--        ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로--%>
        <%--        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함--%>
        <%--        ,buttonText: "선택" //버튼 호버 텍스트--%>
        <%--        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트--%>
        <%--        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트--%>
        <%--        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip--%>
        <%--        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트--%>
        <%--        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip--%>
        <%--        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)--%>
        <%--        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)--%>
        <%--        ,onSelect:function(d){--%>
        <%--            var start = new Date($("#dspStDt").datepicker("getDate"));--%>
        <%--            var end = new Date($("#dspEndDt").datepicker("getDate"));--%>
        <%--            if (end - start < 0){--%>
        <%--                alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");--%>
        <%--                $('#dspEndDt').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)--%>
        <%--            }--%>
        <%--        }--%>
        <%--    });--%>


        <%--    //초기값을 오늘 날짜로 설정해줘야 합니다.--%>
        <%--    $('#dspStDt').datepicker('setDate', '${content.dspStDt}'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)--%>
        <%--    $('#dspEndDt').datepicker('setDate', '${content.dspEndDt}'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)--%>
        <%--    $("img.ui-datepicker-trigger").css({'cursor':'pointer', 'margin-left':'5px'});--%>

        <%--});--%>

        $(function () {
            jQuery.datetimepicker.setLocale('kr');

            $('#dspStDt').datetimepicker({
                format: 'Y-m-d H:i',
                defaultDate: moment('${content.dspStDt}').format("YYYY-MM-DD HH:mm"),
                step: 10,
                onSelectDate: function () {
                    var start = $('#dspStDt').val();
                    var front = start.substr(0, 14);
                    var back = parseInt(start.substr(14, 2));

                    var remain = back % 10;
                    back = back - remain;
                    back = back < 10 ? '0' + back.toString() : back.toString();

                    var newStart = front + back;
                    $('#dspStDt').val(newStart);

                }
            });

            $('#dspEndDt').datetimepicker({
                format: 'Y-m-d H:i',
                defaultDate: moment('${content.dspEndDt}').format("YYYY-MM-DD HH:mm"),
                step: 10,
                onSelectDate: function () {
                    var start = $('#dspEndDt').val();
                    var front = start.substr(0, 14);
                    var back = parseInt(start.substr(14, 2));

                    var remain = back % 10;
                    back = back - remain;
                    back = back < 10 ? '0' + back.toString() : back.toString();

                    var newStart = front + back;
                    $('#dspEndDt').val(newStart);
                }
            })

            $('#dspStDt').val(moment('${content.dspStDt}').format("YYYY-MM-DD HH:mm"));
            $('#dspEndDt').val(moment('${content.dspEndDt}').format("YYYY-MM-DD HH:mm"));


            $('#stToggle').on('click', function () {
                $('#dspStDt').datetimepicker('toggle');
            })

            $('#endToggle').on('click', function () {
                $('#dspEndDt').datetimepicker('toggle');
            })

        });

        function loadFile(input) {
            checkDetection();
            const file = input.files[0];	//선택된 파일 가져오기

            const fileName = file.name;
            const extension = fileName.substring(fileName.indexOf('.') + 1, fileName.length);

            const fileSize = input.size;
            const MAX_SIZE = 315000;

            if (fileSize >= MAX_SIZE) {
                alert("이미지 포맷이 맞지 않습니다.");
                return false;
            }

            if (extension === "gif" || extension === "jpg" || extension === "png") {
                //이미지 source 가져오기
                const newImage = document.getElementsByClassName('reprImg')[0];
                newImage.src = URL.createObjectURL(file);
                newImage.style.width = "150px;";
                newImage.style.height = "150px;";
                newImage.style.visibility = "visible";
                newImage.style.objectFit = "contain";

                const container = document.getElementById('image-show');
                if (container.querySelector('.reprImg') != null) {
                    const oldImage = container.querySelector('.reprImg');
                    container.removeChild(oldImage);
                }

            } else {
                alert("이미지 포맷이 맞지 않습니다.");
                return false;
            }
        }

        function ctn_loadFile(input) {
            checkDetection();
            const cur = input.id[input.id.length-1];

            var file = input.files[0];
            const fileName = file.name;
            const extension = fileName.substring(fileName.indexOf('.') + 1, fileName.length)

            const fileSize = input.size;
            const MAX_SIZE = 1125000

            if (fileSize >= MAX_SIZE) {
                alert("이미지 포맷이 맞지 않습니다.");
                return false;
            }

            if (extension === "gif" || extension === "jpg" || extension === "png") {

                if (document.getElementById("defaultImg" + cur) != null) {
                    var defaultImg = document.getElementById("defaultImg" + cur);
                    defaultImg.remove();
                }

                var newImage = document.createElement("img");
                newImage.setAttribute("class", "ctnDetImg");

                newImage.src = URL.createObjectURL(file);

                newImage.style.width = "150px";
                newImage.style.height = "150px";
                newImage.style.visibility = "visible";
                newImage.style.objectFit = "contain";

                var container = document.getElementById('ctn_image-show' + cur);
                if (container.querySelector('.ctnDetImg') != null) {
                    const oldImage = container.querySelector('.ctnDetImg');
                    container.removeChild(oldImage);
                }
                container.appendChild(newImage);
            } else {
                alert("이미지 포맷이 맞지 않습니다.");
                return false;
            }
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

            for (var i = 2; i <= ctn_index; i++) {
                if (document.getElementById('down_arrow' + String(i)).classList.contains('disabled')) {
                    document.getElementById('down_arrow' + String(i)).style.cursor = 'default';
                }
            }
        }

        var idx_list = [];

        function removeRow(e) {
            checkDetection();
            const cur = Number(e.id[e.id.length-1]);

            const ctnDiv = document.getElementById('ctn_image-show' + cur);

            if (ctnDiv.getElementsByTagName('input')[0] != null) {
                const findInputHidden = ctnDiv.getElementsByTagName('input')[0];
                const findImgSeq = findInputHidden.value;

                $(document).ready(function () {
                    $.ajax({
                        url:'/content/image/delete',
                        method: "post",
                        data: {"imgSeq" : findImgSeq},
                        sync: false
                    });
                });
            }

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


                var inputFile = document.getElementById('ctn_img' + String(i));
                inputFile.id = 'ctn_img' + String(i - 1);


                var removeBtn = document.getElementById('remove_btn' + String(i));
                removeBtn.id = 'remove_btn' + String(i - 1)
            }

            ctn_index -= 1;

            document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
            document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'default';



        }

        function moveUpTr(node) {
            checkDetection();
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


            const curInputFileBlock = document.getElementById('ctn_img' + curIdx);
            const preInputFileBlock = document.getElementById('ctn_img' + preIdx);
            curInputFileBlock.id = 'ctn_img' + preIdx;
            preInputFileBlock.id = 'ctn_img' + curIdx;


            const curRmBtnBlock = document.getElementById('remove_btn' + curIdx);
            const preRmBtnBlock = document.getElementById('remove_btn'+ preIdx);
            curRmBtnBlock.id = 'remove_btn' + preIdx;
            preRmBtnBlock.id = 'remove_btn' + curIdx;

            table.insertBefore(curTr, preTr);

            checkArrowAble();

        }

        function moveDownTr(node) {
            checkDetection();
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


            const currentInputFileBlock = document.getElementById('ctn_img' + String(currentIdx));
            const nextInputFileBlock = document.getElementById('ctn_img' + String(nextIdx));
            currentInputFileBlock.id = 'ctn_img' + String(nextIdx);
            nextInputFileBlock.id = 'ctn_img' + String(currentIdx);


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
            i_up.setAttribute("name", "up_arrow");
            i_up.style.cursor = 'pointer';
            i_up.addEventListener('click', function () {moveUpTr(this)});


            const i_down = document.createElement('i');
            i_down.classList.add('bi', 'hoverBtn', 'bi-file-arrow-down');
            i_down.id = 'down_arrow' + String(my_index);
            i_down.setAttribute("name", "down_arrow");
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

            const feDiv = document.createElement('div');
            feDiv.style.display = "inline-block";
            feDiv.style.marginRight = "30px";
            feDiv.classList.add('fileInput');

            const imgDiv = document.createElement('div');
            imgDiv.id = 'ctn_image-show' + String(my_index);

            const defaultImg = document.createElement("img");
            defaultImg.id = 'defaultImg' + String(my_index);
            defaultImg.src = "https://icon-library.com/images/no-image-icon/no-image-icon-0.jpg";
            defaultImg.style.width = "100px";
            defaultImg.style.height = "100px";

            imgDiv.appendChild(defaultImg);

            feDiv.append(imgDiv);

            const div = document.createElement('div');
            div.style.display = "inline-block";

            const label = document.createElement('label');
            label.classList.add('file-input');
            label.for = 'ctn_img' + String(my_index);
            label.innerText = "찾기";

            const inputFile = document.createElement('input');
            inputFile.style.display = 'none';
            inputFile.setAttribute('type', 'file');
            inputFile.setAttribute('name', 'ctn_img');
            inputFile.setAttribute('id', 'ctn_img' + String(my_index));
            inputFile.setAttribute('accept', 'image/png, image/jpeg, image/gif');
            inputFile.addEventListener('change', function () {ctn_loadFile(this)});

            label.append(inputFile)
            div.append(label);
            newCell3.append(feDiv, div);

            newCell4.classList.add("bottom_td");
            const remove_btn = document.createElement('button')
            remove_btn.innerText = "삭제"
            remove_btn.classList.add("remove_btn");
            remove_btn.id = 'remove_btn' + String(my_index);
            remove_btn.name = "remove_btn";
            remove_btn.setAttribute('type', 'button');
            remove_btn.addEventListener('click', function () {removeRow(this)});
            newCell4.append(remove_btn)
        }


        function checkSave() {
            const contentName = document.getElementById("ctnNm");
            const reprImgLength = document.getElementsByClassName("reprImg").length;
            const ctnDetImgLength = document.getElementsByClassName("ctnDetImg").length;
            const inputUrl = document.getElementsByName("inputUrl")[0];
            const targetOption = document.getElementById("srcCd");
            const tbody = document.getElementById('tbody');

            const dspStDtTime = document.getElementById("dspStDt").value;
            const dspEndDtTime = document.getElementById("dspEndDt").value;
            const currentDateTime = getCurrentDate();


            const dspStDt = dspStDtTime.substr(0, 10);
            const dspEndDt = dspEndDtTime.substr(0, 10);

            const currentDate = currentDateTime.substr(0, 10);


            if (contentName.value === "") {
                alert("콘텐츠명을 작성해주세요.");
                return false;
            }

            if (document.getElementById("dspStDt").getAttribute("disabled") === "disabled") {
                if (dspStDt >= dspEndDt || currentDateTime > dspEndDtTime) {
                    alert("전시기간이 잘못 설정되었습니다.");
                    return false;
                }
            } else {
                if (dspStDtTime < currentDateTime || dspStDt >= dspEndDt) {
                    alert("전시기간이 잘못 설정되었습니다.");
                    return false;
                }
            }



            if (targetOption.options[targetOption.selectedIndex].text === "전체") {
                alert("콘텐츠 출처가 선택되지 않았습니다.");
                return false;
            }

            if (reprImgLength === 0) {
                alert("대표 이미지가 등록 되어있지 않습니다.");
                return false;
            }



            if ("${tplCd}" === 'T0001') {
                if (document.getElementById('tr1') === null) {
                    alert("콘텐츠 본문내용이 존재하지 않습니다.");
                    return false;
                }

                if (tbody.childElementCount !== ctnDetImgLength) {
                    alert("콘텐츠 본문내용의 이미지가 등록 되어있지 않습니다.");
                    return false;
                }

                if (ctnDetImgLength === 0) {
                    alert("콘텐츠 본문내용의 이미지가 등록 되어있지 않습니다.");
                    return false;
                }
            } else if ("${tplCd}" === 'T0002') {
                if (inputUrl.value === '') {
                    alert("콘텐츠 본문내용이 존재하지 않습니다.");
                    return false;
                } else if (inputUrl.value !== '') {
                    if (inputUrl.value.substring(0, 7) !== 'http://' && inputUrl.value.substring(0, 8) !== 'https://') {
                        alert("URL 주소 형식은 http:// 또는 https://로 시작되야합니다");
                        return false;
                    }
                }
            }


            if (!confirm("저장하시겠습니까?")) {
                return false;
            }
        }


        function showList() {
            if (Detection === true) {
                if (!confirm("변경된 내용이 있습니다. 취소하시겠습니까?")) {
                    return false;
                } else {
                    location.href = '/content/search';
                }
            } else {
                location.href = '/content/search';
            }
        }


        function checkRemove() {
            if (!confirm("해당 콘텐츠를 삭제하시겠습니까?")) {
                return false;
            } else {
                $(document).ready(function () {
                    $.ajax({
                        url:'/content/delete',
                        method: "post",
                        data: {"ctnSeq" : "${content.ctnSeq}"},
                        sync: false
                    });
                });
                location.href = '/content/search';
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
            <div class="no_border_head">
                <span class="tab_span flSpan">콘텐츠 조회/수정</span>
                <div class="d-flex justify-content-end flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary" onClick="location.href='/temp/detail'" style="visibility: hidden">DetailPage</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Form Table 영역 // -->
            <form action="/content/update/${content.ctnSeq}" method="post" id="updateForm" enctype="multipart/form-data" style="display: inline">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap pt-3">
                    <table class="table table-sm search-table">
                        <tbody>
                        <colgroup>
                            <col width="7%">
                            <col width="18%">
                            <col width="7%">
                            <col width="18%">
                            <col width="7">
                            <col width="18%">
                            <col width="8%">
                            <col width="17%">
                        </colgroup>
                            <th style="text-align: center">콘텐츠명</th>
                            <td colspan="3">
                                <input type="text" class="form-control" name="ctnNm" id="ctnNm" value="${content.ctnNm}" maxlength="50" onchange="checkDetection()">
                            </td>
                            <th style="text-align: center">콘텐츠 구분</th>
                            <td colspan="3">
                                <div>
                                    <c:if test="${content.ctnDiv eq 'IN'}">
                                        <input class="form-check-input" type="radio" name="ctnDiv" id="inside" value="IN" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.ctnDiv ne 'IN'}">
                                        <input class="form-check-input" type="radio" name="ctnDiv" id="inside" value="IN" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="inside">
                                        내부
                                    </label>
                                    <c:if test="${content.ctnDiv eq 'OUT'}">
                                        <input class="form-check-input" type="radio" name="ctnDiv" id="outside" value="OUT" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.ctnDiv ne 'OUT'}">
                                        <input class="form-check-input" type="radio" name="ctnDiv" id="outside" value="OUT" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="outside">
                                        외부
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align: center">템플릿 유형</th>
                            <td>${tplNm}</td>
                            <th style="text-align: center">화면코드</th>
                            <td>${ctnSeq}</td>
                            <th></th>
                            <td colspan="3"></td>
                        </tr>
                        <tr>
                            <th style="text-align: center">전시 기간</th>
                            <td colspan="3">
                                <input type="text" class="datepicker" name="dspStDt" id="dspStDt">
                                <button type="button" id="stToggle" class="input-group-text" style="display: inline-block;  background-color: transparent; border:0 ;background-image: url(http://jqueryui.com/resources/demos/datepicker/images/calendar.gif); background-repeat: no-repeat; background-size: 23px 25px; width: 23px; height: 25px;"></button>
                                ~
                                <input type="text" class="datepicker" name="dspEndDt" id="dspEndDt" onchange="checkDetection()">
                                <button type="button" id="endToggle" class="input-group-text" style="display: inline-block; background-color: transparent; border:0; background-image: url(http://jqueryui.com/resources/demos/datepicker/images/calendar.gif); background-repeat: no-repeat; background-size: 23px 25px; width: 23px; height: 25px;"></button>
                            </td>
                            <th style="text-align: center">전시 상태</th>
                            <td>
                                <div>
                                    <c:if test="${content.dspYn eq 'Y'}">
                                        <input class="form-check-input" type="radio" name="dspYn" id="display" value="Y" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.dspYn ne 'Y'}">
                                        <input class="form-check-input" type="radio" name="dspYn" id="display" value="Y" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="display">
                                        전시
                                    </label>
                                    <c:if test="${content.dspYn eq 'N'}">
                                        <input class="form-check-input" type="radio" name="dspYn" id="not_display" value="N" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.dspYn ne 'N'}">
                                        <input class="form-check-input" type="radio" name="dspYn" id="not_display" value="N" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="not_display">
                                        전시안함
                                    </label>
                                </div>
                            </td>
                            <th style="text-align: center">댓글가능 여부</th>
                            <td>
                                <div>
                                    <c:if test="${content.cmtYn eq 'Y'}">
                                        <input class="form-check-input" type="radio" name="cmtYn" id="yes" value="Y" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.cmtYn ne 'Y'}">
                                        <input class="form-check-input" type="radio" name="cmtYn" id="yes" value="Y" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="yes">
                                        가능
                                    </label>
                                    <c:if test="${content.cmtYn eq 'N'}">
                                        <input class="form-check-input" type="radio" name="cmtYn" id="no" value="N" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.cmtYn ne 'N'}">
                                        <input class="form-check-input" type="radio" name="cmtYn" id="no" value="N" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="no">
                                        불가능
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td colspan="3"></td>
                            <th style="text-align: center">콘텐츠 출처</th>
                            <td colspan="3">
                                <select class="form-select w130" style="margin-left:3px; margin-right:3px; display: inline-block;" name="srcCd" id="srcCd">
                                    <option selected value="${content.srcCd}" onchange="checkDetection()">${srcNm}</option>
                                    <c:forEach var="item" items="${srcList}">
                                        <option value="${item.cd}">${item.cd_nm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2" style="text-align: center">대표이미지</th>
                            <td rowspan="2" colspan="3">
                                <div class="fileInput" style="display: inline-block; margin-right: 30px;">
                                    <div class="image-show" id="image-show"></div>
                                    <img class="reprImg" src="/image/${reprImg.encFeNm}.${reprImg.feExt}">
                                </div>
                                <div style="display: inline-block;">
                                    <label class="file-input" for="repr_img">
                                        찾기
                                        <input type="file" name="repr_img" id="repr_img" accept="image/png, image/jpeg, image/gif"  onchange="loadFile(this)" style="display: none;">
                                    </label>
                                </div>
                            </td>
                            <th style="text-align: center">상담하기</th>
                            <td colspan="3">
                                <div>
                                    <c:if test="${content.cstYn eq 'Y'}">
                                        <input class="form-check-input" type="radio" name="cstYn" id="not_use" value="Y" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.cstYn ne 'Y'}">
                                        <input class="form-check-input" type="radio" name="cstYn" id="not_use" value="N" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="not_use">
                                        미사용
                                    </label>
                                    <c:if test="${content.cstYn eq 'N'}">
                                        <input class="form-check-input" type="radio" name="cstYn" id="use" value="N" checked onchange="checkDetection()">
                                    </c:if>
                                    <c:if test="${content.cstYn ne 'N'}">
                                        <input class="form-check-input" type="radio" name="cstYn" id="use" value="N" onchange="checkDetection()">
                                    </c:if>
                                    <label class="form-check-label" for="use">
                                        사용
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align: center">팝업문구</th>
                            <td colspan="3">
                                <input type="text" class="form-control" name="popMsg" id="popMsg" value="${content.popMsg}" placeholder="25자 이내로 작성해 주세요" maxlength="25" onchange="checkDetection()">
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2" style="text-align: center">대표이미지 개별등록</th>
                            <td colspan="7">
                                <div style="width: 500px; height: 500px; float: left; margin-left: 30px;">
                                    <span style="margin-left: 170px; font-weight: bold">[빅 사이즈]</span><br><br>
                                    <img class="bigImg" src="/image/${bigImg.encFeNm}.${bigImg.feExt}">
                                </div>
                                <div style="width: 500px; height: 500px; float: left">
                                    <span style="margin-left: 65px; font-weight: bold">[작은 이미지형 및 연관 게시물 썸네일]</span><br><br>
                                    <img class="smallImg" src="/image/${smallImg.encFeNm}.${smallImg.feExt}">
                                </div>

                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><br><br><br>
            </form>
            <br><br><br><br>
            <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                <div class="btn-toolbar mb-2">
                    <div class="btn-group">
                        <button type="button" class="btn btn-secondary" onclick="showList();" style="margin-right: 400px;">목록</button>
                        <button type="submit" class="btn btn-primary" id="btn_submit" form="updateForm" onclick="return checkSave();">수정</button>
                        <button type="button" class="btn btn-secondary" onclick="return checkRemove();" style="margin-left: 400px;float: right">삭제</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
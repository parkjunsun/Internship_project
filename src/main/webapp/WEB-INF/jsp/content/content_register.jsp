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

            return year + '-' + month + '-' + day + ' ' + hour + ':' + minutes
        }


        $(function () {
            jQuery.datetimepicker.setLocale('kr');

            $('#dspStDt').datetimepicker({
                format: 'Y-m-d H:i',
                // defaultDate: moment(getCurrentDate()).subtract(7, 'days').format("YYYY-MM-DD HH:mm"),
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
                // defaultDate: moment(getCurrentDate()).format("YYYY-MM-DD HH:mm"),
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


            $('#dspStDt').val("시작일");
            $('#dspEndDt').val("종료일");

            $('#stToggle').on('click', function () {
                $('#dspStDt').datetimepicker('toggle');
            })

            $('#endToggle').on('click', function () {
                $('#dspEndDt').datetimepicker('toggle');
            })

        });


        function loadFile(input) {

            const file = input.files[0];	//선택된 파일 가져오기

            const fileName = file.name;
            const extension = fileName.substring(fileName.lastIndexOf('.') + 1);


            if (input.files && file) {
                if ($.inArray(extension, ['png', 'jpg', 'gif']) == -1) {
                    alert("이미지 포맷이 맞지 않습니다.");
                    return;
                }

                const reader = new FileReader();
                reader.onload = e => {
                    var img = new Image();
                    img.src = e.target.result;
                    img.onload = function () {
                        var w = this.width;
                        var h = this.height;
                        if (w === 750 && h === 420) {
                            if (document.getElementById("defaultImg") != null) {
                                const defaultImg = document.getElementById("defaultImg");
                                defaultImg.style.display = 'none';
                            }

                            const newImage = document.createElement("img");
                            newImage.setAttribute("class", 'reprImg');

                            //이미지 source 가져오기
                            newImage.src = URL.createObjectURL(file);

                            newImage.style.width = "150px";
                            newImage.style.height = "150px";
                            newImage.style.visibility = "visible";
                            newImage.style.objectFit = "contain";

                            const container = document.getElementById('image-show');
                            if (container.querySelector('.reprImg') != null) {
                                const oldImage = container.querySelector('.reprImg');
                                container.removeChild(oldImage);
                            }
                            container.appendChild(newImage);
                        } else {
                            alert("이미지 사이즈가 맞지 않습니다.");
                            return false;
                        }
                    }
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function ctn_loadFile(input) {
            const cur = input.id[input.id.length-1];

            var file = input.files[0];
            const fileName = file.name;
            const extension = fileName.substring(fileName.lastIndexOf('.') + 1);

            if (input.files && file) {
                if ($.inArray(extension, ['png', 'jpg', 'gif']) == -1) {
                    alert("이미지 포맷이 맞지 않습니다.");
                    return;
                }
                const reader = new FileReader();
                reader.onload = e => {
                    var img = new Image();
                    img.src = e.target.result;
                    img.onload = function () {
                        var w = this.width;
                        var h = this.height;
                        if (w === 750 && h === 1500) {
                            if (document.getElementById("defaultImg" + cur)) {
                                var defaultImg = document.getElementById("defaultImg" + cur);
                                defaultImg.style.display = 'none';
                            }

                            var newImage = document.createElement("img");
                            newImage.setAttribute("class", "ctnDetImg");

                            newImage.src = URL.createObjectURL(file);

                            newImage.style.width = "200px";
                            newImage.style.height = "200px";
                            newImage.style.visibility = "visible";
                            newImage.style.objectFit = "contain";

                            var container = document.getElementById('ctn_image-show' + cur);
                            if (container.querySelector('.ctnDetImg') != null) {
                                const oldImage = container.querySelector('.ctnDetImg');
                                container.removeChild(oldImage);
                            }
                            container.appendChild(newImage);
                        } else {
                            alert("이미지 사이즈가 맞지 않습니다.");
                            return false;
                        }
                    }
                }
                reader.readAsDataURL(input.files[0]);
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


                var inputFile = document.getElementById('ctn_img' + String(i));
                inputFile.id = 'ctn_img' + String(i - 1);

                var defaultImage = document.getElementById('defaultImg' + String(i));
                defaultImage.id = 'defaultImg' + String(i - 1);

                var removeBtn = document.getElementById('remove_btn' + String(i));
                removeBtn.id = 'remove_btn' + String(i - 1)
            }

            ctn_index -= 1;

            document.getElementById('down_arrow' + String(ctn_index)).classList.add('disabled');
            document.getElementById('down_arrow' + String(ctn_index)).style.cursor = 'default';

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


            const curInputFileBlock = document.getElementById('ctn_img' + curIdx);
            const preInputFileBlock = document.getElementById('ctn_img' + preIdx);
            curInputFileBlock.id = 'ctn_img' + preIdx;
            preInputFileBlock.id = 'ctn_img' + curIdx;

            const curDefaultImageBlock = document.getElementById('defaultImg' + curIdx);
            const preDefaultImageBlock = document.getElementById('defaultImg' + preIdx);
            curDefaultImageBlock.id = 'defaultImg' + preIdx;
            preDefaultImageBlock.id = 'defaultImg' + curIdx;


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


            const currentInputFileBlock = document.getElementById('ctn_img' + String(currentIdx));
            const nextInputFileBlock = document.getElementById('ctn_img' + String(nextIdx));
            currentInputFileBlock.id = 'ctn_img' + String(nextIdx);
            nextInputFileBlock.id = 'ctn_img' + String(currentIdx);

            const currentDefaultImageBlock = document.getElementById('defaultImg' + String(currentIdx));
            const nextDefaultImageBlock = document.getElementById('defaultImg' + String(nextIdx));
            currentDefaultImageBlock.id = 'defaultImg' + String(nextIdx);
            nextDefaultImageBlock.id = 'defaultImg' + String(currentIdx);


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

            const imgSizeDiv = document.createElement('div');
            imgSizeDiv.style.marginLeft = '12px';
            imgSizeDiv.style.color = '#dc3545';
            imgSizeDiv.innerText = '가로: 750px 세로: 1500px';

            label.append(inputFile)
            div.append(label);
            newCell3.append(feDiv, div, imgSizeDiv);

            newCell4.classList.add("bottom_td");
            const remove_btn = document.createElement('button')
            remove_btn.innerText = "삭제"
            remove_btn.classList.add("remove_btn");
            remove_btn.id = 'remove_btn' + String(my_index);
            remove_btn.setAttribute('type', 'button');
            remove_btn.addEventListener('click', function () {removeRow(this)});
            newCell4.append(remove_btn)
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
            input.name = 'inputUrl';

            td.appendChild(input);

            tr.appendChild(th);
            tr.appendChild(td);

            tbody.appendChild(tr);

            table.appendChild(colgroup);
            table.appendChild(tbody);

            rootDiv.appendChild(div);
            rootDiv.appendChild(table);

            const form = document.getElementById('registerForm');
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

            const form = document.getElementById('registerForm');
            form.appendChild(rootDiv);
        }

         function changeMenu(e) {

            if (e.id === "tplCd1") {
                const cardDiv = document.getElementById('cardDiv');
                cardDiv.remove();
                addUrlRow();
                ctn_index = 0;

            } else {
                const urlDiv = document.getElementById('urlDiv');
                urlDiv.remove();
                addCardHead();
                ctn_index = 0;

            }
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

            var re = /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]/;
            if (!re.test(dspStDtTime) || !re.test(dspEndDtTime)) {
                alert("전시날짜를 선택해주세요.");
                return false;
            }


            if (dspStDtTime < currentDateTime || dspStDtTime >= dspEndDtTime) {
                 alert("전시기간이 잘못 설정되었습니다.");
                 return false;
            }


            if (targetOption.options[targetOption.selectedIndex].text === "전체") {
                alert("콘텐츠 출처가 선택되지 않았습니다.");
                return false;
            }

            if (reprImgLength === 0) {
                alert("대표 이미지가 등록 되어있지 않습니다.");
                return false;
            }

            if (document.getElementById('tplCd0').checked === true && document.getElementById('tr1') === null) {
                alert("콘텐츠 본문내용이 존재하지 않습니다.");
                return false;
            }


            if (document.getElementById('tplCd0').checked === true && tbody.childElementCount !== ctnDetImgLength) {
                alert("콘텐츠 본문내용의 이미지가 등록 되어있지 않습니다.");
                return false;
            }


            if (document.getElementById('tplCd0').checked === true && ctnDetImgLength === 0) {
                 alert("콘텐츠 본문내용의 이미지가 등록 되어있지 않습니다.");
                 return false;
            }

            if (document.getElementById('tplCd1').checked === true && inputUrl.value === ''){
                alert("콘텐츠 본문내용이 존재하지 않습니다.");
                return false;
            }
            if (document.getElementById('tplCd1').checked === true && inputUrl.value !== '') {
                if (inputUrl.value.substring(0, 7) !== 'http://' && inputUrl.value.substring(0, 8) !== 'https://') {
                    alert("URL 주소 형식은 http:// 또는 https://로 시작되야합니다");
                    return false;
                }
            }

            if (!confirm("저장하시겠습니까?")) {
                return false;
            }
         }


         function checkCancel() {
            if (!confirm("등록을 취소하시겠습니까?")) {
                return false;
            } else {
                location.href = '/';
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
                <span class="tab_span flSpan">콘텐츠 등록</span>
                <div class="d-flex justify-content-end flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary" onClick="location.href='/temp/detail'" style="visibility: hidden">DetailPage</button>
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
                            <th style="text-align: center">콘텐츠명</th>
                            <td>
                                <input type="text" class="form-control" name="ctnNm" id="ctnNm" maxlength="50">
                            </td>
                            <th style="text-align: center">콘텐츠 구분</th>
                            <td colspan="3">
                                <div>
                                    <input class="form-check-input" type="radio" name="ctnDiv" id="inside" value="IN" checked>
                                    <label class="form-check-label" for="inside">
                                        내부
                                    </label>
                                    <input class="form-check-input" type="radio" name="ctnDiv" id="outside" value="OUT">
                                    <label class="form-check-label" for="outside">
                                        외부
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align: center">템플릿 유형</th>
                            <td>
                                <div>
                                    <c:forEach var="item" items="${tplList}" varStatus="status">
                                        <input class="form-check-input" type="radio" name="tplCd" id="tplCd${status.index}" value="${item.cd}" onclick="changeMenu(this)">
                                        <label class="form-check-label" for="tplCd${status.index}">
                                            ${item.cd_nm}
                                        </label>
                                    </c:forEach>
                                </div>
                            </td>
                            <th ></th>
                            <td colspan="3"></td>
                        </tr>
                        <tr>
                            <th style="text-align: center">전시 기간</th>
                            <td>
                                <input type="text" class="datepicker" name="dspStDt" id="dspStDt">
                                <button type="button" id="stToggle" class="input-group-text" style="display: inline-block;  background-color: transparent; border:0 ;background-image: url(http://jqueryui.com/resources/demos/datepicker/images/calendar.gif); background-repeat: no-repeat; background-size: 23px 25px; width: 23px; height: 25px;"></button>
                                ~
                                <input type="text" class="datepicker" name="dspEndDt" id="dspEndDt">
                                <button type="button" id="endToggle" class="input-group-text" style="display: inline-block; background-color: transparent; border:0; background-image: url(http://jqueryui.com/resources/demos/datepicker/images/calendar.gif); background-repeat: no-repeat; background-size: 23px 25px; width: 23px; height: 25px;"></button>
                            </td>
                            <th style="text-align: center">전시 상태</th>
                            <td>
                                <div>
                                    <input class="form-check-input" type="radio" name="dspYn" id="display" value="Y" checked>
                                    <label class="form-check-label" for="display">
                                        전시
                                    </label>
                                    <input class="form-check-input" type="radio" name="dspYn" id="not_display" value="N">
                                    <label class="form-check-label" for="not_display">
                                        전시안함
                                    </label>
                                </div>
                            </td>
                            <th style="text-align: center">댓글가능 여부</th>
                            <td>
                                <div>
                                    <input class="form-check-input" type="radio" name="cmtYn" id="yes" value="Y" checked>
                                    <label class="form-check-label" for="yes">
                                        가능
                                    </label>
                                    <input class="form-check-input" type="radio" name="cmtYn" id="no" value="N">
                                    <label class="form-check-label" for="no">
                                        불가능
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td></td>
                            <th style="text-align: center">콘텐츠 출처</th>
                            <td colspan="3">
                                <select class="form-select w130" style="margin-left:3px; margin-right:3px; display: inline-block;" name="srcCd" id="srcCd">
                                    <option selected>전체</option>
                                    <c:forEach var="item" items="${srcList}">
                                        <option value="${item.cd}">${item.cd_nm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2" style="text-align: center">대표이미지</th>
                            <td rowspan="2">
                                <div class="fileInput" style="display: inline-block; margin-right: 30px;">
                                    <div class="image-show" id="image-show">
                                        <img src="https://icon-library.com/images/no-image-icon/no-image-icon-0.jpg" name="defaultImg" id="defaultImg" style="width: 100px;height: 100px;">
                                    </div>
                                </div>
                                <div style="display: inline-block;">
                                    <label class="file-input" for="repr_img">
                                        찾기
                                        <input type="file" name="repr_img" id="repr_img"  accept=".gif, .jpg, .png" onchange="return loadFile(this)" style="display: none;">
                                    </label>
                                </div>
                                <div style="margin-left: 12px; color:#dc3545">
                                    가로: 750px, 세로: 420px
                                </div>
                            </td>
                            <th style="text-align: center">상담하기</th>
                            <td colspan="3">
                                <div>
                                    <input class="form-check-input" type="radio" name="cstYn" id="not_use" value="Y" checked>
                                    <label class="form-check-label" for="not_use">
                                        미사용
                                    </label>
                                    <input class="form-check-input" type="radio" name="cstYn" id="use" value="N">
                                    <label class="form-check-label" for="use">
                                        사용
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align: center">팝업문구</th>
                            <td colspan="3">
                                <input type="text" class="form-control" name="popMsg" id="popMsg" placeholder="25자 이내로 작성해 주세요" maxlength="25">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div><br><br><br>
                <div class="table-responsive" id="cardDiv">
                    <div style="border: 1px solid black; height: 45px;">
                        <span style="float:left; margin-top: 11px; margin-left: 10px;">콘텐츠 본문내용</span>
                        <button type="button" style="float: right; height: 30px; margin-top: 6px; margin-right: 10px;" id="add_btn" onclick="addRow()">콘텐츠 추가</button>
                    </div>
                    <table class="table table-striped table-sm" id="extraContent">
                        <colgroup id="colgroup">
                            <col width="150px">
                            <col width="150px">
                            <col width="*">
                            <col width="150px">
                        </colgroup>
                            <thead id="thead">
                                <tr style="height: 45px;">
                                    <th scope="col" style="text-align: center;">본문</th>
                                    <th scope="col" style="text-align: center;">전시순서</th>
                                    <th scope="col" style="text-align: center">본문 이미지</th>
                                    <th scope="col" style="text-align: center;">영역 삭제</th>
                                </tr>
                            </thead>
                            <tbody id="tbody">
                            </tbody>
                    </table>
                </div>
            </form>
            <br><br><br><br>
            <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                <div class="btn-toolbar mb-2">
                    <div class="btn-group">
                        <button type="button" class="btn btn-secondary" onclick="return checkCancel();" style="margin-right: 20px;">취소</button>
                        <button type="submit" class="btn btn-primary" id="btn_submit" form="registerForm" style="margin-right: 100px;" onclick="return checkSave();">저장</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>


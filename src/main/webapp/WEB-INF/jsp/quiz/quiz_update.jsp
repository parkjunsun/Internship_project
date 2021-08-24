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
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js" integrity="sha512-LGXaggshOkD/at6PFNcp2V2unf9LzFq6LE+sChH7ceMTDP0g2kn6Vxwgg7wkPP7AAtX+lmPqPdxB47A0Nz0cMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />

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
        var originalCnt = 0;
        $(function(){
            quizCnt = document.getElementsByName("quizRow").length;
            originalCnt = quizCnt;
        });

        var quizTypes = new Array();
        <c:forEach items="${types}" var="type">
        var obj = {
            "quizNm" : "${type.quizNm}",
            "quizCd" : "${type.quizCd}"
        };
        quizTypes.push(obj);
        </c:forEach>

        $(function(){
            checkTD();
        });

        <%--console.log(quizTypes);--%>

        $(function() {

            $("#datetimepicker1").datetimepicker({
                locale: 'ko',
                format: 'YYYY-MM-DD HH:mm' //달력 날짜 형태
            });

            $("#datetimepicker1").on("change.datetimepicker", ({date, oldDate}) => {
                var start = new Date(document.getElementById("dspStDt").value);
                var end = new Date(document.getElementById("dspEndDt").value);
                var chkdate=Date.parse(start);
                if (isNaN(chkdate)==true) {
                    alert('날짜 형식이 맞지 않습니다 (YYYY-MM-DD HH:mm)');
                    $('#datetimepicker1').datetimepicker('date', end);
                }
                if (end - start < 0){
                    alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                    $('#datetimepicker1').datetimepicker('date', oldDate);
                }
            })

            $("#datetimepicker2").datetimepicker({
                locale: 'ko',
                format: 'YYYY-MM-DD HH:mm' //달력 날짜 형태
            });

            $("#datetimepicker2").on("change.datetimepicker", ({date, oldDate}) => {
                var start = new Date(document.getElementById("dspStDt").value);
                var end = new Date(document.getElementById("dspEndDt").value);
                var chkdate=Date.parse(end);
                if (isNaN(chkdate)==true) {
                    alert('날짜 형식이 맞지 않습니다 (YYYY-MM-DD HH:mm)');
                    $('#datetimepicker2').datetimepicker('date', start);
                }
                if (end - start < 0){
                    alert("전시 시작일이 미래인 콘텐츠는 전시설정을 할 수 없습니다.");
                    $('#datetimepicker2').datetimepicker('date', oldDate);
                }
            })


        });


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
            img.setAttribute("src", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXu7u67u7vv7++4uLjg4ODCwsLk5OS2trby8vLd3d2+vr7q6urKysrHx8fY2NjV1dXPz8/wKvVCAAAHpUlEQVR4nO2d67qjKgyGBeQg4uH+r3YHBHW12oLVms7O92M9M2tay9twSCBhqopEIpFIJBKJRCKRSCQSiUQikUgkEolEIpFIJBKJRCKRSCQSiUQikUgk0jfFUesMwBOecaU+b9+/T4hdRPj7IsLfFxH+vojw90WEv6+7Cbl5r88ChJsJedsxAWKCrWTXknJsP2nlvYS8/kO2IyF688FnnNfc/c/Yi0V5mwPoGfvj7byckPN2VvWAabo8QEBsjzfgU4I3MkMYZ1FS/f28TBMC4XC4oRcT8kE/2GL1gbzJJmTs8Ei8mvDRFuPqA43LBxTqaEuvJXyeSrqVLbjNJ2TuqBFvJOSqoJMycbgNp5DsPv0l4VBEeHTBuJHQyAJAxuTBbnojYe5yn4x4cEm8j7BorWAP03BJG06j2Xr4FmE6UDCujBCWxEPnE9cRcsPbun+kkHUT1PdNIR/4Nc2+VGt2UC4jNCrERc/tnFVKuHb/NmSHbZirCLnT75t8rgSrt6bbawg5l+Um+ly62QrRriEc7wB8cOyvJMyObE8n7J776TWEN5kQ+ulGY64gNCVBw6na8F6vGYd3mZCx8ambXkH4yTA8ulYmPQ/ESwiLAr81ne3G3js8g5MHMZ8jEDSEQrim5cn1NKaqR3bgMWgJhe2rh917wKzL/QakhMI2m34zN6qUESehGHaDH24KQxCMhMKqV/sTvOpKnoaQUHRLG/wU4/8CE816W7XEQ8JHKJZ9UG6qZpQhqLSuX0W05imO/iHCBRBmFbdaAoWWzTw6CxCxES6xgGmfhpuwdbKjyd5axUZo08c/nuCkLyC1L3vbChlhClh5tbPsCZZC2twzDlyE6fCaV3b3DenMKfeZuAjlDPjqa4iImWsGKsLZPK/PL0Rq4+8Rxnn0rXGSqbPmU0yE0YTvXzyf4Wc8FBVhbEvGGVs8HM0aiYgI455RzgmUmDZfsjZHMBFOx4FZx6TJiBlrIiJCmW+X2d4Z3RQPoRhCU4pWuZwsOESEdfjkzL3j5N79FOHU5sydVdHkfh+ICKeRlZV9Ofdp/j7TDw+hnZqcGdrGQDlj1OIhjHNHbmSb/XI8hJNTmn0M978hfN+p8RDKf96GheMw2+R4CKec39zMr5jxlZFyi4dQ5H8XbHZMM9x0RIQq1w9bvdq8fyUiwuiHZdYjTM9t3+dZ4SGMeduZTo3LHrWICNN2d1Z8WOdONJgI09DKqUiwcbct46WYCKcFICfIj2M2KxBBRBjjp4J4IWtWQkUYE7Te9r20sZoVLWMiTHMNV6/XgBj9ZtYQoSJMe9mvT3jTIeq7LwIjIZsOB/nLoShkOkDMqz/BRTifce8jiq7wnBsX4XxEWpkdb0WkZMrsRyIjXKoKebtxzi1YyiXiWedOGAmX1HNuGvs331KwJRkscxBiJGRzKkJIqJlq88PPbkmnKQDESLgg+qSvthlGUK+qJSVqN1PjVwhFs+R9VdVzoRZvCx6GktD74C8qz0qS2rAShoKl7XaUp9DiJPSei9pg5KYtrlHESugZ/yZ6+0zTuivP18dL6JcIOSifre9vpKlUfwAPOWGAFMxK0GZtJiLC0irtM/Wdmplb656+U9lVeJfAiRLPVaTX1B8W3Qdxpr5Vf3hfDenGDSjXjMP8zPOTCb9VB+z3Nu9AjLv/XyG8oxRYsM17iK4irMCnfHMJwsmS/XaIchmhL15qVf0trUPmbxFW1Vdva99vxJWEp+um1mZ+ySbuUVTGhD9Mt1ou/2x8v56fVvkAI/1+fkl8y3Ip5ge2Pf1rUKxJ5RXOw9ROMjm2aYVumeOVlcvrZTi75/VcjGAaZ+EdteENi1mYX2t9jiCiisuxsR2Yp9PMjZ3QyVNuNXAvhQfg94V8FFhXdVgDeGu1daNjWvJGjNMUdgvJnnzMKBdCqQff2yqXECfCxSmZMm7A/RtDmgJvvVPtu/rgTKMH890emCMgdDp4jZ5w0DEl1nSTiSZC4dicSDpqmFf4oFvny4LAlnHTEcCAEBdcEFe6HrU/9vWEjKUmKt2tCIchAHvT9YHQSlPDu+Dd60vC0BJy609igLBdFcdG2Ilw5GFiMWC3AQi5pzPwK97r5dISnnrpLSC7AsLGtMJCx7SdmicYmDOnkC4Sml433mKD8YTQN/2ko5UZ9eRU+ypvmGmkAyEzpCf0I6gzLwk5lxbAmOfyWV7O+DvfRhiXgZB3UkrViG4AfXDz7hUKhBBxgHWgly6j6rGX+o6p/MgDQj8hwbKgpOD9dMkVb/pRK7y91E8zUiuYaaxYfj0NyUTos2akNcGGqbzCCoCO1V3QDRTamcYT8kpYIOyhwcEm0EnVHxv6runHnCcEc07OGcw1MpaSoicMqVuw4nd6DNcOdnFhXAiBzYWfmrtU3wY9U4EvE1zSZumluDAToR9cXRiQWnZSz+XcC+F0JbZf61epNKOBb6ZvWzWA29No1wfdBbMprtJN18Z5DqOGrnP9vHPUSuh53WrR62Uz343NXQdT6mi1FnKAbtBNko8fcq/4HINPvYuHG5OWkM//8zpMj/HW6i0xBuPL/zbwpaaTSCQSiUQikUgkEolEIpFIJBKJRCKRSCQSiUQikUgkEolEIpH+6D/+pF/9/+I9DwAAAABJRU5ErkJggg==");
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
            abUpperTable.setAttribute("id", "abUpperTable_"+String(quizCnt-1));
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
            td.setAttribute("id", "comTd_"+String(quizCnt-1));
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
            abLowerTable.setAttribute("id", "abLowerTable_"+String(quizCnt-1));
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
            td.setAttribute("id","imageAtd_"+String(quizCnt-1));
            var div = document.createElement("div");
            var img = document.createElement("img");
            img.setAttribute("style", "margin:6px");
            img.setAttribute("src", "data:image/png;base64,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");
            img.setAttribute("id","preview_A_"+String(quizCnt-1))
            var label = document.createElement("label");
            // label.setAttribute("for", "image_A_"+String(quizCnt-1));
            label.setAttribute("class", "btn btn-dark");
            label.setAttribute("id", "labelA_"+String(quizCnt-1));
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
            td.setAttribute("id","imageBtd_"+String(quizCnt-1));
            var div = document.createElement("div");
            var img = document.createElement("img");
            img.setAttribute("style", "margin:6px");
            img.setAttribute("src", "data:image/png;base64,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");
            img.setAttribute("id","preview_B_"+String(quizCnt-1))
            var label = document.createElement("label");
            // label.setAttribute("for", "image_B_"+String(quizCnt-1));
            label.setAttribute("class", "btn btn-dark");
            label.setAttribute("id", "labelB_"+String(quizCnt-1));
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
            var quizId = input.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id;
            var type = input.value;
            var upperTable = document.getElementById("upperTable_" + quizId);
            var lowerTable = document.getElementById("lowerTable_" + quizId);
            var quizRow = upperTable.parentNode;
            // OX형
            if(type == "Q0001"){
                var oxUpperTable = document.createElement("table");
                oxUpperTable.setAttribute("class", "table table-sm search-table");
                oxUpperTable.setAttribute("id", upperTable.id);
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
                select.setAttribute("name", "searchType_" + quizId);
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
                input.setAttribute("name", "quizQuestion_"+quizId);
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
                img.setAttribute("id","preview_"+quizId)
                var label = document.createElement("label");
                label.setAttribute("for", "image_"+quizId);
                label.setAttribute("class", "btn btn-dark");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizMainImage");
                input.setAttribute("id", "image_" + quizId);
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
                input.setAttribute("name", "ansYn_"+quizId);
                input.setAttribute("id", "ansY_"+quizId);
                input.setAttribute("value", "Y");
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansY_" + quizId);
                var span_1 = document.createElement("span");
                span_1.innerText="사용 (정답 : ";
                var span_2 = document.createElement("span");
                var ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("onchange", "checkInt(this)");
                ansInput.setAttribute("name", "ansClov_"+quizId);
                ansInput.setAttribute("disabled", "disabled");
                ansInput.setAttribute("id", "ansY_corY_clov_" + quizId);
                span_2.appendChild(ansInput);
                var span_3 = document.createElement("span");
                span_3.innerText="C,   오답 : ";
                var wrngInput = document.createElement("input");
                wrngInput.setAttribute("type", "text");
                wrngInput.setAttribute("size", "12");
                wrngInput.setAttribute("maxlength", "15");
                wrngInput.setAttribute("onchange", "checkInt(this)");
                wrngInput.setAttribute("name", "wngClov_"+quizId);
                wrngInput.setAttribute("disabled", "disabled");
                wrngInput.setAttribute("id", "ansY_corN_clov_" + quizId);
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
                input.setAttribute("name", "ansYn_"+quizId);
                input.setAttribute("id", "ansN_"+quizId);
                input.setAttribute("value", "N");
                input.setAttribute("checked", "checked");
                input.setAttribute("style", "margin-left: 30px");

                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansN_" + quizId);
                span_1 = document.createElement("span");
                span_1.innerText="미사용 (";
                span_2 = document.createElement("span");
                ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("name", "ansN_clov_"+quizId);
                ansInput.setAttribute("id", "ansN_clov_"+quizId);
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
                td.setAttribute("id", "comTd_"+quizId);
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+quizId);
                input.setAttribute("id", "comY_"+quizId);
                input.setAttribute("value", "Y");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comY_" + quizId);
                label.innerText="사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+quizId);
                input.setAttribute("id", "comN_"+quizId);
                input.setAttribute("value", "N");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comN_" + quizId);
                label.innerText="미사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("size", "100");
                input.setAttribute("name", "comment_"+quizId);
                input.setAttribute("disabled", "disabled");
                input.setAttribute("id", "comment_"+(quizId));
                td.appendChild(input);

                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                oxUpperTable.appendChild(tbody);

                var oxLowerTable = document.createElement("table");
                oxLowerTable.setAttribute("class", "table table-sm search-table");
                oxLowerTable.setAttribute("id", lowerTable.id);
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
                input.setAttribute("name", "corOX_"+quizId);
                input.setAttribute("id", "corO_"+quizId);
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
                input.setAttribute("name", "corOX_"+quizId);
                input.setAttribute("id", "corX_"+quizId);
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
                abUpperTable.setAttribute("id", upperTable.id);
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
                select.setAttribute("name", "searchType_"+quizId);
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
                input.setAttribute("name", "quizQuestion_"+quizId);
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
                img.setAttribute("id","preview_"+quizId)
                var label = document.createElement("label");
                label.setAttribute("for", "image_"+quizId);
                label.setAttribute("class", "btn btn-dark");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizMainImage");
                input.setAttribute("id", "image_" + quizId);
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
                input.setAttribute("name", "ansYn_"+quizId);
                input.setAttribute("id", "ansY_"+quizId);
                input.setAttribute("value", "Y");
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansY_" + quizId);
                var span_1 = document.createElement("span");
                span_1.innerText="사용 (정답 : ";
                var span_2 = document.createElement("span");
                var ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("onchange", "checkInt(this)");
                ansInput.setAttribute("name", "ansClov_"+quizId);
                ansInput.setAttribute("disabled", "disabled");
                ansInput.setAttribute("id", "ansY_corY_clov_" + quizId);
                span_2.appendChild(ansInput);
                var span_3 = document.createElement("span");
                span_3.innerText="C,   오답 : ";
                var wrngInput = document.createElement("input");
                wrngInput.setAttribute("type", "text");
                wrngInput.setAttribute("size", "12");
                wrngInput.setAttribute("maxlength", "15");
                wrngInput.setAttribute("onchange", "checkInt(this)");
                wrngInput.setAttribute("name", "wngClov_"+quizId);
                wrngInput.setAttribute("disabled", "disabled");
                wrngInput.setAttribute("id", "ansY_corN_clov_" + quizId);
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
                input.setAttribute("name", "ansYn_"+quizId);
                input.setAttribute("id", "ansN_"+quizId);
                input.setAttribute("value", "N");
                input.setAttribute("checked", "checked");
                input.setAttribute("style", "margin-left: 30px");

                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "ansN_" + quizId);
                span_1 = document.createElement("span");
                span_1.innerText="미사용 (";
                span_2 = document.createElement("span");
                ansInput = document.createElement("input");
                ansInput.setAttribute("type", "text");
                ansInput.setAttribute("size", "12");
                ansInput.setAttribute("maxlength", "15");
                ansInput.setAttribute("onchange", "checkInt(this)");
                ansInput.setAttribute("name", "ansN_clov_"+quizId);
                ansInput.setAttribute("id", "ansN_clov_"+(quizId));
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
                input.setAttribute("name", "imgYn_"+quizId);
                input.setAttribute("id", "imgY_"+quizId);
                input.setAttribute("value", "Y");
                input.setAttribute("onclick", "imageYnConfig(this)");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "imgY_" + quizId);
                label.innerText="사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "imgYn_"+quizId);
                input.setAttribute("id", "imgN_"+quizId);
                input.setAttribute("value", "N");
                input.setAttribute("onclick", "imageYnConfig(this)");
                input.setAttribute("checked", "checked");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "imgN_" + quizId);
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
                td.setAttribute("id", "comTd_"+quizId);
                td.setAttribute("style","background-color: #ecedee");
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+quizId);
                input.setAttribute("id", "comY_"+quizId);
                input.setAttribute("value", "Y");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comY_" + quizId);
                label.innerText="사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("onclick","commentYnConfig(this)");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "comYn_"+quizId);
                input.setAttribute("id", "comN_"+quizId);
                input.setAttribute("value", "N");
                input.setAttribute("disabled", "disabled");
                td.appendChild(input);
                label = document.createElement("label");
                label.setAttribute("class", "form-check-label");
                label.setAttribute("for", "comN_" + quizId);
                label.innerText="미사용"
                td.appendChild(label);

                input = document.createElement("input");
                input.setAttribute("type", "text");
                input.setAttribute("size", "100");
                input.setAttribute("onchange", "checkText(this)");
                input.setAttribute("name", "comment");
                input.setAttribute("disabled", "disabled");
                input.setAttribute("id", "comment_"+(quizId));
                td.appendChild(input);

                tr.appendChild(th);
                tr.appendChild(td);
                tbody.appendChild(tr);

                abUpperTable.appendChild(tbody);

                var abLowerTable = document.createElement("table");
                abLowerTable.setAttribute("class", "table table-sm search-table");
                abLowerTable.setAttribute("id", lowerTable.id);
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
                input.setAttribute("name", "A_"+quizId);
                input.setAttribute("size", "80");
                input.setAttribute("maxlength", "80");
                td.appendChild(input);
                tr.appendChild(td);

                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                td.setAttribute("id","imageAtd_"+quizId);
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id","preview_A_"+quizId)
                var label = document.createElement("label");
                // label.setAttribute("for", "image_A_"+quizId);
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("id", "labelA_"+quizId);
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizABImage");
                input.setAttribute("id", "image_A_" + quizId);
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
                td.setAttribute("id","corAtd_"+quizId);
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "corAB_"+quizId);
                input.setAttribute("id", "corA_"+quizId);
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
                input.setAttribute("name", "B_"+quizId);
                input.setAttribute("maxlength", "80");
                td.appendChild(input);
                tr.appendChild(td);

                td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                td.setAttribute("id","imageBtd_"+quizId);
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id","preview_B_"+quizId)
                var label = document.createElement("label");
                // label.setAttribute("for", "image_B_"+quizId);
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("id", "labelB_"+quizId);
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("name", "quizABImage");
                input.setAttribute("id", "image_B_" + quizId);
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
                td.setAttribute("id","corBtd_"+quizId);
                td.setAttribute("id","corBtd_"+quizId);
                input = document.createElement("input");
                input.setAttribute("class", "form-check-input");
                input.setAttribute("type", "radio");
                input.setAttribute("name", "corAB_"+quizId);
                input.setAttribute("id", "corB_"+quizId);
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
                var up = udList[i].getElementsByTagName("button")[0];
                var down = udList[i].getElementsByTagName("button")[1];
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
            var id = input.id.split("_")[1];
            var ansYcorY = document.getElementById("ansY_corY_clov_" + id);
            var ansYcorN = document.getElementById("ansY_corN_clov_" + id);
            var ansN = document.getElementById("ansN_clov_" + id);
            var comTd = document.getElementById("comTd_" + id);
            var comY = document.getElementById("comY_"+id);
            var comN = document.getElementById("comN_"+id);
            var comment = document.getElementById("comment_" + id);
            var corA = document.getElementById("corA_" + id);
            var corAtd = document.getElementById("corAtd_" + id);
            var corB = document.getElementById("corB_" + id);
            var corBtd = document.getElementById("corBtd_" + id);
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
            var id = input.id.split("_")[1];
            var ansYcorY = document.getElementById("ansY_corY_clov_" + id);
            var ansYcorN = document.getElementById("ansY_corN_clov_" + id);
            var ansN = document.getElementById("ansN_clov_" + id);
            var comTd = document.getElementById("comTd_" + id);
            var comY = document.getElementById("comY_"+id);
            var comN = document.getElementById("comN_"+id);
            var comment = document.getElementById("comment_" + id);
            var corO = document.getElementById("corO_" + id);
            var corOtd = document.getElementById("corOTd_" + id);
            var corX = document.getElementById("corX_" + id);
            var corXtd = document.getElementById("corXTd_" + id);
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
            var inputId = input.id.split("_")[1];
            var textInput = document.getElementById("comment_"+inputId);
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
            var inputId = input.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id;
            var imageAtd = document.getElementById("imageAtd_" + inputId);
            var imageBtd = document.getElementById("imageBtd_" + inputId);
            var labelA = document.getElementById("labelA_" + inputId);
            var labelB = document.getElementById("labelB_" + inputId);
            var inputA = document.getElementById("image_A_" + inputId);
            var inputB = document.getElementById("image_B_" + inputId);

            var YN = input.value;
            if (YN == "Y") {
                imageAtd.removeAttribute("style");
                imageBtd.removeAttribute("style");
                labelA.setAttribute("for", "image_A_"+inputId);
                labelA.removeAttribute("style");
                labelB.setAttribute("for", "image_B_"+inputId);
                labelB.removeAttribute("style");

            }
            else{
                var td = document.createElement("td");
                td.setAttribute("style","background-color: #ecedee");
                td.setAttribute("id","imageAtd_"+inputId);
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,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");
                img.setAttribute("id", "preview_A_" + inputId);
                var label = document.createElement("label");
                // label.setAttribute("for", "image_A_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("id", "labelA_"+inputId);
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("id", "image_A_" + inputId);
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
                td.setAttribute("id","imageBtd_"+inputId);
                var div = document.createElement("div");
                var img = document.createElement("img");
                img.setAttribute("style", "margin:6px");
                img.setAttribute("src", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXu7u67u7vv7++4uLjg4ODCwsLk5OS2trby8vLd3d2+vr7q6urKysrHx8fY2NjV1dXPz8/wKvVCAAAHpUlEQVR4nO2d67qjKgyGBeQg4uH+r3YHBHW12oLVms7O92M9M2tay9twSCBhqopEIpFIJBKJRCKRSCQSiUQikUgkEolEIpFIJBKJRCKRSCQSiUQikUgk0jfFUesMwBOecaU+b9+/T4hdRPj7IsLfFxH+vojw90WEv6+7Cbl5r88ChJsJedsxAWKCrWTXknJsP2nlvYS8/kO2IyF688FnnNfc/c/Yi0V5mwPoGfvj7byckPN2VvWAabo8QEBsjzfgU4I3MkMYZ1FS/f28TBMC4XC4oRcT8kE/2GL1gbzJJmTs8Ei8mvDRFuPqA43LBxTqaEuvJXyeSrqVLbjNJ2TuqBFvJOSqoJMycbgNp5DsPv0l4VBEeHTBuJHQyAJAxuTBbnojYe5yn4x4cEm8j7BorWAP03BJG06j2Xr4FmE6UDCujBCWxEPnE9cRcsPbun+kkHUT1PdNIR/4Nc2+VGt2UC4jNCrERc/tnFVKuHb/NmSHbZirCLnT75t8rgSrt6bbawg5l+Um+ly62QrRriEc7wB8cOyvJMyObE8n7J776TWEN5kQ+ulGY64gNCVBw6na8F6vGYd3mZCx8ambXkH4yTA8ulYmPQ/ESwiLAr81ne3G3js8g5MHMZ8jEDSEQrim5cn1NKaqR3bgMWgJhe2rh917wKzL/QakhMI2m34zN6qUESehGHaDH24KQxCMhMKqV/sTvOpKnoaQUHRLG/wU4/8CE816W7XEQ8JHKJZ9UG6qZpQhqLSuX0W05imO/iHCBRBmFbdaAoWWzTw6CxCxES6xgGmfhpuwdbKjyd5axUZo08c/nuCkLyC1L3vbChlhClh5tbPsCZZC2twzDlyE6fCaV3b3DenMKfeZuAjlDPjqa4iImWsGKsLZPK/PL0Rq4+8Rxnn0rXGSqbPmU0yE0YTvXzyf4Wc8FBVhbEvGGVs8HM0aiYgI455RzgmUmDZfsjZHMBFOx4FZx6TJiBlrIiJCmW+X2d4Z3RQPoRhCU4pWuZwsOESEdfjkzL3j5N79FOHU5sydVdHkfh+ICKeRlZV9Ofdp/j7TDw+hnZqcGdrGQDlj1OIhjHNHbmSb/XI8hJNTmn0M978hfN+p8RDKf96GheMw2+R4CKec39zMr5jxlZFyi4dQ5H8XbHZMM9x0RIQq1w9bvdq8fyUiwuiHZdYjTM9t3+dZ4SGMeduZTo3LHrWICNN2d1Z8WOdONJgI09DKqUiwcbct46WYCKcFICfIj2M2KxBBRBjjp4J4IWtWQkUYE7Te9r20sZoVLWMiTHMNV6/XgBj9ZtYQoSJMe9mvT3jTIeq7LwIjIZsOB/nLoShkOkDMqz/BRTifce8jiq7wnBsX4XxEWpkdb0WkZMrsRyIjXKoKebtxzi1YyiXiWedOGAmX1HNuGvs331KwJRkscxBiJGRzKkJIqJlq88PPbkmnKQDESLgg+qSvthlGUK+qJSVqN1PjVwhFs+R9VdVzoRZvCx6GktD74C8qz0qS2rAShoKl7XaUp9DiJPSei9pg5KYtrlHESugZ/yZ6+0zTuivP18dL6JcIOSifre9vpKlUfwAPOWGAFMxK0GZtJiLC0irtM/Wdmplb656+U9lVeJfAiRLPVaTX1B8W3Qdxpr5Vf3hfDenGDSjXjMP8zPOTCb9VB+z3Nu9AjLv/XyG8oxRYsM17iK4irMCnfHMJwsmS/XaIchmhL15qVf0trUPmbxFW1Vdva99vxJWEp+um1mZ+ySbuUVTGhD9Mt1ou/2x8v56fVvkAI/1+fkl8y3Ip5ge2Pf1rUKxJ5RXOw9ROMjm2aYVumeOVlcvrZTi75/VcjGAaZ+EdteENi1mYX2t9jiCiisuxsR2Yp9PMjZ3QyVNuNXAvhQfg94V8FFhXdVgDeGu1daNjWvJGjNMUdgvJnnzMKBdCqQff2yqXECfCxSmZMm7A/RtDmgJvvVPtu/rgTKMH890emCMgdDp4jZ5w0DEl1nSTiSZC4dicSDpqmFf4oFvny4LAlnHTEcCAEBdcEFe6HrU/9vWEjKUmKt2tCIchAHvT9YHQSlPDu+Dd60vC0BJy609igLBdFcdG2Ilw5GFiMWC3AQi5pzPwK97r5dISnnrpLSC7AsLGtMJCx7SdmicYmDOnkC4Sml433mKD8YTQN/2ko5UZ9eRU+ypvmGmkAyEzpCf0I6gzLwk5lxbAmOfyWV7O+DvfRhiXgZB3UkrViG4AfXDz7hUKhBBxgHWgly6j6rGX+o6p/MgDQj8hwbKgpOD9dMkVb/pRK7y91E8zUiuYaaxYfj0NyUTos2akNcGGqbzCCoCO1V3QDRTamcYT8kpYIOyhwcEm0EnVHxv6runHnCcEc07OGcw1MpaSoicMqVuw4nd6DNcOdnFhXAiBzYWfmrtU3wY9U4EvE1zSZumluDAToR9cXRiQWnZSz+XcC+F0JbZf61epNKOBb6ZvWzWA29No1wfdBbMprtJN18Z5DqOGrnP9vHPUSuh53WrR62Uz343NXQdT6mi1FnKAbtBNko8fcq/4HINPvYuHG5OWkM//8zpMj/HW6i0xBuPL/zbwpaaTSCQSiUQikUgkEolEIpFIJBKJRCKRSCQSiUQikUgkEolEIpH+6D/+pF/9/+I9DwAAAABJRU5ErkJggg==");
                img.setAttribute("id","preview_B_"+inputId)
                var label = document.createElement("label");
                // label.setAttribute("for", "image_B_"+String(quizCnt-1));
                label.setAttribute("class", "btn btn-dark");
                label.setAttribute("id", "labelB_"+inputId);
                label.setAttribute("style", "background-color: lightgrey; border-color: lightgrey");
                label.innerText = "찾기";
                var input = document.createElement("input");
                input.setAttribute("type", "file");
                input.setAttribute("id", "image_B_" + inputId);
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
                            if(row.id>=originalCnt){
                                alert('<spring:message code="error12.3" arguments="질문이미지"/>');
                                error = true;
                                return false;
                            }
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
                                    if(row.id>=originalCnt){
                                        alert('<spring:message code="error12.3" arguments="선택지 이미지"/>');
                                        error = true;
                                        return false;
                                    }
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
                var quizDtlImageYn = document.getElementById("quizDtlImageYn");
                var quizAImageYn = document.getElementById("quizAImageYn");
                var quizBImageYn = document.getElementById("quizBImageYn");
                var quizAImageYnStr = "";
                var quizBImageYnStr = "";
                var quizDtlImageYnStr = "";
                var quizOrderStr = "";
                quizList.forEach(function(quiz){
                    quizOrderStr += (quiz.id + "_");
                    var quizMainImage = document.getElementById("image_" + quiz.id);
                    if(quizMainImage.value==""){
                        quizDtlImageYnStr += "X_";
                    }
                    else{
                        quizDtlImageYnStr += "O_";
                    }

                    var quizAImage = document.getElementById("image_A_" + quiz.id);
                    if(quizAImage!=null){
                        if(quizAImage.value==""){
                            quizAImageYnStr += "X_";
                        }
                        else{
                            quizAImageYnStr += "O_";
                        }
                    }
                    else{
                        quizAImageYnStr +="N"
                    }
                    quizAImageYn.setAttribute("value", quizAImageYnStr);

                    var quizBImage = document.getElementById("image_B_" + quiz.id);
                    if(quizBImage!=null){
                        if(quizBImage.value==""){
                            quizBImageYnStr += "X_";
                        }
                        else{
                            quizBImageYnStr += "O_";
                        }
                    }
                    else{
                        quizBImageYnStr +="N"
                    }
                    quizBImageYn.setAttribute("value", quizBImageYnStr);
                })
                quizDtlImageYn.setAttribute("value", quizDtlImageYnStr);
                quizOrder.setAttribute("value", quizOrderStr);
                var originCnt = document.getElementById("originalCnt");
                originCnt.setAttribute("value", originalCnt);
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
                <span class="tab_span flSpan">퀴즈 상세정보/수정</span>
                <br>
                <br>
            </div>
            <!-- //헤드라인 영역 -->

            <!-- 입력창 영역 // -->
            <form action="/quiz/update/${quiz.qzSeq}" method="post" id="registerForm" enctype="multipart/form-data" style="display: inline" onsubmit="return checkForm();">
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
                            <th style="height: 50px; width:100px">등록일</th>
                            <td><div style="margin-left: 6px">${quiz.regDt}</div></td>
                            <th>퀴즈번호</th>
                            <td colspan="3"><div style="margin-left: 6px">${quiz.qzSeq}</div></td>
                        </tr>
                        <tr>
                            <th style="height: 50px; width:100px">시작일</th>
                            <td style="width: 360px">
                                <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
                                    <input style="border: 1px solid; border-color: #767676" type="text" id="dspStDt" name="dspStDt" class="datetimepicker" data-target="#datetimepicker1" value="${quiz.stDt}">
                                    <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </td>
                            <th style="height: 50px; width:100px">종료일</th>
                            <td style="width: 360px">
                                <div class="input-group date" id="datetimepicker2" data-target-input="nearest">
                                    <input style="border: 1px solid; border-color: #767676" type="text" id="dspEndDt" name="dspEndDt" class="datetimepicker" data-target="#datetimepicker2" value="${quiz.endDt}">
                                    <div class="input-group-append" data-target="#datetimepicker2" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </td>
                            <th style="height: 50px; width:100px">일괄 푸시 발송</th>
                            <td style="width: 360px">
                                <c:if test="${quiz.pshYn eq 'Y'}">
                                    <input class="form-check-input" type="radio" name="pushYn" id="pushY" value="Y" checked>
                                </c:if>
                                <c:if test="${quiz.pshYn ne 'Y'}">
                                    <input class="form-check-input" type="radio" name="pushYn" id="pushY" value="Y">
                                </c:if>
                                <label class="form-check-label" for="pushY">
                                    발송
                                </label>
                                <c:if test="${quiz.pshYn eq 'Y'}">
                                    <input class="form-check-input" type="radio" name="pushYn" id="pushN" value="N">
                                </c:if>
                                <c:if test="${quiz.pshYn ne 'Y'}">
                                    <input class="form-check-input" type="radio" name="pushYn" id="pushN" value="N" checked>
                                </c:if>
                                <label class="form-check-label" for="pushN">
                                    미발송
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th style="height: 50px">전시상태</th>
                            <td colspan="6">
                                <div style="margin-left: 5px">
                                    <c:if test="${quiz.dspYn eq 'Y'}">
                                        전시
                                    </c:if>
                                    <c:if test="${quiz.dspYn ne 'Y'}">
                                        미전시
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="height: 50px">퀴즈명</th>
                            <td colspan="6">
                                <div>
                                    <input type="text" name="quizNm" id="quizNm" size="150" maxlength="24" onchange="checkText(this)" value="${quiz.qzNm}">
                                </div>
                            </td>
                        </tr>
                        <tr style="height: 160px">
                            <th >대표이미지</th>
                            <td colspan="6">
                                <div>
                                    <img style="margin: 6px" id="previewMain" src="/image/${quizImage.encFeNm}.${quizImage.feExt}">
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
                            <input type="text" name="maxPrt" id="maxPrt" size="11" maxlength="10" value="${quiz.mxPrt}" onchange="checkInt(this)"> 명
                        </td>
                    </tr>
                    </tbody>
                </table>

                <br>
                <table class="table table-sm search-table">
                    <tbody>
                    <tr style="height: 50px; font-size: medium; font-weight: bold; vertical-align: center">
                        <td colspan="2">
                            <span>
                                당첨내역
                            </span>
                            <span style="float: right">
                                <button type="button" class="btn btn-outline-secondary" style="background-color: #ecedee; color: black; font-size: 15px">엑셀 다운로드 요청</button>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th style="height: 50px; width: 110px">참여자수</th>
                        <td style="height: 50px">
                            <div style="margin-left: 6px">
                                ${totalPtc}명
                            </div>
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
                    <c:forEach var="qd" items="${quizDtls}" varStatus="status">
                        <c:if test="${qd.quizTyCd eq 'Q0001'}">
                            <tr id="${status.index}" name="quizRow">
                                <td>
                                    <div>
                                        <div style="float: left" name="updown">
                                            <button type="button" class="btn btn-outline-secondary" style="background-color: #ecedee; color: black; font-size: 15px; margin-left: 6px" onclick="up(this)">▲</button>
                                            <button type="button" class="btn btn-outline-secondary" style="background-color: #ecedee; color: black; font-size: 15px; margin-right: 6px" onclick="down(this)">▼</button>
                                        </div>
                                        <div style="float: right">
                                            <button type="button" class="btn btn-outline-secondary" style="margin-bottom: 6px; background-color: #ecedee; color: black; font-size: 15px" onclick="delRow(this)">삭제</button>
                                        </div>
                                    </div>
                                    <table class="table table-sm search-table" id="upperTable_${status.index}">
                                        <style>input{margin-left:6px; margin-right:6px;}</style>
                                        <tbody>
                                        <tr>
                                            <th style="height: 50px; width:100px">퀴즈유형</th>
                                            <td style="width: 500px">
                                                <c:set var="searchType" value="searchType_${status.index}"/>
                                                <select name="${searchType}" class="form-select w130" onchange="changeType(this)" style="marin-left:6px; margin-right:3px; display: inline-block;">
                                                    <option value="Q0001">OX형</option>
                                                    <option value="Q0002">AB형</option>
                                                </select>
                                            </td>
                                            <th>퀴즈질문</th>
                                            <td>
                                                <c:set var="quizQuestion" value="quizQuestion_${status.index}"/>
                                                <input type="text" name="${quizQuestion}" size="50" onchange="checkText(this)" maxlength="40" value="${qd.quizQst}">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>질문이미지</th>
                                            <td colspan="3">
                                                <div>
                                                    <c:set var="qdImage" value="qdImage_${status.index}"/>
                                                    <c:set var="previewId" value="preview_${status.index}"/>
                                                    <c:set var="image" value="image_${status.index}"/>
                                                    <img style="margin:6px" src="/image/${requestScope[qdImage].encFeNm}.${requestScope[qdImage].feExt}" id=${previewId}>
                                                    <label for="${image}" class="btn btn-dark">찾기</label>
                                                    <input type="file" name="quizMainImage" id="${image}" class="btn btn-outline-dark" style="margin-right: 100px; display: none" accept=".png, .jpg" onchange="readImage(this)">
                                                </div>
                                                <div style="margin-left: 12px; color:#dc3545">가로: 670px, 세로: 380px</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>정답 사용 여부 및 지급 클로버</th>
                                            <td colspan="3">
                                                <c:set var="ansYn" value="ansYn_${status.index}"/>
                                                <c:set var="ansY" value="ansY_${status.index}"/>
                                                <c:set var="ansN" value="ansN_${status.index}"/>
                                                <c:set var="ansClov" value="ansClov_${status.index}"/>
                                                <c:set var="wngClov" value="wngClov_${status.index}"/>
                                                <c:set var="ansY_corY_clov" value="ansY_corY_clov_${status.index}"/>
                                                <c:set var="ansY_corN_clov" value="ansY_corN_clov_${status.index}"/>
                                                <c:set var="ansN_clov" value="ansN_clov_${status.index}"/>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <input class="form-check-input" onclick="oxAnswerYnConfig(this)" type="radio" name="${ansYn}" id="${ansY}" value="Y" checked>
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" onclick="oxAnswerYnConfig(this)" type="radio" name="${ansYn}" id="${ansY}" value="Y">
                                                </c:if>
                                                <label class="form-check-label" for="${ansY}">
                                                    <span>사용 (정답 : </span>
                                                    <span>
                                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${ansClov}" id="${ansY_corY_clov}" value="${qd.crtAnsClv}">
                                                            </c:if>
                                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${ansClov}" disabled="disabled" id="${ansY_corY_clov}">
                                                            </c:if>
                                                        </span>
                                                    <span>C,   오답 : </span>
                                                    <span>
                                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${wngClov}" id="${ansY_corN_clov}" value="${qd.wrgAnsClv}">
                                                            </c:if>
                                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${wngClov}" disabled="disabled" id="${ansY_corN_clov}" >
                                                            </c:if>
                                                        </span>
                                                    <span>C)</span>
                                                </label>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <input class="form-check-input" type="radio" onclick="oxAnswerYnConfig(this)" name="${ansYn}" id="${ansN}" value="N" style="margin-left: 30px">
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" type="radio" onclick="oxAnswerYnConfig(this)" name="${ansYn}" id="${ansN}" value="N" checked style="margin-left: 30px">
                                                </c:if>
                                                <label class="form-check-label" for="${ansN}">
                                                    <span>미사용 (</span>
                                                    <span>
                                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                                <input type="text" size="12" maxlength="15" name="${ansN_clov}" id="${ansN_clov}" disabled>
                                                            </c:if>
                                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                                <input type="text" size="12" maxlength="15" name="${ansN_clov}" id="${ansN_clov}" value="${qd.notUseClv}">
                                                            </c:if>
                                                        </span>
                                                    <span>C)</span>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>해설 사용 여부</th>
                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                            <td id="comTd_${status.index}" colspan="3">
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                            <td id="comTd_${status.index}" colspan="3" style="background-color: #ecedee">
                                                </c:if>
                                                <c:set var="comYn" value="comYn_${status.index}"/>
                                                <c:set var="comY" value="comY_${status.index}"/>
                                                <c:set var="comN" value="comN_${status.index}"/>
                                                <c:set var="comment" value="comment_${status.index}"/>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <c:if test="${qd.cmtUseYn eq 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comY}" value="Y" checked>
                                                    </c:if>
                                                    <c:if test="${qd.cmtUseYn ne 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comY}" value="Y">
                                                    </c:if>
                                                    <label class="form-check-label" for="${comY}">사용</label>
                                                    <c:if test="${qd.cmtUseYn eq 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comN}" value="N">
                                                    </c:if>
                                                    <c:if test="${qd.cmtUseYn ne 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comN}" value="N" checked>
                                                    </c:if>
                                                    <label class="form-check-label" for="${comN}">미사용</label>
                                                    <c:if test="${qd.cmtUseYn eq 'Y'}">
                                                        <input type="text" onchange="checkText(this)" size="100" name="${comment}" id="${comment}" value="${qd.cmtCnt}">
                                                    </c:if>
                                                    <c:if test="${qd.cmtUseYn ne 'Y'}">
                                                        <input type="text" onchange="checkText(this)" size="100" name="${comment}" id="${comment}" disabled>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comY}" value="Y" disabled>
                                                    <label class="form-check-label" for="${comY}">사용</label>
                                                    <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comN}" value="N" disabled>
                                                    <label class="form-check-label" for="${comN}">미사용</label>
                                                    <input type="text" onchange="checkText(this)" size="100" name="${comment}" id="${comment}" disabled>
                                                </c:if>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table class="table table-sm search-table" id="lowerTable_${status.index}">
                                        <style>input{margin-left:6px; margin-right:6px;}</style>
                                        <tbody>
                                        <tr>
                                            <th style="height: 50px; width:50%; text-align: center">선택지</th>
                                            <th style="height: 50px; width:50%; text-align: center">정답</th>
                                        </tr>
                                        <tr style="text-align: center">
                                            <td>O</td>
                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                            <td id="corOTd_${status.index}">
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                            <td id="corOTd_${status.index}" style="background-color: #ecedee">
                                                </c:if>
                                                <c:set var="corOX" value="corOX_${status.index}"/>
                                                <c:set var="corO" value="corO_${status.index}"/>
                                                <c:set var="corX" value="corX_${status.index}"/>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <c:if test="${qd.quizAns eq 0}">
                                                        <input class="form-check-input" type="radio" name="${corOX}" id="${corO}" value="0" checked>
                                                    </c:if>
                                                    <c:if test="${qd.quizAns ne 0}">
                                                        <input class="form-check-input" type="radio" name="${corOX}" id="${corO}" value="0">
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" type="radio" name="${corOX}" id="${corO}" value="0" disabled>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <tr style="text-align: center">
                                            <td>X</td>
                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                            <td id="corXTd_${status.index}">
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                            <td id="corXTd_${status.index}" style="background-color: #ecedee">
                                                </c:if>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <c:if test="${qd.quizAns eq 1}">
                                                        <input class="form-check-input" type="radio" name="${corOX}" id="${corX}" value="1" checked>
                                                    </c:if>
                                                    <c:if test="${qd.quizAns ne 1}">
                                                        <input class="form-check-input" type="radio" name="${corOX}" id="${corX}" value="1">
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" type="radio" name="${corOX}" id="${corX}" value="1" disabled>
                                                </c:if>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${qd.quizTyCd eq 'Q0002'}">
                            <tr id="${status.index}" name="quizRow">
                                <td>
                                    <div>
                                        <div style="float: left" name="updown">
                                            <button type="button" class="btn btn-outline-secondary" style="background-color: #ecedee; color: black; font-size: 15px; margin-left: 6px" onclick="up(this)" disabled="disabled">▲</button>
                                            <button type="button" class="btn btn-outline-secondary" style="background-color: #ecedee; color: black; font-size: 15px; margin-right: 6px" onclick="down(this)" disabled="disabled">▼</button>
                                        </div>
                                        <div style="float: right">
                                            <button type="button" class="btn btn-outline-secondary" style="margin-bottom: 6px; background-color: #ecedee; color: black; font-size: 15px" onclick="delRow(this)">삭제</button>
                                        </div>
                                    </div>
                                    <table class="table table-sm search-table" id="upperTable_${status.index}">
                                        <style>input{margin-left:6px; margin-right:6px;}</style>
                                        <tbody>
                                        <tr>
                                            <th style="height: 50px; width:100px">퀴즈유형</th>
                                            <td style="width: 500px">
                                                <c:set var="searchType" value="searchType_${status.index}"/>
                                                <select name="${searchType}" class="form-select w130" onchange="changeType(this)" style="marin-left:6px; margin-right:3px; display: inline-block;">
                                                    <option value="Q0002">AB형</option>
                                                    <option value="Q0001">OX형</option>
                                                </select>
                                            </td>
                                            <th>퀴즈질문</th>
                                            <td>
                                                <c:set var="quizQuestion" value="quizQuestion_${status.index}"/>
                                                <input type="text" size="50" onchange="checkText(this)" name="${quizQuestion}" value="${qd.quizQst}" maxlength="40">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>질문이미지</th>
                                            <td colspan="3">
                                                <div>
                                                    <c:set var="qdImage" value="qdImage_${status.index}"/>
                                                    <c:set var="previewId" value="preview_${status.index}"/>
                                                    <c:set var="image" value="image_${status.index}"/>
                                                    <img style="margin:6px" src="/image/${requestScope[qdImage].encFeNm}.${requestScope[qdImage].feExt}" id=${previewId}>
                                                    <label for="${image}" class="btn btn-dark">찾기</label>
                                                    <input type="file" name="quizMainImage" id="${image}" class="btn btn-outline-dark" style="margin-right: 100px; display: none" accept=".png, .jpg" onchange="readImage(this)">
                                                </div>
                                                <div style="margin-left: 12px; color:#dc3545">가로: 670px, 세로: 380px</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>정답 사용 여부 및 지급 클로버</th>
                                            <td colspan="3">
                                                <c:set var="ansYn" value="ansYn_${status.index}"/>
                                                <c:set var="ansY" value="ansY_${status.index}"/>
                                                <c:set var="ansN" value="ansN_${status.index}"/>
                                                <c:set var="ansClov" value="ansClov_${status.index}"/>
                                                <c:set var="wngClov" value="wngClov_${status.index}"/>
                                                <c:set var="ansY_corY_clov" value="ansY_corY_clov_${status.index}"/>
                                                <c:set var="ansY_corN_clov" value="ansY_corN_clov_${status.index}"/>
                                                <c:set var="ansN_clov" value="ansN_clov_${status.index}"/>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <input class="form-check-input" onclick="abAnswerYnConfig(this)" type="radio" name="${ansYn}" id="${ansY}" value="Y" checked>
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" onclick="abAnswerYnConfig(this)" type="radio" name="${ansYn}" id="${ansY}" value="Y">
                                                </c:if>
                                                <label class="form-check-label" for="${ansY}">
                                                    <span>사용 (정답 : </span>
                                                    <span>
                                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${ansClov}" id="${ansY_corY_clov}" value="${qd.crtAnsClv}">
                                                            </c:if>
                                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${ansClov}" disabled="disabled" id="${ansY_corY_clov}">
                                                            </c:if>
                                                        </span>
                                                    <span>C,   오답 : </span>
                                                    <span>
                                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${wngClov}" id="${ansY_corN_clov}" value="${qd.wrgAnsClv}">
                                                            </c:if>
                                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                                <input type="text" size="12" maxlength="15" onchange="checkInt(this)" name="${wngClov}" disabled="disabled" id="${ansY_corN_clov}" >
                                                            </c:if>
                                                        </span>
                                                    <span>C)</span>
                                                </label>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <input class="form-check-input" type="radio" onclick="abAnswerYnConfig(this)" name="${ansYn}" id="${ansN}" value="N" style="margin-left: 30px">
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" type="radio" onclick="abAnswerYnConfig(this)" name="${ansYn}" id="${ansN}" value="N" checked style="margin-left: 30px">
                                                </c:if>
                                                <label class="form-check-label" for="${ansN}">
                                                    <span>미사용 (</span>
                                                    <span>
                                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                                <input type="text" size="12" maxlength="15" name="${ansN_clov}" id="${ansN_clov}" disabled>
                                                            </c:if>
                                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                                <input type="text" size="12" maxlength="15" name="${ansN_clov}" id="${ansN_clov}" value="${qd.notUseClv}">
                                                            </c:if>
                                                        </span>
                                                    <span>C)</span>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>선택지 이미지 사용 여부</th>
                                            <td colspan="3">
                                                <c:set var="imgYn" value="imgYn_${status.index}"/>
                                                <c:set var="imgY" value="imgY_${status.index}"/>
                                                <c:set var="imgN" value="imgN_${status.index}"/>
                                                <c:if test="${qd.abImgYn eq 'Y'}">
                                                    <input class="form-check-input" type="radio" name="${imgYn}" id="${imgY}" value="Y" onclick="imageYnConfig(this)" checked>
                                                </c:if>
                                                <c:if test="${qd.abImgYn ne 'Y'}">
                                                    <input class="form-check-input" type="radio" name="${imgYn}" id="${imgY}" value="Y" onclick="imageYnConfig(this)">
                                                </c:if>
                                                <label class="form-check-label" for="${imgY}">사용</label>
                                                <c:if test="${qd.abImgYn eq 'Y'}">
                                                    <input class="form-check-input" type="radio" name="${imgYn}" id="${imgN}" value="N" onclick="imageYnConfig(this)">
                                                </c:if>
                                                <c:if test="${qd.abImgYn ne 'Y'}">
                                                    <input class="form-check-input" type="radio" name="${imgYn}" id="${imgN}" value="N" onclick="imageYnConfig(this)" checked>
                                                </c:if>
                                                <label class="form-check-label" for="${imgN}">미사용</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>해설 사용 여부</th>
                                            <td id="comTd_${status.index}" colspan="3">
                                                <c:set var="comYn" value="comYn_${status.index}"/>
                                                <c:set var="comY" value="comY_${status.index}"/>
                                                <c:set var="comN" value="comN_${status.index}"/>
                                                <c:set var="comment" value="comment_${status.index}"/>
                                                <c:if test="${qd.ansUseYn eq 'Y'}">
                                                    <c:if test="${qd.cmtUseYn eq 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comY}" value="Y" checked>
                                                    </c:if>
                                                    <c:if test="${qd.cmtUseYn ne 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comY}" value="Y">
                                                    </c:if>
                                                    <label class="form-check-label" for="${comY}">사용</label>
                                                    <c:if test="${qd.cmtUseYn eq 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comN}" value="N">
                                                    </c:if>
                                                    <c:if test="${qd.cmtUseYn ne 'Y'}">
                                                        <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comN}" value="N" checked>
                                                    </c:if>
                                                    <label class="form-check-label" for="${comN}">미사용</label>
                                                    <c:if test="${qd.cmtUseYn eq 'Y'}">
                                                        <input type="text" onchange="checkText(this)" size="100" name="${comment}" id="${comment}" value="${qd.cmtCnt}">
                                                    </c:if>
                                                    <c:if test="${qd.cmtUseYn ne 'Y'}">
                                                        <input type="text" onchange="checkText(this)" size="100" name="${comment}" id="${comment}" disabled>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${qd.ansUseYn ne 'Y'}">
                                                    <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comY}" value="Y" disabled>
                                                    <label class="form-check-label" for="${comY}">사용</label>
                                                    <input class="form-check-input" onclick="commentYnConfig(this)" type="radio" name="${comYn}" id="${comN}" value="N" disabled>
                                                    <label class="form-check-label" for="${comN}">미사용</label>
                                                    <input type="text" onchange="checkText(this)" size="100" name="${comment}" id="${comment}" disabled>
                                                </c:if>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table class="table table-sm search-table" id="lowerTable_${status.index}">
                                        <style>input{margin-left:6px; margin-right:6px;}</style>
                                        <tbody>
                                        <tr>
                                            <th style="height: 50px; width:50%; text-align: center">선택지</th>
                                            <th style="height: 50px; width:25%; text-align: center">
                                                <div>이미지</div>
                                                <div style="margin-left: 12px; color:#dc3545; font-weight: normal">가로: 324px, 세로: 324px</div>
                                            </th>
                                            <th style="height: 50px; width:25%; text-align: center">정답</th>
                                        </tr>
                                        <tr style="text-align: center">
                                            <td>
                                                <c:set var="A" value="A_${status.index}"/>
                                                <c:set var="optionA" value="optionA_${status.index}"/>
                                                <input type="text" onchange="checkText(this)" name="${A}" size="80" maxlength="80" value="${requestScope[optionA].optCnt}"></td>
                                            <c:set var="optionImageA" value="optionImageA_${status.index}"/>
                                            <c:set var="preview_A" value="preview_A_${status.index}"/>
                                            <c:set var="image_A" value="image_A_${status.index}"/>
                                            <c:if test="${qd.abImgYn eq 'Y'}">
                                                <td id="imageAtd_${status.index}">
                                                    <div>
                                                        <img style="margin:6px" src="/image/${requestScope[optionImageA].encFeNm}.${requestScope[optionImageA].feExt}" id="${preview_A}">
                                                        <label for="${image_A}" class="btn btn-dark" id="labelA_${status.index}">찾기</label>
                                                        <input type="file" name="quizABImage" id="${image_A}" class="btn btn-outline-dark" style="margin-right: 100px; display: none" accept=".png, .jpg" onchange="readImageAB(this)">
                                                    </div>
                                                </td>
                                            </c:if>
                                            <c:if test="${qd.abImgYn ne 'Y'}">
                                                <td style="background-color: #ecedee" id="imageAtd_${status.index}">
                                                    <div>
                                                        <img style="margin:6px" src="data:image/png;base64,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" id="${preview_A}">
                                                        <label class="btn btn-dark" style="background-color: lightgrey; border-color: lightgrey" id="labelA_${status.index}">찾기</label>
                                                        <input type="file" name="quizABImage" id="${image_A}" class="btn btn-outline-dark" style="margin-right: 100px; display: none" accept=".png, .jpg" onchange="readImageAB(this)">
                                                    </div>
                                                </td>
                                            </c:if>
                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                <c:set var="corAB" value="corAB_${status.index}"/>
                                                <c:set var="corA" value="corA_${status.index}"/>
                                                <c:if test="${qd.quizAns eq 0}">
                                                    <td id="corATd_${status.index}">
                                                        <input class="form-check-input" type="radio" name="${corAB}" id="${corA}" value="0" checked>
                                                    </td>
                                                </c:if>
                                                <c:if test="${qd.quizAns ne 0}">
                                                    <td id="corATd_${status.index}">
                                                        <input class="form-check-input" type="radio" name="${corAB}" id="${corA}" value="0">
                                                    </td>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                <c:set var="corAB" value="corAB_${status.index}"/>
                                                <c:set var="corA" value="corA_${status.index}"/>
                                                <td id="corATd_${status.index}" style="background-color: #ecedee">
                                                    <input class="form-check-input" type="radio" name="${corAB}" id="${corA}" value="0" disabled="disabled">
                                                </td>
                                            </c:if>
                                        </tr>
                                        <tr style="text-align: center">
                                            <td>
                                                <c:set var="B" value="B_${status.index}"/>
                                                <c:set var="optionB" value="optionB_${status.index}"/>
                                                <input type="text" onchange="checkText(this)" name="${B}" size="80" maxlength="80" value="${requestScope[optionB].optCnt}"></td>
                                            <c:set var="optionImageB" value="optionImageB_${status.index}"/>
                                            <c:set var="preview_B" value="preview_B_${status.index}"/>
                                            <c:set var="image_B" value="image_B_${status.index}"/>
                                            <c:if test="${qd.abImgYn eq 'Y'}">
                                                <td id="imageBtd_${status.index}">
                                                    <div>
                                                        <img style="margin:6px" src="/image/${requestScope[optionImageB].encFeNm}.${requestScope[optionImageB].feExt}" id="${preview_B}">
                                                        <label for="${image_B}" class="btn btn-dark" id="labelB_${status.index}">찾기</label>
                                                        <input type="file" name="quizABImage" id="${image_B}" class="btn btn-outline-dark" style="margin-right: 100px; display: none" accept=".png, .jpg" onchange="readImageAB(this)">
                                                    </div>
                                                </td>
                                            </c:if>
                                            <c:if test="${qd.abImgYn ne 'Y'}">
                                                <td style="background-color: #ecedee" id="imageBtd_${status.index}">
                                                    <div>
                                                        <img style="margin:6px" src="data:image/png;base64,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" id="${preview_B}">
                                                        <label class="btn btn-dark" style="background-color: lightgrey; border-color: lightgrey" id="labelB_${status.index}">찾기</label>
                                                        <input type="file" name="quizABImage" id="${image_B}" class="btn btn-outline-dark" style="margin-right: 100px; display: none" accept=".png, .jpg" onchange="readImageAB(this)">
                                                    </div>
                                                </td>
                                            </c:if>
                                            <c:if test="${qd.ansUseYn eq 'Y'}">
                                                <c:set var="corAB" value="corAB_${status.index}"/>
                                                <c:set var="corB" value="corB_${status.index}"/>
                                                <c:if test="${qd.quizAns eq 1}">
                                                    <td id="corBTd_${status.index}">
                                                        <input class="form-check-input" type="radio" name="${corAB}" id="${corB}" value="1" checked>
                                                    </td>
                                                </c:if>
                                                <c:if test="${qd.quizAns ne 1}">
                                                    <td id="corBTd_${status.index}" >
                                                        <input class="form-check-input" type="radio" name="${corAB}" id="${corB}" value="1">
                                                    </td>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${qd.ansUseYn ne 'Y'}">
                                                <c:set var="corAB" value="corAB_${status.index}"/>
                                                <c:set var="corB" value="corB_${status.index}"/>
                                                <td id="corBTd_${status.index}" style="background-color: #ecedee">
                                                    <input class="form-check-input" type="radio" name="${corAB}" id="${corB}" value="1" disabled="disabled">
                                                </td>
                                            </c:if>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
                <br>

                <table class="table table-sm search-table">
                    <tr>
                        <td>
                            <div style="margin-bottom: 7px">
                                <button type="button" class="btn btn-outline-secondary" style="background-color: #ecedee; color: black; font-size: 15px">엑셀 다운로드</button>
                            </div>
                        </td>
                    </tr>
                        <c:forEach var="qd" items="${quizDtls}" varStatus="status">
                            <tr>
                            <td>
                                <table class="table table-sm search-table">
                                    <tr>
                                        <th colspan="2" style="text-align: center">${qd.quizQst}</th>
                                    </tr>
                                    <tr>
                                        <c:if test="${qd.quizTyCd eq 'Q0001'}">
                                            <td><div style="margin-left: 30px">O</div></td>
                                        </c:if>
                                        <c:if test="${qd.quizTyCd ne 'Q0001'}">
                                            <c:set var="optionA" value="optionA_${status.index}"/>
                                            <td><div style="margin-left: 30px">${requestScope[optionA].optCnt}</div></td>
                                        </c:if>
                                        <c:set var="ptcAns" value="ptcAns_${status.index}"/>
                                        <c:forEach var="pa" items="${requestScope[ptcAns]}">
                                            <c:if test="${pa.ptcAns eq '0'}">
                                                <td style="width: 300px">${pa.ansCnt}명</td>
                                            </c:if>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <c:if test="${qd.quizTyCd eq 'Q0001'}">
                                            <td> <div style="margin-left: 30px">X</div></td>
                                        </c:if>
                                        <c:if test="${qd.quizTyCd ne 'Q0001'}">
                                            <c:set var="optionB" value="optionB_${status.index}"/>
                                            <td><div style="margin-left: 30px">${requestScope[optionB].optCnt}</div></td>
                                        </c:if>
                                        <c:set var="ptcAns" value="ptcAns_${status.index}"/>
                                        <c:forEach var="pa" items="${requestScope[ptcAns]}">
                                            <c:if test="${pa.ptcAns eq '1'}">
                                                <td style="width: 300px">${pa.ansCnt}명</td>
                                            </c:if>
                                        </c:forEach>
                                    </tr>
                                </table>
                            </td>
                            </tr>
                        </c:forEach>
                </table>


                <!-- 초기화, 검색버튼// -->
                <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar mb-2">
                        <div class="btn-group">
                            <button type="submit"  class="btn btn-primary" style="margin-right:6px; width:80px; height:40px " id="btn_submit" >수정</button>
                        </div>
                    </div>
                </div>
                <!-- //초기화, 검색버튼 -->

                <%--                hidden data field                --%>
                <input type="hidden" name="quizOrder" id="quizOrder">
                <input type="hidden" name="originalCnt" id="originalCnt">
                <input type="hidden" name="quizDtlImageYn" id="quizDtlImageYn">
                <input type="hidden" name="quizAImageYn" id="quizAImageYn">
                <input type="hidden" name="quizBImageYn" id="quizBImageYn">

            </form>
        </main>
    </div>
</div>
</body>
</html>
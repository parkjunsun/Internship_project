<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/jsp/include/common_plugin.jsp" %>
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
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap pt-3">
                <h1 class="h2">Template Detail</h1>
            </div>
            <!-- Form Table 영역 // -->
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
                        <th>구분<br>(TextBox)</th>
                        <td>
                            <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com">
                        </td>
                        <th>구분<br>(SingleLine TextBox)</th>
                        <td>
                            <input type="email" class="form-control w150" id="exampleFormControlInput2" placeholder="name@example.com" style="margin-right:5px; display: inline-block;">
                            <input type="email" class="form-control w150" id="exampleFormControlInput3" placeholder="name@example.com" style="margin-right:5px; display: inline-block;" disabled="disabled">
                        </td>
                    </tr>
                    <tr>
                        <th>구분(SelectBox)</th>
                        <td>
                            <select class="form-select">
                                <option selected>Open this select menu</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </td>
                        <th>구분<br>(MultiLine SelectBox)</th>
                        <td>
                            <select class="form-select">
                                <option selected>Open this select menu</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                            <select class="form-select mt-3" disabled="disabled">
                                <option selected>Open this select menu</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>구분<br>(SingleLine SelectBox)</th>
                        <td>
                            1-depth
                            <select class="form-select w130" style="margin-left:3px; margin-right:3px; display: inline-block;">
                                <option selected>Open this select menu</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                            2-depth
                            <select class="form-select w130" style="margin-left:3px; margin-right:3px; display: inline-block;" disabled="disabled">
                                <option selected>Open this select menu</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </td>
                        <th>구분(CheckBox)</th>
                        <td>
                            <div>
                                <input class="form-check-input" type="checkbox" value="" id="flexCheck1" name="flexCheckBox" checked>
                                <label class="form-check-label" for="flexCheck1">
                                    checkbox1
                                </label>
                                <input class="form-check-input" type="checkbox" value="" id="flexCheck2" name="flexCheckBox" checked>
                                <label class="form-check-label" for="flexCheck2">
                                    checkbox2
                                </label>
                                <input class="form-check-input" type="checkbox" value="" id="flexCheck3" name="flexCheckBox" disabled="disabled">
                                <label class="form-check-label" for="flexCheck3">
                                    checkbox3
                                </label>
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <th>구분(RadioButton)</th>
                        <td>
                            <div>
                                <input class="form-check-input" type="radio" name="flexRadio" id="flexRadio1" checked>
                                <label class="form-check-label" for="flexRadio1">
                                    radio1
                                </label>
                                <input class="form-check-input" type="radio" name="flexRadio" id="flexRadio2">
                                <label class="form-check-label" for="flexRadio2">
                                    radio2
                                </label>
                                <input class="form-check-input" type="radio" name="flexRadio" id="flexRadio3" disabled="disabled">
                                <label class="form-check-label" for="flexRadio3">
                                    radio3
                                </label>
                            </div>
                        </td>
                        <th>구분(datepicker)</th>
                        <td>
                            <input type="text" class="datepicker" id="datepicker1">
                            ~
                            <input type="text" class="datepicker" id="datepicker2">
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>


            <div class="border_head">
                <span class="tab_span flSpan">Grid title</span>
                <div class="d-flex justify-content-end flex-wrap flex-md-nowrap">
                    <div class="btn-toolbar">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary">Primary</button>
                            <button type="button" class="btn btn-secondary">Secondary</button>
                            <button type="button" class="btn btn-success">Success</button>
                            <button type="button" class="btn btn-danger">Danger</button>
                            <button type="button" class="btn btn-warning">Warning</button>
                            <button type="button" class="btn btn-info">Info</button>
                            <button type="button" class="btn btn-light">Light</button>
                            <button type="button" class="btn btn-dark">Dark</button>
                            <button type="button" class="btn btn-outline-secondary">Share</button>
                        </div>
                    </div>
                </div>
            </div>
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
            <!-- // grid Semple 영역 -->

            <!-- Button Set (middle 정렬) // -->
            <div class="d-flex justify-content-center flex-wrap flex-md-nowrap">
                <div class="btn-toolbar mb-2">
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary">Primary</button>
                        <button type="button" class="btn btn-secondary">Secondary</button>
                        <button type="button" class="btn btn-success">Success</button>
                        <button type="button" class="btn btn-danger">Danger</button>
                        <button type="button" class="btn btn-warning">Warning</button>
                        <button type="button" class="btn btn-info">Info</button>
                        <button type="button" class="btn btn-light">Light</button>
                        <button type="button" class="btn btn-dark">Dark</button>
                        <button type="button" class="btn btn-outline-secondary">Share</button>
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
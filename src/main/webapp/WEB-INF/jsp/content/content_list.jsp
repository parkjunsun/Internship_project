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

</script>
<body>
<div id="chart"  class="table-responsive" >
    <table class="table table-striped table-sm">
        <thead>
        <tr>
            <td style="text-align: center; width:40px;" scope="col">전시설정</td>
            <td style="text-align: center; width:300px;" scope="col">
                <div>
                    <input class="form-check-input" type="radio" name="dspYn" value="all" id="flexRadio1" checked style="margin-left:6px; margin-right:6px;">
                    <label class="display-state-label" for="flexRadio1">
                        전시
                    </label>
                    <input class="form-check-input" type="radio" name="dspYn" value="Y" id="flexRadio2" style="margin-left:6px; margin-right:6px;">
                    <label class="display-state-label" for="flexRadio2">
                        미전시
                    </label>
                </div>
            </td>
        </tr>
        </thead>

    </table>
</div>
</body>
</html>
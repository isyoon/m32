<%--
  Created by IntelliJ IDEA.
  User: isyoon
  Date: 2010. 6. 9
  Time: 오전 2:04:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <% request.setAttribute("cacheTime", System.currentTimeMillis());%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>daum & 메멘토</title>

    <link rel="icon" href="<c:url value="/favicon.ico"/>" type="image/x-icon"/>
    <link rel="shortcuticon" href="<c:url value="/favicon.ico"/>" type="image/x-icon"/>

    <link rel="stylesheet" type="text/css" href="<c:url value="/css/common.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/p_main.css"/>"/>
    <!-- LIBS -->
    <script type="text/javascript" src="<c:url value="/js/jquery-1.4.2.js"/>"></script>
</head>
<body id="body">
<div class="ssjs-main">
    <div class="ssjs-logo">
        <a id="daumLogo" href="http://www.daum.net/" title="Daum 메인페이지로 가기" target="_blank">
            <img src="/images/o_daum_small.gif" width="62" height="26" alt="Daum"></a>
        <a id="m32Logo" href="<c:url value="/"/>" title="m32">m32</a>
    </div>
    <div class="ssjs-search-bar-box">
        <form id="search" name="search" action="./search" method="get">
            <div class="ssjs-search-bar">
                <input type="text" class="ssjs-search" id="q" name="q" maxlength="64"/>
                    <span>
                        <button type="button" title="" class="ssjs-suggest"></button>
                    </span>
            </div>
            <input type="submit" class="ssjs-search-btn" value="검색">
        </form>
    </div>
</div>
</body>
</html>
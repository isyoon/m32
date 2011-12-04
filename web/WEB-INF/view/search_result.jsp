<%--
  Created by IntelliJ IDEA.
  User: isyoon
  Date: 2010. 6. 9
  Time: 오전 2:04:29
  To change this template use File | Settings | File Templates.
  0.C74CbV34FqYn9CPpRq4pIYnzHF44ZQXSgEG6xliGfjKfqY1DuS7bk5JCWd
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
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/p_result.css"/>"/>
    <!-- LIBS -->
    <script type="text/javascript" src="<c:url value="/js/jquery-1.4.2.js"/>"></script>
    <script type="text/javascript" src="http://apis.daum.net/maps/maps2.js?apikey=7f51fa50e4e59eb1d52a61c17cadf263288d9663"></script>
</head>
<body id="body">
<div id="wrap">
	<div id="topWrap">
		<h1 id="daumHeader">
		    <a id="daumLogo" title="Daum 메인페이지로 가기" href="http://www.daum.net/" target="_top"><img alt="Daum" src="<c:url value="/images/o_daum_small.gif"/>" height="26" width="62" /></a>
		    <a id="m32Logo" title="m32 메인페이지로 가기" href="<c:url value="/"/>">M32</a>
		</h1>
        <form id="search" name="search" action="./search" method="get">
			<div class="searchbar">
				<input class="search" id="qTop" name="q" value=""  type="text">
				<span id="daumNoSuggest"></span>
			</div>
			<input id="daumBtnSearch" value="검색" type="submit">
		</form>
	</div>
    <div class="ssjs-result-area">
        <div class="ssjs-search-info">
            <p>검색키워드 : ${q}</p>
            <p><a href="regedit" style="color:#0066FF;font-weight:bold;"> &gt;새로운 장소 등록&lt;</a></p>
        </div>
        <c:if test="${!empty maps}">
            <c:forEach items="${maps}" var="map" varStatus="status">
                <div class="ssjs-map-area">
                    <div class="ssjs-maps" id="map_${status.index}" style=""></div>
                    <script type="text/javascript">
                        var map = new DMap("map_${status.index}", {
                                                                        point:new DLatLng(${map.endPhotoX}, ${map.endPhotoY}),
                                                                        width:300 ,
                                                                        height:200
                                                                     });
                        map.addOverlay(new DMark(new DLatLng(${map.startPhotoX}, ${map.startPhotoY})));
                        map.addOverlay(new DMark(new DLatLng(${map.endPhotoX}, ${map.endPhotoY}),{'mark':new DIcon("/images/mark.png",new DSize(31,35))}));
                    </script>
                    <ul>
                        <li>${map.title}</li>
                        <li>목적지 주소 : ${map.addr}</li>
                        <li>출발지 : ${map.startPlace}</li>
                        <li>목적지 : ${map.endPlace}</li>
                        <li>설명   : ${map.description}</li>
                        <li><a href="play?mapId=${map.id}"> &gt;가는길 보기&lt;</a></li>
                    </ul>
                    <div style="clear:both;"></div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty maps}">
            <p>검색된 결과가 없습니다.</p>
        </c:if>
    </div>
</div>
</body>
</html>
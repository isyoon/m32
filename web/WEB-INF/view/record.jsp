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
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/common.css"/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/p_record.css"/>"/>
    <link rel="shortcuticon" href="<c:url value="/favicon.ico"/>" type="image/x-icon"/>
    <!-- LIBS -->
    <script type="text/javascript" src="<c:url value="/js/jquery-1.4.2.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/tag.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.json.js"/>"></script>
    <script type="text/javascript"
            src="http://apis.daum.net/maps/maps2.js?apikey=7f51fa50e4e59eb1d52a61c17cadf263288d9663"></script>
</head>
<body id="body">
<div class="ssjs-record">
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
    <div style="clear:both;"></div>
    <div class="ssjs-record-box">
        <!-- 지도 -->
        <div class="ssjs-map-box">
            <div id="daummap"></div>
            <div id="roadview" class="roadview"></div>
        </div>
        <div class="ssjs-map-info-box">
            <div class="ssjs-title-label">로드뷰 녹화 정보</div>
            <form action="/save" method="post" name="roadForm" id="roadForm">
                <p>
                    <span class="label">제목</span>
                    <input type="text" name="title" value=""/>
                </p>

                <p>
                    <span class="label">출발지</span>
                    <input type="text" name="startPlace" value="${mapLocation.startPlace}"/>
                </p>

                <p>
                    <span class="label">도착지</span>
                    <input type="text" name="endPlace" value="${mapLocation.endPlace}"/>
                </p>

                <p>
                    <span class="label">주소</span>
                    ${mapLocation.addr}
                    <input type="hidden" name="addr" value="${mapLocation.addr}"/>
                </p>

                <p>
                    <span class="label v-top">설명</span>
                    <textarea name="description"></textarea>
                </p>

                <p>
                    <span class="label">태그</span>
                    <input class="tagger" type="text" name="tags"/>
                </p>

                <input type="hidden" name="startPhotoX" value="${mapLocation.startPhotoX}"/>
                <input type="hidden" name="startPhotoY" value="${mapLocation.startPhotoY}"/>
                <input type="hidden" name="endPhotoX" value="${mapLocation.endPhotoX}"/>
                <input type="hidden" name="endPhotoY" value="${mapLocation.endPhotoY}"/>
                <input type="hidden" name="keyWords" value=""/>
                <input type="hidden" name="roadViews" value=""/>
            </form>
            <input type="button" value="save" id="save"/>
        </div>
        <div style="clear:both;"></div>
    </div>
</div>
<script type="text/javascript">
    var ssjsRecordConfig = {
        mapW :590,
        mapH :300,
        rMapH : 400
    };
    var SsjsRecord = function() {
        var _self = this;
        this.roadViewDatas = [];
        this.isStartRecord = false;
        this.roadViewDatas.last = function() {
            return this[this.length - 1];
        };
        _self.roadViewDatas.last = function() {
            return this[this.length - 1];
        };
        var startLatLng = new DLatLng(${mapLocation.startPhotoX}, ${mapLocation.startPhotoY});

        var rmap = new DMap("daummap", {width:ssjsRecordConfig.mapW,height:ssjsRecordConfig.mapH,point:startLatLng});//로드뷰 지도 생성
        //            var rvo = new DRoadViewOverlay(rmap); //로드뷰 오버레이 생성

        var opt = {width:ssjsRecordConfig.mapW,height:ssjsRecordConfig.rMapH,point:startLatLng};
        var rv = new DRoadView("roadview", opt); //로드뷰 생성
        var rvc = new DRoadViewClient(); //로드뷰 클라이언트 생성

        var rmark = new DMark(startLatLng); //로드뷰 마크
        rmap.addOverlay(new DMark(new DLatLng(${mapLocation.endPhotoX}, ${mapLocation.endPhotoY}), {'mark':new DIcon("/images/mark.png", new DSize(31, 35))}));
        rmap.addOverlay(rmark);
        DEvent.addListener(rv, "complete", function() {
            addRecord(startLatLng);
        });

        DEvent.addListener(rv, "move", function(latlng) {
            rmap.setCenter(latlng);
            addRecord(latlng);
        });

        DEvent.addListener(rv, "changeddirection", function(addtion) { // 지도 클릭이벤트
            _self.roadViewDatas.last().pan = addtion.pan + '';
            _self.roadViewDatas.last().tilt = addtion.tilt + '';
            _self.roadViewDatas.last().zoom = addtion.zoom + '';
        });
        var addRecord = function(latlng) {
            var lastRoadViewData = _self.roadViewDatas.last();
            if (lastRoadViewData) {
                drawLine(new DLatLng(lastRoadViewData.photoX, lastRoadViewData.photoY), latlng);
            }
            _self.roadViewDatas.push({
                'seq'   : _self.roadViewDatas.length,
                'photoX': latlng.y + '',
                'photoY': latlng.x + '',
                'panoId': rv.getPanoId() + '',
                'pan': rv.getPan() + '',
                'tilt': rv.getTilt() + '',
                'zoom': rv.getZoom() + ''
            });
        };
        var drawLine = function(sLatLng, eLatLng) {
            rmap.addOverlay(new DLine(sLatLng, eLatLng));
        };
        this.save = function() {
            var tags = [];
            var roadViewData = _self.roadViewDatas.last();
            $('input[name=roadViews]').val($.JSON.encode(_self.roadViewDatas));

            $('input[name=tags]').each(function(idx, element) {
                tags.push({
                    'keyWord':element.value
                });
            });
//            $('input[name=endPhotoX]').val(roadViewData.photoX);
//            $('input[name=endPhotoY]').val(roadViewData.photoY);
            $('input[name=keyWords]').val($.JSON.encode(tags));

            //빈 값이 있는지 채크

            if(!$('input[name=title]').val()) {
                alert("제목을 입력해주세요.");
                return false;
            } else if(!$('input[name=startPlace]').val()) {
                alert("출발지를 입력해주세요.");
                return false;
            } else if(!$('input[name=endPlace]').val()) {
                alert("도착지를 입력해주세요.");
                return false;
//            } else if(!$('textarea[name=description]').val()) {
//                alert("설명을 입력해주세요.");
//                return false;
            } else if(_self.roadViewDatas.length < 2) {
                alert("녹화된 데이터가 없습니다.");
                return false;
//            } else if(tags.length == 0) {
//                alert("태그를 입력해주세요.");
//                return false;
            } else {
                $('#roadForm').submit();                
            }

        };
    }

    $(document).ready(function() {
        var ssjsRecord = new SsjsRecord();
        $('#save').click(ssjsRecord.save);
    });
</script>

</body>
</html>
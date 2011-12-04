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
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/p_regedit.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.4.2.js"/>"></script>
    <script type="text/javascript"
            src="http://apis.daum.net/maps/maps2.js?apikey=7f51fa50e4e59eb1d52a61c17cadf263288d9663"></script>
</head>
<body id="body">
    <div id="ssjs-regedit" class="ssjs-regedit">
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
        <div class="ssjs-search-bar-box">
            <!-- 지도 -->
            <div class="ssjs-map-box">
                <div id="daummap"></div>
                <div id="roadview"class="roadview"></div>
            </div>
            <!-- 검색창 -->
            <div class="ssjs-map-info-box">
                <div class="ssjs-search-label"> 로드뷰 출발지 선택</div>
                <div class="ssjs-search-bar">
                    <input type="text" class="ssjs-search" id="q" name="q" maxlength="64"/>
                    <button type="button" title="" class="ssjs-suggest"></button>
                </div>
                <input type="button" class="ssjs-search-btn" value="검색">
                <div style="clear:both;"></div>
                <div id="search-result"></div>
                <div><button id="btn">출발지 등록</button></div>
                <br/>
                <div><a href="http://kr.gugi.yahoo.com/" target="_blank">powered by 야후! 거기</a> </div>
            </div>
            <div style="clear:both;"></div>            
        </div>
    </div>
    <form action="<c:url value="/record"/>" method="post" id="placeForm">
        <input type="hidden" name="startPhotoX"/>
        <input type="hidden" name="startPhotoY"/>
        <input type="hidden" name="endPhotoX"/>
        <input type="hidden" name="endPhotoY"/>
        <input type="hidden" name="startPlace"/>
        <input type="hidden" name="endPlace"/>
        <input type="hidden" name="addr"/>
    </form>
    <!-- LIBS -->
    <script type="text/javascript">
        var ssjsRegConfig = {
            yAPIKey : '0.C74CbV34FqYn9CPpRq4pIYnzHF44ZQXSgEG6xliGfjKfqY1DuS7bk5JCWd',
            yAPIUrl : 'http://kr.open.gugi.yahoo.com/service/poi.php',
            mapW :590,
            mapH :300,
            rMapH : 400

        };

       var params = {
           startPhotoX : undefined,
           startPhotoY : undefined,
           endPhotoX : undefined,
           endPhotoY : undefined,
           startPlace : undefined,
           endPlace : undefined,
           addr: undefined
        };

        var SsjsReg = function() {
            var tmpLat = 37.53729488297613, tmpLng = 127.00551022687515;
            var tmpPlace, tmpAddr;

            var step = 1;
            
            var roadviewLocation = function() {
                rmark.setPoint(new DLatLng(tmpLat, tmpLng));
                rvc.getNearestRoadView(new DLatLng(tmpLat, tmpLng), function(data){
                    if(data.service){
                        rv.setPanoId(data.id);
//                        rmark.setPoint(new DLatLng(data.photoy, data.photox));
                    }else{
                        alert("로드뷰 서비스 지역이 아닙니다.");
                    }
                });
            };

            // 검색 결과 이벤트
            $(".r").live("click", function() {
                var target = $(this);
                tmpLat = target.attr('latitude');
                tmpLng = target.attr('longitude');
                
                tmpPlace = target.attr('place');
                tmpAddr = target.attr('address');
                
                rmap.setCenter(new DLatLng(tmpLat, tmpLng));
                rmark.setPoint(new DLatLng(tmpLat, tmpLng));                
                roadviewLocation();
            });

            // 버튼 이벤트
            $("#btn").click(function(){
                if(step == 1) {
                    if(tmpPlace) {
                        params.startPhotoX = tmpLat;
                        params.startPhotoY = tmpLng;
                        params.startPlace = tmpPlace;
                        tmpPlace = undefined;
                        tmpAddr = undefined;

                        $('.ssjs-search-label').html("도착지를 선택해주세요.");
                        $('#btn').html("도착지 등록");
                        $('#search-result').html('');
                        $('#q').val('').focus();
                        rmap.clearOverlay();
                        rmark = new DMark(new DLatLng(tmpLat,tmpLng), {'mark':new DIcon("/images/mark.png", new DSize(31, 35))});
                        rmap.addOverlay(rmark);
                        step = 2;
                    } else {
                        alert("검색 후 클릭해주세요.");
                        return false;
                    }
                } else if(step == 2) {
                    if(tmpPlace) {
                        params.endPhotoX = tmpLat;
                        params.endPhotoY = tmpLng;
                        params.endPlace = tmpPlace;
                        params.addr = tmpAddr;

                        $('input[name=startPhotoX]').val(params.startPhotoX);
                        $('input[name=startPhotoY]').val(params.startPhotoY);
                        $('input[name=startPlace]').val(params.startPlace);
                        $('input[name=endPhotoX]').val(params.endPhotoX);
                        $('input[name=endPhotoY]').val(params.endPhotoY);
                        $('input[name=endPlace]').val(params.endPlace);
                        $('input[name=addr]').val(params.addr);
                        
                        $("#placeForm").submit();

                    } else {
                        alert("검색 후 클릭해주세요.");
                        return false;
                    }
                }
            });
            
            //1,2 단계 등록 지도 초기화
            var rmap = new DMap("daummap",{width:ssjsRegConfig.mapW,height:ssjsRegConfig.mapH,point:new DLatLng(tmpLat, tmpLng)});//로드뷰 지도 생성
            var rvo = new DRoadViewOverlay(rmap); //로드뷰 오버레이 생성

            var zoomControl = new DZoomControl();
            rmap.addControl(zoomControl);
            zoomControl.setVAlign("middle");

            var opt = {width:ssjsRegConfig.mapW,height:ssjsRegConfig.rMapH,point:new DLatLng(tmpLat, tmpLng)};
            var rv = new DRoadView("roadview",opt); //로드뷰 생성
            var rvc = new DRoadViewClient(); //로드뷰 클라이언트 생성
            
            var rmark = new DMark( new DLatLng(tmpLat, tmpLng) ); //로드뷰 마크
            rmap.addOverlay(rmark);
            
            DEvent.addListener(rv,"move", function(latlng){
            	rmap.setCenter(latlng);
	            rmark.setPoint(latlng);
            });

            DEvent.addListener(rmap,"click",function(e){ // 지도 클릭이벤트
                tmpLng = e.x;
                tmpLat = e.y;
                rmark.setPoint(e);
                roadviewLocation();
            });

            roadviewLocation();
            
            this.search = function() {
                var q =  $('#q').val().trim();

                $('#q').val(q);

                if(q) {
                    $.get('gateway/localSearch', {
                        'q': q
                    }, function(data) {
                        var local = data.localInfos;
                        if(data.total > 0) {
                            var html = "<ul>";
                            var i, limit = (local.length < 20) ? local.length : 20;
                            for(i=0; i<limit; i++) {
                                var pt = new DPoint(local[i].mapx, local[i].mapy);
                                var latlng = rmap.getTransCoord(pt, "ktm", "wgs84");
                                var title = local[i].title.replace(/(<([^>]+)>)/ig,""); 
                                html += '<li class="r" longitude="'+latlng.x+'" latitude="'+latlng.y+'" address="'+local[i].address+'" place="'+title+'">'+title+'</li>';
                            }
                            html += "</ul>"

                            $("#search-result").html(html);
                        } else {
                            $.get(ssjsRegConfig['yAPIUrl'], {
                                'appid':ssjsRegConfig['yAPIKey'],
                                'q': $('#q').val(),
                                'results':20,
                                'output' :'json',
                                'encoding' :'utf-8'
                                }, function(data) {
                                    if(data.ResultSet.head.Found > 0) {
                                        var i;
                                        var html = "<ul>";
                                        var d = data.ResultSet.locations.item;
                                        for(i=0; i<d.length; i++) {
                                           html += '<li class="r" longitude="' + d[i].longitude +
                                                   '" latitude="' + d[i].latitude +
                                                   '" address="' + d[i].state + ' ' + d[i].county +
                                                   '" place="' + d[i].name +'">'+d[i].name+'</li>';
                                        }
                                        html += "</ul>";
                                    } else {
                                        alert("검색 결과가 없습니다.");
                                    }
                                
                                    $("#search-result").html(html);
                            },'jsonp');
                        }
                    },'json');
                } else {
                    alert("검색어를 입력해주세요.");
                }                
            };
        }

        $(document).ready(function() {
            var ssjsReg = new SsjsReg();
            $(".ssjs-search-btn").bind("click", ssjsReg.search);
            $("#q").bind("keydown",function(e){
                if(e.keyCode === 13 || e.keyCode === 10){
                    ssjsReg.search();
                }
            }).focus();
        });

    </script>

</body>
</html>


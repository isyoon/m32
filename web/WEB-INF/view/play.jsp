<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<% request.setAttribute("cacheTime", System.currentTimeMillis());%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
	<title>daum & 메멘토</title>

    <link rel="icon" href="<c:url value="/favicon.ico"/>" type="image/x-icon"/>
    <link rel="shortcuticon" href="<c:url value="/favicon.ico"/>" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/common.css"/>"/>

	<style type="text/css">.
		a { text-decoration:none; }
		a img { border:0 none;}
		#wrap { width:978px;}
		#contentWrap { width:928px; padding:10px; color:#FFF; -moz-border-radius: 10px; -webkit-border-radius: 10px; border:5px solid #5D76F3; margin-left:10px;}
		#player { background-color:#000000; padding:2px; display:none; width:922px;height:412px; overflow:hidden;}
		#daummap {float:left;}
		.roadview { float:left;position:absolute;left:359px;}
		#conroller {clear:both; padding-top:2px;}
		#desc { margin-top:15px; font-size:14px;}
        #desc p {padding-top:5px;}
		.readyPlay {background:url("<c:url value="/images/o_playbtn_off.png"/>") no-repeat scroll 0 0 transparent; height:25px; width:30px; border:medium none; cursor:pointer; display:inline; overflow:hidden; text-indent:-9999in; vertical-align:top; margin:0; float:left;}
		.activePlay {background:url("<c:url value="/images/o_playbtn_on.png"/>") no-repeat scroll 0 0 transparent;}
		.readyPause {background:url("<c:url value="/images/o_pausebtn_off.png"/>") no-repeat scroll 0 0 transparent; height:25px; width:30px; border:medium none; cursor:pointer; display:inline; overflow:hidden; text-indent:-9999in; vertical-align:top; margin:0; float:left;}
		.activePause {background-image:url("<c:url value="/images/o_pausebtn_on.png"/>");}
		#btnPlay:hover { background-image:url("<c:url value="/images/o_playbtn_on.png"/>"); }
		#btnPlay:active { background-image:url("<c:url value="/images/o_playbtn_click.png"/>");}
		#btnPause:hover { background-image:url("<c:url value="/images/o_pausebtn_on.png"/>");}
		#btnPause:active { background-image:url("<c:url value="/images/o_pausebtn_click.png"/>");}
		#progressbarWrap { height:15px; border:#bfbfbf solid thick; margin-left:60px; }
		#progressbar { width:0%; height:15px; background-color:#ed6969;}
		
		#loading { background: url("<c:url value="/images/o_ajax-loader.gif"/>") no-repeat scroll center center transparent; background-color:#000000; padding:20px; width:886px; height:376px;}
        #processbar {clear:both;}
	</style>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.4.2.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/progressbar.min.js"/>"></script>
    <!--
    <script type="text/javascript" src="http://apis.daum.net/maps/maps2.js?apikey=7f51fa50e4e59eb1d52a61c17cadf263288d9663"></script>
     -->
    <script type="text/javascript" src="http://apis.daum.net/maps/maps2.js?apikey=7f51fa50e4e59eb1d52a61c17cadf263288d9663"></script>

</head>
<body>

<div id="wrap">
	<div id="topWrap">
		<h1 id="daumHeader">
		    <a id="daumLogo" title="Daum 메인페이지로 가기" href="http://www.daum.net/" target="_top"><img alt="Daum" src="<c:url value="/images/o_daum_small.gif"/>" height="26" width="62" /></a>
		    <a id="m32Logo" title="m32 메인페이지로 가기" href="/">m32</a>
		</h1>
	
		<form id="search" name="daumSearch" action="./search" method="get">
			<div class="searchbar">
				<input class="search" id="qTop" name="q" value=""type="text">
				<span id="daumNoSuggest"></span>
			</div>
			<input id="daumBtnSearch" value="검색" type="submit">
		</form>
	</div>

	<div id="contentWrap">
		<div id="loading"></div>
		<div id="player">
			<div id="daummap"></div>
            <div id="roadview2" class="roadview"></div>
			<div id="roadview3" class="roadview"></div>
			<div id="roadview4" class="roadview"></div>
			<div id="roadview1" class="roadview"></div>
            <div class="progressBar" id="processbar"></div>
			<div id="conroller" style="display:none;">
				<input class="readyPlay" id="btnPlay" value="" type="button">
				<input class="readyPause" id="btnPause" value="" type="button">
				<div id="progressbarWrap">
					<div id="progressbar"></div>
				</div>
			</div>
		</div>
		<div id="desc">
            <p>제목 : ${mapLocation.title}</p>
            <p>출발 : ${mapLocation.startPlace} ~ 도착 : ${mapLocation.endPlace}</p>
            <p>설명 : ${mapLocation.description}</p>
		</div>
	</div>
</div>
<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		ssjs.loadData();
		$("#btnPlay").bind("click", ssjs.play);
		$("#btnPause").bind("click", ssjs.pause);
        $("#processbar").progressBar(10,{ barImage: '/images/progressbg_blue.png', showText: false , boxImage:'/images/s.gif', width:922,height:10});
	 });

	var ssjs = {
		data: null,
		rv1: null,
		rv2: null,
		rv3: null,
		rv4: null,
		maxLength: 0,
		index: 0,
		interval: null,
		rmark: null,
		map: null,
		currentRoadView: 1,
		progressSize: 0,
        loadingCount : 0,
        loadErrorCnt: 0,
        opts : [],
        tmpRv : null,
        tmpOpt :{},
        tmpRv2 : null,
        tmpOpt2 :{},
        tmpRv3 : null,
        tmpOpt3 :{},
        tmpRv4 : null,
        tmpOpt4 :{},
		//progressTime: 0,
		
		loadData: function() {
			$.getJSON('<c:url value="/roadView"/>',{'mapId':${mapLocation.id}}, function(data) {
				ssjs.data = data.roadViews;
                ssjs.maxLength = ssjs.data.length;
                ssjs.progressSize = 100 / (ssjs.maxLength-1);
                //ssjs.progressTime = 0.8 / ssjs.progressSize;
				ssjs.startPlay();
			});
		},
		initMap: function() {
			var pointData = this.data[this.index];
			var latlng = new DLatLng(pointData.photoX, pointData.photoY);

			// 지도 로딩
			this.map = new DMap("daummap",{width:330,height:400,point:latlng});//로드뷰 지도 생성
			
			this.rmark = new DMark(latlng); //로드뷰 마크
			this.map.addOverlay(this.rmark);
            this.map.addOverlay(new DMark(new DLatLng(${mapLocation.endPhotoX}, ${mapLocation.endPhotoY}), {'mark':new DIcon("/images/mark.png", new DSize(31, 35))}));
        },
		
		initRoadView: function() {
			var pointData = this.data[this.index];
			var latlng = new DLatLng(pointData.photoX, pointData.photoY);

			// 로드뷰 로딩 
			var opt = {point:latlng,width:590,height:400,pan:pointData.pan,tilt:pointData.tilt,zoom:pointData.zoom};
			this.rv1 = new DRoadView("roadview1",opt);
            $("#processbar").progressBar(30);
			this.currentRoadView = 1;

			for(var i = 1; i < 4; i++) {
				var tmpIdx = this.index + i; 
				
				if (tmpIdx <= this.maxLength-1) {
					var pointData = this.data[tmpIdx];
					
					var latlng = new DLatLng(pointData.photoX, pointData.photoY);
					// 로드뷰 로딩 
					ssjs.opts.push({point:latlng,width:590,height:400,pan:pointData.pan,tilt:pointData.tilt,zoom:pointData.zoom});
					if(i === 1) {
                        setTimeout('ssjs.createRoadView(1)',500);
					} else if(i === 2) {
                        setTimeout('ssjs.createRoadView(2)',1000);
					} else if(i === 3) {
                        setTimeout('ssjs.createRoadView(3)',1500);
					}
				}
			}

            DEvent.addListener(this.rv1, "complete", function() {
                console.log("rv1");
                if(ssjs.rv1.isLoaded()){
                    ssjs.showControllerBar();
                }else{
                    if(ssjs.loadErrorCnt === 0){
                        alert('로드뷰를 정상적으로 로딩하지 못하였습니다. 새로고침 해주세요.');
                    }
                }
            });
		},

		reinitRoadView: function() {
			for(var i = 0; i < 4; i++) {
				var tmpIdx = this.index + i; 

				var pointData = ssjs.data[tmpIdx];
				var latlng = new DLatLng(pointData.photoX, pointData.photoY);

				var tempRv = ssjs.getRv(tmpIdx + 1);

				tempRv.setPanoId(pointData.panoId);
                if (i === 0) {
                	ssjs.tmpOpt.tilt = pointData.tilt;
                    ssjs.tmpOpt.pan   = pointData.pan;
                    ssjs.tmpOpt.zoom  = pointData.zoom;
                    ssjs.tmpRv        = tempRv;
                	setTimeout('ssjs.changeRvOpt(); $(".roadview").css("z-index", 0); $("#roadview1").css("z-index", 100);',500);
                } else if (i === 1)  {
                	ssjs.tmpOpt2.tilt = pointData.tilt;
                    ssjs.tmpOpt2.pan   = pointData.pan;
                    ssjs.tmpOpt2.zoom  = pointData.zoom;
                    ssjs.tmpRv2        = tempRv;
                	setTimeout('ssjs.tmpRv2.setPan(ssjs.tmpOpt2.pan); ssjs.tmpRv2.setTilt(ssjs.tmpOpt2.tilt);ssjs.tmpRv2.setZoom(ssjs.tmpOpt2.zoom);',500 * tmpIdx);
                } else if (i === 2)  {
                	ssjs.tmpOpt3.tilt = pointData.tilt;
                    ssjs.tmpOpt3.pan   = pointData.pan;
                    ssjs.tmpOpt3.zoom  = pointData.zoom;
                    ssjs.tmpRv3        = tempRv;
                	setTimeout('ssjs.tmpRv3.setPan(ssjs.tmpOpt3.pan); ssjs.tmpRv3.setTilt(ssjs.tmpOpt3.tilt);ssjs.tmpRv3.setZoom(ssjs.tmpOpt3.zoom);',500 * tmpIdx);                	
                } else if (i === 3)  {
                	ssjs.tmpOpt4.tilt = pointData.tilt;
                    ssjs.tmpOpt4.pan   = pointData.pan;
                    ssjs.tmpOpt4.zoom  = pointData.zoom;
                    ssjs.tmpRv4        = tempRv;
                	setTimeout('ssjs.tmpRv4.setPan(ssjs.tmpOpt4.pan); ssjs.tmpRv4.setTilt(ssjs.tmpOpt4.tilt);ssjs.tmpRv4.setZoom(ssjs.tmpOpt4.zoom);',500 * tmpIdx);
                }
			}
		},

		preLoadRoadView: function() {
			if (ssjs.index + 4 < ssjs.maxLength) {
				var pointData = ssjs.data[ssjs.index + 4];
				var latlng = new DLatLng(pointData.photoX, pointData.photoY);
	
				var tempRv = ssjs.getRv(ssjs.getPrevDivforRoadView());

				tempRv.setPanoId(pointData.panoId);
                ssjs.tmpOpt.tilt = pointData.tilt;
                ssjs.tmpOpt.pan   = pointData.pan;
                ssjs.tmpOpt.zoom  = pointData.zoom;
                ssjs.tmpRv         = tempRv;
                setTimeout('ssjs.changeRvOpt()',500);
				//console.log("preLoad : " + ssjs.getPrevDivforRoadView() + " / " + pointData.panoId);
			}
			ssjs.index++;
		},

		startPlay: function() {
			$("#loading").hide();
			$("#player").show();

			this.initMap();
			this.initRoadView();
			$(".roadview").css("z-index", 0);
			$("#roadview"+ssjs.currentRoadView).css("z-index", 100);
		},

		play: function() {
			if (ssjs.index >= ssjs.maxLength-1) {
				ssjs.index = 0;
				ssjs.reinitRoadView();
				$("#progressbar").css("width", "0%");
				ssjs.map.clearOverlay();
				
				ssjs.map.addOverlay(ssjs.rmark);
	            ssjs.map.addOverlay(new DMark(new DLatLng(${mapLocation.endPhotoX}, ${mapLocation.endPhotoY}), {'mark':new DIcon("/images/mark.png", new DSize(31, 35))}));
	            $("#btnPlay").addClass("activePlay");
				$("#btnPause").removeClass("activePause");
				ssjs.currentRoadView = 1;
				setTimeout('ssjs.interval = setInterval("ssjs.loadRoadView()", 800);', 1000);
			} else {
				$("#btnPlay").addClass("activePlay");
				$("#btnPause").removeClass("activePause");
				ssjs.interval = setInterval("ssjs.loadRoadView()", 800);
			}
		},
		
		pause: function() {
			clearInterval(ssjs.interval);
			$("#btnPlay").removeClass("activePlay");
			$("#btnPause").removeClass("activePause");
			$("#btnPause").addClass("activePause");
		},

		loadRoadView: function() {
			if (ssjs.index >= ssjs.maxLength-1) {
				$("#btnPlay").removeClass("activePlay");
				$("#btnPause").removeClass("activePause");
				clearInterval(ssjs.interval);
			} else {
                var pointData = ssjs.data[ssjs.index];
				var latlng = new DLatLng(pointData.photoX, pointData.photoY);
				if(ssjs.index > 0){
                    ssjs.drawLine(new DLatLng(ssjs.data[ssjs.index-1].photoX, ssjs.data[ssjs.index-1].photoY),latlng);
                }
				ssjs.getNextDivforRoadView();
				$(".roadview").css("z-index", 0);
				$("#roadview"+ssjs.currentRoadView).css("z-index", 100);
				//console.log("div : " + ssjs.currentRoadView);
				ssjs.updateProgress(1);				
				ssjs.map.setCenter(latlng);
				ssjs.preLoadRoadView();
			}
		},

		getNextDivforRoadView: function() {
			if (ssjs.currentRoadView === 4) {
				ssjs.currentRoadView = 1;
			} else {
				ssjs.currentRoadView++;
			}
		},

		getPrevDivforRoadView: function() {
			if (ssjs.currentRoadView === 1) {
				return 4;
			} else {
				return ssjs.currentRoadView - 1;
			}
		},

		getRv: function(idx) {
			if(idx === 1) {
				return ssjs.rv1;
			} else if(idx === 2) {
				return ssjs.rv2;
			} else if(idx === 3) {
				return ssjs.rv3;
			} else if(idx === 4) {
				return ssjs.rv4;
			}
		},

		updateProgress: function(flag) {
			//if (flag * ssjs.progressTime < ssjs.progressSize) {
				var currentPercent = $("#progressbar").css("width").replace("px", "");
				currentPercent = currentPercent.replace("%", "");
				var newPercent = currentPercent*1 + ssjs.progressSize;
//				flag++;
				$("#progressbar").css("width", newPercent + "%");
				//setTimeout("ssjs.updateProgress("+flag+")", ssjs.progressTime*100);
			//}
		},
        drawLine : function(sLatLng, eLatLng) {
            ssjs.map.addOverlay(new DLine(sLatLng, eLatLng));
        },
        showControllerBar : function(){
            ssjs.loadingCount++;
            if(ssjs.loadingCount === 4){
                $("#processbar").progressBar(100);                
                $('#player').css('height','427px');
                $("#processbar").hide();
                $("#conroller").show();
            }
        },
        roadViewLoadingError : function(){
            if(ssjs.loadErrorCnt === 0){
                ssjs.loadErrorCnt++;
                alert('로드뷰를 정상적으로 로딩하지 못하였습니다. 새로고침 해주세요.');
            }
        },
        createRoadView : function(idx){
            switch(idx){
                case 1:
                        ssjs.rv2 = new DRoadView("roadview2",ssjs.opts[0]);
                        console.log("rv2");
                        $("#processbar").progressBar(50);
                        DEvent.addListener(ssjs.rv2, "complete", function() {
                            if(ssjs.rv2.isLoaded()){
                                ssjs.showControllerBar();
                            }else{
                                ssjs.roadViewLoadingError();
                            }
                        });
                    break;
                case 2:
                        ssjs.rv3 = new DRoadView("roadview3",ssjs.opts[1]);
                        $("#processbar").progressBar(70);
                        console.log("rv3");
                        DEvent.addListener(ssjs.rv3, "complete", function() {
                            if(ssjs.rv3.isLoaded()){
                                ssjs.showControllerBar();
                            }else{
                                ssjs.roadViewLoadingError();
                            }
                        });
                    break;
                case 3:
                        ssjs.rv4 = new DRoadView("roadview4",ssjs.opts[2]);
                        console.log("rv4");
                        $("#processbar").progressBar(98);
                        DEvent.addListener(ssjs.rv4, "complete", function() {
                            if(ssjs.rv4.isLoaded()){
                                ssjs.showControllerBar();
                            }else{
                                ssjs.roadViewLoadingError();
                            }
                        });
                    break;
            }
        },
        changeRvOpt : function(){
            ssjs.tmpRv.setPan(ssjs.tmpOpt.pan);
            ssjs.tmpRv.setTilt(ssjs.tmpOpt.tilt);
            ssjs.tmpRv.setZoom(ssjs.tmpOpt.zoom);
        }
	};
//]]>  	
</script>
</body>
</html>
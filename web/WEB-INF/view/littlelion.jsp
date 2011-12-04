<%--
  Created by IntelliJ IDEA.
  User: isyoon
  Date: 2010. 6. 9
  Time: 오전 2:04:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>daum & 메멘토</title>
<link rel="shortcuticon" href="/favicon.ico" type="image/x-icon"/>
<style type="text/css">
    p {
        margin: 0;
        padding: 0 0 3px 0;
    }

    .profile_master .image_box,
    .profile_master_1 .image_box {
        border: 0 none;
        height: 89px;
        padding: 0;
        position: relative;
        width: 89px;
        margin: 0;
    }

    .profile_master_1 .image_box {
        height: 79px;
    }

    .profile_master .name_text,
    .profile_master_1 .name_text {
        position: absolute;
        left: 1px;
        overflow: hidden;
        width: 72px;
        height: 16px;
        padding: 1px 2px 2px;
        zoom: 1;
        font-size: 8pt;
        letter-spacing: 0.1em;
        line-height: 19px;
        opacity: 0.8;
        filter: alpha(opacity = 80);
        -ms-filter: "alpha(opacity=80)";
        background: #797979;
        color: #fff;
        text-align: center;
        text-indent: 0;
        bottom: 12px;
    }

    .profile_master {
        border: 0 none;
        height: 89px;
        overflow: visible;
        position: relative;
        width: 89px;
        float: left;
        margin-top: 5px;
        z-index: 0;
        left: 6px;
    }

    .profile_master_1 {
        float: left;
        margin-top: 5px;
        border: 0 none;
        height: 89px;
        overflow: visible;
        position: relative;
        width: 89px;
        margin-bottom: 20px;
    }

    .contents_wrap .sec_post .post_section {
        margin-left: 106px;
        padding-bottom: 10px;
    }

    .post_section.no_border {
        border-bottom: 0 none;
    }

    .post_section {
        margin: 0 0 -1px 106px;
        overflow: hidden;
        padding-top: 10px;
    }

    .p_wrap {
        padding: 5px 20px 0px 0;
        width: 400px;
        margin: 0 0 5px 0px;
        border: 2px solid #FCD5E3;
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
    }

    p.title {
        margin-top: 30px;
        padding: 10px 0px 20px 50px;
        font-size: 25px;
        font-weight: bold;
    }

    p.comment-into {
        padding: 10px 0 0 50px;
        font-size: 18px;
        font-weight: bold;
    }

    #totalBody {
        width: 1000px;
    }

    #processbar {
        margin-left: 50px;
    }

    .lank-area {
        padding: 20px 0 0 50px;
        width: 450px;
        float: left;
    }

    .etc-area {
        padding: 20px 0 0 0;
        width: 500px;
        float: left;
    }

    .lank-box {
        width:450px;
        padding:10px 10px 10px 20px;
        border: 2px solid #FCD5E3;
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
    }
    .lank_wrap{
        width:90px;
        float:left;
    }

</style>
<!-- LIBS -->
<script type="text/javascript" src="<c:url value="/js/jquery-1.4.2.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/progressbar.min.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#processbar").progressBar(10, { barImage: '/images/progressbg_blue.png', showText: false , boxImage:'/images/s.gif', width:922,height:10});
        var littleLion = new LittleLion();
        littleLion.init();
    });
    var littleLionCfg = {
        'getCommentUrl' : 'http://me2day.net/api/get_comments.json',
        'postId' : 'pbj37q',
        'page' : 1
    };
    var LittleLion = function() {
        var tmpCommnet = {
            totalCount : 0,
            totalPage : 0,
            commenter : []
        };

        this.init = function() {
            littleLionCfg['page'] = 1;
            this.getComment();
            $("#processbar").progressBar(40);
        };

        this.getComment = function() {
            var _self = this;
            $.get(littleLionCfg['getCommentUrl'], {
                'post_id':littleLionCfg['postId'],
                'page': 'page_' + littleLionCfg['page']
            }, function(data) {
                //				console.log(data);
                tmpCommnet['totalCount'] = data.totalCount;
                tmpCommnet['totalPage'] = data.totalPage;
                $.each($(data.comments), function(index, item) {
                    tmpCommnet.commenter.push(item.author);
                });

                littleLionCfg['page']++;
                if (littleLionCfg['page'] === Math.floor((tmpCommnet['totalPage'] / 2))) {
                    $("#processbar").progressBar(80);
                }
                if (littleLionCfg['page'] <= tmpCommnet['totalPage']) {
                    _self.getComment();
                } else {
                    $("#processbar").progressBar(90);
                    _self.printCommenter();
                }
            }, 'jsonp');
        };

        this.printCommenter = function() {
            var html = '<div class="p_wrap #css#"> ' +
                       '	<div class="profile_master"> ' +
                       '		<div class="image_box">' +
                       '			<img src="{face}" alt="{nickname}"/>' +
                       '		</div>' +
                       '		<div class="friend_text">' +
                       '			<span class="name_text" >{nickname}</span>' +
                       '		</div>' +
                       '	</div>' +
                       '	<div class="post_section no_border">' +
                       '		현재 순위 : {lank} 위 <br/> ' +
                       '		total Count : {totalCnt}개 <br/> ' +
                       '	</div>' +
                       '	<div style="clear:both;"></div>' +
                       '</div> ';
            var lankhtml = '<div class="lank_wrap"> ' +
                           '    <div class="profile_master_1"> ' +
                           '        <div class="image_box">' +
                           '			<img src="{face}" alt="{nickname}"/>' +
                           '		</div>' +
                           '   	    <div class="friend_text">' +
                           '            <span class="name_text" >{nickname}</span>' +
                           '	     </div>' +
                           '        <span> {tLank} </span>' +
                           '    </div>' +
                           '<div style="clear:both;"></div>' +
                           '</div>' ;

            var commenters = {};
            var lank = [];
            var idxs = 0;
            var titleLank = [];
	    var seven = '';
            $.each(tmpCommnet.commenter, function(idx, item) {
                if (((idx + 1) % 100 ) === 0) {
                    titleLank.push({ 'tLank':idx + 1 , 'nickname':item.nickname, 'face':item.face});
                }
		if (((idx +1) % 7777)  === 0 ){
			seven = item.nickname;
		}
                if (!commenters[item.id]) {
                    commenters[item.id] = {};
                    commenters[item.id]['totalCnt'] = 0;
                    commenters[item.id]['id'] = item.id;
                    commenters[item.id]['nickname'] = item.nickname;
                    commenters[item.id]['face'] = item.face;
                    commenters[item.id]['lankIdx'] = idxs++;
                    lank.push({'count' : 0 , 'id':item.id});
                }
                commenters[item.id]['totalCnt'] = ++commenters[item.id]['totalCnt'];
                (lank[commenters[item.id]['lankIdx']])['count'] = commenters[item.id]['totalCnt'];
            });
            lank.sort(function(a, b) {
                return    b['count'] - a['count'];
            });
            $("#processbar").hide();
            $('.comment-into').html('총 ' + tmpCommnet.totalCount + '개 총 ' + lank.length + '명 참여.!');
            var preLank = 1 , preCount, tmpHtml;
            $('#lankArea').html('<p> 엄마!! 나 일등 먹었어~![여러부운~! '+seven+'가 7777 siasia 했어요!]</p>');

            $.each(lank, function(idx, item) {
                if (preCount === commenters[item['id']]['totalCnt']) {
                    commenters[item['id']]['lank'] = preLank;
                } else {
                    commenters[item['id']]['lank'] = idx + 1;
                    preLank = idx + 1;
                }
                preCount = commenters[item['id']]['totalCnt'];
                tmpHtml = html.replace(/\{([\w-]+)\}/g, function(m, name) {
                    return commenters[item['id']][name];
                });
                //                tmpHtml = tmpHtml.replace();
                $('#lankArea').append(tmpHtml);
            });
            var lankCommenter;
            $('.etc-area').html('<p> 엄마!! 나 타이틀 먹었어~!</p> <div class="lank-box"></div>');
            $.each(titleLank, function(idx, item) {
                lankCommenter = titleLank[idx];
                $('.lank-box').append(lankhtml.replace(/\{([\w-]+)\}/g, function(m, name) {
                    return lankCommenter[name];
                }));
            });
            $('.lank-box').append('<div style="clear:both;"></div>');
            //			for(id in commenters){
            //			}
        };
    }
</script>
</head>
<body id="body">
<div class="totalBody" id="totalBody">
    <p class="title"> 꼬마사자님 천성지 실시간 통계!!</p>

    <div class="progressBar" id="processbar"></div>
    <p class="comment-into"></p>

    <div class="lank-area" id="lankArea"></div>
    <div class="etc-area"></div>

</div>
</body>
</html>

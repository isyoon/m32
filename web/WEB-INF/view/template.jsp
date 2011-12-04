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
    <!-- LIBS -->
    <script type="text/javascript" src="<c:url value="/js/jquery-1.4.2.js"/>"></script>

</head>
<body id="body">
    
</body>
</html>
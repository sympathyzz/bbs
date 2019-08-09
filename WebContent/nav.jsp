

<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<DIV>
	&gt;&gt;<B><a href="index?op=getIndex">论坛首页</a></B>
	<c:if test="${boardname != null }">
	<B>&gt;&gt;<a href="topic?op=list&boardid=${boardid}&boardname=${boardname}&pageNum=1">${boardname}</a></B>
	</c:if>
</DIV>
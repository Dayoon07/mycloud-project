<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />

	<%
	    String c = request.getRequestURL().toString();
	    String url = c.substring(0, c.indexOf("/", c.indexOf("://") + 3));
	    request.setAttribute("fuck", url);
	%>

	<header style="height: 60px;" class="w-full flex justify-between align-center px-5 py-4 border-b">
		<div class="flex">
			<span onclick="openSide()" class="block lg:hidden mr-5 text-lg cursor-pointer">&#9776;</span>
			<a href="${ cl }/" class="font-semibold text-xl">마이 <span class="text-blue-600">클라우드</span></a>
		</div>
		<c:choose>
			<c:when test="${ not empty sessionScope.user }">
				<div class="flex justify-between items-center">
					<img src="${ fuck }/source/img/mycloud-profile.jpeg" class="cursor-pointer relative" onclick="me()" 
						alt="${ sessionScope.user.username }'s 프로필 이미지" width="40" height="40">
						
					<div id="mo" class="hidden w-auto h-auto absolute top-14 right-0 z-50 bg-white shadow-xl border">
					    <div class="flex p-4 pr-8">
					        <img src="${ fuck }/source/img/mycloud-profile.jpeg" class="w-16 h-16 rounded-full object-cover cursor-pointer mr-3" 
					            onclick="side()" alt="${ sessionScope.user.username }의 프로필 이미지">
					        <div>
					        	<p class="text-lg font-semibold">${ sessionScope.user.username }</p>
					        	<p class="text-md text-gray-600">${ sessionScope.user.useremail }</p>
					        	<a href="${ cl }/${ sessionScope.user.fileAccessKey }" class="text-blue-500 hover:underline break-words">
						            ${ sessionScope.user.fileAccessKey }
						        </a>
					        </div>
					    </div>
					
					    <form action="${ cl }/logout" method="post" autocomplete="off">
					        <button type="submit" 
					            class="w-full bg-black text-white text-md px-4 py-2 transition hover:bg-gray-800">
					            로그아웃
					        </button>
					    </form>
					</div>

					<div id="momo" class="hidden fixed top-0 left-0 w-full h-full z-30" onclick="closeMe()"></div>
				</div>
			</c:when>
			<c:otherwise>
				<div>
					<a href="${ cl }/login" class="mr-5 text-md">로그인</a>
					<a href="${ cl }/signUp" class="text-md">계정생성</a>
				</div>
			</c:otherwise>
		</c:choose>
	</header>
	
	<div id="loading" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%;
	     background: white; display: flex; justify-content: center; align-items: center; z-index: 9999;">
	</div>
	
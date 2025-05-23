<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cl" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원가입</title>
</head>
<body>

	<%
	    String c = request.getRequestURL().toString();
	    String url = c.substring(0, c.indexOf("/", c.indexOf("://") + 3)) + "/mycloud";
	    request.setAttribute("fuck", url);
	%>
	
	<header style="height: 60px;" class="fixed top-0 left-0 bg-white z-20 w-full flex justify-between align-center px-5 py-4 border-b">
		<div style="height: 60px; display: flex;">
			<a href="${ cl }/" class="font-semibold text-xl">마이 <span class="text-blue-600">클라우드</span></a>
		</div>
		<c:choose>
			<c:when test="${ not empty sessionScope.user }">
				<div class="flex justify-between items-center">
					<img src="${ fuck }/source/img/mycloud-profile.jpeg" class="cursor-pointer relative" onclick="me()" 
						alt="${ sessionScope.user.username }'s 프로필 이미지" width="40" height="40">
						
					<div id="mo" class="hidden w-auto h-auto absolute top-12 right-12 border border-black z-50 bg-gray-100 px-4 py-4 rounded-lg shadow-xl">
					    <div class="flex mb-4 pr-4">
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
					            class="w-full bg-black text-white text-md px-4 py-1.5 rounded-lg transition hover:bg-gray-800">
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
	
	<div id="infoBar" class="hidden fixed top-16 left-0 w-full bg-teal-100 border-t-4 border-teal-500 rounded-b text-teal-900 px-4 py-3 shadow-md z-30" role="alert">
		<div class="flex">
			<div class="py-1">
				<svg class="fill-current h-6 w-6 text-teal-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
					<path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z"/>
      			</svg>
    		</div>
    		<div>
      			<p id="infoTitle" class="font-bold"></p>
      			<p id="infoMessage" class="text-sm"></p>
    		</div>
  		</div>
	</div>

	<div class="flex lg:min-h-screen max-lg:mt-12">
	    <div class="hidden lg:flex lg:w-1/2 bg-black items-center justify-center">
	        <div class="max-w-md text-center">
	            <img src="https://d1nuzc1w51n1es.cloudfront.net/28a7682cea92bd8f54ba.png" alt="MyCloud 서비스 이미지" class="mx-auto mb-8 rounded-lg shadow-lg" />
	            <h2 class="text-3xl font-bold text-white mb-2">마이 <span class="text-blue-600">클라우드</span> 오신 것을 <br> 환영합니다</h2>
	            <p class="text-blue-100">안전하고 빠른 클라우드 서비스를 경험해보세요</p>
	        </div>
	    </div>
	
	    <div class="w-full lg:w-1/2 flex items-center justify-center px-6 py-8">
	        <div class="w-full max-w-md">
	            <div class="text-center">
	                <p class="text-4xl font-bold">마이 <span class="text-blue-600">클라우드</span></p>
	            </div>
	
	            <div class="bg-white rounded-lg p-8">
	                <h2 class="text-2xl font-semibold text-gray-800 mb-6 text-center">계정생성</h2>
	
					<div class="space-y-5">
		                <div>
			                <label for="username" class="block text-sm font-medium text-gray-700 mb-1">사용자 이름</label>
			                <input id="username" name="username" type="text" required placeholder="홍길동" 
			                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
		                	<div id="username-feedback"></div>
		                </div>
	                    <div>
		                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">이메일</label>
		                    <input id="email" name="email" type="email" required placeholder="example@gmail.com" 
		                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
	                    </div>
	                    <div>
							<label for="password" class="block text-sm font-medium text-gray-700 mb-1">비밀번호</label>
	                        <input id="password" name="password" type="text" required placeholder="1234" 
	                        	class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
						</div>
						
	                    <div>
	                    	<button type="button" onclick="submit()" class="w-full bg-blue-600 text-white py-3 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 
	                    		focus:ring-blue-500 focus:ring-offset-2 transition-colors duration-300 font-medium">
			                    계정생성
		                    </button>
						</div>
					</div>
	
	                <p class="mt-6 text-center text-sm text-gray-600">
	                    이미 계정이 있으신가요?
	                    <a href="${ cl }/login" class="font-medium text-blue-600 hover:text-blue-500">로그인</a>
	                </p>
	            </div>
	
	            <div class="mt-8 text-center text-sm text-gray-500">
	                <p>© 2025 MyCloud. All rights reserved.</p>
	            </div>
	        </div>
	    </div>
	</div>

	<%@ include file="/common/footer.jsp" %>
	<script src="${ cl }/source/js/signup.js"></script>
	
</body>
</html>
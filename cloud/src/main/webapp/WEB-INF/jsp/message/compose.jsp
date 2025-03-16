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
	<title>마이 클라우드</title>
</head>
<body onclick="document.getElementById('list').classList.add('hidden')">
	<%@ include file="/common/header.jsp" %>

    <div class="flex flex-col md:flex-row">
        <nav class="w-full lg:w-64 bg-white p-4 mb-4 lg:mb-0 hidden lg:block max-lg:fixed h-full z-20">
		    <ul class="space-y-4">
		    	<li>
				    <a href="${ cl }/" class="flex items-center gap-2 block px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-full">
				        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				            <path d="M3 12l9-9 9 9" />
				            <path d="M4 10v10h16V10" />
				            <path d="M9 21V12h6v9" />
				        </svg>
				        홈
				    </a>
				</li>
		        <c:if test="${ not empty sessionScope.user and (descSize lt 1000 or empty descSize) }">
		            <li>
		                <a href="${ cl }/upload" class="flex items-center gap-2 block px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-full">
		                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                        <path d="M12 19V5"></path>
		                        <path d="M5 12l7-7 7 7"></path>
		                        <path d="M19 21H5"></path>
		                    </svg>
		                    업로드
		                </a>
		            </li>
		        </c:if>
		        <li>
		            <a href="${ cl }/file" class="flex items-center gap-2 block px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-full">
		                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                    <path d="M6 2h12l4 4v14H2V2h4zm2 2v2h8V4H8zm-2 4v10h12V8H6z"></path>
		                </svg>
		                내 파일
		            </a>
		        </li>
		        <li>
		            <a href="${ cl }/compose" class="flex items-center gap-2 block px-4 py-2 text-gray-700 bg-blue-100 rounded-full">
		                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                    <path d="M21 11.5a8.38 8.38 0 0 1-14.6 5.9L2 20l2.6-4.4A8.38 8.38 0 0 1 21 11.5z"></path>
		                </svg>
		                메세지 보내기
		            </a>
		        </li>
		        <li>
		            <a href="${ cl }/chkmsg" class="flex items-center gap-2 block px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-full">
		                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                    <circle cx="12" cy="12" r="3"></circle>
		                    <path d="M2 12a10 10 0 1 1 20 0"></path>
		                </svg>
		                메세지 확인
		            </a>
		        </li>
		        <li>
				    <a href="${ cl }/remove" class="flex items-center gap-2 block px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-full">
				        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4z"></path>
				            <path d="M2 20c0-5 4-9 9-9s9 4 9 9"></path>
				        </svg>
				        계정 관리
				    </a>
				</li>
				<li>
				    <a href="${ cl }/access" class="flex items-center gap-2 block px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-full">
					    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					        <path d="M12 2C9.79 2 8 3.79 8 6C8 7.1 8.6 8.16 9.44 8.67L9.5 8.73L14.59 14L13.17 15.42L8.09 10.18C7.46 10.7 6.48 11 5.5 11C3.57 11 2 9.43 2 7.5C2 5.57 3.57 4 5.5 4C7.03 4 8.37 4.77 8.87 5.94C9.67 5.44 10.8 5 12 5C14.21 5 16 6.79 16 9C16 9.89 15.6 10.84 14.77 11.35L14.71 11.41L12 14.41L12.75 15.47L16.96 11.72C18.35 10.63 18.35 8.37 17.23 7.03C16.09 5.67 13.99 6.21 12.92 7.89L12 9.41L11.08 7.89C9.99 6.21 7.89 5.67 6.77 7.03C5.65 8.37 5.65 10.63 7.04 11.72L9.25 15.47L8.5 14.41L8.59 14.16C8.95 13.57 10.3 12 12 12C13.7 12 14.95 12.57 15.41 13.16L12 12L14 11L14 8L12 5Z"></path>
					    </svg>
					    엑세스 키 사용
					</a>
				</li>
		    </ul>
		</nav>

        <main class="flex-1 p-6">
            <c:choose>
                <c:when test="${ empty sessionScope.user }">
                    <div class="bg-white p-4 rounded-lg shadow-md">
                        <h2 class="text-2xl font-bold mb-4">마이 <span class="text-blue-600">클라우드</span>에 오신 것을 환영합니다!</h2>
                        <p>로그인하여 파일을 관리하고 클라우드를 이용해 보세요. 바로 아래 버튼을 클릭하여 로그인 해주세요.</p>
                        <a href="${ cl }/login" class="bg-blue-600 text-white px-4 py-2 rounded-md mt-4 inline-block">로그인</a>
                    </div>
                </c:when>
                
                <c:otherwise>
                	<div>
		                <input type="text" id="resc" placeholder="수신자 (이메일)" required class="w-full px-4 py-2 text-md border-b focus:outline-none focus:border-black relative" oninput="chk()"><br>
		                <input type="text" id="title" placeholder="제목" required class="w-full px-4 py-2 text-md border-b focus:outline-none focus:border-black"><br>
		                <input type="hidden" id="receiveId" required readonly>
		                <div id="preview" class="border-b"></div>
		                <textarea id="message" rows="10" class="block p-2.5 w-full text-sm border-b focus:outline-none resize-none"></textarea>
		                <div class="flex items-center">
		                	<button id="compose" type="button" class="px-6 py-2 bg-blue-600 text-white my-4 rounded-full hover:opacity-80">보내기</button>
		                	<label for="file" class="flex items-center bg-black text-white text-base px-4 py-2 outline-none rounded-full cursor-pointer font-[sans-serif] mx-5">
		                		<svg xmlns="http://www.w3.org/2000/svg" class="w-6 mr-2 fill-white inline" viewBox="0 0 32 32">
		                			<path d="M23.75 11.044a7.99 7.99 0 0 0-15.5-.009A8 8 0 0 0 9 27h3a1 1 0 0 0 0-2H9a6 6 0 0 1-.035-12 1.038 1.038 0 0 0 1.1-.854 5.991 5.991 0 0 1 11.862 
		                				0A1.08 1.08 0 0 0 23 13a6 6 0 0 1 0 12h-3a1 1 0 0 0 0 2h3a8 8 0 0 0 .75-15.956z" data-original="#000000" />
						        	<path d="M20.293 19.707a1 1 0 0 0 1.414-1.414l-5-5a1 1 0 0 0-1.414 0l-5 5a1 1 0 0 0 1.414 1.414L15 16.414V29a1 1 0 0 0 2 0V16.414z" data-original="#000000" />
						      	</svg>
						      	파일 첨부
								<input type="file" id="file" class="hidden" />
						    </label>
		                </div>
		                <div id="list" class="shadow-xl hidden fixed top-16 max-h-60 overflow-y-auto border max-lg:left-48 lg:left-96 bg-white rounded-lg">
		
		                </div>
		            </div>
                </c:otherwise>
            </c:choose>	
        </main>
    </div>

	<%@ include file="/common/footer.jsp" %>
	<script src="${ cl }/source/js/compose.js"></script>
	
</body>
</html>
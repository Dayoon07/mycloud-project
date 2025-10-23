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
	<style>
	    /* 웹킷 기반 브라우저 (Chrome, Safari 등) */
	    progress::-webkit-progress-value { background-color: #2563EB; }
	    /* Firefox */
	    progress::-moz-progress-bar { background-color: #2563EB; }
	</style>
</head>
<body>
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
		        <c:if test="${ not empty sessionScope.user and (descSize lt 1024 or empty descSize) }">
		            <li>
		                <a href="${ cl }/upload" class="flex items-center gap-2 block px-4 py-2 text-gray-700 bg-blue-100 rounded-full">
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
		            <a href="${ cl }/compose" class="flex items-center gap-2 block px-4 py-2 text-gray-700 hover:bg-blue-100 rounded-full">
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
					    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" 
					    	class="lucide lucide-key-round-icon lucide-key-round">
					    	<path d="M2.586 17.414A2 2 0 0 0 2 18.828V21a1 1 0 0 0 1 1h3a1 1 0 0 0 1-1v-1a1 1 0 0 1 1-1h1a1 1 0 0 0 1-1v-1a1 1 0 0 1 1-1h.172a2 2 0 0 0 1.414-.586l.814-.814a6.5 6.5 0 1 0-4-4z"/>
					    	<circle cx="16.5" cy="7.5" r=".5" fill="currentColor"/>
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
                        <h2 class="text-2xl font-bold mb-4">클라우드에 오신 것을 환영합니다!</h2>
                        <p>로그인하여 파일을 관리하고 클라우드를 이용해 보세요. 바로 아래 버튼을 클릭하여 로그인 해주세요.</p>
                        <a href="${ cl }/login" class="bg-blue-600 text-white px-4 py-2 rounded-md mt-4 inline-block">로그인</a>
                    </div>
                </c:when>
                
                <c:otherwise>
					<h2 class="text-3xl font-semibold text-center px-4 py-2 rounded-md">업로드</h2>

					<span id="clse" class="hidden w-8 h-8 p-2 px-3 text-red-500 font-semibold cursor-pointer hover:bg-gray-100 rounded-full">X</span>
                    <div id="preview-div" class="w-full mx-auto p-2 m-2"></div>

					<form id="upload-form" autocomplete="off" enctype="multipart/form-data" class="max-w-xl mx-auto px-3">
						<div class="flex items-center justify-center w-full" id="cloudUI">
							<label for="dropzone-file" class="flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100">
								<div class="flex flex-col items-center justify-center pt-5 pb-6">
									<svg class="w-8 h-8 mb-4 text-gray-500" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 16">
				                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2"></path>
				                    </svg>
									<p class="text-xs text-gray-500">파일 업로드</p>
								</div>
								<input id="dropzone-file" type="file" name="file" class="hidden" onchange="previewFile()" />
							</label>
						</div><br>
						
						<div class="w-full">
							<p id="uploadText"></p>
							<progress id="upload-progress" value="0" max="100" class="w-full hidden"></progress>
						</div>
				
						<button type="button" id="upload-btn" class="px-6 py-2 bg-black text-white w-full rounded hidden">업로드</button>
					</form>
                </c:otherwise>
            </c:choose>
        </main>
    </div>

	<%@ include file="/common/footer.jsp" %>
	<script src="${ cl }/source/js/upload.js"></script>
</body>
</html>
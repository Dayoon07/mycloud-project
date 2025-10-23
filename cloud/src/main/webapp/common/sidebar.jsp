<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

		<nav class="w-full lg:w-64 bg-white p-4 mb-4 lg:mb-0 hidden lg:block max-lg:fixed h-full z-20">
		    <ul class="space-y-4">
		    	<li>
				    <a href="${ cl }/" class="flex items-center gap-2 block px-4 py-2 text-gray-700 bg-blue-100 rounded-full">
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

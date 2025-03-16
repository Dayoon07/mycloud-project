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
<body>
	<%@ include file="/common/header.jsp" %>

    <div class="flex flex-col lg:flex-row">
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
					    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					        <path d="M12 2C9.79 2 8 3.79 8 6C8 7.1 8.6 8.16 9.44 8.67L9.5 8.73L14.59 14L13.17 15.42L8.09 10.18C7.46 10.7 6.48 11 5.5 11C3.57 11 2 9.43 2 7.5C2 5.57 3.57 4 5.5 4C7.03 4 8.37 4.77 8.87 5.94C9.67 5.44 10.8 5 12 5C14.21 5 16 6.79 16 9C16 9.89 15.6 10.84 14.77 11.35L14.71 11.41L12 14.41L12.75 15.47L16.96 11.72C18.35 10.63 18.35 8.37 17.23 7.03C16.09 5.67 13.99 6.21 12.92 7.89L12 9.41L11.08 7.89C9.99 6.21 7.89 5.67 6.77 7.03C5.65 8.37 5.65 10.63 7.04 11.72L9.25 15.47L8.5 14.41L8.59 14.16C8.95 13.57 10.3 12 12 12C13.7 12 14.95 12.57 15.41 13.16L12 12L14 11L14 8L12 5Z"></path>
					    </svg>
					    엑세스 키 사용
					</a>
				</li>
		    </ul>
		</nav>

        <main class="flex-1 p-6">
                    <div class="lg:block hidden overflow-x-auto mt-6">
					    <table class="min-w-full divide-y divide-gray-200">
						    <thead class="bg-gray-200">
						        <tr>
						            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider flex items-center">
						                <span>이름</span>
						            </th>
						            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
						                수정한 날짜
						            </th>
						            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
						                소유자
						            </th>
						            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
						                크기
						            </th>
						            <th scope="col" class="relative px-6 py-3">
						                <span class="sr-only">Actions</span>
						            </th>
						        </tr>
						    </thead>
						    <tbody class="bg-white divide-y divide-gray-200">
						    	<c:if test="${ not empty diffFileList }">
						    		${ diffFileList[0].userVo.username }
									<c:forEach var="dfl" items="${ diffFileList }">
										<tr class="hover:bg-gray-100 cursor-pointer">
											<td class="px-6 py-4 whitespace-nowrap">
												<div class="flex items-center">
													<c:if test="${ dfl.fileVo.fileName.length() > 30 }">
														<a href="${ dfl.fileVo.fileLocation }" download="${ dfl.fileVo.fileName }" class="font-medium">${ dfl.fileVo.fileName.substring(0, 30) }...</a>
													</c:if>
													<c:if test="${ dfl.fileVo.fileName.length() < 30 }">
														<a href="${ dfl.fileVo.fileLocation }" download="${ dfl.fileVo.fileName }" class="font-medium">${ dfl.fileVo.fileName }</a>
													</c:if>
												</div>
											</td>
											<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
												${ dfl.fileVo.createAt.substring(0, 4) }년 ${ dfl.fileVo.createAt.substring(5, 6) }월 ${ dfl.fileVo.createAt.substring(7, 8) }일
											</td>
											<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
												${ dfl.userVo.username }
											</td>
											<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
												${ dfl.fileVo.fileSize }MB
											</td>
											<td class="whitespace-nowrap text-sm text-right">
												<div class="flex space-x-2 justify-end">
													<a href="${ dfl.fileVo.fileLocation }" download="${ dfl.fileVo.fileName }" class="text-blue-600 hover:text-blue-800 mr-3">
											            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
											                <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4"></path>
											                <polyline points="7 10 12 15 17 10"></polyline>
											                <line x1="12" y1="15" x2="12" y2="3"></line>
											            </svg>
											        </a>
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:if>
						    </tbody>
						</table>
					</div>
					<div class="lg:hidden block mt-6">
						<c:if test="${ empty diffFileList }">
							<h1 class="text-xl font-semibold">존재하지 않는 엑세스 키입니다</h1>
						</c:if>
						<c:if test="${ not empty diffFileList }">
							<span class="text-2xl">${ diffFileList[0].userVo.username }</span>
							<c:forEach var="dfl" items="${ diffFileList }">
								<div class="bg-white py-4 border-b relative">
									<h3 class="text-lg font-bold text-gray-800 dark:text-white">
							    		<div class="flex items-center">
											<c:if test="${ dfl.fileVo.fileName.length() > 30 }">
												<a href="${ dfl.fileVo.fileLocation }" download="${ dfl.fileVo.fileName }" class="font-medium">${ dfl.fileVo.fileName.substring(0, 30) }...</a>
											</c:if>
											<c:if test="${ dfl.fileVo.fileName.length() < 30 }">
												<a href="${ dfl.fileVo.fileLocation }" download="${ dfl.fileVo.fileName }" class="font-medium">${ dfl.fileVo.fileName }</a>
											</c:if>
										</div>
							  		</h3>
							  		<p class="text-gray-500 dark:text-neutral-400">
							  			${ dfl.fileVo.createAt.substring(0, 4) }년 ${ dfl.fileVo.createAt.substring(5, 6) }월 ${ dfl.fileVo.createAt.substring(7, 8) }일
							  		</p>
							  		<p class="text-sm">크기 : ${ dfl.fileVo.fileSize }MB</p>
							  		<div class="flex space-x-2 justify-end absolute bottom-4 right-0">
													<a href="${ dfl.fileVo.fileLocation }" download="${ dfl.fileVo.fileName }" class="text-blue-600 hover:text-blue-800 mr-3">
											            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
											                <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4"></path>
											                <polyline points="7 10 12 15 17 10"></polyline>
											                <line x1="12" y1="15" x2="12" y2="3"></line>
											            </svg>
											        </a>
												</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
        </main>
    </div>

	<%@ include file="/common/footer.jsp" %>
	
</body>
</html>
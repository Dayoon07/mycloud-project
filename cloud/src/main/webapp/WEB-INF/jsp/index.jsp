<%@page import="java.text.DecimalFormat"%>
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
        <%@ include file="/common/sidebar.jsp" %>

        <main class="flex-1 p-6">
            <c:choose>
                <c:when test="${ empty sessionScope.user }">
                    <div class="p-4">
                        <h2 class="text-2xl font-bold mb-4">마이 <span class="text-blue-600">클라우드</span>에 <br class="block md:hidden"> 오신 것을 환영합니다!</h2>
                        <p>로그인하여 파일을 관리하고 클라우드를 이용해 보세요. 바로 아래 버튼을 클릭하여 로그인 해주세요.</p>
                        <a href="${ cl }/login" class="bg-blue-600 text-white px-4 py-2 rounded-md mt-4 hover:bg-blue-700 inline-block">로그인</a>
                    </div><br>
                    <div class="p-4">
	            		<input type="text" id="accesskey" oninput="accesskeyLoc()" placeholder="1ab2c3d4e5f6g7" required class="w-60 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 
	            			focus:border-blue-500 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
                    	<a id="accesskeyLocation" class="bg-blue-600 text-white px-4 py-2 rounded-md mt-4 hover:bg-blue-700 inline-block">엑세스 키 사용하기</a>
                    </div>                	
                </c:when>
                
                <c:otherwise>
                    <h2 class="text-xl font-semibold mb-4">
                    	최근 파일 <span class="md:inline hidden">•</span><br class="md:hidden">
                    	사용 용량 ${ descSize == null ? '없음' : descSize += 'MB' } 
                    	<c:if test="${ not empty descSize }">
                    		<span class="md:inline hidden">• </span><br class="md:hidden"> ${ (descSize / 1024) * 100 }% 사용
                    	</c:if>
                    </h2>
                    <c:if test="${ not empty descSize and descSize > 1024 }">
                    	<h1 class="text-xl font-semibold">용량을 초과했습니다.</h1>
                    </c:if>
                    <c:if test="${ not empty descSize and descSize < 1024 }">
						<div class="w-full bg-gray-200 h-2.5 rounded-full dark:bg-gray-700">
							<div class="bg-blue-600 h-2.5 rounded-full" style="width: ${ (descSize / 1024) * 100 }%;"></div>
						</div>
					</c:if>
                    
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
						            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
						                공개 여부
						            </th>
						            <!-- 
						            <th scope="col" class="relative px-6 py-3">
						                <span class="sr-only">Actions</span>
						            </th>
						            -->
						        </tr>
						    </thead>
						    <tbody class="bg-white divide-y divide-gray-200">
						    	<c:if test="${ not empty myFiles }">
							        <c:forEach var="mf" items="${ myFiles }" varStatus="mfStatus">
							        	<c:if test="${ mfStatus.index < 20 }">
								            <tr class="hover:bg-gray-100 cursor-pointer">
								                <td class="px-6 py-4 whitespace-nowrap">
								                    <div class="flex items-center">
								                    	<c:if test="${ mf.fileName.length() > 30 }">
									                        <a href="${ cl }/lk/${ mf.fileLink }" class="font-medium">${ mf.fileName.substring(0, 30) }...</a>
								                    	</c:if>
								                    	<c:if test="${ mf.fileName.length() < 30 }">
									                        <a href="${ cl }/lk/${ mf.fileLink }" class="font-medium">${ mf.fileName }</a>
								                    	</c:if>
								                    </div>
								                </td>
								                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
								                    ${ mf.createAt.substring(0, 4) }년 ${ mf.createAt.substring(5, 6) }월 ${ mf.createAt.substring(7, 8) }일
								                </td>
								                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
								                    나
								                </td>
								                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
								                    ${ mf.fileSize }MB
								                </td>
								                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
								                    <c:choose>
								                    	<c:when test="${ mf.filePrivate eq 'N' }">
								                    		공개
								                    	</c:when>
								                    	<c:otherwise>
								                    		비공개
								                    	</c:otherwise>
								                    </c:choose>
								                </td>
								            </tr>
										</c:if>
							        </c:forEach>
						        </c:if>
						    </tbody>
						</table>
					</div>
					<div class="lg:hidden block mt-6">
						<c:forEach var="mf" items="${ myFiles }" varStatus="mfStatus">
							<c:if test="${ mfStatus.index < 20 }">
								<div class="bg-white py-4 border-b">
									<h3 class="text-lg font-bold text-gray-800 dark:text-white">
							    		<c:if test="${ mf.fileName.length() > 30 }">
								      		<a href="${ cl }/lk/${ mf.fileLink }">${ mf.fileName.substring(0, 30) }...</a>
										</c:if>
							            <c:if test="${ mf.fileName.length() < 30 }">
								        	<a href="${ cl }/lk/${ mf.fileLink }">${ mf.fileName }</a>
							            </c:if>
							  		</h3>
							  		<p class="text-gray-500 dark:text-neutral-400">
							  			${ mf.createAt.substring(0, 4) }년 ${ mf.createAt.substring(4, 6) }월 ${ mf.createAt.substring(6, 8) }일
							  		</p>
							  		<p class="mt-2 text-sm font-medium uppercase">
							    		공개 여부 : 
							    		<c:if test="${ mf.filePrivate eq 'N' }">
							    			공개
							    		</c:if>
							    		<c:if test="${ mf.filePrivate eq 'Y' }">
							    			비공개
							    		</c:if>
							  		</p>
							  		<p class="text-sm">크기 : ${ mf.fileSize }MB</p>
								</div>
							</c:if>
						</c:forEach>
					</div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>

	<%@ include file="/common/footer.jsp" %>
	
</body>
</html>
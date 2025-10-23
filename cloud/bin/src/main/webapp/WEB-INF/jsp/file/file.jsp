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

    <div class="flex flex-col md:flex-row">
        <%@ include file="/common/sidebar.jsp" %>

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
                    <h2 class="text-xl font-semibold mb-4">📁 내 파일</h2>

                    <div id="realContent">
                    	<img src="${ fileButForUser.get().fileLocation }" width="300">
                    	<video src="${ fileButForUser.get().fileLocation }" controls width="500"></video>
                    </div>
                    
                </c:otherwise>
            </c:choose>
        </main>
    </div>

	<%@ include file="/common/footer.jsp" %>
</body>
</html>
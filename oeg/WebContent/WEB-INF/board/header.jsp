<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
    function confirmInitDB() {
    	if ( confirm("정말 초기화 하시겠습니까?")  ) {
    		return true;
    	} else {
    		return false;
    	}
    }
</script>
</head>

<body>
    <div id="header">
		<p class="page_header">		  
                      openeg.co.kr  
		</p>
	</div>
	<div id="navigation">
		<ul>
			<li><a href="<%=request.getContextPath()%>/index.html">홈으로</a></li>
			<li><a href="<%=request.getContextPath()%>/board/list.do">게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/test/test.do?no=0">보안코딩테스트</a></li>
			<li><a href="<%=request.getContextPath()%>/test/esapi_test.do">ESAPI 테스트</a></li>
			<li><a href="http://openeg.co.kr" target="_blank">OpenEG</a></li>
			<li><a href="http://cafe.naver.com/sunschool" target="_blank">SunSchool</a></li>
			<li><a href="<%=request.getContextPath()%>/test/init_db.do?id=${userId}"  onclick="return confirmInitDB();">DB초기화</a></li>
		</ul>
	</div>
</body>
</html>
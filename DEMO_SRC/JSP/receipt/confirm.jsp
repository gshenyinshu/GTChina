<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<jsp:useBean id="message" class="java.lang.String" scope="request"/>
<jsp:useBean id="toURL" class="java.lang.String" scope="request"/>

<html>
<head>



<script language='javascript' src='/common/js/common.js'></script>
<title>지티원</title>

<script language="javascript">
    function showMsg()
    {
		if(confirm('<%=message%>'))
		{
	
		}
		else
		{
			alert("취소");
		}
		
    }
</script>
</head>
<body onLoad="javascript:showMsg()">
</body>
</html>
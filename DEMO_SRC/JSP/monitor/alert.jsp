<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<jsp:useBean id="message" class="java.lang.String" scope="request"/>
<jsp:useBean id="toURL" class="java.lang.String" scope="request"/>
<jsp:useBean id="check_form" class="java.lang.String" scope="request"/>

<html>
<head>
<script language='javascript' src='/common/js/common.js'></script>
<title>��Ƽ��</title>

<%
	//���Ѱ���-����ڵ��
	if( check_form.equals("Y") ){
%>
<script language="javascript">
    function showMsg()
    {
		alert('<%=message%>');		
		<% if (toURL == null || toURL.equals("")) { %>		
			document.location.href="javascript:history.back(-2);";
		<% } else { %>
			window.close();//���Ѱ��� â�ݱ�
			//setTimeout("opener.window.close();",1000);
		<% 	} %>
    }
</script>
<%
	}else{
%>
<script language="javascript">
    function showMsg()
    {
		alert('<%=message%>');
		
		<% if (toURL == null || toURL.equals("")) { %>		
			document.location.href="javascript:history.back(-2);";
		<% } else { %>
			document.location.href='<%=toURL%>';
		<% 	} %>
    }
</script>
<% 	} %>
</head>
<body onLoad="javascript:showMsg()">
</body>
</html>
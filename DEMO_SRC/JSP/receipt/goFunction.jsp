<%
/**
 * Title       	: goFunction.jsp - ���������
 * Description 	: ���̹�����Ÿ 
 * Copyright   	: Copyright (c) 2004
 * Company      : CyberImagination
 * @author 	    : Jung Hun - PARK
 * @version 1.0
 */
%> 
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*" %>  
<%@ page import="java.text.*" %>
<%@ page import="anyframe.util.*"%>
<%@ page import="anyframe.data.DataSet"%>
<jsp:useBean id="message" 			class="java.lang.String" scope="request"/>
<jsp:useBean id="goFunction" 		class="java.lang.String" scope="request"/>

<html> 
<head>



<script language='javascript' src='/common/js/common.js'></script>
<title>��Ƽ��</title>
<%
	message = StringFormater.replaceStr(message,"&enter","\\n\\n");
	
%>
<script language="JavaScript">
<!--
<%

	if(!message.equals("")) out.println("alert('"+message+"');");
	if(!goFunction.equals("")) out.println(""+goFunction+";");
%>
//-->
</script>


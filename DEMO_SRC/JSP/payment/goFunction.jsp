<%
/**
 * Title       	: goFunction.jsp - 결과페이지
 * Description 	: 사이버고객센타 
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
<title>지티원</title>
<%
	message = StringFormater.replaceStr(message,"&enter","\\n\\n");
	
%>
<script language="JavaScript">
<!--
<%

	if(!message.equals("")) out.println("alert('"+message+"');");   //메세지가 있으면 메세지를 뿌린다.
	if(!goFunction.equals("")) out.println(""+goFunction+";");	     //실행할 스크립트가 있으면 실행한다.
	
%>

//-->
</script>


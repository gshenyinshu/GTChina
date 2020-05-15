<%
/**
 * Title       : login_check
 * Description : ÁÂÃø¸Þ´º¿¡¼­ "logout"´­·¶À»°æ¿ì ¼¼¼Ç ¾ø¾Ú
 * File        : /payment/login_check.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : jung-hun Park
 * First Write : 2005.02.17
 * update date : 
 * update desc :
 */
%>

<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<jsp:useBean id="islogin" class="java.lang.String" scope="request"/>

<script language="javascript">
<%
	if( islogin.equals("N") )
	{
%>	
		document.location.href="/payment/cyber_login.do";
<%
	}
%>
</script>

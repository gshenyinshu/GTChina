<%
/**
 * Title       : process_login_frist
 * Description : 로그인했을 경우 세션check
 * File        : /payment/process_login_frist.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : jung-hun Park
 * First Write : 2005.02.17
 * update date : 
 * update desc :
 */
%>
  
<% 
	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	   

	
	//System.out.println("#############################process_login_first.jsp ===> emp_no : "+ emp_no);

  
	String islogin = "";
	if( emp_no.equals("") || emp_no.equals("null") )
	{
		islogin = "N";
	}
%>	
   

<script language="javascript">
<!--
<%
//out.println("#############################process_login_first.jsp ===> emp_no : "+ emp_no);
//out.println("#############################process_login_first.jsp ===> islogin : "+ islogin);
//로그인여부 체크
	if( islogin.equals("N") )
	
	{
	
%>	

		document.location.href="/payment/cyber_login.do";
<%

	}
	
	%>
	
	

	
-->	
</script>

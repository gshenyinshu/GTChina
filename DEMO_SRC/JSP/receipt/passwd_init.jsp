<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*, anyframe.log.*, anyframe.*,anyframe.db.*,anyframe.data.*, anyframe.util.*" %>

<%
String ready = request.getParameter("ready") == null ? "no" : request.getParameter("ready");

if(ready.equals("yes")){
	try	{
//update aaaaaa 초기화 prudb_tbl_userinfo
//+raprw1CVwn+iebXgsaXKw== 

		String ssn = request.getParameter("init_ssn") == null ? "1234561111111" : request.getParameter("init_ssn");
		
		DataSet input = new DataSet();                                          			
		input.put("ssn",ssn);
		
		InteractionBean interact = new InteractionBean();                       
		interact.execute("/cybercenter/member/passwd_init", input);    	
	}

	catch(SQLException e)	{
	
		Logger.debug.println("SQL Execption......");
		e.printStackTrace();
	}

	catch(ResourceException re)	{
	
		Logger.debug.println("Resource Execption......");
		re.printStackTrace();
	}
	
	catch(Exception ex)	{
		Logger.debug.println("Execption......");
		ex.printStackTrace();
	}
%>
<script>
	alert("패스워드 초기화 완료");
	
	parent.opener.location.reload();
	parent.close();
</script>

<%
}
%>


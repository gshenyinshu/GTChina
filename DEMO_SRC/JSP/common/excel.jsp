<%@ page contentType="text/html;charset=euc-kr"	%>

<jsp:useBean id="excel" class="java.lang.String" scope="request"/>

<%
	System.out.println("################# excel ##########################");
	System.out.println(excel);
	System.out.println("################# excel ##########################");

	if ( !"".equals(excel) )
	{
		response.setHeader("Content-Disposition", "filename=excel.xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setContentType("application/vnd.ms-excel");
	}
%>
<%=excel%>






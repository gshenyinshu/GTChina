<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>
<%@ page import = "gtone.changeminer.common.utility.Utility" %>


<jsp:useBean id="list" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="total" class="java.lang.String" scope="request"/>
<jsp:useBean id="returnForm" class="anyframe.data.DataSet" scope="request"/>

<%
	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	
	String search = "";
	String searchStr = "";
	String pageNumber = "0";
	int count = Utility.nvlToNumber(total, 0);
	
//	out.println("search : "+returnForm.getText("search"));
%>

<html>
<head>
<title>특이사항</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>
</head>
<script language="javascript">
<!--	
	function search_func(){
		if(searchForm.search.value == "") {
			alert("검색조건을 선택해주세요");
			searchForm.search.focus();
		}else{
			searchForm.action = "/common/cyber_index.do";
			searchForm.submit();
		}
	}
//-->
</script>
<body>
<table>
	<tr>
		<td colspan="3" valign="top">
			<table  width="100%"  class="adm_table">
				<tr> 
					<th >날짜</th>
					<th >사유</th>
				</tr>
<!-- 리스트 반복 부분 -->
<%
//out.println("success size : "+success.size());
//out.println("fail size : "+fail.size());
if(list.getCount("seq") > 0)
{
	String bgcolor;
	String createdate;
	String cause;

	for ( int i = 0 ; i < list.getCount("seq") ; i++ )
	{
		if(i%2==0) bgcolor = "lp04";
		else bgcolor = "lp05";

		createdate = list.getText("createdate", i);
		cause = list.getText("cause", i);
%>
							<tr align="center">
								<td ><div align="center"><%=createdate.substring(0,10)%></div></td>
								<td ><div align="center"><%=cause%></div></td>
							</tr>
<%  }
}else{%>
							<tr class="lp04"> 
								<td colspan='6' class="view_right"><div align="center">자료가 없습니다.</div></td>
							</tr>
<%}%>
			</table>					
		</td>
	</tr>
	<!----------------------------검색------------------>
	<!--tr><form name="searchForm" onSubmit="return false;">
		<input type="hidden" name="run" value="cause">
		<td colspan="3" style="height:0%">
		
		  
			<select name="search">
				<option>선택</option>
				<option value="content"  <%if ("content".equals(returnForm.getText("search"))) out.println("selected");%>>사유</option>
				<option value="date" <%if ("date".equals(returnForm.getText("search"))) out.println("selected");%>>날짜</option>
			</select>
			<input type="text" name="searchStr" value="<%=returnForm.getText("searchStr")%>" > 
		  
		  <a href="javascript:search_func();"><img src="/img/common/btn_inquiry.gif" border='0' align="absmiddle"></a></td>
		</form>
	</tr-->
	<!----------------------------검색-끝--------------------------------->
	<tr>
		<td style="width:10%;height:0%">&nbsp;</td>
		<td align="center" >
<!----------------------------페이징------------------>
<%	
	int nRow = 10;
	int pageNum = Utility.nvlToNumber(pageNumber, 1);
	int nLast = count / nRow;

	if(count%nRow != 0) nLast = nLast+1;
	int limit = 10;
	int posi = (pageNum - 1) % limit;
	int sPage = pageNum - posi;
		
	String pageView = "";

	if (sPage - limit > 0)
		out.println("<a href='/common/cyber_index.do?run=cause&pageNumber="+String.valueOf(sPage-1)+"&search="+search+"&searchStr="+searchStr+" '><img src='/img/common/paging_btn_prev.gif' width='32' height='9' alt='' border='0' align='absmiddle'></a>");
	else out.println("<img src='/img/common/paging_btn_prev.gif' width='32' height='9' alt='' border='0' align='absmiddle'>");

	out.println("|");

	for(int i=sPage; i<sPage+limit; i++){
		if(i == pageNum) out.println("<span class='or01'>"+String.valueOf(i)+"</span> |");
		else 	out.println("<a href='/common/cyber_index.do?run=cause&pageNumber="+String.valueOf(i)+"&search="+search+"&searchStr="+searchStr+" '  class='pg'>"+String.valueOf(i)+"</a> |");
		if(i >= nLast)	break;
	}

	out.println(" ");
	if (sPage + limit <= nLast)
		out.println("<a href='/common/cyber_index.do?run=cause&pageNumber="+String.valueOf(sPage+limit)+"&search="+search+"&searchStr="+searchStr+" '><img src='/img/common/paging_btn_next.gif' width='38' height='9' alt='' border='0' align='absmiddle'></a>");
	else
		out.println("<img src='/img/common/paging_btn_next.gif' width='38' height='9' alt='' border='0' align='absmiddle'>");
%>
<!---------------------------------------------------------페이징-끝--------------------------------->					</td>
		<td align="center" style="width:10%"><a href="javascript:window.close();"><img src="/img/common/btn_close.gif" border='0'></a></td>
	</tr>
</table>

</body>
</html>


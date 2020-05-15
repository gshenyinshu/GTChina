<%
/* -----------------------------------------------------------------------------
 * Project Title	: 모니터링(고객정보변경) and 모니터링(동의철회/수신거부) 팝업창
 * File Name		: realtime_client.jsp
 * Programmer		: 
 * First Write		: 2004.12.08
 * Last Update		: 2004.12.08
 * R&D         		: CI
 * ---------------------------------------------------------------------------*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="client1" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="client2" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="srvc_cd" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>

<%
	if("A".equals(srvc_cd)){
%>
<%

	//안내장수신 변경여부
	String email_service_chk = "N";
	String email_service_chk_a = client2.getText("email_service_yn").trim();
	if( email_service_chk_a.equals("Y") )
	{
		email_service_chk = "Y";
	}
	
	//우편물수신 변경여부
	String post_send_chk = "N";
	String post_send_yn_chk_a = client2.getText("post_send_yn").trim();
	if( post_send_yn_chk_a .equals("Y") )
	{
		post_send_chk = "Y";
	}
	
	//자택주소 변경여부
	String home_addr_chk = "N";
	String home_addr_yn_chk_a = client2.getText("home_addr_yn").trim();
	if( home_addr_yn_chk_a .equals("Y") )
	{
		home_addr_chk = "Y";
	}
	
	//자택전화 변경여부
	String home_phone_chk = "N";
	String home_phone_yn_chk_a = client2.getText("home_phone_yn").trim();
	if( home_phone_yn_chk_a.equals("Y") )
	{
		home_phone_chk = "Y";
	}
	
	//직장주소 변경여부
	String office_addr_chk = "N";
	String office_addr_yn_a = client2.getText("office_addr_yn").trim();
	if( office_addr_yn_a.equals("Y") )
	{
		office_addr_chk = "Y";
	}

	//직장전화 변경여부
	String office_phone_chk = "N";
	String office_phone_yn_a = client2.getText("office_phone_yn").trim();
	if( office_phone_yn_a.equals("Y") )
	{
		office_phone_chk  = "Y";
	}

	//핸드폰 변경여부
	String mobile_chk = "N";
	String mobile_yn_a = client2.getText("mobile_yn").trim();
	if( mobile_yn_a.equals("Y") )
	{
		mobile_chk = "Y";
	}

	//이메일 변경여부
	String email_chk = "N";
	String email_yn_a = client2.getText("email_yn").trim();
	if( email_yn_a.equals("Y") )
	{
		email_chk = "Y";
	}	
	
	
%>					
<html>
<head>
<title>모니터링 - 고객정보변경</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>

<body>
<center>
    <table width="600">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			<td><img src="/img/common/bu_cir01.gif"> <b>고객정보변경 (주민번호:<%=client2.getText("ssn").substring(0,6)+"-"+client2.getText("ssn").substring(6)+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=12%> <col width=12%> <col width=38%> <col width=38%> 
					<tr> 
						<th colspan="2">구분</th>
						<th>변경 후</th>
						<th style="background: #A0B9E8;">변경 전</th>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="#F3F3F3">안내장 수신방법</td>
						<td><%if(email_service_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("email_service").trim()%></font></td>
						<td><%=client1.getText("email_service").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">우편물 수령지</td>
						<td><%if(post_send_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("post_send").trim()%></td>
						<td><%=client1.getText("post_send").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="4" bgcolor="F3F3F3">자택</td>
						<td align=center bgcolor="F3F3F3">우편번호</td>
						<td><%if(home_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_post").trim()%></font></td>
						<td><%=client1.getText("home_post").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="2" align=center bgcolor="F3F3F3">주소</td>
						<td><%if(home_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_addr1").trim()%></font></td>
						<td><%=client1.getText("home_addr1").trim()%></td>
					</tr>
					<tr> 
						<td><%if(home_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_addr2").trim()%></td>
						<td><%=client1.getText("home_addr2").trim()%></td>
					</tr>
					<tr> 
						<td bgcolor="F3F3F3">전화번호</td>
						<td><%if(home_phone_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_phone").trim()%></font></td>
						<td><%=client1.getText("home_phone").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="4" bgcolor="F3F3F3">직장</td>
						<td align=center bgcolor="F3F3F3">우편번호</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_post").trim()%></font></td>
						<td><%=client1.getText("office_post").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="2" align=center bgcolor="F3F3F3">주소</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr1").trim()%></font></td>
						<td><%=client1.getText("office_addr1").trim()%></td>
					</tr>
					<tr> 
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr2").trim()%></font></td>
						<td><%=client1.getText("office_addr2").trim()%></td>
					</tr>
					<tr> 
						<td bgcolor="F3F3F3">전화번호</td>
						<td><%if(office_phone_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_phone").trim()%></font></td>
						<td><%=client1.getText("office_phone").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">직장명</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr3").trim()%></font></td>
						<td><%=client1.getText("office_addr3").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">부서명</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr4").trim()%></font></td>
						<td><%=client1.getText("office_addr4").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">휴대전화번호</td>
						<td><%if(mobile_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("mobile").trim()%></font></td>
						<td><%=client1.getText("mobile").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">이메일</td>
						<td><%if(email_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("email").trim()%></font></td>
						<td><%=client1.getText("email").trim()%></td>
					</tr>
				</table></td>
		</tr>
		<tr><!--<td align="right"><a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" hspace="10"><img src="/img/common/btn_cancel.gif"></a></td>-->
			<td align="right"><a href="javascript:self.close()" onFocus="blur()"><img src="/img/common/btn_ok.gif" hspace="10"></a></td>
		</tr>
	</table>
</center>
</body>
</html>
<%} else if("N".equals(srvc_cd)) {%>
<html>
<head>
<title>모니터링 - 동의철회/수신거부</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>

<body>
<center>
    <table width="600">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			<td><img src="/img/common/bu_cir01.gif"> <b>동의철회/수신거부 (주민번호:<%=client2.getText("ssn").substring(0,6)+"-"+client2.getText("ssn").substring(6)+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=12%> <col width=12%> <col width=38%> <col width=38%> 
					<tr> 
						<th colspan="2">구분</th>
						<th>변경 후</th>
						<th style="background: #A0B9E8;">변경 전</th>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="#F3F3F3">정보제공 동의 철회</td>
						<td><%if(!client2.getText("appro").trim().equals(client1.getText("appro").trim())){%><font color="#2B63CA"><%}%>
						<%if("Y".equals(client2.getText("appro").trim())){%> 정보제공동의<%}else{%>정보제공동의철회 <%}%></font></td>
						<td><%if("Y".equals(client1.getText("appro").trim())){%> 정보제공동의<%}else{%>정보제공동의철회 <%}%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">전화수신 거부</td>
						<td><%if(!client2.getText("ncall").trim().equals(client1.getText("ncall").trim())){%><font color="#2B63CA"><%}%>
						<%if("Y".equals(client2.getText("ncall").trim())){%> 전화수신거부<%}else{%>전화수신허용 <%}%>
						</td>
						<td><%if("Y".equals(client1.getText("ncall").trim())){%> 전화수신거부<%}else{%>전화수신허용 <%}%></td>
					</tr>
				</table></td>
		</tr>
		<tr><!--<td align="right"><a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" hspace="10"><img src="/img/common/btn_cancel.gif"></a></td>-->
			<td align="right"><a href="javascript:self.close()" onFocus="blur()"><img src="/img/common/btn_ok.gif" hspace="10"></a></td>
		</tr>
	</table>
</center>
</body>
</html>
<%}%>
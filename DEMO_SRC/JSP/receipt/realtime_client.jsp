<%
/* -----------------------------------------------------------------------------
 * Project Title	: ����͸�(����������) and ����͸�(����öȸ/���Űź�) �˾�â
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

	//�ȳ������ ���濩��
	String email_service_chk = "N";
	String email_service_chk_a = client2.getText("email_service_yn").trim();
	if( email_service_chk_a.equals("Y") )
	{
		email_service_chk = "Y";
	}
	
	//�������� ���濩��
	String post_send_chk = "N";
	String post_send_yn_chk_a = client2.getText("post_send_yn").trim();
	if( post_send_yn_chk_a .equals("Y") )
	{
		post_send_chk = "Y";
	}
	
	//�����ּ� ���濩��
	String home_addr_chk = "N";
	String home_addr_yn_chk_a = client2.getText("home_addr_yn").trim();
	if( home_addr_yn_chk_a .equals("Y") )
	{
		home_addr_chk = "Y";
	}
	
	//������ȭ ���濩��
	String home_phone_chk = "N";
	String home_phone_yn_chk_a = client2.getText("home_phone_yn").trim();
	if( home_phone_yn_chk_a.equals("Y") )
	{
		home_phone_chk = "Y";
	}
	
	//�����ּ� ���濩��
	String office_addr_chk = "N";
	String office_addr_yn_a = client2.getText("office_addr_yn").trim();
	if( office_addr_yn_a.equals("Y") )
	{
		office_addr_chk = "Y";
	}

	//������ȭ ���濩��
	String office_phone_chk = "N";
	String office_phone_yn_a = client2.getText("office_phone_yn").trim();
	if( office_phone_yn_a.equals("Y") )
	{
		office_phone_chk  = "Y";
	}

	//�ڵ��� ���濩��
	String mobile_chk = "N";
	String mobile_yn_a = client2.getText("mobile_yn").trim();
	if( mobile_yn_a.equals("Y") )
	{
		mobile_chk = "Y";
	}

	//�̸��� ���濩��
	String email_chk = "N";
	String email_yn_a = client2.getText("email_yn").trim();
	if( email_yn_a.equals("Y") )
	{
		email_chk = "Y";
	}	
	
	
%>					
<html>
<head>
<title>����͸� - ����������</title>
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
			<td><img src="/img/common/bu_cir01.gif"> <b>���������� (�ֹι�ȣ:<%=client2.getText("ssn").substring(0,6)+"-"+client2.getText("ssn").substring(6)+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=12%> <col width=12%> <col width=38%> <col width=38%> 
					<tr> 
						<th colspan="2">����</th>
						<th>���� ��</th>
						<th style="background: #A0B9E8;">���� ��</th>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="#F3F3F3">�ȳ��� ���Ź��</td>
						<td><%if(email_service_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("email_service").trim()%></font></td>
						<td><%=client1.getText("email_service").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">���� ������</td>
						<td><%if(post_send_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("post_send").trim()%></td>
						<td><%=client1.getText("post_send").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="4" bgcolor="F3F3F3">����</td>
						<td align=center bgcolor="F3F3F3">�����ȣ</td>
						<td><%if(home_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_post").trim()%></font></td>
						<td><%=client1.getText("home_post").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="2" align=center bgcolor="F3F3F3">�ּ�</td>
						<td><%if(home_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_addr1").trim()%></font></td>
						<td><%=client1.getText("home_addr1").trim()%></td>
					</tr>
					<tr> 
						<td><%if(home_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_addr2").trim()%></td>
						<td><%=client1.getText("home_addr2").trim()%></td>
					</tr>
					<tr> 
						<td bgcolor="F3F3F3">��ȭ��ȣ</td>
						<td><%if(home_phone_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("home_phone").trim()%></font></td>
						<td><%=client1.getText("home_phone").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="4" bgcolor="F3F3F3">����</td>
						<td align=center bgcolor="F3F3F3">�����ȣ</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_post").trim()%></font></td>
						<td><%=client1.getText("office_post").trim()%></td>
					</tr>
					<tr> 
						<td rowspan="2" align=center bgcolor="F3F3F3">�ּ�</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr1").trim()%></font></td>
						<td><%=client1.getText("office_addr1").trim()%></td>
					</tr>
					<tr> 
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr2").trim()%></font></td>
						<td><%=client1.getText("office_addr2").trim()%></td>
					</tr>
					<tr> 
						<td bgcolor="F3F3F3">��ȭ��ȣ</td>
						<td><%if(office_phone_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_phone").trim()%></font></td>
						<td><%=client1.getText("office_phone").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">�����</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr3").trim()%></font></td>
						<td><%=client1.getText("office_addr3").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">�μ���</td>
						<td><%if(office_addr_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("office_addr4").trim()%></font></td>
						<td><%=client1.getText("office_addr4").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">�޴���ȭ��ȣ</td>
						<td><%if(mobile_chk.equals("Y")){%><font color="#2B63CA"><%}%><%=client2.getText("mobile").trim()%></font></td>
						<td><%=client1.getText("mobile").trim()%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">�̸���</td>
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
<title>����͸� - ����öȸ/���Űź�</title>
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
			<td><img src="/img/common/bu_cir01.gif"> <b>����öȸ/���Űź� (�ֹι�ȣ:<%=client2.getText("ssn").substring(0,6)+"-"+client2.getText("ssn").substring(6)+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=12%> <col width=12%> <col width=38%> <col width=38%> 
					<tr> 
						<th colspan="2">����</th>
						<th>���� ��</th>
						<th style="background: #A0B9E8;">���� ��</th>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="#F3F3F3">�������� ���� öȸ</td>
						<td><%if(!client2.getText("appro").trim().equals(client1.getText("appro").trim())){%><font color="#2B63CA"><%}%>
						<%if("Y".equals(client2.getText("appro").trim())){%> ������������<%}else{%>������������öȸ <%}%></font></td>
						<td><%if("Y".equals(client1.getText("appro").trim())){%> ������������<%}else{%>������������öȸ <%}%></td>
					</tr>
					<tr> 
						<td colspan="2" bgcolor="F3F3F3">��ȭ���� �ź�</td>
						<td><%if(!client2.getText("ncall").trim().equals(client1.getText("ncall").trim())){%><font color="#2B63CA"><%}%>
						<%if("Y".equals(client2.getText("ncall").trim())){%> ��ȭ���Űź�<%}else{%>��ȭ������� <%}%>
						</td>
						<td><%if("Y".equals(client1.getText("ncall").trim())){%> ��ȭ���Űź�<%}else{%>��ȭ������� <%}%></td>
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
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<%
	String srvc_code = "";
	String linkpage = "";
	
 
	
	//���ǿ��� ��������
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	//String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	//String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
%>
<jsp:useBean id="policyindiv" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="search" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="rslt" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="modeind" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" class="java.lang.String" scope="request"/>
<jsp:useBean id="status" class="java.lang.String" scope="request"/>
<jsp:useBean id="menu_mode" class="java.lang.String" scope="request"/>
<%




	
	if(menu_mode.equals("")){
	
		menu_mode = "6";
	
	
	}



	if(current.length() == 0 || current.equals("0"))
	{
		current = "1";
	}
	
	if(status.trim().length() == 0)
	{
		status = " ";
	}
	
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='/common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>

</head>
<script language="javascript">
<!--
	function goSearch()
	{
		document.form.current.value = 1;
		document.form.searchgubun.value = "S";
		document.form.submit();
	}

	function goDetail(cd1, cd2, cd3, cd4, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}	

		var path = "";
		path = "/receipt/"+cd1+"?indate="+cd2+"&seq_no="+cd3+"&srvc_cd="+cd4;
		
		if(cd4 == "A")
		{
			window.open(path, '����͸�', 'left=400,top=350,Width=700,Height=540, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		} 
		else if(cd4 == "B" || cd4 == "C" || cd4 == "D")
		{
			window.open(path, '����͸�', 'left=400,top=350,Width=525,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		} 
		else
		{
			window.open(path, '����͸�', 'left=400,top=350,Width=525,Height=170, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		}
	}
	
	
	function goHost(cd1, cd2, cd3, cd4, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}	

		document.form.searchgubun.value = "H";
		document.form.indate.value = cd1;
		document.form.seq_no.value = cd2;
		document.form.srvc_gubun.value = cd3;
		document.form.process_mode.value = cd4;
		document.form.submit();		
	}
	
	
	function openit(oform,obox)
	{
		var temp = "width=190,height=232,left="+(screen.width/2-110)+",top="+(screen.height/2-80);	
		window.open("../common/calen1.jsp?oform="+oform+"&obox="+obox,"datewindow",temp);
	}
	
	function goPage(num) 
	{
		document.form.current.value = num;
		document.form.method="get" ;
		document.form.submit();
	}	
	
	function ReLoadWindow(val)
	{				
		var srvc_value = '<%=srvc_ind%>';	
		var searchgubun = '<%=searchgubun%>';
		
		if(val == "") val = "1";
				
		if(val == "1")
		{
		
		
			if( '8' == '<%=menu_mode%>' && 'B'== srvc_value ){
			
				
				var AddOption0 = new Option("�ڵ���ü����", "B");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;					

			
			}else if('8' == '<%=menu_mode%>' && 'C'=='<%=srvc_ind%>'){
			
				var AddOption0 = new Option("�ڵ���ü����", "C");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;		
			
			}else if('9' == '<%=menu_mode%>' && 'I'=='<%=srvc_ind%>'){
			
				var AddOption0 = new Option("APL��û", "I");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;					
			
			}else if('9' == '<%=menu_mode%>' && 'J'=='<%=srvc_ind%>'){
			
				var AddOption0 = new Option("APL����", "J");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;					
			
			}else{
			
	
			
				var AddOption0 = new Option("�� ü" ,"Z");
				var AddOption = new Option("����������" ,"A");
				//var AddOption1 = new Option("�ڵ���ü����", "B");
				//var AddOption2 = new Option("�ڵ���ü����", "C")
				//var AddOption3 = new Option("�׷������û","D");
				//var AddOption4 = new Option("����ڵ���ȯ","E");
				//var AddOption5 = new Option("APL�ڵ���ȯ","F");
				var AddOption1 = new Option("���ֺ���","G");
				//var AddOption8 = new Option("APL��û","I");
				//var AddOption9 = new Option("APL����","J");
				

				
				document.forms[0].srvc_ind.length  = 3;
				document.forms[0].srvc_ind.options[0] = AddOption0;			
				//document.forms[0].srvc_ind.options[1] = AddOption;			
				//document.forms[0].srvc_ind.options[2] = AddOption3;			
				//document.forms[0].srvc_ind.options[3] = AddOption4;			
				//document.forms[0].srvc_ind.options[4] = AddOption5;			
				document.forms[0].srvc_ind.options[1] = AddOption;			
				document.forms[0].srvc_ind.options[2] = AddOption1;			
				//document.forms[0].srvc_ind.options[7] = AddOption6;			
				//document.forms[0].srvc_ind.options[8] = AddOption8;			
				//document.forms[0].srvc_ind.options[9] = AddOption9;			
				
				if(srvc_value == "Z") document.forms[0].srvc_ind.options[0].selected = true;
				if(srvc_value == "A") document.forms[0].srvc_ind.options[1].selected = true;
				//if(srvc_value == "B") document.forms[0].srvc_ind.options[2].selected = true;
				//if(srvc_value == "C") document.forms[0].srvc_ind.options[3].selected = true;
				//if(srvc_value == "D") document.forms[0].srvc_ind.options[2].selected = true;
				//if(srvc_value == "E") document.forms[0].srvc_ind.options[3].selected = true;
				//if(srvc_value == "F") document.forms[0].srvc_ind.options[4].selected = true;
				if(srvc_value == "G") document.forms[0].srvc_ind.options[2].selected = true;			
				//if(srvc_value == "I") document.forms[0].srvc_ind.options[8].selected = true;
				//if(srvc_value == "J") document.forms[0].srvc_ind.options[9].selected = true;
				
			
			
			}
			
					

		}
		else if(val == "2")
		{
			var AddOption = new Option("����", "1");
			
			document.forms[0].srvc_ind.length  = 1;
			document.forms[0].srvc_ind.options[0] = AddOption;					
			
			if(srvc_value == "1") document.forms[0].srvc_ind.options[0].selected = true;
		}
		else if(val == "3")
		{
			var AddOption = new Option("��Ȱ����", "2");
			
			document.forms[0].srvc_ind.length  = 1;
			document.forms[0].srvc_ind.options[0] = AddOption;					
			
			if(srvc_value == "2") document.forms[0].srvc_ind.options[0].selected = true;
		}
	}
	
	function goAllChange()
	{
	
		document.form.action ="/receipt/policy_change.do";
		document.form.submit();
	}

	function goChange(indate, seq_no, row, srvc_gubun, cnt, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}	

		document.form.indate.value = indate;
		document.form.seq_no.value = seq_no;
		document.form.searchgubun.value = "C";
		document.form.srvc_gubun.value = srvc_gubun;
		if(cnt == 1)
		{
			document.form.rtnflag.value = document.form.chgstatus.value;
		}
		else
		{
			document.form.rtnflag.value = document.form.chgstatus[row].value;
		}
		document.form.submit();	
	}
	
	
	function goReturn(cd1,cd2,cd3,deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}	

		var path = "";
		path = "/receipt/return_cause.do?indate="+cd1+"&seq_no="+cd2+"&srvc_gubun="+cd3+"&flag=S";
		window.open(path, '�ݼۻ���', 'left=400,top=350,Width=430,Height=280, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	}

	function goContent(cd1,cd2, cd3, cd4, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}	

		var path = "";
		path = "/receipt/return_content.do?indate="+cd1+"&seq_no="+cd2+"&srvc_gubun="+cd3+"&status_code="+cd4;
		window.open(path, '����', 'left=400,top=350,Width=630,Height=280, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	}	
	
	function winreflash()
	{
		document.form.action = "policy_indiv.do";	
		document.form.searchgubun.value = "S";			
		document.form.submit();
	}			
//-->
</script>
<body onLoad="javascript:ReLoadWindow('<%=modeind%>');">

<form name="form" method="post"  action="policy_indiv.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="indate">
<input type="hidden" name="seq_no">
<input type="hidden" name="srvc_gubun">
<input type="hidden" name="process_mode">
<input type="hidden" name="rtnflag">
<input type="hidden" name="menu_mode" value="<%=menu_mode%>">
<table width="100%" height="100%">
	<tr> 
		<td height=71><table width="100%" background="/img/common/logo_bg.gif">
				<tr> 
					<td><img src="/img/common/logo.gif"></td>
					<td align="right"><img src="/img/common/logo_end.gif"></td>
				</tr>
			</table></td>
	</tr>
	<tr> 
		<td><table width=100% height="100%">
				<col width=200> 
				<tr> 					
					<td align="center" class="menu">
						<!--DropDown ���� : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="<%=menu_mode%>"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					</td>
							<td class="contents"><table width="100%">
							<tr> 								
                  						<td><img src="/img/common/title_06.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"></td>
							</tr>
							<tr> 
								<td>
									<table width="100%">
										<tr> 											                        					
					                        <td><img src="/img/common/bu_cir01.gif"> 
					                        
					                        <b>����ó��(
					                        <%if(srvc_ind.equals("B")){%>
					                        
					                        �ڵ���ü����
					                        <%}else if(srvc_ind.equals("C")){ %>
					                        �ڵ���ü����
					                        <%}else if(srvc_ind.equals("I")){ %>
					                        
					                        APL��û
					                        
					                        <%}else if(srvc_ind.equals("J")){ %>
					                        APL����
					                         <%}else{ %>
					                        ��� �� ����������
					                        
					                        <%} %>
					                        )</b></td>
					                        <td align="right">&nbsp;</td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td><table width="100%" class="adm_table">
				                      <col width=12%>
				                      <col width=20%>
				                      <col width=>
				                      <col width=>
				                      <col width=>
				                      <col width=>
				                      <col width=25%>
				                      <tr> 
				                        <th width="8%" rowspan="2">�˻�����</th>
				                        <th width="18%">��������</th>
				                        <th width="13%">�����з�</th>
				                        <th width="9%">����</th>
				                        <th width="9%">���ΰ˻�</th>
				                        <th width="22%">�˻��Է�</th>
				                      </tr>
				                      <tr class="adm11"> 
				                        <td><input type="text" name="fromdate" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate%>" readonly> 
				                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  > 
				                          - 
				                          <input type="text" name="todate" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate%>" readonly> 
				                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  > 
				                        </td>
				                        <td><div align="center"><select name="srvc_ind"  size="1" style="width:115px;" >
				                          </select></div></td>
				                        <td><div align="center"><select name="status" size="1" style="width:80px;">
				                           <option value="T"  <% if(status.equals("T")){ %> selected <% } %>>��ü</option>
				                            <option value="R"  <% if(status.equals("R")){ %> selected <% } %>>����</option>
				                            <option value="0"  <% if(status.equals("0")){ %> selected <% } %>>���ó��</option>
				                            <option value="1"  <% if(status.equals("1")){ %> selected <% } %>>�ϰ�ó��</option>
				                            <option value="2"  <% if(status.equals("2")){ %> selected <% } %>>����</option>
				                            <option value="3"  <% if(status.equals("3")){ %> selected <% } %>>�ݼ�</option>
				                          </select></div></td>
				                        <td><div align="center"><select name="search" size="1" style="width:80px;">
				                            <option value="1"  <% if(search.equals("1")){ %> selected <% } %>>���ǹ�ȣ</option>
				                            <option value="2"  <% if(search.equals("2")){ %> selected <% } %>>�����</option>
				                            <option value="3"  <% if(search.equals("3")){ %> selected <% } %>>�ֹι�ȣ</option>
				                          </select></div></td>
				                        <td><input type="text" name="key" class="box03" value="<%=key%>"> 
				                          <a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
				                         &nbsp;<a href="javascript:goExcel();" ><img src="/img/common/btn_excel.gif" align="absmiddle" border="0"></a>
				                         </td>
				                      </tr>
				                    </table></td>
									</tr>
									<tr> 
										<td>&nbsp;</td>
									</tr>
									<tr> 
										<td>
										 <div id="excelDiv"><!-- excel 2�ܰ� -->
										<table width="100%" class="adm_table">
						                      <tr> 
						                        <th width="3%">N</th>
						                        <th width="7%">��������</th>
						                        <th width="6%">�����ð�</th>
						                        <th width="10%">���ǹ�ȣ</th>
						                        <th width="6%">�����</th>
						                        <th width="10%">������</th>
						                        <th width="6%">����</th>
						                        <th width="6%">����</th>
						                        <th width="7%">����ó��</th>
						                        <th width="7%">����</th>
						                        <th width="6%">����</th>
						                        <th width="9%">�ݼ�</th>
						                        <th width="9%">�ݼ�(����)����</th>
						                        <th width="8%">����</th>
						                      </tr>
<%
										int cnt = policyindiv.getCount("seq_no");
										if(cnt == 0) 
										{
%>
						                      <tr class="adm01"> 
						                        <td colspan="14">�ش��ϴ� �ڷᰡ �����ϴ�.</td>
						                      </tr>
<%										
										}
										else
										{				
											int row = 0;
											row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*20;
											for(int i=0;i<cnt;i++)
											{											
%>
						                      <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>"> 
						                        <td><%=row%></td>
<%
												String indate = "";//������
												String intime = "";//�����ð�
												String prdate = "";//ó����
												String prtime = "";//ó���ð�
												indate = policyindiv.getText("indate",i).trim();
												intime = policyindiv.getText("intime",i).trim();
												prdate = policyindiv.getText("prdate",i).trim();
												prtime = policyindiv.getText("prtime",i).trim();
												
												if(indate.length() > 7)
													indate = indate.substring(0,4) +"."+ indate.substring(4,6) +"."+ indate.substring(6,8);
												if(intime.length() > 5)
													intime = intime.substring(0,2) +":"+	intime.substring(2,4) +":"+ intime.substring(4,6);
												if(prdate.length() > 7)
													prdate = prdate.substring(0,4) +"."+ prdate.substring(4,6) +"."+ prdate.substring(6,8);
												if(prtime.length() > 5)
													prtime = prtime.substring(0,2) +":"+	prtime.substring(2,4) +":"+ prtime.substring(4,6);
												
												srvc_code = policyindiv.getText("srvc_code",i).trim();
											

												linkpage = "realtime_client.do";
%>
						                        <td><%=indate%></td>
						                        <td><%=intime%></td>
<%
												if(srvc_code.equals("A"))
												{	
													String ssn = policyindiv.getText("ssn",i).trim();
													if( ssn.length()>0 )  ssn = ssn.substring(0,6)+"-"+ssn.substring(6);
%>
										        <td><%=ssn%></td>
<%
													}
													else
													{
%>
            									<td><%=policyindiv.getText("policy",i).trim()%></td>
<%
													}
%>
						                        <td><%=policyindiv.getText("owner",i).trim()%></td>
						                        <td><%=policyindiv.getText("srvc_cd",i).trim()%></td>
						                        <td><%=policyindiv.getText("status",i).trim()%></td>
						                        <td>
<%
													if(srvc_code.equals("D"))
													{	
%>								                        
													&nbsp;
<%
													}
													else
													{	
%>												
							                        <a href="javascript:goDetail('<%=linkpage%>', '<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>','<%=policyindiv.getText("deathResult",i)%>')" onFocus="blur()">
							                        <img src="/img/common/btn_inquiry.gif" width="38" height="18" border="0"></a>
<%
													}
%>										                        
						                        </td>
						                        <td width="4%">
<%
													//out.println(policyindiv.getText("status_code",i));
													if(policyindiv.getText("status_code",i).equals(" "))
													{	
														//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
														//if( auth_cd.equals("20") || auth_cd.equals("30") )
														if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
														{
%>										                        
										        	<a href="javascript:goHost('<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>','<%=policyindiv.getText("process_mode",i)%>', '<%=policyindiv.getText("deathResult",i)%>')" onFocus="blur()"><img src="/img/common/btn_apply.gif" width="49" height="19" border="0"></a>
<%
														}
													}
													else
													{
%>
													&nbsp;
<%													
													}
%>										                        
										        </td>
												<td><select name="chgstatus">
					                      			<option value=""  selected>����</option>
					                      			<option value="0">���ó��</option>
					                      			<option value="1">�ϰ�ó��</option>
					                      			<option value="2">����</option>
					                      			<option value="3">�ݼ�</option>
					                        		</select></td>										                        
							                       <td>
<%
												//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
												//if( auth_cd.equals("20") || auth_cd.equals("30") )
												if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
												{
%>							                       
							                       <a href="javascript:goChange('<%=policyindiv.getText("indate",i)%>', '<%=policyindiv.getText("seq_no",i)%>','<%=i%>','<%=policyindiv.getText("srvc_code",i)%>','<%=cnt%>','<%=policyindiv.getText("deathResult",i)%>')"><img src="/img/common/btn_changes.gif" border="0"></a>
<%
												}
%>							                       
							                       </td> 
							                       <td>
<%
												//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
												//if( auth_cd.equals("20") || auth_cd.equals("30") )
												if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
												{
%>	
							                       <a href="javascript:goReturn('<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>','<%=policyindiv.getText("deathResult",i)%>');"><img src="/img/common/btn_return.gif" width="40" height="18" border="0"></a>
<%
												}
%>							                       
							                       </td>
							                       <td>
<%													
													if(policyindiv.getText("status_code",i).equals("3") || policyindiv.getText("status_code",i).equals("2"))
													{	
%>										                        
										        	<a href="javascript:goContent('<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>', '<%=policyindiv.getText("status_code",i)%>', '<%=policyindiv.getText("deathResult",i)%>')" onFocus="blur()">
<%
													if(policyindiv.getText("status_code",i).equals("3"))
													{
%>										        	
										        	<img src="/img/common/btn_return2.gif" width="62" height="18" border="0">
<%
													}
													else if(policyindiv.getText("status_code",i).equals("2"))
													{
%>
													<img src="/img/common/btn_return3.gif" width="62" height="18" border="0">	
<%													
													}
%>										        	
										        	</a>
<%
													}
													else
													{
%>
													&nbsp;
<%													
													}
%>										                        
							                       </td>
<%
												String process_mode = "";//����
												       process_mode = policyindiv.getText("process_mode",i).trim();
												if( process_mode.equals("R") )
												{
													process_mode = "�ǽð�";
												}
												else
												{
													process_mode = "������";
												}
%>							                       
							                       <td><%=process_mode%></td>
							                      </tr>
<%
													row = row - 1;
												}
											}
%>
									          </table>
									          </div>
									          </td>
											</tr>
											<tr> 
											<td align="center"><table>
													<tr> 
														<td width="26"></td>
														<td width="45"> <td align="center">
															<jsp:include page="/common/include/paging.jsp" flush="true">
																<jsp:param name="total" value="<%= totalCount %>"/>
																<jsp:param name="cpage" value="<%= current %>"/>
															</jsp:include>
														</td>
														<td width="30"></td>
													</tr>
												</table></td>
										</tr>
										<tr> 
											<td height="50">&nbsp;</td>
										</tr>
									</table></td>
							</tr>
						</table></td>
				</tr>
				<tr> 
					<td height="56" background="/img/common/copy_bg.gif"><img src="/img/common/copy.gif"></td>
				</tr>
			</table>

<!-- excel �� ���������� target frame-->
<iframe src="" name="excelFrame" width="0" height="0" frameborder="0" ></iframe>



<div id="cal" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
    <iframe name='dalFrame' 
            id='dalFrame' 
            src="/common/cal.jsp?setDate=form.fromdate&divName=cal" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"></iframe>
</div>
<div id="cal1" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
            <iframe id='dalFrame1' 
            src="/common/cal.jsp?setDate=form.todate&divName=cal1" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"> </iframe>
</div>            
</form>
<!-- excel 1�ܰ� -->
<form name="excelform" method="post">
<input type="hidden" name="excel">
</form>
<!-- excel 1�ܰ� -->

</body>
</html>

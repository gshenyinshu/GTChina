<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="statuschg" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="search" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="rslt" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun1" class="java.lang.String" scope="request"/>
<jsp:useBean id="modeind" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" class="java.lang.String" scope="request"/>
<jsp:useBean id="chgstatus" class="java.lang.String" scope="request"/>

<%
	//���ǿ��� ����������
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);

%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>

</head>
<script language="javascript">
<!--

	function goSearch()
	{
		document.form.current.value = 1;
		document.form.method="post" ;	
		document.form.searchgubun.value = "S";
		document.form.searchgubun1.value = "N";
		document.form.submit();
	}
	
	function goPage(num) 
	{
		document.form.current.value = num;
		document.form.searchgubun1.value = "N";
		document.form.method="post" ;
		document.form.submit();
	}	
		
	function ReLoadWindow(val)
	{				
		var srvc_value = '<%=srvc_ind%>';	
		var searchgubun = '<%=searchgubun%>';
		if(srvc_value.length == 0)
		{
			srvc_value = "";
		}

		if(val == "1")
		{
			//2006.03.23 PSR CyberAdmin ��ɰ��� PSR
			var AddOption4 = new Option("�� ü" ,"");
			var AddOption = new Option("�������" ,"1");
			var AddOption1 = new Option("��������", "4");
			var AddOption2 = new Option("�޸麸�������","5");
			var AddOption3 = new Option("���ݻ��","7");
			
			document.forms[0].srvc_ind.length  = 5;
			document.forms[0].srvc_ind.options[0] = AddOption4;			
			document.forms[0].srvc_ind.options[1] = AddOption;			
			document.forms[0].srvc_ind.options[2] = AddOption1;			
			document.forms[0].srvc_ind.options[3] = AddOption2;			
			document.forms[0].srvc_ind.options[4] = AddOption3;			
			
			if(srvc_value == "") document.forms[0].srvc_ind.options[0].selected = true;
			if(srvc_value == "1") document.forms[0].srvc_ind.options[1].selected = true;
			if(srvc_value == "4") document.forms[0].srvc_ind.options[2].selected = true;
			if(srvc_value == "5") document.forms[0].srvc_ind.options[3].selected = true;
			if(srvc_value == "7") document.forms[0].srvc_ind.options[4].selected = true;
			
		}
		else if(val == "2")
		{
			//2006.03.23 PSR CyberAdmin ��ɰ��� PSR
			var AddOption4 = new Option("�� ü" ,"");
			var AddOption = new Option("��������", "6");
			var AddOption1 = new Option("����ȯ", "2");
			var AddOption2 = new Option("APL��ȯ" ,"3");
			var AddOption3 = new Option("�߰���������", "8");
			
			document.forms[0].srvc_ind.length  = 5;
			document.forms[0].srvc_ind.options[0] = AddOption4;					
			document.forms[0].srvc_ind.options[1] = AddOption;					
			document.forms[0].srvc_ind.options[2] = AddOption3;			
			document.forms[0].srvc_ind.options[3] = AddOption1;			
			document.forms[0].srvc_ind.options[4] = AddOption2;		
			
			if(srvc_value == "") document.forms[0].srvc_ind.options[0].selected = true;
			if(srvc_value == "6") document.forms[0].srvc_ind.options[1].selected = true;
			if(srvc_value == "8") document.forms[0].srvc_ind.options[2].selected = true;
			if(srvc_value == "2") document.forms[0].srvc_ind.options[3].selected = true;
			if(srvc_value == "3") document.forms[0].srvc_ind.options[4].selected = true;

		}
	}	
	
	function goChange(policy_apln_no, policy_no, srvc_cd,bank_cd, acct_no, payor_ssn, row)
	{
		document.form.policy_apln_no.value = policy_apln_no;
		document.form.policy_no.value = policy_no;
		document.form.srvc_cd.value = srvc_cd;
		document.form.bank_cd.value = bank_cd;
		document.form.acct_no.value = acct_no;
		document.form.payor_ssn.value = payor_ssn;
		document.form.searchgubun1.value = "C";		
		document.form.searchgubun.value = "S";	
		
		//������ 2006.12.06 ���̹� ������ ȭ�� ����
		<%if( statuschg.getCount("policy_apln_no") > 1 ) {%>
			document.form.rtnflag.value = document.form.chgstatus[row].value;
		<%}else{ %>
			document.form.rtnflag.value = document.form.chgstatus.options[document.form.chgstatus.selectedIndex].value;
		<%}%>
		//alert(document.form.rtnflag.value);
		//return;		
		document.form.method="get" ;			
		document.form.submit();	
	}
	
	function goDisplay(policy_apln_no, row)
	{		
		var path = "";
		path = "/receipt/displayall.do?policy_apln_no="+policy_apln_no;
		
		window.open(path, '�������', 'left=400,top=150,Width=530,Height=200, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');		
	}
	
//-->
</script>
<body>

<form name="form" method="post"  action="status_chg_list.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="searchgubun1" value="<%=searchgubun1%>">
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="policy_apln_no">
<input type="hidden" name="policy_no">
<input type="hidden" name="srvc_cd">
<input type="hidden" name="rtnflag">
<input type="hidden" name="acct_no">
<input type="hidden" name="payor_ssn">
<input type="hidden" name="bank_cd">

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
						<jsp:param name="menu_mode" value="3"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					</td>
							<td class="contents"><table width="100%">
							<tr> 
								<td><img src="/img/common/title_03.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"></td>
							</tr>
							<tr> 
								<td><table width="100%">
										<tr> 
											<td><img src="/img/common/bu_cir01.gif"> 
												<b>���º���</b></td>
											<td align="right"></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 								
						                <td><table width="100%" class="adm_table">
						                    <col width=12%>
						                    <col width=25%>
						                    <col width=>
						                    <col width=>
						                    <col width=>
						                    <col width=>
						                    <col width=25%>
						                    <tr> 
						                      <th rowspan="2">�˻�����</th> 
						                      <th>��������</th>
						                      <th>������з�</th>
						                      <th>�����Һз�</th>
						                      <th>����</th>
						                      <th>���ΰ˻��׸�</th>
						                      <th>�˻��Է�</th>
						                    </tr>
						                    <tr class="adm11"> 
						                      <td><input type="text" name="fromdate" class="box02" size="8" maxlength="10" style="text-align:center" value="<%=fromdate%>" readonly> 
						                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  > 
						                        - 
						                        <input type="text" name="todate" class="box02" size="8" maxlength="10" style="text-align:center" value = "<%=todate%>" readonly> 
						                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  > 
						                      </td>
						                      <td><select name="modeind"  size="1" style="width:80px;" onChange="ReLoadWindow(this.value)">
						                          <option value="1"  <% if(modeind.equals("1")){ %> selected <% } %>>����ó��</option>
						                          <option value="2"  <% if(modeind.equals("2")){ %> selected <% } %>>����ó��</option>
						                        </Select> </td>
						                      <td> <select name="srvc_ind"  size="1" style="width:120px;" >
						                        </select> </td>
						                      <td><select name="rslt">
						                          <option value="T"  <% if(rslt.equals("T")){ %> selected <% } %>>��ü</option>
						                          <option value=""  <% if(rslt.equals("")){ %> selected <% } %>>����</option>
						                          <option value="0"  <% if(rslt.equals("0")){ %> selected <% } %>>����</option>
						                          <option value="2"  <% if(rslt.equals("2")){ %> selected <% } %>>����</option>
						                          <option value="3"  <% if(rslt.equals("3")){ %> selected <% } %>>����</option>
												  <!-- 2006.12.06 ���̹� ������ ȭ�� ����-->
												  <option value="1"  <% if(rslt.equals("1")){ %> selected <% } %>>�ݼ�</option>
						                        </select></td>
						                      <td><select name="search">
						                          <option value="1"  <% if(search.equals("1")){ %> selected <% } %>>���ǹ�ȣ</option>
						                          <option value="2"  <% if(search.equals("2")){ %> selected <% } %>>�����</option>
						                          <option value="3"  <% if(search.equals("3")){ %> selected <% } %>>�ֹι�ȣ</option>
						                        </select></td>
						                      <td><input type="text" name="key" class="box04" value="<%=key%>"> 
						                        <a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a></td>
						                    </tr>
						                  </table></td>
								</tr>
								<tr> 
									<td>&nbsp;</td>
								</tr>
								<tr> 
									<td><table width="100%" class="adm_table">
								                    <tr> 
								                      <th>N</th>
								                      <th>��������</th>
								                      <th>�����ð�</th>
								                      <th>���ǹ�ȣ</th>
								                      <th>�����</th>
								                      <th>������</th>
								                      <th>��û�ݾ�</th>
								                      <th>������</th>
								                      <th>����</th>
								                      <th>����</th>
								                      <th>����</th>
								                      <th>ó������</th>
								                      <th>ó���ð�</th>
								                      <th>ó����</th>
								                      <th>���LP</th>
								                    </tr>
<%
											int cnt = statuschg.getCount("policy_apln_no");
											if(cnt == 0)
											{
%>
								                    <tr class="adm01"> 
								                      <td colspan="15">�ش��ϴ� �ڷᰡ �����ϴ�.</td>
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
								                      <td><%=statuschg.getText("apln_dt",i).substring(0,11)%></td>
								                      <td><%=statuschg.getText("apln_dt",i).substring(11,19)%></td>
								                      <td><%=statuschg.getText("policy_no",i)%></td>
								                      <td><%=statuschg.getText("payor_nm",i)%></td>
								                      <td><%=statuschg.getText("srvc_name",i)%></td>
								                      <td><%=Util.addComma(statuschg.getText("apln_amt",i))%></td>
								                      <td><%=statuschg.getText("rslt_name",i)%></td>
								                      <td><select name="chgstatus">
								                      	<option value=""  selected>����</option>
								                      	<option value="0">����</option>
								                      	<option value="2">����</option>
								                      	<option value="3">����</option>	
														<!-- 2006.12.06 ���̹� ������ ȭ�� ����-->						                      								                         								<option value="1">�ݼ�</option>	
								                        </select></td>
								                      <td>
<%
											//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
											//if(auth_cd.equals("20") || auth_cd.equals("30"))
											if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
											{		
%>
<a href="javascript:goChange('<%=statuschg.getText("policy_apln_no",i).trim()%>','<%=statuschg.getText("policy_no",i).trim()%>','<%=statuschg.getText("srvc_cd",i).trim()%>','<%=statuschg.getText("bank_cd",i).trim()%>','<%=statuschg.getText("acct_no",i).trim()%>','<%=statuschg.getText("payor_ssn",i).trim()%>','<%=i%>')"><img src="/img/common/btn_changes.gif" border="0"></a>
<%
											}	
%>								                      </td>
								                      <td><a href="javascript:goDisplay('<%=statuschg.getText("policy_apln_no",i)%>','<%=row%>')"><img src="/img/common/btn_history.gif" border="0"></a></td>
								                      <td><%=statuschg.getText("proc_dt",i)%></td>
								                      <td><%=statuschg.getText("proc_tm",i)%></td>
								                      <td><%=statuschg.getText("emp_nm",i)%></td>
								                      <td><%=statuschg.getText("lpname",i)%></td>
								                    </tr>
<%
												row = row - 1;
												}
											}
%>
								                  </table></td>
									</tr>
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
</body>
</html>



<script language="javascript">
<!--
<%
	//����Ʈ�ڽ� ������
	String select_modeind = request.getParameter("modeind") == null ? "" : request.getParameter("modeind");

	if( select_modeind.equals("") )
	{
%>
		ReLoadWindow(1);
<%
	}
	else
	{
%>
		ReLoadWindow(<%=select_modeind%>);
<%
	}
%>
//-->
</script>

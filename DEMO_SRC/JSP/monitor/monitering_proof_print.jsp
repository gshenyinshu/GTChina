<%
/**
 * Description : ����͸�(��������߱�)
 * File        : /monitor/monitering_proof_print.jsp
 * @author     : �躸��
 * First Write : 2006.10.30
 * update date : 
 * update desc :
 */
%>

<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util, gtone.changeminer.common.utility.ToolString" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="monitor" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="search" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>

<jsp:useBean id="useind" class="java.lang.String" scope="request"/>
<jsp:useBean id="modeind" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" class="java.lang.String" scope="request"/>
<jsp:useBean id="auth_cd" class="java.lang.String" scope="request"/>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>
<script language="javascript">
<!--
	function goSearch()
	{
		document.form.current.value = 1;
		document.form.method="get" ;	
		document.form.searchgubun.value = "S";
		document.form.submit();
	}
	
	function goPage(num) 
	{
		document.form.current.value = num;
		document.form.method="get" ;
		document.form.submit();
	}	
		
	function ReLoadWindowIpl(val)
	{				
		var mode_value = '<%=modeind%>';
		document.form.srvc_val.value = val;	
				
		if(val == "I"||val == "C")
		{
			mode_value = "K";
			var AddOption = new Option("����", "K");
			
			document.forms[0].modeind.length  = 1;
			document.forms[0].modeind.options[0] = AddOption;					
			
			if(mode_value == "K") document.forms[0].modeind.options[0].selected = true;
			
			
		}		
		else if(val == "P" ||val == "S")
		{
			var AddOption0 = new Option("��ü" ,"");
			var AddOption1 = new Option("����" ,"K");
			var AddOption2 = new Option("����" ,"E");
			
			document.forms[0].modeind.length  = 3;
			document.forms[0].modeind.options[0] = AddOption0;	
			document.forms[0].modeind.options[1] = AddOption1;			
			document.forms[0].modeind.options[2] = AddOption2;			
			
			if(mode_value == "" ) document.forms[0].modeind.options[0].selected = true;
			if(mode_value == "K") document.forms[0].modeind.options[1].selected = true;
			if(mode_value == "E") document.forms[0].modeind.options[2].selected = true;
		}
		else if(val == "L")
		{
			mode_value = "K";
			var AddOption = new Option("����", "K");
			
			document.forms[0].modeind.length  = 1;
			document.forms[0].modeind.options[0] = AddOption;					
			
			if(mode_value == "K") document.forms[0].modeind.options[0].selected = true;
		}
		else if(val == "")
		{
			mode_value = "";		
			
			var AddOption = new Option("", "");
					
			document.forms[0].modeind.length  = 1;
			document.forms[0].modeind.options[0] = AddOption;	
			
			if(mode_value == "") document.forms[0].modeind.options[0].selected = true;
			
		}
		
		ReLoadWindowKe(mode_value);
	}
	
	function ReLoadWindowKe(val)
	{				
		var srvc_value = document.form.srvc_val.value;	
		var use_value = '<%=useind%>';	
				
		if(val == "K" ){
		
			if(srvc_value == "I")
			{
				var AddOption1 = new Option("���������" ,"I01");
				
				document.forms[0].useind.length  = 1;
				document.forms[0].useind.options[0] = AddOption1;			
				
				if(use_value == "I01") document.forms[0].useind.options[0].selected = true;
				
			}
			else if (srvc_value == "P" ||srvc_value == "C"||srvc_value == "S")
			{
	
				var AddOption0 = new Option("------��ü------","");
				var AddOption1 = new Option("����" ,			"P01");
				var AddOption2 = new Option("������������",	"P02");
				var AddOption3 = new Option("���������Ű��","P03");
				var AddOption4 = new Option("���������" ,	"P04");
				var AddOption5 = new Option("���������" ,		"P05");
				var AddOption6 = new Option("���ڹ߱޿�" ,		"P06");
				var AddOption7 = new Option("�����������" ,	"P07");
				var AddOption8 = new Option("���ǹ߱޿�" ,		"P08");
				var AddOption9 = new Option("���������" ,		"P09");
				
				document.forms[0].useind.length  = 10;
				document.forms[0].useind.options[0] = AddOption0;
				document.forms[0].useind.options[1] = AddOption1;			
				document.forms[0].useind.options[2] = AddOption2;	
				document.forms[0].useind.options[3] = AddOption3;			
				document.forms[0].useind.options[4] = AddOption4;	
				document.forms[0].useind.options[5] = AddOption5;			
				document.forms[0].useind.options[6] = AddOption6;	
				document.forms[0].useind.options[7] = AddOption7;			
				document.forms[0].useind.options[8] = AddOption8;	
				document.forms[0].useind.options[9] = AddOption9;			
				
				if(use_value == "")		document.forms[0].useind.options[0].selected = true;
				if(use_value == "P01")	document.forms[0].useind.options[1].selected = true;
				if(use_value == "P02")	document.forms[0].useind.options[2].selected = true;
				if(use_value == "P03")	document.forms[0].useind.options[3].selected = true;
				if(use_value == "P04")	document.forms[0].useind.options[4].selected = true;
				if(use_value == "P05")	document.forms[0].useind.options[5].selected = true;
				if(use_value == "P06")	document.forms[0].useind.options[6].selected = true;
				if(use_value == "P07")	document.forms[0].useind.options[7].selected = true;
				if(use_value == "P08")	document.forms[0].useind.options[8].selected = true;
				if(use_value == "P09")	document.forms[0].useind.options[9].selected = true;
				
				
				
			}
			else if(srvc_value == "L")
			{			
				var AddOption0 = new Option("------��ü------" ,   "");
				var AddOption1 = new Option("�����������" ,		"L01");
				var AddOption2 = new Option("���������Ű��" ,	"L02");
				var AddOption3 = new Option("����" ,				"L03");
				var AddOption4 = new Option("���ڹ߱޿�" ,			"L04");
				var AddOption5 = new Option("���ǹ߱޿�" ,			"L05");
				var AddOption6 = new Option("���������" ,		"L06");
				var AddOption7 = new Option("������������" ,		"L07");
				
				document.forms[0].useind.length  = 8;
				document.forms[0].useind.options[0] = AddOption0;
				document.forms[0].useind.options[1] = AddOption1;			
				document.forms[0].useind.options[2] = AddOption2;	
				document.forms[0].useind.options[3] = AddOption3;			
				document.forms[0].useind.options[4] = AddOption4;	
				document.forms[0].useind.options[5] = AddOption5;			
				document.forms[0].useind.options[6] = AddOption6;	
				document.forms[0].useind.options[7] = AddOption7;		
				
				if(use_value == "")		document.forms[0].useind.options[0].selected = true;
				if(use_value == "L01")	document.forms[0].useind.options[1].selected = true;
				if(use_value == "L02")	document.forms[0].useind.options[2].selected = true;
				if(use_value == "L03")	document.forms[0].useind.options[3].selected = true;
				if(use_value == "L04")	document.forms[0].useind.options[4].selected = true;
				if(use_value == "L05")	document.forms[0].useind.options[5].selected = true;
				if(use_value == "L06")	document.forms[0].useind.options[6].selected = true;
				if(use_value == "L07")	document.forms[0].useind.options[7].selected = true;
			}
		
		}
		else if(val == "E")
		{
			var AddOption0 = new Option("----------------��ü-----------------" ,	"");
			var AddOption1 = new Option("For Account Closing" ,					"P51");
			var AddOption2 = new Option("For Public Institution" ,					"P52");
			var AddOption3 = new Option("For Filling Property(public official)",	"P53"); 
			var AddOption4 = new Option("For Embassy" ,							"P54");
			var AddOption5 = new Option("For Court" ,								"P55");
			var AddOption6 = new Option("For Visa Application" ,					"P56");
			var AddOption7 = new Option("For Tax Office" ,							"P57");
			var AddOption8 = new Option("For Passport Issuance" ,					"P58");
			var AddOption9 = new Option("For Bank" ,								"P59");
			
			document.forms[0].useind.length  = 10;
			document.forms[0].useind.options[0] = AddOption0;
			document.forms[0].useind.options[1] = AddOption1;			
			document.forms[0].useind.options[2] = AddOption2;	
			document.forms[0].useind.options[3] = AddOption3;			
			document.forms[0].useind.options[4] = AddOption4;	
			document.forms[0].useind.options[5] = AddOption5;			
			document.forms[0].useind.options[6] = AddOption6;	
			document.forms[0].useind.options[7] = AddOption7;			
			document.forms[0].useind.options[8] = AddOption8;	
			document.forms[0].useind.options[9] = AddOption9;			
			
			if(use_value == "")		document.forms[0].useind.options[0].selected = true;
			if(use_value == "P51")	document.forms[0].useind.options[1].selected = true;
			if(use_value == "P52")	document.forms[0].useind.options[2].selected = true;
			if(use_value == "P53") 	document.forms[0].useind.options[3].selected = true;
			if(use_value == "P54")	document.forms[0].useind.options[4].selected = true;
			if(use_value == "P55")	document.forms[0].useind.options[5].selected = true;
			if(use_value == "P56")	document.forms[0].useind.options[6].selected = true;
			if(use_value == "P57")	document.forms[0].useind.options[7].selected = true;
			if(use_value == "P58")	document.forms[0].useind.options[8].selected = true;
			if(use_value == "P59")	document.forms[0].useind.options[9].selected = true;
		}
		else if(val == "")
		{
			use_value = "";
			
			var AddOption = new Option("", "");
			
			document.forms[0].useind.length  = 1;
			document.forms[0].useind.options[0] = AddOption;					
			
			if(use_value == "")		document.forms[0].useind.options[0].selected = true;
		}
		
		document.form.mode_val.value = val;
	}
	



	
//-->
</script>
</head>
<body onLoad="ReLoadWindowIpl('<%=srvc_ind%>');">

<form name="form" method="post"  action="monitering_proof_print.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="srvc_val" value="<%=srvc_ind%>">
<input type="hidden" name="mode_val" value="<%=modeind%>">
<input type="hidden" name="use_val" value="<%=useind%>">
<table width="100%" height="100%">
	<tr> 
		<td height=71>
			<table width="100%" background="/img/common/logo_bg.gif">
				<tr> 
					<td><img src="/img/common/logo.gif"></td>
					<td align="right"><img src="/img/common/logo_end.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr> 
		<td><table width=100% height="100%">
				<col width=200> 
				<tr> 					
          			<td align="center" class="menu">
						<!--DropDown ���� : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="6"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					</td>
					<td class="contents">
						<table width="100%">
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
                      						<td><img src="/img/common/bu_cir01.gif"> <b>����͸�(����ȭ�����)</b></td>
											<!--
					                        <td align="right">
<%
												if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
												{
%>											
												<a href="javascript:goAllChange()" onFocus="blur()"><img src="/img/common/btn_batchprocess.gif" ></a>
<%
												}
%>												
											</td>-->
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
				                <td>
				                <table width="100%" class="adm_table">
				                    <col width=12%>
				                    <col width=20%>
				                    <col width=>
				                    <col width=>
				                    <col width=>
				                    <col width=>
				                    <col width=25%>
				                    <tr> 
				                      <th width="8%" rowspan="2">�˻�����</th>
				                      <th width="17%">��ȸ����</th> 
				                      <th width="14%">�����з�</th>
				                      <th width="8%">����/����</th>
				                      <th width="24%">�뵵</th>
				                      <th width="8%">���ΰ˻�</th>
				                      <th width="21%">�˻��Է�</th>
				                    </tr>
				                    <tr class="adm11"> 
				                      <td><input type="text" name="fromdate" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate%>" readonly> 
				                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  > 
				                        - 
				                        <input type="text" name="todate" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate%>" readonly> 
				                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  > 
				                      </td>
				                      <td><select name="srvc_ind"  size="1" style="width:150px;" onChange="ReLoadWindowIpl(this.value)">
									  
				                      	<option value=""  <% if(srvc_ind.equals("")){ %> selected <% } %>>-------��ü-------</option>
				                      	<option value="I"  <% if(srvc_ind.equals("I")){ %> selected <% } %>>�ҵ������������</option>
				                      	<option value="P"  <% if(srvc_ind.equals("P")){ %> selected <% } %>>����ᳳ������</option>
				                      	<option value="L"  <% if(srvc_ind.equals("L")){ %> selected <% } %>>�����ܾ�����</option>				                      	
				                      	<option value="C"  <% if(srvc_ind.equals("C")){ %> selected <% } %>>�ؾ�ȯ������</option>
				                      	<option value="S"  <% if(srvc_ind.equals("S")){ %> selected <% } %>>����������</option>
									  
				                        </select></td>
				                      <td><select name="modeind"  size="1" style="width:80px;" onChange="ReLoadWindowKe(this.value)">
				                        </select> </td>
				                      <td><select name="useind"  size="1" style="width:230px;" >
				                        </select> </td>										
				                      <td><select name="search" size="1" style="width:80px;">
				                          <option value="1"  <% if(search.equals("1")){ %> selected <% } %>>�ֹι�ȣ</option>
				                          <option value="2"  <% if(search.equals("2")){ %> selected <% } %>>�����</option>
				                          <option value="3"  <% if(search.equals("3")){ %> selected <% } %>>��ȸ�⵵</option>
				                        </select></td>
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
				                        <th width="5%">N</th>
				                        <th width="9%">��ȸ����</th>
				                      	<th width="9%">��ȸ�ð�</th> 
				                        <th width="15%">�ֹι�ȣ</th>
				                        <th width="13%">����ڸ�</th>
				                        <th width="18%">������</th>
				                        <th width="10%">����/����</th>
				                        <th width="22%">�뵵</th>
				                      </tr>
<%
										int cnt = monitor.getCount("search_date");
										if(cnt == 0)
										{
%>
				                      <tr class="adm01"> 
				                        <td colspan="9">�ش��ϴ� �ڷᰡ �����ϴ�.</td>
				                      </tr>
<%				
										}
										else
										{
											int row = 0;
											row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*20;
											
											if(row == 0) row=1;
											
											for(int i=0;i<cnt;i++)
											{
%>
				                      <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>"> 
				                        <td><%=row%></td>
<%
										String search_date =  "";//������
									    search_date = monitor.getText("search_date",i).trim();	
									    if( search_date.length() > 7 ) search_date = search_date.substring(0,4) +"."+ search_date.substring(4,6) +"."+ search_date.substring(6,8);
										
										String search_time =  "";//�����ð�
									    search_time = monitor.getText("search_time",i).trim();	
									    if( search_time.length() > 5 ) search_time = search_time.substring(0,2) +":"+ search_time.substring(2,4) +":"+ search_time.substring(4,6);

										String jumin_no = "";//�ֹι�ȣ
										jumin_no = monitor.getText("ssn",i).trim();
										if( jumin_no.length() > 0 ) jumin_no = jumin_no.substring(0,6)+"-"+jumin_no.substring(6);
											   
										String proof_code = "";//������
										proof_code = monitor.getText("proof_code",i).trim();
										if( proof_code.equals("I") ) {proof_code = "�ҵ������������";}
										else if( proof_code.equals("P") ) {proof_code = "����ᳳ������";}
										else if( proof_code.equals("L") ) {proof_code = "�����ܾ�����";}
										else if( proof_code.equals("C") ) {proof_code = "�ؾ�ȯ������";}
										else if( proof_code.equals("S") ) {proof_code = "����������";}
										
										String koreng = "";//����/����
										koreng = monitor.getText("koreng",i).trim();
										if( koreng.equals("K") ) {koreng = "����";}
										else if( koreng.equals("E") ) {koreng = "����";}
										else {koreng="";}
										
										String proof_usage = "";//���� �뵵
										proof_usage = monitor.getText("proof_usage",i).trim();
										if( proof_usage.equals("") ){proof_usage="";}
										else if( proof_usage.equals("I01") ){proof_usage="���������";}
										else if( proof_usage.equals("P01") || proof_usage.equals("L03") ){proof_usage="����";}
										else if( proof_usage.equals("P02") || proof_usage.equals("L07")  ){proof_usage="������������";}
										else if( proof_usage.equals("P03") || proof_usage.equals("L02")  ){proof_usage="���������Ű��";}
										else if( proof_usage.equals("P04") || proof_usage.equals("L06")  ){proof_usage="���������";}
										else if( proof_usage.equals("P05") ){proof_usage="���������";}
										else if( proof_usage.equals("P06") || proof_usage.equals("L04")  ){proof_usage="���ڹ߱޿�";}
										else if( proof_usage.equals("P07") || proof_usage.equals("L01")  ){proof_usage="�����������";}
										else if( proof_usage.equals("P08") || proof_usage.equals("L05")  ){proof_usage="���ǹ߱޿�";}
										else if( proof_usage.equals("P09") ){proof_usage="���������";}
										else if( proof_usage.equals("P51") ){proof_usage="For Account Closing";}
										else if( proof_usage.equals("P52") ){proof_usage="For Public Institution";}
										else if( proof_usage.equals("P53") ){proof_usage="For Filling Property(public official)";}
										else if( proof_usage.equals("P54") ){proof_usage="For Embassy";}
										else if( proof_usage.equals("P55") ){proof_usage="For Court";}
										else if( proof_usage.equals("P56") ){proof_usage="For Visa Application";}
										else if( proof_usage.equals("P57") ){proof_usage="For Tax Office";}
										else if( proof_usage.equals("P58") ){proof_usage="For Passport Issuance";}
										else if( proof_usage.equals("P59") ){proof_usage="For Bank";}
										else {proof_usage="";}
											    	   
%>
				                        <td><%=search_date%></td>
				                        <td><%=search_time%></td>
				                        <td><%=jumin_no%></td>
				                        <td><%=monitor.getText("name",i).trim()%></td>
				                        <td><%=proof_code%></td>
				                        <td><%=koreng%></td>
										<td><%=proof_usage%></td>
				                      </tr>
<%
												row = row -1;
											}
										}
%>
                    				</table>
                  				</div>
                  				</td>
							</tr>
							<tr> 
								<td align="center">
									<table>
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
						</table>
					</td>
				</tr>
			</table>
		</td>
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

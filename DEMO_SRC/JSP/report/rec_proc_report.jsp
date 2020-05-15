<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="selBank" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="policyview" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="sumCount" class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="rslt" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_cd" class="java.lang.String" scope="request"/>
<jsp:useBean id="bankcd" class="java.lang.String" scope="request"/>
<jsp:useBean id="top" class="java.lang.String" scope="request"/>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>

<%

	String v_toyear = Util.getTodayToYMD();
	String to_year = v_toyear.substring(0,8);
	
	if(fromdate.length() == 0)
	{
		fromdate = to_year;				
	}
	
	if(todate.length() == 0)
	{
		todate = to_year;
	}
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
	
//-->
</script>
<body>


<form name="form" method="post"  action="rec_proc_report.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
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
						<jsp:param name="menu_mode" value="4"/>
						</jsp:include>
						<!--DropDown ���� : E-->
						</td>
							<td class="contents"><table width="100%">
							<tr> 
								<td><img src="/img/common/title_04.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"><div align="right"> </div></td>
							</tr>
							<tr> 
								<td>
									<table width="100%">
										<tr> 
											<td><img src="/img/common/bu_cir01.gif"> 
												<b>������������</b></td>
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
					                      <col width=25%>
					                      <col width=>
					                      <col width=>
					                      <col width=>
					                      <col width=>
					                      <col width=25%>
					                      <tr> 
					                        <th width="6%" rowspan="2">�˻�����</th>
					                        <th width="18%">ó������</th>
					                        <th width="10%">�����з�</th>
					                        <th width="5%">����</th>
					                        <th width="6%">����</th>
					                        <th width="15%">���ǹ�ȣ</th>
					                        <th width="16%">�˻�</th>
					                      </tr>
					                      <tr class="adm11"> 
					                        <td><input type="text" name="fromdate" class="box02" size="8" maxlength="10" style="text-align:center" value="<%=fromdate%>" readonly> 
					                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  > 
					                          - 
					                          <input type="text" name="todate" class="box02" size="8" maxlength="10" style="text-align:center" value = "<%=todate%>" readonly> 
					                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  > 
					                        </td>
					                        <td> <select name="srvc_cd"  size="1" style="width:120px;" >
					                            <option value="T"  <% if(srvc_cd.equals("T")){ %> selected <% } %>>��ü</option>
												<!-- 0602713 ���̹� ������ ���� ������ 2007.01.03 -->
					                            <option value="6"  <% if(srvc_cd.equals("6")){ %> selected <% } %>>��������</option>
					                            <option value="2"  <% if(srvc_cd.equals("2")){ %> selected <% } %>>����ȯ</option>
					                            <option value="3"  <% if(srvc_cd.equals("3")){ %> selected <% } %>>APL��ȯ</option>
					
					                          </select> </td>
					                        <td><select name="rslt">
					                            <option value="T"  <% if(rslt.equals("T")){ %> selected <% } %>>��ü</option>
									<option value="B"  <% if(rslt.equals("B")){ %> selected <% } %>>����</option>
									<option value="0"  <% if(rslt.equals("0")){ %> selected <% } %>>����</option>
									<option value="1"  <% if(rslt.equals("1")){ %> selected <% } %>>�ݼ�</option>
									<option value="2"  <% if(rslt.equals("2")){ %> selected <% } %>>����</option>
									<option value="3"  <% if(rslt.equals("3")){ %> selected <% } %>>����</option>
									<option value="A"  <% if(rslt.equals("A")){ %> selected <% } %>>������</option>
					                          </select></td>
					                        <td>
                        					   <select name="bankcd">
                        					   <option value="T"  <% if(bankcd.equals("T")){ %> selected <% } %>>��ü</option>
<%
									int count = selBank.getCount("bank_code");
									for(int i =0;i<count;i++)
									{
				
%>						
									<option value="<%=selBank.getText("bank_code",i)%>" <% if(selBank.getText("bank_code",i).equals(bankcd)){ %> selected <% } %>><%=selBank.getText("bank_name",i).trim()%></option>								
<%
									}	
%>	
     						                   </select></td>
						                        <td><div align="center"><input type="text" name="key" class="box03" value="<%=key%>"></div></td>
						                        
                        <td> <a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a> 
                          <a href="javascript:goExcel();" ><img src="/img/common/btn_excel.gif" align="absmiddle" border="0"></a> 
                          <select name="top" onChange="goSearch()">
                            <option value="10"  <% if(top.equals("10")){ %> selected <% } %>>10</option>
                            <option value="20"  <% if(top.equals("20")){ %> selected <% } %>>20</option>
                            <option value="30"  <% if(top.equals("30")){ %> selected <% } %>>30</option>
                            <option value="40"  <% if(top.equals("40")){ %> selected <% } %>>40</option>
                            <option value="50"  <% if(top.equals("50")){ %> selected <% } %>>50</option>
                            <option value="60"  <% if(top.equals("60")){ %> selected <% } %>>60</option>
                            <option value="70"  <% if(top.equals("70")){ %> selected <% } %>>70</option>
                            <option value="80"  <% if(top.equals("80")){ %> selected <% } %>>80</option>
                            <option value="90"  <% if(top.equals("90")){ %> selected <% } %>>90</option>
                            <option value="100"  <% if(top.equals("100")){ %> selected <% } %>>100</option>
                            <option value="200"  <% if(top.equals("200")){ %> selected <% } %>>200</option>
                          </select> </td>
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
						                          <th>N</th>
						                          <th>ó������</th>
						                          <th>ó���ð�</th>
						                          <th>��������</th>
						                          <th>���ǹ�ȣ</th>
						                          <th>�����</th>
						                          <th>�ֹι�ȣ</th>
						                          <th>ó���ݾ�</th>
						                          <th>ó�����</th>
						                          <th>����</th>
						                          <th>������</th>
						                          <th>����</th>
						                          <th>ó����</th>
						                        </tr>
<%
										int cnt = policyview.getCount("policy_no");
										if(cnt == 0) 
										{
%>
						                        <tr class="adm01"> 
						                          <td colspan="13">�ش��ϴ� �ڷᰡ �����ϴ�.</td>						                          
						                        </tr>
<%										
										}
										else
										{				
											int row = 0;
											row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )* Integer.parseInt(top);		
											for(int i=0;i<cnt;i++)
											{											
%>
						                        <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>"> 
						                          <td><%=row%></td>
						                          <td><%=policyview.getText("proc_dt",i)%></td>
						                          <td><%=policyview.getText("proc_tm",i)%></td>
						                          <td><%=policyview.getText("srvc_name",i)%></td>
						                          <td><%=policyview.getText("policy_no",i)%></td>
						                          <td><%=policyview.getText("payor_nm",i)%></td>
<%
										String payor_ssn = "";
										payor_ssn = policyview.getText("payor_ssn",i);
										if(payor_ssn.length() == 13)
										{
											payor_ssn = payor_ssn.substring(0,6)+"-"+payor_ssn.substring(7);
										}
%>						                          
						                          <td><%=payor_ssn%></td>
						                          <td><div align="right"><%=Util.addComma(trans.removeZero(policyview.getText("apln_amt",i)))%></div></td>
						                          <td><%=policyview.getText("rslt_name",i)%></td>
												  
												<%	String bank_name, bank_cd;
													bank_name = policyview.getText("bank_name",i).trim();
													bank_cd = policyview.getText("bank_cd",i).trim();
													//2006.10.04 : �躸�� : �ѱ���Ƽ����(27, 53->27), �츮����(83, 20->20), ��������(21, 26->88)
													if(bank_cd.equals("53")){
														bank_cd = "27";
														bank_name = "�ѱ���Ƽ����";
													}else if(bank_cd.equals("83")){
														bank_cd = "20";
														bank_name = "�츮����";
													}else if(bank_cd.equals("21")||bank_cd.equals("26")){
														bank_cd = "88";
														bank_name = "��������";
													}else if(bank_cd.equals("11")||bank_cd.equals("12")||bank_cd.equals("13")||bank_cd.equals("14")||bank_cd.equals("15")||bank_cd.equals("16")||bank_cd.equals("17")){
														bank_name = "����";
													}
												%>			
						                          <td><%=bank_name%></td>
						                          <td><%=policyview.getText("acct_nm",i)%></td>
						                          <td><%=policyview.getText("acct_no",i)%></td>
						                          <td><%=policyview.getText("emp_nm",i)%></td>
						                        </tr>
<%
												row = row - 1;
											}
										}
%>
                      					</table>
<%
									if(searchgubun.equals("S"))
									{
%>                             					
									<table width="400" class="adm_table" align="center">
						                        <tr> 
						                          <th width="15%">�ѰǼ�</th>
						                          <td width="15%"><%=totalCount%>��</td>
						                          <th width="30%">ó���ݾװ�</th>
						                          <td><div align="right"><%=Util.addComma(sumCount.getText("apln_amt"))%>��</div></td>
						                        </tr>
									</table>						                        	
<%
								}
%>                      
								</div><!-- excel 3�ܰ� -->
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
													<jsp:param name="top" value="<%= top %>"/>
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

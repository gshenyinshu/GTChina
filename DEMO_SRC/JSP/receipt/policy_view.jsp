<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="policyview" class="anyframe.data.DataSet" scope="request"/>
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
<jsp:useBean id="fromamt" class="java.lang.String" scope="request"/>
<jsp:useBean id="toamt" class="java.lang.String" scope="request"/>

<jsp:useBean id="count1" class="java.lang.String" scope="request"/>
<jsp:useBean id="count2" class="java.lang.String" scope="request"/>
<jsp:useBean id="count3" class="java.lang.String" scope="request"/>
<jsp:useBean id="count4" class="java.lang.String" scope="request"/>
<%
	String v_toyear = Util.getTodayToYMD();
	String to_year = v_toyear.substring(0,8);
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

	function goReLoadListPage()
	{
		document.form.method="get" ;
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
			var AddOption4 = new Option("�� ü" ,"");
			var AddOption = new Option("��������", "6");
			var AddOption3 = new Option("�߰���������", "8");
			var AddOption1 = new Option("����ȯ", "2");
			var AddOption2 = new Option("APL��ȯ" ,"3");

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

	/*
	* ���������� ����...
	*/
	function heightControl(object, maxHeight , height) {
			try {
				//if(height < (maxHeight))
					eval( "document.all."+object+".height=height");

				//else eval("document.all."+object+".height=maxHeight");

			} catch(e) {
				alert(e)
			}
	}


	function goSuccess(){

		//alert("��ũ��Ʈ ȣ�� ����...");

		document.form.method="get" ;
		document.form.submit();


	}



	 function viewPopUp(linkStr,popNameStr,codeDiv){
        // ���״���� D+1�ΰ��� ������� �����ش�.
        if(codeDiv == "true") {
            alert("���װ�������� �����ϱ��� 2�����Ŀ� ó�������մϴ�.");
        }

		var frm = document.form1;

		var w = 1000;
		var h = 650;
		x = 10;//(screen.availWidth - w) / 2;
		y = 10;//(screen.availHeight - h) / 2;
		window.open(linkStr, 'popPolicy_'+popNameStr,'width='+w+', height='+h+', left='+x+', top='+y+' , status=no , scrollbars=yes');

	 }

//-->
</script>
<body onLoad="javascript:ReLoadWindow('<%=modeind%>');">
<form name="form" method="post"  action="policy_view.do">
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
						<jsp:param name="menu_mode" value="<%=modeind%>"/>
						</jsp:include>
						<!--DropDown ���� : E-->
						</td>
							<td class="contents"><table width="100%">
							<tr>
<%
						if( srvc_ind.equals("1") || srvc_ind.equals("4") || srvc_ind.equals("5") || srvc_ind.equals("7") )
						{
%>
								<td><img src="/img/common/title_01.gif"></td>
<%
						}else{
%>
								<td><img src="/img/common/title_02.gif"></td>
<%
						}
%>
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
												<b>����ó�� �⺻ȭ��</b></td>
											<td align="right">&nbsp;</td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><table width="100%" class="adm_table">
										<col width=7%><col width=23%><col width=><col width=><col width=><col width=><col width=><col width=25%>
										<tr>
											<th rowspan="2">�˻�����</th>
											<th>��������</th>
											<th>��û�ݾ�</th>
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
											<td><select name="fromamt"  size="1" style="width:80px;" onChange="">
													  <option value=""  <% if(fromamt.equals("")){ %> selected <% } %>>----</option>
													  <option value="-1"  <% if(fromamt.equals("-1")){ %> selected <% } %>>0</option>
													  <option value="2000000"  <% if(fromamt.equals("2000000")){ %> selected <% } %>>200</option>
													  <option value="10000000"  <% if(fromamt.equals("10000000")){ %> selected <% } %>>1000</option>
												</Select>
												-
											<select name="toamt"  size="1" style="width:80px;" onChange="">
													  <option value=""  <% if(toamt.equals("")){ %> selected <% } %>>----</option>
													  <option value="-1"  <% if(toamt.equals("-1")){ %> selected <% } %>>0</option>
													  <option value="2000000"  <% if(toamt.equals("2000000")){ %> selected <% } %>>200</option>
													  <option value="10000000"  <% if(toamt.equals("10000000")){ %> selected <% } %>>1000</option>
												</Select>
											</td>

											<td><select name="modeind"  size="1" style="width:80px;" onChange="ReLoadWindow(this.value)">
													  <option value="1"  <% if(modeind.equals("1")){ %> selected <% } %>>����ó��</option>
													  <option value="2"  <% if(modeind.equals("2")){ %> selected <% } %>>����ó��</option>
												</Select>
											</td>
											<td>
											<select name="srvc_ind"  size="1" style="width:120px;" >
											</select>
											</td>
											<td><select name="rslt">
												<option value="T"  <% if(rslt.equals("T")){ %> selected <% } %>>��ü</option>
												<option value="B"  <% if(rslt.equals("B")){ %> selected <% } %>>����</option>
												<option value="0"  <% if(rslt.equals("0")){ %> selected <% } %>>����</option>
												<option value="1"  <% if(rslt.equals("1")){ %> selected <% } %>>�ݼ�</option>
												<option value="2"  <% if(rslt.equals("2")){ %> selected <% } %>>����</option>
												<option value="3"  <% if(rslt.equals("3")){ %> selected <% } %>>����</option>
												<option value="A"  <% if(rslt.equals("A")){ %> selected <% } %>>ó����</option>
												</select></td>
											<td><select name="search">
													<option value="1"  <% if(search.equals("1")){ %> selected <% } %>>���ǹ�ȣ</option>
													<option value="2"  <% if(search.equals("2")){ %> selected <% } %>>�����</option>
													<option value="3"  <% if(search.equals("3")){ %> selected <% } %>>�ֹι�ȣ</option>
												</select></td>
											<td>
												<input type="text" name="key" class="box04" value="<%=key%>">
												<a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
												<a href="javascript:goExcel();" ><img src="/img/common/btn_excel.gif" align="absmiddle" border="0"></a>
											</td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>

							<tr>
								<td><b>&nbsp;���� : <%=count1%> &nbsp;&nbsp;&nbsp;&nbsp;���� : <%=count2%> &nbsp;&nbsp;&nbsp;&nbsp;ó���� : <%=count3%> &nbsp;&nbsp;&nbsp;&nbsp;������ : <%=count4%></b></td>
							</tr>

							<tr>
								<td>


								<div id="excelDiv"><!-- excel 2�ܰ� -->

                      <table width="100%" class="adm_table" style="margin: 0px; ">
                      <col width=4%>
                      <col width=9%>
                      <col width=8%>
                      <col width=10%>
                      <col width=7%>
                      <col width=10%>
                      <col width=10%>
                      <col width=6%>
                      <col width=10%>
                      <col width=9%>
                      <col width=8%>
                      <col width=>
                        <tr>
                          <th>N</th>
                          <th>��������</th>
                          <th>�����ð�</th>
                          <th>���ǹ�ȣ</th>
                          <th>�����</th>
                          <th>������</th>
                          <th>��û�ݾ�</th>
                          <th>����</th>
                          <th>ó������</th>
                          <th>ó���ð�</th>
                          <th>ó����</th>
                          <th>���LP</th>
                        </tr>
                        <!--/table>
                        <!--div style="overflow: auto; width: 100%; height: 150px;"-->
                        <!--table width="100%" class="adm_table"  style="table-layout: fixed;">
	                       <col width=30>
	                      <col width=75>
	                      <col width=65>
	                      <col width=72>
	                      <col width=58>
	                      <col width=75>
	                      <col width=65>
	                      <col width=40>
	                      <col width=75>
	                      <col width=70>
	                      <col width=60>
	                      <col width=-->
                        <%
										int cnt = policyview.getCount("policy_no");
										if(cnt == 0)
										{
%>
                        <tr class="adm01">
                          <td colspan="12">�ش��ϴ� �ڷᰡ �����ϴ�.</td>
                        </tr>
                        <%
										}
										else
										{
											int row = 0;
											row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*20;
											for(int i=0;i<cnt;i++)
											{
                                                // 0702255 : �Ⱥ���
                                                String strBackGround = ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8";
                                                String strPlnCode = Util.nvl(policyview.getText("plncode",i));
                                                String strCodeDiv = "false"; // ���׻�ǰ�� ��� ó�� �Ұ����ϰ� ����. true : ó���Ұ���, false : ó������
                                                if("".equals(strPlnCode) == false) {
                                                    strPlnCode = strPlnCode.substring(0,2);
                                                }

                                                if("51".equals(strPlnCode) || "53".equals(strPlnCode) || "54".equals(strPlnCode) || "55".equals(strPlnCode) || "56".equals(strPlnCode)) {

                                                    String strTemp = Util.nvl(policyview.getText("comp_2after",i), "0"); // ������ ���� 2������
                                                    if("".equals(strTemp)) strTemp = "0";
                                                    int int2After = Integer.parseInt(strTemp); // ������ ���� 2������
                                                    int intToday = Integer.parseInt(to_year); // ���� ����

                                                    // ���� ���ڰ� �����ϱ��� 2������ �����̸� ó�� �Ұ���. ������ ȸ��
                                                    if(intToday < int2After) {
                                                        strCodeDiv = "true"; // D, D+1 ó�� �Ұ� : ���� ���Ϲ� �������� ó�� �Ұ�
                                                        strBackGround = "#DDDDDD";
                                                    // ���� ���ڰ� D+2������������ ��� ó�� ����. ������ �����
                                                    }else {
                                                        strCodeDiv = "false"; // D+2 ���� ó������ : ���� 2������ ���ķδ� ó�� ����
                                                        strBackGround = "#FFFF99";
                                                    }

                                                }
%>
                        <tr align="center" bgcolor="<%=strBackGround%>">
                          <%
											String linkcontent = "";
											if(policyview.getText("srvc_cd",i).trim().equals("1"))
											{
												linkcontent = "/payment/pl_payment_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("2"))
											{
												linkcontent = "/receipt/pl_repayment_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("3"))
											{
												linkcontent = "/receipt/apl_payment.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("4"))
											{
												linkcontent = "/payment/dividend_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("5"))
											{
												linkcontent = "/payment/resting_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("6"))
											{
												linkcontent = "/receipt/premium_paid_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("7"))
											{
												linkcontent = "/payment/dividend_setoff_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("8"))
											{
												linkcontent = "/receipt/add_premium_paid_search.do";
											}



											String linkStr = ""+linkcontent
																+"?policy_apln_no="+policyview.getText("policy_apln_no",i)
																+"&ssn="+policyview.getText("payor_ssn",i)
																+"&policy="+policyview.getText("policy_no",i)
																+"&searchgubun="+searchgubun
																+"&current="+current
																+"&fromdate="+fromdate
																+"&todate="+todate
																+"&fromamt="+fromamt
																+"&toamt="+toamt
																+"&modeind="+modeind
																+"&srvc_ind="+srvc_ind
																+"&rslt="+rslt
																+"&search="+search
																+"&key="+key;



%>
                          <td ><%=row%></td>
                          <td><%=policyview.getText("apln_dt",i).substring(0,11)%></td>
                          <td><%=policyview.getText("apln_dt",i).substring(11,19)%></td>
                          <td><a href="javascript:viewPopUp('<%=linkStr%>','<%=policyview.getText("policy_no",i)%>', '<%=strCodeDiv%>');" ><b><font color="003cff"><%=policyview.getText("policy_no",i)%></font></b> </a></td>
                          <td><a href="javascript:viewPopUp('<%=linkStr%>','<%=policyview.getText("policy_no",i)%>', '<%=strCodeDiv%>');" ><b><font color="003cff"><%=policyview.getText("payor_nm",i)%></font></b> </a></td>
                          <td><%=policyview.getText("srvc_name",i)%></td>
                          <td><div align="right"><%=Util.addComma(policyview.getText("apln_amt",i))%></div></td>
                          <td><font class=font01><%=policyview.getText("rslt_name",i)%></font></td>
                          <td><%=policyview.getText("proc_dt",i).trim()%></td>
                          <td><%=policyview.getText("proc_tm",i).trim()%></td>
                          <td><%=policyview.getText("emp_nm",i)%></td>
                          <td><%=policyview.getText("lpname",i)%></td>
                        </tr>
                        <%
												row = row - 1;
											}
										}
%>
                      </table>
                      <!--/div-->

								</div><!-- excel 3�ܰ� -->
								</td>
							</tr>
							<tr>
								<td height="5"></td>
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
							<tr>
								<td >

								<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
                             <iframe name="act_frame1" width=100% height=0 marginwidth="0" marginheight="0" noresize frameBorder=0 scrolling="no"></iframe>
                             </iframe>
                            </td>
                          </tr>
                        </table></td>
							</tr>
							 <!--  ó�� �׸� ���������� -->

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

<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="premiumsearch" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plcynoinfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="payment" 	class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean id="policy" class="java.lang.String" scope="request"/>
<jsp:useBean id="policy_apln_no" class="java.lang.String" scope="request"/>
<jsp:useBean id="ssn" class="java.lang.String" scope="request"/>
<jsp:useBean id="realpay" 	class="java.lang.String" scope="request"/>

<jsp:useBean id="sbkcda" class="java.lang.String" scope="request"/>
<jsp:useBean id="sbknoa" class="java.lang.String" scope="request"/>
<jsp:useBean id="pyrna" class="java.lang.String" scope="request"/>
<jsp:useBean id="bankconf" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>

<jsp:useBean id="opt1" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="regdate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="cash" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="indate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkclt" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkcode" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkacct" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="process" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="approval" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="returnurl" 	class="java.lang.String" scope="request"/>

<!-- 2006.12.27 ������  0602294 ���̹� ������ ȭ�� ���� -->
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

<!-- 20080325 : ������ : ����ڰ��� �߰� -->
<jsp:useBean id="deathResult" 	class="java.lang.String" scope="request"/>
<html>
<%


	//���ǿ��� ����������
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);

	String	deptcd 	 = request.getParameter("deptcd")	== null ? "INT" : request.getParameter("deptcd");	
	String	init	 	 = request.getParameter("init")	== null ? "     " : request.getParameter("init");	
	String      seladvcnt	 = request.getParameter("seladvcnt")	== null ? "" : request.getParameter("seladvcnt");	
	String      bankconfc = 	request.getParameter("bankconfc")	== null ? "N" : request.getParameter("bankconfc");	
	
	int    	totdivd	 = 0;//�ѹ߻�����
	int		divthis	 = 0;//�ݳ⵵�߻���
	int		tdivint	 = 0;//�ѹ߻�����
	int		curint	 = 0;//��ġ�Ѿ�
	int		aftint		 = 0;//��ġ����
	int		balsum	 = 0;//��ȿ����������			

	//����,���� - S
	String advcnt = "";
	String todate_s 	= Util.getTodayToYMD();
	String tempdate      = todate_s.substring(0,6);//������
	
	String advcnt_s 	= premiumsearch.getText("modx").trim();//����
	int advcnt_i 		= Integer.parseInt(advcnt_s);
	
	String lpaidyy 		= premiumsearch.getText("lpaidym").substring(0,4);//�������Գ�
	String lpaidmm 	= premiumsearch.getText("lpaidym").substring(4,6);//�������Կ�
	
	int ilpaidyy 		= Integer.parseInt(lpaidyy);//�������Գ�
	int ilpaidmm 		= Integer.parseInt(lpaidmm);//�������Կ�
	
	int compday 		= 0;//�������Կ�+����
	compday			= ilpaidmm + advcnt_i;
	if(compday > 12)
	{
		ilpaidyy = ilpaidyy + 1;
		compday = compday - 12;
	}
	
	String  compyy   	= Integer.toString(ilpaidyy);
	String  compmm 	= trans.fillZero(Integer.toString(compday),2);
	
	String totsum = compyy + compmm;
	
	if( Integer.parseInt(tempdate) > Integer.parseInt(totsum))
	{
		advcnt ="2";//������ 2ȸ���� ���氡��
	}
	else 
	{
		advcnt ="1";//������ 1ȸ�� ���氡��
	}
	
	String bnkyn		= request.getParameter("bnkyn")	== null ? "": request.getParameter("bnkyn");
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="JavaScript">
<!--
	function goSelect()
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.realpay.value = formatCurrency(parseInt('<%=premiumsearch.getText("modp").trim()%>') * parseInt(form.seladvcnt.value),"");		
		var realpay = parseInt('<%=premiumsearch.getText("modp").trim()%>') * parseInt(form.seladvcnt.value);
		var realpay1 = '<%=payment.getText("apln_amt")%>';
		if(realpay != realpay1) 
		{
			alert("���Աݾ��� ������������ �ٸ��ϴ�. Ȯ���ϼ���.");
			return;
		}
	}
	
	function returnFalseMsg(cd){
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}

		var path = "";
		path = "/receipt/return_false.do?policy_apln_no="+cd;
		
		window.open(path, '���и޼���', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	
	}
	
	function formatCurrency(arg,tail)
	{
		n=String(arg)
		o=n.split(".")[0]
		p=n.split(".")[1]
		n=""
		while(o.indexOf(",")!=-1){
			o=o.replace(",","")
			}
		d=o.length%3
		for(i=0;i<o.length;i++){
			if(i%3==d){
				n+=","
				}
			n+=o.charAt(i)
			}
		if(!d){n=n.replace(n.charAt(0),"")}
		if(p){n+="."}
		if(tail!=null){
			n=n+tail
			}
		return n
	}
	
	function bankconfc(cd1, cd2, cd3)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.sbkcda.value = cd1;
		form.sbknoa.value = cd2;
		form.pyrna.value = cd3;
		//form.action = "premium_paid_search.do";
		form.submit();
	}
	
	function getLoan()
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.process.value = "L";
		form.submit();
	}		
	
	function goProcess(cd1, cd2, cd3, cd4, cd5, cd6, cd7)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.opt1.value = cd1;//�����ڵ� L1
		form.policy.value = cd2;//���ǹ�ȣ
		form.regdate.value = cd3;//��������
		form.indate.value = cd3;
		form.cash.value = cd4;//�ݾ�
		form.bnkclt.value = cd5;//�������ֹ�
		form.bnkcode.value = cd6;//�����ڵ�
		form.bnkacct.value =  cd7;//���¹�ȣ
		
		var bankon = '<%=payment.getText("bank_conf_yn")%>';
		if(bankon == 'N')
		{
			alert("������ Ȯ���� ���� �ʾҽ��ϴ�. ������ Ȯ���� �Ͻð� ���ο�û�� �ϼ���");
			return;
		}
		//if(form.process.value == "L")
		//{				
			if (confirm('���� ó���� �Ͻðڽ��ϱ�?')) 
			{		
				form.process.value = "Y";
				form.submit();
			}
			else
			{
				return;
			}	
		//}
		//else
		//{
		//	alert("ó���� ��ȸ�� �ϰ� ������ �ϼ���.");
		//	return;	
		//}									
	}
		
	function goResult(cd1, cd2, cd3, cd4, cd5, cd6, cd7)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.opt1.value = cd1;//�����ڵ� L1
		form.policy.value = cd2;//���ǹ�ȣ
		form.regdate.value = cd3;//��������
		form.indate.value = cd3;
		form.cash.value = cd4;//�ݾ�
		form.bnkclt.value = cd5;//�������ֹ�
		form.bnkcode.value = cd6;//�����ڵ�
		form.bnkacct.value =  cd7;//���¹�ȣ
		
					
		if (confirm('��ȸ/�а��� �Ͻðڽ��ϱ�?')) 
		{		
			form.process.value = "R";
			form.submit();
		}
		else
		{
			return;
		}	
	}
	
	function goTimeout()	
	{

		setTimeout("goDisable()", 1000 * 5);
	}
	
	function goDisable()
	{
		document.getElementById("btn1").disabled = true;				
	}

	function goReturn(cd)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ó�� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}

		var path = "";
		path = "/receipt/return_tbl.do?policy_apln_no="+cd;
		
		window.open(path, '�ݼ�', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	}
	
	function init(){
		//parent.heightControl( "act_frame1", "600", document.getElementById('otable').offsetHeight );
	}
	
	function windowClose(){
	
	
		window.opener.goSuccess();
		self.close();
	}
	
-->
</script>
</head>

<body onload="javascript:init();<%if( process.equals("L") ){%>goTimeout('<%=payment.getText("rslt")%>')<%}%>" >
<table width="980">
<tr>
<td colspan="2" height="10"></td>
</tr>
<tr>
<td width="10"></td>
<td>	
<form name="paymentForm"  method="post">
<input type="hidden" name="policy" value="<%=policy%>">
<input type="hidden" name="advcnt" value="<%=advcnt%>">
<input type="hidden" name="policy_apln_no" value="<%=policy_apln_no%>">
<input type="hidden" name="ssn" value="<%=ssn%>">

<input type="hidden" name="sbkcda" value="<%=sbkcda%>">
<input type="hidden" name="sbknoa" value="<%=sbknoa%>">
<input type="hidden" name="pyrna"  value="<%=pyrna%>">

<input type="hidden" name="opt1"  value="<%=opt1%>">
<input type="hidden" name="regdate"  value="<%=regdate%>">
<input type="hidden" name="cash"  value="<%=cash%>">
<input type="hidden" name="indate"  value="<%=indate%>">
<input type="hidden" name="bnkclt"  value="<%=bnkclt%>">
<input type="hidden" name="bnkcode"  value="<%=bnkcode%>">
<input type="hidden" name="bnkacct"  value="<%=bnkacct%>">
<input type="hidden" name="process"  value="<%=process%>">
<input type="hidden" name="returnurl"  value="/receipt/premium_paid_search.do">
<input type="hidden" name="bnkyn"  value="<%=bnkyn%>">

<!-- �ߺ���û ����. saveToken �̿� -->
<INPUT type="hidden" name="org.apache.struts.taglib.html.TOKEN" value="<%=session.getAttribute("org.apache.struts.action.TOKEN")%>" >

<!--table width="100%" height="100%">
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
						<!--jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="2"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					<!--/td>
							<td class="contents"-->
							
							
	<!-- �α��� ���θ� ���� üũ�Ѵ�. ����    : ��ȭ���� ����Ʈȭ�� ������ ���鼭.. �α��ο��� üũ�� ���� ����ȭ�鿡�� üũ�Ѵ�.-->							
<%


	String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	
	String islogin = "";
	if( emp_no.equals("") || emp_no.equals("null") )
	{
		islogin = "N";
	}
%>	
 

<script language="javascript">

<%
	if( islogin.equals("N"))
	{
%>	
		opener.location.href="/payment/cyber_login.do";
		self.close();
<%
	}
	%>
</script>
<!-- �α��� ���θ� ���� üũ�Ѵ�. ��-->								
							
							<table width="100%" id="otable">
							<!--tr> 
								<td><img src="/img/common/title_0.gif"></td>
							</tr-->						
							<tr> 
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"></td>
							</tr>
							<tr> 
								<td> <table width="100%">
										<tr> 
											<td><img src="/img/common/bu_cir01.gif"> 
												<b>�߰���������</b></td>
											<td align="right">
											<!--a href="/receipt/policy_view.do?modeind=2&srvc_ind=6&searchgubun=S" onFocus="blur()"><img src="/img/common/btn_list.gif" hspace="10" border="0"></a-->
											
											<a href="javascript:windowClose();"><img src="/img/common/btn_close.gif" hspace="10" border="0"></a>
											</td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td><table width="100%">
										<tr> 
											<td width=250 valign="top" style="padding-right: 10px;"><table width="100%" class="adm_table">
<%
													String bcashvl = "";//����ؾ�ȯ�ޱ�
													String refnprm = "";//�̰�������
													String val_pua = "";//�߰��ϳ�����
													String acu_div = "";//�ѹ�翹ġ��	
													String acc_div = "";//��ġ������
													String pdffund = "";//PDF
													String acrdpdf = "";//PDF����
													String tot_amt = "";//���޾�
													String pl_prin = "";//��������
													String pl_int  = "";//��������
													String apl_amt = "";//apl�����
													String ard_apl = "";//apl��������
													String red_amt = "";//������
													String act_amt = "";//�����޾�
													
													bcashvl = plcynoinfo.getText("bcashvl",0).trim();
													refnprm = plcynoinfo.getText("refnprm",0).trim();
													val_pua = plcynoinfo.getText("val_pua",0).trim();
													acu_div = plcynoinfo.getText("acu_div",0).trim();
													acc_div = plcynoinfo.getText("acc_div",0).trim();
													pdffund = plcynoinfo.getText("pdffund",0).trim();
													acrdpdf = plcynoinfo.getText("acrdpdf",0).trim();
													tot_amt = plcynoinfo.getText("tot_amt",0).trim();
													pl_prin = plcynoinfo.getText("pl_prin",0).trim();
													pl_int = plcynoinfo.getText("pl_int",0).trim();
													apl_amt = plcynoinfo.getText("apl_amt",0).trim();
													ard_apl = plcynoinfo.getText("ard_apl",0).trim();
													red_amt = plcynoinfo.getText("red_amt",0).trim();
													act_amt = plcynoinfo.getText("act_amt",0).trim();
													String banknm1 = "";
													String bankcd1 = "";
%>																		
													<tr class="adm15"> 
														<th>����ؾ�ȯ�ޱ�</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(bcashvl)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>�̰�������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(refnprm)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>�߰��ϳ�����</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(val_pua)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>�ѹ�翹ġ��</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acu_div)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>��ġ������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acc_div)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>PDF</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pdffund)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>PDF����</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acrdpdf)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>���޾�</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(tot_amt)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>��������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_prin)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>��������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_int)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>APL�����</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(apl_amt)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>APL��������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(ard_apl)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(red_amt)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>�����޾�</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(act_amt)%>"></td>
													</tr>
												</table></td>
											<td><table width="100%">
													<tr> 
														<td height="40" valign="top"><table width="100%">
																<tr> 
																	<td background="/img/edit/subtitle_bg.gif"> 
																		<table height="31" class="subtitle">
																			<tr> 
																				<td class="select">�������ȸ</td>
																				<td><a href="premium_paid_info.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">���⺻����</a></td>
																				<th>|</th>
																				<td><a href="premium_paid_list.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">�Աݳ���</a></td>
																			</tr>
																		</table></td>
																	<td class="subright"></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%> 
																<tr class="adm11"> 
																	<th>���ǹ�ȣ</th>
																	<td><%=payment.getText("policy_no")%></td>
																	<th>�����</th>
																	<td><%=payment.getText("payor_nm")%></td>
																</tr>
																<tr class="adm11"> 
																	<th>����ó</th>
<%
																	String payor_phone = "";
																	payor_phone =  payment.getText("payor_phone").trim();								
																	if(payor_phone.substring(0,2).equals("01")) 
																	{
																	
																		payor_phone = Util.to_Cell(payor_phone);
																	}
																	else
																	{
																		payor_phone = Util.toTel(payor_phone);
																	}
%>																			
																	<td><%=payor_phone%></td>
																	<th>E-Mail</th>
																	<td><%=payment.getText("payor_email").trim()%></td>
																</tr>
															</table></td>
													</tr>
													<tr> 
														<td><img src="/img/common/bu_cir02.gif"> 
															<b>����� ��ȸ</b></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<col width=10%><col width=15%><col width=10%><col width=15%><col width=10%><col width=15%><col width=10%><col width=15%>
																<tr class="adm13"> 
																	<th>���ⳳ����</th>
<%
																	String ptd = "";
																	ptd = premiumsearch.getText("ptd").trim();
																	if(ptd.length() > 0)
																	{
																		ptd = ptd.substring(0,4) + "." +ptd.substring(4,6) +"." + ptd.substring(6,8);
																	}
%>																																		
												                                  <td class="ce"><%=ptd%></td>																													
												                                  <th>���溸���</th>
																	<td><%=Util.addComma(premiumsearch.getText("modp").trim())%></td>																	
                                  													<th>���������</th>
																	<td><%=Util.addComma(premiumsearch.getText("prmsusp").trim())%></td>																	
                                  													<th>���������</th>
																	<td><%=Util.addComma(premiumsearch.getText("missusp").trim())%></td>
																</tr>
															</table></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
												                                  <col width=20%>
												                                  <col width=30%>
												                                  <col width=20%>
												                                  <col width=30%>
												                                  <tr class="adm11"> 
												                                    <th>����Ƚ��</th>
												                                    <td>1ȸ <%--<select name="seladvcnt" class="box02">
<%
																		if(advcnt.equals("1"))
																		{
%>
																		<option value = "1" selected>1</option>
<%						
																		}
																		else
																		{
%>                                    

												                                        <option  value="1" selected>1</option>                                        
												                                        <option value="2">2</option>
<%
																		}
%>                                        
											                                      </select> <a href="javascript:goSelect()" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
											                                    --%></td>
											                                    <th>����</th>
											                                    <td> 
<%
																String modx = "";//�����ֱ�
																modx = premiumsearch.getText("modx").trim();
															
																if(modx.equals("01")) 
																{
																	modx = "����";
																}
																else if(modx.equals("03")) 
																{
																	modx = "3������";
																}
																else if(modx.equals("06")) 
																{
																	modx = "6������";
																}
																else if(modx.equals("12")) 
																{
																	modx = "����";
																} else 
																{
																	modx = "";
																}
%>
								                                      <input type="text" name="textfield3" class="box03" readonly value="<%=modx%>"></td>
								                                  </tr>
								                                  <tr class="adm11"> 
								                                    <th>������</th>
								                                    <td><input type="text" name="modp" class="box03" readonly style="text-align:right" value="<%=Util.addComma(premiumsearch.getText("modp"))%>"> 
								                                    </td>
								                                    <th>ȸ��</th>
<%
														String lpdcnt = Integer.toString(Integer.parseInt(premiumsearch.getText("lpadcnt").trim()) + 1);		
%>								                                    
								                                    <td><input type="text" name="textfield4" class="box03" style="text-align:right" readonly value="<%=lpdcnt%>">ȸ</td>
								                                  </tr>
								                                  <tr class="adm11"> 
								                                    <th>�������Կ�</th>
<%
														String lpaidym = premiumsearch.getText("lpaidym").trim();//�������Կ�
														if(lpaidym.length() > 0)
														{
															lpaidym = lpaidym.substring(0,4) +"." + lpaidym.substring(4,6);
														}
%>								                                    
								                                    <td><input type="text" name="textfield5" class="box03" readonly value="<%=lpaidym%>"> 
								                                    </td>
								                                    <th>���Աݾ�</th>
								                                    <td><input type="text" name="realpay" class="box03" readonly style="text-align:right" value="<%=realpay%>"></td>
								                                  </tr>
								                                </table></td>
													</tr>
													<tr> 
														<td height="5" background="/img/common/line.gif"></td>
													</tr>
													<tr> 
														<td>&nbsp;</td>
													</tr>
													<tr> 
														<td><img src="/img/common/bu_cir02.gif"> 
															<b>������Ա� ��������</b></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%> 
																<tr class="adm21"> 
																	<th>���ⳳ����</th>
																	<td><%=ptd%></td>
																	<th>ȸ��</th>
																	<td><%=lpdcnt%></td>
																</tr>
																<tr class="adm21"> 
																	<th>����Ƚ��</th>
<%
																	String modp 		= premiumsearch.getText("modp").trim();
																	String apln_amt 	= payment.getText("apln_amt").trim();
																	String incount		= "";
																	if(modp.equals(apln_amt))
																	{
																		incount = "1";
																	}
																	else
																	{
																		incount = "2";
																	}	
%>																	
																	<td><%=incount%>ȸ</td>
																	<th>���Աݾ�</th>
																	<td><div align="right"><%=Util.addComma(payment.getText("apln_amt").trim())%></div></td>
																</tr>
																<tr class="adm21">																	                                    												
                                    												<th>������</th>																	
												                                    <td><%=payment.getText("acct_nm").trim()%></td>
												                                    <th>����</th>
																	<%	banknm1 = payment.getText("bank_name").trim();
																		bankcd1 = payment.getText("bank_cd").trim();
																	//2006.10.04 : �躸�� : �ѱ���Ƽ����(27, 53->27), �츮����(83, 20->20), ��������(21, 26->88)
																	if(bankcd1.equals("53")){
																		bankcd1 = "27";
																		banknm1 = "�ѱ���Ƽ����";
																	}else if(bankcd1.equals("83")){
																		bankcd1 = "20";
																		banknm1 = "�츮����";
																	}else if(bankcd1.equals("21")||bankcd1.equals("26")){
																		bankcd1 = "88";
																		banknm1 = "��������";
																	}
																	/*else if(bankcd1.equals("04")){
																		bankcd1 = "04";
																		banknm1 = "����������";
																	}*/
																	%>																	
																	<td><%=banknm1%></td>
																</tr>
																<tr class="adm21"> 																	
												                                    <th>���¹�ȣ</th>																	
												                                    <td><%=payment.getText("acct_no").trim()%></td>																	
												                                    <th>����ó</th>																	
												                                    <td><%=payor_phone%></td>
																</tr>																
																<tr class="adm21"> 																												
												                                    <th>E-Mail</th>																	
												                                    <td><%=payment.getText("payor_email").trim()%></td>																	
												                                    <th>����</th>
<%
																	String rsltname = "";
																	rsltname = payment.getText("rslt").trim();
																	if(rsltname.equals("0"))
																	{
																		rsltname = "����"; 
																	}
																	else if(rsltname.equals("1"))
																	{
																		rsltname = "�ݼ�";
																	}
																	else if(rsltname.equals("2"))
																	{
																		rsltname = "����";
																	}
																	else if(rsltname.equals("3"))
																	{
																		rsltname = "����";
																	}
																	else if(rsltname.equals("A"))
																	{
																		rsltname = "������";
																	}
																	else 
																	{
																		rsltname = "����";
																	}
%>													                          <td>          																	
												                                    <input type="text" name="rsltname"  value="<%=rsltname%>" size="14" maxlength="10"  style="background-color:white; border-width:0; border-color:black; border-style:solid;" readonly >
												                                  </td>  
																</tr>
																<tr class="adm21"> 																	
												                                   <th><a href="javascript:bankconfc('<%=bankcd1%>','<%=payment.getText("acct_no")%>','<%=payment.getText("payor_ssn")%>');" onFocus="blur()"><u>������Ȯ��</u></a></th>
<%												                                   
																	String wbbank = "";
																	wbbank = payment.getText("bank_conf_yn");
																	if(bnkyn.equals("0") || wbbank.equals("Y"))
																	{
																		bankconfc = "Ȯ��";																		
																	}
																	else
																	{
																		bankconfc = "��Ȯ��";
																	}										                                   											
%>
																	<td><%=bankconfc%></td>                                    												
																	<td style="border-right: none; border-bottom: none;"></td>
																	<td style="border-left: none; border-right: none; border-bottom: none;"></td>
																</tr>
															</table></td>
													</tr>
													<tr> 
														<td align="right">
<%

														
														//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
														//if(auth_cd.equals("20") || auth_cd.equals("30"))
														if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
														{
														
															if(payment.getText("rslt").equals("3"))														
															{
%>
													<img src="/img/common/btn_inq.gif"  style="cursor: hand;" id="btn1" onClick="goResult('P2','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
<%																
															}
															else
															{
%>														
													<!--a href="javascript:getLoan()" onFocus="blur()"><img src="/img/common/btn_inquirys.gif" border="0"></a-->
<%
															}	
%>														


<%
													if(payment.getText("rslt").equals("2"))														
															{
%>
														<a href="javascript:returnFalseMsg('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_sms_email_send.gif" hspace="10"></a> 


<%
														
															}
%>															

													<a href="javascript:goReturn('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_return.gif" hspace="10"></a>



<%														
																												
															if(payment.getText("rslt").trim().equals(""))
															{
%>														
													<img src="/img/common/btn_recognize.gif"  style="cursor: hand;" id="btn1" onClick="goProcess('P2','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')"></td>
<%
															}
															else 														
															{
%>
													&nbsp;</td>		
<%														
															} 
																														
														}//20~30
%>														

													</tr>
													<tr> 
														<td height="10"></td>
													</tr>
													<tr> 
														<td height="5" background="/img/common/line.gif"></td>
													</tr>
													<tr> 
														<td>&nbsp;</td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=> 
																<tr class="adm16"> 
																	<th>ó�����</th>
<%																	
																String errmsg1 = "";																
																if(process.equals("Y"))
																{																
																	errmsg1 = approval.getText("errmsg1").trim() + "- " + approval.getText("errmsg2").trim();
																}
																
																//WB_PAYMENT���� err_msg�� ������
																if(errmsg1.length() == 0)
																{
																	errmsg1 = payment.getText("err_msg");
																}																																																																
%>																											
																	<td><input name="errmsg" type="text" class="box10" value="<%=errmsg1%>"></td>
																</tr>
															</table></td>
													</tr>
												</table></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td height="50">&nbsp;</td>
							</tr>
						</table><!--/td>
				</tr>
			</table></td>
	</tr>
	<tr> 
		<td height="56" background="/img/common/copy_bg.gif"><img src="/img/common/copy.gif"></td>
	</tr>
</table-->
</form>
</td>
</tr>
</table>
</body>
</html>
<%@ page import = "gtone.changeminer.common.constant.*, gtone.changeminer.common.manager.SessionManager, java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util, gtone.changeminer.common.utility.Utility" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<!--PAYMENT SCREEN-->
<jsp:useBean id="checkopt" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="workinginfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="otherSystemStatus" 	class="anyframe.data.DataSet" scope="request"/>

<!---->
<jsp:useBean id="plpayment" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plpaymentApln" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plpaymentlist" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plcynoinfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="payment" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="policy" class="java.lang.String" scope="request"/>
<jsp:useBean id="policy_apln_no" class="java.lang.String" scope="request"/>
<jsp:useBean id="ssn" class="java.lang.String" scope="request"/>

<jsp:useBean id="sbkcda" class="java.lang.String" scope="request"/>
<jsp:useBean id="sbknoa" class="java.lang.String" scope="request"/>
<jsp:useBean id="pyrna" class="java.lang.String" scope="request"/>
<jsp:useBean id="bankconf" 	class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean id="opt1" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="regdate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="cash" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="indate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkclt" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkcode" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkacct" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="process" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="approval" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="recognize" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>
<jsp:useBean id="plancd" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="working2after" 	class="java.lang.String" scope="request"/>

<!-- 2006.12.27  -->
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

<!-- 20080201 :   METHOD=P -->
<jsp:useBean id="contractDetail" class="anyframe.data.DataSet" scope="request"/>

<!-- 20080325 :   -->
<jsp:useBean id="deathResult" 	class="java.lang.String" scope="request"/>

<html>
<%
	String bnkyn		= request.getParameter("bnkyn")	== null ? "": request.getParameter("bnkyn");
    //  
    if("".equals(Util.nvl(plancd)) == false) {
        plancd = plancd.substring(0,2);
    }
%>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript">
<!--
	function goReturn(cd)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("Interest Rate"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("Interest Rate"))  {
				return;
			}
		}

		var path = "";
		path = "/receipt/return_tbl.do?policy_apln_no="+cd;

		window.open(path, ' ', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');

	}

	function returnFalseMsg(cd){
		if ("<%=deathResult%>" == "1") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("Check your payment list!"))  {
				return;
			}
		}


		var path = "";
		path = "/receipt/return_false.do?policy_apln_no="+cd;

		window.open(path, ' ', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');


	}



	function bankconfc(cd1, cd2, cd3)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm(" "))  {
				return;
			}
		}


		form = document.paymentForm;
		form.sbkcda.value = cd1;
		form.sbknoa.value = cd2;
		form.pyrna.value = cd3;
		//form.action = "pl_payment_list.do";
		form.submit();
	}

	function getLoan()
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm(" "))  {
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
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm(" "))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}


<%
SessionManager sessionManager = new SessionManager(request);
String emp_no = sessionManager.getString(Constant.SESSION_USERID);
%>
		var recon_id = "<%=payment.getText("recon_id")%>";
		var cur_id = "<%=emp_no%>";

		if (recon_id == cur_id) {
			alert("Message Alert");
			return;
		}
		var act_amt = <%=payment.getText("apln_amt",0).trim()%>-0;
		var auth_cd = "<%=payment.getText("auth_cd")%>";
		if (act_amt > 10000000) {
			alert("Watch out");
			return;
		} else if (act_amt > 2000000 && auth_cd != "32" && auth_cd != "33") {
			alert("Watch out");
			return;
		}
		form = document.paymentForm;
		form.opt1.value = cd1;
		form.policy.value = cd2;
		form.regdate.value = cd3;
		form.indate.value = cd3;
		form.cash.value = cd4;
		form.bnkclt.value = cd5;
		form.bnkcode.value = cd6;
		form.bnkacct.value =  cd7;

		//if(form.process.value == "L")
		//{
			if (confirm('Message'))
			{
				form.process.value = "Y";
				form.action = "pl_payment_list.do";
				form.submit();
			}
			else
			{
				return;
			}
		//}
	}


	function goRecogn(cd,cd1, cd2, cd3, cd4, cd5, cd6, cd7)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("Message?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("Message Confirm"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("Message?"))  {
				return;
			}
		}

		form = document.paymentForm;
		var Time = new Date();

		var bankon = '<%=payment.getText("bank_conf_yn")%>';


		//20060601 
		//20060601 

		var selopt  	= '<%=checkopt.getText("selopt")%>';	
		var advcnt 	= '<%=checkopt.getText("advcnt")%>';	
		var aplclose	= '<%=workinginfo.getText("aplclose")%>';   
		var delayclose	= '<%=workinginfo.getText("delay_pay_close")%>'; 

		//20080201 : METHOD=P
		var method =  '<%=contractDetail.getText("method")%>';  
		
		//test
		//selopt='0';
		//advcnt='2';
		//aplclose='Y';
		//delayclose='Y';
		//alert(" ,2 : "+selopt+" /   : "+advcnt+" /   : "+aplclose+" /   : "+delayclose);


		if(aplclose == 'Y'){
			if(advcnt == '2' && method !='P'){
<%
    // 0800133 : 
    if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) == false) { 
%>
				alert("Message");
				return;
<%
    }else {
%>
				alert("Message");
<%
    }
%>
			}
		}

		// 
		if(delayclose == 'Y'){
			if(selopt == '0' || selopt == '2'){
				if(advcnt == '2' && method !='P'){
<%
    // 0800133 : 
    if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) == false) { 
%>
					alert("Message ");
					return;
<%
    }else {
%>
					alert("Message ");
<%
    }
%>
				}
			}
		}


		if(bankon == 'N')
		{
			alert("Message");
			return;
		}
		else
		{
			//if(form.process.value == "L")
			//{
				if (confirm('Confirm?'))
				{
					form.process.value = "R";
					form.opt1.value = cd1;
					form.policy.value = cd2;
					form.regdate.value = cd3;
					form.indate.value = cd3;
					form.cash.value = cd4;
					form.bnkclt.value = cd5;
					form.bnkcode.value = cd6;
					form.bnkacct.value =  cd7;

					form.action = "pl_payment_list.do";
					form.submit();

				}
				else
				{
					return;
				}
			//}
			//else
			//{
			//	alert(" ");
			//	return;
			//}
		}
	}

	function goTimeout(cd)
	{

		if(cd != 'A')
			setTimeout("goDisable()", 1000 * 5);
		else
			setTimeout("goDisable1()", 1000 * 5);
	}

	function goDisable()
	{
		document.getElementById("btn2").disabled = true;
	}

	function goDisable1()
	{
		document.getElementById("btn1").disabled = true;
	}

	function goProcess1(cd1, cd2, cd3, cd4, cd5, cd6, cd7,cd8)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("Cofirm?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("Message Confirm"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("Confirm?"))  {
				return;
			}
		}


		var act_amt = <%=payment.getText("apln_amt",0).trim()%>-0;
		var auth_cd = "<%=payment.getText("auth_cd")%>";
		if (act_amt > 1000 && auth_cd != "33") {
			alert("1000");
			return;
		} else if (act_amt > 200 && auth_cd != "32" && auth_cd != "31") {
			alert("200");
			return;
		}
		form = document.paymentForm;
		form.opt1.value = cd1;
		form.policy.value = cd2;
		form.regdate.value = cd3;
		form.indate.value = cd3;
		form.cash.value = cd4;
		form.bnkclt.value = cd5;
		form.bnkcode.value = cd6;
		form.bnkacct.value =  cd7;
		form.sndseq.value = cd8;

		//if(form.process.value == "L")
		//{
			if (confirm(' '))
			{
				form.process.value = "K";
				form.action = "pl_payment_list.do";
				form.submit();
			}
			else
			{
				return;
			}
		//}
	}

	function getResult(cd1, cd2, cd3, cd4, cd5, cd6, cd7,cd8)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("Confirm?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("Message Confirm"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("Message?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.opt1.value = cd1;
		form.policy.value = cd2;
		form.regdate.value = cd3;
		form.indate.value = cd3;
		form.cash.value = cd4;
		form.bnkclt.value = cd5;
		form.bnkcode.value = cd6;
		form.bnkacct.value =  cd7;
		form.sndseq.value = cd8;


		if (confirm('Confirm'))
		{
			form.process.value = "K";
			form.action = "pl_payment_list.do";
			form.submit();
		}
		else
		{
			return;
		}

	}



	function init(){

		//parent.heightControl( "act_frame1", "600", document.getElementById('otable').offsetHeight );
<%
    if(payment.getText("rslt").trim().equals("0") == false
    && ("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd))) {
%>
        var varMessage     = "";
        varMessage += "<%=otherSystemStatus.getText("capsil_message"    )%>";
        varMessage += "<%=otherSystemStatus.getText("image_message"     )%>";
        varMessage += "<%=otherSystemStatus.getText("callcenter_message")%>";

        if(varMessage != "") {
            alert(varMessage.replace(/\<br>/g,"\n"));
        }
<%
    }
%>
	}

	function windowClose(){


		window.opener.goSuccess();
		self.close();
	}

//-->
</script>
</head>

<body onload="<%if( process.equals("L") ){%>goTimeout('<%=payment.getText("rslt")%>')<%}%>;init();" >

<table width="980">
<tr>
<td colspan="2" height="10"></td>
</tr>
<tr>
<td width="10"></td>
<td>


<form name="paymentForm"  method="post">
<input type="hidden" name="policy" value="<%=policy%>">
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
<input type="hidden" name="returnurl"  value="/payment/pl_payment_list.do">
<input type="hidden" name="bnkyn"  value="<%=bnkyn%>">
<input type="hidden" name="sndseq">

<!-- saveToken  -->
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
						<!--DropDown 삽입 : S-->
						<!--jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="1"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
					<!--/td>
							<td class="contents"-->

<!-- SR.-->
<%

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
<!-- SR -->

							<table width="100%" id="otable">
							<tr>
								<td><img src="/img/common/title_01.gif"></td>
							</tr>
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
												<b>Send</b> </td>
											<td align="right">

											<!-- 2006.12.27  -->
<!--a href="/receipt/policy_view.do?searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">
											<img src="/img/common/btn_list.gif" hspace="10" border="0"></a-->
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
													<tr class="adm15">
<%
													String bcashvl = "";
													String refnprm = "";
													String val_pua = "";
													String acu_div = "";
													String acc_div = "";
													String pdffund = "";//PDF
													String acrdpdf = "";
													String tot_amt = "";
													String pl_prin = "";
													String pl_int  = "";
													String apl_amt = "";
													String ard_apl = "";
													String red_amt = "";
													String act_amt = "";

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
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(bcashvl)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(refnprm)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(val_pua)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acu_div)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acc_div)%>"></td>
													</tr>
													<tr class="adm15">
														<th>PDF</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pdffund)%>"></td>
													</tr>
													<tr class="adm15">
														<th>PDF</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acrdpdf)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(tot_amt)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_prin)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_int)%>"></td>
													</tr>
													<tr class="adm15">
														<th>APL</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(apl_amt)%>"></td>
													</tr>
													<tr class="adm15">
														<th>APL</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(ard_apl)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(red_amt)%>"></td>
													</tr>
													<tr class="adm15">
														<th>Send</th>
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
																				<td class="subleft"><a href="pl_payment_search.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">약대조회</a></td>
																				<th>|</th>
																				<td><a href="pl_payment_info.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">계약기본사항</a></td>
																				<td class="select">Send</td>
																				<td><a href="pl_payment_paidup.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">제지급금내역</a></td>
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
																	<th>Click</th>
																	<td><%=payment.getText("policy_no").trim()%></td>
																	<th>Click</th>
																	<td><%=payment.getText("payor_nm").trim()%></td>
																</tr>
																<tr class="adm11">
																	<th>Admin</th>
																	<td><%=payment.getText("payor_nm").trim()%></td>
																	<th>E-Mail</th>
																	<td><%=payment.getText("payor_email").trim()%></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td>&nbsp;</td>
													</tr>
													<tr>
														<td><img src="/img/common/bu_cir02.gif">
															<b>Business</b></td>
													</tr>
													<tr>
														<td><table width="100%" class="adm_table">
																<col width=><col width=><col width=5%><col width=14%><col width=14%><col width=14%><col width=14%><col width=14%>
																<tr class="adm11">
																	<th>Send</th>
																	<th>Message</th>
																	<th>SEQ</th>
																	<th>Service</th>
																	<th>Home</th>
																	<th>Plus</th>
																	<th>Car</th>
																	<th>Money</th>
																</tr>
<%
																int cnt = plpaymentlist.getCount("seq");

																if(cnt == 0)
																{
%>
																<tr>
																	<td colspan="8" align="center">Please send the form</td>
																</tr>
<%
																}
																else
																{
																	for(int i=0;i<cnt;i++)
																	{
%>
																<tr class="adm12">
<%
																		String procdat = plpaymentlist.getText("procdat", i).trim();
																		if(procdat.length() >= 8)
																		{
																			procdat = procdat.substring(0,4) +"." + procdat.substring(4,6) +"."+ procdat.substring(6,8);
																		}

%>
																	<td class="ce"><%=procdat%></td>
<%
																		String effdat = plpaymentlist.getText("effdat", i).trim();
																		if(effdat.length() >= 8)
																		{
																			effdat = effdat.substring(0,4) +"." + effdat.substring(4,6) +"."+ effdat.substring(6,8);
																		}

%>
																	<td class="ce"><%=effdat%></td>
																	<td class="ce"><%=plpaymentlist.getText("seq", i).trim()%></td>
																	<td><%=Util.addComma(plpaymentlist.getText("loanamt", i).trim())%></td>
																	<td><%=Util.addComma(plpaymentlist.getText("eflnamt", i).trim())%></td>
																	<td><%=Util.addComma(plpaymentlist.getText("efreamt", i).trim())%></td>
																	<td><%=Util.addComma(plpaymentlist.getText("int", i).trim())%></td>
																	<td><%=Util.addComma(plpaymentlist.getText("totamt", i).trim())%></td>
																</tr>
<%
																		}
																	}
%>
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
															<b>Image</b></td>
													</tr>
													<tr>
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%>
																<tr class="adm21">
																	<th>Payment</th>
																	<td><%=payment.getText("apln_dt").trim()%> </td>
																	<th>Category</th>
																	<%	banknm1 = payment.getText("bank_name").trim();
																		bankcd1 = payment.getText("bank_cd").trim();
																	//2006.10.04 : 
																	if(bankcd1.equals("53")){
																		bankcd1 = "27";
																		banknm1 = "Name";
																	}else if(bankcd1.equals("83")){
																		bankcd1 = "20";
																		banknm1 = "Names";
																	}else if(bankcd1.equals("21")||bankcd1.equals("26")){
																		bankcd1 = "88";
																		banknm1 = "KK";
																	}else if(bankcd1.equals("11")||bankcd1.equals("12")||bankcd1.equals("13")||bankcd1.equals("14")||bankcd1.equals("15")||bankcd1.equals("16")||bankcd1.equals("17")){
																		banknm1 = "SF";
																	}
																	/*else if(bankcd1.equals("04")){
																		bankcd1 = "04";
																		banknm1 = "LA";
																	}*/
																	%>
																	<td><%=banknm1%></td>
																</tr>
																<tr class="adm21">
																	<th>Admin</th>
																	<td><%=payment.getText("pay_cd").trim()%></td>
																	<th>Tool</th>
																	<td><%=payment.getText("acct_nm").trim()%></td>
																</tr>
																<tr class="adm21">
																	<th>Test</th>
																	<td class="adm21"><%=Util.addComma(payment.getText("apln_amt"))%></td>
																	<th>GOV </th>
																	<td><%=payment.getText("acct_no").trim()%></td>
																</tr>
																<tr class="adm21">
																	<th>Finance</th>
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
																<tr class="adm21">
																	<th>Class</th>
<%
																	String rsltname = "";
																	rsltname = payment.getText("rslt").trim();
																	if(rsltname.equals("0"))
																	{
																		rsltname = "BWK";
																	}
																	else if(rsltname.equals("1"))
																	{
																		rsltname = "SIMON";
																	}
																	else if(rsltname.equals("2"))
																	{
																		rsltname = "GRAND";
																	}
																	else if(rsltname.equals("3"))
																	{
																		rsltname = "SMALL";
																	}
																	else if(rsltname.equals("A"))
																	{
																		rsltname = "A Series";
																	}
																	else
																	{
																		rsltname = "Host";
																	}
%>
																	<td><input type="text" name="rsltname"  value="<%=rsltname%>" size="14" maxlength="10"  style="background-color:white; border-width:0; border-color:black; border-style:solid;" readonly >
																	</td>
																	<th><a href="javascript:bankconfc('<%=bankcd1%>','<%=payment.getText("acct_no")%>','<%=payment.getText("payor_ssn")%>');" onFocus="blur()"><u>예금주확인</u></a></th>
<%
																	String bankconfc = "N";
																	String wbbank = "";
																	wbbank = payment.getText("bank_conf_yn");
																	if(bnkyn.equals("0") || wbbank.equals("Y"))
																	{
																		bankconfc = "Done";
																	}
																	else
																	{
																		bankconfc = "Fail";
																	}%>
																	<td><%=bankconfc%></td>																</tr>
															</table></td>
													<tr>
														<td align="right">
<%
                                                String strAplnDt = Util.nvl(Utility.replaceStr(payment.getText("apln_dt").trim(), ".", ""), "0");
                                                if("".equals(strAplnDt)) strAplnDt = "0";
														//2005-10-10. 05-C-138. 
                                                                                                                //if(payment.getText("auth_cd").equals("20") || payment.getText("auth_cd").equals("30"))
                                                                                                                if(payment.getText("auth_cd").equals("20") || payment.getText("auth_cd").equals("30") || payment.getText("auth_cd").equals("31") || payment.getText("auth_cd").equals("32") || payment.getText("auth_cd").equals("33"))
														{
															if(payment.getText("rslt").trim().equals("") || payment.getText("rslt").equals("A"))
															{
%>
														<!--a href="javascript:getLoan()" onFocus="blur()"><img src="/img/common/btn_inquirys.gif" border="0"></a-->
														<a href="javascript:goReturn('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_return.gif" hspace="10"></a>
<%
															}
															else if(payment.getText("rslt").trim().equals("3"))
															{
                                                    
                                                                if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) &&
                                                                    Integer.parseInt(working2after) > Integer.parseInt(Utility.getToday("yyyyMMdd")) && Integer.parseInt(strAplnDt) > 20080102) {

                                                                }else {
%>
														<a href="javascript:getResult('L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>','<%=payment.getText("sending_num")%>')" onFocus="blur()"><img src="/img/common/btn_sbun.gif" border="0"></a>
<%
                                                                }
%>
														<a href="javascript:goReturn('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_return.gif" hspace="10"></a>
<%
															}
															else if(payment.getText("rslt").trim().equals("2"))
															{
%>
														<a href="javascript:returnFalseMsg('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_sms_email_send.gif" hspace="10"></a>

														<a href="javascript:goReturn('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_return.gif" hspace="10"></a>
<%
															}

													/*****************  - S *********************/
													int loanval    = 0;
													int loanval80  = 0;
													int loanval100 = 0;
													// Loan Rate
													for(int i=0;i<plpaymentApln.getCount("rid_nam");i++)
													{
														loanval   = loanval  + Integer.parseInt(plpaymentApln.getText("loanval",i).trim());
													}

													for(int i=0;i<plpayment.getCount("rid_nam");i++)
													{
														loanval80   = loanval80  + Integer.parseInt(plpayment.getText("loanval80" ,i).trim());
														loanval100  = loanval100 + Integer.parseInt(plpayment.getText("loanval100",i).trim());
													}
													int amt1 = loanval;
													int amt2 = loanval80;
													int amt3 = Integer.parseInt(payment.getText("apln_amt"));
													int amt4 = loanval100;

													// CIO
													if( amt1 >= amt3 || ("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)))
													{
                                
                                                        if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) 
                                                        && Integer.parseInt(strAplnDt) > 20080102
                                                        && (Integer.parseInt(working2after) > Integer.parseInt(Utility.getToday("yyyyMMdd")) || amt1 < amt3 || amt2 < amt3)) {
                                                            if(Integer.parseInt(working2after) <= Integer.parseInt(Utility.getToday("yyyyMMdd"))
                                                            && (payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33"))
                                                            && payment.getText("rslt").trim().equals("A")) {
                                                                if(amt3 <= amt4) {
%>
																<img src="/img/common/btn_constraint.gif"  style="cursor: hand;" id="btn1" onClick="goProcess('L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
																<input type="hidden" name="variable_div" value="Y">
<%
                                                                }
                                
                                                            } else if(Integer.parseInt(working2after) <= Integer.parseInt(Utility.getToday("yyyyMMdd"))
                                                                   && (payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33"))
                                                                   && payment.getText("rslt").trim().equals("2") == false
                                                                   && payment.getText("rslt").trim().equals("1") == false
                                                                   && payment.getText("rslt").trim().equals("0") == false
                                                                   && payment.getText("rslt").trim().equals("3") == false
                                                                   && payment.getText("rslt").trim().equals("A") == false) {
%>
																<img src="/img/common/btn_money.gif"  style="cursor: hand;" id="btn2" onClick="javascript:goRecogn('<%=payment.getText("policy_apln_no")%>','L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
<%

                                                            } else {
%>
													&nbsp;
<%
                                                            }
                                                        }else {
																//2005-10-10. 
																//if((payment.getText("auth_cd").trim().equals("30") && payment.getText("rslt").trim().equals("A")))
																if((payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33")) && payment.getText("rslt").trim().equals("A"))
																{
%>
															<img src="/img/common/btn_recognize.gif"  style="cursor: hand;" id="btn1" onClick="goProcess('L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
<%
																}
																else if(payment.getText("rslt").trim().equals("2") || payment.getText("rslt").equals("1") || payment.getText("rslt").equals("0") || payment.getText("rslt").equals("3"))
																{
%>
															&nbsp;
<%
																}
																else if(!payment.getText("rslt").trim().equals("A"))
																{
%>
															<img src="/img/common/btn_money.gif"  style="cursor: hand;" id="btn2" onClick="javascript:goRecogn('<%=payment.getText("policy_apln_no")%>','L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
<%
																}
															}
															}
														}
														else
														{
%>
														&nbsp;
<%
														}
%>														</td>
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
																	<th>처리결과</th>
<%
																String errmsg1 = "";
																if(process.equals("Y"))
																{
																	errmsg1 = approval.getText("errmsg1").trim() + "- " + approval.getText("errmsg2").trim();
																}

																//WB_PAYMENT
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

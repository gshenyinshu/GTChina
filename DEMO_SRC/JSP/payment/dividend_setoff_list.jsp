<%@ page import = "gtone.changeminer.common.constant.*, gtone.changeminer.common.manager.SessionManager, java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="dividendofflist" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plcynoinfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>
<jsp:useBean id="payment" 	class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean id="policy" class="java.lang.String" scope="request"/>
<jsp:useBean id="policy_apln_no" class="java.lang.String" scope="request"/>
<jsp:useBean id="ssn" class="java.lang.String" scope="request"/>
<jsp:useBean id="opt1" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="rcvdate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="date" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bk_clt" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bk_cod" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bk_acct" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="process" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="indate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="approval" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="recognize" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="sndseq" 	class="anyframe.data.DataSet" scope="request"/>

<!-- 2006.12.27 유섭교  0602294 사이버 고객센터 화면 수정 -->
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

<!-- 20080325 : 김종명 : 사망자관련 추가 -->
<jsp:useBean id="deathResult" 	class="java.lang.String" scope="request"/>

<html>
<%

	int    	totdivd	 = 0;//총발생배당액
	int		divthis	 = 0;//금년도발생액
	int		tdivint	 = 0;//총발생이자
	int		curint	 = 0;//예치총액
	int		aftint		 = 0;//예치이자
	int		balsum	 = 0;//실효후지급이자			

%>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">

<!--	
	function goReturn(cd)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		var path = "";
		path = "/payment/return_tbl.do?policy_apln_no="+cd;
		
		window.open(path, '반송', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	}
	
	
	function returnFalseMsg(cd){
		if ("<%=deathResult%>" == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		var path = "";
		path = "/receipt/return_false.do?policy_apln_no="+cd;
		
		window.open(path, '실패메세지', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	
	}

	function getLoan()
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.process.value = "L";
		form.submit();
	}
	
	function goProcess(cd1, cd2, cd3, cd4)
	{	
		if ("<%=deathResult%>" == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
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
			alert("본인 결재요청건은 본인이 처리할 수 없습니다.");
			return;
		}
		var act_amt = <%=payment.getText("apln_amt",0).trim()%>-0;
		var auth_cd = "<%=payment.getText("auth_cd")%>";
		if (act_amt > 10000000) {
			alert("지급 권한에 맞지 않는 금액입니다.");
			return;
		} else if (act_amt > 2000000 && auth_cd != "32" && auth_cd != "33") {
			alert("지급 권한에 맞지 않는 금액입니다.");
			return;
		}
		form = document.paymentForm;
		form.opt1.value = cd1;//처리옵션
		form.policy.value = cd2;//증권번호
		form.rcvdate.value = cd3;//접수일자
		form.indate.value = cd3;
		form.date.value = cd4;//지급일자 // 2007년 5월25일 넘어오는건 금액인데 date에 왜 집어 넣는지 모르겠음. 일단 놔둠.
		form.cash.value = cd4;//금액

		//if(form.process.value == "L")
		//{				
			if (confirm('지급 처리 입니다.\n\n결재 처리를 하시겠습니까?')) 
			{		
				form.process.value = "Y";
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
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		form = document.paymentForm;
		var Time = new Date();
		
		//if(form.process.value == "L")
		//{			
			if (confirm('결재 요청을 하시겠습니까?')) 
			{		
				form.process.value = "R";
				form.opt1.value = cd1;//선택코드 L1
				form.policy.value = cd2;//증권번호
				form.regdate.value = cd3;//접수일자
				form.indate.value = cd3;
				form.cash.value = cd4;//금액
				form.bnkclt.value = cd5;//예금주주번
				form.bnkcode.value = cd6;//은행코드
				form.bnkacct.value =  cd7;//계좌번호
				
				form.action = "dividend_setoff_list.do";
				form.submit();
				
			}
			else
			{
				return;
			}
		//}
		//else
		//{
		//	alert("처리전 조회를 하시고 결재를 신청하세요.");
		//	return;
		//}	
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
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		var act_amt = <%=plcynoinfo.getText("act_amt",0).trim()%>-0;
		var auth_cd = "<%=payment.getText("auth_cd")%>";
		if (act_amt > 1000 && auth_cd != "33") {
			alert("1000만원 초과금액에 대하여 결재권한이 없습니다.");
			return;
		} else if (act_amt > 200 && auth_cd != "32" && auth_cd != "31") {
			alert("200만원 초과금액에 대하여 결재권한이 없습니다.");
			return;
		}
		form = document.paymentForm;
		form.opt1.value = cd1;//처리옵션
		form.policy.value = cd2;//증권번호
		form.rcvdate.value = cd3;//접수일자
		form.indate.value = cd3;
		form.date.value = cd4;//지급일자 // 2007년 5월25일 넘어오는건 금액인데 date에 왜 집어 넣는지 모르겠음. 일단 놔둠.
		form.cash.value = cd4;//금액
		form.bk_clt.value = cd5;//예금주주번
		form.bk_cod.value = cd6;//은행코드
		form.bk_acct.value =  cd7;//계좌번호
		form.sndseq.value = cd8;//전송번호
				
		//if(form.process.value == "L")
		//{			
			if (confirm('지급 처리 입니다.\n\n결재 처리를 하시겠습니까?')) 
			{		
				form.process.value = "K";
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
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 지급 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.opt1.value = cd1;//선택코드 L1
		form.policy.value = cd2;//증권번호
		form.regdate.value = cd3;//접수일자
		form.indate.value = cd3;
		form.cash.value = cd4;//금액
		form.bnkclt.value = cd5;//예금주주번
		form.bnkcode.value = cd6;//은행코드
		form.bnkacct.value =  cd7;//계좌번호
		form.sndseq.value = cd8;//전송번호
				
					
		if (confirm('지연건입니다.\n\n결과조회및 분개를 하시겠습니까?')) 
		{		
			form.process.value = "K";
			form.action = "dividend_setoff_list.do";
			form.submit();
		}
		else
		{
			return;
		}
			
	}					
	
	
	function init(){
	
		//parent.heightControl( "act_frame1", "600", document.getElementById('otable').offsetHeight );
		
	}
	
	function windowClose(){
	
	
		window.opener.goSuccess();
		self.close();
	}		
									
//-->
</script>
<body onload="javascript:init();<%if( process.equals("L") ){%>onload="javascript:goTimeout('<%=payment.getText("rslt")%>')<%}%>" >
<table width="980">
<tr>
<td colspan="2" height="10"></td>
</tr>
<tr>
<td width="10"></td>
<td>	
<form name="paymentForm"  method="post">
<input type="hidden" name="policy" value="<%=policy%>">
<input type="hidden" name="ssn" value="<%=ssn%>">
<input type="hidden" name="policy_apln_no" value="<%=policy_apln_no%>">

<input type="hidden" name="opt1"  value="<%=opt1%>">
<input type="hidden" name="rcvdate"  value="<%=rcvdate%>">
<input type="hidden" name="date"  value="<%=date%>">
<input type="hidden" name="bk_clt"  value="<%=bk_clt%>">
<input type="hidden" name="bk_cod"  value="<%=bk_cod%>">
<input type="hidden" name="bk_acct"  value="<%=bk_acct%>">
<input type="hidden" name="process"  value="<%=process%>">
<input type="hidden" name="indate"  value="<%=indate%>">
<input type="hidden" name="sndseq"  value="<%=sndseq%>">
<input type="hidden" name="returnurl"  value="/payment/dividend_setoff_list.do">
<input type="hidden" name="procgb"  value="D1">
<input type="hidden" name="regdate">
<input type="hidden" name="cash">
<input type="hidden" name="bnkclt">
<input type="hidden" name="bnkcode">
<input type="hidden" name="bnkacct">

<!-- 중복요청 막음. saveToken 이용 -->
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
								
<!-- 로그인 여부를 직접 체크한다. 시작    : 상세화면이 리스트화면 밑으로 들어가면서.. 로그인여부 체크를 위해 직접화면에서 체크한다.-->							
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
<!-- 로그인 여부를 직접 체크한다. 끝-->								
							
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
												<b>배당금상계지급</b></td>
											<td align="right">

<!-- 2006.12.27 유섭교  0602294 사이버 고객센터 화면 수정 -->
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
<%
													String bcashvl = "";//경과해약환급금
													String refnprm = "";//미경과보험료
													String val_pua = "";//추가완납현가
													String acu_div = "";//총배당예치금	
													String acc_div = "";//예치금이자
													String pdffund = "";//PDF
													String acrdpdf = "";//PDF이자
													String tot_amt = "";//지급액
													String pl_prin = "";//기대출원금
													String pl_int  = "";//대출이자
													String apl_amt = "";//apl대출액
													String ard_apl = "";//apl대출이자
													String red_amt = "";//차감액
													String act_amt = "";//실지급액
													
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
															
													banknm1 = payment.getText("bank_name").trim();
													bankcd1 = payment.getText("bank_cd").trim();
													//2006.10.04 : 김보영 : 한국씨티은행(27, 53->27), 우리은행(83, 20->20), 신한은행(21, 26->88), 농협(11~17)
													if(bankcd1.equals("53")){
														bankcd1 = "27";
														banknm1 = "한국씨티은행";
													}else if(bankcd1.equals("83")){
														bankcd1 = "20";
														banknm1 = "우리은행";
													}else if(bankcd1.equals("21")||bankcd1.equals("26")){
														bankcd1 = "88";
														banknm1 = "신한은행";
													}else if(bankcd1.equals("11")||bankcd1.equals("12")||bankcd1.equals("13")||bankcd1.equals("14")||bankcd1.equals("15")||bankcd1.equals("16")||bankcd1.equals("17")){
														banknm1 = "농협";
													}
													/*else if(bankcd1.equals("04")){
														bankcd1 = "04";
														banknm1 = "하하하은행";
													}*/
													
													
%>												
													<tr class="adm15"> 
														<th>경과해약환급금</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(bcashvl)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>미경과보험료</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(refnprm)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>추가완납현가</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(val_pua)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>총배당예치금</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acu_div)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>예치금이자</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acc_div)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>PDF</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pdffund)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>PDF이자</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acrdpdf)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>지급액</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(tot_amt)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>기대출원금</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_prin)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>대출이자</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_int)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>APL대출액</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(apl_amt)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>APL대출이자</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(ard_apl)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>차감액</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(red_amt)%>"></td>
													</tr>
													<tr class="adm15"> 
														<th>실지급액</th>
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
												                                        <td><a href="dividend_setoff_search.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">배당금조회</a></td>
												                                        <td><a href="dividend_setoff_info.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">계약기본사항</a></td>
												                                        <th>|</th>
												                                        <td class="select">배당금발생내역</td>
												                                      </tr>
												                                    </table> </td>
																	<td class="subright"></td>
																</tr>
															</table></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%> 
																<tr class="adm11"> 
																	<th>증권번호</th>
																	<td><%=payment.getText("policy_no").trim()%></td>
																	<th>계약자</th>
																	<td><%=payment.getText("payor_nm").trim()%></td>
																</tr>
															</table></td>
													</tr>
													<tr> 
														<td>&nbsp;</td>
													</tr>
													<tr> 
														<td><img src="/img/common/bu_cir02.gif"> 
															<b>배당금내역</b></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<tr class="adm13"> 
																	<th>배당종류</th>
																	<th>배당방법</th>
																	<th>배당일</th>
																	<th>배당발생년</th>
																	<th>총발생배당액</th>
																	<th>금년도발생액</th>
																	<th>총발생이자</th>
																	<th>예치총액</th>
																	<th>예치이자</th>
																	<th>실효후지급이자</th>
																</tr>
<%
																int cnt = dividendofflist.getCount("divdopt");
																if(cnt == 0)
																{
%>
																<tr align="center"> 
																	<td colspan="10">해당하는 자료가 없습니다.</td>
																</tr>

<%	
																}
																else 
																{
																	for(int i=0;i<cnt;i++)
																	{
																		String div_type = "";
																		if(i == 0)
																		{
																			div_type = "";				
																		}
																		else if(i == 1)
																		{
																			div_type = "사차";
																		}
																		else if(i == 2)
																		{
																			div_type = "이차";
																		}
																		else if(i ==3) 
																		{
																			div_type = "장기";
																		}
																		else if(i == 4)
																		{
																			div_type = "확정";
																		}
																		else if(i ==5)
																		{
																			div_type="전환차액";
																		}
																		else if(i == 6)
																		{
																			div_type = "비차";
																		}
%>																
																<tr class="adm13"> 
																
																	<td class="ce"><%=div_type%></td>
<%
																	String divdopt = "";
																	divdopt = dividendofflist.getText("divdopt",i).trim();
																	if(divdopt.equals("1"))
																	{
																		divdopt = "현금지급식";
																	}
																	else if(divdopt.equals("2")) 
																	{
																		divdopt = "보험료 상계식";
																	}
																	else if(divdopt.equals("4"))	
																	{
																		divdopt = "적립식";
																	}	
%>																	
																	<td class="ce"><%=divdopt%></td>														
<%
																	String divdate = "";
																	divdate = dividendofflist.getText("divdate",i).trim();
																	if(divdate.length() > 7)
																	{
																		divdate = divdate.substring(0,4) +"."+divdate.substring(4,6) +"." + divdate.substring(6,8);
																	}
%>																	
																	<td class="ce"><%=divdate%></td>
																	<td class="ce"><%=dividendofflist.getText("ldivyy",i).trim()%></td>
																	<td><%=Util.addComma(dividendofflist.getText("totdivd",i).trim())%></td>
																	<td><%=Util.addComma(dividendofflist.getText("divthis",i).trim())%></td>
																	<td><%=Util.addComma(dividendofflist.getText("tdivint",i).trim())%></td>
																	<td><%=Util.addComma(dividendofflist.getText("curint",i).trim())%></td>
																	<td><%=Util.addComma(dividendofflist.getText("aftint",i).trim())%></td>
																	<td><%=Util.addComma(dividendofflist.getText("balsum",i).trim())%></td>
																</tr>
<%
																	totdivd = totdivd + Integer.parseInt(dividendofflist.getText("totdivd",i).trim());//총발생배당액
																	divthis = divthis + Integer.parseInt(dividendofflist.getText("divthis",i).trim());//금년도발생액
																	tdivint = tdivint + Integer.parseInt(dividendofflist.getText("tdivint",i).trim());//총발생이자
																	curint = curint + Integer.parseInt(dividendofflist.getText("curint",i).trim());//예치총액
																	aftint = aftint + Integer.parseInt(dividendofflist.getText("aftint",i).trim());//예치이자
																	balsum = balsum + Integer.parseInt(dividendofflist.getText("balsum",i).trim());//실효우지급이자
																	
																	}
																}
																
																if(cnt >0)
																{
%>																
																<tr class="adm13"> 
																	<th colspan="4" class="ce">합계</th>
																	<td><%=Util.addComma(Integer.toString(totdivd))%></td>
																	<td><%=Util.addComma(Integer.toString(divthis))%></td>
																	<td><%=Util.addComma(Integer.toString(tdivint))%></td>
																	<td><%=Util.addComma(Integer.toString(curint))%></td>
																	<td><%=Util.addComma(Integer.toString(aftint))%></td>
																	<td><%=Util.addComma(Integer.toString(balsum))%></td>
																</tr>
<%
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
										                            <td><img src="/img/common/bu_cir02.gif"> <b>배당금상계 
										                              접수내역</b></td>
													</tr>
<%
														int tot_divid = 0;//배당총액
														int rent_amt = 0;//기대출원리금														
														
														tot_divid = Integer.parseInt(plcynoinfo.getText("acu_div").trim()) + Integer.parseInt(plcynoinfo.getText("acc_div").trim());//배당총액(A)
														rent_amt = Integer.parseInt(plcynoinfo.getText("pl_prin").trim()) + Integer.parseInt(plcynoinfo.getText("pl_int").trim()) + Integer.parseInt(plcynoinfo.getText("apl_amt").trim()) + Integer.parseInt(plcynoinfo.getText("ard_apl").trim());
%>																		
													<tr> 
														<td><table width="100%" class="adm_table">
										                                <col width=20%>
										                                <col width=30%>
										                                <col width=20%>
										                                <col width=30%>
										                                <tr class="adm21"> 
										                                  <th>신청일자</th>
										                                  <td><%=payment.getText("apln_dt").trim()%></td>
										                                  <th>배당총액</th>
										                                  <td><div align="right"><%=Util.addComma(Integer.toString(tot_divid ))%></div></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>약관대출원금</th>
										                                  <td><div align="right"><%=Util.addComma(pl_prin)%></div></td>
										                                  <th>APL원금</th>
										                                  <td><div align="right"><%=Util.addComma(apl_amt)%></div></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>약관대출이자</th>
										                                  <td><div align="right"><%=Util.addComma(pl_int)%></div></td>
										                                  <th>APL이자</th>
										                                  <td><div align="right"><%=Util.addComma(ard_apl)%></div></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>처리전원리금</th>
										                                  <td><div align="right"><%=Util.addComma(Integer.toString(rent_amt))%></div></td>
										                                  <th>처리후원리금</th>
										                                  <td><div align="right"><%=Util.addComma(payment.getText("apln_amt"))%></div></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>상태</th>
<%
															String rsltname = "";
															rsltname = payment.getText("rslt").trim();
															if(rsltname.equals("0"))
															{
																rsltname = "성공";
															}
															else if(rsltname.equals("1"))
															{
																rsltname = "반송";
															}
															else if(rsltname.equals("2"))
															{
																rsltname = "실패";
															}
															else if(rsltname.equals("3"))
															{
																rsltname = "지연";
															}
															else if(rsltname.equals("A"))
															{
																rsltname = "처리중";
															}
															else 
															{
																rsltname = "접수";
															}
%>										                                  
										                                  <td colspan="3"><input type="text" name="rsltname"  value="<%=rsltname%>" size="14" maxlength="10"  style="background-color:white; border-width:0; border-color:black; border-style:solid;" readonly >
															</td>
										                                </tr>
										                              </table></td>
													</tr>
													<tr> 
														<td align="right">
<%
														//2005-10-10. 05-C-138. 이위혁. 결재권한 세분화
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
%>																				
														<a href="javascript:getResult('R','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>','<%=payment.getText("sending_num")%>')" onFocus="blur()"><img src="/img/common/btn_sbun.gif" border="0"></a>
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
															//2005-10-10. 05-C-138. 이위혁. 결재권한 세분화
															//if((payment.getText("auth_cd").trim().equals("30") && payment.getText("rslt").trim().equals("A")))
															if((payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33")) && payment.getText("rslt").trim().equals("A"))
															{
%>														
														<img src="/img/common/btn_recognize.gif"  style="cursor: hand;" id="btn1" onClick="goProcess('S','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')"></td>
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
														<img src="/img/common/btn_money.gif"  style="cursor: hand;" id="btn2" onClick="javascript:goRecogn('<%=payment.getText("policy_apln_no")%>','D1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')"></td>
<%														
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
																
																//WB_PAYMENT에서 err_msg를 가져옴
																if(errmsg1.length() == 0)
																{
																	errmsg1 = payment.getText("err_msg");
																}																																																																
%>																	
																	<td><input name="errmsg" type="text" class="box10" value="<%=errmsg1%>"></td>																</tr>
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

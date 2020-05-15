<%@ page import = "gtone.changeminer.common.constant.*, gtone.changeminer.common.manager.SessionManager, java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<!--20060605김보영추가-->
<jsp:useBean id="checkopt" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="workinginfo" 	class="anyframe.data.DataSet" scope="request"/>
<!---->
<jsp:useBean id="dividendpaidup" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plcynoinfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>	
<jsp:useBean id="payment" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="policy" class="java.lang.String" scope="request"/>
<jsp:useBean id="policy_apln_no" class="java.lang.String" scope="request"/>
<jsp:useBean id="ssn" class="java.lang.String" scope="request"/>

<jsp:useBean id="sbkcda" class="java.lang.String" scope="request"/>
<jsp:useBean id="sbknoa" class="java.lang.String" scope="request"/>
<jsp:useBean id="pyrna" class="java.lang.String" scope="request"/>
<jsp:useBean id="bankconf" 	class="anyframe.data.DataSet" scope="request"/>

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
<%		
	String bnkyn		= request.getParameter("bnkyn")	== null ? "": request.getParameter("bnkyn");	
%>

<html>
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

	function bankconfc(cd1, cd2, cd3)
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
		form.sbkcda.value = cd1;
		form.sbknoa.value = cd2;
		form.pyrna.value = cd3;		
		form.submit();
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
	
	function goProcess(cd1, cd2, cd3, cd4, cd5, cd6, cd7)
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
		form.bk_clt.value = cd5;//예금주주번
		form.bk_cod.value = cd6;//은행코드
		form.bk_acct.value =  cd7;//계좌번호
		
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
		//else
		//{
		//	alert("처리전 조회를 하시고 결재를 신청하세요.");
		//	return;														
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
		
		var bankon = '<%=payment.getText("bank_conf_yn")%>';
		
		
		//20060601 김보영 0601081 유예/실효(감/완)체크추가
		//20060601 김보영 0601081 workingday의 유예/실효(감/완)체크추가
		
		var selopt  	= '<%=checkopt.getText("selopt")%>';	//실효옵션 - 실효선택이 0:연장정기, 2:감액완납
		var advcnt 	= '<%=checkopt.getText("advcnt")%>';	//2:유예건
		var aplclose	= '<%=workinginfo.getText("aplclose")%>';   //Y:유예건 APL 불가일
		var delayclose	= '<%=workinginfo.getText("delay_pay_close")%>';  //Y:유예건(감/연) 제지급수령불가일
		
		//test
		//selopt='0';		
		//advcnt='2';		
		//aplclose='Y';
		//delayclose='Y';
		//alert("실효옵션0,2 : "+selopt+" / 유예건2 : "+advcnt+" / 유예건불가일 : "+aplclose+" / 유예건(감/연)불가일 : "+delayclose);
		
		//유예건 APL 불가일인 경우, 모든 유예건은 처리불가
		if(aplclose == 'Y'){
			if(advcnt == '2'){
				alert("접수된 건은 유예건입니다.\n당일은 유예건 APL 불가일이므로 대상 건은 처리될 수 없습니다.");
				return;
			}
		}
		
		//유예건(감/연) 제지급수령불가일인 경우, 유예건이면서 실효선택이 감액완납과 연장정기인 건이면 처리 불가
		if(delayclose == 'Y'){		
			if(selopt == '0' || selopt == '2'){
				if(advcnt == '2'){
					alert("접수된 건은 감액완납/연장정기인 유예건입니다.\n당일은 유예건(감액완납/연장정기) 제지급수령 불가일이므로 대상 건은 처리될 수 없습니다.");
					return;
				}	
			}
		}		
		
		
		
		if(bankon == 'N')
		{
			alert("예금주 확인을 하지 않았습니다. 예금주 확인을 하시고 결재요청을 하세요");
			return;
		}
		else
		{
			//if(form.process.value == "L")
			//{			
				if (confirm('결재 요청을 하시겠습니까?')) 
				{		
					form.process.value = "R";
					form.opt1.value = cd1;//선택코드 L1
					form.policy.value = cd2;//증권번호
					form.indate.value = cd3;
					form.cash.value = cd4;//금액
					form.bnkclt.value = cd5;//예금주주번
					form.bnkcode.value = cd6;//은행코드
					form.bnkacct.value =  cd7;//계좌번호
					
					form.action = "dividend_paidup.do";
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
		form.indate.value = cd3;
		form.cash.value = cd4;//금액
		form.bnkclt.value = cd5;//예금주주번
		form.bnkcode.value = cd6;//은행코드
		form.bnkacct.value =  cd7;//계좌번호
		form.sndseq.value = cd8;//전송번호
				
					
		if (confirm('지연건입니다.\n\n결과조회및 분개를 하시겠습니까?')) 
		{		
			form.process.value = "K";
			form.action = "dividend_paidup.do";
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
<input type="hidden" name="policy_apln_no" value="<%=policy_apln_no%>">
<input type="hidden" name="ssn" value="<%=ssn%>">

<input type="hidden" name="sbkcda" value="<%=sbkcda%>">
<input type="hidden" name="sbknoa" value="<%=sbknoa%>">
<input type="hidden" name="pyrna"  value="<%=pyrna%>">

<input type="hidden" name="opt1"  value="<%=opt1%>">
<input type="hidden" name="rcvdate"  value="<%=rcvdate%>">
<input type="hidden" name="date"  value="<%=date%>">
<input type="hidden" name="bk_clt"  value="<%=bk_clt%>">
<input type="hidden" name="bk_cod"  value="<%=bk_cod%>">
<input type="hidden" name="bk_acct"  value="<%=bk_acct%>">
<input type="hidden" name="process"  value="<%=process%>">
<input type="hidden" name="indate"  value="<%=indate%>">
<input type="hidden" name="sndseq"  value="<%=sndseq%>">
<input type="hidden" name="returnurl"  value="/payment/dividend_paidup.do">
<input type="hidden" name="procgb"  value="D1">
<input type="hidden" name="bnkyn"  value="<%=bnkyn%>">
<input type="hidden" name="bnkclt" >
<input type="hidden" name="bnkcode" >
<input type="hidden" name="bnkacct" >
<input type="hidden" name="cash" >

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
								<td class="contents">
								
								
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
								                      <td><img src="/img/common/bu_cir01.gif"> <b>배당금지급</b> 
								                      </td>
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
														String banknm2 = "";
														String bankcd2 = "";
														int tot_divid = 0;//배당총액
														
														tot_divid = Integer.parseInt(plcynoinfo.getText("acu_div").trim()) + Integer.parseInt(plcynoinfo.getText("acc_div").trim());//배당총액(A)	
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
												                                        <td><a href="dividend_search.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">배당금조회</a></td>
												                                        <td><a href="dividend_info.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">계약기본사항</a></td>												                                        
												                                        <td><a href="dividend_info.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">배당금발생내역</a></td>
												                                        <th>|</th>
												                                        <td class="select">제지급금내역</td>
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
																<tr class="adm11"> 
																	<th>연락처</th>
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
														<td>&nbsp;</td>
													</tr>
													<tr> 
														<td><img src="/img/common/bu_cir02.gif"> 
															<b>제지급금내역</b></td>
													</tr>
													<tr> 
														
                           
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<tr class="adm11"> 
																	<th>송금일</th>
																	<th>접수일</th>
																	<th>처리일</th>
																	<th>지급종류</th>
																	<th>실지급금</th>
																	<th>은행</th>
																	<th>계좌번호</th>
																	<th>예금주</th>
																	<th>처리자</th>
																</tr>
<%
																	int cnt  = dividendpaidup.getCount("cardcd");
																	
																	if(cnt == 0)
																	{
%>																
																<tr align="center"> 
																	<td colspan="9">해당하는 자료가 없습니다.</td>
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
																			String snddate = dividendpaidup.getText("snddate").trim();
																			if(snddate.length() > 7)
																			{
																				snddate = snddate.substring(0,4) +"."+ snddate.substring(4,6) +"." + snddate.substring(6,8);
																			}
%>																
																	<td class="ce"><%=snddate%></td>
<%
																			String regdate = dividendpaidup.getText("regdate").trim();
																			if(regdate.length() > 7)
																			{
																				regdate = regdate.substring(0,4) +"."+ regdate.substring(4,6) +"." + regdate.substring(6,8);
																			}
%>																	
																	<td class="ce"><%=regdate%></td>
<%
																			String pcsdate = dividendpaidup.getText("pcsdate").trim();
																			if(pcsdate.length() > 7)
																			{
																				pcsdate = pcsdate.substring(0,4) +"."+ pcsdate.substring(4,6) +"." + pcsdate.substring(6,8);
																			}
%>																	
																	
																	<td class="ce"><%=pcsdate%></td>
																	<td class="ce"><%=dividendpaidup.getText("cardna",i).trim()%></td>
																	<td><%=Util.addComma(trans.removeZero(dividendpaidup.getText("payamt",i).trim()))%></td>
																	<%	banknm2 = dividendpaidup.getText("bankna").trim();
																		bankcd2 = dividendpaidup.getText("bankcd").trim();
																	//2006.10.04 : 김보영 : 한국씨티은행(27, 53->27), 우리은행(83, 20->20), 신한은행(21, 26->88), 농협(11~17)
																	if(bankcd2.equals("53")){
																		bankcd2 = "27";
																		banknm2 = "한국씨티은행";
																	}else if(bankcd2.equals("83")){
																		bankcd2 = "20";
																		banknm2 = "우리은행";
																	}else if(bankcd2.equals("21")||bankcd2.equals("26")){
																		bankcd2 = "88";
																		banknm2 = "신한은행";
																	}else if(bankcd1.equals("11")||bankcd1.equals("12")||bankcd1.equals("13")||bankcd1.equals("14")||bankcd1.equals("15")||bankcd1.equals("16")||bankcd1.equals("17")){
																		banknm1 = "농협";
																	}
																	/*else if(bankcd2.equals("04")){
																		bankcd2 = "04";
																		banknm2 = "하하하은행";
																	}*/
																	%>					
																	<td class="ce"><%=banknm2%></td>
																	<td class="ce"><%=dividendpaidup.getText("bnkacc",i).trim()%></td>
																	<td class="ce"><%=dividendpaidup.getText("payna",i).trim()%></td>
																	<td class="ce"><%=dividendpaidup.getText("prcinit",i).trim()%></td>
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
                            										<td><img src="/img/common/bu_cir02.gif"> <b>배당금신청접수내역</b></td>
													</tr>
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
										                                  <td><div align="right"><%=Util.addComma(Integer.toString(tot_divid))%></div></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>실지급액</th>
										                                  <td><div align="right"><%=Util.addComma(payment.getText("apln_amt"))%></div></td>
										                                  <th>예금주</th>
										                                  <td><%=payment.getText("acct_nm").trim()%></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>은행</th>
																	<%	banknm1 = payment.getText("bank_name").trim();
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
																	<td><%=banknm1%></td>
										                                  <th>계좌번호 </th>
										                                  <td><%=payment.getText("acct_no").trim()%></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>연락처</th>
										                                  <td><%=payor_phone%></td>
										                                  <th>E-Mail</th>
										                                  <td><%=payment.getText("payor_email").trim()%></td>
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
										                                  <td><input type="text" name="rsltname"  value="<%=rsltname%>" size="14" maxlength="10"  style="background-color:white; border-width:0; border-color:black; border-style:solid;" readonly >
															</td>
												                                    <th><a href="javascript:bankconfc('<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>','<%=payment.getText("payor_ssn").trim()%>');" onFocus="blur()"><u>예금주확인</u></a></th>
<%
																	String bankconfc = "N";	
																	String wbbank = "";
																	wbbank = payment.getText("bank_conf_yn");
																	if(bnkyn.equals("0") || wbbank.equals("Y"))
																	{
																		bankconfc = "확인";																		
																	}
																	else
																	{
																		bankconfc = "미확인";
																	}	
%>
									                                    <td><%=bankconfc%></td>
									                                  </tr>
									                                </table></td>
													</tr>
													<tr> 
														<td align="right">
<%			
														//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
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
															if((payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31")  || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33")) && payment.getText("rslt").trim().equals("A"))
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
																else
																{
																	errmsg1 = bankconf.getText("errmsg").trim();
																}
																
																//WB_PAYMENT에서 err_msg를 가져옴
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

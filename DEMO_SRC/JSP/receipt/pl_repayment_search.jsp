<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="plrepaymentsearch" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="payment" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="issdatesearch" 	class="anyframe.data.DataSet" scope="request"/>

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
<jsp:useBean id="returnurl" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="approval" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>

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
 	//실수형 자릿수 설정
 	DecimalFormat df = new DecimalFormat("###.##");
 	String 	bnkyn		= request.getParameter("bnkyn")	== null ? "": request.getParameter("bnkyn");
	String 	bankconfc = "";
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
	function bankconfc(cd1, cd2, cd3)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		form = document.paymentForm;
		form.sbkcda.value = cd1;
		form.sbknoa.value = cd2;
		form.pyrna.value = cd3;
		if (confirm('예금주 확인을 하시겠습니까?')) 
		{		
			form.submit();
		}
		else
		{
			return;
		}	
	}
	
	
	function returnFalseMsg(cd){
		if ("<%=deathResult%>" == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
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
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
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
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
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
		
		var bankon = '<%=payment.getText("bank_conf_yn")%>';
		if(bankon == 'N')
		{
			alert("예금주 확인을 하지 않았습니다. 예금주 확인을 하시고 승인을 하세요");
			return;
		} 
		
		
		//if(form.process.value == "L")   //2007.05.25 처리전조회 유무 삭제...
		//{				
			if (confirm('승인 처리를 하시겠습니까?')) 
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
		//	alert("처리전 조회를 하고 승인을 하세요.");
		//	return;	
		//}
		
		
	}



	function goResult(cd1, cd2, cd3, cd4, cd5, cd6, cd7)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
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
		
						
		if (confirm('결과조회를 하시겠습니까?')) 
		{		
			form.process.value = "R";
			form.submit();
		}
		else
		{
			return;
		}			
	}
	
	
	function goTimeout(cd)	
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
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}

		var path = "";
		path = "/receipt/return_tbl.do?policy_apln_no="+cd;
		
		window.open(path, '반송', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');	
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
<input type="hidden" name="returnurl"  value="pl_repayment_search.do">
<input type="hidden" name="bnkyn"  value="<%=bnkyn%>">

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
						<jsp:param name="menu_mode" value="2"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
					<!--/td>
					<td class="contents"-->
					
					
	<!-- 로그인 여부를 직접 체크한다. 시작    : 상세화면이 리스트화면 밑으로 들어가면서.. 로그인여부 체크를 위해 직접화면에서 체크한다.-->							
<%

	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	
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
<!-- 로그인 여부를 직접 체크한다. 끝-->								
							
							<table width="100%" id="otable">
							<tr> 
								<td><img src="/img/common/title_02.gif"></td>
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
								                      <td><img src="/img/common/bu_cir01.gif"> <b>약관대출상환</b> 
								                      </td>
											<td align="right">
<!-- 2006.12.27 유섭교  0602294 사이버 고객센터 화면 수정 -->
<!--a href="/receipt/policy_view.do?modeind=1&srvc_ind=1&searchgubun=S" onFocus="blur()"-->
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
											
											bcashvl = plrepaymentsearch.getText("bcashvl",0).trim();
											refnprm = plrepaymentsearch.getText("refnprm",0).trim();
											val_pua = plrepaymentsearch.getText("val_pua",0).trim();
											acu_div = plrepaymentsearch.getText("acu_div",0).trim();
											acc_div = plrepaymentsearch.getText("acc_div",0).trim();
											pdffund = plrepaymentsearch.getText("pdffund",0).trim();
											acrdpdf = plrepaymentsearch.getText("acrdpdf",0).trim();
											tot_amt = plrepaymentsearch.getText("tot_amt",0).trim();
											pl_prin = plrepaymentsearch.getText("pl_prin",0).trim();
											pl_int = plrepaymentsearch.getText("pl_int",0).trim();
											apl_amt = plrepaymentsearch.getText("apl_amt",0).trim();
											ard_apl = plrepaymentsearch.getText("ard_apl",0).trim();
											red_amt = plrepaymentsearch.getText("red_amt",0).trim();
											act_amt = plrepaymentsearch.getText("act_amt",0).trim();
													String banknm1 = "";
													String bankcd1 = "";
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
												                                        <td class="select">약대조회</td>
												                                        <td><a href="pl_repayment_info.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">계약기본사항</a></td>
												                                        <th>|</th>
												                                        <td><a href="pl_repayment_list.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">약관대출내역</a></td>
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
															<b>약관대출금 조회</b></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%> 
<%
																int basloan = 0;//총대출기준액
																int lstloan   = 0;//순대출한도액
																int loanamt = 0;//기대출원리금
																int refprem = 0;//미납보험료
																int loanval  = 0;//현대출가능액
																String factor    = "";//현대출가능액
																String percent = "";
																int cnt = plrepaymentsearch.getCount("rid_nam");//보종명
																for(int i=0;i<cnt;i++)
																{
																	basloan = basloan + Integer.parseInt(plrepaymentsearch.getText("basloan",i).trim());
																	lstloan   = lstloan   + Integer.parseInt(plrepaymentsearch.getText("lstloan",i).trim());
																	loanamt   = loanamt  + Integer.parseInt(plrepaymentsearch.getText("loanamt",i).trim());
																	refprem   = refprem  + Integer.parseInt(plrepaymentsearch.getText("refprem",i).trim());
																	loanval   = loanval  + Integer.parseInt(plrepaymentsearch.getText("loanval",i).trim());		
																}
																factor = plrepaymentsearch.getText("factor",0).trim();
																factor = df.format(Float.parseFloat(factor)); 
																if(factor.length() > 0)
																{
																	percent = "%";
																}	
%>
																
																<tr class="adm12"> 
																	<th>총대출기준액</th>
																	<td><%=Util.addComma(Integer.toString(basloan))%></td>
																	<th>순대출한도액</th>
																	<td><%=Util.addComma(Integer.toString(lstloan))%></td>
																</tr>
																<tr class="adm12"> 
																	<th>기대출원리금</th>
																	<td><font color="#543CFB"><b><%=Util.addComma(Integer.toString(loanamt))%></b></font></td>
																	<th>미납보험료</th>
																	<td><%=Util.addComma(Integer.toString(refprem))%></td>
																</tr>
																<tr class="adm12"> 
																	<th>현대출가능액</th>
																	<td><%=Util.addComma(Integer.toString(loanval))%></td>
																	<th>대출이율</th>
																	<td><%=factor%>&nbsp;<%=percent%></td>
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
<%
													String issdte = "";
													issdte = issdatesearch.getText("issdte");
													if(issdte.length() == 8)
													{
														issdte = issdte.substring(0,4)+"."+issdte.substring(4,6)+"."+issdte.substring(6);
													}	
%>                            										
                            										<b>약대상환접수내역(계약일:<%=issdte%>)</b></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%> 
																<tr class="adm21"> 																	
                                  													<th>신청일자</th>
																	<td><%=payment.getText("apln_dt").trim()%></td>
																	<th>은행</th>
																	<%
																		banknm1 = payment.getText("bank_name").trim();
																		bankcd1 = payment.getText("bank_cd").trim();//2006.10.04 : 김보영 : 한국씨티은행(27, 53->27), 우리은행(83, 20->20), 신한은행(21, 26->88)
																	if(bankcd1.equals("53")){
																		bankcd1 = "27";
																		banknm1 = "한국씨티은행";
																	}else if(bankcd1.equals("83")){
																		bankcd1 = "20";
																		banknm1 = "우리은행";
																	}else if(bankcd1.equals("21")||bankcd1.equals("26")){
																		bankcd1 = "88";
																		banknm1 = "신한은행";
																	}
																	/*else if(bankcd1.equals("04")){
																		bankcd1 = "04";
																		banknm1 = "하하하은행";
																	}*/
																	%>																	
																	<td><%=banknm1%></td>
																</tr>
																<tr class="adm21"> 																	
                                  													<th>신청구분</th>
																	<td><%=payment.getText("pay_cd").trim()%></td>
																	<th>예금주</th>
																	<td><%=payment.getText("acct_nm").trim()%></td>
																</tr>
																<tr class="adm21"> 																	
                                  													<th>신청금액</th>
																	<td><div align="right"><font color="#543CFB"><b><%=Util.addComma(payment.getText("apln_amt").trim())%></b></font></div></td>
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
                                  													<td><input type="text" name="rsltname"  value="<%=rsltname%>" size="14" maxlength="10"  style="background-color:white; border-width:0; border-color:black; border-style:solid;" readonly ></td>
																	<th><a href="javascript:bankconfc('<%=bankcd1%>','<%=payment.getText("acct_no")%>','<%=payment.getText("payor_ssn")%>');" onFocus="blur()"><u>예금주확인</u></a></th>																	
<%												                                   
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
//2005-10-17 안정화 이관 --; syntax 오류 있었음. -> 여미경
//if(payment.getText("auth_cd").equals("20") || payment.getText("auth_cd").equals("30"))


	if(payment.getText("auth_cd").equals("20") || payment.getText("auth_cd").equals("30") || 
		payment.getText("auth_cd").equals("31") || payment.getText("auth_cd").equals("32") || 
		payment.getText("auth_cd").equals("33")) {
		if(payment.getText("rslt").equals("3")) {
		
%>														
														<img src="/img/common/btn_inq.gif"  style="cursor: hand;" id="btn1" onClick="goResult('P3','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
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
														<img src="/img/common/btn_recognize.gif"  style="cursor: hand;" id="btn1" onClick="goProcess('P3','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')"></td>
<%
															}
															else 														
															{
%>
														&nbsp;</td>		
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

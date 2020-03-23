<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="premiumlist" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plcynoinfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="trans" class="anyframe.util.StringFormater" scope="request"/>
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
<html>

<%
	String	deptcd 	 = request.getParameter("deptcd")	== null ? "INT" : request.getParameter("deptcd");	
	String	init	 	 = request.getParameter("init")	== null ? "     " : request.getParameter("init");		
	String      start   	 = request.getParameter("start")	== null ? "        " : request.getParameter("start");		
	String      end   	 = request.getParameter("end")	== null ? "        " : request.getParameter("end");		
	String      option   	 = request.getParameter("option")	== null ? "C" : request.getParameter("option");	
	String      language   	 = request.getParameter("language")	== null ? "K" : request.getParameter("language");	

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<!--
	function bankconfc(cd1, cd2, cd3)
	{
		form = document.paymentForm;
		form.sbkcda.value = cd1;
		form.sbknoa.value = cd2;
		form.pyrna.value = cd3;
		form.action = "premium_paid_list.do";
		form.submit();
	}
	
	function goProcess(cd1, cd2, cd3, cd4, cd5, cd6, cd7)
	{
		form = document.paymentForm;
		form.opt1.value = cd1;//�����ڵ� L1
		form.policy.value = cd2;//���ǹ�ȣ
		form.regdate.value = cd3;//��������
		form.cash.value = cd4;//�ݾ�
		form.bnkclt.value = cd5;//�������ֹ�
		form.bnkcode.value = cd6;//�����ڵ�
		form.bnkacct.value =  cd7;//���¹�ȣ
		form.process.value = "Y";
		form.action = "premium_paid_list.do";
		form.submit();
	}
	
	function getLoan()
	{
		form = document.paymentForm;
		form.submit();
	}		
-->
</script>
<body>
<form name="paymentForm"  method="post">
<input type="hidden" name="policy" value="<%=policy%>">
<input type="hidden" name="deptcd" value="<%=deptcd%>">
<input type="hidden" name="init" value="<%=init%>">
<input type="hidden" name="start" value="<%=start%>">
<input type="hidden" name="end" value="<%=end%>">
<input type="hidden" name="option" value="<%=option%>">
<input type="hidden" name="language" value="<%=language%>">
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
						<jsp:param name="menu_mode" value="2"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					</td>
					<td class="contents"><table width="100%">
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
											
                      <td><img src="/img/common/bu_cir01.gif"> <b>�Աݳ���</b> 
                      </td>
											<td align="right"><a href="/receipt/policy_view.do?modeind=1&searchgubun=S"><img src="/img/common/btn_list.gif" hspace="10" border="0"></a></td>
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
									                                        <td><a href="premium_paid_search.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>">�������ȸ</a></td>
									                                        <th>|</th>
									                                        <td><a href="premium_paid_info.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>">���⺻����</a></td>
									                                        <td class="select">�Աݳ���</td>
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
																	<td><%=payment.getText("policy_no").trim()%></td>
																	<th>�����</th>
																	<td><%=payment.getText("payor_nm").trim()%></td>
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
														<td>&nbsp;</td>
													</tr>
													<tr> 														
                            										<td><img src="/img/common/bu_cir02.gif"> <b>�Աݳ���</b></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
										                                <col width=20%>
										                                <col width=>
										                                <tr class="adm11"> 
										                                  <th width="18%">���溸���</th>
										                                  <td width="17%"><div align="right"><%=Util.addComma(premiumlist.getText("hmodprm",0).trim())%>��</div></td>
										                                  <th width="16%">�ڵ���ü�����</th>
										                                  <td width="15%"><div align="right"><%=Util.addComma(premiumlist.getText("hautoprem",0).trim())%>��</div></td>
										                                  <th width="16%">���������</th>
										                                  <td width="18%"><div align="right"><%=Util.addComma(premiumlist.getText("hsuspamt",0).trim())%>��</div></td>
										                                </tr>
										                              </table></td>
													</tr>													
													<tr> 
														<td><table width="100%" class="adm_table" style="margin: 0px;">
									                                <tr class="adm11"> 
									                                  <th width="30">ȸ��</th>
									                                  <th width="8%">����</th>
									                                  <th width="12%">���ⳳ����</th>
									                                  <th width="13%">����/�Ա���</th>
									                                  <th width="7%">�ݿ���</th>
									                                  <th width="8%">�Աݾ�</th>
									                                  <th width="11%">�ҵ����</th>
									                                  <th width="8%">���Ա�</th>
									                                  <th width="8%">������</th>
									                                  <th width="9%">����</th>
									                                  <th width="%">���</th>
									                                </tr></table><div style="overflow: auto; width: 100%; height: 200px;"><table width="100%" class="adm_table"><col width="30"><col width="8%"><col width="12%"><col width="13%"><col width="7%"><col width="8%"><col width="11%"><col width="8%"><col width="8%"><col width="9%"><col width="%">
<%
														int cnt = premiumlist.getCount("paydate");
														if(cnt == 0)
														{
%>
									                                <tr align="center"> 
									                                  <td colspan="11">�ش��ϴ� �ڷᰡ �����ϴ�.</td>
									                                </tr>	
<%	
														}
														else
														{	
															for(int i=0;i<cnt;i++)
															{	
%>									                                
									                                <tr class="adm12"> 
									                                  <td class="ce"><%=trans.removeZero(premiumlist.getText("cnt",i).trim())%></td>
<%
																String caseym = "";
																caseym = premiumlist.getText("caseym",i).trim();			
																if(caseym.length() > 0)
																{
																	caseym = caseym.substring(0,4) +"." + caseym.substring(4,6);
																}
%>									                                  
									                                  <td class="ce"><%=caseym%></td>
<%
																String ptd  = "";
																ptd =  premiumlist.getText("ptd",i).trim();			
																if(ptd.length() > 0)
																{
																	ptd = ptd.substring(0,4) +"."+ ptd.substring(4,6) +"."+ ptd.substring(6,8);
																}
%>									                                  
									                                  <td class="ce"><%=ptd%></td>
<%
																String paydate  = "";
																paydate =  premiumlist.getText("paydate",i).trim();			
																if(paydate.length() > 0)
																{
																	paydate = paydate.substring(0,4) +"."+ paydate.substring(4,6) +"."+ paydate.substring(6,8);
																}
%>									                                  
									                                  
									                                  <td class="ce"><%=paydate%></td>
<%
																String procdate  = "";
																procdate =  premiumlist.getText("procdate",i).trim();			
																if(procdate.length() > 0)
																{
																	procdate = procdate.substring(0,4) +"."+ procdate.substring(4,6) +"."+ procdate.substring(6,8);
																}
%>									                                  
									                                  
									                                  <td class="ce"><%=paydate%></td>
									                                  <td class="ce"><div align="right"><%=Util.addComma(premiumlist.getText("rctamt",i).trim())%></div></td>
									                                  <td class="ce"><div align="right"><%=Util.addComma(premiumlist.getText("taxdeduct",i).trim())%></div></td>
									                                  <td class="ce"><div align="right"><%=Util.addComma(premiumlist.getText("payamt",i).trim())%></div></td>
									                                  <td class="ce"><div align="right"><%=Util.addComma(premiumlist.getText("suspamt",i).trim())%></div></td>
<%
																String modx = premiumlist.getText("modx",i);
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
																}
																else 
																{
																	modx = "";
																}
%>            									                                  
									                                  <td class="ce"><%=modx%></td>		                                  
									                                  <td class="ce"><%=premiumlist.getText("paypath",i).trim()%></td>
									                                </tr>
<%
															}
														}
%>
									                              </table></div></td>
													</tr>
													<tr> 
														<td height="5" background="/img/common/line.gif"></td>
													</tr>
													<tr> 
														<td>&nbsp;</td>
													</tr>
													<tr> 														
                          					 	 					<td><img src="/img/common/bu_cir02.gif"> <b>������Ա���������</b></td>
													</tr>
													<tr> 
														<td><table width="100%" class="adm_table">
										                                <col width=20%>
										                                <col width=30%>
										                                <col width=20%>
										                                <col width=30%>
										                                <tr class="adm21"> 
										                                  <th>���ⳳ����</th>
<%																	
															String hptd = premiumlist.getText("hptd").trim();
															
															if(hptd.length() > 0)
															{
																hptd = hptd.substring(0,4) + "." +hptd.substring(4,6) +"." + hptd.substring(6,8);
															}
%>																					                                  
										                                  <td><%=hptd%></td>
										                                  <th>ȸ��</th>
<%
															String hpdcnt = Integer.toString(Integer.parseInt(premiumlist.getText("hpdcnt").trim()) + 1);
%>											                                  
										                                  <td><%=trans.removeZero(hpdcnt)%></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>����Ƚ��</th>
<%
															String hmodprem 	= premiumlist.getText("hmodprem").trim();
															String apln_amt 	= payment.getText("apln_amt").trim();
															String incount		= "";
															if(hmodprem.equals(apln_amt))
															{
																incount = "1";
															}
															else
															{
																incount = "2";
															}	
%>											                                  
										                                  <td><%=incount%>ȸ</td>
										                                  <th>�����</th>
										                                  <td><div align="right"><%=Util.addComma(premiumlist.getText("hmodprm",0).trim())%>��</div></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>���Աݾ�</th>
										                                  <td><div align="right"><%=Util.addComma(payment.getText("apln_amt").trim())%>��</div></td>
										                                  <th>������</th>
										                                  <td><%=payment.getText("acct_nm").trim()%></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>����</th>
										                                  <td><%=payment.getText("bank_name").trim()%></td>
										                                  <th>���¹�ȣ</th>
										                                  <td><%=payment.getText("acct_no").trim()%></td>
										                                </tr>
										                                <tr class="adm21"> 
										                                  <th>����ó</th>
										                                  <td><%=payor_phone%></td>
										                                  <th>E-Mail</th>
										                                  <td><%=payment.getText("payor_email").trim()%></td>
										                                </tr>
										                                <tr class="adm21"> 
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
%>												                                  <td><%=rsltname%></td>
										                                  <th><a href="javascript:bankconfc('<%=payment.getText("bank_cd")%>','<%=payment.getText("acct_no")%>','<%=payment.getText("payor_ssn")%>');"><u>������Ȯ��</u></a></th>
<%																	
																	String bankconfc = "N";	
																	if(sbkcda.length() > 0 && sbknoa.length() > 0 && pyrna.length() > 0)
																	{
																		String confyn = "";
																		confyn = bankconf.getText("rtn");																		
																		if(confyn.equals("0"))
																		{
																			bankconfc = "Y";
																		}				
																		else
																		{
																			bankconfc = "N";																			
																		}														
																	}	
%>																	
																	<td><%=bankconfc%></td>										                                </tr>
										                              </table></td>
													</tr>
													<tr> 
														<td align="right"><a href="javascript:getLoan()"><img src="/img/common/btn_inquirys.gif" border="0"></a><a href="#"><img src="/img/common/btn_return.gif" hspace="10"></a>
<%
														//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
														//if(payment.getText("auth_cd").trim().equals("30"))
														if(payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33"))
														{
%>														
														<a href="javascript:goProcess('P2','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=payment.getText("bank_cd")%>','<%=payment.getText("acct_no").trim()%>')"><img src="/img/common/btn_money.gif"></a></td>
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
																	<td><input name="errmsg" type="text" class="box10" value="<%=errmsg1%>"></td>																	</tr>
															</table></td>
													</tr>
												</table></td>
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
</form>
</body>
</html>

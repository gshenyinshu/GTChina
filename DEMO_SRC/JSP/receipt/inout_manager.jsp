<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean    id="form"      			class="gtone.changeminer.receipt.form.LoginManForm" scope="request"/>    
<jsp:useBean 	id="inoutinfo" 			class="anyframe.data.DataSet" scope="request"/>

<html>
<head>
<META HTTP-EQUIV= 'Content-Type' CONTENT='text/html; charset=euc-kr'>
<%
	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	String emp_no 	= sessionManager.getString(Constant.SESSION_USERID);
	
	String pl_sts 		= inoutinfo.getText("pl_sts");
	String div_sts 		= inoutinfo.getText("div_sts");
	String rest_sts 	= inoutinfo.getText("rest_sts");
	//String divoff_sts	= inoutinfo.getText("divoff_sts");
	String prem_sts 	= inoutinfo.getText("prem_sts");
	String addprem_sts 	= inoutinfo.getText("addprem_sts");
	String plrepay_sts 	= inoutinfo.getText("plrepay_sts");
	String apl_sts 		= inoutinfo.getText("apl_sts");
	
	String pl_close_msg 		= inoutinfo.getText("pl_close_msg");
	String div_close_msg 		= inoutinfo.getText("div_close_msg");
	String rest_close_msg 		= inoutinfo.getText("rest_close_msg");
	//String divoff_close_msg 	= inoutinfo.getText("divoff_close_msg");
	String prem_close_msg 		= inoutinfo.getText("prem_close_msg");
	String addprem_close_msg 	= inoutinfo.getText("addprem_close_msg");
	String plrepay_close_msg 	= inoutinfo.getText("plrepay_close_msg");
	String apl_close_msg 		= inoutinfo.getText("apl_close_msg");
%>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>

<script language="javascript">
	function sts_check(){			
		var pl_sts 			= '<%=pl_sts%>';
		var div_sts 		= '<%=div_sts%>';
		var rest_sts 		= '<%=rest_sts%>';
		var prem_sts 		= '<%=prem_sts%>';
		var addprem_sts 	= '<%=addprem_sts%>';
		var plrepay_sts 	= '<%=plrepay_sts%>';
		var apl_sts 		= '<%=apl_sts%>';
		
		pl_sts_check(pl_sts);
		div_sts_check(div_sts);
		rest_sts_check(rest_sts);
		prem_sts_check(prem_sts);
		addprem_sts_check(addprem_sts);
		plrepay_sts_check(plrepay_sts);
		apl_sts_check(apl_sts);		
	}
	
	function pl_sts_check(pl_sts){	
		var form = document.form;
		if(pl_sts=='N')	form.pl_close_msg.disabled=true;
		else 			form.pl_close_msg.disabled=false;		
	}
	function div_sts_check(div_sts){	
		var form = document.form;			
		if(div_sts=='N')	form.div_close_msg.disabled=true;
		else 				form.div_close_msg.disabled=false;		
	}
	function rest_sts_check(rest_sts){	
		var form = document.form;			
		if(rest_sts=='N')	form.rest_close_msg.disabled=true;
		else 				form.rest_close_msg.disabled=false;		
	}
	function prem_sts_check(prem_sts){	
		var form = document.form;			
		if(prem_sts=='N')	form.prem_close_msg.disabled=true;
		else 				form.prem_close_msg.disabled=false;		
	}
	function addprem_sts_check(addprem_sts){
		var form = document.form;				
		if(addprem_sts=='N')	form.addprem_close_msg.disabled=true;
		else 					form.addprem_close_msg.disabled=false;		
	}
	function plrepay_sts_check(plrepay_sts){
		var form = document.form;				
		if(plrepay_sts=='N')	form.plrepay_close_msg.disabled=true;
		else 					form.plrepay_close_msg.disabled=false;		
	}
	function apl_sts_check(apl_sts){	
		var form = document.form;			
		if(apl_sts=='N')	form.apl_close_msg.disabled=true;
		else 				form.apl_close_msg.disabled=false;		
	}
	
	function sts_change(){	
		var form = document.form;
		
		if(form.pl_sts[0].checked==true){
			form.pl_close_msg.disabled		=false;
			form.pl_close_msg.value			=form.plclose_msg.value;
		}
		if(form.div_sts[0].checked==true){
			form.div_close_msg.disabled		=false;
			form.div_close_msg.value		=form.divclose_msg.value;
		}
		if(form.rest_sts[0].checked==true){
			form.rest_close_msg.disabled	=false;
			form.rest_close_msg.value		=form.restclose_msg.value;
		}
		if(form.prem_sts[0].checked==true){
			form.prem_close_msg.disabled	=false;
			form.prem_close_msg.value		=form.premclose_msg.value;
		}
		if(form.addprem_sts[0].checked==true){
			form.addprem_close_msg.disabled	=false;
			form.addprem_close_msg.value	=form.addpremclose_msg.value;
		}
		if(form.plrepay_sts[0].checked==true){
			form.plrepay_close_msg.disabled	=false;
			form.plrepay_close_msg.value	=form.plrepayclose_msg.value;
		}
		if(form.apl_sts[0].checked==true){
			form.apl_close_msg.disabled		=false;
			form.apl_close_msg.value		=form.aplclose_msg.value;
		}		
				
		if(confirm("현재 상태로 변경하시겠습니까?")){
			form.save_sts.value='Y';
			form.emp_no.value='<%=emp_no%>';
			form.action = "inout_manager.do";
			form.submit();
		}		
	}
	
</script>
<body onLoad="javascript:sts_check();">

<form name="form" method="post"  action="inout_manager.do">
<input type="hidden" name="save_sts">
<input type="hidden" name="emp_no" value="<%=emp_no%>">
<input type="hidden" name="plclose_msg" value="<%=pl_close_msg%>">
<input type="hidden" name="divclose_msg" value="<%=div_close_msg%>">
<input type="hidden" name="restclose_msg" value="<%=rest_close_msg%>">
<input type="hidden" name="premclose_msg" value="<%=prem_close_msg%>">
<input type="hidden" name="addpremclose_msg" value="<%=addprem_close_msg%>">
<input type="hidden" name="plrepayclose_msg" value="<%=plrepay_close_msg%>">
<input type="hidden" name="aplclose_msg" value="<%=apl_close_msg%>">

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
						<!--DropDown 삽입 : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="3"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
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
                  <td> <table width="100%">
                      <tr> 
                        <td><img src="/img/common/bu_cir01.gif"> <b>입출금관리</b></td>
                        <td align="right">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td><table width="100%" class="adm_table">
                      <tr> 
                        <th width="15%">입출금 구분</th>
                        <th width="40%">입출금 접수 상태</th>
                        <th width="45%">입출금 불가 메세지</th>
                      </tr>
					  <tr>
					  	<td>약관대출지급</td>
					  	<td>
                        	<input type="radio" onFocus="this.blur()" name="pl_sts" value="N" <% if(pl_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="pl_sts_check(this.value)">접수,처리가능&nbsp;                        	
                        	<input type="radio" onFocus="this.blur()" name="pl_sts" value="X" <% if(pl_sts.equals("X")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="pl_sts_check(this.value)">접수만가능
                        	<input type="radio" onFocus="this.blur()" name="pl_sts" value="Y" <% if(pl_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="pl_sts_check(this.value)">접수불가
						</td>
					  	<td>
							<textarea name="pl_close_msg" cols="50" rows="5"style="overflow=hidden"><%=pl_close_msg%></textarea>
						</td>
					  </tr>
					  <tr>
					  	<td>배당금지급/<br>배당금상계지급</td>
					  	<td>
                        	<input type="radio" onFocus="this.blur()" name="div_sts" value="N" <% if(div_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="div_sts_check(this.value)">접수가능&nbsp;
                        	<input type="radio" onFocus="this.blur()" name="div_sts" value="Y" <% if(div_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="div_sts_check(this.value)">접수불가
						</td>
					  	<td>
							<textarea name="div_close_msg" cols="50" rows="5"style="overflow=hidden"><%=div_close_msg%></textarea>
						</td>
					  </tr>
					  <tr>
					  	<td>휴면보험금지급</td>
					  	<td>
                        	<input type="radio" onFocus="this.blur()" name="rest_sts" value="N" <% if(rest_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="rest_sts_check(this.value)">접수가능&nbsp;
                        	<input type="radio" onFocus="this.blur()" name="rest_sts" value="Y" <% if(rest_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="rest_sts_check(this.value)">접수불가
						</td>
					  	<td>
							<textarea name="rest_close_msg" cols="50" rows="5"style="overflow=hidden"><%=rest_close_msg%></textarea>
						</td>
					  </tr>
					  <tr>
					  	<td>보험료수납</td>
					  	<td>
                        	<input type="radio" onFocus="this.blur()" name="prem_sts" value="N" <% if(prem_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="prem_sts_check(this.value)">접수가능&nbsp;
                        	<input type="radio" onFocus="this.blur()" name="prem_sts" value="Y" <% if(prem_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="prem_sts_check(this.value)">접수불가
						</td>
					  	<td>
							<textarea name="prem_close_msg" cols="50" rows="5"style="overflow=hidden"><%=prem_close_msg%></textarea>
						</td>
					  </tr>
					  <tr>
					  	<td>추가보험료수납</td>
					  	<td>
                        	<input type="radio" onFocus="this.blur()" name="addprem_sts" value="N" <% if(addprem_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="addprem_sts_check(this.value)">접수가능&nbsp;
                        	<input type="radio" onFocus="this.blur()" name="addprem_sts" value="Y" <% if(addprem_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="addprem_sts_check(this.value)">접수불가
						</td>
					  	<td>
							<textarea name="addprem_close_msg" cols="50" rows="5"style="overflow=hidden"><%=addprem_close_msg%></textarea>
						</td>
					  </tr>
					  <tr>
					  	<td>약관대출상환</td>
					  	<td>
                        	<input type="radio" onFocus="this.blur()" name="plrepay_sts" value="N" <% if(plrepay_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="plrepay_sts_check(this.value)">접수가능&nbsp;
                        	<input type="radio" onFocus="this.blur()" name="plrepay_sts" value="Y" <% if(plrepay_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="plrepay_sts_check(this.value)">접수불가
						</td>
					  	<td>
							<textarea name="plrepay_close_msg" cols="50" rows="5"style="overflow=hidden"><%=plrepay_close_msg%></textarea>
						</td>
					  </tr>
					  <tr>
					  	<td>APL상환</td>
					  	<td>
                        	<input type="radio" onFocus="this.blur()" name="apl_sts" value="N" <% if(apl_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="apl_sts_check(this.value)">접수가능&nbsp;
                        	<input type="radio" onFocus="this.blur()" name="apl_sts" value="Y" <% if(apl_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="apl_sts_check(this.value)">접수불가
						</td>
					  	<td>
							<textarea name="apl_close_msg" cols="50" rows="5"style="overflow=hidden"><%=apl_close_msg%></textarea>
						</td>
					  </tr>
				  </table></td>
				 </tr>
                <tr> 
                  <td><table width="100%">
					<div align="right"><a href="javascript:sts_change();" onFocus="blur()"><img src="/img/common/btn_changes.gif" width="38" height="18" ></a></div>
				   </table></td>
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


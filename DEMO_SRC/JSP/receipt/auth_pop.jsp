<%
/* -----------------------------------------------------------------------------
 * Project Title		: 권한관리 - 팝업창
 * File Name		: auth_pop.jsp
 * Programmer		:
 * First Write		: 2004.12.08
 * Last Update		: 2004.12.08
 * R&D         		: CI
 * ---------------------------------------------------------------------------*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<%
	String flag		= request.getParameter("flag") 	== null ? ""  : request.getParameter("flag");
	String emp_no 	= request.getParameter("emp_no") 	== null ? ""  : request.getParameter("emp_no");
	String pwd		= request.getParameter("pwd") 	== null ? ""  : request.getParameter("pwd");
	String emp_nm 	= request.getParameter("emp_nm") 	== null ? ""  : request.getParameter("emp_nm");
	String auth_cd 	= request.getParameter("auth_cd") 	== null ? ""  : request.getParameter("auth_cd");
	String auth_cd2 	= request.getParameter("auth_cd2") 	== null ? ""  : request.getParameter("auth_cd2");
	String team_nm 	= request.getParameter("team_nm") 	== null ? ""  : request.getParameter("team_nm");
	String old_pwd 	= request.getParameter("old_pwd") 	== null ? ""  : request.getParameter("old_pwd");
	String chg_pwd_dt 	= request.getParameter("chg_pwd_dt") 	== null ? ""  : request.getParameter("chg_pwd_dt");
	String hand_phone 	= request.getParameter("hand_phone") 	== null ? ""  : request.getParameter("hand_phone");
	String hand_phone_yn 	= request.getParameter("hand_phone_yn") 	== null ? ""  : request.getParameter("hand_phone_yn");
	String email 	= request.getParameter("email") 	== null ? ""  : request.getParameter("email");
	String email_yn 	= request.getParameter("email_yn") 	== null ? ""  : request.getParameter("email_yn");


	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd1 = sessionManager.getString(Constant.SESSION_LEVEL);
	String auth_cdS2 = sessionManager.getString(Constant.SESSION_LEVEL2);

%>
   
<html>
<head>
<title>권한관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">
<!--

	//라디오 버튼 값 가져오기 
	function checkIt(form){

		for(var i=0; i<form.length; i++){
		
			if(form[i].checked==true){
			
				return form[i].value;
			
			}
		}
	}	

	
	
	// 이메일주소 형식이 제대로 되어 있는지 확인
	function CheckEmail(email) {
		cnt1=0;
		cnt2=0;
	        
		for(var ii = 0; ii < email.length; ii ++) {
	   		if((ii==0 || ii==email.length-1) && email.charAt(ii)=='@') {
				return false;
			}
	   		if((ii==0 || ii==email.length-1) && email.charAt(ii)=='.') {
				return false;
			}
	   		if(email.charAt(ii)=='@') cnt1++;
	   		if(email.charAt(ii)=='.') cnt2++;
	    }
		if (cnt1==0){
				return false;
		}
		if (cnt2==0){
				return false;
		}
		return true;
	}


	function checkFild(formName,alertMsg){
		form = document.authForm;
		var nameValue = formName.value;
		if(nameValue.replace(/\s/g, "") == ''){
			
			alert(alertMsg);
			return false;
		
		}
		
			return true;
	
	}
	
	
	function goWrite()
	{
	

		form = document.authForm;
		
		
		
		if(!checkFild(form.emp_no,'사번을 입력하여 주십시오.')){
			
				return;
			
			}
			
		if(!checkFild(form.emp_nm,'성명을 입력하여 주십시오.')){
			
				return;
			
			}
		if(!checkFild(form.pwd,'비밀번호를 입력하여 주십시오.')){
			
				return;
			
			}
		if(!checkFild(form.team_nm,'팀명을 입력하여 주십시오.')){
			
				return;
			
			}			
		

<%
		if(auth_cd1.equals("40"))
		{
%>		
		if(checkIt(form.hand_phone_yn) == "Y"){
<% }else{ %>

		if(form.hand_phone_yn.value == "Y"){
		
<%}%>		
			if(!checkFild(form.hand_phone,'SMS수신이 선택되어있습니다.\n핸드폰번호를 입력하여주십시오.')){
			
				return;
			
			}
		
		}

<%
		if(auth_cd1.equals("40"))
		{
%>				
		if(checkIt(form.email_yn) == "Y"){
		
<% }else{ %>

		if(form.email_yn.value == "Y"){
		
<%}%>			
			if(!checkFild(form.email,'EMAIL수신이 선택되어있습니다.\EMAIL주소를 입력하여주십시오.')){
			
				return;
			
			}else{
		
		
					if(!CheckEmail(form.email.value)){
					
						alert('EMAIL형식이 잘못되었습니다.');
						return;
					
					
					}
			}		
		
		
		
		}
		
		
		
		form.chkyn.value = "Y";
		form.flag.value="I";
		
		

		
		form.submit();
		opener.document.form.flag.value = " ";
		opener.document.form.submit();
//		opener.winreflash();

		//this.close();
	}

	function goUpdate()
	{
		form = document.authForm;

<%
		if(auth_cd1.equals("40"))
		{
%>		
		if(checkIt(form.hand_phone_yn) == "Y"){
<% }else{ %>

		if(form.hand_phone_yn.value == "Y"){
		
<%}%>		
			if(!checkFild(form.hand_phone,'SMS수신이 선택되어있습니다.\n핸드폰번호를 입력하여주십시오.')){
			
				return;
			
			}
		
		}

<%
		if(auth_cd1.equals("40"))
		{
%>				
		if(checkIt(form.email_yn) == "Y"){
		
<% }else{ %>

		if(form.email_yn.value == "Y"){
		
<%}%>			
			if(!checkFild(form.email,'EMAIL수신이 선택되어있습니다.\EMAIL주소를 입력하여주십시오.')){
			
				return;
			
			}else{
		
		
					if(!CheckEmail(form.email.value)){
					
						alert('EMAIL형식이 잘못되었습니다.');
						return;
					
					
					}
			}		
		
		
		
		}
				
		
		form.chkyn.value = "Y";
		form.flag.value="U";
		form.submit();
		opener.document.form.submit();
//		opener.winreflash();

		//this.close();
	}


	function winClose()
	{
		this.close();
	}
//-->
</script>

<body <%if(flag.equals("")){%>onLoad="javascript:winClose()"<%}%>>
<form name="authForm" method="post" action="auth_pop.do">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="chkyn" >
<center>
    <table width="600">
		<tr>
			<td height="14"></td>
		</tr>
		<tr>

      <td><img src="/img/common/bu_cir01.gif"> <b>권한관리</b></td>
		</tr>
		<tr>
			<td height="7"></td>
		</tr>
		<tr>
			<td><table width="100%" class="adm_table">
          <col width=12%>
          <col width=12%>
          <col width=38%>
          <col width=38%>
          <tr>
            <th colspan="2">사용자 등록</th>
          </tr>
          <tr>
            <td width="35%" bgcolor="#F3F3F3">ID</td>
            <td width="65%"><div align="left">
<%
	if(flag.equals("I"))
	{
%>
                <input type="text" name="emp_no" value="<%=emp_no%>" maxlength="5">
<%
	}
	else if(flag.equals("U"))
	{
%>
		<input type="text" name="emp_no"  value="<%=emp_no%>" size="14" maxlength="5"  style="background-color:white; border-width:0; border-color:black; border-style:solid;" readonly ></td>

<%
	}
%>
                </div>

			</td>
          </tr>
          <tr>
            <td colspan="2" bgcolor="F3F3F3">※반드시 사번으로 입력하십시오.</td>
          </tr>
          <tr>
            <td bgcolor="F3F3F3">이름</td>
            <td><div align="left">
                <input type="text" name="emp_nm" value="<%=emp_nm%>" maxlength="20">
              </div></td>
          </tr>
          <tr>
            <td bgcolor="F3F3F3">비밀번호</td>
            <td><div align="left">
                <input type="password" name="pwd"  value="<%=pwd%>" maxlength="10">
                <input type="hidden" name="old_pwd" value="<%=pwd%>" maxlength="10">
              </div></td>
          </tr>
          <tr>
            <td bgcolor="F3F3F3">팀</td>
            <td><div align="left">
                <input type="text" name="team_nm" value="<%=team_nm%>" maxlength="20">
              </div></td>
          </tr>
          <tr>
            <td bgcolor="F3F3F3">권한</td>
            <td><div align="left">
<%
		String tmp = "";
		//if(auth_cd1.equals("30")) tmp = "결재자";
		if(auth_cd1.equals("31")) tmp = "1차결재자";
		if(auth_cd1.equals("32")) tmp = "2차결재자";
		if(auth_cd1.equals("33")) tmp = "3차결재자";
		if(auth_cd1.equals("20")) tmp = "상담원";
		if(auth_cd1.equals("10")) tmp = "조회";
		if(auth_cd1.equals("00")) tmp = "삭제";
		if(auth_cd1.equals("90")) tmp = "청약철회관리자";


		if(auth_cd1.equals("40"))
		{
%>
                <select name="auth_cd">
                  <option value="40" <% if(auth_cd.equals("40")){ %> selected <% } %>>Admin</option>
                  <!--option value="30" <% //if(auth_cd.equals("30")){ %> selected <% //} %>>결재자</option-->
                  <option value="31" <% if(auth_cd.equals("31")){ %> selected <% } %>>1차결재자</option>
                  <option value="32" <% if(auth_cd.equals("32")){ %> selected <% } %>>2차결재자</option>
                  <option value="33" <% if(auth_cd.equals("33")){ %> selected <% } %>>3차결재자</option>
                  <option value="20" <% if(auth_cd.equals("20")){ %> selected <% } %>>상담원</option>
                  <option value="10" <% if(auth_cd.equals("10")){ %> selected <% } %>>조회</option>
                  <option value="00" <% if(auth_cd.equals("00")){ %> selected <% } %>>삭제</option>
                  <option value="90" <% if(auth_cd.equals("90")){ %> selected <% } %>>청약철회관리자</option>
                </select>
<%
		}
		else
		{
			out.println(tmp);
%>
		<input type="hidden" name="auth_cd" value="<%=auth_cd1%>">
<%
		}
%>


              </div></td>
          </tr>
          
          <tr>
            <td bgcolor="F3F3F3">상담원 세부권한</td>
            <td><div align="left">
<%
		String tmp2 = "";
		
		
		
		if(auth_cd.equals("20")&&auth_cdS2.equals("00")){
		
			tmp2 = "상담원A";
			
		}else if(auth_cd.equals("20")&&auth_cdS2.equals("11")){
		
			tmp2 = "상담원B";
		}
		
		
		
		if(auth_cd1.equals("40"))
		{
%>
                <select name="auth_cd2">
                  <option value="" <% if(auth_cd2.equals("")){ %> selected <% } %>>==선택==</option>
                  <option value="00" <% if(auth_cd2.equals("00")){ %> selected <% } %>>상담원A</option>
                  <option value="11" <% if(auth_cd2.equals("11")){ %> selected <% } %>>상담원B</option>
                </select>
<%
		}
		else
		{
			out.println(tmp2);
%>
		<input type="hidden" name="auth_cd2" value="<%=auth_cdS2%>">
<%
		}
%>

* 상담원일경우만 사용
              </div></td>
          </tr>          
          
          
          <tr>
            <td bgcolor="F3F3F3">핸드폰</td>
            <td><div align="left">
                <input type="text" name="hand_phone" value="<%=hand_phone%>" maxlength="20">
<%
    // 어드민만 수정할수 있음.
    if("40".equals(auth_cd1)) {
%>
                <input type="radio" name="hand_phone_yn" <%="Y".equals(hand_phone_yn)?"checked":""%> value="Y">허용
                <input type="radio" name="hand_phone_yn" <%="Y".equals(hand_phone_yn)==false?"checked":""%> value="N">거부
<%
    }else {
%>
                <input type="hidden" name="hand_phone_yn" value="<%=hand_phone_yn%>"><%="Y".equals(hand_phone_yn)?"수신허용":"수신거부"%>
<%
    }
%>
              </div></td>
          </tr>
          <tr>
            <td bgcolor="F3F3F3">이메일</td>
            <td><div align="left">
                <input type="text" name="email" value="<%=email%>" maxlength="50">
<%
    // 어드민만 수정할수 있음.
    if("40".equals(auth_cd1)) {
%>
                <input type="radio" name="email_yn" <%="Y".equals(email_yn)?"checked":""%> value="Y">수신허용
                <input type="radio" name="email_yn" <%="Y".equals(email_yn)==false?"checked":""%> value="N">수신거부
<%
    }else {
%>
                <input type="hidden" name="email_yn" value="<%=email_yn%>"><%="Y".equals(email_yn)?"수신허용":"수신거부"%>
<%
    }
%>
              </div></td>
          </tr>
        </table></td>
		</tr>
		<tr><!--<td align="right"><a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" hspace="10"><img src="/img/common/btn_cancel.gif"></a></td>-->

      <td align="right">
<%
	if(flag.equals("I"))
	{
%>
      	<a href="javascript:goWrite()" onFocus="blur()"><img src="/img/common/btn_save.gif" width="49" height="19" hspace="10"></a>
<%
	}
	else if(flag.equals("U"))
	{
%>
		<a href="javascript:goUpdate()" onFocus="blur()"><img src="/img/common/btn_changes.gif" width="38" height="18" hspace="10"></a>
<%
	}
%>
      </td>
		</tr>
	</table>
</center>
</form>
</body>
</html>
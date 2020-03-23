<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="withdrawal" class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean id="svclpname" class="java.lang.String" scope="request"/>
<jsp:useBean id="policy_no" class="java.lang.String" scope="request"/>
<jsp:useBean id="seq" class="java.lang.String" scope="request"/>
<jsp:useBean id="strMessage" class="java.lang.String" scope="request"/>

<%
    String flag = request.getParameter("flag") == null? "" : request.getParameter("flag");

    //세션에서 가져오기
    SessionManager sessionManager = new SessionManager(request);
    String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
    String emp_no = sessionManager.getString(Constant.SESSION_USERID);

    String apl_date     = withdrawal.getText("apl_date"   );
    String con_date     = withdrawal.getText("con_date"   );
    String status_cd    = withdrawal.getText("status_cd"  );
    String client_name  = withdrawal.getText("client_name");
    String client_ssn   = withdrawal.getText("client_ssn" );
    String emp_id       = withdrawal.getText("emp_id"     );
    String emp_nm       = withdrawal.getText("emp_nm"     );
    String memo         = withdrawal.getText("memo"       );

%>
<html>
<head>
<title>청약철회 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">
<!--
    function goWrite()
    {
        var varStatusCd = "<%=status_cd%>";
        form = document.withdrawalForm;
        form.action = "/withdrawal/withdrawal_detail.do";
        form.save.value = "Y";
        // 최초의 상태값에서 바뀔때 처리일자와 처리자를 입력하기 위한 플래그.
        // 반송, 완료 상태는 상태값을 바꿀수 없기 때문에 접수 -> 반송, 접수 -> 완료 일때만임. 
        if(varStatusCd != form.status_cd.value) {
            form.save_status.value = "Y";
        }
        form.submit();
    }

    function onInit() {
<%
    if("".equals(strMessage) == false) {
%>
        alert("<%=strMessage%>");
        winClose();
<%
    }
%>
    }

    function winClose()
    {
        if(parent.window.opener.closed) {
        }else {
            opener.goSearch();
        }
        this.close();
    }
//-->
</script>

<body onLoad="javascript:onInit();">
<form name="withdrawalForm" method="post" action="/withdrawal/withdrawal_detail.do">
<input type="hidden" name="save" value="">
<input type="hidden" name="save_status" value="N">
<input type="hidden" name="emp_id" value="<%=emp_no%>">
<center>
    <table width="600">
        <tr>
            <td height="14"></td>
        </tr>
        <tr>
          <td><img src="/img/common/bu_cir01.gif"> <b>철회신청접수내역</b></td>
        </tr>
        <tr>
          <td height="7"></td>
        </tr>
        <tr>
          <td><table width="100%" class="adm_table" border="1">
                <col width=15%>
                <col width=35%>
                <col width=15%>
                <col width=35%>
                <tr>
                  <th colspan="4"></th>
                </tr>
                <tr>
                  <td bgcolor="#F3F3F3">증권번호</td>
                  <td colspan="3"><div align="left">
                      <input type="hidden" name="policy_no" value="<%=policy_no%>"><%=policy_no%>
                      <input type="hidden" name="seq" value="<%=seq%>">
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="#F3F3F3">접수일시</td>
                  <td colspan="3"><div align="left">
                      <input type="hidden" name="apl_date" value="<%=apl_date%>" maxlength="20"><%=apl_date%>
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">처리일시</td>
                  <td colspan="3"><div align="left">
                      <input type="hidden" name="con_date" value="<%=con_date%>" maxlength="20"><%=con_date%>
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">상태</td>
                  <td><div align="left">
<%
    if("1".equals(status_cd)) {
%>
                      <select name="status_cd">
                        <option value="1" <% if(status_cd.equals("1")){ %> selected <% } %>>접수</option>
                        <option value="2" <% if(status_cd.equals("2")){ %> selected <% } %>>반송</option>
                        <option value="3" <% if(status_cd.equals("3")){ %> selected <% } %>>완료</option>
                      </select>
<%
    }else {
        if("2".equals(status_cd)) {
%>
                      <input type="hidden" name="status_cd" value="<%=status_cd%>">반송
<%
        }else if("3".equals(status_cd)) {
%>
                      <input type="hidden" name="status_cd" value="<%=status_cd%>">완료
<%
        }
    }
%>
                    </div></td>
                  <td bgcolor="F3F3F3">철회접수경로</td>
                  <td><div align="left">사이버센터</div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">계약자</td>
                  <td><div align="left">
                          <%=client_name%> (<%=client_ssn%>)
                   </div></td>
                  <td bgcolor="F3F3F3">담당LP</td>
                  <td><div align="left"><%=svclpname%></div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">처리자</td>
                  <td colspan="3"><div align="left">
<%
    if("".equals(emp_id) == false) {
        out.println(emp_id + "(" + emp_nm + ")");
    }
%>
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">메모</td>
                  <td colspan="3"><div align="left"><textarea name="memo" style="width:100%" rows="5"><%=memo%></textarea>
                    </div></td>
                </tr>
            </table>
          </td>
        </tr>
        <tr><!--<td align="right"><a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" hspace="10"><img src="/img/common/btn_cancel.gif"></a></td>-->

      <td align="center">
        <a href="javascript:goWrite()" onFocus="blur()"><img src="/img/common/btn_save.gif" width="49" height="19" hspace="10"></a>
        <a href="javascript:winClose()" onFocus="blur()"><img src="/img/common/btn_close.gif"></a>
        <a href="javascript:window.print();" onFocus="blur()"><img src="/img/common/btn_print.gif"></a>
      </td>
        </tr>
    </table>
</center>
</form>
</body>
</html>

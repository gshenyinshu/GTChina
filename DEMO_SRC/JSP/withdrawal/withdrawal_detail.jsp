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

    //���ǿ��� ��������
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
<title>û��öȸ ����</title>
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
        // ������ ���°����� �ٲ� ó�����ڿ� ó���ڸ� �Է��ϱ� ���� �÷���.
        // �ݼ�, �Ϸ� ���´� ���°��� �ٲܼ� ���� ������ ���� -> �ݼ�, ���� -> �Ϸ� �϶�����. 
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
          <td><img src="/img/common/bu_cir01.gif"> <b>öȸ��û��������</b></td>
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
                  <td bgcolor="#F3F3F3">���ǹ�ȣ</td>
                  <td colspan="3"><div align="left">
                      <input type="hidden" name="policy_no" value="<%=policy_no%>"><%=policy_no%>
                      <input type="hidden" name="seq" value="<%=seq%>">
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="#F3F3F3">�����Ͻ�</td>
                  <td colspan="3"><div align="left">
                      <input type="hidden" name="apl_date" value="<%=apl_date%>" maxlength="20"><%=apl_date%>
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">ó���Ͻ�</td>
                  <td colspan="3"><div align="left">
                      <input type="hidden" name="con_date" value="<%=con_date%>" maxlength="20"><%=con_date%>
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">����</td>
                  <td><div align="left">
<%
    if("1".equals(status_cd)) {
%>
                      <select name="status_cd">
                        <option value="1" <% if(status_cd.equals("1")){ %> selected <% } %>>����</option>
                        <option value="2" <% if(status_cd.equals("2")){ %> selected <% } %>>�ݼ�</option>
                        <option value="3" <% if(status_cd.equals("3")){ %> selected <% } %>>�Ϸ�</option>
                      </select>
<%
    }else {
        if("2".equals(status_cd)) {
%>
                      <input type="hidden" name="status_cd" value="<%=status_cd%>">�ݼ�
<%
        }else if("3".equals(status_cd)) {
%>
                      <input type="hidden" name="status_cd" value="<%=status_cd%>">�Ϸ�
<%
        }
    }
%>
                    </div></td>
                  <td bgcolor="F3F3F3">öȸ�������</td>
                  <td><div align="left">���̹�����</div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">�����</td>
                  <td><div align="left">
                          <%=client_name%> (<%=client_ssn%>)
                   </div></td>
                  <td bgcolor="F3F3F3">���LP</td>
                  <td><div align="left"><%=svclpname%></div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">ó����</td>
                  <td colspan="3"><div align="left">
<%
    if("".equals(emp_id) == false) {
        out.println(emp_id + "(" + emp_nm + ")");
    }
%>
                    </div></td>
                </tr>
                <tr>
                  <td bgcolor="F3F3F3">�޸�</td>
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

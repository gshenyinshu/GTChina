<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager,gtone.changeminer.common.utility.Utility" %>

<jsp:useBean id="smsloglist" class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>

<jsp:useBean id="fromDate1" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromDate2" class="java.lang.String" scope="request"/>

<jsp:useBean id="searchtype" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>

<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>

<%
    String flag = request.getParameter("flag") == null? "" : request.getParameter("flag");

    //세션에서 가져오기
    SessionManager sessionManager = new SessionManager(request);
    String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
    //String emp_no = sessionManager.getString(Constant.SESSION_USERID);
    //String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
    
	//현재년, 현재월
    int year  = Calendar.getInstance().get(Calendar.YEAR) ;
	int month = Calendar.getInstance().get(Calendar.MONTH) + 1 ;
	
	
	
%>
<html>
<head>
<title>청약철회 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>

</head>
<script language="javascript">
    function goSearch()
    {
    
    	nowYear	= document.form.fromDate1.value;
    	nowMon = document.form.fromDate2.value;
    	if(<%=year%><nowYear){
    	
    		alert("검색가능한 년도가 아닙니다.");
    	
    		return;
    		
    	}else if(<%=year%>==nowYear){
    	
    		if(<%=month%><nowMon){
    		
    			alert("검색가능한 월이 아닙니다.\n"+<%=month%>+"월 이하로 검색하여 주십시오.");
    			
    			return;
    		
    		}
    	
    	
    	}
    		
    		
    		
    		
    		
        document.form.current.value = 1;
        document.form.method="get" ;
        document.form.action = "/sms_log/sms_log_list.do";
        document.form.submit();
    }

    function openit(oform,obox)
    {
        var temp = "width=190,height=232,left="+(screen.width/2-110)+",top="+(screen.height/2-80);
        window.open("../common/calen1.jsp?oform="+oform+"&obox="+obox,"datewindow",temp);
    }

    function goPage(num)
    {
        document.form.current.value = num;
        document.form.method="get" ;
        document.form.action = "/sms_log/sms_log_list.do";
        document.form.submit();
    }

    function goDetail(policy_no, seq)
    {
        varForm = document.form;
        varForm.policy_no.value = policy_no;
        varForm.seq.value = seq;
        varForm.target = "POPUP";
        varForm.action = "/withdrawal/withdrawal_detail.do";
        window.open("about:blank","POPUP","top="+(screen.height/2-200)+",left="+(screen.width/2-295)+",width="+600+",height="+340+",status=yes,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=no");
        varForm.submit();
        varForm.target = "";
    }

    function onInit() {

    }
</script>
<body onLoad="javascript:onInit();">
<form name="form" method="post" >
<input type="hidden" name="current" value="<%=current%>"><!--보여주는 페이지 번호 -->
<input type="hidden" name="flag">
<input type="hidden" name="emp_no" >
<input type="hidden" name="policy_no" >
<input type="hidden" name="seq" >
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
                        <jsp:include page="/common/dropDown.jsp" flush="true"></jsp:include>
                        <!--DropDown 삽입 : E-->
                    </td>
                    <td class="contents"><table width="100%">
                <tr>
                  <td><img src="/img/common/title_11.gif"></td>
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
                        <td><img src="/img/common/bu_cir01.gif"> <b>SMS발송이력 관리</b></td>
                        <td align="right">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                                <td><table width="100%" class="adm_table">
                                        <col width=13%><col width=35%><col width=15%><col width=38%>
                                        <tr>
                                            <th rowspan="2">검색조건</th>
                                            <th>검색월</th>
                                            <th>세부검색항목</th>
                                            <th>검색입력</th>
                                        </tr>
                                        <tr class="adm11">
                                            <td align=center>
                                            	<!--input type="text" name="fromdate" class="box02" size="8" maxlength="10" style="text-align:center" value="<%=fromdate%>" readonly>
                                                <!--img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  >
                                                -
                                                <input type="text" name="todate" class="box02" size="8" maxlength="10" style="text-align:center" value = "<%=todate%>" readonly-->
                                                <!--img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  -->
                                               <select name="fromDate1">
                                               <%

																
																for(int i=2005; i<=year; i++){%>
																				<option value="<%=i%>" <%if(fromDate1.equals(""+i)){%>selected<%}%>><%=i%></option>
												<%				}%>
																			</select> 년  
																			<select name="fromDate2">
												<%				for(int i=1; i<=12 ; i++){%>
																				<option value="<%=i%>" <%if(fromDate2.equals(""+i)){%>selected<%}%>><%=i%></option>
												<%				}%>
																			</select> 월
                                                
                                            </td>
                                            <td align=center><select name="searchtype">
                                                    <option value="1"  <% if(searchtype.equals("1")){ %> selected <% } %>>휴대번호</option>
                                                    <option value="2"  <% if(searchtype.equals("2")){ %> selected <% } %>>수신자</option>
                                                    <option value="3"  <% if(searchtype.equals("3")){ %> selected <% } %>>증권번호</option>
                                                </select></td>
                                            <td align=center>
                                                <input type="text" name="key" class="box04" value="<%=key%>">
                                                <a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
                                            </td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>

                <tr>
                  <td><table width="100%" class="adm_table">
                  <col width=5%>
                  <col width=10%>
                  <col width=10%>
                  <col width=10%>
                  <col width=5%>
                  <col width=12%>
                  <col width=12%>
                  <col width=>
                      <tr>
                          <th>N</th>
                          <th>증권번호</th>
                          <th>전송일</th>
                          <th>전송시간</th>
                          <th>상태</th>
                          <th>수신자</th>
                          <th>수신번호</th>
                          <th>내용</th>
                      </tr>
<%
            int cnt = smsloglist.getCount("policy_no");
            if(cnt == 0)
            {
%>
                      <tr class="adm01">
                        <td colspan="8">해당하는 자료가 없습니다.</td>
                      </tr>
<%
            }
            else
            {
                int row = 0;
                row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*20;
                for(int i=0;i<cnt;i++)
                {
%>
                      <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>">
                        <td><%=row%></td>
                        <td><%=smsloglist.getText("policy_no",i)%></td>
                        <td><%=smsloglist.getText("tran_date_dt",i)%></td>
                        <td><%=smsloglist.getText("tran_date_tm",i)%></td>
                        <td><%=smsloglist.getText("tran_status",i)%></td>
                        <td><%=smsloglist.getText("tran_nm",i)%></td>
                        <td><%=smsloglist.getText("tran_phone",i)%></td>
                        <td align="left" ><%=smsloglist.getText("tran_msg",i)%></td>
                        
                      </tr>
<%
                    row = row - 1;
                }
            }
%>
                    </table></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td align="center"><table>
                      <tr>
                        <td width="26"></td>
                        <td width="45">
                        <td align="center"> <jsp:include page="/common/include/paging.jsp" flush="true">
                          <jsp:param name="total" value="<%= totalCount %>"/>
                          <jsp:param name="cpage" value="<%= current %>"/>
                          </jsp:include> </td>
                        <td width="30"></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td height="50"><div align="right">

                    &nbsp;&nbsp;</div></td>
                </tr>
              </table></td>
                </tr>
            </table></td>
    </tr>
    <tr>
        <td height="56" background="/img/common/copy_bg.gif"><img src="/img/common/copy.gif"></td>
    </tr>
</table>


<div id="cal" style="position:absolute; z-index:1;
                     left:192px; top:195px; width:193px;  height:195px;
                     visibility:hidden">
    <iframe name='dalFrame'
            id='dalFrame'
            src="/common/cal.jsp?setDate=form.fromdate&divName=cal"
            width="183"
            height="175"
            marginwidth="0"
            marginheight="0"
            topmargin="0"
            frameborder="0"
            scrolling="no"></iframe>
</div>
<div id="cal1" style="position:absolute; z-index:1;
                     left:192px; top:195px; width:193px;  height:195px;
                     visibility:hidden">
            <iframe id='dalFrame1'
            src="/common/cal.jsp?setDate=form.todate&divName=cal1"
            width="183"
            height="175"
            marginwidth="0"
            marginheight="0"
            topmargin="0"
            frameborder="0"
            scrolling="no"> </iframe>
</div>

</form>
</body>
</html>

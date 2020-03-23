<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.util.DateTime"%>
<%@ page import="anyframe.jsp.HtmlUtil"%>

<!-- 글내용 -->
<jsp:useBean    id="view" 
                class="anyframe.data.DataSet" 
                scope="request"/>
<!-- 폼데이터 -->
<jsp:useBean    id="form"
                class="gtone.home.mypage.form.ScrapForm"
                scope="request"/>
<html>
<head>
	<title></title>
    <script language="javascript" src="/common/js/mypage/scrap.js"></script>
</head>
<body>
<div id="content" style="display:none">
    <!-- body flash && location bar -->
    <!-- //body flash && location bar -->
<div align="left" style="POSITION : absolute;HEIGHT: 0px; LEFT: 221px; TOP:123px; VISIBILITY: visible; WIDTH: 170px;z-index:0">
				<table border="0" cellpadding="0" cellspacing="0" width="647">
					<tr align="right" valign="top">
						<td height="127" id='LocationBar'></td>
					</tr>
					<tr>	
                      <td><img src="/img/mypage/mypage_title06.gif"></td>
					</tr>
				</table>
				</div>
    <!-- contents -->
  <table width=628>
<form name="scrap" >
    <input type='hidden' name='current' value='<%=form.getCurrent()%>'>
    <input type='hidden' name='method'>
</form>
    <tr> 
      <td class=title01>My 스크랩북</td>
    </tr>
    <tr> 
      <td class=basic><table width="100%" class=mytable01>
          <col width=60>
          <col width=240>
          <col width=60>
          <col width=120>
          <tr> 
            <td class=my01>제목</td>
            <td colspan="3" class=my10>&nbsp;<%=view.getText("subject")%></td>
          </tr>
          <tr> 
            <td class=my01>등록자</td>
            <td class=my10>등록자</td>
            <td class=my01>날짜</td>
            <td class=my10>2004.02.03</td>
          </tr>
          <tr> 
            <td valign="top" class=my01>내용</td>
            <td colspan="3" class=my10><%=HtmlUtil.translateNewline(view.getText("contents"))%></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td class=btn01><a href="javascript:scrap_doSubmit();"><img src="/img/mypage/my_btn_list01.gif"></a></td>
    </tr>
  </table>
  <table><tr><td class=list00></td></tr></table>
    <!-- //contents -->
</div>
    <!-- banner -->
    <!-- //banner -->
<jsp:include page="/common/layout/Default.jsp" flush="true">
    <jsp:param name="menuId" value="PHMP0500"/>
</jsp:include>
</body>
</html>

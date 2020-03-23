<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<jsp:useBean    id="list" 
                class="anyframe.data.DataSet" 
                scope="request"/>
<jsp:useBean    id="count"
                class="java.lang.String"      
                scope="request"/>
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
    <input type='hidden' name='sequenceNo'>
</form>
    <tr> 
      <td class=title01>My 스크랩북</td>
    </tr>
    <tr> 
      <td class=basic><table width="100%" class=mytable01>
          <col width=>
          <col width=>
          <col width=60>
          <col width=60>
          <tr> 
            <td class=my03>No.</td>
            <td class=my01>제목</td>
            <td class=my01>등록자</td>
            <td class=my01>날짜</td>
          </tr>
<%if( list!=null && list.getCount("subject")>0){

    String temp = null ;
    int index = form.getMaxSize() * (form.getCurrent()-1) ;//row번호
    index = Integer.parseInt(count) - index ;

    int rowIndex = 0 ;//
    String   color    = "class=my10";//테이블 색 

    //결과데이트출력
    for(int i=0 ; i<list.getCount("subject") ; i++){

        //table row 색
        if(rowIndex==1){
            color = "class=my11" ;
            rowIndex-- ;
        }else{
            color = "class=my10" ;
            rowIndex++ ;
        }
%>
          <tr align=center <%=color%>> 
            <td><%=index--%></td>
            <td align='left'><a href="javascript:scrap_View('<%=list.getText("scrapDate",i).trim()%>')"><%=list.getText("subject",i)%></a></td>
            <td><%=list.getText("writer",i)%></td>
<%
    temp = list.getText("scrapDate",i).trim() ;//2004.02.02
    temp = temp.substring(0,4)+"."
         + temp.substring(4,6)+"."
         + temp.substring(6,8) ;

%>
            <td><a href='/mypage/scrap_view.do'><%=temp%></td>
          </tr>
<%  }
}%>
        </table>
        </td>
    </tr>

  </table>

        <!--페이징처리-->
        <jsp:include page="/common/include/paging.jsp" flush="true">
            <jsp:param name="row"  value="<%=form.getMaxSize()%>"/>
            <jsp:param name="list" value="10"/>
            <jsp:param name="total" value="<%=count%>"/>
            <jsp:param name="cpage" value="<%=form.getCurrent()%>"/>
		</jsp:include>
        <!--페이징처리-->
    <table><tr><td class=list00></td></tr></table>
    <!-- //contents -->

    <!-- banner -->
    <!-- //banner -->
</div>
<jsp:include page="/common/layout/Default.jsp" flush="true">
    <jsp:param name="menuId" value="PHMP0500"/>
</jsp:include>
</body>
</html>

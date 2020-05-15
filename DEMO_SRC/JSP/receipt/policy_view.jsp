<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="policyview" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
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

<jsp:useBean id="count1" class="java.lang.String" scope="request"/>
<jsp:useBean id="count2" class="java.lang.String" scope="request"/>
<jsp:useBean id="count3" class="java.lang.String" scope="request"/>
<jsp:useBean id="count4" class="java.lang.String" scope="request"/>
<%
	String v_toyear = Util.getTodayToYMD();
	String to_year = v_toyear.substring(0,8);
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>

</head>
<script language="javascript">
<!--
	function goSearch()
	{
		document.form.current.value = 1;
		document.form.method="get" ;
		document.form.searchgubun.value = "S";
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
		document.form.submit();
	}

	function goReLoadListPage()
	{
		document.form.method="get" ;
		document.form.submit();
	}

	function ReLoadWindow(val)
	{
		var srvc_value = '<%=srvc_ind%>';
		var searchgubun = '<%=searchgubun%>';
		if(srvc_value.length == 0)
		{
			srvc_value = "";
		}

		if(val == "1")
		{
			var AddOption4 = new Option("전 체" ,"");
			var AddOption = new Option("약대지급" ,"1");
			var AddOption1 = new Option("배당금지급", "4");
			var AddOption2 = new Option("휴면보험금지급","5");
			var AddOption3 = new Option("배당금상계","7");

			document.forms[0].srvc_ind.length  = 5;
			document.forms[0].srvc_ind.options[0] = AddOption4;
			document.forms[0].srvc_ind.options[1] = AddOption;
			document.forms[0].srvc_ind.options[2] = AddOption1;
			document.forms[0].srvc_ind.options[3] = AddOption2;
			document.forms[0].srvc_ind.options[4] = AddOption3;

			if(srvc_value == "") document.forms[0].srvc_ind.options[0].selected = true;
			if(srvc_value == "1") document.forms[0].srvc_ind.options[1].selected = true;
			if(srvc_value == "4") document.forms[0].srvc_ind.options[2].selected = true;
			if(srvc_value == "5") document.forms[0].srvc_ind.options[3].selected = true;
			if(srvc_value == "7") document.forms[0].srvc_ind.options[4].selected = true;
		}
		else if(val == "2")
		{
			var AddOption4 = new Option("전 체" ,"");
			var AddOption = new Option("보험료수납", "6");
			var AddOption3 = new Option("추가보험료수납", "8");
			var AddOption1 = new Option("약대상환", "2");
			var AddOption2 = new Option("APL상환" ,"3");

			document.forms[0].srvc_ind.length  = 5;
			document.forms[0].srvc_ind.options[0] = AddOption4;
			document.forms[0].srvc_ind.options[1] = AddOption;
			document.forms[0].srvc_ind.options[2] = AddOption3;
			document.forms[0].srvc_ind.options[3] = AddOption1;
			document.forms[0].srvc_ind.options[4] = AddOption2;

			if(srvc_value == "") document.forms[0].srvc_ind.options[0].selected = true;
			if(srvc_value == "6") document.forms[0].srvc_ind.options[1].selected = true;
			if(srvc_value == "8") document.forms[0].srvc_ind.options[2].selected = true;
			if(srvc_value == "2") document.forms[0].srvc_ind.options[3].selected = true;
			if(srvc_value == "3") document.forms[0].srvc_ind.options[4].selected = true;
		}
	}

	/*
	* 아이프레임 높이...
	*/
	function heightControl(object, maxHeight , height) {
			try {
				//if(height < (maxHeight))
					eval( "document.all."+object+".height=height");

				//else eval("document.all."+object+".height=maxHeight");

			} catch(e) {
				alert(e)
			}
	}


	function goSuccess(){

		//alert("스크립트 호출 성공...");

		document.form.method="get" ;
		document.form.submit();


	}



	 function viewPopUp(linkStr,popNameStr,codeDiv){
        // 변액대출시 D+1인건은 경고문구를 보여준다.
        if(codeDiv == "true") {
            alert("변액계약대출건은 접수일기준 2일이후에 처리가능합니다.");
        }

		var frm = document.form1;

		var w = 1000;
		var h = 650;
		x = 10;//(screen.availWidth - w) / 2;
		y = 10;//(screen.availHeight - h) / 2;
		window.open(linkStr, 'popPolicy_'+popNameStr,'width='+w+', height='+h+', left='+x+', top='+y+' , status=no , scrollbars=yes');

	 }

//-->
</script>
<body onLoad="javascript:ReLoadWindow('<%=modeind%>');">
<form name="form" method="post"  action="policy_view.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
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
						<jsp:param name="menu_mode" value="<%=modeind%>"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
						</td>
							<td class="contents"><table width="100%">
							<tr>
<%
						if( srvc_ind.equals("1") || srvc_ind.equals("4") || srvc_ind.equals("5") || srvc_ind.equals("7") )
						{
%>
								<td><img src="/img/common/title_01.gif"></td>
<%
						}else{
%>
								<td><img src="/img/common/title_02.gif"></td>
<%
						}
%>
							</tr>
							<tr>
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr>
								<td height="14"></td>
							</tr>
							<tr>
								<td>
									<table width="100%">
										<tr>
											<td><img src="/img/common/bu_cir01.gif">
												<b>업무처리 기본화면</b></td>
											<td align="right">&nbsp;</td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><table width="100%" class="adm_table">
										<col width=7%><col width=23%><col width=><col width=><col width=><col width=><col width=><col width=25%>
										<tr>
											<th rowspan="2">검색조건</th>
											<th>접수일자</th>
											<th>신청금액</th>
											<th>업무대분류</th>
											<th>업무소분류</th>
											<th>상태</th>
											<th>세부검색항목</th>
											<th>검색입력</th>
										</tr>
										<tr class="adm11">
											<td><input type="text" name="fromdate" class="box02" size="8" maxlength="10" style="text-align:center" value="<%=fromdate%>" readonly>
												<img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  >
												-
												<input type="text" name="todate" class="box02" size="8" maxlength="10" style="text-align:center" value = "<%=todate%>" readonly>
												<img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  >
											</td>
											<td><select name="fromamt"  size="1" style="width:80px;" onChange="">
													  <option value=""  <% if(fromamt.equals("")){ %> selected <% } %>>----</option>
													  <option value="-1"  <% if(fromamt.equals("-1")){ %> selected <% } %>>0</option>
													  <option value="2000000"  <% if(fromamt.equals("2000000")){ %> selected <% } %>>200</option>
													  <option value="10000000"  <% if(fromamt.equals("10000000")){ %> selected <% } %>>1000</option>
												</Select>
												-
											<select name="toamt"  size="1" style="width:80px;" onChange="">
													  <option value=""  <% if(toamt.equals("")){ %> selected <% } %>>----</option>
													  <option value="-1"  <% if(toamt.equals("-1")){ %> selected <% } %>>0</option>
													  <option value="2000000"  <% if(toamt.equals("2000000")){ %> selected <% } %>>200</option>
													  <option value="10000000"  <% if(toamt.equals("10000000")){ %> selected <% } %>>1000</option>
												</Select>
											</td>

											<td><select name="modeind"  size="1" style="width:80px;" onChange="ReLoadWindow(this.value)">
													  <option value="1"  <% if(modeind.equals("1")){ %> selected <% } %>>지급처리</option>
													  <option value="2"  <% if(modeind.equals("2")){ %> selected <% } %>>수납처리</option>
												</Select>
											</td>
											<td>
											<select name="srvc_ind"  size="1" style="width:120px;" >
											</select>
											</td>
											<td><select name="rslt">
												<option value="T"  <% if(rslt.equals("T")){ %> selected <% } %>>전체</option>
												<option value="B"  <% if(rslt.equals("B")){ %> selected <% } %>>접수</option>
												<option value="0"  <% if(rslt.equals("0")){ %> selected <% } %>>성공</option>
												<option value="1"  <% if(rslt.equals("1")){ %> selected <% } %>>반송</option>
												<option value="2"  <% if(rslt.equals("2")){ %> selected <% } %>>실패</option>
												<option value="3"  <% if(rslt.equals("3")){ %> selected <% } %>>지연</option>
												<option value="A"  <% if(rslt.equals("A")){ %> selected <% } %>>처리중</option>
												</select></td>
											<td><select name="search">
													<option value="1"  <% if(search.equals("1")){ %> selected <% } %>>증권번호</option>
													<option value="2"  <% if(search.equals("2")){ %> selected <% } %>>계약자</option>
													<option value="3"  <% if(search.equals("3")){ %> selected <% } %>>주민번호</option>
												</select></td>
											<td>
												<input type="text" name="key" class="box04" value="<%=key%>">
												<a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
												<a href="javascript:goExcel();" ><img src="/img/common/btn_excel.gif" align="absmiddle" border="0"></a>
											</td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>

							<tr>
								<td><b>&nbsp;지연 : <%=count1%> &nbsp;&nbsp;&nbsp;&nbsp;실패 : <%=count2%> &nbsp;&nbsp;&nbsp;&nbsp;처리중 : <%=count3%> &nbsp;&nbsp;&nbsp;&nbsp;접수중 : <%=count4%></b></td>
							</tr>

							<tr>
								<td>


								<div id="excelDiv"><!-- excel 2단계 -->

                      <table width="100%" class="adm_table" style="margin: 0px; ">
                      <col width=4%>
                      <col width=9%>
                      <col width=8%>
                      <col width=10%>
                      <col width=7%>
                      <col width=10%>
                      <col width=10%>
                      <col width=6%>
                      <col width=10%>
                      <col width=9%>
                      <col width=8%>
                      <col width=>
                        <tr>
                          <th>N</th>
                          <th>접수일자</th>
                          <th>접수시간</th>
                          <th>증권번호</th>
                          <th>계약자</th>
                          <th>업무명</th>
                          <th>신청금액</th>
                          <th>상태</th>
                          <th>처리일자</th>
                          <th>처리시간</th>
                          <th>처리자</th>
                          <th>담당LP</th>
                        </tr>
                        <!--/table>
                        <!--div style="overflow: auto; width: 100%; height: 150px;"-->
                        <!--table width="100%" class="adm_table"  style="table-layout: fixed;">
	                       <col width=30>
	                      <col width=75>
	                      <col width=65>
	                      <col width=72>
	                      <col width=58>
	                      <col width=75>
	                      <col width=65>
	                      <col width=40>
	                      <col width=75>
	                      <col width=70>
	                      <col width=60>
	                      <col width=-->
                        <%
										int cnt = policyview.getCount("policy_no");
										if(cnt == 0)
										{
%>
                        <tr class="adm01">
                          <td colspan="12">해당하는 자료가 없습니다.</td>
                        </tr>
                        <%
										}
										else
										{
											int row = 0;
											row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*20;
											for(int i=0;i<cnt;i++)
											{
                                                // 0702255 : 안병훈
                                                String strBackGround = ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8";
                                                String strPlnCode = Util.nvl(policyview.getText("plncode",i));
                                                String strCodeDiv = "false"; // 변액상품의 경우 처리 불가능하게 막음. true : 처리불가능, false : 처리가능
                                                if("".equals(strPlnCode) == false) {
                                                    strPlnCode = strPlnCode.substring(0,2);
                                                }

                                                if("51".equals(strPlnCode) || "53".equals(strPlnCode) || "54".equals(strPlnCode) || "55".equals(strPlnCode) || "56".equals(strPlnCode)) {

                                                    String strTemp = Util.nvl(policyview.getText("comp_2after",i), "0"); // 접수일 기준 2영업일
                                                    if("".equals(strTemp)) strTemp = "0";
                                                    int int2After = Integer.parseInt(strTemp); // 접수일 기준 2영업일
                                                    int intToday = Integer.parseInt(to_year); // 현재 날자

                                                    // 현재 날자가 접수일기준 2영업일 이전이면 처리 불가능. 색깔은 회색
                                                    if(intToday < int2After) {
                                                        strCodeDiv = "true"; // D, D+1 처리 불가 : 접수 당일및 다음날은 처리 불가
                                                        strBackGround = "#DDDDDD";
                                                    // 현재 날자가 D+2영업일이후일 경우 처리 가능. 색깔은 노란색
                                                    }else {
                                                        strCodeDiv = "false"; // D+2 이후 처리가능 : 접수 2영업일 이후로는 처리 가능
                                                        strBackGround = "#FFFF99";
                                                    }

                                                }
%>
                        <tr align="center" bgcolor="<%=strBackGround%>">
                          <%
											String linkcontent = "";
											if(policyview.getText("srvc_cd",i).trim().equals("1"))
											{
												linkcontent = "/payment/pl_payment_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("2"))
											{
												linkcontent = "/receipt/pl_repayment_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("3"))
											{
												linkcontent = "/receipt/apl_payment.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("4"))
											{
												linkcontent = "/payment/dividend_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("5"))
											{
												linkcontent = "/payment/resting_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("6"))
											{
												linkcontent = "/receipt/premium_paid_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("7"))
											{
												linkcontent = "/payment/dividend_setoff_search.do";
											}
											else if(policyview.getText("srvc_cd",i).trim().equals("8"))
											{
												linkcontent = "/receipt/add_premium_paid_search.do";
											}



											String linkStr = ""+linkcontent
																+"?policy_apln_no="+policyview.getText("policy_apln_no",i)
																+"&ssn="+policyview.getText("payor_ssn",i)
																+"&policy="+policyview.getText("policy_no",i)
																+"&searchgubun="+searchgubun
																+"&current="+current
																+"&fromdate="+fromdate
																+"&todate="+todate
																+"&fromamt="+fromamt
																+"&toamt="+toamt
																+"&modeind="+modeind
																+"&srvc_ind="+srvc_ind
																+"&rslt="+rslt
																+"&search="+search
																+"&key="+key;



%>
                          <td ><%=row%></td>
                          <td><%=policyview.getText("apln_dt",i).substring(0,11)%></td>
                          <td><%=policyview.getText("apln_dt",i).substring(11,19)%></td>
                          <td><a href="javascript:viewPopUp('<%=linkStr%>','<%=policyview.getText("policy_no",i)%>', '<%=strCodeDiv%>');" ><b><font color="003cff"><%=policyview.getText("policy_no",i)%></font></b> </a></td>
                          <td><a href="javascript:viewPopUp('<%=linkStr%>','<%=policyview.getText("policy_no",i)%>', '<%=strCodeDiv%>');" ><b><font color="003cff"><%=policyview.getText("payor_nm",i)%></font></b> </a></td>
                          <td><%=policyview.getText("srvc_name",i)%></td>
                          <td><div align="right"><%=Util.addComma(policyview.getText("apln_amt",i))%></div></td>
                          <td><font class=font01><%=policyview.getText("rslt_name",i)%></font></td>
                          <td><%=policyview.getText("proc_dt",i).trim()%></td>
                          <td><%=policyview.getText("proc_tm",i).trim()%></td>
                          <td><%=policyview.getText("emp_nm",i)%></td>
                          <td><%=policyview.getText("lpname",i)%></td>
                        </tr>
                        <%
												row = row - 1;
											}
										}
%>
                      </table>
                      <!--/div-->

								</div><!-- excel 3단계 -->
								</td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
							<tr>
								<td align="center"><table>
										<tr>
											<td width="26"></td>
											<td width="45"> <td align="center">
												<jsp:include page="/common/include/paging.jsp" flush="true">
													<jsp:param name="total" value="<%= totalCount %>"/>
													<jsp:param name="cpage" value="<%= current %>"/>
												</jsp:include>
											</td>
											<td width="30"></td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td height="50">&nbsp;</td>
							</tr>
							<tr>
								<td >

								<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td>
                             <iframe name="act_frame1" width=100% height=0 marginwidth="0" marginheight="0" noresize frameBorder=0 scrolling="no"></iframe>
                             </iframe>
                            </td>
                          </tr>
                        </table></td>
							</tr>
							 <!--  처리 항목 아이프레임 -->

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




<!-- excel 을 보내기위한 target frame-->
<iframe src="" name="excelFrame" width="0" height="0" frameborder="0" ></iframe>



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

<!-- excel 1단계 -->
<form name="excelform" method="post">
<input type="hidden" name="excel">
</form>
<!-- excel 1단계 -->


</body>
</html>

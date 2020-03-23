<%
/**
 * Title       : DropDown
 * Description : 관리자화면의 좌측화면
 * File        : /common/dropDown.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : jung-hun Park
 * First Write : 2005.02.14
 * update date : 
 * update desc :
 *///
%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager,gtone.changeminer.common.utility.Utility" %>

<!--로그인 체크 : S --->            
<%@ include file = "/payment/process_login_first.jsp" %> 
<!--로그인 체크 : E--->
 
<%
	//해당페이지의 구분자 받기
	String menu_mode = request.getParameter("menu_mode") == null? "" : request.getParameter("menu_mode");
	//세션에서 가져오기
	
	String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	String auth_cd2 = sessionManager.getString(Constant.SESSION_LEVEL2);
	
	//권한 체크를 위하여 숫자로 변경.
	int auth_cd_num = 0;
	if(auth_cd.length() !=0 ){
		auth_cd_num = Integer.parseInt(auth_cd);
	}
	
	//20070620 권한 관련 추가...(메뉴에서 화면으로 링크를 막았으나 화면에 들어갔을 경우 처리 하기 위한.. 화면이며... 
	//직접 접근시에는 메인으로 다시오도록 한다.)
	//메뉴를 감추지 않고 사용이 가능하다. 
	//화면별 권한 체크를 위한로직 추가... 
	//request로 체크여부와 체크를 한다면... 권한을 비교하고 아니라면 누구나 통과....

	String menu_num = request.getParameter("menu_num") == null? "" : request.getParameter("menu_num");

	String auth_check_yn = "N"; //기본값 
	int auth_param = 0;
	
	if(menu_num.equals("101")){ 	//약관대출지급  
	}else if(menu_num.equals("102")){ 	//배당금지급     
	}else if(menu_num.equals("103")){ 	//휴면보험금지급     
	}else if(menu_num.equals("104")){ 	//배당금상계지급
	}else if(menu_num.equals("201")){ 	//보험료수납     
	}else if(menu_num.equals("202")){ 	//추가보험료수납     
	}else if(menu_num.equals("203")){ 	//약관대출상환     
	}else if(menu_num.equals("204")){ 	//APL상환
	}else if(menu_num.equals("401")){ 	//APL신청    
	}else if(menu_num.equals("402")){ 	//APL해지
	}else if(menu_num.equals("501")){ 	//처리상태변경
	}else if(menu_num.equals("502")){ 	//SMS관리
		auth_check_yn = "Y";
		auth_param 	= 31;
	}else if(menu_num.equals("503")){ 	//웹회원관리
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("504")){ 	//로그인관리
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("505")){ 	//입출금관리
		auth_check_yn = "Y";
		auth_param 	= 31;
	}else if(menu_num.equals("601")){ 	//지급내역보고서
	}else if(menu_num.equals("602")){ 	//수납내역보고서
	}else if(menu_num.equals("701")){ 	//반송사유관리
	}else if(menu_num.equals("702")){ 	//반송처리리스트
	}else if(menu_num.equals("801")){ 	//모니터링(일반)
	}else if(menu_num.equals("802")){ 	//모니터링(증명서우편발급)
	}else if(menu_num.equals("803")){ 	//모니터링(증명서화면조회)
	}else if(menu_num.equals("804")){ 	//모니터링(증명서화면출력)
	}else if(menu_num.equals("805")){ 	//모니터링(보험증권재발행)
	}else if(menu_num.equals("806")){ 	//모니터링(부활)
	}else if(menu_num.equals("807")){ 	//개별처리
	}else if(menu_num.equals("901")){ 	//추첨하기
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("902")){ 	//통계자료
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("1001")){ 	//WORKINGDAY관리
		auth_check_yn = "Y";
		auth_param 	= 31;
	}else if(menu_num.equals("1101")){ 	//권한관리
	}else if(menu_num.equals("1201")){ 	//Cyber Index
	}else if(menu_num.equals("1301")){ 	//청약 철회
	}else if(menu_num.equals("1401")){ 	//SMS발송이력
	}
	
	
	String fromdate2before = Utility.addDay(-2);//현재일의 2일전
	String fromdate = Utility.addDay(-1);//현재일의 하루전
	String todate = Utility.addDay(0);//오늘 현재일
	
	String todaydate = todate;
	String toYear = todaydate.substring(0,4);
	String toDay = todaydate.substring(4,6);
	
	

	//2006.03.22 유섭교 0600069 Cyberadmin 기능개선
	
	String tempStr = "";
	String tempUser = "";
	if (auth_cd.equals("31")) {
		//tempStr = "&fromamt=-1&toamt=2000000";
		tempStr = "&fromamt=&toamt=2000000";
		tempUser = "1차결재자";
	} else if (auth_cd.equals("32")) {
		//tempStr = "&fromamt=2000000&toamt=10000000";
		tempStr = "&fromamt=&toamt=10000000";
		tempUser = "2차결재자";
	} else if (auth_cd.equals("33")) {
		//tempStr = "&fromamt=2000000&toamt=10000000";
		tempStr = "&fromamt=&toamt=10000000";
		tempUser = "3차결재자";
	} else if (auth_cd.equals("40")) {
		tempUser = "Admin";
	} else if (auth_cd.equals("20")) {
		tempUser = "상담원";
	} else if (auth_cd.equals("10")) {
		tempUser = "조회";
	} else if (auth_cd.equals("90")) {
		tempUser = "청약철회관리자";
	}
	
	String sunap = "&fromamt=&toamt=";
	
	//tempStr = "&fromamt=-1&toamt=10000000";
%>
<br><b>[ <%=emp_nm%> ]</b>님께서<br>로그인하셨습니다.
<br><b>(<%=tempUser%>)</b>
<br><br>
<script language="javascript">
<!--  
<%  //권한체크가 Y일때 파람으로 받은 권한자와.. 권한자 코드 가 같은지 체크...
	if(auth_check_yn.equals("Y")){

		if(auth_param>auth_cd_num){
%>		
			alert("접근 권한이 없는 페이지입니다.");		
			location.href="/payment/admin_main.do";
<%		
		}
		

	}
%>


	try{
	
		var menuidTemp = parent.TopFrame.frameHidden.menuidTemp.value;
		
	}catch(e){   
	
		alert("올바른 접근이 아닙니다.");
		location.href = "/index.jsp";
		
	}


//-->
</script>
<script language='javascript' src='../../common/js/menu_on.js'></script>


	
<img src="../../img/common/menu_side.gif" width="155" height="64" border="0" usemap="#Map"> 
<map name="Map">
  <area shape="rect" coords="1,9,160,30" href="/payment/admin_main.do" onFocus="blur();">
  <area shape="rect" coords="0,36,160,57" href="javascript:goLink('logout')" onFocus="blur();">
</map>

<table width="100%">

<!--지급처리 : S-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("11")){ %> <!-- 상담원이고 B인경우 메뉴 보이지 않음 -->
<tr id=subMenuBlock1 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(1,'#')" onFocus="blur()">지급처리</a></td>
	</tr>
	<tr id=subMenuBlock1 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">

			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=1&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate2before%>&todate=<%=todate%>','101')" onFocus="blur()">약관대출지급</a></div>
			<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=4&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate%>&todate=<%=todate%>','102')" onFocus="blur()">배당금지급</a></div>
			<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=5&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate%>&todate=<%=todate%>','103')" onFocus="blur()">휴면보험금지급</a></div>
			<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=7&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate%>&todate=<%=todate%>','104')" onFocus="blur()">배당금상계지급</a></div></th>
			</th>
	</tr>
<%}%>

<!--수납처리 : S-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("00")){ %> <!-- 상담원이고 A인경우 메뉴 보이지 않음 -->
<tr id=subMenuBlock2 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(2,'#')" onFocus="blur()">수납처리</a></td>
	</tr>
	<tr id=subMenuBlock2 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=2&srvc_ind=6&searchgubun=S<%=sunap%>&fromdate=<%=fromdate%>&todate=<%=todate%>','201')" onFocus="blur()">보험료수납</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=2&srvc_ind=8&searchgubun=S<%=sunap%>&fromdate=<%=fromdate%>&todate=<%=todate%>','202')" onFocus="blur()">추가보험료수납</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=2&srvc_ind=2&rslt=T&search=1&key=<%=sunap%>','203')" onFocus="blur()">약관대출상환</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=2&srvc_ind=3&rslt=T&search=1&key=<%=sunap%>','204')" onFocus="blur()">APL상환</a></div>
				</th>
	</tr>
<% } %>
	
<!-- 자동이체처리 : S--><!-- 추가 2007.05.23-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("00")){ %> <!-- 상담원이고 A인경우 메뉴 보이지 않음 -->
<tr id=subMenuBlock8 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(8,'#')" onFocus="blur()">자동이체처리</a></td>
	</tr>
	<tr id=subMenuBlock8 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=8&srvc_ind=B','301')" onFocus="blur()">자동이체변경</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=8&srvc_ind=C','302')" onFocus="blur()">자동이체해지</a></div>
				</th>
	</tr>
<% } %>

<!-- 계약변경처리 : S--><!-- 추가 2007.05.23-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("11")){ %> <!-- 상담원이고 B인경우 메뉴 보이지 않음 -->
<tr id=subMenuBlock9 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(9,'#')" onFocus="blur()">계약변경처리</a></td>
	</tr>
	<tr id=subMenuBlock9 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=9&srvc_ind=I','401')" onFocus="blur()">APL신청</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=9&srvc_ind=J','402')" onFocus="blur()">APL해지</a></div>
				</th>
	</tr>
	
<%}%>
<!--기타 : S-->
	<tr>  
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(3,'#')" onFocus="blur()">기타</a></td>
	</tr>
	<tr id=subMenuBlock3 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'>  
		<th>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/status_chg_list.do?searchgubun=S&current=1&fromdate=&todate=&rslt=T&search=1&key=','501')" onFocus="blur()">처리상태변경</a></div>
				
				<%if(auth_cd_num>=31){ %>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/smslp_manager.do','502')" onFocus="blur()">SMS관리</a></div>   
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/member_list.do?run=list','503')" onFocus="blur()">웹회원관리</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/login_manager.do','504')" onFocus="blur()">로그인관리</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/inout_manager.do','505')" onFocus="blur()">입출금관리</a></div>
				<%}%>
				</th>
	</tr>
	

<!--일마감 : S-->		
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(4,'#')" onFocus="blur()">일마감</a></td>
	</tr>
	<tr id=subMenuBlock4 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/report/pay_proc_report.do','601')" onFocus="blur()">지급내역보고서</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/report/rec_proc_report.do','602')" onFocus="blur()">수납내역보고서</a></div>
				
				</th>
	</tr>
	

<!--반송관리 : S-->
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(5,'#')" onFocus="blur()">반송관리</a></td>
	</tr>
	<tr id=subMenuBlock5 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/return_manager.do','701')" onFocus="blur()">반송사유관리</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/payment/policy_return.do?searchgubun=S&fromdate=&todate=&fromdate2=&todate2=&srvc_ind=0&search=1&key=','702')" onFocus="blur()">반송처리리스트</a></div>
				</th>
	</tr>
	
	
<!--모티터링 : S-->
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(6,'#')" onFocus="blur()">모니터링</a></td>
	</tr>
	<tr id=subMenuBlock6 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_realtime.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=Z&search=1&key=&rslt=A','801')" onFocus="blur()">모니터링(일반)</a></div>
				
<!--명칭변경:모니터링(증명서)->모니터링(증명서우편발급)-->				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_proof.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1&key=','802')" onFocus="blur()">모니터링<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(증명서우편발급)</a></div>
				
<!--추가:모니터링(증명서화면조회)-->				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_proof_search.do?searchgubun=S&current=1&fromdate=&todate=&useind=&modeind=&srvc_ind=&search=1&key=','803')" onFocus="blur()">모니터링<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(증명서화면조회)</a></div>
				
<!--추가:모니터링(증명서화면출력)-->				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_proof_print.do?searchgubun=S&current=1&fromdate=&todate=&useind=&modeind=&srvc_ind=&search=1&key=','804')" onFocus="blur()">모니터링<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(증명서화면출력)</a></div>
				
<!--메뉴변경:기타->모니터링///명칭변경:보험증권재발행->모니터링(보험증권재발행)-->					
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_reissue.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&search=1&key=','805')" onFocus="blur()">모니터링<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(보험증권재발행)</a></div>
				
				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_resurr.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1&key=','806')" onFocus="blur()">모니터링(부활)</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do','807')" onFocus="blur()">개별처리</a></div>
				</th>
	</tr>
	<%if(auth_cd_num>=31){ %>
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(7,'#')" onFocus="blur()">사이버센터이벤트</a></td>
	</tr>
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/common/event/event_prize.do?run=list','901')" onFocus="blur()">추첨하기</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/common/event/event_stat.do?run=list','902')" onFocus="blur()">통계자료</a></div>
				</th>
	</tr>
	<%}else{%>
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th></th>
	</tr>

	<%}%>

	
	
	

	
	
	
	<%if(auth_cd_num>=31){ %>
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/receipt/schedule.do?run=view','1001')" onFocus="blur()">WORKINGDAY관리</a></td>
	</tr>		
	<%}%>
		
<!--WORKINGDAY관리 : S-->

	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/receipt/auth_manager.do','1101')" onFocus="blur()">권한관리</a></td>
	</tr>
	

<!--Cyber Index : S-->
	<tr>
		<td>
			<img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/common/cyber_index.do?run=list','1201')" onFocus="blur()">Cyber Index</a>
		</td>
	</tr>
<!--Event : S-->

<!--청약 철회 : S-->
	<tr>
		<td>
			<img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/withdrawal/withdrawal.do','1301')" onFocus="blur()">청약 철회</a>
		</td>
	</tr>
	
<!--SMS발송이력 : S-->
	<tr>
		<td>
			<img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/withdrawal/sms_log_list.do?fromDate1=<%=toYear%>&fromDate2=<%=toDay%>','1401')" onFocus="blur()">SMS발송이력</a>
		</td>
	</tr>	
	
	
	<!-- 통계기준메뉴 만들다가 중단 2006.06.14 tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(8,'#')" onFocus="blur()">Cyber Index</a></td>
	</tr>							
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'>
		<th>
		<div class="mn">
			<img src="../../img/common/menu02.gif" hspace="8"><a href="/common/cyber_index.do?run=list" onFocus="blur()">Cyber Index</a>
		</div>
		<div class="mn">
			<img src="../../img/common/menu02.gif" hspace="8"><a href="javascript:" onFocus="blur()">통계기준관리</a>
		</div>
		</th>		
	</tr-->							

	<!--<tr>
		<td><img src="../../img/common/menu01.gif" hspace="7"><a href="javascript:choiceMenu(7,'#')" onFocus="blur()">WORKINGDAY관리</a></td>
	</tr>							
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="7">
				<a href="/receipt/schedule.do?run=view" onFocus="blur()">WORKINGDAY관리</a></div>
				</th>
	</tr>-->
</table>


<SCRIPT language=javascript>
<!--




	function choiceMenu(intChoiceMenu)
	{
		var thisForm = self.document.forms[0];
		for(var idxLoop=1; idxLoop<10; idxLoop++){
			var objSubMenuBlock = eval('document.all.subMenuBlock'+idxLoop);
			var objMainMenuImg = eval('document.all.Image'+idxLoop);
			
			if (intChoiceMenu == idxLoop)
			{
				if (objSubMenuBlock.style.display == 'block')
				{ 
					objSubMenuBlock.style.display = 'none'; 
				}
				else
				{
					objSubMenuBlock.style.display = 'block';
				}
			}
			else
			{
				objSubMenuBlock.style.display = 'none'; 
			}
		}
	}
	
	var menu_mode = "<%=menu_mode%>";
	if( menu_mode == "1" )
	{
		choiceMenu(1,'#');
	}
	else if( menu_mode == "2" )
	{
		choiceMenu(2,'#');
	}
	else if( menu_mode == "3" )
	{
		choiceMenu(3,'#');
	}
	else if( menu_mode == "4" )
	{
		choiceMenu(4,'#');
	}
	else if( menu_mode == "5" )
	{
		choiceMenu(5,'#');
	}
	else if( menu_mode == "6" )
	{
		choiceMenu(6,'#');
	}
	
	else if( menu_mode == "7" )
	{
		choiceMenu(7,'#');
	}
	else if( menu_mode == "8" )
	{
		choiceMenu(8,'#');
	}
	else if( menu_mode == "9" )
	{
		choiceMenu(9,'#');
	}
	else
	{
		choiceMenu(0,'#');
	}

	


//-->
</SCRIPT>


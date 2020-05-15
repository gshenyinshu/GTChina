<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr" buffer="80k"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>
<%@ page import = "gtone.changeminer.common.utility.Variable" %>
<%@ page import = "gtone.changeminer.common.utility.FormatUtil" %>


<jsp:useBean id="pub_stat" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="list1" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="list2" class="anyframe.data.DataSet" scope="request"/>

<!-- form -->
<jsp:useBean    id="form"      class="gtone.changeminer.common.form.CyberIndexForm" scope="request"/>                

<%


	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);

	String pruhome = Variable.get("pruhome.url");

	//메뉴별 링크 처리
	//고객정보변경
	//<a href="/receipt/policy_indiv.do?
	//current=1
	//searchgubun=S
	//srvc_gubun=A
	//status=0
	
//	">
	
try {
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv=Cache-Control content=No-Cache> 
<meta http-equiv=Pragma content=No-Cache> 

<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>
<script language='javascript' src='/common/js/cyber_index.js'></script>
</head>
<script language="javascript">
<!--
//현재월을 계산해서 상세메뉴로 이동시 기간까지 전송이 될수 있도록 한다.

	var date_string="";
	var fromdate = "";
	var todate   = "";
<% if(form.getTermDiv().equals("1")) { 
	//일자별 검색일 경우
%>
	fromdate = "<%=form.getFromDate()%>";
	todate   = "<%=form.getToDate()%>";
<% }else if(form.getTermDiv().equals("2")) { 
	//월별 검색일 경우
%>
	fromdate = "<%=form.getFromDate()%>";
	fromdate      = fromdate.substring(0,6)+"01";
	
 	todate   = "<%=form.getToDate()%>";
	var toMonth1 = todate.substring(4,6);
	todate       = todate.substring(0,6);
	//시작날짜에는 01이 붙으면 되지만
	//끝날짜에는 28, 29, 30, 31 이 경우에 따라서 붙어야 한다.
	
	if(toMonth1=="01" || toMonth1=="03" || toMonth1=="05" || toMonth1=="07" ||
					toMonth1=="09" || toMonth1=="10" || toMonth1=="12" ){
				todate = todate + "31";
	}else if(toMonth1=="04" || toMonth1=="06" || toMonth1=="08" || toMonth1=="11" ){
		todate = todate + "30";
	}else if(toMonth1=="02" ){
		if ((parseInt(toYear1) % 400 == 0) 
				|| ((parseInt(toYear1) % 100 != 0) 
					&& (parseInt(toYear1) % 4 == 0))) 
			todate = todate + "29";
		else
			todate = todate + "28";
	}
<%
	}else if(form.getTermDiv().equals("4")) { 
	//분기별 검색일 경우
%>
	if("1" == "<%=form.getQuater()%>"){
		fromdate = "<%=form.getYear()%>"+"0101";
		todate   = "<%=form.getYear()%>"+"0331";
	}else if("2" == "<%=form.getQuater()%>"){
		fromdate = "<%=form.getYear()%>"+"0401";
		todate   = "<%=form.getYear()%>"+"0630";
	}else if("3" == "<%=form.getQuater()%>"){
		fromdate = "<%=form.getYear()%>"+"0701";
		todate   = "<%=form.getYear()%>"+"0930";
	}else if("4" == "<%=form.getQuater()%>"){
		fromdate = "<%=form.getYear()%>"+"1001";
		todate   = "<%=form.getYear()%>"+"1231";
	}	
<%	
	}else if(form.getTermDiv().equals("3")) { 
	//년도별 검색일 경우
%>
	fromdate = "<%=form.getYear()%>"+"0101";
 	todate   = "<%=form.getYear()%>"+"1231";
<%	
	}
%>
	date_string="&fromdate="+fromdate+"&todate="+todate;


	function link_func(seq){
		//일반메뉴 선택시 조건은 모두 15개
		if(seq == '고객정보변경'){
			location.href="/receipt/policy_indiv.do";
		}else if(seq == 'APL신청'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=T&srvc_ind=I&search=1";
		}else if(seq == 'APL해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=T&srvc_ind=J&search=1";
		}else if(seq == '자동이체변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=T&srvc_ind=B&search=1";
		}else if(seq == '자동이체해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=T&srvc_ind=C&search=1";
		}else if(seq == '약대지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=1&rslt=T&search=1";
		}else if(seq == '배당금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=4&rslt=T&search=1";
		}else if(seq == '배당금상계지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=7&rslt=T&search=1";
		}else if(seq == '휴면보험금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=5&rslt=T&search=1";
		}else if(seq == '보험료수납'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=6&rslt=T&search=1";
		}else if(seq == '약대상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=2&rslt=T&search=1";
		}else if(seq == 'APL상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=3&rslt=T&search=1";
		}else if(seq == '증권재발행'){
			location.href="/receipt/policy_reissue.do?searchgubun=S&current=1&todate2=&srvc_ind=all&search=1";
		}else if(seq == '증명서발급'){
			location.href='/monitor/monitering_proof.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1';
		}else if(seq == 'CCK'){
			window.open("http://<%=pruhome%>/cck/index.cck","","left=0,top=0,width=1024,height=768,resizable=yes,scrollbars=yes,status=yes;");
		}
	}
		
	function success_func(seq){
		//성공 조건은 모두 15개
		if(seq == '고객정보변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_gubun=A&status=0"+date_string;
		}else if(seq == 'APL신청'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=0&srvc_ind=I&search=1"+date_string;
		}else if(seq == 'APL해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=0&srvc_ind=J&search=1"+date_string;
		}else if(seq == '자동이체변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=0&srvc_ind=B&search=1"+date_string;
		}else if(seq == '자동이체해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&status=0&srvc_ind=C&search=1"+date_string;
		}else if(seq == '약대지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=1&rslt=0&search=1"+date_string;
		}else if(seq == '배당금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=4&rslt=0&search=1"+date_string;
		}else if(seq == '배당금상계지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=7&rslt=0&search=1"+date_string;
		}else if(seq == '휴면보험금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=5&rslt=0&search=1"+date_string;
		}else if(seq == '보험료수납'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=6&rslt=0&search=1"+date_string;
		}else if(seq == '약대상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=2&rslt=0&search=1"+date_string;
		}else if(seq == 'APL상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=3&rslt=0&search=1"+date_string;
		}else if(seq == '증권재발행'){
			location.href="/receipt/policy_reissue.do?searchgubun=S&current=1&todate2=&srvc_ind=2&search=1"+date_string;
		}else if(seq == '증명서발급'){
			location.href='/monitor/monitering_proof.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1'+date_string;
		}else if(seq == 'CCK'){
			window.open("http://<%=pruhome%>/cck/index.cck","","left=0,top=0,width=1024,height=768,resizable=yes,scrollbars=yes,status=yes;");
		}
	}

	function process_func(seq){
		//처리 조건은 모두 7개
		if(seq == '약대지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=1&rslt=A&search=1"+date_string;
		}else if(seq == '배당금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=4&rslt=A&search=1"+date_string;
		}else if(seq == '배당금상계지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=7&rslt=A&search=1"+date_string;
		}else if(seq == '휴면보험금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=5&rslt=A&search=1"+date_string;
		}else if(seq == '보험료수납'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=6&rslt=A&search=1"+date_string;
		}else if(seq == '약대상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=2&rslt=A&search=1"+date_string;
		}else if(seq == 'APL상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=3&rslt=A&search=1"+date_string;
		}else if(seq == '증권재발행'){
			location.href="/receipt/policy_reissue.do?searchgubun=S&current=1&todate2=&srvc_ind=1&search=1"+date_string;
		}else if(seq == 'CCK'){
			window.open("http://<%=pruhome%>/cck/index.cck","","left=0,top=0,width=1024,height=768,resizable=yes,scrollbars=yes,status=yes;");
		}
	}

	function regist_func(seq){
		//접수 조건은 모두 13개
		if(seq == '약대지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=1&rslt=B&search=1"+date_string;
		}else if(seq == '배당금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=4&rslt=B&search=1"+date_string;
		}else if(seq == '배당금상계지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=7&rslt=B&search=1"+date_string;
		}else if(seq == '휴면보험금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=5&rslt=B&search=1"+date_string;
		}else if(seq == '보험료수납'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=6&rslt=B&search=1"+date_string;
		}else if(seq == '약대상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=2&rslt=B&search=1"+date_string;
		}else if(seq == 'APL상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=3&rslt=B&search=1"+date_string;
		}else if(seq == '고객정보변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=A&status=R&search=1"+date_string;
		}else if(seq == 'APL신청'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=I&status=R&search=1"+date_string;
		}else if(seq == 'APL해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=J&status=R&search=1"+date_string;
		}else if(seq == '자동이체변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=B&status=R&search=1"+date_string;
		}else if(seq == '자동이체해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=C&status=R&search=1"+date_string;
		}else if(seq == '증권재발행'){
			location.href="/receipt/policy_reissue.do?searchgubun=S&current=1&todate2=&srvc_ind=0&search=1"+date_string;
		}else if(seq == 'CCK'){
			window.open("http://<%=pruhome%>/cck/index.cck","","left=0,top=0,width=1024,height=768,resizable=yes,scrollbars=yes,status=yes;");
		}
	}
	function fault_func (seq){
		//실패 조건은 모두 12개
		if(seq == '약대지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=1&rslt=2&search=1"+date_string;
		}else if(seq == '배당금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=4&rslt=2&search=1"+date_string;
		}else if(seq == '배당금상계지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=7&rslt=2&search=1"+date_string;
		}else if(seq == '휴면보험금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=5&rslt=2&search=1"+date_string;
		}else if(seq == '보험료수납'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=6&rslt=2&search=1"+date_string;
		}else if(seq == '약대상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=2&rslt=2&search=1"+date_string;
		}else if(seq == 'APL상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=3&rslt=2&search=1"+date_string;
		}else if(seq == '고객정보변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=A&status=2&search=1"+date_string;
		}else if(seq == 'APL신청'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=I&status=2&search=1"+date_string;
		}else if(seq == 'APL해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=J&status=2&search=1"+date_string;
		}else if(seq == '자동이체변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=B&status=2&search=1"+date_string;
		}else if(seq == '자동이체해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=C&status=2&search=1"+date_string;
		}else if(seq == 'CCK'){
			window.open("http://<%=pruhome%>/cck/index.cck","","left=0,top=0,width=1024,height=768,resizable=yes,scrollbars=yes,status=yes;");
		}
	}
	function wait_func  (seq){
		//지연 조건은 모두 7개
		if(seq == '약대지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=1&rslt=3&search=1"+date_string;
		}else if(seq == '배당금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=4&rslt=3&search=1"+date_string;
		}else if(seq == '배당금상계지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=7&rslt=3&search=1"+date_string;
		}else if(seq == '휴면보험금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=5&rslt=3&search=1"+date_string;
		}else if(seq == '보험료수납'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=6&rslt=3&search=1"+date_string;
		}else if(seq == '약대상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=2&rslt=3&search=1"+date_string;
		}else if(seq == 'APL상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=3&rslt=3&search=1"+date_string;
		}else if(seq == 'CCK'){
			window.open("http://<%=pruhome%>/cck/index.cck","","left=0,top=0,width=1024,height=768,resizable=yes,scrollbars=yes,status=yes;");
		}
	}
	function return_func(seq){
		//반송 조건은 모두 13개
		if(seq == '약대지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=1&rslt=1&search=1"+date_string;
		}else if(seq == '배당금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=4&rslt=1&search=1"+date_string;
		}else if(seq == '배당금상계지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=7&rslt=1&search=1"+date_string;
		}else if(seq == '휴면보험금지급'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&toamt=10000000&modeind=1&srvc_ind=5&rslt=1&search=1"+date_string;
		}else if(seq == '보험료수납'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=6&rslt=1&search=1"+date_string;
		}else if(seq == '약대상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=2&rslt=1&search=1"+date_string;
		}else if(seq == 'APL상환'){
			location.href="/receipt/policy_view.do?searchgubun=S&current=1&&modeind=2&srvc_ind=3&rslt=1&search=1"+date_string;
		}else if(seq == '고객정보변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=A&status=3&search=1"+date_string;
		}else if(seq == 'APL신청'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=I&status=3&search=1"+date_string;
		}else if(seq == 'APL해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=J&status=3&search=1"+date_string;
		}else if(seq == '자동이체변경'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=B&status=3&search=1"+date_string;
		}else if(seq == '자동이체해지'){
			location.href="/receipt/policy_indiv.do?current=1&searchgubun=S&srvc_ind=C&status=3&search=1"+date_string;
		}else if(seq == '증권재발행'){
			location.href="/receipt/policy_reissue.do?searchgubun=S&current=1&todate2=&srvc_ind=3&search=1"+date_string;
		}else if(seq == 'CCK'){
			window.open("http://<%=pruhome%>/cck/index.cck","","left=0,top=0,width=1024,height=768,resizable=yes,scrollbars=yes,status=yes;");
		}
	}
	

	function write_func(){
		if(MemberF.cause.value == ""){
			alert("특이사항을 입력해 주세요");		
			MemberF.cause.focus();
		}else if(MemberF.createdate.value ==""){
			alert("날짜를 선택해 주세요");		
			MemberF.createdate.focus();
		}else{
			MemberF.action="/common/cyber_index.do";
			MemberF.submit() ;
		}
	}
	
	function search_func(){
		window.open("/common/cyber_index.do?run=cause","","left=200,top=100,width=300,height=340,resizable=yes,scrollbars=yes,status=no;");
	}

    function create(){
        var f = document.myform ;
        f.bypass.value = 1;
        f.method.value = "create";
    	var popup = window.open("about:blank", "CreatMemoWindow", "width=442, height=470, status=no, toolbar=no, menubar=no, location=no, resizable=no, scrollbars=no");
        f.target	= "CreatMemoWindow";
        f.action    = "/lphome/admin/memo.do" ;
        f.submit() ;
        f.target    = "";
    } 	
	
//-->
</script>
<body>

<form name=MemberF action='' >
<input type="hidden" name="current" value=<%=form.getCurrent()%>>
<input type=hidden name='toDate'    value='<%=form.getToDate()%>'>
<input type=hidden name='fromDate'  value='<%=form.getFromDate()%>'>
<input type=hidden name='year'  value='<%=form.getYear()%>'>
<input type=hidden name='quatertoDate'    value='<%=form.getQuatertoDate()%>'>
<input type=hidden name='quaterfromDate'  value='<%=form.getQuaterfromDate()%>'>
<input type="hidden" name="quater" value='<%=form.getQuater()%>'>
<input type="hidden" name="flag" value='I'>
<input type="hidden" name="run" value='list'>

<table width="100%" height="100%">
	<tr> 
	<td height=71>
		<table width="100%" background="/img/common/logo_bg.gif">
			<tr> 
			<td><img src="/img/common/logo.gif"></td>
			<td align="right"><img src="/img/common/logo_end.gif"></td>
			</tr>
		</table>
	</td>
	</tr>
	<tr> 
	<td>
		<table width=100% height="100%">
		<col width=200> 
		<tr> 
		<td align="center" class="menu">
		<!--DropDown 삽입 : S-->
		<jsp:include page="/common/dropDown.jsp" flush="true">
		<jsp:param name="menu_mode" value=""/>
		</jsp:include>
		<!--DropDown 삽입 : E-->
		</td>
		<td class="contents">
			
			<table width="100%">
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
				<td>
					<table width="100%">
						<tr> 
						<td><img src="/img/common/bu_cir01.gif"> 
							<b>Cyber Index</b>
						</td>
						<td align="right"></td>
						</tr>
					</table>
				</td>
				</tr>
				<tr> 
					<td>&nbsp;</td>
				</tr>
				<tr> 								
				<td>
					<table cellpadding="0" cellspacing="0" border="0">
						<tr> 
						<td>
							<table  width="700" border="1">
								<tr> 
								<th colspan="4" align="left" style="padding-left:20px">
									<SELECT NAME="termDiv" style="width:100px" onChange="showDate(this.value)">
										<option value="1"<%=form.getTermDiv().equals("1")?" selected":""%>>일별</option>
										<option value="2"<%=form.getTermDiv().equals("2")?" selected":""%>>월별</option>
										<option value="4"<%=form.getTermDiv().equals("4")?" selected":""%>>분기별</option>
										<option value="3"<%=form.getTermDiv().equals("3")?" selected":""%>>년도별</option>
									</SELECT>
									<span style="display:none" id="calDailyForm">
										<select name="fromDate1"  onChange="setDate(this.form.fromDate1,this.form.fromDate2,this.form.fromDate3)">
			<%				int year  = Calendar.getInstance().get(Calendar.YEAR) ;

							int month = Calendar.getInstance().get(Calendar.MONTH) + 1 ;
							for(int i=2005; i<=year+2; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 년
										<select name="fromDate2" onChange="setDate(this.form.fromDate1,this.form.fromDate2,this.form.fromDate3)">
			<%				for(int i=1; i<=12 ; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 월
										<select name="fromDate3">
										</select> 일 ~
										<select name="toDate1"  onChange="setDate(this.form.toDate1,this.form.toDate2,this.form.toDate3)">
			<%				for(int i=2005; i<=year+2; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 년
										<select name="toDate2" onChange="setDate(this.form.toDate1,this.form.toDate2,this.form.toDate3)">
			<%				for(int i=1; i<=12 ; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 월
										<select name="toDate3">
										</select> 일
									</span>
									
									<span style="display:none" id="calMonthlyForm">
										<select name="fromMDate1">
			<%				for(int i=2005; i<=year+2; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 년
										<select name="fromMDate2">
			<%				for(int i=1; i<=12 ; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 월
										~
										<select name="toMDate1">
			<%				for(int i=2005; i<=year+2; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 년
										<select name="toMDate2">
			<%				for(int i=1; i<=12 ; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 월
									</span>
									
									<span style="display:none" id="calYearlyForm">
										<select name="fromYDate1">
			<%				for(int i=2005; i<=year+2; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 년
										
									</span>	
									
							<span style="display:none" id="calQuaterForm">
										<select name="quaters" onChange="quaterFunc(this.value);">
			<%				for(int i=1; i<=4; i++){%>
											<option value="<%=i%>"><%=i%></option>
			<%				}%>
										</select> 분기
										
									</span>	
								<!--select name="confrim_process">
									<option value="" <% if(form.getConfrim_process().equals("")){ %> selected <% } %>>-전체보기-</option>
									<option value="login" <% if(form.getConfrim_process().equals("login")){ %> selected <% } %>>Login</option>
									<option value="confirm" <% if(form.getConfrim_process().equals("confirm")){ %> selected <% } %>>Confirm</option>
								</select-->																
								</th>
								</tr>
							</table>
						</td>
						<td width="150" align="left" style="padding:8 0 0 5px" valign="top">
							
							<img src="/img/common/btn_search.gif" align="absmiddle" onClick="javascript:logMailCall('list');" style="cursor:hand;" >
							<img src="/img/common/btn_excel.gif" align="absmiddle" onClick="javascript:goExcel_ext();" style="cursor:hand;" >	
						</td>
						<td width="250"></td>
						</tr>
					</table>										
				</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr> 
				<td><div id="excelDiv3">
					<table width="400" class="adm_table">
						<tr>
						<th width="100" rowspan="2">총 접속자수</th>
						<th width="100" rowspan="2">Log-In</th>
						<th width="100" rowspan="2">Confirm</th>
						<th width="450" colspan="3">고객등록</th>
						</tr>
						<tr>
						<th width="150">계약자</th>
						<th width="150">보험대상자</th>
						<th width="150">합계</th>
						</tr>
						
						<%//if(!"".equals(pub_stat.getText("totol_count"))   ){ %>
						<tr>
						<td><%=pub_stat.getInt("totol_count")%></td>
						<td><%=pub_stat.getInt("Log_In")%></td>
						<td><%=pub_stat.getInt("Confirm")%></td>
						<td><%=pub_stat.getInt("owner_cnt")%></td>
						<td><%=pub_stat.getInt("insurant_cnt")%></td>
						<td><%=pub_stat.getInt("tot_count")%></td>
						</tr>
						<%//}else{%>
						<!--tr class="adm01"> 
						<td colspan="6">해당하는 자료가 없습니다.</td>
						</tr-->
						<%//}%>
					</table>
					</div>
				</td>
				</tr>
				<tr> 
				<td>
					<div id="excelDiv"><!-- excel 2단계 -->
					<table width="100%" class="adm_table">
						<tr> 
						<th>항목</th>
						<th>총건수</th>
						<th>총금액(일원)</th>
						<th>성공</th>
						<th>처리중</th>
						<th>접수</th>
						<th>실패</th>
						<th>지연</th>
						<th>반송</th>
						<th>처리율</th>
						<th>S/L</th>
						<th>AHT</th>
						</tr>
	<%
							int cnt = list1.getCount("item");
							
							
							if(cnt == 0) {
	%>
									<tr class="adm01"> 
									  <td colspan="12">해당하는 자료가 없습니다.</td>
									</tr>										
	<%											
							} else {
							
							
								int total=0;
								long total_cost = 0;
								int success=0;
								int process=0;
								int regist =0;
								int fault  =0;
								int wait   =0;
								int returns =0;
								float success_count = 0f;
								float service_percent = 0f;
								int time_average=0;
								
								int parent = 0;
								
								//소계 계산....
								for(int j=0;j<cnt;j++) {
								

											total += Integer.parseInt(list1.getText("total",j));
											
											total_cost += Long.parseLong(list1.getText("total_cost",j));
											
	
											success += Integer.parseInt(list1.getText("success",j));
											
										
											
											process += Integer.parseInt(list1.getText("process",j));
											regist += Integer.parseInt(list1.getText("regist",j));
											fault  += Integer.parseInt(list1.getText("fault",j));
											wait   += Integer.parseInt(list1.getText("wait",j));
											returns += Integer.parseInt(list1.getText("return",j));
											success_count += Float.parseFloat(list1.getText("success_count",j));
											service_percent += Float.parseFloat(list1.getText("service_percent",j));
											
											//""으로 비교하는 이유는 2007년 또는 그 후 없는데이터 호출시 자료값에서 null이 보여서 
											//아래와 같이 처리했음. 또 한가지 알아야 할점은 로그상에서는 자료가 없어도 null로 보이는 반면
											//실제 소스에서 비교해야 할때는 ""(공백)으로 비교해야 한다.
					
											if("".equals(list1.getText("time_average",j).trim() ) ){
												time_average = time_average+ 0;
											}else{
												time_average = time_average+ Integer.parseInt(list1.getText("time_average",j));
											}
						
											//System.out.println(time_average );
											parent++;
								
								
								}
								
								
								
								for(int i=0;i<16;i++) {
									
									for(int j=0;j<cnt;j++) {
									  
										if(i+1 == Integer.parseInt(list1.getText("order",j)) ){
										
											
											
									
										%>
										
										
										
											<tr> 
											  <td align="left"><a href="javascript:link_func('<%=list1.getText("item",j)%>');"><%=list1.getText("item",j)%></a></td>
											  <td align="right"><%=FormatUtil.formatBigDecimal(list1.getText("total",j))%></td>
											  <td align="right"><%=FormatUtil.formatBigDecimal(list1.getText("total_cost",j))%></td>
											  <td align="right"><a href="javascript:success_func('<%=list1.getText("item",j)%>');">
											  		<%=FormatUtil.formatBigDecimal(list1.getText("success",j))%></a>
											  </td>
											  <td align="right"><a href="javascript:process_func('<%=list1.getText("item",j)%>');">
											  		<%=FormatUtil.formatBigDecimal(list1.getText("process",j))%></a>
											  </td>
											  <td align="right"><a href="javascript:regist_func('<%=list1.getText("item",j)%>');">
											  		<%=FormatUtil.formatBigDecimal(list1.getText("regist",j))%></a>
											  </td>
											  <td align="right"><a href="javascript:fault_func('<%=list1.getText("item",j)%>');">
											  		<%=FormatUtil.formatBigDecimal(list1.getText("fault",j))%></a>
											  </td>
											  <td align="right"><a href="javascript:wait_func('<%=list1.getText("item",j)%>');">
											  		<%=FormatUtil.formatBigDecimal(list1.getText("wait",j))%></a>
											  </td>
											  <td align="right"><a href="javascript:return_func('<%=list1.getText("item",j)%>');">
											  		<%=FormatUtil.formatBigDecimal(list1.getText("return",j))%></a>
											  </td>
											  <td align="right"><%=list1.getText("success_count",j).substring(0,list1.getText("success_count",j).indexOf(".")+3)   %></td>
											  <td align="right"><%=list1.getText("service_percent",j).substring(0,list1.getText("service_percent",j).indexOf(".")+3)   %></td>
											  <td align="right"><%= "".equals( list1.getText("time_average",j) ) ? "0":list1.getText("time_average",j)%></td>
											</tr>
									<%	}//end if
									}//end for
								} //end for
							
								%>
										<tr> 
										  <td>소계</td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Integer.toString(total) )%></td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Long.toString( total_cost ))%></td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Integer.toString(success ))%></td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Integer.toString(process ))%></td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Integer.toString(regist )) %></td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Integer.toString(fault ))  %></td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Integer.toString(wait ))   %></td>
										  <td align="right"><%=FormatUtil.formatBigDecimal( Integer.toString(returns )) %></td>
										  <!--(parent==0?1:parent) : 분모가 0이되면 by zero 익셉션이 떨이지니 -->
										  <td align="right"><%=Float.toString(Math.round(success_count  / (parent==0?1:parent) ))%></td>
										  <td align="right"><%=Float.toString(Math.round(service_percent/ (parent==0?1:parent) ))%></td>
										  <td align="right"><%=Float.toString(Math.round(time_average   / (parent==0?1:parent) ))%></td>
										</tr>
							<%
							
							
							}// end if
							%>													
					</table>
					</div><!-- excel 2단계 끝-->
				</td>
				</tr>
				<tr>
				<td>
					<div id="excelDiv2">
					<table width="100%" class="adm_table">
						<tr> 
						<th>항목</th>
						<th>총건수</th>
						<th>총금액(일원)</th>
						<th>성공</th>
						<th>처리중</th>
						<th>접수</th>
						<th>실패</th>
						<th>지연</th>
						<th>반송</th>
						<th>처리율</th>
						<th>S/L</th>
						<th>AHT</th>
						</tr>
	<%
							int cnt2 = list2.getCount("item");
							
							int total_temp=0;
							
							for(int i=0;i<cnt2;i++) {														
								total_temp +=  Integer.parseInt( list2.getText("total",i) );
							}
							
							if(cnt2 == 0  || total_temp == 0) {
	%>
									<tr class="adm01"> 
									  <td colspan="12">해당하는 자료가 없습니다.</td>
									</tr>										
	<%											
							} else {
								for(int i=0;i<cnt2;i++) {
								if(Integer.parseInt(list2.getText("total",i)) > 0){
								
								%>
							<tr> 
							  <td align="left"><a href="javascript:link_func('<%=list2.getText("item",i)%>');"><%=list2.getText("item",i)%></a></td>
							  <td align="right"><%=FormatUtil.formatBigDecimal(list2.getText("total",i))%></td>
							  <td align="right"><%=list2.getText("total_cost",i)%>
							  </td>
							  <td align="right"><a href="javascript:success_func('<%=list2.getText("item",i)%>');">
								  <%=FormatUtil.formatBigDecimal(list2.getText("success",i))%></a>
							  </td>
							  <td align="right"><a href="javascript:process_func('<%=list2.getText("item",i)%>');">
								  <%=FormatUtil.formatBigDecimal(list2.getText("process",i))%></a>
							  </td>
							  <td align="right"><a href="javascript:regist_func('<%=list2.getText("item",i)%>');">
								  <%=FormatUtil.formatBigDecimal(list2.getText("regist",i))%></a>
							  </td>
							  <td align="right"><a href="javascript:fault_func('<%=list2.getText("item",i)%>');">
								  <%=FormatUtil.formatBigDecimal(list2.getText("fault",i))%></a>
							  </td>
							  <td align="right"><a href="javascript:wait_func('<%=list2.getText("item",i)%>');">
								  <%=FormatUtil.formatBigDecimal(list2.getText("wait",i))%></a>
							  </td>
							  <td align="right"><a href="javascript:return_func('<%=list2.getText("item",i)%>');">
								  <%=FormatUtil.formatBigDecimal(list2.getText("return",i))%></a>
							  </td>
							  <td align="right"><%=list2.getText("success_count",i).substring(0,list2.getText("success_count",i).indexOf(".")+3)   %></td>
							  <td align="right"><%=list2.getText("service_percent",i).substring(0,list2.getText("service_percent",i).indexOf(".")+3)   %></td>
							  <td align="right"><%=list2.getText("time_average",i)%></td>
							</tr>
							<%	} //end for
								} //end if
							}// end if
							%>													
					</table>
					</div>
					
				</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr> 
				<td>
					<table width="600">
						<tr>
						<td width="98">특이사항	</td>
						<td width="536">
							<input type="text" name="cause" size="50">
							<input type="text" name="createdate" class="box01" size="8" maxlength="8" style="text-align:center" value="" readonly>
							<img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  >
							<input type="button" name="btn" value="입력" onClick="write_func();">
							<input type="button" name="sch" value="조회" onClick="search_func();">
						</td>
						</tr>
					</table>
				</td>
				</tr>
			</table>
			
		</td>
		</tr>
	</table>
</td>
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
            src="/common/cal.jsp?setDate=MemberF.createdate&divName=cal" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"></iframe>
</div>

</form>

<script language="javascript">
	f = document.MemberF ;

	fromYear  = "<%=form.getFromDate().substring(0,4)%>" ;
	fromMonth = "<%=form.getFromDate().substring(4,6)%>" ;
	fromDay   = "<%=form.getFromDate().substring(6).equals("")?"1":form.getFromDate().substring(6)%>" ;
	toYear    = "<%=form.getToDate().substring(0,4)%>" ;
	toMonth   = "<%=form.getToDate().substring(4,6)%>" ;
	toDay     = "<%=form.getToDate().substring(6).equals("")?"1":form.getToDate().substring(6)%>" ;

	years      = <%=form.getYear()%>;
	
	f.fromDate1.value = fromYear;
	f.fromDate2.value = eval(fromMonth);
	setDate(f.fromDate1,f.fromDate2,f.fromDate3) ;
	f.fromDate3.value = eval(fromDay) ;

	f.toDate1.value = toYear;
	f.toDate2.value = eval(toMonth);
	setDate(f.toDate1,f.toDate2,f.toDate3) ;
	f.toDate3.value = eval(toDay) ;

	f.fromMDate1.value = fromYear;
	f.fromMDate2.value = eval(fromMonth);

	f.toMDate1.value = toYear;
	f.toMDate2.value = eval(toMonth);
	
	f.fromYDate1.value = eval(years);
	f.quaters.value =<%=form.getQuater()%>;

<%	if("1".equals(form.getTermDiv())){%>
	document.all["calDailyForm"].style.display = ""
	f.current.value="1";//첫페이지로 셋팅
<%	}else if("2".equals(form.getTermDiv()) ){%>
	document.all["calMonthlyForm"].style.display = ""
	f.current.value="1";//첫페이지로 셋팅
<%	}else if("3".equals(form.getTermDiv()) ) {%>
	document.all["calYearlyForm"].style.display = ""
	f.current.value="1";//첫페이지로 셋팅
<%	}else if("4".equals(form.getTermDiv()) ) {%>
	document.all["calQuaterForm"].style.display = ""
	f.current.value="1";//첫페이지로 셋팅
<%	}%>

function goExcel_ext() {
	var htmls = '<HEAD><META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=KSC5601"></HEAD>';
	var exce1, excel2;
	
	//document.excelform.excel.value= document.all.excelDiv.innerHTML;
	excel =  htmls+document.all.excelDiv3.innerHTML;
	excel = excel + document.all.excelDiv2.innerHTML;
	excel = excel + document.all.excelDiv.innerHTML;
 	document.excelform.excel.value = excel;
	
	
	//alert("excel : "+ document.excelform.excel.value);
	
	document.excelform.taret =excelFrame;
	document.excelform.action="/common/excel.do";
	//document.excelform.action="/common/excel.jsp";
	document.excelform.submit();
}

</script>
<!-- excel 을 보내기위한 target frame-->
<iframe src="" name="excelFrame" width="0" height="0" frameborder="0" ></iframe>

<!-- excel 1단계 -->
<form name="excelform" method="post">
<input type="hidden" name="excel">
</form>
<!-- excel 1단계 -->

<form name="cyberindex" method="get" action="/common/cyber_index.do">
	<input type="hidden" name="run" value='list'>
	<input type="hidden" name="current" value=<%=form.getCurrent()%>>
	<input type=hidden name='toDate'    value='<%=form.getToDate()%>'>
	<input type=hidden name='fromDate'  value='<%=form.getFromDate()%>'>
	<input type=hidden name='year'  value='<%=form.getYear()%>'>
	<input type=hidden name='quatertoDate'    value='<%=form.getQuatertoDate()%>'>
	<input type=hidden name='quaterfromDate'  value='<%=form.getQuaterfromDate()%>'>
	<input type="hidden" name="quater" value='<%=form.getQuater()%>'>
	<input type="hidden" name="flag" value='I'>
	<input type="hidden" name="termDiv" value='<%=form.getTermDiv()%>'>
	
	
</form>

</body>
</html>


<%
}catch(Exception e){


	System.out.println(e.toString());
}


%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%
// -----------------------------------------------------------------------------
//    변수
// -----------------------------------------------------------------------------
	String setDate  = request.getParameter("setDate");
	String year     = request.getParameter("year");
	String month    = request.getParameter("month");
	String divName  = request.getParameter("divName");
	String call     = request.getParameter("call"   );
// -----------------------------------------------------------------------------
//    
// -----------------------------------------------------------------------------
    if(setDate!=null)   setDate = "'"+setDate+"'" ;
    if(year!=null)      year    = "'"+year+"'" ;
    if(month!=null)     month   = "'"+month+"'" ;
    if(divName!=null)   divName = "'"+divName+"'" ;
    if(call!=null)      call    = "parent."+call+"(d);" ;
    else call = "" ;
%> 
<html>
<head>
    <title></title>
    <style type='text/css'>
	BODY{FONT-SIZE: 10pt; font-family:돋움;leftmargin=0 ;topmargin=0}
	.datacenter{ TEXT-ALIGN:center; font-size:9pt; }
	.center{	TEXT-ALIGN: center;}
    .searchin {  font-family: 굴림; font-size: 9pt; border-style: none}
    .font2 { font-family: 굴림; font-size: 9pt}
	.font {  font-family: 굴림; font-size: 9pt;color:#FFFFFF}
	 td#sun {font-size:9pt; color:#B8013B; background-color:#FEF5F4; height:20}
	 td#sat {font-size:9pt; color:#1700C8; background-color:#ECF8FE; height:20}
	 td#gen {font-size:9pt; background-color:#FFFFFF; height:20}
	 td#hsun {cursor:hand; font-size:9pt; color:#CC0000; background-color:#FFF7F7; height:20;}
	 td#hsat {cursor:hand; font-size:9pt; color:#0033CC; background-color:#EFFDFF; height:20;}
	 td#hgen {cursor:hand; font-size:9pt; background-color:#FFFFFF; height:20;}
    </style>
    <script language="javascript" src="/common/js/calendar2.js"></script>
    <script>

<!--
function SetTdColor(bgcolor) {
window.event.srcElement.style.backgroundColor=bgcolor;
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc; 
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->

    </script>
</head>
<script>
    var setDate  = <%=setDate%> ;//날짜를 셋팅하고자 하는 데이터필드
    var year     = <%=year%> ;//날짜를 셋팅하고자 하는 데이터필드
    var month    = <%=month%> ;//날짜를 셋팅하고자 하는 데이터필드
    var divName  = <%=divName%> ;//div이름
/* -----------------------------------------------------------------------------
Function : reSize()
Param	 : iframe size조절용 스크립트
----------------------------------------------------------------------------- */
    function returnLast( d ){
        if(setDate!=null){
            var sDate = eval("parent."+setDate) ;
            sDate.value = d ;
        }
        parent.hideLayer(divName);
        <%=call%>
    }
/* -----------------------------------------------------------------------------
Function : reSize()
Param	 : iframe size조절용 스크립트
----------------------------------------------------------------------------- */
	function reSize() {
        try{
            var parentPage = document.body ;
            var thisPage   = parent.document.all[window.name];
            thisPage.style.height = parentPage.scrollHeight ;
            thisPage.style.width = parentPage.scrollWidth ;
        }catch(e){
        }
	}
</script>
<body leftmargin=0 topmargin=0 marginwidth=0 marginheight=0 bgcolor=#ffffff  
    onLoad="MM_preloadImages('/images/button/buttonCalendarPrev2.gif','/images/button/buttonCalendarNext2.gif','/images/button/buttonCalendarEnd2.gif','/images/button/buttonCalendarHome2.gif');">

<div id='writeDal'></div>

</body>
</html>
<script>
//    if(setDate!=null)
        ShowCalendar("", year, month, 'YYYYMMDD');
</script>


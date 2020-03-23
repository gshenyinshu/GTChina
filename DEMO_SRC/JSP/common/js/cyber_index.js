
var thisFormName = "MemberF" ;
var currAction = null;
var thisFormAction = "/common/cyber_index.do" ;
//var ff = 	document.cyberindex;


/* -----------------------------------------------------------------------------
* Function : logMailCall()
* Comment  : 최종적으로 submit
----------------------------------------------------------------------------- */

function logMailCall(run){
    var f = document.forms[thisFormName] ;
	var ff = document.cyberindex;
	
	// 일별 검색일 경우
	if(f.termDiv.value=="1"){
		toYear  = f.toDate1.value ;
		toMonth = eval(f.toDate2.value)<10 ? "0"+f.toDate2.value : f.toDate2.value ;
		toDay   = eval(f.toDate3.value)<10 ? "0"+f.toDate3.value : f.toDate3.value ;

		fromYear  = f.fromDate1.value ;
		fromMonth = eval(f.fromDate2.value)<10 ? "0"+f.fromDate2.value : f.fromDate2.value ;
		fromDay   = eval(f.fromDate3.value)<10 ? "0"+f.fromDate3.value : f.fromDate3.value ;

//		f.toDate.value   = toYear   + "" + toMonth   + "" + toDay ;
//		f.fromDate.value = fromYear + "" + fromMonth + "" + fromDay ;
		ff.toDate.value   = toYear   + "" + toMonth   + "" + toDay ;
		ff.fromDate.value = fromYear + "" + fromMonth + "" + fromDay ;

	}
	// 월별 검색일 경우
	else if(f.termDiv.value=="2"){
		toYear  = f.toMDate1.value ;
		toMonth = eval(f.toMDate2.value)<10 ? "0"+f.toMDate2.value : f.toMDate2.value ;

		fromYear  = f.fromMDate1.value ;
		fromMonth = eval(f.fromMDate2.value)<10 ? "0"+f.fromMDate2.value : f.fromMDate2.value ;

//		f.toDate.value   = toYear   + "" + toMonth ;
//		f.fromDate.value = fromYear + "" + fromMonth ;
		ff.toDate.value   = toYear   + "" + toMonth ;
		ff.fromDate.value = fromYear + "" + fromMonth ;

		
	}	
	// 년도별 검색일 경우
	else if(f.termDiv.value=="3"){
		toYear  = f.toDate1.value ;
		toMonth = eval(f.toDate2.value)<10 ? "0"+f.toDate2.value : f.toDate2.value ;
		toDay   = eval(f.toDate3.value)<10 ? "0"+f.toDate3.value : f.toDate3.value ;

		fromYear  = f.fromDate1.value ;
		fromMonth = eval(f.fromDate2.value)<10 ? "0"+f.fromDate2.value : f.fromDate2.value ;
		fromDay   = eval(f.fromDate3.value)<10 ? "0"+f.fromDate3.value : f.fromDate3.value ;

//		f.toDate.value   = toYear   + "" + toMonth   + "" + toDay ;
//		f.fromDate.value = fromYear + "" + fromMonth + "" + fromDay ;
		ff.toDate.value   = toYear   + "" + toMonth   + "" + toDay ;
		ff.fromDate.value = fromYear + "" + fromMonth + "" + fromDay ;

		//==============================
//		fromYear  = f.fromYDate1.value ;
		fromYear  = f.fromYDate1.value ;
		//alert("하1 : "+f.year.value);
//		f.year.value = fromYear;
		ff.year.value = fromYear;
		//alert("하2 : "+f.year.value);

	}else if(f.termDiv.value=="4"){
		toYear  = f.toDate1.value ;
		toMonth = eval(f.toDate2.value)<10 ? "0"+f.toDate2.value : f.toDate2.value ;
		toDay   = eval(f.toDate3.value)<10 ? "0"+f.toDate3.value : f.toDate3.value ;

		fromYear  = f.fromDate1.value ;
		fromMonth = eval(f.fromDate2.value)<10 ? "0"+f.fromDate2.value : f.fromDate2.value ;
		fromDay   = eval(f.fromDate3.value)<10 ? "0"+f.fromDate3.value : f.fromDate3.value ;

//		f.toDate.value   = toYear   + "" + toMonth   + "" + toDay ;
//		f.fromDate.value = fromYear + "" + fromMonth + "" + fromDay ;
		ff.toDate.value   = toYear   + "" + toMonth   + "" + toDay ;
		ff.fromDate.value = fromYear + "" + fromMonth + "" + fromDay ;
		
		

		//alert("ysg"+f.quater.value );
		//alert("ysg"+f.toDate.value );
		//alert("ysg"+f.fromDate.value );
	}


	//f.method    = "post" ;
    //f.action    = thisFormAction + '?run=' + run ;
	//alert(ff.toDate.value + " : "+ ff.fromDate.value);
	//alert(ff.quater.value);
    //f.submit() ;
	ff.submit();
}

/* -----------------------------------------------------------------------------
* Function : setDate()
* Comment  : 날자 입력
----------------------------------------------------------------------------- */
function setFromDate(s){
	
    document.forms[thisFormName].fromDate.value = s;
}

/* -----------------------------------------------------------------------------
* Function : setDate()
* Comment  : 날자 입력
----------------------------------------------------------------------------- */
function setToDate(s){
	
    document.forms[thisFormName].toDate.value = s;
}


/* -----------------------------------------------------------------------------
* Function : setDate()
* Comment  : 날자 입력
----------------------------------------------------------------------------- */
function setDate(obj1,obj2,obj3){
	year  = obj1.value ;
	month = obj2.value ;
	day   = obj3.value ;
	
	days    = new Array(31,28,31,30,31,30,31,31,30,31,30,31) ;
	days[1] = (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) ? 29 : 28 // 윤달
	
	for(i=obj3.options.length-1; i>=0 ; i--){	
		obj3.options.remove(i);
	}
	
	for(i=0; i<days[month-1] ; i++){
		oOption=document.createElement("OPTION");
		oOption.value = i+1 ;
		oOption.text  = i+1 ;
		obj3.options.add(oOption);

		obj3.value = day>days[month-1]?days[month-1]:day ;
	}
}


/* -----------------------------------------------------------------------------
* Function : showDate()
* Comment  : 날짜 검색 필드
----------------------------------------------------------------------------- */
function showDate(gubun){
	if(gubun==1){
		document.all['calDailyForm'].style.display   = "" ;
		document.all['calMonthlyForm'].style.display = "none" ;
		document.all['calYearlyForm'].style.display = "none" ;
		document.all['calQuaterForm'].style.display = "none" ;
		document.cyberindex.termDiv.value="1";
	}
	else if(gubun==2){
		document.all['calDailyForm'].style.display   = "none" ;
		document.all['calMonthlyForm'].style.display = "" ;
		document.all['calYearlyForm'].style.display = "none" ;
		document.all['calQuaterForm'].style.display = "none" ;
		document.cyberindex.termDiv.value="2";
	}
	else if(gubun==3){
		document.all['calDailyForm'].style.display   = "none" ;
		document.all['calMonthlyForm'].style.display = "none" ;
		document.all['calYearlyForm'].style.display = "" ;
		document.all['calQuaterForm'].style.display = "none" ;
		document.cyberindex.termDiv.value="3";
	}
	else if(gubun==4){
		document.all['calDailyForm'].style.display   = "none" ;
		document.all['calMonthlyForm'].style.display = "none" ;
		document.all['calYearlyForm'].style.display = "none" ;
		document.all['calQuaterForm'].style.display = "" ;
		document.cyberindex.termDiv.value="4";
	}

}


/* -----------------------------------------------------------------------------
* Function : setTblName()
* Comment  : 날자 입력
----------------------------------------------------------------------------- */
function setTblName(s){
	//alert(s.value);
    document.forms[thisFormName].tbl_name.value = s.value;
}

/* -----------------------------------------------------------------------------
* Function : setOrderBy()
* Comment  : 날자 입력
----------------------------------------------------------------------------- */
function setOrderBy(s){
	//alert(s.value);
    document.forms[thisFormName].orderby.value = s.value;
}


/* -----------------------------------------------------------------------------
* Function : quaterFunc(obj)
* Comment  : 분기별 선택시 날짜 입력
----------------------------------------------------------------------------- */
function quaterFunc(obj){
	var ff = document.cyberindex;

	var thisYear = new Date().getYear()  ;
	//alert(obj);
	
	if(obj == '1'){
		ff.quater.value = "1";
		ff.quaterfromDate.value =   thisYear + "" + "01";
		ff.quatertoDate.value   =   thisYear + "" + "03";
		
	}else if(obj == '2'){
		ff.quater.value = "2";
		ff.quaterfromDate.value = thisYear + "" + "04";
		ff.quatertoDate.value   = thisYear + "" + "06";
		
	}else if(obj == '3'){
		ff.quater.value = "3";
		ff.quaterfromDate.value = thisYear + "" + "07";
		ff.quatertoDate.value   = thisYear + "" + "09";
		
	}else{
		ff.quater.value = "4";
		ff.quaterfromDate.value = thisYear + "" + "10";
		ff.quatertoDate.value   = thisYear + "" + "12";
	}
}
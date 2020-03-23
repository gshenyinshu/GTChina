/*******************************************************************************
* Title       : My 일정관리
* Description : My 일정관리에서만 사용하는 스크립트 모음
                [/common/js/common.js]파일과 함께 사용하기.
* File Name   : /common/js/receipt/schedule.js
* Copyright   : Copyright (c) 2004
* Company     : CyberImagination
* @author     : Sang-Mi Lee
*******************************************************************************/

/* -----------------------------------------------------------------------------
* Function : schedule_blank()
* Comment  : 스크립트 호출하는 팝업창
* Param    : funName -
* Param    : w - 가로사이트
* Param    : h - 세로사이즈
----------------------------------------------------------------------------- */
function schedule_blank( funName , w , h, scr, re ){

    if(scr==null)scr = "yes" ;
    var url =  "/common/blank.jsp?function=opener."+funName;  
    common_openWindow(url,w,h,scr,'no', 'write') ;
}
/* -----------------------------------------------------------------------------
* Function : setDeleteDay( flag )
* Comment  : 스케줄 삭제하기 및 수정하기 화면으로 이동
* Param    : flag         - 0:수정 1:삭제
* Param    : scheduleDate - 가로사이트
* Param    : insertDate   - 가로사이트
----------------------------------------------------------------------------- */
function setDeleteDay( flag, scheduleDate, insertDate ){
    var f = document.forms['scheduleForm'] ;
    f.scheduleDate.value = scheduleDate ;
    f.insertDate.value   = insertDate ;
    f.target = "_self" ;

    if(flag==0){
        f.run.value = "viewDay" ;
        f.viewType.value = "onlyOne" ;
        f.forward.value = "schedule_day_update" ;
        f.action = "/receipt/schedule.do" ;
    }else{
         f.run.value = "deleteDay" ;
        if(confirm("데이터를 삭제하시겠습니까?"))
            f.action = "/receipt/scheduleTA.do" ;
        else 
            return false ; 
    }
    f.submit();
}  
/* -----------------------------------------------------------------------------
* Function : setScheduleType( flag )
* Comment  : 스케줄분류코드
* Param    : date - 가로사이트
* Param    : flag - 세로사이즈
----------------------------------------------------------------------------- */
function setScheduleType( date, flag ){
    document.forms['scheduleForm'].scheduleDate.value= date ;
    document.forms['scheduleForm'].scheduleType.value= flag ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_view()
* Comment  : 일일스케줄 보기
----------------------------------------------------------------------------- */
function schedule_day_view(){
    var f = document.forms['scheduleForm']; 
    f.run.value= 'viewDay' ;
    f.forward.value= 'schedule_day_view' ;
    f.target       = 'write' ;
    f.action       = '/receipt/schedule.do' ;
    f.submit();
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_view_main()
* Comment  : 일일스케줄 보기(메인)
----------------------------------------------------------------------------- */
function schedule_day_view_main(){
    var f = document.forms['scheduleForm']; 
    f.run.value    = "viewMainMeno" ;
    f.target       = 'write' ;
    f.action       = '/receipt/schedule.do' ;
    f.submit();
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_update()
* Comment  : 일일스케줄 수정
----------------------------------------------------------------------------- */
function schedule_day_update(){
    var f = document.forms['scheduleForm']; 
    f.forward.value = 'schedule_day_update' ;
    f.target       = 'write' ;
    f.action       = '/receipt/schedule_day_view.do' ;
    f.submit();
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_create()
* Comment  : 일일스케줄 입력창 보여주기
----------------------------------------------------------------------------- */
function schedule_day_create(){ 
    var url =  "/receipt/schedule_day_create.do";  
        common_openWindow(url,476,450,'no','no', 'write') ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_create_process()
* Comment  : 일일스케줄 입력실행
----------------------------------------------------------------------------- */
function schedule_day_create_process(){ 
    var f = document.forms['scheduleForm'];  
    f.scheduleDate.value = f.year.value+f.month.value+f.day.value ;
    f.forward.value = "";

    //내용체크
    if( !common_Empty(f.contents) ){
        alert("스케줄내용을 입력하여주세요.");
        f.contents.focus();
        return false ;
    }

    //내용문자길이 체크
    if( !common_maxStr( f.contents , 127 ) ){
        f.contents.focus();
        return false ;
    }

    //분류체크
    if(f.scheduleType.value<0){
        alert("스케줄분류를 선택하여주세요.");
        f.scheduleType.focus();
        return false ;
    }
    f.run.value = "createDay" ;
    f.target = "_self" ;
    f.method = "post" ;
    f.action = "/receipt/schedule.do" ;
    f.submit();
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_update_process()
* Comment  : 일일스케줄 수정실행
----------------------------------------------------------------------------- */
function schedule_day_update_process(){ 
    var f = document.forms['scheduleForm'];  
    //내용체크
    if( !common_Empty(f.contents) ){
        alert("스케줄내용을 입력하여주세요.");
        f.contents.focus();
        return false ;
    }
    f.run.value = "updateDay" ;
    f.target = "_self" ;
    f.method = "post" ;
    f.action = "/receipt/scheduleTA.do" ;
    f.submit();
}
/* -----------------------------------------------------------------------------
* Function : schedule_search_main(flag)
* Comment  : 년,월의 select가 onchange되면 실행
* Param    : action - action
* Param    : flag - -1 pre버튼 +1 next버튼
----------------------------------------------------------------------------- */
function schedule_search_main(action , flag){
    var f = document.forms['scheduleForm']; 
    f.run.value = "viewMain" ;
    schedule_search(action , flag) ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_search_main(flag)
* Comment  : 년,월의 select가 onchange되면 실행
* Param    : action - action
* Param    : flag - -1 pre버튼 +1 next버튼
----------------------------------------------------------------------------- */
function schedule_search_page(action , flag){
    var f = document.forms['scheduleForm']; 
    f.run.value = "view" ;
    schedule_search(action , flag) ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_search(flag)
* Comment  : 년,월의 select가 onchange되면 실행
* Param    : action - action
* Param    : flag - -1 pre버튼 +1 next버튼
----------------------------------------------------------------------------- */
function schedule_search(action , flag){
    var f = document.forms['scheduleForm']; 
    var y   = parseInt(f.year.value ,10) ;
   //alert(f.month.value);
    var m   = parseInt(f.month.value ,10) ;
 //alert(m);
    if(flag!=null){
        var len = 0 ;

        if( flag==-1 ){
            if(m==1){
                y = y-1 ;
                m = 12 ;
            }else{
                m = m-1 ;
                if(m<10) m="0"+m ;
            }
        }else {
            if(m==12){
                y = y+1 ;
                m = 1 ;
            }else{
                m = m+1 ;  
                if(m<10) m="0"+m ;
            }
        }
        len = y+""+m ;
        if(len<200409){
//            alert('2004년 09월 이전의 스케줄은 사용하실 수 없습니다.');
//            return false ;
        }
    }
    //alert(m);
    
    if((m+"").length<2) m="0"+m ;   
    f.year.value  = ""+y ;
    
    //alert(m);
    
    f.month.value = ""+m ;
    f.scheduleDate.value = y+""+m ;
    f.is.value = '0' ;
    f.action = action ;
    f.target = "_self" ;
    
   	//alert(f.year.value);
	//alert(f.month.value);
	//alert(f.scheduleDate.value);
    
    f.submit();
}
/* -----------------------------------------------------------------------------
* Function : schedule_memo()
* Comment  : 팝업창
* Param    : obj - 호출한 객체
----------------------------------------------------------------------------- */
function schedule_memo(){
    var f = document.forms['scheduleForm'];  
    var url =  "/receipt/schedule.do";  
        url += "?run=viewMemo&scheduleDate="+f.year.value+f.month.value ;
        url += "&is="+f.is.value ;
        common_openWindow(url,476,394,'no','no', 'write') ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_memo_write()
* Comment  : 
* Param    : obj - 호출한 객체
----------------------------------------------------------------------------- */
function schedule_memo_write(){
    var f    = document.forms['scheduleForm'];  

    //제목체크
    if( !common_Empty(f.subject) ){
        alert("월간메모 제목을 입력하여주세요.");
        f.subject.focus();
        return false ;
    }
    //내용체크
    if( !common_Empty(f.contents) ){
        alert("월간메모 내용을 입력하여주세요.");
        f.contents.focus();
        return false ;
    }
    f.run.value = "writeMemo" ;
    f.target = "_self" ;
    f.method = "post" ;
    f.action = "/receipt/scheduleTA.do" ;
    f.submit();
}
/* -----------------------------------------------------------------------------
* Function : schedule_memo_write()
* Comment  : 
* Param    : flag - 정상비정상여부
----------------------------------------------------------------------------- */
function viewMSG( flag ){
    if(flag){
        opener.location.reload() ;
        alert("입력되었습니다.");
        window.close();
    }    
}
/* -----------------------------------------------------------------------------
* Function : schedule_memo_write()
* Comment  : 
* Param    : flag - 정상비정상여부
----------------------------------------------------------------------------- */
function alertMSG( run , flag ){
    if(flag && run=='updateDay'){
            opener.location.reload() ;
            alert("수정되었습니다.");
    }else if(  run=='deleteDay' ){
            opener.location.reload() ;
            alert("삭제되었습니다.");
            window.close();
    }
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_create_MSG()
* Comment  : 
* Param    : flag - true 저장 후
----------------------------------------------------------------------------- */
function schedule_day_create_MSG( flag ){
    if(flag){
        opener.location.reload() ;
        alert("입력되었습니다.");
        location.href='/receipt/schedule_day_create.do';
    }    
}

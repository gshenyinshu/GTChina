/*******************************************************************************
* Title       : My ��������
* Description : My �������������� ����ϴ� ��ũ��Ʈ ����
                [/common/js/common.js]���ϰ� �Բ� ����ϱ�.
* File Name   : /common/js/receipt/schedule.js
* Copyright   : Copyright (c) 2004
* Company     : CyberImagination
* @author     : Sang-Mi Lee
*******************************************************************************/

/* -----------------------------------------------------------------------------
* Function : schedule_blank()
* Comment  : ��ũ��Ʈ ȣ���ϴ� �˾�â
* Param    : funName -
* Param    : w - ���λ���Ʈ
* Param    : h - ���λ�����
----------------------------------------------------------------------------- */
function schedule_blank( funName , w , h, scr, re ){

    if(scr==null)scr = "yes" ;
    var url =  "/common/blank.jsp?function=opener."+funName;  
    common_openWindow(url,w,h,scr,'no', 'write') ;
}
/* -----------------------------------------------------------------------------
* Function : setDeleteDay( flag )
* Comment  : ������ �����ϱ� �� �����ϱ� ȭ������ �̵�
* Param    : flag         - 0:���� 1:����
* Param    : scheduleDate - ���λ���Ʈ
* Param    : insertDate   - ���λ���Ʈ
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
        if(confirm("�����͸� �����Ͻðڽ��ϱ�?"))
            f.action = "/receipt/scheduleTA.do" ;
        else 
            return false ; 
    }
    f.submit();
}  
/* -----------------------------------------------------------------------------
* Function : setScheduleType( flag )
* Comment  : �����ٺз��ڵ�
* Param    : date - ���λ���Ʈ
* Param    : flag - ���λ�����
----------------------------------------------------------------------------- */
function setScheduleType( date, flag ){
    document.forms['scheduleForm'].scheduleDate.value= date ;
    document.forms['scheduleForm'].scheduleType.value= flag ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_view()
* Comment  : ���Ͻ����� ����
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
* Comment  : ���Ͻ����� ����(����)
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
* Comment  : ���Ͻ����� ����
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
* Comment  : ���Ͻ����� �Է�â �����ֱ�
----------------------------------------------------------------------------- */
function schedule_day_create(){ 
    var url =  "/receipt/schedule_day_create.do";  
        common_openWindow(url,476,450,'no','no', 'write') ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_create_process()
* Comment  : ���Ͻ����� �Է½���
----------------------------------------------------------------------------- */
function schedule_day_create_process(){ 
    var f = document.forms['scheduleForm'];  
    f.scheduleDate.value = f.year.value+f.month.value+f.day.value ;
    f.forward.value = "";

    //����üũ
    if( !common_Empty(f.contents) ){
        alert("�����ٳ����� �Է��Ͽ��ּ���.");
        f.contents.focus();
        return false ;
    }

    //���빮�ڱ��� üũ
    if( !common_maxStr( f.contents , 127 ) ){
        f.contents.focus();
        return false ;
    }

    //�з�üũ
    if(f.scheduleType.value<0){
        alert("�����ٺз��� �����Ͽ��ּ���.");
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
* Comment  : ���Ͻ����� ��������
----------------------------------------------------------------------------- */
function schedule_day_update_process(){ 
    var f = document.forms['scheduleForm'];  
    //����üũ
    if( !common_Empty(f.contents) ){
        alert("�����ٳ����� �Է��Ͽ��ּ���.");
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
* Comment  : ��,���� select�� onchange�Ǹ� ����
* Param    : action - action
* Param    : flag - -1 pre��ư +1 next��ư
----------------------------------------------------------------------------- */
function schedule_search_main(action , flag){
    var f = document.forms['scheduleForm']; 
    f.run.value = "viewMain" ;
    schedule_search(action , flag) ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_search_main(flag)
* Comment  : ��,���� select�� onchange�Ǹ� ����
* Param    : action - action
* Param    : flag - -1 pre��ư +1 next��ư
----------------------------------------------------------------------------- */
function schedule_search_page(action , flag){
    var f = document.forms['scheduleForm']; 
    f.run.value = "view" ;
    schedule_search(action , flag) ;
}
/* -----------------------------------------------------------------------------
* Function : schedule_search(flag)
* Comment  : ��,���� select�� onchange�Ǹ� ����
* Param    : action - action
* Param    : flag - -1 pre��ư +1 next��ư
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
//            alert('2004�� 09�� ������ �������� ����Ͻ� �� �����ϴ�.');
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
* Comment  : �˾�â
* Param    : obj - ȣ���� ��ü
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
* Param    : obj - ȣ���� ��ü
----------------------------------------------------------------------------- */
function schedule_memo_write(){
    var f    = document.forms['scheduleForm'];  

    //����üũ
    if( !common_Empty(f.subject) ){
        alert("�����޸� ������ �Է��Ͽ��ּ���.");
        f.subject.focus();
        return false ;
    }
    //����üũ
    if( !common_Empty(f.contents) ){
        alert("�����޸� ������ �Է��Ͽ��ּ���.");
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
* Param    : flag - ��������󿩺�
----------------------------------------------------------------------------- */
function viewMSG( flag ){
    if(flag){
        opener.location.reload() ;
        alert("�ԷµǾ����ϴ�.");
        window.close();
    }    
}
/* -----------------------------------------------------------------------------
* Function : schedule_memo_write()
* Comment  : 
* Param    : flag - ��������󿩺�
----------------------------------------------------------------------------- */
function alertMSG( run , flag ){
    if(flag && run=='updateDay'){
            opener.location.reload() ;
            alert("�����Ǿ����ϴ�.");
    }else if(  run=='deleteDay' ){
            opener.location.reload() ;
            alert("�����Ǿ����ϴ�.");
            window.close();
    }
}
/* -----------------------------------------------------------------------------
* Function : schedule_day_create_MSG()
* Comment  : 
* Param    : flag - true ���� ��
----------------------------------------------------------------------------- */
function schedule_day_create_MSG( flag ){
    if(flag){
        opener.location.reload() ;
        alert("�ԷµǾ����ϴ�.");
        location.href='/receipt/schedule_day_create.do';
    }    
}

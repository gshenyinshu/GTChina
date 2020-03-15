/**
 * Title       : 
 * Description : ScheduleF form
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author       Sang-Mi Lee
 * @version 1.0
 */
package gtone.changeminer.receipt.form;

import java.util.Calendar ;

import gtone.changeminer.common.action.*;

import org.apache.struts.action.ActionForm      ;
import org.apache.struts.action.ActionMapping   ;
import org.apache.struts.action.ActionErrors    ;
import org.apache.struts.action.ActionMessage   ;

import javax.servlet.http.HttpServletRequest    ;

/**
 * XDoclet definition:
 * @struts:form name="scheduleForm"
 */
public  class ScheduleForm extends ActionForm{

    private String userID           = null ;////사용자ID
    private String userName         = null ;////사용자이름
    private String userSsn          = null ;////사용자주빈등록번호

    private String beforerun      = null ;////처리전 메소드
    private String forward        = null ;////forward
    private String result         = null ;////결과
    private String scheduleDate   = null ;////메모한 달
    private String scheduleType   = null ;////스케줄타입
    private String subject        = null ;////제   목
    private String contents       = null ;////내   용
    private String insertDate     = null ;////일일스케줄 저장날짜  
    private String allday = null;
    ////viewType-0:메인 1:해당일 모두 2:해당일의 같은 종류 3:한개만
    private String viewType       = null ;

    private int    year           = -1 ;////년도
    private int    month          = -1 ;////월
    private int    day            = -1 ;////월
    private int    is             = -1 ;////데이터존재여부
    private boolean status        = false ;////결과
    


    ////set사용자이름
    public void setUserName(String userName){
        this.userName = userName;
    }
    ////get사용자이름
    public String getUserName(){
        return userName ;
    }

    ////set사용자주민등록번호
    public void setUserSsn(String userSsn){
        this.userSsn = userSsn;
    }
    ////get사용자주민등록번호
    public String getUserSsn(){
        return userSsn ;
    }

    ////set사용자ID
    public void setUserID(String userID){
        this.userID = userID;
    }
    ////get사용자ID
    public String getUserID(){
        return userID ;
    }

    ////set사용자ID
    public void setBeforerun(String beforerun){
        this.beforerun = beforerun;
    }
    ////get사용자ID
    public String getBeforerun(){
        return beforerun ;
    }

    ////setForward
    public void setForward(String forward){
        this.forward = forward;
    }
    ////getForward
    public String getForward(){
        return forward ;
    }

    ////set결과
    public void setResult(String result){
        this.result = result;
    }
    ////get결과
    public String getResult(){
        return result ;
    }

    ////set메모한 달
    public void setScheduleDate(String scheduleDate){
        this.scheduleDate = scheduleDate;
    }
    ////get메모한 달
    public String getScheduleDate(){
        return scheduleDate ;
    }

    ////set스케줄타입
    public void setScheduleType(String scheduleType){
        this.scheduleType = scheduleType ;
    }
    ////get스케줄타입
    public String getScheduleType(){
        return scheduleType ;
    }

    ////set제   목
    public void setSubject(String subject){
        this.subject = subject;
    }
    ////get제   목
    public String getSubject(){
        return subject ;
    }

    ////set내   용
    public void setContents(String contents){
        this.contents = contents;
    }
    ////get내   용
    public String getContents(){
        return contents ;
    }

    ////set일일스케줄 저장날짜
    public void setInsertDate(String insertDate){
        this.insertDate = insertDate ;
    }
    ////get일일스케줄 저장날짜
    public String getInsertDate(){
        return insertDate ;
    }

    ////set보기타입
    public void setViewType(String viewType){
        this.viewType = viewType ;
    }
    ////get보기타입
    public String getViewType(){
        return viewType ;
    }

    ////set년도
    public void setYear(int year){
        this.year = year;
    }
    ////get년도
    public int getYear(){
        return year ;
    }

    ////set월
    public void setMonth(int month){
        month = month-1 ;
        this.month = month;
    }
    ////get월
    public int getMonth(){
        return month ;
    }

    ////set일
    public void setDay(int day){
        this.day = day;
    }
    ////get일
    public int getDay(){
        return day ;
    }
    ////set데이터존재여부
    public void setIs(int is){
        this.is = is;
    }
    ////get데이터존재여부
    public int getIs(){
        return is ;
    }

    ////set
    public void setStatus(boolean status){
        this.status = status ;
    }
    ////get
    public boolean getStatus(){
        return status ;
    }

    ////set
    public void setAllday(String allday){
        this.allday = allday ;
    }
    ////get
    public String getAllday(){
        return allday ;
    }
    ////--------------------------------------------------------------------------
    //// list entity
    ////--------------------------------------------------------------------------
    /**
     * form으로 받기 전 초기화
     * @return  ActionErrors
     */
    public void reset(ActionMapping mapping, HttpServletRequest request){
        
        userID  = "";
        userName= "";////사용자이름
        userSsn = "";////사용자이름    
        beforerun= "" ;
        Calendar rightNow = Calendar.getInstance()  ;
        year     = rightNow.get(rightNow.YEAR)      ; ////설정-년도
        month    = rightNow.get(rightNow.MONTH)     ; ////설정-월
        day      = rightNow.get(rightNow.DATE)      ; ////설정-년

        scheduleDate = year+"" ;
        scheduleDate+= ((month+1)<10?"0"+(month+1):""+(month+1)) ;
        scheduleDate+= (day<10  ?"0"+day  :""+day  ) ;

        viewType = "sameType";

    }


    /**
     * form으로 받은 데이터 유효성검사
     * @return  ActionErrors
     */
    public ActionErrors validate(   ActionMapping mapping, 
                                    HttpServletRequest request){
        java.util.Enumeration tt = request.getHeaderNames() ;

        int k=0 ;
        String s = request.getHeader("accept") ;
        ActionErrors errors = super.validate(mapping, request);
        return errors ;
    }
}

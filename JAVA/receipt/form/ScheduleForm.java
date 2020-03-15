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

    private String userID           = null ;////�1�7�3�0�3�1ID
    private String userName         = null ;////�1�7�3�0�3�1�3�3�0�5
    private String userSsn          = null ;////�1�7�3�0�3�1�3�5�1�5�9�4�0�0�0�7�6�3

    private String beforerun      = null ;////�4�9�0�5�3�7 �0�3�2�1�9�3
    private String forward        = null ;////forward
    private String result         = null ;////�7�1�7�7
    private String scheduleDate   = null ;////�0�3�0�7�6�3 �9�7
    private String scheduleType   = null ;////�2�1�4�5�3�3�5�3�3�0
    private String subject        = null ;////�3�1   �0�8
    private String contents       = null ;////�8�9   �3�0
    private String insertDate     = null ;////�3�1�3�1�2�1�4�5�3�3 �3�3�3�2�8�9�3�9  
    private String allday = null;
    ////viewType-0:�0�3�3�7 1:�6�7�9�0�3�1 �0�7�9�3 2:�6�7�9�0�3�1�3�5 �7�0�3�1 �3�6�0�1 3:�6�3�7�3�0�7
    private String viewType       = null ;

    private int    year           = -1 ;////�8�3�9�3
    private int    month          = -1 ;////�3�3
    private int    day            = -1 ;////�3�3
    private int    is             = -1 ;////�9�9�3�3�5�5�3�9�3�9�2�1�1�5
    private boolean status        = false ;////�7�1�7�7
    


    ////set�1�7�3�0�3�1�3�3�0�5
    public void setUserName(String userName){
        this.userName = userName;
    }
    ////get�1�7�3�0�3�1�3�3�0�5
    public String getUserName(){
        return userName ;
    }

    ////set�1�7�3�0�3�1�3�5�0�7�9�4�0�0�0�7�6�3
    public void setUserSsn(String userSsn){
        this.userSsn = userSsn;
    }
    ////get�1�7�3�0�3�1�3�5�0�7�9�4�0�0�0�7�6�3
    public String getUserSsn(){
        return userSsn ;
    }

    ////set�1�7�3�0�3�1ID
    public void setUserID(String userID){
        this.userID = userID;
    }
    ////get�1�7�3�0�3�1ID
    public String getUserID(){
        return userID ;
    }

    ////set�1�7�3�0�3�1ID
    public void setBeforerun(String beforerun){
        this.beforerun = beforerun;
    }
    ////get�1�7�3�0�3�1ID
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

    ////set�7�1�7�7
    public void setResult(String result){
        this.result = result;
    }
    ////get�7�1�7�7
    public String getResult(){
        return result ;
    }

    ////set�0�3�0�7�6�3 �9�7
    public void setScheduleDate(String scheduleDate){
        this.scheduleDate = scheduleDate;
    }
    ////get�0�3�0�7�6�3 �9�7
    public String getScheduleDate(){
        return scheduleDate ;
    }

    ////set�2�1�4�5�3�3�5�3�3�0
    public void setScheduleType(String scheduleType){
        this.scheduleType = scheduleType ;
    }
    ////get�2�1�4�5�3�3�5�3�3�0
    public String getScheduleType(){
        return scheduleType ;
    }

    ////set�3�1   �0�8
    public void setSubject(String subject){
        this.subject = subject;
    }
    ////get�3�1   �0�8
    public String getSubject(){
        return subject ;
    }

    ////set�8�9   �3�0
    public void setContents(String contents){
        this.contents = contents;
    }
    ////get�8�9   �3�0
    public String getContents(){
        return contents ;
    }

    ////set�3�1�3�1�2�1�4�5�3�3 �3�3�3�2�8�9�3�9
    public void setInsertDate(String insertDate){
        this.insertDate = insertDate ;
    }
    ////get�3�1�3�1�2�1�4�5�3�3 �3�3�3�2�8�9�3�9
    public String getInsertDate(){
        return insertDate ;
    }

    ////set�1�5�8�5�5�3�3�0
    public void setViewType(String viewType){
        this.viewType = viewType ;
    }
    ////get�1�5�8�5�5�3�3�0
    public String getViewType(){
        return viewType ;
    }

    ////set�8�3�9�3
    public void setYear(int year){
        this.year = year;
    }
    ////get�8�3�9�3
    public int getYear(){
        return year ;
    }

    ////set�3�3
    public void setMonth(int month){
        month = month-1 ;
        this.month = month;
    }
    ////get�3�3
    public int getMonth(){
        return month ;
    }

    ////set�3�1
    public void setDay(int day){
        this.day = day;
    }
    ////get�3�1
    public int getDay(){
        return day ;
    }
    ////set�9�9�3�3�5�5�3�9�3�9�2�1�1�5
    public void setIs(int is){
        this.is = is;
    }
    ////get�9�9�3�3�5�5�3�9�3�9�2�1�1�5
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
     * form�3�7�0�9 �0�8�8�5 �3�7 �4�1�8�5�6�1
     * @return  ActionErrors
     */
    public void reset(ActionMapping mapping, HttpServletRequest request){
        
        userID  = "";
        userName= "";////�1�7�3�0�3�1�3�3�0�5
        userSsn = "";////�1�7�3�0�3�1�3�3�0�5    
        beforerun= "" ;
        Calendar rightNow = Calendar.getInstance()  ;
        year     = rightNow.get(rightNow.YEAR)      ; ////�1�7�3�4-�8�3�9�3
        month    = rightNow.get(rightNow.MONTH)     ; ////�1�7�3�4-�3�3
        day      = rightNow.get(rightNow.DATE)      ; ////�1�7�3�4-�8�3

        scheduleDate = year+"" ;
        scheduleDate+= ((month+1)<10?"0"+(month+1):""+(month+1)) ;
        scheduleDate+= (day<10  ?"0"+day  :""+day  ) ;

        viewType = "sameType";

    }


    /**
     * form�3�7�0�9 �0�8�3�1 �9�9�3�3�5�5 �3�9�6�5�1�0�7�3�1�7
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

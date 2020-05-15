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

    private String userID           = null ;////�����ID
    private String userName         = null ;////������̸�
    private String userSsn          = null ;////������ֺ��Ϲ�ȣ

    private String beforerun      = null ;////ó���� �޼ҵ�
    private String forward        = null ;////forward
    private String result         = null ;////���
    private String scheduleDate   = null ;////�޸��� ��
    private String scheduleType   = null ;////������Ÿ��
    private String subject        = null ;////��   ��
    private String contents       = null ;////��   ��
    private String insertDate     = null ;////���Ͻ����� ���峯¥  
    private String allday = null;
    ////viewType-0:���� 1:�ش��� ��� 2:�ش����� ���� ���� 3:�Ѱ���
    private String viewType       = null ;

    private int    year           = -1 ;////�⵵
    private int    month          = -1 ;////��
    private int    day            = -1 ;////��
    private int    is             = -1 ;////���������翩��
    private boolean status        = false ;////���
    


    ////set������̸�
    public void setUserName(String userName){
        this.userName = userName;
    }
    ////get������̸�
    public String getUserName(){
        return userName ;
    }

    ////set������ֹε�Ϲ�ȣ
    public void setUserSsn(String userSsn){
        this.userSsn = userSsn;
    }
    ////get������ֹε�Ϲ�ȣ
    public String getUserSsn(){
        return userSsn ;
    }

    ////set�����ID
    public void setUserID(String userID){
        this.userID = userID;
    }
    ////get�����ID
    public String getUserID(){
        return userID ;
    }

    ////set�����ID
    public void setBeforerun(String beforerun){
        this.beforerun = beforerun;
    }
    ////get�����ID
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

    ////set���
    public void setResult(String result){
        this.result = result;
    }
    ////get���
    public String getResult(){
        return result ;
    }

    ////set�޸��� ��
    public void setScheduleDate(String scheduleDate){
        this.scheduleDate = scheduleDate;
    }
    ////get�޸��� ��
    public String getScheduleDate(){
        return scheduleDate ;
    }

    ////set������Ÿ��
    public void setScheduleType(String scheduleType){
        this.scheduleType = scheduleType ;
    }
    ////get������Ÿ��
    public String getScheduleType(){
        return scheduleType ;
    }

    ////set��   ��
    public void setSubject(String subject){
        this.subject = subject;
    }
    ////get��   ��
    public String getSubject(){
        return subject ;
    }

    ////set��   ��
    public void setContents(String contents){
        this.contents = contents;
    }
    ////get��   ��
    public String getContents(){
        return contents ;
    }

    ////set���Ͻ����� ���峯¥
    public void setInsertDate(String insertDate){
        this.insertDate = insertDate ;
    }
    ////get���Ͻ����� ���峯¥
    public String getInsertDate(){
        return insertDate ;
    }

    ////set����Ÿ��
    public void setViewType(String viewType){
        this.viewType = viewType ;
    }
    ////get����Ÿ��
    public String getViewType(){
        return viewType ;
    }

    ////set�⵵
    public void setYear(int year){
        this.year = year;
    }
    ////get�⵵
    public int getYear(){
        return year ;
    }

    ////set��
    public void setMonth(int month){
        month = month-1 ;
        this.month = month;
    }
    ////get��
    public int getMonth(){
        return month ;
    }

    ////set��
    public void setDay(int day){
        this.day = day;
    }
    ////get��
    public int getDay(){
        return day ;
    }
    ////set���������翩��
    public void setIs(int is){
        this.is = is;
    }
    ////get���������翩��
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
     * form���� �ޱ� �� �ʱ�ȭ
     * @return  ActionErrors
     */
    public void reset(ActionMapping mapping, HttpServletRequest request){
        
        userID  = "";
        userName= "";////������̸�
        userSsn = "";////������̸�    
        beforerun= "" ;
        Calendar rightNow = Calendar.getInstance()  ;
        year     = rightNow.get(rightNow.YEAR)      ; ////����-�⵵
        month    = rightNow.get(rightNow.MONTH)     ; ////����-��
        day      = rightNow.get(rightNow.DATE)      ; ////����-��

        scheduleDate = year+"" ;
        scheduleDate+= ((month+1)<10?"0"+(month+1):""+(month+1)) ;
        scheduleDate+= (day<10  ?"0"+day  :""+day  ) ;

        viewType = "sameType";

    }


    /**
     * form���� ���� ������ ��ȿ���˻�
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

/**
 * Title       : 
 * Description : Schedule day  action
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination
 * @author       Sang-Mi Lee
 * @version 1.0
 */ 
package gtone.changeminer.receipt.action;

import org.apache.struts.action.Action;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import anyframe.data.DataSet;


import gtone.changeminer.receipt.form.ScheduleForm ;
import gtone.changeminer.receipt.manager.ScheduleManager ;

/**
 * @struts.action
 *      path="/schedule"
 *      parameter="run"
 *      name="scheduleForm"
 *      scope="request"
 *      validate="true"
 *
 * <!-- My 일정관리 달력화면-->
 * @struts.action-forward
 *      name="schedule_view"
 *      path="/schedule_view.jsp"
 *      redirect="false"
 */ 
 
public  class ScheduleAction extends DispatchAction {


    /**
     *  My 일정관리 달력화면
     * @param   
     * @return  
     */
      
    public ActionForward view(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
      throws Exception{
        try{
            ScheduleForm    thisForm    ;
            ScheduleManager manager     ;	
            DataSet         input       ;
	     
            thisForm  = (ScheduleForm)form ;
            manager = ScheduleManager.getInstance(); 

            request.setAttribute("calendar" , manager.readCalendar(thisForm)) ;
            request.setAttribute("today"    , manager.toDay()               ) ;
            request.setAttribute("form"     , thisForm                      ) ;

            return mapping.findForward("schedule_view");
        }catch(Exception e){
            throw (e);
        }
	}

    /**
     * 메인에서 사용되는 달력화면
     * @param   
     * @return  
     */
    public ActionForward viewMain(
                    ActionMapping mapping, 
                    ActionForm form, 
                    HttpServletRequest request,
                    HttpServletResponse response)
                throws Exception{
        try{
        anyframe.log.Logger.debug.println("달력화면 뜨는지보자");    
            ScheduleForm    thisForm    ;
            ScheduleManager manager     ;	

            thisForm  = (ScheduleForm)form ;
            manager = ScheduleManager.getInstance(); 

            request.setAttribute("calendar",manager.readCalendar(thisForm)) ;
            request.setAttribute("today"   ,manager.toDay()               ) ;
            request.setAttribute("form"    ,thisForm                      ) ;

            return mapping.findForward("main_schedule");
        }catch(Exception e){
            throw (e);
        }
	}

    /**
     * 일정보기
     * @param   
     * @return  
     */
    public ActionForward viewDay(
                    ActionMapping mapping, 
                    ActionForm form, 
                    HttpServletRequest request,
                    HttpServletResponse response)
                throws Exception{
        try{
            ScheduleForm  thisForm  ;
            ScheduleManager manager ;	

            thisForm  = (ScheduleForm)form ;
            manager = ScheduleManager.getInstance(); 
            request.setAttribute("list" ,manager.selectDay(thisForm) ) ; 
            request.setAttribute("form" ,thisForm                     ) ;

            return mapping.findForward(thisForm.getForward());
        }catch(Exception e){
            throw (e);
        }
	}


    /**
     * 일일일정 입력
     * @param   
     * @return  
     */
    public ActionForward createDay(
                    ActionMapping mapping, 
                    ActionForm form, 
                    HttpServletRequest request,
                    HttpServletResponse response)
                throws Exception{
         try{
            ScheduleForm    thisForm ;
            ScheduleManager manager  ;            
      
            thisForm = (ScheduleForm)form ;
            manager  = ScheduleManager.getInstance();
            thisForm.setStatus( manager.createDay(thisForm) ) ;
            request.setAttribute("form" ,thisForm) ;

            return mapping.findForward("schedule_day_create");
        }catch(Exception e){
            throw (e);
        }
	}

}
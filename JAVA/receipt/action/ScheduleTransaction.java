package gtone.changeminer.receipt.action;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import anyframe.data.DataSet;

import gtone.changeminer.receipt.form.ScheduleForm;
import gtone.changeminer.receipt.manager.ScheduleManager;
import gtone.changeminer.common.action.ActionRedirect;


/**
 * @struts.action
 *      path="/scheduleTA"
 *      parameter="run"
 *      name="scheduleForm"
 *      scope="request"
 *      validate="true"
 *
 * <!-- 리스트 -->
 * @struts.action-forward
 *      name="schedule"
 *      path="/schedule.do"
 *      redirect="true"
 */ 
public  class ScheduleTransaction {


    /**
     * 일일일정 수정
     * @param   
     * @return  
     */
	public ActionRedirect updateDay(
                    ActionMapping mapping, 
                    ActionForm form, 
                    HttpServletRequest request,
                    HttpServletResponse response)
                throws Exception{
         try{
            ScheduleForm    thisForm ;
            ScheduleManager manager  ;
            ActionRedirect  redirect ;
      
            thisForm = (ScheduleForm)form ;
            manager  = ScheduleManager.getInstance();
            thisForm.setStatus( manager.updateDay(thisForm) ) ;

            redirect = new ActionRedirect();
            redirect.setParam("run"          , "viewDay" );
            redirect.setParam("scheduleDate" , thisForm.getScheduleDate() );
            redirect.setParam("scheduleType" , thisForm.getScheduleType() );
            redirect.setParam("viewType"     , thisForm.getViewType() );
            redirect.setParam("forward"      , thisForm.getForward()      );
            redirect.setParam("status"       , ""+thisForm.getStatus() );
            redirect.setParam("beforerun"    , "updateDay" );
            redirect.setForward(mapping.findForward("schedule")  );
            return redirect;
        }catch(Exception e){
            throw (e);
        }
	}

}